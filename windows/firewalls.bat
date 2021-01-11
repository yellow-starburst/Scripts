@echo off

# Drop all rules
netsh advfirewall reset
netsh advfirewall set allprofiles state on
netsh advfirewall firewall delete rule name=all

# Set default drop
netsh advfirewall set allprofiles firewallpolicy blockinbound,blockoutbound

# Configure logging
netsh advfirewall set allprofiles logging filename C:\Windows\fw.log
netsh advfirewall set allprofiles logging maxfilesize 32676
netsh advfirewall set allprofiles logging droppedconnections enable
netsh advfirewall set allprofiles logging allowedconnections enable

# Loopback
netsh adv f a r n=Loop-Out dir=out act=allow remoteip=127.0.0.1
netsh adv f a r n=Loop-In dir=in act=allow remoteip=127.0.0.1
netsh adv f a r n=Loop-6-Out dir=out act=allow remoteip=::1
netsh adv f a r n=Loop-6-In dir=in act=allow remoteip=::1

# Ping is good. They've never had a ping beacon.
netsh adv f a r n=Ping-Out dir=out act=allow prof=any prot=icmpv4:8,any
netsh adv f a r n=Ping-In dir=in act=allow prof=any prot=icmpv4:8,any

# Lockout prevention - put this at the end if you're logged in remotely
timeout 5
netsh advfirewall reset
