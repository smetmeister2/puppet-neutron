require 'spec_helper'

describe 'neutron::db::postgresql' do
  shared_examples 'neutron::db::postgresql' do
    let :req_params do
      { :password => 'pw' }
    end

    let :pre_condition do
      'include postgresql::server'
    end

    context 'with only required parameters' do
      let :params do
        req_params
      end

      it { should contain_postgresql__server__db('neutron').with(
        :user     => 'neutron',
        :password => 'md5696acd1dd66513a556a18a1beccd03d1'
      )}
    end

  end

  on_supported_os({
    :supported_os   => OSDefaults.get_supported_os
  }).each do |os,facts|
    context "on #{os}" do
      let (:facts) do
        facts.merge(OSDefaults.get_facts({
          :processorcount => 8,
          :concat_basedir => '/var/lib/puppet/concat'
        }))
      end

      it_behaves_like 'neutron::db::postgresql'
    end
  end
end
