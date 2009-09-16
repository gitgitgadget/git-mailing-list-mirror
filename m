From: Marius Storm-Olsen <mstormo@gmail.com>
Subject: [PATCH 01/15] Avoid declaration after statement
Date: Wed, 16 Sep 2009 10:20:17 +0200
Message-ID: <213f3c7799721c3f42ffa689498175f0495048eb.1253088099.git.mstormo@gmail.com>
References: <cover.1253088099.git.mstormo@gmail.com>
Cc: Johannes.Schindelin@gmx.de, msysgit@googlegroups.com, gitster@pobox.com, j6t@kdbg.org, lznuaa@gmail.com, raa.lkml@gmail.com, snaury@gmail.com, Marius Storm-Olsen <mstormo@gmail.com>
To: git@vger.kernel.org
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Wed Sep 16 10:21:07 2009
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-yx0-f137.google.com ([209.85.210.137])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MnplD-0004m7-3k
	for gcvm-msysgit@m.gmane.org; Wed, 16 Sep 2009 10:21:07 +0200
Received: by yxe1 with SMTP id 1so8796964yxe.21
        for <gcvm-msysgit@m.gmane.org>; Wed, 16 Sep 2009 01:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to
         :received:received:received:received-spf:received:dkim-signature
         :domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references
         :sender:precedence:x-google-loop:mailing-list:list-id:list-post
         :list-help:list-unsubscribe:x-beenthere-env:x-beenthere;
        bh=6x8AmbRrDlQXWrYSCSDQsDJbcXmsFySH8qGAxPi3YQY=;
        b=egObkNKWAqaLp6sb5FsSBRQ+2uGY3mOE0CDfD2R3RlaQCL+AMWNTGhfKHOdzOeBzXd
         U13K1wfduf4jlU1yl8cW1RSOl2KBARYKCtpmfsHy8H8IyDtN9blxWFI6a1RUGW6NSxpO
         4IYKZfPNBB7zp2aAlRws7z5+Tm/7YIqxkj0xc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results
         :dkim-signature:domainkey-signature:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:sender:precedence
         :x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere-env:x-beenthere;
        b=JpIVscPqVi686phvcK1NEmh8zmFpnhl9xAZSyfXyu+HY3lZEaWBOObSFJNpJeEKHAl
         TB8eDpJKbRUcs6OFS3H5jdsLKpwYPiihT/wUW9kpnGYUht+baRd+KMTNi+xWgUvDEuTr
         L7SwfIcdxG1oX4t/q+9H4zH6to4A99N0Y2+Dw=
Received: by 10.101.67.1 with SMTP id u1mr1868221ank.30.1253089260415;
        Wed, 16 Sep 2009 01:21:00 -0700 (PDT)
Received: by 10.177.108.35 with SMTP id k35gr7036yqm.0;
	Wed, 16 Sep 2009 01:20:52 -0700 (PDT)
X-Sender: mstormo@gmail.com
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.211.184.13 with SMTP id l13mr1122081ebp.18.1253089251819; Wed, 16 Sep 2009 01:20:51 -0700 (PDT)
Received: by 10.211.184.13 with SMTP id l13mr1122080ebp.18.1253089251745; Wed, 16 Sep 2009 01:20:51 -0700 (PDT)
Received: from mail-ew0-f210.google.com (mail-ew0-f210.google.com [209.85.219.210]) by gmr-mx.google.com with ESMTP id 16si1671084ewy.3.2009.09.16.01.20.50; Wed, 16 Sep 2009 01:20:50 -0700 (PDT)
Received-SPF: pass (google.com: domain of mstormo@gmail.com designates 209.85.219.210 as permitted sender) client-ip=209.85.219.210;
Authentication-Results: gmr-mx.google.com; spf=pass (google.com: domain of mstormo@gmail.com designates 209.85.219.210 as permitted sender) smtp.mail=mstormo@gmail.com; dkim=pass (test mode) header.i=@gmail.com
Received: by mail-ew0-f210.google.com with SMTP id 6so2098461ewy.30 for <msysgit@googlegroups.com>; Wed, 16 Sep 2009 01:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma; h=domainkey-signature:received:received:from:to:cc:subject:date :message-id:x-mailer:in-reply-to:references:in-reply-to:references; bh=z19TPtsCjvMI//lw0Lp/gPQfhD3Q5s2LzpXUWGaVDVg=; b=Z/QGgjyspoaU8giUgcILOgvElphkKM7ZlbC52ex/xNjHJHHg+Ijq1nKKNOeciyt1Zd nDwJatyArI20PM7FXZf4UyHB9pB2OIf93nREN/piChxQUU/8K1lYYGmD/Y5GCQAnmY25 NgMWhcK68Lxt0NxYhqov2Nw/4ybuwQgI2ZmZU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=gmail.com; s=gamma; h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references; b=B64furymLHzT8/DT4tUKNSivW/zIkTiKtP6X6/5yqslOsVBmwJ0XWyIQ6oBRdHMDVb nqiVXeEf3gpYRN4QtJgLqTUJ4vkstE49aHSzl0jh6LIG5c2mK90ln3hZtVpRM/CG9A3y +otEdkJHfqo/A65AOf0RfOvVoDl7Wtt7asthA=
Received: by 10.210.15.14 with SMTP id 14mr1892136ebo.49.1253089250533; Wed, 16 Sep 2009 01:20:50 -0700 (PDT)
Received: from localhost.localdomain ([62.70.27.104]) by mx.google.com with ESMTPS id 10sm1370859eyd.16.2009.09.16.01.20.48 (version=SSLv3 cipher=RC4-MD5); Wed, 16 Sep 2009 01:20:49 -0700 (PDT)
X-Mailer: git-send-email 1.6.2.1.418.g33d56.dirty
In-Reply-To: <cover.1253088099.git.mstormo@gmail.com>
In-Reply-To: <cover.1253088099.git.mstormo@gmail.com>
References: <cover.1253088099.git.mstormo@gmail.com>
Sender: msysgit@googlegroups.com
Precedence: bulk
X-Google-Loop: groups
Mailing-List: list msysgit@googlegroups.com;
	contact msysgit+owner@googlegroups.com
