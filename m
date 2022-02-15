Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 968BAC433F5
	for <git@archiver.kernel.org>; Tue, 15 Feb 2022 16:00:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241137AbiBOQAe (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Feb 2022 11:00:34 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238585AbiBOQAR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Feb 2022 11:00:17 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83C16BDE75
        for <git@vger.kernel.org>; Tue, 15 Feb 2022 07:59:51 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id j26so22057661wrb.7
        for <git@vger.kernel.org>; Tue, 15 Feb 2022 07:59:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=xRVyFwV/KR6l0CAmUoatgRiqQpA8JXkdhfK/5H7F/hg=;
        b=F9BT6L10n5Ec0FUaTm+i/h3Mec1PvOm5U0/08vKwywKKqFWRAI7W7E/X84Gg5Bg6ii
         aOMnyF4Nlcv80T/LC09cvTALxxCRFsKeztK4axDimbvNiXWgZqWb77eA/JqMNbBAdHq+
         PVsXZunSwKKUoBMtaGGepxQZV65WPk0cjZ6+XbQ1YVtmEOCx8FWdRKbI2rPjY6tVeJfs
         XXsRIzBAoiRTC8WBUhu/ojkooF1v6MVlxWkmCOYXgsHuO5QatATVaSC0kBFajhMpXcf+
         fGXg7J7hF1mwIMmL6ys/kVvld8w5P2zw5iSngcRJTHb9L5fVxOb+AZy8r+OupdRPWg3e
         tVYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=xRVyFwV/KR6l0CAmUoatgRiqQpA8JXkdhfK/5H7F/hg=;
        b=Wul1qHpOZ/cmZXwUtA95qQjPe1TDfkVIFzkJ9OekfEplKhXoQ6LVgVaWFFt8R2fr+D
         F8khKltzpF6bPYzmO7KDWhx0ujOOhah/bVSIgov05SVkxxBI5BGcYg4zn/6MMRmMGQVq
         wD4TATLQ6pYewGqURNZZij2MkiBVVl0bew67oUegV70xeI+c8wsZHnSMCZH6Glc6tkRk
         A00Waskr69WU/5LuqTEdmUK9Acqp5LeXAHHTucxEcM6buK21ZC26gcCM3TMrxOy73oOO
         4tI/gSXuLaF+FSbVpLxfTGSFJzKsSQcy/fVzEHi6ehgL9MfuUSLsAKlg3/StbgzKnede
         K4xg==
X-Gm-Message-State: AOAM532f8SiHEfWt1DLjS72y0722pX/ocZ2DmjT4krr5XySP03KuiUqg
        84X/9MzCBkYvthLSRSDTyM66FMq5nFk=
X-Google-Smtp-Source: ABdhPJx9sPXK+faen9l9VyeXPhNzDbSj8k2/lNoHi4+PnIHwmpvVmTBPXuAjm2KGRu72qSfObUqOYQ==
X-Received: by 2002:a5d:62c4:: with SMTP id o4mr3745400wrv.319.1644940789893;
        Tue, 15 Feb 2022 07:59:49 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q13sm33716280wrd.78.2022.02.15.07.59.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Feb 2022 07:59:49 -0800 (PST)
Message-Id: <95cdff22be0b0ee6f364dfed031836ed2327cadb.1644940774.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1143.git.1644940773.gitgitgadget@gmail.com>
References: <pull.1143.git.1644940773.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 15 Feb 2022 15:59:24 +0000
Subject: [PATCH 14/23] fsmonitor--daemon: cd out of worktree root
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

Teach the fsmonitor--daemon to CD outside of the worktree
before starting up.

The common Git startup mechanism causes the CWD of the daemon process
to be in the root of the worktree.  On Windows, this causes the daemon
process to hold a locked handle on the CWD and prevents other
processes from moving or deleting the worktree while the daemon is
running.

CD to HOME before entering main event loops.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 builtin/fsmonitor--daemon.c         | 32 +++++++++++++++++++++++++++--
 compat/fsmonitor/fsm-listen-win32.c | 22 ++++++++++++++------
 fsmonitor--daemon.h                 |  1 +
 3 files changed, 47 insertions(+), 8 deletions(-)

diff --git a/builtin/fsmonitor--daemon.c b/builtin/fsmonitor--daemon.c
index dd0561cfc51..e9b3f44d791 100644
--- a/builtin/fsmonitor--daemon.c
+++ b/builtin/fsmonitor--daemon.c
@@ -1169,11 +1169,11 @@ static int fsmonitor_run_daemon_1(struct fsmonitor_daemon_state *state)
 	 * before we need it.
 	 */
 	if (ipc_server_run_async(&state->ipc_server_data,
-				 fsmonitor_ipc__get_path(), &ipc_opts,
+				 state->path_ipc.buf, &ipc_opts,
 				 handle_client, state))
 		return error_errno(
 			_("could not start IPC thread pool on '%s'"),
-			fsmonitor_ipc__get_path());
+			state->path_ipc.buf);
 
 	/*
 	 * Start the fsmonitor listener thread to collect filesystem
@@ -1208,6 +1208,7 @@ static int fsmonitor_run_daemon_1(struct fsmonitor_daemon_state *state)
 static int fsmonitor_run_daemon(void)
 {
 	struct fsmonitor_daemon_state state;
+	const char *home;
 	int err;
 
 	memset(&state, 0, sizeof(state));
@@ -1277,6 +1278,15 @@ static int fsmonitor_run_daemon(void)
 
 	strbuf_addch(&state.path_cookie_prefix, '/');
 
+	/*
+	 * We create a named-pipe or unix domain socket inside of the
+	 * ".git" directory.  (Well, on Windows, we base our named
+	 * pipe in the NPFS on the absolute path of the git
+	 * directory.)
+	 */
+	strbuf_init(&state.path_ipc, 0);
+	strbuf_addstr(&state.path_ipc, absolute_path(fsmonitor_ipc__get_path()));
+
 	/*
 	 * Confirm that we can create platform-specific resources for the
 	 * filesystem listener before we bother starting all the threads.
@@ -1286,6 +1296,23 @@ static int fsmonitor_run_daemon(void)
 		goto done;
 	}
 
+	/*
+	 * CD out of the worktree root directory.
+	 *
+	 * The common Git startup mechanism causes our CWD to be the
+	 * root of the worktree.  On Windows, this causes our process
+	 * to hold a locked handle on the CWD.  This prevents the
+	 * worktree from being moved or deleted while the daemon is
+	 * running.
+	 *
+	 * We assume that our FS and IPC listener threads have either
+	 * opened all of the handles that they need or will do
+	 * everything using absolute paths.
+	 */
+	home = getenv("HOME");
+	if (home && *home && chdir(home))
+		die_errno("could not cd home '%s'", home);
+
 	err = fsmonitor_run_daemon_1(&state);
 
 done:
