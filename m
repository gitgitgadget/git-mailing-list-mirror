From: Brady Catherman <brady@catherman.org>
Subject: git clone over smart-http hanging for just one repo.
Date: Sun, 21 Mar 2010 23:52:43 -0700
Message-ID: <51569EE6-A926-45DB-A588-B659750BA643@catherman.org>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Mar 22 08:14:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NtbqV-0001Es-DD
	for gcvg-git-2@lo.gmane.org; Mon, 22 Mar 2010 08:14:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754170Ab0CVHOj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Mar 2010 03:14:39 -0400
Received: from rattlesnake.gecka.us ([69.162.118.237]:36341 "EHLO
	rattlesnake.gecka.us" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753483Ab0CVHOi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Mar 2010 03:14:38 -0400
X-Greylist: delayed 1311 seconds by postgrey-1.27 at vger.kernel.org; Mon, 22 Mar 2010 03:14:38 EDT
Received: from 173-11-123-97-sfba.hfc.comcastbusiness.net ([173.11.123.97] helo=173-11-123-99-sfba.hfc.comcastbusiness.net)
	by rattlesnake.gecka.us with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <gecka@gecka.us>)
	id 1NtbVF-0004gL-1a
	for git@vger.kernel.org; Mon, 22 Mar 2010 09:52:46 +0300
Received: from [192.168.1.6] (helo=viper.gecka.us)
	by 173-11-123-99-sfba.hfc.comcastbusiness.net with esmtpsa (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.69)
	(envelope-from <gecka@gecka.us>)
	id 1NtbVD-0001Kh-W4
	for git@vger.kernel.org; Sun, 21 Mar 2010 23:52:44 -0700
X-Mailer: Apple Mail (2.936)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142903>

I have a git repo that fails to clone or fetch over smart-http, but  
works great over dav. I am wondering if somebody can help me debug the  
issue since I am at a loss why this is happening.

Just for clarification, I have several dozen repos in a directory,  
almost all others work without issue, but one of them is messed up.  
Replacing it with a different repo works so the error has to be  
somewhere in the git files themselves. Cloning the repo via DAV works  
and git fsck reports no problems with the repo.

This is all on git 1.7.0.1 on a Linux machine.

The interesting parts of a strace of git-http-backend following a git  
clone follow:

