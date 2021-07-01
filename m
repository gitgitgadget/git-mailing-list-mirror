Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2D2AC11F6C
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 14:48:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A3C16140C
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 14:48:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233016AbhGAOug (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Jul 2021 10:50:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232907AbhGAOu1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jul 2021 10:50:27 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 423C6C0613E1
        for <git@vger.kernel.org>; Thu,  1 Jul 2021 07:47:55 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id i8so8665864wrc.0
        for <git@vger.kernel.org>; Thu, 01 Jul 2021 07:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=UfZUXel1p6AOKNdy1ef02UiRKIjcEL1X8er7dQKR42M=;
        b=W0YGGiO21Mdxh1rXRTHfDs9JPCDmO559ehggERJWYfYZDVLyzjHayur2yRA4nLW4EE
         I9qDvD7+YZHME7Mv8rP1OsvhfAqxU5okvNDe440+qBlNRbJsN95PSQx9tmwGqFk289MS
         5MI3PXxbFRpNXoHWYwa4ydvmGMQeaC/+u9iUh6ajvYDhuuf46eicqvtul4zQ8GO4TalH
         g+t3K5EUIX2AeMakpr6vN4S/qH+/gR9hOSdPlm5h893cMWzgG+zAH2V/h5iOlpSrzWhJ
         muC4L57Rso+fLjDsxohkj9Scjq6X1Iita40VQhXSTDGSxmy+sT/71aFC+VU8o36/QUYB
         ze1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=UfZUXel1p6AOKNdy1ef02UiRKIjcEL1X8er7dQKR42M=;
        b=qPcZPHFe8JwBkNc9h2IeNacJpvtIRRsFyULe6g3IUD+MbSsCpYQ6ZgpP/frkFh36pg
         3UEooRn/lV0e9oa8ikKzA57YdmYmQLUsyRiVe8sBQb1v2XuYTOOZmPCGd4PKDTUQBD0c
         00uTunC8PcA8tubIl5yCkQYbz9v0kz+Uaoxc8mtgeNCS67QtvyWm032RnCdyjrf21rbw
         x9ecRwSf9nlCuzMlEw8nRJQgh+ehZOBMal/wgYEJrZTOKakBxZjc+NpTar5rNleVRsTw
         kDrACgFdj+TqxwEDGnaWwIQujFxghpfovUk9EiiyXZPDHaq8ridqGEEXEZokQmrr8Df1
         7apA==
X-Gm-Message-State: AOAM532CTgBys+FQpaQZKpil3UUlpulS4CO8XfmSY3kZP25SMsSpvk4V
        rJTLGQRvYosQpA9M4HwnyjYgkfgocB4=
X-Google-Smtp-Source: ABdhPJw2LkpQfWpv7I91AtezUZUN+HVaobQEiDFVz7y2Hh36CJo+lGtLY9xyBsAExm7fAqieiUWzLg==
X-Received: by 2002:adf:82a1:: with SMTP id 30mr2683wrc.31.1625150873805;
        Thu, 01 Jul 2021 07:47:53 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f2sm127500wrq.69.2021.07.01.07.47.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jul 2021 07:47:53 -0700 (PDT)
Message-Id: <9fe902aad87f1192705fb69ea212a2d066d0286d.1625150864.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.923.v3.git.1625150864.gitgitgadget@gmail.com>
References: <pull.923.v2.git.1621691828.gitgitgadget@gmail.com>
        <pull.923.v3.git.1625150864.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 01 Jul 2021 14:47:24 +0000
Subject: [PATCH v3 14/34] fsmonitor--daemon: implement 'start' command
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Derrick Stolee <stolee@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Implement 'git fsmonitor--daemon start' command.  This command
tries to start a daemon in the background.  It creates a background
process to run the daemon.

The updated daemon does not actually do anything yet because the
platform backends are still just stubs.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 builtin/fsmonitor--daemon.c | 208 ++++++++++++++++++++++++++++++++++++
 1 file changed, 208 insertions(+)

diff --git a/builtin/fsmonitor--daemon.c b/builtin/fsmonitor--daemon.c
index a265c962ccc..7fcf960652f 100644
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
 
@@ -256,6 +269,194 @@ static int try_to_run_foreground_daemon(void)
 	return !!fsmonitor_run_daemon();
 }
 
