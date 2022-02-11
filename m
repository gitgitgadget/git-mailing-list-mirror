Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F401CC433F5
	for <git@archiver.kernel.org>; Fri, 11 Feb 2022 20:57:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353589AbiBKU5H (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Feb 2022 15:57:07 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353528AbiBKU4d (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Feb 2022 15:56:33 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CAA4D4F
        for <git@vger.kernel.org>; Fri, 11 Feb 2022 12:56:31 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id k1so17171825wrd.8
        for <git@vger.kernel.org>; Fri, 11 Feb 2022 12:56:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=7tZJjMAc3V/rH8V47Q4W4BdmV4UxbZzHrR96wmhnFh4=;
        b=KbbbIGDJbotZNR2tD/jafnpS+CWQMrtYUGZ1TAv+KoxwUz6l5DC0YwsfTcGPa0OzrR
         l+qjLXy95ciPCG64XY9dZYmvi7+ZspaEaxcb0uNqny/Ei3dP9Ta3eqsYPNlu8A4rwfxf
         X2axPB4IbGrXjyQEkb/LSMDJLycPD4JvdXdBOUIA7YzI0SwdulYFOcT4HELDHpXDtq1V
         7uahG9wn+An7Ky+cYtLNaR6BwsRS5vW9/hh5BNhjl/b3nrvO01IcoYUMAacxsxtvJg7J
         lHHoq2mbRX3VRx2/QgawkVRbBsh8a6eMNAm08Bhg7CdZnmihvuHLgH3PEqhK+bbr5PSl
         LVUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=7tZJjMAc3V/rH8V47Q4W4BdmV4UxbZzHrR96wmhnFh4=;
        b=efO/5TWA4t3JAhbY07ULdLIHPBGOgp4XKL6+2bpWNlEZ79TgHi5bkybGjMNHW3n6Ke
         Su3JHiaWNHhXfcDbs5I3QKvYCQfXdenm2t2F5DZuSlAm9ZDmXSyIP/hMNx03N3ga9yAp
         flDdDF51Euy7sr/iRWo76oXwDepyigzy1c+raYsUbzuSRIluNDWsM+XQAQYLaF1cWHi0
         JhNk2h1dADhkpd0oeF/vEjbpwuAUxq4oH78ob5ME5exp9VfrilQW1dZlGUPgwx1XBIGZ
         1bJ0r564QNCCpQZswu23FOqnTYlWEmV2tlYwdytiMvdQrE6vUHFWs1MCrSH6Z18VfdIq
         MmIw==
X-Gm-Message-State: AOAM532DB82T0VKrVzHmq9C8yjuv+qVjG77Tpqtiok9PbRDXfr1uXYrg
        jNrFoHJpTTeiwZaFm3+VKaqqisrQeGU=
X-Google-Smtp-Source: ABdhPJzxQCDqmNFq5jUzQl18uowb4B4fNiec/52oxGnPIopFFby/znv78uMhwacnkkT8NmpHT0M3cg==
X-Received: by 2002:adf:d1c9:: with SMTP id b9mr2711556wrd.142.1644612989977;
        Fri, 11 Feb 2022 12:56:29 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b15sm17311658wri.96.2022.02.11.12.56.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Feb 2022 12:56:29 -0800 (PST)
Message-Id: <69fc0998286cbc791f199710a68a2028080e1632.1644612979.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1041.v5.git.1644612979.gitgitgadget@gmail.com>
References: <pull.1041.v4.git.1634826309.gitgitgadget@gmail.com>
        <pull.1041.v5.git.1644612979.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 11 Feb 2022 20:56:00 +0000
Subject: [PATCH v5 11/30] fsmonitor--daemon: implement 'start' command
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Jeff Hostetler <git@jeffhostetler.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Implement 'git fsmonitor--daemon start' command.  This command starts
an instance of 'git fsmonitor--daemon run' in the background using
the new 'start_bg_command()' function.

We avoid the fork-and-call technique on Unix systems in favor of a
fork-and-exec technique.  This gives us more uniform Trace2 child-*
events.  It also makes our usage more consistent with Windows usage.

On Windows, teach 'git fsmonitor--daemon run' to optionally call
'FreeConsole()' to release handles to the inherited Win32 console
(despite being passed invalid handles for stdin/out/err).  Without
this, command prompts and powershell terminal windows could hang
in "exit" until the last background child process exited or released
their Win32 console handle.  (This was not seen with git-bash shells
because they don't have a Win32 console attached to them.)

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 builtin/fsmonitor--daemon.c | 107 +++++++++++++++++++++++++++++++++++-
 1 file changed, 105 insertions(+), 2 deletions(-)

diff --git a/builtin/fsmonitor--daemon.c b/builtin/fsmonitor--daemon.c
index b5ebd1eca33..8988440b7c1 100644
--- a/builtin/fsmonitor--daemon.c
+++ b/builtin/fsmonitor--daemon.c
@@ -9,6 +9,7 @@
 #include "khash.h"
 
 static const char * const builtin_fsmonitor__daemon_usage[] = {
+	N_("git fsmonitor--daemon start [<options>]"),
 	N_("git fsmonitor--daemon run [<options>]"),
 	N_("git fsmonitor--daemon stop"),
 	N_("git fsmonitor--daemon status"),
@@ -22,6 +23,9 @@ static const char * const builtin_fsmonitor__daemon_usage[] = {
 #define FSMONITOR__IPC_THREADS "fsmonitor.ipcthreads"
 static int fsmonitor__ipc_threads = 8;
 
+#define FSMONITOR__START_TIMEOUT "fsmonitor.starttimeout"
+static int fsmonitor__start_timeout_sec = 60;
+
 static int fsmonitor_config(const char *var, const char *value, void *cb)
 {
 	if (!strcmp(var, FSMONITOR__IPC_THREADS)) {
@@ -33,6 +37,15 @@ static int fsmonitor_config(const char *var, const char *value, void *cb)
 		return 0;
 	}
 
+	if (!strcmp(var, FSMONITOR__START_TIMEOUT)) {
+		int i = git_config_int(var, value);
+		if (i < 0)
+			return error(_("value of '%s' out of range: %d"),
+				     FSMONITOR__START_TIMEOUT, i);
+		fsmonitor__start_timeout_sec = i;
+		return 0;
+	}
+
 	return git_default_config(var, value, cb);
 }
 
@@ -237,7 +250,7 @@ done:
 	return err;
 }
 
-static int try_to_run_foreground_daemon(void)
+static int try_to_run_foreground_daemon(int free_console)
 {
 	/*
 	 * Technically, we don't need to probe for an existing daemon
@@ -255,17 +268,104 @@ static int try_to_run_foreground_daemon(void)
 	       the_repository->worktree);
 	fflush(stdout);
 
+#ifdef GIT_WINDOWS_NATIVE
+	if (free_console)
+		FreeConsole();
+#endif
+
 	return !!fsmonitor_run_daemon();
 }
 
+static start_bg_wait_cb bg_wait_cb;
+
+static int bg_wait_cb(const struct child_process *cp, void *cb_data)
+{
+	enum ipc_active_state s = fsmonitor_ipc__get_state();
+
+	switch (s) {
+	case IPC_STATE__LISTENING:
+		/* child is "ready" */
+		return 0;
+
+	case IPC_STATE__NOT_LISTENING:
+	case IPC_STATE__PATH_NOT_FOUND:
+		/* give child more time */
+		return 1;
+
+	default:
+	case IPC_STATE__INVALID_PATH:
+	case IPC_STATE__OTHER_ERROR:
+		/* all the time in world won't help */
+		return -1;
+	}
+}
+
+static int try_to_start_background_daemon(void)
+{
+	struct child_process cp = CHILD_PROCESS_INIT;
+	enum start_bg_result sbgr;
+
+	/*
+	 * Before we try to create a background daemon process, see
+	 * if a daemon process is already listening.  This makes it
+	 * easier for us to report an already-listening error to the
+	 * console, since our spawn/daemon can only report the success
+	 * of creating the background process (and not whether it
+	 * immediately exited).
+	 */
+	if (fsmonitor_ipc__get_state() == IPC_STATE__LISTENING)
+		die("fsmonitor--daemon is already running '%s'",
+		    the_repository->worktree);
+
+	printf(_("starting fsmonitor-daemon in '%s'\n"),
+	       the_repository->worktree);
+	fflush(stdout);
+
+	cp.git_cmd = 1;
+
+	strvec_push(&cp.args, "fsmonitor--daemon");
+	strvec_push(&cp.args, "run");
+	strvec_push(&cp.args, "--free-console");
+	strvec_pushf(&cp.args, "--ipc-threads=%d", fsmonitor__ipc_threads);
+
+	cp.no_stdin = 1;
+	cp.no_stdout = 1;
+	cp.no_stderr = 1;
+
+	sbgr = start_bg_command(&cp, bg_wait_cb, NULL,
+				fsmonitor__start_timeout_sec);
+
+	switch (sbgr) {
+	case SBGR_READY:
+		return 0;
+
+	default:
+	case SBGR_ERROR:
+	case SBGR_CB_ERROR:
+		return error("daemon failed to start");
+
+	case SBGR_TIMEOUT:
+		return error("daemon not online yet");
+
+	case SBGR_DIED:
+		return error("daemon terminated");
+	}
+}
+
 int cmd_fsmonitor__daemon(int argc, const char **argv, const char *prefix)
 {
 	const char *subcmd;
+	int free_console = 0;
 
 	struct option options[] = {
+		OPT_BOOL(0, "free-console", &free_console, N_("free console")),
 		OPT_INTEGER(0, "ipc-threads",
 			    &fsmonitor__ipc_threads,
 			    N_("use <n> ipc worker threads")),
+		OPT_INTEGER(0, "start-timeout",
+			    &fsmonitor__start_timeout_sec,
+			    N_("Max seconds to wait for background daemon startup")),
+
 		OPT_END()
 	};
 
@@ -281,8 +381,11 @@ int cmd_fsmonitor__daemon(int argc, const char **argv, const char *prefix)
 		die(_("invalid 'ipc-threads' value (%d)"),
 		    fsmonitor__ipc_threads);
 
+	if (!strcmp(subcmd, "start"))
+		return !!try_to_start_background_daemon();
+
 	if (!strcmp(subcmd, "run"))
-		return !!try_to_run_foreground_daemon();
+		return !!try_to_run_foreground_daemon(free_console);
 
 	if (!strcmp(subcmd, "stop"))
 		return !!do_as_client__send_stop();
-- 
gitgitgadget