12037 execve("/usr/libexec/git-core/git-http-backend.real", ["/usr/ 
libexec/git-core/git-http-backend.real"], [/* 33 vars */]) = 0
... various library loads and such ...
12037 access("/usr/local/git/gitrepo", F_OK) = 0
12037 chdir("/usr/local/git/gitrepo")  = 0
12037 access("objects", X_OK)           = 0
12037 access("refs", X_OK)              = 0
12037 lstat("HEAD", {st_mode=S_IFREG|0644, st_size=23, ...}) = 0
12037 open("HEAD", O_RDONLY)            = 3
12037 read(3, "ref: refs/heads/master\n", 255) = 23
12037 access("/usr/local/etc/gitconfig", R_OK) = -1 ENOENT (No such  
file or directory)
12037 access("./config", R_OK)          = 0
12037 open("./config", O_RDONLY)        = 3
12037 read(3, "[core]\n\trepositoryformatversion = 0\n\tfilemode = true 
\n\tbare = true\n\tlogallrefupdates = true\n\tsharedRepository = true 
\n", 4096) = 116
12037 read(3, "", 4096)                 = 0
12037 close(3)                          = 0
12037 munmap(0x2aaaaaaac000, 4096)      = 0
12037 write(1, "Expires: Fri, 01 Jan 1980 00:00:00 GMT\r\n", 40) = 40
12037 write(1, "Pragma: no-cache\r\n", 18) = 18
12037 write(1, "Cache-Control: no-cache, max-age=0, must-revalidate\r 
\n", 53) = 53
12037 write(1, "Content-Type: application/x-git-upload-pack-result\r 
\n", 52) = 52
12037 write(1, "\r\n", 2)               = 2
12037 pipe([3, 4])                      = 0
12037 pipe([3, 4])                      = 012037 pipe([5,  
6])                      = 0
12037 clone(child_stack=0, flags=CLONE_CHILD_CLEARTID| 
CLONE_CHILD_SETTID|SIGCHLD
, child_tidptr=0x2aaaaae12c20) = 12038
12038 close(5 <unfinished ...>
12037 close(6)                          = 0
12037 read(5,  <unfinished ...>
12038 <... close resumed> )             = 0
12038 fcntl(6, F_GETFD)                 = 0
12038 fcntl(6, F_SETFD, FD_CLOEXEC)     = 012038 dup2(3,  
0)                        = 0
12038 close(3)                          = 012038  
close(4)                          = 0
12038 execve("/usr/local/libexec/git-core/git", ["git", "upload-pack",  
"--stateless-rpc", "."], [/* 36 vars */]) = -1 ENOENT (No such file or  
directory)
12038 execve("/usr/libexec/git-core/git", ["git", "upload-pack", "-- 
stateless-rp
c", "."], [/* 36 vars */] <unfinished ...>
12037 <... read resumed> "", 1)         = 0
12037 <... read resumed> "", 1)         = 012037  
close(5)                          = 0
12037 close(3)                          = 012038 <... execve  
resumed> )            = 0
12037 close(1)                          = 0
... More random library loads ...
12038 pipe([3, 4])                      = 0
12038 clone(child_stack=0, flags=CLONE_CHILD_CLEARTID| 
CLONE_CHILD_SETTID|SIGCHLD, child_tidptr=0x2aaaaae12c40) = 12039
12039 close(3)                          = 0
12039 fcntl(4, F_GETFD)                 = 0
12039 fcntl(4, F_SETFD, FD_CLOEXEC)     = 0
12039 execve("/usr/libexec/git-core/git-upload-pack", ["git-upload- 
pack", "--stateless-rpc", "."], [/* 36 vars */] <unfinished ...>
12038 close(4)                          = 0
12037 read(0, "0067want c83f5a4ec9fb6b6681e74dc3c2276de5b947a76c  
multi_ack_detailed side-band-64k thin-pack ofs-delta\n0032want  
92e9b73bbd59b5ecf711381716c8aa13948f5a5d\n0032want
.. clipped out lots of sha's ..
98040a8100513ad2852ca911ac330ebd4ff9e10d\n00000009done\n", 8192) = 2316
12039 <... execve resumed> )            = 0
12038 <... read resumed> "", 1)         = 0
12038 close(3)                          = 0
12039 brk(0 <unfinished ...>
12038 wait4(12039,  <unfinished ...>
12039 <... brk resumed> )               = 0xf9d1000
12037 write(1, "Status: 500 Internal Server Error\r\n", 35  
<unfinished ...>
12039 mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE| 
MAP_ANONYMOUS, -1, 0 <unfinished ...>
12037 <... write resumed> )             = -1 EBADF (Bad file descriptor)
12039 <... mmap resumed> )              = 0x2aaaaaaab000
... This repeats for a while.. spitting out 500's on a bad file  
descriptor...
12037 write(1, "Status: 500 Internal Server Error\r\n", 35) = -1 EBADF  
(Bad file descriptor)
... Eventually this just repeats a few thousand times ...
12037 write(1, "Status: 500 Internal Server Error\r\n", 35) = -1 EBADF  
(Bad file descriptor)
12037 --- SIGSEGV (Segmentation fault) @ 0 (0) ---
12037 +++ killed by SIGSEGV +++
12039 <... read resumed> "", 4)         = 0
12039 write(2, "fatal: The remote end hung up unexpectedly\n", 43) = 43
12039 exit_group(128)                   = ?
12038 <... wait4 resumed> [{WIFEXITED(s) && WEXITSTATUS(s) == 128}],  
0, NULL) = 12039
12038 --- SIGCHLD (Child exited) @ 0 (0) ---
12038 exit_group(128)                   = ?

Anybody have any thoughts why this would happen or what can be done to  
fix it?
