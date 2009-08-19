From: Frank Li <lznuaa@gmail.com>
Subject: [PATCH 03/12] Using macro WIN32 replace __MINGW32_  at Windows special handler The code which is conditional on MinGW32 is actually conditional on Windows. Use WIN32 macro will share both MINGW32 and MSVC environment.
Date: Wed, 19 Aug 2009 23:52:38 +0800
Message-ID: <1250697167-5536-3-git-send-email-lznuaa@gmail.com>
References: <1250697167-5536-1-git-send-email-lznuaa@gmail.com>
 <1250697167-5536-2-git-send-email-lznuaa@gmail.com>
Cc: Frank Li <lznuaa@gmail.com>
To: git@vger.kernel.org, msysgit@googlegroups.com
X-From: git-owner@vger.kernel.org Wed Aug 19 17:53:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MdnTq-0001jw-Ic
	for gcvg-git-2@lo.gmane.org; Wed, 19 Aug 2009 17:53:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752564AbZHSPxa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Aug 2009 11:53:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752542AbZHSPxa
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Aug 2009 11:53:30 -0400
Received: from rv-out-0506.google.com ([209.85.198.237]:42065 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752531AbZHSPx3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Aug 2009 11:53:29 -0400
Received: by rv-out-0506.google.com with SMTP id f6so1310962rvb.1
        for <git@vger.kernel.org>; Wed, 19 Aug 2009 08:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=wWMkJCdfvQvpRnp5qMnbdluoem0lRJNbQOQ/chO+zIg=;
        b=ujPbdEfTwvnA8VLpRxvCJct+sDrqrQeWduCkKIftHaOCBNY+dAWWtmEHu4nEVGcvrt
         uI49u/5UVNP7rizQ/HT0k/42k2VT1NJXP2yUn6xFI+X0lYY1QvwA4FDWUW+dKD0N3CBu
         MhppBN7fKNa2SFkFH/HeqtukpPaRtqUvucdUo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=TQU5mFCTBHLtlkxI3bVGveZLr/VcfqKZZRk38cLaHjslvt9PrBjXNRckydS0sj0ExY
         eJdeBW3MbhQWkSVEcenIvmuaS/WRiLZSbZnbRbWDmUBtMZay3dW0Y+/jZrBmELMmDGY5
         3khnn6sN9dBloPT0ak0yQC3Lx6djDNlCr2Apg=
Received: by 10.140.143.19 with SMTP id q19mr2671726rvd.17.1250697211022;
        Wed, 19 Aug 2009 08:53:31 -0700 (PDT)
Received: from localhost ([58.38.115.215])
        by mx.google.com with ESMTPS id f42sm50106rvb.22.2009.08.19.08.53.26
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 19 Aug 2009 08:53:29 -0700 (PDT)
X-Mailer: git-send-email 1.6.4.msysgit.0
In-Reply-To: <1250697167-5536-2-git-send-email-lznuaa@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126553>

Signed-off-by: Frank Li <lznuaa@gmail.com>
---
 help.c        |    2 +-
 pager.c       |    4 ++--
 run-command.c |    8 ++++----
 run-command.h |    2 +-
 setup.c       |    2 +-
 5 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/help.c b/help.c
index 399b0b4..9dae4e7 100644
--- a/help.c
+++ b/help.c
@@ -126,7 +126,7 @@ static int is_executable(const char *name)
 	    !S_ISREG(st.st_mode))
 		return 0;
 
-#ifdef __MINGW32__
+#ifdef WIN32
 {	/* cannot trust the executable bit, peek into the file instead */
 	char buf[3] = { 0 };
 	int n;
diff --git a/pager.c b/pager.c
index 4921843..37d1948 100644
--- a/pager.c
+++ b/pager.c
@@ -9,7 +9,7 @@
 
 static int spawned_pager;
 
-#ifndef __MINGW32__
+#ifndef WIN32
 static void pager_preexec(void)
 {
 	/*
@@ -70,7 +70,7 @@ void setup_pager(void)
 	pager_argv[2] = pager;
 	pager_process.argv = pager_argv;
 	pager_process.in = -1;
-#ifndef __MINGW32__
+#ifndef WIN32
 	pager_process.preexec_cb = pager_preexec;
 #endif
 	if (start_command(&pager_process))
diff --git a/run-command.c b/run-command.c
index d1df7ab..d0833f8 100644
--- a/run-command.c
+++ b/run-command.c
@@ -67,7 +67,7 @@ int start_command(struct child_process *cmd)
 
 	trace_argv_printf(cmd->argv, "trace: run_command:");
 
-#ifndef __MINGW32__
+#ifndef WIN32
 	fflush(NULL);
 	cmd->pid = fork();
 	if (!cmd->pid) {
@@ -294,7 +294,7 @@ int run_command_v_opt_cd_env(const char **argv, int opt, const char *dir, const
 	return run_command(&cmd);
 }
 
-#ifdef __MINGW32__
+#ifdef WIN32
 static __stdcall unsigned run_thread(void *data)
 {
 	struct async *async = data;
@@ -310,7 +310,7 @@ int start_async(struct async *async)
 		return error("cannot create pipe: %s", strerror(errno));
 	async->out = pipe_out[0];
 
-#ifndef __MINGW32__
+#ifndef WIN32
 	/* Flush stdio before fork() to avoid cloning buffers */
 	fflush(NULL);
 
@@ -339,7 +339,7 @@ int start_async(struct async *async)
 
 int finish_async(struct async *async)
 {
-#ifndef __MINGW32__
+#ifndef WIN32
 	int ret = 0;
 
 	if (wait_or_whine(async->pid))
diff --git a/run-command.h b/run-command.h
index e345502..09a4cb2 100644
--- a/run-command.h
+++ b/run-command.h
@@ -79,7 +79,7 @@ struct async {
 	int (*proc)(int fd, void *data);
 	void *data;
 	int out;	/* caller reads from here and closes it */
-#ifndef __MINGW32__
+#ifndef WIN32
 	pid_t pid;
 #else
 	HANDLE tid;
diff --git a/setup.c b/setup.c
index e3781b6..029371e 100644
--- a/setup.c
+++ b/setup.c
@@ -41,7 +41,7 @@ const char *prefix_path(const char *prefix, int len, const char *path)
 const char *prefix_filename(const char *pfx, int pfx_len, const char *arg)
 {
 	static char path[PATH_MAX];
-#ifndef __MINGW32__
+#ifndef WIN32
 	if (!pfx || !*pfx || is_absolute_path(arg))
 		return arg;
 	memcpy(path, pfx, pfx_len);
-- 
1.6.4.msysgit.0
