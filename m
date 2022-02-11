Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B1D3C433EF
	for <git@archiver.kernel.org>; Fri, 11 Feb 2022 20:57:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353660AbiBKU5P (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Feb 2022 15:57:15 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353580AbiBKU4v (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Feb 2022 15:56:51 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9568AD5F
        for <git@vger.kernel.org>; Fri, 11 Feb 2022 12:56:36 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id o24so14521710wro.3
        for <git@vger.kernel.org>; Fri, 11 Feb 2022 12:56:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=HfoOR6IKLJgzyxYDtlbjOqyeVhHCKUqnSoicoP+h94s=;
        b=JIMwF/yHe/0D0YbgboKPh3oXDXE3TZ0ouewRLSU4EmTTeGKm2OreXL9ZgPbsU9CzzM
         inTLEw6A23IX8jQmMsf3BqNM3mUhlxAsZnkeIQwnYxKpawZfDO/xMxY/RuGA9bv0l5kT
         KlGOt9tddyGH8ZutnaTOtlJjoZgJzqkSQXaWgwvzcmC+CV8UPLWn/Xo3hdRZVEInSPgs
         nladtgOMKci7nb75t1/n6xasRgPwCSJOhvsF2b4kshAdgDGQy4myfYjxO2K0Mkc2ZeDa
         olQQi52oR1/dfA+gwEcvSC3vUTQS61kGoOJdPgIkArvw6Bl4/iulG1Tdc2FHoOmKhbZ3
         SdjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=HfoOR6IKLJgzyxYDtlbjOqyeVhHCKUqnSoicoP+h94s=;
        b=JPa2yF2+m3BRwAKRGfeWrQ548iz44ZJ4fC9HpU7yENPURwVqxZqa1xPzz3r9ryv2Qu
         IhTPsPOMltFPNDSQhk6Ui+YA0zT+Q1rSLMUvKDCb+Ivh+tZ1lYGMQgnz+yrbuczFgYGe
         p1HMBb0aqJDXV0hj3bk2dqjik/ampEjHIkf8YfaXZ72qOLMIveTITYLsrXWea/ZgVfaI
         Be5r0D3lnuFwWBrQWXN+x6wjHmAfR01LfDC3LMMJwecrQBPsMPEJjV4XpkwtomRQASOc
         ElxPVoKNUOPXTGlIdmhxC8ythQ62Fa8SBo0hFrAlOZr796uQWv2PSlUhoDEcc8f/HthD
         rAiw==
X-Gm-Message-State: AOAM532rjHgSvC5jjA88oKBVhve+6DLpV953wokXfYcmifkRbaX4TgZY
        4IUHJNK75LBAmhbw44D/nYlqJ+LvFyg=
X-Google-Smtp-Source: ABdhPJwexNt4ZAPeo9t1M6rPQB0Q1L1cncPfApmNrI6z5oSCGHHdzL4klJPu979J4mIIbkGCoIMucQ==
X-Received: by 2002:a5d:4888:: with SMTP id g8mr2725502wrq.65.1644612994987;
        Fri, 11 Feb 2022 12:56:34 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l12sm4680445wmd.44.2022.02.11.12.56.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Feb 2022 12:56:34 -0800 (PST)
Message-Id: <162e357db7211e72c8a39e722e8432baf710c70d.1644612979.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1041.v5.git.1644612979.gitgitgadget@gmail.com>
References: <pull.1041.v4.git.1634826309.gitgitgadget@gmail.com>
        <pull.1041.v5.git.1644612979.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 11 Feb 2022 20:56:06 +0000
Subject: [PATCH v5 17/30] compat/fsmonitor/fsm-listen-darwin: implement
 FSEvent listener on MacOS
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

Implement file system event listener on MacOS using FSEvent,
CoreFoundation, and CoreServices.

Co-authored-by: Kevin Willford <Kevin.Willford@microsoft.com>
Co-authored-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 compat/fsmonitor/fsm-listen-darwin.c | 382 ++++++++++++++++++++++++++-
 1 file changed, 381 insertions(+), 1 deletion(-)

diff --git a/compat/fsmonitor/fsm-listen-darwin.c b/compat/fsmonitor/fsm-listen-darwin.c
index f424253d3eb..2aefdc14d89 100644
--- a/compat/fsmonitor/fsm-listen-darwin.c
+++ b/compat/fsmonitor/fsm-listen-darwin.c
@@ -1,4 +1,4 @@
-#if defined(__GNUC__)
+#ifndef __clang__
 /*
  * It is possible to #include CoreFoundation/CoreFoundation.h when compiling
  * with clang, but not with GCC as of time of writing.
@@ -97,20 +97,400 @@ void FSEventStreamRelease(FSEventStreamRef stream);
 #include "cache.h"
 #include "fsmonitor.h"
 #include "fsm-listen.h"
+#include "fsmonitor--daemon.h"
+
+struct fsmonitor_daemon_backend_data
+{
+	CFStringRef cfsr_worktree_path;
+	CFStringRef cfsr_gitdir_path;
+
+	CFArrayRef cfar_paths_to_watch;
+	int nr_paths_watching;
+
+	FSEventStreamRef stream;
+
+	CFRunLoopRef rl;
+
+	enum shutdown_style {
+		SHUTDOWN_EVENT = 0,
+		FORCE_SHUTDOWN,
+		FORCE_ERROR_STOP,
+	} shutdown_style;
+
+	unsigned int stream_scheduled:1;
+	unsigned int stream_started:1;
+};
+
+static void log_flags_set(const char *path, const FSEventStreamEventFlags flag)
+{
+	struct strbuf msg = STRBUF_INIT;
+
+	if (flag & kFSEventStreamEventFlagMustScanSubDirs)
+		strbuf_addstr(&msg, "MustScanSubDirs|");
+	if (flag & kFSEventStreamEventFlagUserDropped)
+		strbuf_addstr(&msg, "UserDropped|");
+	if (flag & kFSEventStreamEventFlagKernelDropped)
+		strbuf_addstr(&msg, "KernelDropped|");
+	if (flag & kFSEventStreamEventFlagEventIdsWrapped)
+		strbuf_addstr(&msg, "EventIdsWrapped|");
+	if (flag & kFSEventStreamEventFlagHistoryDone)
+		strbuf_addstr(&msg, "HistoryDone|");
+	if (flag & kFSEventStreamEventFlagRootChanged)
+		strbuf_addstr(&msg, "RootChanged|");
+	if (flag & kFSEventStreamEventFlagMount)
+		strbuf_addstr(&msg, "Mount|");
+	if (flag & kFSEventStreamEventFlagUnmount)
+		strbuf_addstr(&msg, "Unmount|");
+	if (flag & kFSEventStreamEventFlagItemChangeOwner)
+		strbuf_addstr(&msg, "ItemChangeOwner|");
+	if (flag & kFSEventStreamEventFlagItemCreated)
+		strbuf_addstr(&msg, "ItemCreated|");
+	if (flag & kFSEventStreamEventFlagItemFinderInfoMod)
+		strbuf_addstr(&msg, "ItemFinderInfoMod|");
+	if (flag & kFSEventStreamEventFlagItemInodeMetaMod)
+		strbuf_addstr(&msg, "ItemInodeMetaMod|");
+	if (flag & kFSEventStreamEventFlagItemIsDir)
+		strbuf_addstr(&msg, "ItemIsDir|");
+	if (flag & kFSEventStreamEventFlagItemIsFile)
+		strbuf_addstr(&msg, "ItemIsFile|");
+	if (flag & kFSEventStreamEventFlagItemIsHardlink)
+		strbuf_addstr(&msg, "ItemIsHardlink|");
+	if (flag & kFSEventStreamEventFlagItemIsLastHardlink)
+		strbuf_addstr(&msg, "ItemIsLastHardlink|");
+	if (flag & kFSEventStreamEventFlagItemIsSymlink)
+		strbuf_addstr(&msg, "ItemIsSymlink|");
+	if (flag & kFSEventStreamEventFlagItemModified)
+		strbuf_addstr(&msg, "ItemModified|");
+	if (flag & kFSEventStreamEventFlagItemRemoved)
+		strbuf_addstr(&msg, "ItemRemoved|");
+	if (flag & kFSEventStreamEventFlagItemRenamed)
+		strbuf_addstr(&msg, "ItemRenamed|");
+	if (flag & kFSEventStreamEventFlagItemXattrMod)
+		strbuf_addstr(&msg, "ItemXattrMod|");
+	if (flag & kFSEventStreamEventFlagOwnEvent)
+		strbuf_addstr(&msg, "OwnEvent|");
+	if (flag & kFSEventStreamEventFlagItemCloned)
+		strbuf_addstr(&msg, "ItemCloned|");
+
+	trace_printf_key(&trace_fsmonitor, "fsevent: '%s', flags=%u %s",
+			 path, flag, msg.buf);
+
+	strbuf_release(&msg);
+}
+
+static int ef_is_root_delete(const FSEventStreamEventFlags ef)
+{
+	return (ef & kFSEventStreamEventFlagItemIsDir &&
+		ef & kFSEventStreamEventFlagItemRemoved);
+}
+
+static int ef_is_root_renamed(const FSEventStreamEventFlags ef)
+{
+	return (ef & kFSEventStreamEventFlagItemIsDir &&
+		ef & kFSEventStreamEventFlagItemRenamed);
+}
+
+static int ef_is_dropped(const FSEventStreamEventFlags ef)
+{
+	return (ef & kFSEventStreamEventFlagMustScanSubDirs ||
+		ef & kFSEventStreamEventFlagKernelDropped ||
+		ef & kFSEventStreamEventFlagUserDropped);
+}
+
+static void fsevent_callback(ConstFSEventStreamRef streamRef,
+			     void *ctx,
+			     size_t num_of_events,
+			     void *event_paths,
+			     const FSEventStreamEventFlags event_flags[],
+			     const FSEventStreamEventId event_ids[])
+{
+	struct fsmonitor_daemon_state *state = ctx;
+	struct fsmonitor_daemon_backend_data *data = state->backend_data;
+	char **paths = (char **)event_paths;
+	struct fsmonitor_batch *batch = NULL;
+	struct string_list cookie_list = STRING_LIST_INIT_DUP;
+	const char *path_k;
+	const char *slash;
+	int k;
+	struct strbuf tmp = STRBUF_INIT;
+
+	/*
+	 * Build a list of all filesystem changes into a private/local
+	 * list and without holding any locks.
+	 */
+	for (k = 0; k < num_of_events; k++) {
+		/*
+		 * On Mac, we receive an array of absolute paths.
+		 */
+		path_k = paths[k];
+
+		/*
+		 * If you want to debug FSEvents, log them to GIT_TRACE_FSMONITOR.
+		 * Please don't log them to Trace2.
+		 *
+		 * trace_printf_key(&trace_fsmonitor, "Path: '%s'", path_k);
+		 */
+
+		/*
+		 * If event[k] is marked as dropped, we assume that we have
+		 * lost sync with the filesystem and should flush our cached
+		 * data.  We need to:
+		 *
+		 * [1] Abort/wake any client threads waiting for a cookie and
+		 *     flush the cached state data (the current token), and
+		 *     create a new token.
+		 *
+		 * [2] Discard the batch that we were locally building (since
+		 *     they are conceptually relative to the just flushed
+		 *     token).
+		 */
+		if (ef_is_dropped(event_flags[k])) {
+			if (trace_pass_fl(&trace_fsmonitor))
+				log_flags_set(path_k, event_flags[k]);
+
+			fsmonitor_force_resync(state);
+			fsmonitor_batch__free_list(batch);
+			string_list_clear(&cookie_list, 0);
+
+			/*
+			 * We assume that any events that we received
+			 * in this callback after this dropped event
+			 * may still be valid, so we continue rather
+			 * than break.  (And just in case there is a
+			 * delete of ".git" hiding in there.)
+			 */
+			continue;
+		}
+
+		switch (fsmonitor_classify_path_absolute(state, path_k)) {
+
+		case IS_INSIDE_DOT_GIT_WITH_COOKIE_PREFIX:
+		case IS_INSIDE_GITDIR_WITH_COOKIE_PREFIX:
+			/* special case cookie files within .git or gitdir */
+
+			/* Use just the filename of the cookie file. */
+			slash = find_last_dir_sep(path_k);
+			string_list_append(&cookie_list,
+					   slash ? slash + 1 : path_k);
+			break;
+
+		case IS_INSIDE_DOT_GIT:
+		case IS_INSIDE_GITDIR:
+			/* ignore all other paths inside of .git or gitdir */
+			break;
+
+		case IS_DOT_GIT:
+		case IS_GITDIR:
+			/*
+			 * If .git directory is deleted or renamed away,
+			 * we have to quit.
+			 */
+			if (ef_is_root_delete(event_flags[k])) {
+				trace_printf_key(&trace_fsmonitor,
+						 "event: gitdir removed");
+				goto force_shutdown;
+			}
+			if (ef_is_root_renamed(event_flags[k])) {
+				trace_printf_key(&trace_fsmonitor,
+						 "event: gitdir renamed");
+				goto force_shutdown;
+			}
+			break;
+
+		case IS_WORKDIR_PATH:
+			/* try to queue normal pathnames */
+
+			if (trace_pass_fl(&trace_fsmonitor))
+				log_flags_set(path_k, event_flags[k]);
+
+			/*
+			 * Because of the implicit "binning" (the
+			 * kernel calls us at a given frequency) and
+			 * de-duping (the kernel is free to combine
+			 * multiple events for a given pathname), an
+			 * individual fsevent could be marked as both
+			 * a file and directory.  Add it to the queue
+			 * with both spellings so that the client will
+			 * know how much to invalidate/refresh.
+			 */
+
+			if (event_flags[k] & kFSEventStreamEventFlagItemIsFile) {
+				const char *rel = path_k +
+					state->path_worktree_watch.len + 1;
+
+				if (!batch)
+					batch = fsmonitor_batch__new();
+				fsmonitor_batch__add_path(batch, rel);
+			}
+
+			if (event_flags[k] & kFSEventStreamEventFlagItemIsDir) {
+				const char *rel = path_k +
+					state->path_worktree_watch.len + 1;
+
+				strbuf_reset(&tmp);
+				strbuf_addstr(&tmp, rel);
+				strbuf_addch(&tmp, '/');
+
+				if (!batch)
+					batch = fsmonitor_batch__new();
+				fsmonitor_batch__add_path(batch, tmp.buf);
+			}
+
+			break;
+
+		case IS_OUTSIDE_CONE:
+		default:
+			trace_printf_key(&trace_fsmonitor,
+					 "ignoring '%s'", path_k);
+			break;
+		}
+	}
+
+	fsmonitor_publish(state, batch, &cookie_list);
+	string_list_clear(&cookie_list, 0);
+	strbuf_release(&tmp);
+	return;
+
+force_shutdown:
+	fsmonitor_batch__free_list(batch);
+	string_list_clear(&cookie_list, 0);
+
+	data->shutdown_style = FORCE_SHUTDOWN;
+	CFRunLoopStop(data->rl);
+	strbuf_release(&tmp);
+	return;
+}
+
+/*
+ * NEEDSWORK: Investigate the proper value for the `latency` argument
+ * in the call to `FSEventStreamCreate()`.  I'm not sure that this
+ * needs to be a config setting or just something that we tune after
+ * some testing.
+ *
+ * With a latency of 0.1, I was seeing lots of dropped events during
+ * the "touch 100000" files test within t/perf/p7519, but with a
+ * latency of 0.001 I did not see any dropped events.  So the
+ * "correct" value may be somewhere in between.
+ *
+ * https://developer.apple.com/documentation/coreservices/1443980-fseventstreamcreate
+ */
 
 int fsm_listen__ctor(struct fsmonitor_daemon_state *state)
 {
+	FSEventStreamCreateFlags flags = kFSEventStreamCreateFlagNoDefer |
+		kFSEventStreamCreateFlagWatchRoot |
+		kFSEventStreamCreateFlagFileEvents;
+	FSEventStreamContext ctx = {
+		0,
+		state,
+		NULL,
+		NULL,
+		NULL
+	};
+	struct fsmonitor_daemon_backend_data *data;
+	const void *dir_array[2];
+
+	CALLOC_ARRAY(data, 1);
+	state->backend_data = data;
+
+	data->cfsr_worktree_path = CFStringCreateWithCString(
+		NULL, state->path_worktree_watch.buf, kCFStringEncodingUTF8);
+	dir_array[data->nr_paths_watching++] = data->cfsr_worktree_path;
+
+	if (state->nr_paths_watching > 1) {
+		data->cfsr_gitdir_path = CFStringCreateWithCString(
+			NULL, state->path_gitdir_watch.buf,
+			kCFStringEncodingUTF8);
+		dir_array[data->nr_paths_watching++] = data->cfsr_gitdir_path;
+	}
+
+	data->cfar_paths_to_watch = CFArrayCreate(NULL, dir_array,
+						  data->nr_paths_watching,
+						  NULL);
+	data->stream = FSEventStreamCreate(NULL, fsevent_callback, &ctx,
+					   data->cfar_paths_to_watch,
+					   kFSEventStreamEventIdSinceNow,
+					   0.001, flags);
+	if (data->stream == NULL)
+		goto failed;
+
+	/*
+	 * `data->rl` needs to be set inside the listener thread.
+	 */
+
+	return 0;
+
+failed:
+	error("Unable to create FSEventStream.");
+
+	FREE_AND_NULL(state->backend_data);
 	return -1;
 }
 
 void fsm_listen__dtor(struct fsmonitor_daemon_state *state)
 {
+	struct fsmonitor_daemon_backend_data *data;
+
+	if (!state || !state->backend_data)
+		return;
+
+	data = state->backend_data;
+
+	if (data->stream) {
+		if (data->stream_started)
+			FSEventStreamStop(data->stream);
+		if (data->stream_scheduled)
+			FSEventStreamInvalidate(data->stream);
+		FSEventStreamRelease(data->stream);
+	}
+
+	FREE_AND_NULL(state->backend_data);
 }
 
 void fsm_listen__stop_async(struct fsmonitor_daemon_state *state)
 {
+	struct fsmonitor_daemon_backend_data *data;
+
+	data = state->backend_data;
+	data->shutdown_style = SHUTDOWN_EVENT;
+
+	CFRunLoopStop(data->rl);
 }
 
 void fsm_listen__loop(struct fsmonitor_daemon_state *state)
 {
+	struct fsmonitor_daemon_backend_data *data;
+
+	data = state->backend_data;
+
+	data->rl = CFRunLoopGetCurrent();
+
+	FSEventStreamScheduleWithRunLoop(data->stream, data->rl, kCFRunLoopDefaultMode);
+	data->stream_scheduled = 1;
+
+	if (!FSEventStreamStart(data->stream)) {
+		error("Failed to start the FSEventStream");
+		goto force_error_stop_without_loop;
+	}
+	data->stream_started = 1;
+
+	CFRunLoopRun();
+
+	switch (data->shutdown_style) {
+	case FORCE_ERROR_STOP:
+		state->error_code = -1;
+		/* fall thru */
+	case FORCE_SHUTDOWN:
+		ipc_server_stop_async(state->ipc_server_data);
+		/* fall thru */
+	case SHUTDOWN_EVENT:
+	default:
+		break;
+	}
+	return;
+
+force_error_stop_without_loop:
+	state->error_code = -1;
+	ipc_server_stop_async(state->ipc_server_data);
+	return;
 }
-- 
gitgitgadget