List-Id: <msysgit.googlegroups.com>
List-Post: <mailto:msysgit@googlegroups.com>
List-Help: <mailto:msysgit+help@googlegroups.com>
List-Unsubscribe: <http://googlegroups.com/group/msysgit/subscribe>,
	<mailto:msysgit+unsubscribe@googlegroups.com>
X-BeenThere-Env: msysgit@googlegroups.com
X-BeenThere: msysgit@googlegroups.com
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128616>


From: Frank Li <lznuaa@gmail.com>

MSVC does not understand this C99 style

Signed-off-by: Frank Li <lznuaa@gmail.com>
Signed-off-by: Marius Storm-Olsen <mstormo@gmail.com>
---
 compat/mingw.c |   14 ++++++++++----
 help.c         |    3 ++-
 run-command.c  |    2 ++
 3 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index 36ef8d3..5478b74 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -123,13 +123,17 @@ int mingw_open (const char *filename, int oflags, ...)
 {
 	va_list args;
 	unsigned mode;
+	int fd;
+
 	va_start(args, oflags);
 	mode = va_arg(args, int);
 	va_end(args);
 
 	if (!strcmp(filename, "/dev/null"))
 		filename = "nul";
-	int fd = open(filename, oflags, mode);
+
+	fd = open(filename, oflags, mode);
+
 	if (fd < 0 && (oflags & O_CREAT) && errno == EACCES) {
 		DWORD attrs = GetFileAttributes(filename);
 		if (attrs != INVALID_FILE_ATTRIBUTES && (attrs & FILE_ATTRIBUTE_DIRECTORY))
@@ -580,10 +584,11 @@ static char **get_path_split(void)
 
 static void free_path_split(char **path)
 {
+	char **p = path;
+
 	if (!path)
 		return;
 
-	char **p = path;
 	while (*p)
 		free(*p++);
 	free(path);
@@ -1120,9 +1125,9 @@ int sigaction(int sig, struct sigaction *in, struct sigaction *out)
 #undef signal
 sig_handler_t mingw_signal(int sig, sig_handler_t handler)
 {
+	sig_handler_t old = timer_fn;
 	if (sig != SIGALRM)
 		return signal(sig, handler);
-	sig_handler_t old = timer_fn;
 	timer_fn = handler;
 	return old;
 }
@@ -1209,8 +1214,9 @@ struct dirent *mingw_readdir(DIR *dir)
 
 	if (dir->dd_handle == (long)INVALID_HANDLE_VALUE && dir->dd_stat == 0)
 	{
+		DWORD lasterr;
 		handle = FindFirstFileA(dir->dd_name, &buf);
-		DWORD lasterr = GetLastError();
+		lasterr = GetLastError();
 		dir->dd_handle = (long)handle;
 		if (handle == INVALID_HANDLE_VALUE && (lasterr != ERROR_NO_MORE_FILES)) {
 			errno = err_win_to_posix(lasterr);
diff --git a/help.c b/help.c
index 294337e..fd51b8e 100644
--- a/help.c
+++ b/help.c
@@ -127,7 +127,7 @@ static int is_executable(const char *name)
 		return 0;
 
 #ifdef __MINGW32__
-	/* cannot trust the executable bit, peek into the file instead */
+{	/* cannot trust the executable bit, peek into the file instead */
 	char buf[3] = { 0 };
 	int n;
 	int fd = open(name, O_RDONLY);
@@ -140,6 +140,7 @@ static int is_executable(const char *name)
 				st.st_mode |= S_IXUSR;
 		close(fd);
 	}
+}
 #endif
 	return st.st_mode & S_IXUSR;
 }
diff --git a/run-command.c b/run-command.c
index ac314a5..02aaedf 100644
--- a/run-command.c
+++ b/run-command.c
@@ -134,6 +134,7 @@ fail_pipe:
 		error("cannot fork() for %s: %s", cmd->argv[0],
 			strerror(failed_errno = errno));
 #else
+{
 	int s0 = -1, s1 = -1, s2 = -1;	/* backups of stdin, stdout, stderr */
 	const char **sargv = cmd->argv;
 	char **env = environ;
@@ -197,6 +198,7 @@ fail_pipe:
 		dup2(s1, 1), close(s1);
 	if (s2 >= 0)
 		dup2(s2, 2), close(s2);
+}
 #endif
 
 	if (cmd->pid < 0) {
-- 
1.6.2.1.418.g33d56.dirty
