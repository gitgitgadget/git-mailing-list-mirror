From: Frank Li <lznuaa@gmail.com>
Subject: [PATCH 04/11] Add _MSC_VER predefine macro to make same behaviors with __MINGW32__ Enable MSVC build. MSVC have the save behaviors with msysgit.
Date: Tue, 18 Aug 2009 00:01:05 +0800
Message-ID: <1250524872-5148-4-git-send-email-lznuaa@gmail.com>
References: <1250524872-5148-1-git-send-email-lznuaa@gmail.com>
 <1250524872-5148-2-git-send-email-lznuaa@gmail.com>
 <1250524872-5148-3-git-send-email-lznuaa@gmail.com>
Cc: Johannes.Schindelin@gmx.de, Frank Li <lznuaa@gmail.com>
To: git@vger.kernel.org, msysgit@googlegroups.com
X-From: git-owner@vger.kernel.org Mon Aug 17 18:02:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Md4fR-0003uE-D1
	for gcvg-git-2@lo.gmane.org; Mon, 17 Aug 2009 18:02:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756521AbZHQQCc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Aug 2009 12:02:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756516AbZHQQCb
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Aug 2009 12:02:31 -0400
Received: from mail-px0-f196.google.com ([209.85.216.196]:63792 "EHLO
	mail-px0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753580AbZHQQCb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Aug 2009 12:02:31 -0400
Received: by pxi34 with SMTP id 34so1251248pxi.4
        for <git@vger.kernel.org>; Mon, 17 Aug 2009 09:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=bALYZG4BvFtXcp4HFojOA15VXHjm4XWk7eoSV+EeQ/0=;
        b=A4djbiWKvWTjcgFId6VGF2EwYn4LSyBQTXQ+CJwj2Hf209hPlQGo2gboGY73c5t7eb
         sNnJ3xat42RF9kpLAZjQtuYJAmosk+fZD+30wkMwnJuUgZMCZJB6wMaleVVdGB4bvJao
         4+usVsfX42pHmhToMlTNWBwI/XaX+p6sQus9I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=rJU6KUgwxzsUy6rimebxtjLremn7HA51lezevYHyfEwXF9EDwwo/JbYEM4tEIA5Jz1
         U6FqAxpHQ39vp8ZT8UINTD3klcXTtH/nyKmzMpvHHAtYbvzxzuBviSazCtDEa2M1K1nh
         5fr8JmnuNaV4ZiN0wpiSvE5Nxcnke+tfXLVrU=
Received: by 10.140.128.20 with SMTP id a20mr2368404rvd.149.1250524952703;
        Mon, 17 Aug 2009 09:02:32 -0700 (PDT)
Received: from localhost ([58.38.115.215])
        by mx.google.com with ESMTPS id g22sm28205350rvb.42.2009.08.17.09.02.29
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 17 Aug 2009 09:02:31 -0700 (PDT)
X-Mailer: git-send-email 1.6.4.msysgit.0
In-Reply-To: <1250524872-5148-3-git-send-email-lznuaa@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126204>

Signed-off-by: Frank Li <lznuaa@gmail.com>
---
 help.c        |    2 +-
 pager.c       |    4 ++--
 run-command.c |    8 ++++----
 run-command.h |    2 +-
 setup.c       |    2 +-
 5 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/help.c b/help.c
index 399b0b4..a311241 100644
--- a/help.c
+++ b/help.c
@@ -126,7 +126,7 @@ static int is_executable(const char *name)
 	    !S_ISREG(st.st_mode))
 		return 0;
 
-#ifdef __MINGW32__
+#if defined(__MINGW32__) || defined(_MSC_VER)
 {	/* cannot trust the executable bit, peek into the file instead */
 	char buf[3] = { 0 };
 	int n;
diff --git a/pager.c b/pager.c
index 4921843..28122c5 100644
--- a/pager.c
+++ b/pager.c
@@ -9,7 +9,7 @@
 
 static int spawned_pager;
 
-#ifndef __MINGW32__
+#if !defined(__MINGW32__) && !defined(_MSC_VER)
 static void pager_preexec(void)
 {
 	/*
@@ -70,7 +70,7 @@ void setup_pager(void)
 	pager_argv[2] = pager;
 	pager_process.argv = pager_argv;
 	pager_process.in = -1;
-#ifndef __MINGW32__
+#if !defined(__MINGW32__) && !defined(_MSC_VER)
 	pager_process.preexec_cb = pager_preexec;
 #endif
 	if (start_command(&pager_process))
diff --git a/run-command.c b/run-command.c
index d1df7ab..df139da 100644
--- a/run-command.c
+++ b/run-command.c
@@ -67,7 +67,7 @@ int start_command(struct child_process *cmd)
 
 	trace_argv_printf(cmd->argv, "trace: run_command:");
 
-#ifndef __MINGW32__
+#if !defined(__MINGW32__) && !defined(_MSC_VER)
 	fflush(NULL);
 	cmd->pid = fork();
 	if (!cmd->pid) {
@@ -294,7 +294,7 @@ int run_command_v_opt_cd_env(const char **argv, int opt, const char *dir, const
 	return run_command(&cmd);
 }
 
-#ifdef __MINGW32__
+#if defined(__MINGW32__) || defined(_MSC_VER)
 static __stdcall unsigned run_thread(void *data)
 {
 	struct async *async = data;
@@ -310,7 +310,7 @@ int start_async(struct async *async)
 		return error("cannot create pipe: %s", strerror(errno));
 	async->out = pipe_out[0];
 
-#ifndef __MINGW32__
+#if !defined(__MINGW32__) && !defined(_MSC_VER)
 	/* Flush stdio before fork() to avoid cloning buffers */
 	fflush(NULL);
 
@@ -339,7 +339,7 @@ int start_async(struct async *async)
 
 int finish_async(struct async *async)
 {
-#ifndef __MINGW32__
+#if !defined(__MINGW32__) && !defined(_MSC_VER)
 	int ret = 0;
 
 	if (wait_or_whine(async->pid))
diff --git a/run-command.h b/run-command.h
index e345502..57a707b 100644
--- a/run-command.h
+++ b/run-command.h
@@ -79,7 +79,7 @@ struct async {
 	int (*proc)(int fd, void *data);
 	void *data;
 	int out;	/* caller reads from here and closes it */
-#ifndef __MINGW32__
+#if !defined(__MINGW32__) && !defined(_MSC_VER)
 	pid_t pid;
 #else
 	HANDLE tid;
diff --git a/setup.c b/setup.c
index e3781b6..14e3ca7 100644
--- a/setup.c
+++ b/setup.c
@@ -41,7 +41,7 @@ const char *prefix_path(const char *prefix, int len, const char *path)
 const char *prefix_filename(const char *pfx, int pfx_len, const char *arg)
 {
 	static char path[PATH_MAX];
-#ifndef __MINGW32__
+#if !defined(__MINGW32__) && !defined(_MSC_VER)
 	if (!pfx || !*pfx || is_absolute_path(arg))
 		return arg;
 	memcpy(path, pfx, pfx_len);
-- 
1.6.4.msysgit.0
