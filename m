From: Marius Storm-Olsen <mstormo@gmail.com>
Subject: [PATCH 02/14] Avoid declaration after statement
Date: Fri, 21 Aug 2009 15:30:34 +0200
Message-ID: <af66de324093bbe8f500b1ef20689dd5d355abf4.1250860247.git.mstormo@gmail.com>
References: <cover.1250860247.git.mstormo@gmail.com>
 <6283b3e1775f43c6fc07e5047f9c99acdc27bc8f.1250860247.git.mstormo@gmail.com>
Cc: msysgit@googlegroups.com, git@vger.kernel.org, lznuaa@gmail.com,
	Marius Storm-Olsen <mstormo@gmail.com>
To: Johannes.Schindelin@gmx.de
X-From: git-owner@vger.kernel.org Fri Aug 21 15:31:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MeUDA-0000V9-VW
	for gcvg-git-2@lo.gmane.org; Fri, 21 Aug 2009 15:31:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932224AbZHUNbM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Aug 2009 09:31:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932227AbZHUNbL
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Aug 2009 09:31:11 -0400
Received: from mail-ew0-f207.google.com ([209.85.219.207]:57834 "EHLO
	mail-ew0-f207.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932207AbZHUNbG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Aug 2009 09:31:06 -0400
Received: by ewy3 with SMTP id 3so637048ewy.18
        for <git@vger.kernel.org>; Fri, 21 Aug 2009 06:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references;
        bh=PCsXt9UdSbIlRgbxua6/3+Q1dQgUWCyLjV/7IO9dr0k=;
        b=AEKw8ed8HaqAmEj30aapB67uGYRwxyb74mkpFN/GTiRTDxh9YEW98hH49aq3fVQVF4
         f+BsDaZLsme+JJeuSU3R+LhjEkz4pLMnNVjR8f24ejYkL/zJUtWkIqpRPproi4KOmNLS
         T7Yg8FgHs2a4uPLpdjr+QBxdtdSKSmKMxF87g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=QE2W1GiM9Yta/nZsYe/FSuxoPqvCYajgZlqbiodgWlL0ufFmsOVtlwwccIa2bY10qs
         94y3j+m4Ipb/j8C5Ul2HmCYyiQGbPvQ5XC83hfV1GuYtSdh4jU+0TT+W8VrEdQg7ntsD
         QPsEwY4Kj+a4mY2VMrzT4gL7KFv00lreBxUp0=
Received: by 10.210.57.1 with SMTP id f1mr1486913eba.66.1250861466580;
        Fri, 21 Aug 2009 06:31:06 -0700 (PDT)
Received: from localhost.localdomain ([62.70.27.104])
        by mx.google.com with ESMTPS id 10sm4251897eyd.24.2009.08.21.06.31.05
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 21 Aug 2009 06:31:06 -0700 (PDT)
X-Mailer: git-send-email 1.6.2.1.418.g33d56.dirty
In-Reply-To: <6283b3e1775f43c6fc07e5047f9c99acdc27bc8f.1250860247.git.mstormo@gmail.com>
In-Reply-To: <cover.1250860247.git.mstormo@gmail.com>
References: <cover.1250860247.git.mstormo@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126711>

From: Frank Li <lznuaa@gmail.com>

Microsoft Visual C++ does not understand this C99 style

Signed-off-by: Frank Li <lznuaa@gmail.com>
Signed-off-by: Marius Storm-Olsen <mstormo@gmail.com>
---
 compat/mingw.c |   14 ++++++++++----
 help.c         |    3 ++-
 run-command.c  |    2 ++
 3 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index bed4178..e4e0e60 100644
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
@@ -1108,9 +1113,9 @@ int sigaction(int sig, struct sigaction *in, struct sigaction *out)
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
@@ -1197,8 +1202,9 @@ struct dirent *mingw_readdir(DIR *dir)
 
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
index f3e7abb..efac7ad 100644
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
@@ -200,6 +201,7 @@ fail_pipe:
 		dup2(s1, 1), close(s1);
 	if (s2 >= 0)
 		dup2(s2, 2), close(s2);
+}
 #endif
 
 	if (cmd->pid < 0) {
-- 
1.6.3.msysgit.0.18.gef407