@@ -1298,6 +1325,7 @@ done:
 	strbuf_release(&state.path_worktree_watch);
 	strbuf_release(&state.path_gitdir_watch);
 	strbuf_release(&state.path_cookie_prefix);
+	strbuf_release(&state.path_ipc);
 
 	/*
 	 * NEEDSWORK: Consider "rm -rf <gitdir>/<fsmonitor-dir>"
diff --git a/compat/fsmonitor/fsm-listen-win32.c b/compat/fsmonitor/fsm-listen-win32.c
index eb407b0748c..6985903c95b 100644
--- a/compat/fsmonitor/fsm-listen-win32.c
+++ b/compat/fsmonitor/fsm-listen-win32.c
@@ -398,12 +398,22 @@ static int recv_rdcw_watch(struct one_watch *watch)
 	}
 
 	/*
-	 * NEEDSWORK: If an external <gitdir> is deleted, the above
-	 * returns an error.  I'm not sure that there's anything that
-	 * we can do here other than failing -- the <worktree>/.git
-	 * link file would be broken anyway.  We might try to check
-	 * for that and return a better error message, but I'm not
-	 * sure it is worth it.
+	 * GetOverlappedResult() fails if the watched directory is
+	 * deleted while we were waiting for an overlapped IO to
+	 * complete.  The documentation did not list specific errors,
+	 * but I observed ERROR_ACCESS_DENIED (0x05) errors during
+	 * testing.
+	 *
+	 * Note that we only get notificaiton events for events
+	 * *within* the directory, not *on* the directory itself.
+	 * (These might be properies of the parent directory, for
+	 * example).
+	 *
+	 * NEEDSWORK: We might try to check for the deleted directory
+	 * case and return a better error message, but I'm not sure it
+	 * is worth it.
+	 *
+	 * Shutdown if we get any error.
 	 */
 
 	error("GetOverlappedResult failed on '%s' [GLE %ld]",
diff --git a/fsmonitor--daemon.h b/fsmonitor--daemon.h
index c16ef095688..a777c3a0590 100644
--- a/fsmonitor--daemon.h
+++ b/fsmonitor--daemon.h
@@ -54,6 +54,7 @@ struct fsmonitor_daemon_state {
 	struct fsmonitor_daemon_backend_data *backend_data;
 
 	struct ipc_server_data *ipc_server_data;
+	struct strbuf path_ipc;
 };
 
 /*
-- 
gitgitgadget

