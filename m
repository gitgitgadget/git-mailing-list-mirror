Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B73D8C38142
	for <git@archiver.kernel.org>; Sat, 21 Jan 2023 20:49:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbjAUUtY (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 Jan 2023 15:49:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjAUUtX (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Jan 2023 15:49:23 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BCD01A972
        for <git@vger.kernel.org>; Sat, 21 Jan 2023 12:49:22 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id l8so6407407wms.3
        for <git@vger.kernel.org>; Sat, 21 Jan 2023 12:49:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=UVy9Lb5waivKjzA5iek5tJaprLJ5btu3tApMTXc4O7k=;
        b=RYhmEFroU5UNcsJzU5Sf+h6h9C5MEBIMs3T0YvAScie9JC0sjfhiO8AXXFqynOoNq6
         IwgXF4UVvhik3XAbM/pxtCORJE5JbeuzaH0UhdF59UZdoj6mh/bnqmuMpwk3yIi79XMV
         voXiIYufCnmfI0zocpxhlhyixe+vkmOGVrRKGlEqPnFFkH/eUjQR/RwkfJLrd7pqwjF+
         nqEWpc51nb5lqm7a88xE8wkQdwUrSOP9ggQHansbga6AFbd20Rz72bwtN23Z9+ZAU2ms
         G6SImEknornnY4c6FZs0eWEulCI9ahIyH+6C4Zms7iKVl5DNy1udBqJ2KHoLsFP/DQic
         sVuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UVy9Lb5waivKjzA5iek5tJaprLJ5btu3tApMTXc4O7k=;
        b=nrP4E2vH4gYzPRBVcyywdrlMQlteia1tHtbHo+erOa3H5aAslyy7pXdx09GQDhB/DR
         2LQvxhkjAG2nILlV7CMzbzzs1CIDA29E2e6i58GySqO64BFPY3WygqWACOSLXSIz6rWV
         75zbKiS3UyI3J1pRyjWt7XW8pyncaV9018VjVtG7cyz2XBNxpW9Ev+hFb1KtgT0yldkv
         RLOIlhzIA8jdwhR2DOKUr7yiQQOBIjgJLgXZt7lwX7NW0Nybj89b+U+/vq/TAWrNqF4r
         hFt/NkATzSOyYIzsmmc1mBxcijcWVoW8fWmqH3XqLxM3lFj/qtqGor6HHEapzuws18js
         iIPQ==
X-Gm-Message-State: AFqh2kpzHJj3zrE+gmyC5Io3iN5BOb3W01w0Eyp05PqMCjlAO2Q3EVxd
        M6+/PZAXGWntLRVyWGqKSfotvtbRm2I=
X-Google-Smtp-Source: AMrXdXt7qhnjncNkdhUbNK3XyO74eHQQ8SM58cfLErNTNHe2bLte8hXjUi1o1KbxKciEgeXPrZVEFQ==
X-Received: by 2002:a1c:f203:0:b0:3da:fa42:bbf2 with SMTP id s3-20020a1cf203000000b003dafa42bbf2mr17821137wmc.28.1674334160586;
        Sat, 21 Jan 2023 12:49:20 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o4-20020a1c7504000000b003da28dfdedcsm7202714wmc.5.2023.01.21.12.49.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Jan 2023 12:49:19 -0800 (PST)
Message-Id: <pull.1440.git.git.1674334159116.gitgitgadget@gmail.com>
From:   "Rose via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 21 Jan 2023 20:49:18 +0000
Subject: [PATCH] win32: fix thread usage for win32
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Rose <83477269+AtariDreams@users.noreply.github.com>,
        Seija Kijin <doremylover123@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Seija Kijin <doremylover123@gmail.com>

Use pthread_exit instead of async_exit.

This means we do not have
to deal with Windows's implementation
requiring an unsigned exit coded
despite the POSIX exit code requiring
a signed exit code.

Use _beginthreadex instead of CreateThread
since we use the Windows CRT.

Finally, check for NULL handles, not "INVALID_HANDLE,"
as _beginthreadex guarantees a valid handle in most cases

Signed-off-by: Seija Kijin <doremylover123@gmail.com>
---
    win32: fix thread usage for win32
    
    Use pthread_exit instead of async_exit.
    
    This means we do not have to deal with Windows's implementation
    requiring an unsigned exit coded despite the POSIX exit code requiring a
    signed exit code.
    
    Use _beginthreadex instead of CreateThread since we use the Windows CRT.
    
    Finally, check for NULL handles, not "INVALID_HANDLE," as _beginthreadex
    guarantees a valid handle in most cases
    
    Signed-off-by: Seija Kijin doremylover123@gmail.com

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1440%2FAtariDreams%2FCreateThread-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1440/AtariDreams/CreateThread-v1
Pull-Request: https://github.com/git/git/pull/1440

 compat/mingw.c   |  2 +-
 compat/winansi.c |  8 ++++----
 run-command.c    | 33 ++++++++++++++-------------------
 3 files changed, 19 insertions(+), 24 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index af397e68a1d..c41d821b382 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -2295,7 +2295,7 @@ static int start_timer_thread(void)
 	timer_event = CreateEvent(NULL, FALSE, FALSE, NULL);
 	if (timer_event) {
 		timer_thread = (HANDLE) _beginthreadex(NULL, 0, ticktack, NULL, 0, NULL);
-		if (!timer_thread )
+		if (!timer_thread)
 			return errno = ENOMEM,
 				error("cannot start timer thread");
 	} else
diff --git a/compat/winansi.c b/compat/winansi.c
index 3abe8dd5a27..be65b27bd75 100644
--- a/compat/winansi.c
+++ b/compat/winansi.c
@@ -340,7 +340,7 @@ enum {
 	TEXT = 0, ESCAPE = 033, BRACKET = '['
 };
 
-static DWORD WINAPI console_thread(LPVOID unused)
+static unsigned int WINAPI console_thread(LPVOID unused)
 {
 	unsigned char buffer[BUFFER_SIZE];
 	DWORD bytes;
@@ -643,9 +643,9 @@ void winansi_init(void)
 		die_lasterr("CreateFile for named pipe failed");
 
 	/* start console spool thread on the pipe's read end */
-	hthread = CreateThread(NULL, 0, console_thread, NULL, 0, NULL);
-	if (hthread == INVALID_HANDLE_VALUE)
-		die_lasterr("CreateThread(console_thread) failed");
+	hthread = (HANDLE)_beginthreadex(NULL, 0, console_thread, NULL, 0, NULL);
+	if (!hthread)
+		die_lasterr("_beginthreadex(console_thread) failed");
 
 	/* schedule cleanup routine */
 	if (atexit(winansi_exit))
diff --git a/run-command.c b/run-command.c
index 50cc011654e..93fd0d22d4f 100644
--- a/run-command.c
+++ b/run-command.c
@@ -1030,6 +1030,13 @@ static void *run_thread(void *data)
 	return (void *)ret;
 }
 
+int in_async(void)
+{
+	if (!main_thread_set)
+		return 0; /* no asyncs started yet */
+	return !pthread_equal(main_thread, pthread_self());
+}
+
 static NORETURN void die_async(const char *err, va_list params)
 {
 	report_fn die_message_fn = get_die_message_routine();
@@ -1055,18 +1062,6 @@ static int async_die_is_recursing(void)
 	return ret != NULL;
 }
 
-int in_async(void)
-{
-	if (!main_thread_set)
-		return 0; /* no asyncs started yet */
-	return !pthread_equal(main_thread, pthread_self());
-}
-
-static void NORETURN async_exit(int code)
-{
-	pthread_exit((void *)(intptr_t)code);
-}
-
 #else
 
 static struct {
@@ -1112,18 +1107,18 @@ int in_async(void)
 	return process_is_async;
 }
 
-static void NORETURN async_exit(int code)
-{
-	exit(code);
-}
-
 #endif
 
 void check_pipe(int err)
 {
 	if (err == EPIPE) {
-		if (in_async())
-			async_exit(141);
+		if (in_async()) {
+#ifdef NO_PTHREADS
+			exit(141);
+#else
+			pthread_exit((void *)141);
+#endif
+		}
 
 		signal(SIGPIPE, SIG_DFL);
 		raise(SIGPIPE);

base-commit: 904d404274fef6695c78a6b055edd184b72e2f9b
-- 
gitgitgadget
