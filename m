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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6571DC11F64
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 14:48:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38CEE6140C
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 14:48:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233003AbhGAOud (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Jul 2021 10:50:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232549AbhGAOu0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jul 2021 10:50:26 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0092C0613DF
        for <git@vger.kernel.org>; Thu,  1 Jul 2021 07:47:54 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id u8-20020a7bcb080000b02901e44e9caa2aso4264384wmj.4
        for <git@vger.kernel.org>; Thu, 01 Jul 2021 07:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=c4fuWBjV9jcEFHts8GQw8jpbOZtgaVEZ32qooQ+Shso=;
        b=E5XP3PylFfNqQjpceRBweEHE0CxwO8p0ZtZ87VzlhLVhov+HGPXz6Bq11EEHqLpDki
         8fdq6HcnT9N5uuHwpWsUyb8BhrMyiD6Jyn72K62he+0sULbzjAFCGsPi641bm2XqZsRc
         1jrMdpRjTmHtjbpsnWK6AYtWlmOt/WrC932PX24vw7vJG/iFv4oZ5gT8yQ2nWQuHQa3G
         Y0olZ791BDosic4D49PXDcnl8/X4QRenmhiO12FAtsS6JQo+NjJkL9y19kLBgKdIU8iq
         nFUjLv9jFZ0bbExA76Ng3FclkeONKp41YpmxsFgGPr3ZAF4qlbB4bjJYWApjEletgfUZ
         PLUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=c4fuWBjV9jcEFHts8GQw8jpbOZtgaVEZ32qooQ+Shso=;
        b=q+P/RqsZhRu3S4PUUeEkyPeXx0zv0JQfBOrVKYjntNoAFFuxhUzI5j1GO1K3mURHXo
         WztCkLL2LeUZHBtljmdGj36mqJJL/8NEhNJf+LdFPTVpA/8tVe64O1Oz+tXjxDsJGzyY
         w+e8+uYMo9s/VWnffgvazfaWeVk7+svkwl2NzYf9olIaOlhbu9MLm9FrO4p1Lcy94Pm+
         15Wr+vUQDDluQ3C7qsHz8P51kz22IfOeou8jSz8DjtR445+8Z6Xqv58u4yjhrtpCELNF
         eT+TyE+pyL+q0e5vrd2DKwGXGn/FyucoJ4y1dY68dpIEzDyiNRXj1cvRa8DSOJ660+Pj
         bX7g==
X-Gm-Message-State: AOAM531SGt4jiK52oz/eB40uNtfC+QN6fW/isnxUM1FNIoUWdu05JLTe
        lK8FJmgJXUvEsbnxIUY9zW9fBykebUI=
X-Google-Smtp-Source: ABdhPJyaRDhs+Yp6/1wIj+7cOC3AYu8pxs4XIhcPeKNys2II/8Eo85EvAkHXPul5PV3sZ9EHxtOcCQ==
X-Received: by 2002:a05:600c:4f53:: with SMTP id m19mr131292wmq.36.1625150873245;
        Thu, 01 Jul 2021 07:47:53 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n18sm4783282wms.3.2021.07.01.07.47.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jul 2021 07:47:52 -0700 (PDT)
Message-Id: <5d6646df93a17659af66f136295444d1bd834090.1625150864.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.923.v3.git.1625150864.gitgitgadget@gmail.com>
References: <pull.923.v2.git.1621691828.gitgitgadget@gmail.com>
        <pull.923.v3.git.1625150864.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 01 Jul 2021 14:47:23 +0000
Subject: [PATCH v3 13/34] fsmonitor--daemon: implement 'run' command
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

Implement `run` command to try to begin listening for file system events.

This version defines the thread structure with a single fsmonitor_fs_listen
thread to watch for file system events and a simple IPC thread pool to
watch for connection from Git clients over a well-known named pipe or
Unix domain socket.

This commit does not actually do anything yet because the platform
backends are still just stubs.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 builtin/fsmonitor--daemon.c | 210 +++++++++++++++++++++++++++++++++++-
 fsmonitor--daemon.h         |  34 ++++++
 2 files changed, 243 insertions(+), 1 deletion(-)
 create mode 100644 fsmonitor--daemon.h

diff --git a/builtin/fsmonitor--daemon.c b/builtin/fsmonitor--daemon.c
index 62efd5ea787..a265c962ccc 100644
--- a/builtin/fsmonitor--daemon.c
+++ b/builtin/fsmonitor--daemon.c
@@ -3,16 +3,39 @@
 #include "parse-options.h"
 #include "fsmonitor.h"
 #include "fsmonitor-ipc.h"
+#include "compat/fsmonitor/fsmonitor-fs-listen.h"
+#include "fsmonitor--daemon.h"
 #include "simple-ipc.h"
 #include "khash.h"
 
 static const char * const builtin_fsmonitor__daemon_usage[] = {
+	N_("git fsmonitor--daemon run [<options>]"),
 	N_("git fsmonitor--daemon stop"),
 	N_("git fsmonitor--daemon status"),
 	NULL
 };
 
 #ifdef HAVE_FSMONITOR_DAEMON_BACKEND
+/*
+ * Global state loaded from config.
+ */
+#define FSMONITOR__IPC_THREADS "fsmonitor.ipcthreads"
+static int fsmonitor__ipc_threads = 8;
+
+static int fsmonitor_config(const char *var, const char *value, void *cb)
+{
+	if (!strcmp(var, FSMONITOR__IPC_THREADS)) {
+		int i = git_config_int(var, value);
+		if (i < 1)
+			return error(_("value of '%s' out of range: %d"),
+				     FSMONITOR__IPC_THREADS, i);
+		fsmonitor__ipc_threads = i;
+		return 0;
+	}
+
+	return git_default_config(var, value, cb);
+}
+
 /*
  * Acting as a CLIENT.
  *
@@ -57,11 +80,190 @@ static int do_as_client__status(void)
 	}
 }
 
+static ipc_server_application_cb handle_client;
+
+static int handle_client(void *data,
+			 const char *command, size_t command_len,
+			 ipc_server_reply_cb *reply,
+			 struct ipc_server_reply_data *reply_data)
+{
+	/* struct fsmonitor_daemon_state *state = data; */
+	int result;
+
+	/*
+	 * The Simple IPC API now supports {char*, len} arguments, but
+	 * FSMonitor always uses proper null-terminated strings, so
+	 * we can ignore the command_len argument.  (Trust, but verify.)
+	 */
+	if (command_len != strlen(command))
+		BUG("FSMonitor assumes text messages");
+
+	trace2_region_enter("fsmonitor", "handle_client", the_repository);
+	trace2_data_string("fsmonitor", the_repository, "request", command);
+
+	result = 0; /* TODO Do something here. */
+
+	trace2_region_leave("fsmonitor", "handle_client", the_repository);
+
+	return result;
+}
+
+static void *fsmonitor_fs_listen__thread_proc(void *_state)
+{
+	struct fsmonitor_daemon_state *state = _state;
+
+	trace2_thread_start("fsm-listen");
+
+	trace_printf_key(&trace_fsmonitor, "Watching: worktree '%s'",
+			 state->path_worktree_watch.buf);
+	if (state->nr_paths_watching > 1)
+		trace_printf_key(&trace_fsmonitor, "Watching: gitdir '%s'",
+				 state->path_gitdir_watch.buf);
+
+	fsmonitor_fs_listen__loop(state);
+
+	trace2_thread_exit();
+	return NULL;
+}
+
+static int fsmonitor_run_daemon_1(struct fsmonitor_daemon_state *state)
+{
+	struct ipc_server_opts ipc_opts = {
+		.nr_threads = fsmonitor__ipc_threads,
+
+		/*
+		 * We know that there are no other active threads yet,
+		 * so we can let the IPC layer temporarily chdir() if
+		 * it needs to when creating the server side of the
+		 * Unix domain socket.
+		 */
+		.uds_disallow_chdir = 0
+	};
+
+	/*
+	 * Start the IPC thread pool before the we've started the file
+	 * system event listener thread so that we have the IPC handle
+	 * before we need it.
+	 */
+	if (ipc_server_run_async(&state->ipc_server_data,
+				 fsmonitor_ipc__get_path(), &ipc_opts,
+				 handle_client, state))
+		return error(_("could not start IPC thread pool"));
+
+	/*
+	 * Start the fsmonitor listener thread to collect filesystem
+	 * events.
+	 */
+	if (pthread_create(&state->listener_thread, NULL,
+			   fsmonitor_fs_listen__thread_proc, state) < 0) {
+		ipc_server_stop_async(state->ipc_server_data);
+		ipc_server_await(state->ipc_server_data);
+
+		return error(_("could not start fsmonitor listener thread"));
+	}
+
+	/*
+	 * The daemon is now fully functional in background threads.
+	 * Wait for the IPC thread pool to shutdown (whether by client
+	 * request or from filesystem activity).
+	 */
+	ipc_server_await(state->ipc_server_data);
+
+	/*
+	 * The fsmonitor listener thread may have received a shutdown
+	 * event from the IPC thread pool, but it doesn't hurt to tell
+	 * it again.  And wait for it to shutdown.
+	 */
+	fsmonitor_fs_listen__stop_async(state);
+	pthread_join(state->listener_thread, NULL);
+
+	return state->error_code;
+}
+
+static int fsmonitor_run_daemon(void)
+{
+	struct fsmonitor_daemon_state state;
+	int err;
+
+	memset(&state, 0, sizeof(state));
+
+	pthread_mutex_init(&state.main_lock, NULL);
+	state.error_code = 0;
+	state.current_token_data = NULL;
+
+	/* Prepare to (recursively) watch the <worktree-root> directory. */
+	strbuf_init(&state.path_worktree_watch, 0);
+	strbuf_addstr(&state.path_worktree_watch, absolute_path(get_git_work_tree()));
+	state.nr_paths_watching = 1;
+
+	/*
+	 * We create and delete cookie files somewhere inside the .git
+	 * directory to help us keep sync with the file system.  If
+	 * ".git" is not a directory, then <gitdir> is not inside the
+	 * cone of <worktree-root>, so set up a second watch to watch
+	 * the <gitdir> so that we get events for the cookie files.
+	 */
+	strbuf_init(&state.path_gitdir_watch, 0);
+	strbuf_addbuf(&state.path_gitdir_watch, &state.path_worktree_watch);
+	strbuf_addstr(&state.path_gitdir_watch, "/.git");
+	if (!is_directory(state.path_gitdir_watch.buf)) {
+		strbuf_reset(&state.path_gitdir_watch);
+		strbuf_addstr(&state.path_gitdir_watch, absolute_path(get_git_dir()));
+		state.nr_paths_watching = 2;
+	}
+
+	/*
+	 * Confirm that we can create platform-specific resources for the
+	 * filesystem listener before we bother starting all the threads.
+	 */
+	if (fsmonitor_fs_listen__ctor(&state)) {
+		err = error(_("could not initialize listener thread"));
+		goto done;
+	}
+
+	err = fsmonitor_run_daemon_1(&state);
+
+done:
+	pthread_mutex_destroy(&state.main_lock);
+	fsmonitor_fs_listen__dtor(&state);
+
+	ipc_server_free(state.ipc_server_data);
+
+	strbuf_release(&state.path_worktree_watch);
+	strbuf_release(&state.path_gitdir_watch);
+
+	return err;
+}
+
+static int try_to_run_foreground_daemon(void)
+{
+	/*
+	 * Technically, we don't need to probe for an existing daemon
+	 * process, since we could just call `fsmonitor_run_daemon()`
+	 * and let it fail if the pipe/socket is busy.
+	 *
+	 * However, this method gives us a nicer error message for a
+	 * common error case.
+	 */
+	if (fsmonitor_ipc__get_state() == IPC_STATE__LISTENING)
+		die("fsmonitor--daemon is already running '%s'",
+		    the_repository->worktree);
+
+	printf(_("running fsmonitor-daemon in '%s'\n"),
+	       the_repository->worktree);
+	fflush(stdout);
+
+	return !!fsmonitor_run_daemon();
+}
+
 int cmd_fsmonitor__daemon(int argc, const char **argv, const char *prefix)
 {
 	const char *subcmd;
 
 	struct option options[] = {
+		OPT_INTEGER(0, "ipc-threads",
+			    &fsmonitor__ipc_threads,
+			    N_("use <n> ipc worker threads")),
 		OPT_END()
 	};
 
@@ -71,7 +273,7 @@ int cmd_fsmonitor__daemon(int argc, const char **argv, const char *prefix)
 	if (argc == 2 && !strcmp(argv[1], "-h"))
 		usage_with_options(builtin_fsmonitor__daemon_usage, options);
 
-	git_config(git_default_config, NULL);
+	git_config(fsmonitor_config, NULL);
 
 	subcmd = argv[1];
 	argv--;
@@ -79,6 +281,12 @@ int cmd_fsmonitor__daemon(int argc, const char **argv, const char *prefix)
 
 	argc = parse_options(argc, argv, prefix, options,
 			     builtin_fsmonitor__daemon_usage, 0);
+	if (fsmonitor__ipc_threads < 1)
+		die(_("invalid 'ipc-threads' value (%d)"),
+		    fsmonitor__ipc_threads);
+
+	if (!strcmp(subcmd, "run"))
+		return !!try_to_run_foreground_daemon();
 
 	if (!strcmp(subcmd, "stop"))
 		return !!do_as_client__send_stop();
diff --git a/fsmonitor--daemon.h b/fsmonitor--daemon.h
new file mode 100644
index 00000000000..3009c1a83de
--- /dev/null
+++ b/fsmonitor--daemon.h
@@ -0,0 +1,34 @@
+#ifndef FSMONITOR_DAEMON_H
+#define FSMONITOR_DAEMON_H
+
+#ifdef HAVE_FSMONITOR_DAEMON_BACKEND
+
+#include "cache.h"
+#include "dir.h"
+#include "run-command.h"
+#include "simple-ipc.h"
+#include "thread-utils.h"
+
+struct fsmonitor_batch;
+struct fsmonitor_token_data;
+
+struct fsmonitor_daemon_backend_data; /* opaque platform-specific data */
+
+struct fsmonitor_daemon_state {
+	pthread_t listener_thread;
+	pthread_mutex_t main_lock;
+
+	struct strbuf path_worktree_watch;
+	struct strbuf path_gitdir_watch;
+	int nr_paths_watching;
+
+	struct fsmonitor_token_data *current_token_data;
+
+	int error_code;
+	struct fsmonitor_daemon_backend_data *backend_data;
+
+	struct ipc_server_data *ipc_server_data;
+};
+
+#endif /* HAVE_FSMONITOR_DAEMON_BACKEND */
+#endif /* FSMONITOR_DAEMON_H */
-- 
gitgitgadget

