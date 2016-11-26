Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 739E5203EC
	for <e@80x24.org>; Sat, 26 Nov 2016 14:03:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751453AbcKZODx (ORCPT <rfc822;e@80x24.org>);
        Sat, 26 Nov 2016 09:03:53 -0500
Received: from mail-io0-f176.google.com ([209.85.223.176]:33199 "EHLO
        mail-io0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751218AbcKZODv (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 Nov 2016 09:03:51 -0500
Received: by mail-io0-f176.google.com with SMTP id j65so163641271iof.0
        for <git@vger.kernel.org>; Sat, 26 Nov 2016 06:03:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:subject:from:to:cc:date:mime-version
         :content-transfer-encoding;
        bh=0401XToJdlK5mFSOS7IOodGIvr2OFT3RSkHHAldRBq4=;
        b=IAHLFBlz7msGGo+oiZPC2Tugw8SGI6p+h2a8PB/EwXVTuJzxwYLX2xdTZmIFMiphpb
         cj7XKASeOa4K2Qw3dtuXdokN4mQIQUcIZwtszi+Wrlrlicnd4FxUt5O5j0Ypi+FHVl97
         2xu6vyoKa0FwYRSXb5BaTBY3d1fmZkmGSzcpbG9MtcBN8HRgQF/ec19bshKT1dNDwzc5
         O6DL09m6OVhAgBUq8j8Dm4emqiZTwFIMk3uDNQCh9fO7SZqbOdpPmks6LFD6lhzt53xQ
         TFX0bvwUzXq30Uhwsa78FL2mdTUMEHRgD1cOosJhO5QL3/Z40frRpuo8W9X0Lvu2NtIy
         dCVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:mime-version
         :content-transfer-encoding;
        bh=0401XToJdlK5mFSOS7IOodGIvr2OFT3RSkHHAldRBq4=;
        b=lf/m3J8IYxqV6a+kfCVBIyoheiRZw94zA436ZCqGChifd+ufWQ1zoVj17kxxYsIlg0
         12mRy/riKTAJSRYD18frjI4zqMoegiU1qZl6kyuvWpuEx3Usm8ut1yP7z23vPo6vWg7z
         I/03KpoJwJymsyFAHIIQ2GlavC/qh2tgG69bARXyek14oDkcex8RAS5628rG/8RGd8u5
         IpVZTVZh5g0JhPM7SexFsTHPDqahfELyrQua4Kwgtke5zUEkUKQUeadvh3USGq8T1kJ6
         yzoqHK/C63NcjdeN/XJ8rxW5BvNxe02BRRlnQcnvMMAAhjsFvlULupEWlOZ8ZvGXCOy3
         3rXg==
X-Gm-Message-State: AKaTC033ErZ3sEnLhsJZ/ZuHnRlKCS4VPkZqUcQ5vygUrP2FV/mUYJs3PmelRcT4kzZWTA==
X-Received: by 10.36.73.90 with SMTP id z87mr10960654ita.109.1480169030730;
        Sat, 26 Nov 2016 06:03:50 -0800 (PST)
Received: from maggy.simpson.net (50-80-55-235.client.mchsi.com. [50.80.55.235])
        by smtp.googlemail.com with ESMTPSA id o13sm6040201itb.18.2016.11.26.06.03.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 26 Nov 2016 06:03:49 -0800 (PST)
Message-ID: <1480169028.3830.24.camel@gmail.com>
Subject: git-daemon regression: 650c449250d7 common-main: call
 git_extract_argv0_path()
From:   Mike Galbraith <umgwanakikbuti@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Date:   Sat, 26 Nov 2016 15:03:48 +0100
Content-Type: text/plain; charset="us-ascii"
X-Mailer: Evolution 3.16.5 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Greetings,

git-daemon went broke on me post v2.9.3 due to binaries being installed
in /usr/lib/git, which is not in PATH.  Reverting 650c449250d7 fixes it
up, as does ln -s /usr/lib/git/git-daemon /usr/bin/git-daemon 'course,
but thought I should report it, since it used to work without that.

Process 18804 attached
restart_syscall(<... resuming interrupted call ...>) = 1
accept(4, {sa_family=AF_INET6, sin6_port=htons(44400), inet_pton(AF_INET6, "::1", &sin6_addr), sin6_flowinfo=0, sin6_scope_id=0}, [28]) = 5
dup(5)                                  = 6
pipe([7, 8])                            = 0
clone(Process 18830 attached
child_stack=0, flags=CLONE_CHILD_CLEARTID|CLONE_CHILD_SETTID|SIGCHLD, child_tidptr=0x7f0e6061c9d0) = 18830
[pid 18830] set_robust_list(0x7f0e6061c9e0, 24 <unfinished ...>
[pid 18804] close(8 <unfinished ...>
[pid 18830] <... set_robust_list resumed> ) = 0
[pid 18804] <... close resumed> )       = 0
[pid 18804] read(7,  <unfinished ...>
[pid 18830] close(7)                    = 0
[pid 18830] fcntl(8, F_GETFD)           = 0
[pid 18830] fcntl(8, F_SETFD, FD_CLOEXEC) = 0
[pid 18830] dup2(5, 0)                  = 0
[pid 18830] close(5)                    = 0
[pid 18830] dup2(6, 1)                  = 1
[pid 18830] close(6)                    = 0
[pid 18830] execve("/usr/local/sbin/git-daemon", ["git-daemon", "--serve", "--syslog", "--detach", "--reuseaddr", "--user=git", "--group=daemon", "--pid-file=/var/run/git-daemon.p"..., "--export-all", "--user-path"], ["CONSOLE=/dev/console", "LC_ALL=POSIX", "REDIRECT=/dev/tty7", "COLUMNS=320", "PATH=/usr/local/sbin:/usr/local/"..., "PWD=/", "LINES=90", "SHLVL=1", "LC_CTYPE=en_US.UTF-8", "_=/sbin/startproc", "PREVLEVEL=", "RUNLEVEL=5", "DAEMON=/usr/lib/git/git-daemon", "REMOTE_ADDR=[::1]", "REMOTE_PORT=44400"]) = -1 ENOENT (No such file or directory)
[pid 18830] execve("/usr/local/bin/git-daemon", ["git-daemon", "--serve", "--syslog", "--detach", "--reuseaddr", "--user=git", "--group=daemon", "--pid-file=/var/run/git-daemon.p"..., "--export-all", "--user-path"], ["CONSOLE=/dev/console", "LC_ALL=POSIX", "REDIRECT=/dev/tty7", "COLUMNS=320", "PATH=/usr/local/sbin:/usr/local/"..., "PWD=/", "LINES=90", "SHLVL=1", "LC_CTYPE=en_US.UTF-8", "_=/sbin/startproc", "PREVLEVEL=", "RUNLEVEL=5", "DAEMON=/usr/lib/git/git-daemon", "REMOTE_ADDR=[::1]", "REMOTE_PORT=44400"]) = -1 ENOENT (No such file or directory)
[pid 18830] execve("/usr/sbin/git-daemon", ["git-daemon", "--serve", "--syslog", "--detach", "--reuseaddr", "--user=git", "--group=daemon", "--pid-file=/var/run/git-daemon.p"..., "--export-all", "--user-path"], ["CONSOLE=/dev/console", "LC_ALL=POSIX", "REDIRECT=/dev/tty7", "COLUMNS=320", "PATH=/usr/local/sbin:/usr/local/"..., "PWD=/", "LINES=90", "SHLVL=1", "LC_CTYPE=en_US.UTF-8", "_=/sbin/startproc", "PREVLEVEL=", "RUNLEVEL=5", "DAEMON=/usr/lib/git/git-daemon", "REMOTE_ADDR=[::1]", "REMOTE_PORT=44400"]) = -1 ENOENT (No such file or directory)
[pid 18830] execve("/usr/bin/git-daemon", ["git-daemon", "--serve", "--syslog", "--detach", "--reuseaddr", "--user=git", "--group=daemon", "--pid-file=/var/run/git-daemon.p"..., "--export-all", "--user-path"], ["CONSOLE=/dev/console", "LC_ALL=POSIX", "REDIRECT=/dev/tty7", "COLUMNS=320", "PATH=/usr/local/sbin:/usr/local/"..., "PWD=/", "LINES=90", "SHLVL=1", "LC_CTYPE=en_US.UTF-8", "_=/sbin/startproc", "PREVLEVEL=", "RUNLEVEL=5", "DAEMON=/usr/lib/git/git-daemon", "REMOTE_ADDR=[::1]", "REMOTE_PORT=44400"]) = -1 ENOENT (No such file or directory)
[pid 18830] execve("/sbin/git-daemon", ["git-daemon", "--serve", "--syslog", "--detach", "--reuseaddr", "--user=git", "--group=daemon", "--pid-file=/var/run/git-daemon.p"..., "--export-all", "--user-path"], ["CONSOLE=/dev/console", "LC_ALL=POSIX", "REDIRECT=/dev/tty7", "COLUMNS=320", "PATH=/usr/local/sbin:/usr/local/"..., "PWD=/", "LINES=90", "SHLVL=1", "LC_CTYPE=en_US.UTF-8", "_=/sbin/startproc", "PREVLEVEL=", "RUNLEVEL=5", "DAEMON=/usr/lib/git/git-daemon", "REMOTE_ADDR=[::1]", "REMOTE_PORT=44400"]) = -1 ENOENT (No such file or directory)
[pid 18830] execve("/bin/git-daemon", ["git-daemon", "--serve", "--syslog", "--detach", "--reuseaddr", "--user=git", "--group=daemon", "--pid-file=/var/run/git-daemon.p"..., "--export-all", "--user-path"], ["CONSOLE=/dev/console", "LC_ALL=POSIX", "REDIRECT=/dev/tty7", "COLUMNS=320", "PATH=/usr/local/sbin:/usr/local/"..., "PWD=/", "LINES=90", "SHLVL=1", "LC_CTYPE=en_US.UTF-8", "_=/sbin/startproc", "PREVLEVEL=", "RUNLEVEL=5", "DAEMON=/usr/lib/git/git-daemon", "REMOTE_ADDR=[::1]", "REMOTE_PORT=44400"]) = -1 ENOENT (No such file or directory)
[pid 18830] fstat(2, {st_dev=makedev(0, 6), st_ino=1029, st_mode=S_IFCHR|0666, st_nlink=1, st_uid=0, st_gid=0, st_blksize=4096, st_blocks=0, st_rdev=makedev(1, 3), st_atime=2016/11/26-00:42:47, st_mtime=2016/11/26-00:42:47, st_ctime=2016/11/26-00:42:47}) = 0
[pid 18830] ioctl(2, TCGETS, 0x7ffe6dbd09b0) = -1 ENOTTY (Inappropriate ioctl for device)
[pid 18830] mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x7f0e60632000
[pid 18830] write(2, "error: cannot run git-daemon: No"..., 56) = 56
[pid 18830] write(8, "\0", 1)           = 1
[pid 18804] <... read resumed> "\0", 1) = 1
[pid 18830] exit_group(127)             = ?
[pid 18804] wait4(18830,  <unfinished ...>
[pid 18830] +++ exited with 127 +++
<... wait4 resumed> [{WIFEXITED(s) && WEXITSTATUS(s) == 127}], 0, NULL) = 18830
--- SIGCHLD {si_signo=SIGCHLD, si_code=CLD_EXITED, si_pid=18830, si_uid=1002, si_status=127, si_utime=0, si_stime=0} ---
rt_sigaction(SIGCHLD, {0x404e10, [CHLD], SA_RESTORER|SA_RESTART, 0x7f0e5f6a7140}, {0x404e10, [CHLD], SA_RESTORER|SA_RESTART, 0x7f0e5f6a7140}, 8) = 0
rt_sigreturn({mask=[]})                 = 18830
close(7)                                = 0
close(5)                                = 0
close(6)                                = 0
open("/etc/localtime", O_RDONLY|O_CLOEXEC) = 5
fstat(5, {st_dev=makedev(8, 5), st_ino=6031966, st_mode=S_IFREG|0644, st_nlink=2, st_uid=0, st_gid=0, st_blksize=4096, st_blocks=8, st_size=2335, st_atime=2016/11/26-01:00:02, st_mtime=2016/11/08-18:09:53, st_ctime=2016/11/09-21:15:24}) = 0
fstat(5, {st_dev=makedev(8, 5), st_ino=6031966, st_mode=S_IFREG|0644, st_nlink=2, st_uid=0, st_gid=0, st_blksize=4096, st_blocks=8, st_size=2335, st_atime=2016/11/26-01:00:02, st_mtime=2016/11/08-18:09:53, st_ctime=2016/11/09-21:15:24}) = 0
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x7f0e60632000
read(5, "TZif2\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t\0\0\0\t\0\0\0\0"..., 4096) = 2335
lseek(5, -1476, SEEK_CUR)               = 859
read(5, "TZif2\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t\0\0\0\t\0\0\0\0"..., 4096) = 1476
close(5)                                = 0
munmap(0x7f0e60632000, 4096)            = 0
socket(PF_LOCAL, SOCK_DGRAM|SOCK_CLOEXEC, 0) = 5
connect(5, {sa_family=AF_LOCAL, sun_path="/dev/log"}, 110) = 0
sendto(5, "<27>Nov 26 14:25:55 git-daemon[1"..., 53, MSG_NOSIGNAL, NULL, 0) = 53
poll([{fd=3, events=POLLIN}, {fd=4, events=POLLIN}], 2, 4294967295

revert 650c449250d7

Process 18934 attached
restart_syscall(<... resuming interrupted call ...>) = 1
accept(4, {sa_family=AF_INET6, sin6_port=htons(44404), inet_pton(AF_INET6, "::1", &sin6_addr), sin6_flowinfo=0, sin6_scope_id=0}, [28]) = 5
dup(5)                                  = 6
pipe([7, 8])                            = 0
clone(Process 19010 attached
child_stack=0, flags=CLONE_CHILD_CLEARTID|CLONE_CHILD_SETTID|SIGCHLD, child_tidptr=0x7f62fcb5e9d0) = 19010
[pid 18934] close(8 <unfinished ...>
[pid 19010] set_robust_list(0x7f62fcb5e9e0, 24) = 0
[pid 18934] <... close resumed> )       = 0
[pid 18934] read(7,  <unfinished ...>
[pid 19010] close(7)                    = 0
[pid 19010] fcntl(8, F_GETFD)           = 0
[pid 19010] fcntl(8, F_SETFD, FD_CLOEXEC) = 0
[pid 19010] dup2(5, 0)                  = 0
[pid 19010] close(5)                    = 0
[pid 19010] dup2(6, 1)                  = 1
[pid 19010] close(6)                    = 0
[pid 19010] execve("/usr/lib/git/git-daemon", ["/usr/lib/git/git-daemon", "--serve", "--syslog", "--detach", "--reuseaddr", "--user=git", "--group=daemon", "--pid-file=/var/run/git-daemon.p"..., "--export-all", "--user-path"], ["CONSOLE=/dev/console", "LC_ALL=POSIX", "REDIRECT=/dev/tty7", "COLUMNS=320", "PATH=/usr/local/sbin:/usr/local/"..., "PWD=/", "LINES=90", "SHLVL=1", "LC_CTYPE=en_US.UTF-8", "_=/sbin/startproc", "PREVLEVEL=", "RUNLEVEL=5", "DAEMON=/usr/lib/git/git-daemon", "REMOTE_ADDR=[::1]", "REMOTE_PORT=44404"] <unfinished ...>
[pid 18934] <... read resumed> "", 1)   = 0
[pid 19010] <... execve resumed> )      = 0
.... works


ln -s /usr/lib/git/git-daemon /usr/bin/git-daemon


Process 19862 attached
restart_syscall(<... resuming interrupted call ...>) = 1
accept(4, {sa_family=AF_INET6, sin6_port=htons(44412), inet_pton(AF_INET6, "::1", &sin6_addr), sin6_flowinfo=0, sin6_scope_id=0}, [28]) = 5
dup(5)                                  = 6
pipe([7, 8])                            = 0
clone(Process 19915 attached
child_stack=0, flags=CLONE_CHILD_CLEARTID|CLONE_CHILD_SETTID|SIGCHLD, child_tidptr=0x7fc97962e9d0) = 19915
[pid 19862] close(8)                    = 0
[pid 19915] set_robust_list(0x7fc97962e9e0, 24 <unfinished ...>
[pid 19862] read(7,  <unfinished ...>
[pid 19915] <... set_robust_list resumed> ) = 0
[pid 19915] close(7)                    = 0
[pid 19915] fcntl(8, F_GETFD)           = 0
[pid 19915] fcntl(8, F_SETFD, FD_CLOEXEC) = 0
[pid 19915] dup2(5, 0)                  = 0
[pid 19915] close(5)                    = 0
[pid 19915] dup2(6, 1)                  = 1
[pid 19915] close(6)                    = 0
[pid 19915] execve("/usr/local/sbin/git-daemon", ["git-daemon", "--serve", "--syslog", "--detach", "--reuseaddr", "--user=git", "--group=daemon", "--pid-file=/var/run/git-daemon.p"..., "--export-all", "--user-path"], ["CONSOLE=/dev/console", "LC_ALL=POSIX", "REDIRECT=/dev/tty7", "COLUMNS=320", "PATH=/usr/local/sbin:/usr/local/"..., "PWD=/", "LINES=90", "SHLVL=1", "LC_CTYPE=en_US.UTF-8", "_=/sbin/startproc", "PREVLEVEL=", "RUNLEVEL=5", "DAEMON=/usr/lib/git/git-daemon", "REMOTE_ADDR=[::1]", "REMOTE_PORT=44412"]) = -1 ENOENT (No such file or directory)
[pid 19915] execve("/usr/local/bin/git-daemon", ["git-daemon", "--serve", "--syslog", "--detach", "--reuseaddr", "--user=git", "--group=daemon", "--pid-file=/var/run/git-daemon.p"..., "--export-all", "--user-path"], ["CONSOLE=/dev/console", "LC_ALL=POSIX", "REDIRECT=/dev/tty7", "COLUMNS=320", "PATH=/usr/local/sbin:/usr/local/"..., "PWD=/", "LINES=90", "SHLVL=1", "LC_CTYPE=en_US.UTF-8", "_=/sbin/startproc", "PREVLEVEL=", "RUNLEVEL=5", "DAEMON=/usr/lib/git/git-daemon", "REMOTE_ADDR=[::1]", "REMOTE_PORT=44412"]) = -1 ENOENT (No such file or directory)
[pid 19915] execve("/usr/sbin/git-daemon", ["git-daemon", "--serve", "--syslog", "--detach", "--reuseaddr", "--user=git", "--group=daemon", "--pid-file=/var/run/git-daemon.p"..., "--export-all", "--user-path"], ["CONSOLE=/dev/console", "LC_ALL=POSIX", "REDIRECT=/dev/tty7", "COLUMNS=320", "PATH=/usr/local/sbin:/usr/local/"..., "PWD=/", "LINES=90", "SHLVL=1", "LC_CTYPE=en_US.UTF-8", "_=/sbin/startproc", "PREVLEVEL=", "RUNLEVEL=5", "DAEMON=/usr/lib/git/git-daemon", "REMOTE_ADDR=[::1]", "REMOTE_PORT=44412"]) = -1 ENOENT (No such file or directory)
[pid 19915] execve("/usr/bin/git-daemon", ["git-daemon", "--serve", "--syslog", "--detach", "--reuseaddr", "--user=git", "--group=daemon", "--pid-file=/var/run/git-daemon.p"..., "--export-all", "--user-path"], ["CONSOLE=/dev/console", "LC_ALL=POSIX", "REDIRECT=/dev/tty7", "COLUMNS=320", "PATH=/usr/local/sbin:/usr/local/"..., "PWD=/", "LINES=90", "SHLVL=1", "LC_CTYPE=en_US.UTF-8", "_=/sbin/startproc", "PREVLEVEL=", "RUNLEVEL=5", "DAEMON=/usr/lib/git/git-daemon", "REMOTE_ADDR=[::1]", "REMOTE_PORT=44412"] <unfinished ...>
[pid 19862] <... read resumed> "", 1)   = 0
[pid 19915] <... execve resumed> )      = 0
.... works


