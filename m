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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E18A7C43462
	for <git@archiver.kernel.org>; Thu,  1 Apr 2021 18:04:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B581361001
	for <git@archiver.kernel.org>; Thu,  1 Apr 2021 18:04:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237671AbhDASEG (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Apr 2021 14:04:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237012AbhDAR7U (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Apr 2021 13:59:20 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72F90C02D543
        for <git@vger.kernel.org>; Thu,  1 Apr 2021 08:41:17 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id r10-20020a05600c35cab029010c946c95easo1125316wmq.4
        for <git@vger.kernel.org>; Thu, 01 Apr 2021 08:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=pShdBCkC3E4HzgZsf0TnBiqhjkrMoEvuj5pmqjUft8s=;
        b=LE2rNy3a4hG6yDWCvq06AfMfQMeW7pbVJGffoiyFi1aX59sJF04IYLiZTO2RO+uGH/
         7UwbBycOSC+oOjPZEntdyaXPR8Pb+gscaMKP8nlCimSznOLN81E1GCj+f02Qxp4BK472
         2XQp8wEdMkwuWDWNoxG0XMkfOCozo/sBJfOJwS/ms5pz+I5BomtpgHB+iUgjSjHo2IYW
         00QiGzbtlNpbFQ/s/i+OW/5vWDEPtXVgqAf99mZZbbpcTlcVwaM+UuO2g3BUmQVHWyC8
         /YG6ymcnhaUOwmdQSDFzwyzzDbGKlrGPohdI9ALBhbfuPK3n0pAUOCjgNxEnJYtgTL/a
         XhSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=pShdBCkC3E4HzgZsf0TnBiqhjkrMoEvuj5pmqjUft8s=;
        b=lZCAoqgyJiBBcM/WsK7jfZelsnb7QWTenH5/iyQVzTEjFDis91qvkKepq4F8y1Svw3
         HeRpL5CACuw0+EN1KmOFcfKynpD7U1C0WK9GwuQmOsz45Y5Gqfkq39Fr1XidXPirjGgE
         oY35M/Ca/SVnFDrBErWDAGn8z5gbFyZGI6FJLzHWVuuBUFj4oTW6Tcl7hLkXgS22s/kw
         cTUOaTegUL8kibQavsDgRmj7nx8lm0ThFFbXvF0qcTUgUoAlPu/caiJ2OCcChhoCK3b8
         Km82m2TbeE2DssYTQjYKIh0zQANHNexmuKEuhVgatFY+M44K0FJcH7xTPmLHYDyY/9sC
         GrUw==
X-Gm-Message-State: AOAM531LI1Ph0Fj7j3SP3fTLVRQbvCP/BYw+Qq+bva2ZOVO/PBDyDhzt
        NLwUnUtBDY3l82ixwe0Mxj3HzKNPpQE=
X-Google-Smtp-Source: ABdhPJzNl6AoR9bOAxzeTFPgVFdDuKGW+YJi9eUjV1Yj63sF83v+inCqBhMEbIgOu8I+u0QyoOaEHA==
X-Received: by 2002:a7b:c047:: with SMTP id u7mr8765854wmc.98.1617291676155;
        Thu, 01 Apr 2021 08:41:16 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h9sm8797603wmb.35.2021.04.01.08.41.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Apr 2021 08:41:15 -0700 (PDT)
Message-Id: <a57ddb3bc7cc2de9a48472c4faff32ef46132f73.1617291666.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.923.git.1617291666.gitgitgadget@gmail.com>
References: <pull.923.git.1617291666.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 01 Apr 2021 15:40:55 +0000
Subject: [PATCH 13/23] fsmonitor-fs-listen-win32: implement FSMonitor backend
 on Windows
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

Teach the win32 backend to register a watch on the working tree
root directory (recursively).  Also watch the <gitdir> if it is
not inside the working tree.  And to collect path change notifications
into batches and publish.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 compat/fsmonitor/fsmonitor-fs-listen-win32.c | 493 +++++++++++++++++++
 1 file changed, 493 insertions(+)

diff --git a/compat/fsmonitor/fsmonitor-fs-listen-win32.c b/compat/fsmonitor/fsmonitor-fs-listen-win32.c
index 880446b49e35..2f1fcf85a0a4 100644
--- a/compat/fsmonitor/fsmonitor-fs-listen-win32.c
+++ b/compat/fsmonitor/fsmonitor-fs-listen-win32.c
@@ -2,20 +2,513 @@
 #include "config.h"
 #include "fsmonitor.h"
 #include "fsmonitor-fs-listen.h"
+#include "fsmonitor--daemon.h"
+
+/*
+ * The documentation of ReadDirectoryChangesW() states that the maximum
+ * buffer size is 64K when the monitored directory is remote.
+ *
+ * Larger buffers may be used when the monitored directory is local and
+ * will help us receive events faster from the kernel and avoid dropped
+ * events.
+ *
+ * So we try to use a very large buffer and silently fallback to 64K if
+ * we get an error.
+ */
+#define MAX_RDCW_BUF_FALLBACK (65536)
+#define MAX_RDCW_BUF          (65536 * 8)
+
+struct one_watch
+{
+	char buffer[MAX_RDCW_BUF];
+	DWORD buf_len;
+	DWORD count;
+
+	struct strbuf path;
+	HANDLE hDir;
+	HANDLE hEvent;
+	OVERLAPPED overlapped;
+
+	/*
+	 * Is there an active ReadDirectoryChangesW() call pending.  If so, we
+	 * need to later call GetOverlappedResult() and possibly CancelIoEx().
+	 */
+	BOOL is_active;
+};
+
+struct fsmonitor_daemon_backend_data
+{
+	struct one_watch *watch_worktree;
+	struct one_watch *watch_gitdir;
+
+	HANDLE hEventShutdown;
+
+	HANDLE hListener[3]; /* we don't own these handles */
+#define LISTENER_SHUTDOWN 0
+#define LISTENER_HAVE_DATA_WORKTREE 1
+#define LISTENER_HAVE_DATA_GITDIR 2
+	int nr_listener_handles;
+};
+
+/*
+ * Convert the WCHAR path from the notification into UTF8 and
+ * then normalize it.
+ */
+static int normalize_path_in_utf8(FILE_NOTIFY_INFORMATION *info,
+				  struct strbuf *normalized_path)
+{
+	int reserve;
+	int len = 0;
+
+	strbuf_reset(normalized_path);
+	if (!info->FileNameLength)
+		goto normalize;
+
+	/*
+	 * Pre-reserve enough space in the UTF8 buffer for
+	 * each Unicode WCHAR character to be mapped into a
+	 * sequence of 2 UTF8 characters.  That should let us
+	 * avoid ERROR_INSUFFICIENT_BUFFER 99.9+% of the time.
+	 */
+	reserve = info->FileNameLength + 1;
+	strbuf_grow(normalized_path, reserve);
+
+	for (;;) {
+		len = WideCharToMultiByte(CP_UTF8, 0, info->FileName,
+					  info->FileNameLength / sizeof(WCHAR),
+					  normalized_path->buf,
+					  strbuf_avail(normalized_path) - 1,
+					  NULL, NULL);
+		if (len > 0)
+			goto normalize;
+		if (GetLastError() != ERROR_INSUFFICIENT_BUFFER) {
+			error("[GLE %ld] could not convert path to UTF-8: '%.*ls'",
+			      GetLastError(),
+			      (int)(info->FileNameLength / sizeof(WCHAR)),
+			      info->FileName);
+			return -1;
+		}
+
+		strbuf_grow(normalized_path,
+			    strbuf_avail(normalized_path) + reserve);
+	}
+
+normalize:
+	strbuf_setlen(normalized_path, len);
+	return strbuf_normalize_path(normalized_path);
+}
 
 void fsmonitor_fs_listen__stop_async(struct fsmonitor_daemon_state *state)
 {
+	SetEvent(state->backend_data->hListener[LISTENER_SHUTDOWN]);
+}
+
+static struct one_watch *create_watch(struct fsmonitor_daemon_state *state,
+				      const char *path)
+{
+	struct one_watch *watch = NULL;
+	DWORD desired_access = FILE_LIST_DIRECTORY;
+	DWORD share_mode =
+		FILE_SHARE_WRITE | FILE_SHARE_READ | FILE_SHARE_DELETE;
+	HANDLE hDir;
+
+	hDir = CreateFileA(path,
+			   desired_access, share_mode, NULL, OPEN_EXISTING,
+			   FILE_FLAG_BACKUP_SEMANTICS | FILE_FLAG_OVERLAPPED,
+			   NULL);
+	if (hDir == INVALID_HANDLE_VALUE) {
+		error(_("[GLE %ld] could not watch '%s'"),
+		      GetLastError(), path);
+		return NULL;
+	}
+
+	watch = xcalloc(1, sizeof(*watch));
+
+	watch->buf_len = sizeof(watch->buffer); /* assume full MAX_RDCW_BUF */
+
+	strbuf_init(&watch->path, 0);
+	strbuf_addstr(&watch->path, path);
+
+	watch->hDir = hDir;
+	watch->hEvent = CreateEvent(NULL, TRUE, FALSE, NULL);
+
+	return watch;
+}
+
+static void destroy_watch(struct one_watch *watch)
+{
+	if (!watch)
+		return;
+
+	strbuf_release(&watch->path);
+	if (watch->hDir != INVALID_HANDLE_VALUE)
+		CloseHandle(watch->hDir);
+	if (watch->hEvent != INVALID_HANDLE_VALUE)
+		CloseHandle(watch->hEvent);
+
+	free(watch);
+}
+
+static int start_rdcw_watch(struct fsmonitor_daemon_backend_data *data,
+			    struct one_watch *watch)
+{
+	DWORD dwNotifyFilter =
+		FILE_NOTIFY_CHANGE_FILE_NAME |
+		FILE_NOTIFY_CHANGE_DIR_NAME |
+		FILE_NOTIFY_CHANGE_ATTRIBUTES |
+		FILE_NOTIFY_CHANGE_SIZE |
+		FILE_NOTIFY_CHANGE_LAST_WRITE |
+		FILE_NOTIFY_CHANGE_CREATION;
+
+	ResetEvent(watch->hEvent);
+
+	memset(&watch->overlapped, 0, sizeof(watch->overlapped));
+	watch->overlapped.hEvent = watch->hEvent;
+
+start_watch:
+	watch->is_active = ReadDirectoryChangesW(
+		watch->hDir, watch->buffer, watch->buf_len, TRUE,
+		dwNotifyFilter, &watch->count, &watch->overlapped, NULL);
+
+	if (!watch->is_active &&
+	    GetLastError() == ERROR_INVALID_PARAMETER &&
+	    watch->buf_len > MAX_RDCW_BUF_FALLBACK) {
+		watch->buf_len = MAX_RDCW_BUF_FALLBACK;
+		goto start_watch;
+	}
+
+	if (watch->is_active)
+		return 0;
+
+	error("ReadDirectoryChangedW failed on '%s' [GLE %ld]",
+	      watch->path.buf, GetLastError());
+	return -1;
+}
+
+static int recv_rdcw_watch(struct one_watch *watch)
+{
+	watch->is_active = FALSE;
+
+	if (GetOverlappedResult(watch->hDir, &watch->overlapped, &watch->count,
+				TRUE))
+		return 0;
+
+	// TODO If an external <gitdir> is deleted, the above returns an error.
+	// TODO I'm not sure that there's anything that we can do here other
+	// TODO than failing -- the <worktree>/.git link file would be broken
+	// TODO anyway.  We might try to check for that and return a better
+	// TODO error message.
+
+	error("GetOverlappedResult failed on '%s' [GLE %ld]",
+	      watch->path.buf, GetLastError());
+	return -1;
+}
+
+static void cancel_rdcw_watch(struct one_watch *watch)
+{
+	DWORD count;
+
+	if (!watch || !watch->is_active)
+		return;
+
+	CancelIoEx(watch->hDir, &watch->overlapped);
+	GetOverlappedResult(watch->hDir, &watch->overlapped, &count, TRUE);
+	watch->is_active = FALSE;
+}
+
+/*
+ * Process filesystem events that happen anywhere (recursively) under the
+ * <worktree> root directory.  For a normal working directory, this includes
+ * both version controlled files and the contents of the .git/ directory.
+ *
+ * If <worktree>/.git is a file, then we only see events for the file
+ * itself.
+ */
+static int process_worktree_events(struct fsmonitor_daemon_state *state)
+{
+	struct fsmonitor_daemon_backend_data *data = state->backend_data;
+	struct one_watch *watch = data->watch_worktree;
+	struct strbuf path = STRBUF_INIT;
+	struct string_list cookie_list = STRING_LIST_INIT_DUP;
+	struct fsmonitor_batch *batch = NULL;
+	const char *p = watch->buffer;
+
+	/*
+	 * If the kernel gets more events than will fit in the kernel
+	 * buffer associated with our RDCW handle, it drops them and
+	 * returns a count of zero.  (A successful call, but with
+	 * length zero.)
+	 */
+	if (!watch->count) {
+		trace2_data_string("fsmonitor", NULL, "fsm-listen/kernel",
+				   "overflow");
+		fsmonitor_force_resync(state);
+		return LISTENER_HAVE_DATA_WORKTREE;
+	}
+
+	/*
+	 * On Windows, `info` contains an "array" of paths that are
+	 * relative to the root of whichever directory handle received
+	 * the event.
+	 */
+	for (;;) {
+		FILE_NOTIFY_INFORMATION *info = (void *)p;
+		const char *slash;
+		enum fsmonitor_path_type t;
+
+		strbuf_reset(&path);
+		if (normalize_path_in_utf8(info, &path) == -1)
+			goto skip_this_path;
+
+		t = fsmonitor_classify_path_workdir_relative(path.buf);
+
+		switch (t) {
+		case IS_INSIDE_DOT_GIT_WITH_COOKIE_PREFIX:
+			/* special case cookie files within .git */
+
+			/* Use just the filename of the cookie file. */
+			slash = find_last_dir_sep(path.buf);
+			string_list_append(&cookie_list,
+					   slash ? slash + 1 : path.buf);
+			break;
+
+		case IS_INSIDE_DOT_GIT:
+			/* ignore everything inside of "<worktree>/.git/" */
+			break;
+
+		case IS_DOT_GIT:
+			/* "<worktree>/.git" was deleted (or renamed away) */
+			if ((info->Action == FILE_ACTION_REMOVED) ||
+			    (info->Action == FILE_ACTION_RENAMED_OLD_NAME)) {
+				trace2_data_string("fsmonitor", NULL,
+						   "fsm-listen/dotgit",
+						   "removed");
+				goto force_shutdown;
+			}
+			break;
+
+		case IS_WORKDIR_PATH:
+			/* queue normal pathname */
+			if (!batch)
+				batch = fsmonitor_batch__new();
+			fsmonitor_batch__add_path(batch, path.buf);
+			break;
+
+		case IS_GITDIR:
+		case IS_INSIDE_GITDIR:
+		case IS_INSIDE_GITDIR_WITH_COOKIE_PREFIX:
+		default:
+			BUG("unexpected path classification '%d' for '%s'",
+			    t, path.buf);
+			goto skip_this_path;
+		}
+
+skip_this_path:
+		if (!info->NextEntryOffset)
+			break;
+		p += info->NextEntryOffset;
+	}
+
+	fsmonitor_publish(state, batch, &cookie_list);
+	batch = NULL;
+	string_list_clear(&cookie_list, 0);
+	strbuf_release(&path);
+	return LISTENER_HAVE_DATA_WORKTREE;
+
+force_shutdown:
+	fsmonitor_batch__free(batch);
+	string_list_clear(&cookie_list, 0);
+	strbuf_release(&path);
+	return LISTENER_SHUTDOWN;
+}
+
+/*
+ * Process filesystem events that happend anywhere (recursively) under the
+ * external <gitdir> (such as non-primary worktrees or submodules).
+ * We only care about cookie files that our client threads created here.
+ *
+ * Note that we DO NOT get filesystem events on the external <gitdir>
+ * itself (it is not inside something that we are watching).  In particular,
+ * we do not get an event if the external <gitdir> is deleted.
+ */
+static int process_gitdir_events(struct fsmonitor_daemon_state *state)
+{
+	struct fsmonitor_daemon_backend_data *data = state->backend_data;
+	struct one_watch *watch = data->watch_gitdir;
+	struct strbuf path = STRBUF_INIT;
+	struct string_list cookie_list = STRING_LIST_INIT_DUP;
+	const char *p = watch->buffer;
+
+	if (!watch->count) {
+		trace2_data_string("fsmonitor", NULL, "fsm-listen/kernel",
+				   "overflow");
+		fsmonitor_force_resync(state);
+		return LISTENER_HAVE_DATA_GITDIR;
+	}
+
+	for (;;) {
+		FILE_NOTIFY_INFORMATION *info = (void *)p;
+		const char *slash;
+		enum fsmonitor_path_type t;
+
+		strbuf_reset(&path);
+		if (normalize_path_in_utf8(info, &path) == -1)
+			goto skip_this_path;
+
+		t = fsmonitor_classify_path_gitdir_relative(path.buf);
+
+		trace_printf_key(&trace_fsmonitor, "BBB: %s", path.buf);
+
+		switch (t) {
+		case IS_INSIDE_GITDIR_WITH_COOKIE_PREFIX:
+			/* special case cookie files within gitdir */
+
+			/* Use just the filename of the cookie file. */
+			slash = find_last_dir_sep(path.buf);
+			string_list_append(&cookie_list,
+					   slash ? slash + 1 : path.buf);
+			break;
+
+		case IS_INSIDE_GITDIR:
+			goto skip_this_path;
+
+		default:
+			BUG("unexpected path classification '%d' for '%s'",
+			    t, path.buf);
+			goto skip_this_path;
+		}
+
+skip_this_path:
+		if (!info->NextEntryOffset)
+			break;
+		p += info->NextEntryOffset;
+	}
+
+	fsmonitor_publish(state, NULL, &cookie_list);
+	string_list_clear(&cookie_list, 0);
+	strbuf_release(&path);
+	return LISTENER_HAVE_DATA_GITDIR;
 }
 
 void fsmonitor_fs_listen__loop(struct fsmonitor_daemon_state *state)
 {
+	struct fsmonitor_daemon_backend_data *data = state->backend_data;
+	DWORD dwWait;
+
+	state->error_code = 0;
+
+	if (start_rdcw_watch(data, data->watch_worktree) == -1)
+		goto force_error_stop;
+
+	if (data->watch_gitdir &&
+	    start_rdcw_watch(data, data->watch_gitdir) == -1)
+		goto force_error_stop;
+
+	for (;;) {
+		dwWait = WaitForMultipleObjects(data->nr_listener_handles,
+						data->hListener,
+						FALSE, INFINITE);
+
+		if (dwWait == WAIT_OBJECT_0 + LISTENER_HAVE_DATA_WORKTREE) {
+			if (recv_rdcw_watch(data->watch_worktree) == -1)
+				goto force_error_stop;
+			if (process_worktree_events(state) == LISTENER_SHUTDOWN)
+				goto force_shutdown;
+			if (start_rdcw_watch(data, data->watch_worktree) == -1)
+				goto force_error_stop;
+			continue;
+		}
+
+		if (dwWait == WAIT_OBJECT_0 + LISTENER_HAVE_DATA_GITDIR) {
+			if (recv_rdcw_watch(data->watch_gitdir) == -1)
+				goto force_error_stop;
+			if (process_gitdir_events(state) == LISTENER_SHUTDOWN)
+				goto force_shutdown;
+			if (start_rdcw_watch(data, data->watch_gitdir) == -1)
+				goto force_error_stop;
+			continue;
+		}
+
+		if (dwWait == WAIT_OBJECT_0 + LISTENER_SHUTDOWN)
+			goto clean_shutdown;
+
+		error(_("could not read directory changes [GLE %ld]"),
+		      GetLastError());
+		goto force_error_stop;
+	}
+
+force_error_stop:
+	state->error_code = -1;
+
+force_shutdown:
+	/*
+	 * Tell the IPC thead pool to stop (which completes the await
+	 * in the main thread (which will also signal this thread (if
+	 * we are still alive))).
+	 */
+	ipc_server_stop_async(state->ipc_server_data);
+
+clean_shutdown:
+	cancel_rdcw_watch(data->watch_worktree);
+	cancel_rdcw_watch(data->watch_gitdir);
 }
 
 int fsmonitor_fs_listen__ctor(struct fsmonitor_daemon_state *state)
 {
+	struct fsmonitor_daemon_backend_data *data;
+
+	data = xcalloc(1, sizeof(*data));
+
+	data->hEventShutdown = CreateEvent(NULL, TRUE, FALSE, NULL);
+
+	data->watch_worktree = create_watch(state,
+					    state->path_worktree_watch.buf);
+	if (!data->watch_worktree)
+		goto failed;
+
+	if (state->nr_paths_watching > 1) {
+		data->watch_gitdir = create_watch(state,
+						  state->path_gitdir_watch.buf);
+		if (!data->watch_gitdir)
+			goto failed;
+	}
+
+	data->hListener[LISTENER_SHUTDOWN] = data->hEventShutdown;
+	data->nr_listener_handles++;
+
+	data->hListener[LISTENER_HAVE_DATA_WORKTREE] =
+		data->watch_worktree->hEvent;
+	data->nr_listener_handles++;
+
+	if (data->watch_gitdir) {
+		data->hListener[LISTENER_HAVE_DATA_GITDIR] =
+			data->watch_gitdir->hEvent;
+		data->nr_listener_handles++;
+	}
+
+	state->backend_data = data;
+	return 0;
+
+failed:
+	CloseHandle(data->hEventShutdown);
+	destroy_watch(data->watch_worktree);
+	destroy_watch(data->watch_gitdir);
+
 	return -1;
 }
 
 void fsmonitor_fs_listen__dtor(struct fsmonitor_daemon_state *state)
 {
+	struct fsmonitor_daemon_backend_data *data;
+
+	if (!state || !state->backend_data)
+		return;
+
+	data = state->backend_data;
+
+	CloseHandle(data->hEventShutdown);
+	destroy_watch(data->watch_worktree);
+	destroy_watch(data->watch_gitdir);
+
+	FREE_AND_NULL(state->backend_data);
 }
-- 
gitgitgadget

