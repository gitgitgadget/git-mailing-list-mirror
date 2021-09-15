Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4018C433FE
	for <git@archiver.kernel.org>; Wed, 15 Sep 2021 20:36:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95D526103E
	for <git@archiver.kernel.org>; Wed, 15 Sep 2021 20:36:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232052AbhIOUhw (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Sep 2021 16:37:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231490AbhIOUho (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Sep 2021 16:37:44 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D789C0613CF
        for <git@vger.kernel.org>; Wed, 15 Sep 2021 13:36:24 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id i23so5876206wrb.2
        for <git@vger.kernel.org>; Wed, 15 Sep 2021 13:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=qbJv3yQE130l2dg1VoZZP6a509XxMSMZ7Jrxs69dQ6s=;
        b=pGWLuszBDBuHlXir0oSSbpSWVs9flRl8lrvgH03Hm7sb3jf9dXmQpSzwVtOmGNGrCV
         1PD1yYy2MBWIt3oqtvYMiNFDfvMbeUfBvLRuyMJmU8H+WVCRuRDWgReSsY+P2H58Dc5b
         JxoYNGMIq03+emXVI7ABKD/HzgdBTb6mSnPN1MXQ47dtuPaamxdVVHptriHSyWZuL0uZ
         Ou8EYPHjuUExszJxlRVYyaU7oIyy953NPnk9pvysf/PSS6/VFNib2xPS/x2bjOv0mOSz
         M970cwCk8/rVVqjA6AfC2qd44G11uDV+Q3YfJsFfHz3nlt3N3fgcUEVsYSm+iC9cnRUF
         qD6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=qbJv3yQE130l2dg1VoZZP6a509XxMSMZ7Jrxs69dQ6s=;
        b=qbIFtiZqu6ClmnY0ybNIAyy6vpTy0SgLfWkGczvlySqgiPmA8QO5ZfhS9J8GdW20Bm
         2M2NBY7PCABRTz67oWCvVX3EvOcAuRhZ35F+XjTTeApLZ/ORH7fd+ufEi1jNcFyg0s5r
         xZpLxToioRvw3rXNgu5Y991c7eItTs45G6WmwGO2eImmPM+4wrq78TDdpITdO9CXEL+T
         QBgaJx7RgDgZxBwx96v3QmDGKa+zWti6yFPgXocoMGOkUhACPO7kY7az+AOpkdmojdw4
         7owa8MG5ErUxMfYS5ElXT2KSCI5R165cosC6yDdtmCR2lbsedXJpa2qepM44OO8aGzhZ
         UEqA==
X-Gm-Message-State: AOAM5311MatuPaWm/50XXEksXezp+olRm1vHaVW7WNU87+L2wSvjh32c
        KPYVmhV08zUeUK2xruls8UOgnRVGG/8=
X-Google-Smtp-Source: ABdhPJxYVlBCnXm9YKkK8m0L6H+tX2EPNHLWt5odNMQPCCpIE2TysL7L8o6ZwMhuzFArFuk//UkSkw==
X-Received: by 2002:adf:816f:: with SMTP id 102mr2082076wrm.368.1631738182896;
        Wed, 15 Sep 2021 13:36:22 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d5sm1103219wra.38.2021.09.15.13.36.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Sep 2021 13:36:22 -0700 (PDT)
Message-Id: <57f29feaadb4a732892cd193b2a1d3c838f09421.1631738177.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1040.git.1631738177.gitgitgadget@gmail.com>
References: <pull.1040.git.1631738177.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 15 Sep 2021 20:36:17 +0000
Subject: [PATCH 7/7] t/helper/simple-ipc: convert test-simple-ipc to use
 start_bg_command
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Convert test helper to use `start_bg_command()` when spawning a server
daemon in the background rather than blocks of platform-specific code.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 t/helper/test-simple-ipc.c | 193 ++++++++-----------------------------
 1 file changed, 40 insertions(+), 153 deletions(-)

diff --git a/t/helper/test-simple-ipc.c b/t/helper/test-simple-ipc.c
index 91345180750..59a950f3b00 100644
--- a/t/helper/test-simple-ipc.c
+++ b/t/helper/test-simple-ipc.c
@@ -9,6 +9,7 @@
 #include "parse-options.h"
 #include "thread-utils.h"
 #include "strvec.h"
+#include "run-command.h"
 
 #ifndef SUPPORTS_SIMPLE_IPC
 int cmd__simple_ipc(int argc, const char **argv)
@@ -274,178 +275,64 @@ static int daemon__run_server(void)
 	return ret;
 }
 
-#ifndef GIT_WINDOWS_NATIVE
-/*
- * This is adapted from `daemonize()`.  Use `fork()` to directly create and
- * run the daemon in a child process.
- */
-static int spawn_server(pid_t *pid)
-{
-	struct ipc_server_opts opts = {
-		.nr_threads = cl_args.nr_threads,
-	};
+static start_bg_wait_cb bg_wait_cb;
 
-	*pid = fork();
-
-	switch (*pid) {
-	case 0:
-		if (setsid() == -1)
-			error_errno(_("setsid failed"));
-		close(0);
-		close(1);
-		close(2);
-		sanitize_stdfds();
+static int bg_wait_cb(void *cb_data, const struct child_process *cp)
+{
+	int s = ipc_get_active_state(cl_args.path);
 
-		return ipc_server_run(cl_args.path, &opts, test_app_cb,
-				      (void*)&my_app_data);
+	switch (s) {
+	case IPC_STATE__LISTENING:
+		/* child is "ready" */
+		return 0;
 
-	case -1:
-		return error_errno(_("could not spawn daemon in the background"));
+	case IPC_STATE__NOT_LISTENING:
+	case IPC_STATE__PATH_NOT_FOUND:
+		/* give child more time */
+		return 1;
 
 	default:
-		return 0;
+	case IPC_STATE__INVALID_PATH:
+	case IPC_STATE__OTHER_ERROR:
+		/* all the time in world won't help */
+		return -1;
 	}
 }
-#else
-/*
- * Conceptually like `daemonize()` but different because Windows does not
- * have `fork(2)`.  Spawn a normal Windows child process but without the
- * limitations of `start_command()` and `finish_command()`.
- */
-static int spawn_server(pid_t *pid)
-{
-	char test_tool_exe[MAX_PATH];
-	struct strvec args = STRVEC_INIT;
-	int in, out;
-
-	GetModuleFileNameA(NULL, test_tool_exe, MAX_PATH);
-
-	in = open("/dev/null", O_RDONLY);
-	out = open("/dev/null", O_WRONLY);
-
-	strvec_push(&args, test_tool_exe);
-	strvec_push(&args, "simple-ipc");
-	strvec_push(&args, "run-daemon");
-	strvec_pushf(&args, "--name=%s", cl_args.path);
-	strvec_pushf(&args, "--threads=%d", cl_args.nr_threads);
-
-	*pid = mingw_spawnvpe(args.v[0], args.v, NULL, NULL, in, out, out);
-	close(in);
-	close(out);
-
-	strvec_clear(&args);
 
-	if (*pid < 0)
-		return error(_("could not spawn daemon in the background"));
-
-	return 0;
-}
-#endif
-
-/*
- * This is adapted from `wait_or_whine()`.  Watch the child process and
- * let it get started and begin listening for requests on the socket
- * before reporting our success.
- */
-static int wait_for_server_startup(pid_t pid_child)
+static int daemon__start_server(void)
 {
-	int status;
-	pid_t pid_seen;
-	enum ipc_active_state s;
-	time_t time_limit, now;
+	struct child_process cp = CHILD_PROCESS_INIT;
+	enum start_bg_result sbgr;
 
-	time(&time_limit);
-	time_limit += cl_args.max_wait_sec;
+	strvec_push(&cp.args, "test-tool");
+	strvec_push(&cp.args, "simple-ipc");
+	strvec_push(&cp.args, "run-daemon");
+	strvec_pushf(&cp.args, "--name=%s", cl_args.path);
+	strvec_pushf(&cp.args, "--threads=%d", cl_args.nr_threads);
 
-	for (;;) {
-		pid_seen = waitpid(pid_child, &status, WNOHANG);
+	cp.no_stdin = 1;
+	cp.no_stdout = 1;
+	cp.no_stderr = 1;
 
-		if (pid_seen == -1)
-			return error_errno(_("waitpid failed"));
+	sbgr = start_bg_command(&cp, bg_wait_cb, NULL, cl_args.max_wait_sec);
 
-		else if (pid_seen == 0) {
-			/*
-			 * The child is still running (this should be
-			 * the normal case).  Try to connect to it on
-			 * the socket and see if it is ready for
-			 * business.
-			 *
-			 * If there is another daemon already running,
-			 * our child will fail to start (possibly
-			 * after a timeout on the lock), but we don't
-			 * care (who responds) if the socket is live.
-			 */
-			s = ipc_get_active_state(cl_args.path);
-			if (s == IPC_STATE__LISTENING)
-				return 0;
-
-			time(&now);
-			if (now > time_limit)
-				return error(_("daemon not online yet"));
-
-			continue;
-		}
+	switch (sbgr) {
+	case SBGR_READY:
+		return 0;
 
-		else if (pid_seen == pid_child) {
-			/*
-			 * The new child daemon process shutdown while
-			 * it was starting up, so it is not listening
-			 * on the socket.
-			 *
-			 * Try to ping the socket in the odd chance
-			 * that another daemon started (or was already
-			 * running) while our child was starting.
-			 *
-			 * Again, we don't care who services the socket.
-			 */
-			s = ipc_get_active_state(cl_args.path);
-			if (s == IPC_STATE__LISTENING)
-				return 0;
+	default:
+	case SBGR_ERROR:
+	case SBGR_CB_ERROR:
+		return error("daemon failed to start");
 
-			/*
-			 * We don't care about the WEXITSTATUS() nor
-			 * any of the WIF*(status) values because
-			 * `cmd__simple_ipc()` does the `!!result`
-			 * trick on all function return values.
-			 *
-			 * So it is sufficient to just report the
-			 * early shutdown as an error.
-			 */
-			return error(_("daemon failed to start"));
-		}
+	case SBGR_TIMEOUT:
+		return error("daemon not online yet");
 
-		else
-			return error(_("waitpid is confused"));
+	case SBGR_DIED:
+		return error("daemon terminated");
 	}
 }
 
-/*
- * This process will start a simple-ipc server in a background process and
- * wait for it to become ready.  This is like `daemonize()` but gives us
- * more control and better error reporting (and makes it easier to write
- * unit tests).
- */
-static int daemon__start_server(void)
-{
-	pid_t pid_child;
-	int ret;
-
-	/*
-	 * Run the actual daemon in a background process.
-	 */
-	ret = spawn_server(&pid_child);
-	if (pid_child <= 0)
-		return ret;
-
-	/*
-	 * Let the parent wait for the child process to get started
-	 * and begin listening for requests on the socket.
-	 */
-	ret = wait_for_server_startup(pid_child);
-
-	return ret;
-}
-
 /*
  * This process will run a quick probe to see if a simple-ipc server
  * is active on this path.
-- 
gitgitgadget
