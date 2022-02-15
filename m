Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CB5EC433F5
	for <git@archiver.kernel.org>; Tue, 15 Feb 2022 16:00:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241190AbiBOQAj (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Feb 2022 11:00:39 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241156AbiBOQAa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Feb 2022 11:00:30 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A57EC0853
        for <git@vger.kernel.org>; Tue, 15 Feb 2022 07:59:56 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id q198-20020a1ca7cf000000b0037bb52545c6so1812998wme.1
        for <git@vger.kernel.org>; Tue, 15 Feb 2022 07:59:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=UkMM7o067DX4pAl9q6UWTehwf7NH/z8tAqzRF88w+U0=;
        b=jp94jZNW8WpnN2MjgKfa/DEDZFfXAZcPD7WdYPEpKff6xR+EW/QgIgLCX4F7fF7LQd
         IRfzg3ZmWCfKVc852RDO4pszPlg37Uus6XZwd2RE/fEVM65PHjcci/vLHlvgQ2/aRdV0
         eHPesajT9NeFDMWBxpk0QFEQlrLKjWuZp+2zBZELX6VoAzgzeR4MUr0H643CmNLdkwuD
         9Ty9uB0U1klWXVvKcKSUDenW8tFkfYxFI4H5+MvygOGJn3DaLlnLmaq7CCmEIhWo2fee
         jSvVxEzxVQMB8rVNfV+kXJt7Wu3QAA4RqzxcT7ES9K3TXhNp4Cefysj/PH3pbJ1NkLWv
         yyHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=UkMM7o067DX4pAl9q6UWTehwf7NH/z8tAqzRF88w+U0=;
        b=tTpnwxsifyf47J+ni8dm+ul0VfZKVJx+jBrFajZHJRe54QBT/bvgmbtNtHt9mLzDv2
         0NjlwAJFvFVrAHtnQjWxAZVDlem/TVM42/hMuyERPKCvzz4j+NPmcVLyW4goQJ0zKSrj
         t6xDdeePUSf34ClVEDgdDVUqAIj78SGeyVzO4TuVAA8prlP8TCbd43LwrU71umqs10/v
         PB12LHNflbfbQPaiHisOI1DJChxW8GiDQXjt8ZCaYeKeEpMo6ITA1EPjKE5u17dpCoWw
         2ONA7YeHcVNGS307V88fgL9cJKZynwa/egYXPdVtex7dz6w3w5AjrtxgFSA6gYa/ZlDD
         FTRA==
X-Gm-Message-State: AOAM532aMoqETkQwLuLwzE8marVsaQROzorde53vMs9KEEmnz+DMncC9
        w98BlMKx3NALig13TDRwWT+KMwQopYg=
X-Google-Smtp-Source: ABdhPJwrA2Ye8lQKXs4Na/JBGw0XObFmbagznt9L0j2/sGFq66Ydw0RP2H6c5lVL7u7ji0c3jcwhvA==
X-Received: by 2002:a05:600c:a4c:: with SMTP id c12mr3630833wmq.48.1644940794477;
        Tue, 15 Feb 2022 07:59:54 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n11sm16726368wms.13.2022.02.15.07.59.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Feb 2022 07:59:53 -0800 (PST)
Message-Id: <023fcd6e2b1163ab3d23b0d5933c14586d814ce0.1644940774.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1143.git.1644940773.gitgitgadget@gmail.com>
References: <pull.1143.git.1644940773.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 15 Feb 2022 15:59:29 +0000
Subject: [PATCH 19/23] fsm-health-win32: force shutdown daemon if worktree
 root moves
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

Force shutdown fsmonitor daemon if the worktree root directory
is moved, renamed, or deleted.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 compat/fsmonitor/fsm-health-win32.c | 133 ++++++++++++++++++++++++++++
 1 file changed, 133 insertions(+)

diff --git a/compat/fsmonitor/fsm-health-win32.c b/compat/fsmonitor/fsm-health-win32.c
index 3c3453369cd..2526ad9194f 100644
--- a/compat/fsmonitor/fsm-health-win32.c
+++ b/compat/fsmonitor/fsm-health-win32.c
@@ -14,7 +14,10 @@ enum interval_fn_ctx { CTX_INIT = 0, CTX_TERM, CTX_TIMER };
 typedef int (interval_fn)(struct fsmonitor_daemon_state *state,
 			  enum interval_fn_ctx ctx);
 
+static interval_fn has_worktree_moved;
+
 static interval_fn *table[] = {
+	has_worktree_moved,
 	NULL, /* must be last */
 };
 
@@ -45,6 +48,12 @@ struct fsm_health_data
 	HANDLE hHandles[1]; /* the array does not own these handles */
 #define HEALTH_SHUTDOWN 0
 	int nr_handles; /* number of active event handles */
+
+	struct wt_moved
+	{
+		wchar_t wpath[MAX_PATH + 1];
+		BY_HANDLE_FILE_INFORMATION bhfi;
+	} wt_moved;
 };
 
 int fsm_health__ctor(struct fsmonitor_daemon_state *state)
@@ -76,6 +85,130 @@ void fsm_health__dtor(struct fsmonitor_daemon_state *state)
 	FREE_AND_NULL(state->health_data);
 }
 