+#ifdef GIT_WINDOWS_NATIVE
+/*
+ * Create a background process to run the daemon.  It should be completely
+ * disassociated from the terminal.
+ *
+ * Conceptually like `daemonize()` but different because Windows does not
+ * have `fork(2)`.  Spawn a normal Windows child process but without the
+ * limitations of `start_command()` and `finish_command()`.
+ *
+ * The child process execs the "git fsmonitor--daemon run" command.
+ *
+ * The current process returns so that the caller can wait for the child
+ * to startup before exiting.
+ */
+static int spawn_background_fsmonitor_daemon(pid_t *pid)
+{
+	char git_exe[MAX_PATH];
+	struct strvec args = STRVEC_INIT;
+	int in, out;
+
+	GetModuleFileNameA(NULL, git_exe, MAX_PATH);
+
+	in = open("/dev/null", O_RDONLY);
+	out = open("/dev/null", O_WRONLY);
+
+	strvec_push(&args, git_exe);
+	strvec_push(&args, "fsmonitor--daemon");
+	strvec_push(&args, "run");
+	strvec_pushf(&args, "--ipc-threads=%d", fsmonitor__ipc_threads);
+
+	*pid = mingw_spawnvpe(args.v[0], args.v, NULL, NULL, in, out, out);
+	close(in);
+	close(out);
+
+	strvec_clear(&args);
+
+	if (*pid < 0)
+		return error(_("could not spawn fsmonitor--daemon in the background"));
+
+	return 0;
+}
+#else
+/*
+ * Create a background process to run the daemon.  It should be completely
+ * disassociated from the terminal.
+ *
+ * This is adapted from `daemonize()`.  Use `fork()` to directly
+ * create and run the daemon in the child process.
+ *
+ * The fork-child can just call the run code; it does not need to exec
+ * it.
+ *
+ * The fork-parent returns the child PID so that we can wait for the
+ * child to startup before exiting.
+ */
+static int spawn_background_fsmonitor_daemon(pid_t *pid)
+{
+	*pid = fork();
+
+	switch (*pid) {
+	case 0:
+		if (setsid() == -1)
+			error_errno(_("setsid failed"));
+		close(0);
+		close(1);
+		close(2);
+		sanitize_stdfds();
+
+		return !!fsmonitor_run_daemon();
+
+	case -1:
+		return error_errno(_("could not spawn fsmonitor--daemon in the background"));
+
+	default:
+		return 0;
+	}
+}
+#endif
+
+/*
+ * This is adapted from `wait_or_whine()`.  Watch the child process and
+ * let it get started and begin listening for requests on the socket
+ * before reporting our success.
+ */
+static int wait_for_background_startup(pid_t pid_child)
+{
+	int status;
+	pid_t pid_seen;
+	enum ipc_active_state s;
+	time_t time_limit, now;
+
+	time(&time_limit);
+	time_limit += fsmonitor__start_timeout_sec;
+
+	for (;;) {
+		pid_seen = waitpid(pid_child, &status, WNOHANG);
+
+		if (pid_seen == -1)
+			return error_errno(_("waitpid failed"));
+		else if (pid_seen == 0) {
+			/*
+			 * The child is still running (this should be
+			 * the normal case).  Try to connect to it on
+			 * the socket and see if it is ready for
+			 * business.
+			 *
+			 * If there is another daemon already running,
+			 * our child will fail to start (possibly
+			 * after a timeout on the lock), but we don't
+			 * care (who responds) if the socket is live.
+			 */
+			s = fsmonitor_ipc__get_state();
+			if (s == IPC_STATE__LISTENING)
+				return 0;
+
+			time(&now);
+			if (now > time_limit)
+				return error(_("fsmonitor--daemon not online yet"));
+		} else if (pid_seen == pid_child) {
+			/*
+			 * The new child daemon process shutdown while
+			 * it was starting up, so it is not listening
+			 * on the socket.
+			 *
+			 * Try to ping the socket in the odd chance
+			 * that another daemon started (or was already
+			 * running) while our child was starting.
+			 *
+			 * Again, we don't care who services the socket.
+			 */
+			s = fsmonitor_ipc__get_state();
+			if (s == IPC_STATE__LISTENING)
+				return 0;
+
+			/*
+			 * We don't care about the WEXITSTATUS() nor
+			 * any of the WIF*(status) values because
+			 * `cmd_fsmonitor__daemon()` does the `!!result`
+			 * trick on all function return values.
+			 *
+			 * So it is sufficient to just report the
+			 * early shutdown as an error.
+			 */
+			return error(_("fsmonitor--daemon failed to start"));
+		} else
+			return error(_("waitpid is confused"));
+	}
+}
+
+static int try_to_start_background_daemon(void)
+{
+	pid_t pid_child;
+	int ret;
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
+	/*
+	 * Run the actual daemon in a background process.
+	 */
+	ret = spawn_background_fsmonitor_daemon(&pid_child);
+	if (pid_child <= 0)
+		return ret;
+
+	/*
+	 * Wait (with timeout) for the background child process get
+	 * started and begin listening on the socket/pipe.  This makes
+	 * the "start" command more synchronous and more reliable in
+	 * tests.
+	 */
+	ret = wait_for_background_startup(pid_child);
+
+	return ret;
+}
+
 int cmd_fsmonitor__daemon(int argc, const char **argv, const char *prefix)
 {
 	const char *subcmd;
@@ -264,6 +465,10 @@ int cmd_fsmonitor__daemon(int argc, const char **argv, const char *prefix)
 		OPT_INTEGER(0, "ipc-threads",
 			    &fsmonitor__ipc_threads,
 			    N_("use <n> ipc worker threads")),
+		OPT_INTEGER(0, "start-timeout",
+			    &fsmonitor__start_timeout_sec,
+			    N_("Max seconds to wait for background daemon startup")),
+
 		OPT_END()
 	};
 
@@ -285,6 +490,9 @@ int cmd_fsmonitor__daemon(int argc, const char **argv, const char *prefix)
 		die(_("invalid 'ipc-threads' value (%d)"),
 		    fsmonitor__ipc_threads);
 
+	if (!strcmp(subcmd, "start"))
+		return !!try_to_start_background_daemon();
+
 	if (!strcmp(subcmd, "run"))
 		return !!try_to_run_foreground_daemon();
 
-- 
gitgitgadget

