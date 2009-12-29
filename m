From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: [PATCH 1/2] MinGW: Use pid_t more consequently, introduce uid_t for
 greater compatibility
Date: Tue, 29 Dec 2009 02:18:46 +0100
Message-ID: <hhbldr$di8$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 29 02:19:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NPQk0-0008O5-Eo
	for gcvg-git-2@lo.gmane.org; Tue, 29 Dec 2009 02:19:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752078AbZL2BTL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Dec 2009 20:19:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751638AbZL2BTL
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Dec 2009 20:19:11 -0500
Received: from lo.gmane.org ([80.91.229.12]:51129 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751061AbZL2BTK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Dec 2009 20:19:10 -0500
Received: from list by lo.gmane.org with local (Exim 4.50)
	id 1NPQjp-0008MM-5z
	for git@vger.kernel.org; Tue, 29 Dec 2009 02:19:05 +0100
Received: from 91-67-62-42-dynip.superkabel.de ([91.67.62.42])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 29 Dec 2009 02:19:05 +0100
Received: from sschuberth by 91-67-62-42-dynip.superkabel.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 29 Dec 2009 02:19:05 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 91-67-62-42-dynip.superkabel.de
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.12) Gecko/20080213 Thunderbird/2.0.0.12 Mnenhy/0.7.5.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135775>

MinGW: Use pid_t more consequently, introduce uid_t for greater compatibility

Signed-off-by: Sebastian Schuberth <sschuberth@gmail.com>
---
 compat/mingw.h |   11 ++++++-----
 1 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/compat/mingw.h b/compat/mingw.h
index b3d299f..af2f810 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -6,6 +6,7 @@
  */
 
 typedef int pid_t;
+typedef int uid_t;
 #define hstrerror strerror
 
 #define S_IFLNK    0120000 /* Symbolic link */
@@ -75,17 +76,17 @@ static inline int symlink(const char *oldpath, const char *newpath)
 { errno = ENOSYS; return -1; }
 static inline int fchmod(int fildes, mode_t mode)
 { errno = ENOSYS; return -1; }
-static inline int fork(void)
+static inline pid_t fork(void)
 { errno = ENOSYS; return -1; }
 static inline unsigned int alarm(unsigned int seconds)
 { return 0; }
 static inline int fsync(int fd)
 { return 0; }
-static inline int getppid(void)
+static inline pid_t getppid(void)
 { return 1; }
 static inline void sync(void)
 {}
-static inline int getuid()
+static inline uid_t getuid()
 { return 1; }
 static inline struct passwd *getpwnam(const char *name)
 { return NULL; }
@@ -117,7 +118,7 @@ static inline int mingw_unlink(const char *pathname)
 }
 #define unlink mingw_unlink
 
-static inline int waitpid(pid_t pid, int *status, unsigned options)
+static inline pid_t waitpid(pid_t pid, int *status, unsigned options)
 {
 	if (options == 0)
 		return _cwait(status, pid, 0);
@@ -158,7 +159,7 @@ int poll(struct pollfd *ufds, unsigned int nfds, int timeout);
 struct tm *gmtime_r(const time_t *timep, struct tm *result);
 struct tm *localtime_r(const time_t *timep, struct tm *result);
 int getpagesize(void);	/* defined in MinGW's libgcc.a */
-struct passwd *getpwuid(int uid);
+struct passwd *getpwuid(uid_t uid);
 int setitimer(int type, struct itimerval *in, struct itimerval *out);
 int sigaction(int sig, struct sigaction *in, struct sigaction *out);
 int link(const char *oldpath, const char *newpath);
-- 
1.6.5.rc2.13.g1be2
