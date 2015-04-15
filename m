From: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH] compat/mingw: stubs for getpgid() and tcgetpgrp()
Date: Wed, 15 Apr 2015 20:29:30 +0200
Message-ID: <552EAE0A.3040208@kdbg.org>
References: <20150413134850.GC23475@mewburn.net> <alpine.LFD.2.11.1504130954420.5619@knanqh.ubzr> <20150413144039.GD23475@mewburn.net> <alpine.LFD.2.11.1504131052090.5619@knanqh.ubzr> <20150414110312.GE23475@mewburn.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Nicolas Pitre <nico@fluxnic.net>, git@vger.kernel.org,
	msysGit <msysgit@googlegroups.com>
To: Luke Mewburn <luke@mewburn.net>
X-From: git-owner@vger.kernel.org Wed Apr 15 20:30:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YiS4D-0005C9-9N
	for gcvg-git-2@plane.gmane.org; Wed, 15 Apr 2015 20:29:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756305AbbDOS3h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Apr 2015 14:29:37 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:14017 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756006AbbDOS3f (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Apr 2015 14:29:35 -0400
Received: from dx.site (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTPSA id 3lRsfM30vVz5tlC;
	Wed, 15 Apr 2015 20:29:31 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.site (Postfix) with ESMTP id 81AA451AD;
	Wed, 15 Apr 2015 20:29:30 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.6.0
In-Reply-To: <20150414110312.GE23475@mewburn.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267228>

Windows does not have process groups. It is, therefore, the simplest
to pretend that each process is in its own process group.

While here, move the getppid() stub from its old location (between
two sync related functions) next to the two new functions.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 compat/mingw.h | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/compat/mingw.h b/compat/mingw.h
index 7b523cf..a552026 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -95,8 +95,6 @@ static inline unsigned int alarm(unsigned int seconds)
 { return 0; }
 static inline int fsync(int fd)
 { return _commit(fd); }
-static inline pid_t getppid(void)
-{ return 1; }
 static inline void sync(void)
 {}
 static inline uid_t getuid(void)
@@ -118,6 +116,12 @@ static inline int sigaddset(sigset_t *set, int signum)
 #define SIG_UNBLOCK 0
 static inline int sigprocmask(int how, const sigset_t *set, sigset_t *oldset)
 { return 0; }
+static inline pid_t getppid(void)
+{ return 1; }
+static inline pid_t getpgid(pid_t pid)
+{ return pid == 0 ? getpid() : pid; }
+static inline pid_t tcgetpgrp(int fd)
+{ return getpid(); }
 
 /*
  * simple adaptors
-- 
2.3.2.245.gb5bf9d3