+static int lookup_bhfi(wchar_t *wpath,
+		       BY_HANDLE_FILE_INFORMATION *bhfi)
+{
+	DWORD desired_access = FILE_LIST_DIRECTORY;
+	DWORD share_mode =
+		FILE_SHARE_WRITE | FILE_SHARE_READ | FILE_SHARE_DELETE;
+	HANDLE hDir;
+
+	hDir = CreateFileW(wpath, desired_access, share_mode, NULL,
+			   OPEN_EXISTING, FILE_FLAG_BACKUP_SEMANTICS, NULL);
+	if (hDir == INVALID_HANDLE_VALUE) {
+		error(_("[GLE %ld] health thread could not open '%ls'"),
+		      GetLastError(), wpath);
+		return -1;
+	}
+
+	if (!GetFileInformationByHandle(hDir, bhfi)) {
+		error(_("[GLE %ld] health thread getting BHFI for '%ls'"),
+		      GetLastError(), wpath);
+		CloseHandle(hDir);
+		return -1;
+	}
+
+	CloseHandle(hDir);
+	return 0;
+}
+
+static int bhfi_eq(const BY_HANDLE_FILE_INFORMATION *bhfi_1,
+		   const BY_HANDLE_FILE_INFORMATION *bhfi_2)
+{
+	return (bhfi_1->dwVolumeSerialNumber == bhfi_2->dwVolumeSerialNumber &&
+		bhfi_1->nFileIndexHigh == bhfi_2->nFileIndexHigh &&
+		bhfi_1->nFileIndexLow == bhfi_2->nFileIndexLow);
+}
+
+/*
+ * Shutdown if the original worktree root directory been deleted,
+ * moved, or renamed?
+ *
+ * Since the main thread did a "chdir(getenv($HOME))" and our CWD
+ * is not in the worktree root directory and because the listener
+ * thread added FILE_SHARE_DELETE to the watch handle, it is possible
+ * for the root directory to be moved or deleted while we are still
+ * watching it.  We want to detect that here and force a shutdown.
+ *
+ * Granted, a delete MAY cause some operations to fail, such as
+ * GetOverlappedResult(), but it is not guaranteed.  And because
+ * ReadDirectoryChangesW() only reports on changes *WITHIN* the
+ * directory, not changes *ON* the directory, our watch will not
+ * receive a delete event for it.
+ *
+ * A move/rename of the worktree root will also not generate an event.
+ * And since the listener thread already has an open handle, it may
+ * continue to receive events for events within the directory.
+ * However, the pathname of the named-pipe was constructed using the
+ * original location of the worktree root.  (Remember named-pipes are
+ * stored in the NPFS and not in the actual file system.)  Clients
+ * trying to talk to the worktree after the move/rename will not
+ * reach our daemon process, since we're still listening on the
+ * pipe with original path.
+ *
+ * Furthermore, if the user does something like:
+ *
+ *   $ mv repo repo.old
+ *   $ git init repo
+ *
+ * A new daemon cannot be started in the new instance of "repo"
+ * because the named-pipe is still being used by the daemon on
+ * the original instance.
+ *
+ * So, detect move/rename/delete and shutdown.  This should also
+ * handle unsafe drive removal.
+ *
+ * We use the file system unique ID to distinguish the original
+ * directory instance from a new instance and force a shutdown
+ * if the unique ID changes.
+ *
+ * Since a worktree move/rename/delete/unmount doesn't happen
+ * that often (and we can't get an immediate event anyway), we
+ * use a timeout and periodically poll it.
+ */
+static int has_worktree_moved(struct fsmonitor_daemon_state *state,
+			      enum interval_fn_ctx ctx)
+{
+	struct fsm_health_data *data = state->health_data;
+	BY_HANDLE_FILE_INFORMATION bhfi;
+	int r;
+
+	switch (ctx) {
+	case CTX_TERM:
+		return 0;
+
+	case CTX_INIT:
+		if (xutftowcs_path(data->wt_moved.wpath,
+				   state->path_worktree_watch.buf) < 0) {
+			error(_("could not convert to wide characters: '%s'"),
+			      state->path_worktree_watch.buf);
+			return -1;
+		}
+
+		/*
+		 * On the first call we lookup the unique sequence ID for
+		 * the worktree root directory.
+		 */
+		return lookup_bhfi(data->wt_moved.wpath, &data->wt_moved.bhfi);
+
+	case CTX_TIMER:
+		r = lookup_bhfi(data->wt_moved.wpath, &bhfi);
+		if (r)
+			return r;
+		if (!bhfi_eq(&data->wt_moved.bhfi, &bhfi)) {
+			error(_("BHFI changed '%ls'"), data->wt_moved.wpath);
+			return -1;
+		}
+		return 0;
+
+	default:
+		die("unhandled case in 'has_worktree_moved': %d",
+		    (int)ctx);
+	}
+
+	return 0;
+}
+
 void fsm_health__loop(struct fsmonitor_daemon_state *state)
 {
 	struct fsm_health_data *data = state->health_data;
-- 
gitgitgadget

