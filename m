From: John Griessen <john@ecosensory.com>
Subject: Re: git-daemon serving repos with repo.git/git-daemon-export-ok
Date: Mon, 03 Jan 2011 17:38:34 -0600
Message-ID: <4D225DFA.50805@ecosensory.com>
References: <S1751603Ab1ACU6e/20110103205834Z+1762@vger.kernel.org> <4D224475.1090805@ecosensory.com> <20110103231153.GA10733@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 04 00:38:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PZtzA-0006zV-42
	for gcvg-git-2@lo.gmane.org; Tue, 04 Jan 2011 00:38:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750947Ab1ACXii (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Jan 2011 18:38:38 -0500
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.123]:42182 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750911Ab1ACXig (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Jan 2011 18:38:36 -0500
X-Authority-Analysis: v=1.1 cv=dquaJDitHqzHCdqWSoZ6IgapSuTzW/4TaRYx9N9k4W8= c=1 sm=0 a=OYK4GqB-rtkA:10 a=8nJEP1OIZ-IA:10 a=hpnIzNeuzKcqG6phuHbX0Q==:17 a=4WL0Wg5FJlEvUpXSZoQA:9 a=1eAEdoxOQ54PdW4KV-oA:7 a=rIHplGfpZdHbo67hKxmCfef4BUEA:4 a=wPNLvfGTeEIA:10 a=5WsZz7uECaOd6WEb:21 a=1dzjSfPlFXxvV2wA:21 a=hpnIzNeuzKcqG6phuHbX0Q==:117
X-Cloudmark-Score: 0
X-Originating-IP: 66.68.104.159
Received: from [66.68.104.159] ([66.68.104.159:34581] helo=[192.168.15.39])
	by hrndva-oedge01.mail.rr.com (envelope-from <john@ecosensory.com>)
	(ecelerity 2.2.3.46 r()) with ESMTP
	id 7D/60-14011-BFD522D4; Mon, 03 Jan 2011 23:38:35 +0000
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.13) Gecko/20101207 Lightning/1.0b2 Thunderbird/3.1.7
In-Reply-To: <20110103231153.GA10733@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164462>

On 01/03/2011 05:11 PM, Jonathan Nieder wrote:
> Hi John,

>
> Worrisome.  Based on /usr/share/doc/git-daemon-run/README.Debian,
> I would be interested in:
>
> 	git --version
server:
vking@mail:/etc/sv$ git --version
git version 1.7.2.3

client:
john@toolbench:~/EEProjects/tek_7k_ext$ git version 1.7.2.3
git version 1.7.2.3

> 	dpkg -l git-daemon-run

dpkg -l git-daemon-run
Desired=Unknown/Install/Remove/Purge/Hold
| Status=Not/Inst/Cfg-files/Unpacked/Failed-cfg/Half-inst/trig-aWait/Trig-pend
|/ Err?=(none)/Hold/Reinst-required/X=both-problems (Status,Err: uppercase=bad)
||/ Name                           Version                        Description
+++-==============================-==============================-============================================================================
pc  git-daemon-run                 1:1.7.2.3-2.2                  fast, scalable, distributed revision contro


> 	sv stat git-daemon
vking@mail:/etc/sv$ sv stat git-daemon
fail: git-daemon: unable to change to service directory: file does not exist

I uninstalled it  so I could run a command line like:

sudo /usr/lib/git-core/git-daemon --verbose --strict-paths --user=git --group=gitosis /srv/gitosis/repositories
or
sudo strace -o strace.out /usr/lib/git-core/git-daemon --verbose --strict-paths --user=git --group=gitosis /srv/gitosis/repositories

I can push to these repos with gitosis, and the permissions are:

vking@mail:/srv/gitosis/repositories$ ll
total 16
drwxr-xr-x 7 gitosis gitosis 4096 Dec 30 12:32 extrudator.data.git
drwxr-xr-x 7 gitosis gitosis 4096 Nov  7 15:23 extrudator.git
drwxr-xr-x 8 gitosis gitosis 4096 Jan  3 14:42 gitosis-admin.git
drwxr-xr-x 7 gitosis gitosis 4096 Jan  2 23:46 tek_7k_ext.git

/etc/group on server
git:x:111:
gitosis:x:115:git

/etc/passwd on server
git:x:106:111:git version control,,,:/home/git:/bin/shh
gitlog:x:108:65534::/nonexistent:/bin/false
gitosis:x:110:115:git repository hosting,,,:/srv/gitosis:/bin/sh


> 	cat /var/log/git-daemon/current

john@toolbench:~/EEProjects/tek_7k_ext$ cat /var/log/git-daemon/current
cat: /var/log/git-daemon/current: No such file or directory


Thanks for looking at this.

John Griessen

===================================strace output================
vking@mail:/etc/sv$ cat strace.out
execve("/usr/lib/git-core/git-daemon", ["/usr/lib/git-core/git-daemon", "--verbose", "--strict-paths", "--user=git", 
"--group=gitosis", "/srv/gitosis/repositories"], [/* 10 vars */]) = 0
brk(0)                                  = 0x89c1000
uname({sys="Linux", node="mail.cibolo.us", ...}) = 0
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or directory)
mmap2(NULL, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb7f19000
access("/etc/ld.so.preload", R_OK)      = -1 ENOENT (No such file or directory)
open("/etc/ld.so.cache", O_RDONLY)      = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=22893, ...}) = 0
mmap2(NULL, 22893, PROT_READ, MAP_PRIVATE, 3, 0) = 0xb7f13000
close(3)                                = 0
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or directory)
open("/usr/lib/libz.so.1", O_RDONLY)    = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\300\30\0\0004\0\0\0"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0644, st_size=81012, ...}) = 0
mmap2(NULL, 83740, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0x62c000
mmap2(0x640000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x13) = 0x640000
close(3)                                = 0
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or directory)
open("/lib/libpthread.so.0", O_RDONLY)  = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0`I\0\0004\0\0\0"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=117105, ...}) = 0
mmap2(NULL, 98784, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xbbf000
mprotect(0xbd3000, 4096, PROT_NONE)     = 0
mmap2(0xbd4000, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x14) = 0xbd4000
mmap2(0xbd6000, 4576, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0xbd6000
close(3)                                = 0
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or directory)
open("/lib/libc.so.6", O_RDONLY)        = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\320m\1\0004\0\0\0"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=1315080, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb7f12000
mmap2(NULL, 1325384, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0x110000
mmap2(0x24e000, 12288, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x13d) = 0x24e000
mmap2(0x251000, 10568, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x251000
close(3)                                = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb7f11000
set_thread_area({entry_number:-1 -> 6, base_addr:0xb7f116c0, limit:1048575, seg_32bit:1, contents:0, read_exec_only:0, 
limit_in_pages:1, seg_not_present:0, useable:1}) = 0
open("/dev/urandom", O_RDONLY)          = 3
read(3, "\367\3Y", 3)                   = 3
close(3)                                = 0
mprotect(0x24e000, 8192, PROT_READ)     = 0
mprotect(0xbd4000, 4096, PROT_READ)     = 0
mprotect(0x855000, 4096, PROT_READ)     = 0
munmap(0xb7f13000, 22893)               = 0
set_tid_address(0xb7f11728)             = 19676
set_robust_list(0xb7f11730, 0xc)        = 0
futex(0xbf8e5370, FUTEX_WAKE_PRIVATE, 1) = 0
futex(0xbf8e5370, FUTEX_WAIT_BITSET_PRIVATE|FUTEX_CLOCK_REALTIME, 1, NULL, bf8e5380) = -1 ENOSYS (Function not implemented)
rt_sigaction(SIGRTMIN, {0xbc33b0, [], SA_RESTORER|SA_SIGINFO, 0xbcce60}, NULL, 8) = 0
rt_sigaction(SIGRT_1, {0xbc3840, [], SA_RESTORER|SA_RESTART|SA_SIGINFO, 0xbcce60}, NULL, 8) = 0
rt_sigprocmask(SIG_UNBLOCK, [RTMIN RT_1], NULL, 8) = 0
getrlimit(RLIMIT_STACK, {rlim_cur=8192*1024, rlim_max=RLIM_INFINITY}) = 0
uname({sys="Linux", node="mail.cibolo.us", ...}) = 0
brk(0)                                  = 0x89c1000
brk(0x89e2000)                          = 0x89e2000
socket(PF_FILE, SOCK_STREAM|SOCK_CLOEXEC|SOCK_NONBLOCK, 0) = 3
connect(3, {sa_family=AF_FILE, path="/var/run/nscd/socket"}, 110) = -1 ENOENT (No such file or directory)
close(3)                                = 0
socket(PF_FILE, SOCK_STREAM|SOCK_CLOEXEC|SOCK_NONBLOCK, 0) = 3
connect(3, {sa_family=AF_FILE, path="/var/run/nscd/socket"}, 110) = -1 ENOENT (No such file or directory)
close(3)                                = 0
open("/etc/nsswitch.conf", O_RDONLY)    = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=465, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb7f18000
read(3, "# /etc/nsswitch.conf\n#\n# Example"..., 4096) = 465
read(3, "", 4096)                       = 0
close(3)                                = 0
munmap(0xb7f18000, 4096)                = 0
open("/etc/ld.so.cache", O_RDONLY)      = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=22893, ...}) = 0
mmap2(NULL, 22893, PROT_READ, MAP_PRIVATE, 3, 0) = 0xb7f13000
close(3)                                = 0
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or directory)
open("/lib/libnss_compat.so.2", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0000\16\0\0004\0\0\0"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0644, st_size=30496, ...}) = 0
mmap2(NULL, 29268, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0x254000
mmap2(0x25a000, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x6) = 0x25a000
close(3)                                = 0
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or directory)
open("/lib/libnsl.so.1", O_RDONLY)      = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\2201\0\0004\0\0\0"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0644, st_size=79676, ...}) = 0
mmap2(NULL, 92136, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xb75000
mmap2(0xb88000, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x12) = 0xb88000
mmap2(0xb8a000, 6120, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0xb8a000
close(3)                                = 0
mprotect(0xb88000, 4096, PROT_READ)     = 0
mprotect(0x25a000, 4096, PROT_READ)     = 0
munmap(0xb7f13000, 22893)               = 0
open("/etc/ld.so.cache", O_RDONLY)      = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=22893, ...}) = 0
mmap2(NULL, 22893, PROT_READ, MAP_PRIVATE, 3, 0) = 0xb7f13000
close(3)                                = 0
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or directory)
open("/lib/libnss_nis.so.2", O_RDONLY)  = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0000\31\0\0004\0\0\0"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0644, st_size=38504, ...}) = 0
mmap2(NULL, 37432, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0x75f000
mmap2(0x767000, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x8) = 0x767000
close(3)                                = 0
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or directory)
open("/lib/libnss_files.so.2", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0 \32\0\0004\0\0\0"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0644, st_size=42572, ...}) = 0
mmap2(NULL, 45772, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0x284000
mmap2(0x28e000, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x9) = 0x28e000
close(3)                                = 0
mprotect(0x28e000, 4096, PROT_READ)     = 0
mprotect(0x767000, 4096, PROT_READ)     = 0
munmap(0xb7f13000, 22893)               = 0
open("/etc/passwd", O_RDONLY|O_CLOEXEC) = 3
fcntl64(3, F_GETFD)                     = 0x1 (flags FD_CLOEXEC)
_llseek(3, 0, [0], SEEK_CUR)            = 0
fstat64(3, {st_mode=S_IFREG|0644, st_size=1804, ...}) = 0
mmap2(NULL, 1804, PROT_READ, MAP_SHARED, 3, 0) = 0xb7f18000
_llseek(3, 1804, [1804], SEEK_SET)      = 0
munmap(0xb7f18000, 1804)                = 0
close(3)                                = 0
socket(PF_FILE, SOCK_STREAM|SOCK_CLOEXEC|SOCK_NONBLOCK, 0) = 3
connect(3, {sa_family=AF_FILE, path="/var/run/nscd/socket"}, 110) = -1 ENOENT (No such file or directory)
close(3)                                = 0
socket(PF_FILE, SOCK_STREAM|SOCK_CLOEXEC|SOCK_NONBLOCK, 0) = 3
connect(3, {sa_family=AF_FILE, path="/var/run/nscd/socket"}, 110) = -1 ENOENT (No such file or directory)
close(3)                                = 0
open("/etc/group", O_RDONLY|O_CLOEXEC)  = 3
_llseek(3, 0, [0], SEEK_CUR)            = 0
fstat64(3, {st_mode=S_IFREG|0644, st_size=836, ...}) = 0
mmap2(NULL, 836, PROT_READ, MAP_SHARED, 3, 0) = 0xb7f18000
_llseek(3, 836, [836], SEEK_SET)        = 0
munmap(0xb7f18000, 836)                 = 0
close(3)                                = 0
open("/dev/null", O_RDWR|O_LARGEFILE)   = 3
close(3)                                = 0
socket(PF_NETLINK, SOCK_RAW, 0)         = 3
bind(3, {sa_family=AF_NETLINK, pid=0, groups=00000000}, 12) = 0
getsockname(3, {sa_family=AF_NETLINK, pid=19676, groups=00000000}, [12]) = 0
time(NULL)                              = 1294097104
sendto(3, "\24\0\0\0\26\0\1\3\320Z\"M\0\0\0\0\0\0\0\0", 20, 0, {sa_family=AF_NETLINK, pid=0, groups=00000000}, 12) = 20
recvmsg(3, {msg_name(12)={sa_family=AF_NETLINK, pid=0, groups=00000000}, 
msg_iov(1)=[{"<\0\0\0\24\0\2\0\320Z\"M\334L\0\0\2\10\200\376\1\0\0\0\10\0\1\0\177\0\0\1"..., 4096}], msg_controllen=0, 
msg_flags=0}, 0) = 240
recvmsg(3, {msg_name(12)={sa_family=AF_NETLINK, pid=0, groups=00000000}, 
msg_iov(1)=[{"@\0\0\0\24\0\2\0\320Z\"M\334L\0\0\n\200\200\376\1\0\0\0\24\0\1\0\0\0\0\0"..., 4096}], msg_controllen=0, 
msg_flags=0}, 0) = 64
recvmsg(3, {msg_name(12)={sa_family=AF_NETLINK, pid=0, groups=00000000}, 
msg_iov(1)=[{"\24\0\0\0\3\0\2\0\320Z\"M\334L\0\0\0\0\0\0\1\0\0\0\24\0\1\0\0\0\0\0"..., 4096}], msg_controllen=0, msg_flags=0}, 0) = 20
close(3)                                = 0
open("/etc/gai.conf", O_RDONLY)         = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=2940, ...}) = 0
fstat64(3, {st_mode=S_IFREG|0644, st_size=2940, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb7f18000
read(3, "# Configuration for getaddrinfo("..., 4096) = 2940
read(3, "", 4096)                       = 0
close(3)                                = 0
munmap(0xb7f18000, 4096)                = 0
futex(0x251cd0, FUTEX_WAKE_PRIVATE, 2147483647) = 0
socket(PF_INET6, SOCK_DGRAM, IPPROTO_IP) = 3
connect(3, {sa_family=AF_INET6, sin6_port=htons(9418), inet_pton(AF_INET6, "::", &sin6_addr), sin6_flowinfo=0, sin6_scope_id=0}, 
28) = 0
getsockname(3, {sa_family=AF_INET6, sin6_port=htons(47484), inet_pton(AF_INET6, "::1", &sin6_addr), sin6_flowinfo=0, 
sin6_scope_id=0}, [28]) = 0
connect(3, {sa_family=AF_UNSPEC, sa_data="\0\0\0\0\0\0\0\0\0\0\0\0\0\0"}, 16) = 0
connect(3, {sa_family=AF_INET, sin_port=htons(9418), sin_addr=inet_addr("0.0.0.0")}, 16) = 0
getsockname(3, {sa_family=AF_INET6, sin6_port=htons(48606), inet_pton(AF_INET6, "::ffff:127.0.0.1", &sin6_addr), sin6_flowinfo=0, 
sin6_scope_id=0}, [28]) = 0
close(3)                                = 0
socket(PF_INET, SOCK_STREAM, IPPROTO_TCP) = 3
bind(3, {sa_family=AF_INET, sin_port=htons(9418), sin_addr=inet_addr("0.0.0.0")}, 16) = -1 EADDRINUSE (Address already in use)
close(3)                                = 0
socket(PF_INET6, SOCK_STREAM, IPPROTO_TCP) = 3
setsockopt(3, SOL_IPV6, IPV6_V6ONLY, [1], 4) = 0
bind(3, {sa_family=AF_INET6, sin6_port=htons(9418), inet_pton(AF_INET6, "::", &sin6_addr), sin6_flowinfo=0, sin6_scope_id=0}, 28) = 0
listen(3, 5)                            = 0
fcntl64(3, F_GETFD)                     = 0
fcntl64(3, F_SETFD, FD_CLOEXEC)         = 0
open("/proc/sys/kernel/ngroups_max", O_RDONLY) = 4
read(4, "65536\n", 31)                  = 6
close(4)                                = 0
open("/etc/group", O_RDONLY|O_CLOEXEC)  = 4
_llseek(4, 0, [0], SEEK_CUR)            = 0
fstat64(4, {st_mode=S_IFREG|0644, st_size=836, ...}) = 0
mmap2(NULL, 836, PROT_READ, MAP_SHARED, 4, 0) = 0xb7f18000
_llseek(4, 836, [836], SEEK_SET)        = 0
fstat64(4, {st_mode=S_IFREG|0644, st_size=836, ...}) = 0
munmap(0xb7f18000, 836)                 = 0
close(4)                                = 0
setgroups32(1, [115])                   = 0
setgid32(115)                           = 0
setuid32(106)                           = 0
rt_sigaction(SIGCHLD, {0x804ae30, [CHLD], SA_RESTORER|SA_RESTART, 0x13a5d8}, {SIG_DFL, [], 0}, 8) = 0
waitpid(-1, 0xbf8e525c, WNOHANG)        = -1 ECHILD (No child processes)
poll([{fd=3, events=POLLIN}], 1, -1)    = -1 EINTR (Interrupted system call)
--- SIGINT (Interrupt) @ 0 (0) ---
+++ killed by SIGINT +++
vking@mail:/etc/sv$
=========================================================



JG
