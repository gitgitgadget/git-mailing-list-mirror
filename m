Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C05C7C43611
	for <git@archiver.kernel.org>; Thu,  1 Apr 2021 17:47:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 77AF161284
	for <git@archiver.kernel.org>; Thu,  1 Apr 2021 17:47:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236308AbhDARr5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Apr 2021 13:47:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234533AbhDARmN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Apr 2021 13:42:13 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2AB1C02D545
        for <git@vger.kernel.org>; Thu,  1 Apr 2021 08:41:18 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id p19so1272316wmq.1
        for <git@vger.kernel.org>; Thu, 01 Apr 2021 08:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=YeAUI6u+REX12lsdfeZEptcjViUJU8DCgHxwyEQq4Vw=;
        b=SrM6rpOu3Qvgm7qOT9bxgupXxzH8NW4CHvl3Wza5TWpp2cAmKef61gDuKg1R9N+k7B
         UazXWVrZYliLnS1kPoUlTXQKBcIdS6caxTLXq9Q3Y2F99AG/n9dqHKs2vJ50dqlhXX8L
         G8cPw9rsi1Yo7MmTJ3VpxtYOZxXP9VK8RJr4sikf6/p4c2RCL54NrrefSqYl/yi+fV1j
         ptFyaScc6ikfkKyH8yPRnJGqYi2+jLwV6kOwY499LWPWnxzlQ2cJ/pB16h1gfL0b7lN3
         aP19MfpBO+vo/BGVII4VWy8KZpfBCe7auaAmFYR+emEcD2SBdK1BVjtYKujLPQTfYqlE
         XsuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=YeAUI6u+REX12lsdfeZEptcjViUJU8DCgHxwyEQq4Vw=;
        b=GxA0XH6id7BxzdTIitJHz8yrT93Q7gx9glBH/0v2hLQWDXtXdcyrZBivr9OzGGY/6D
         oyh9qrzNuyXGL38PpoZaXHNdNFWkAZqdWr56U5kuzvr2D1qavE2zcNved7ZcqNNd00ru
         zadJL+bOJ2VCIEEfnRQCkD4gqw8mAlolvLPOferMgZlhtAnLHDj05ebFLHHf/7tz60XF
         VPVU9ph9ALdtdoV/OBC8Un2R2Y2TkqYhMbqk2Ry9x2LblP4/REGqhkOzSNgIE33aSKfd
         sRtx40ac6pldIbLf2Mvj1pkyZLDhGA/lJcEWSVw9V7Deso5XurrE535hvKmd7Msj1HST
         NzVA==
X-Gm-Message-State: AOAM532M85wHK0Bdu3SVWsNs61z70md1dusq4ArtJMhdHSoWdolUzTBc
        z8Atd3iqX0bK04KkRkDsxx91KVOYQlo=
X-Google-Smtp-Source: ABdhPJyjd7u2uyp85hNUxnA+0KvCHbzqJX2yMnMs9SA/6Am4YADySHSPSV4CAAoZrbUrw8n0+RK60g==
X-Received: by 2002:a05:600c:252:: with SMTP id 18mr8487924wmj.67.1617291677431;
        Thu, 01 Apr 2021 08:41:17 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n4sm8106090wmq.40.2021.04.01.08.41.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Apr 2021 08:41:17 -0700 (PDT)
Message-Id: <d469d3f02e335292f4debd55ff67184b2b91b04f.1617291666.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.923.git.1617291666.gitgitgadget@gmail.com>
References: <pull.923.git.1617291666.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 01 Apr 2021 15:40:57 +0000
Subject: [PATCH 15/23] fsmonitor-fs-listen-macos: implement FSEvent listener
 on MacOS
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

Implement file system event listener on MacOS using FSEvent,
CoreFoundation, and CoreServices.

Co-authored-by: Kevin Willford <Kevin.Willford@microsoft.com>
Co-authored-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 compat/fsmonitor/fsmonitor-fs-listen-macos.c | 368 +++++++++++++++++++
 1 file changed, 368 insertions(+)

diff --git a/compat/fsmonitor/fsmonitor-fs-listen-macos.c b/compat/fsmonitor/fsmonitor-fs-listen-macos.c
index bec5130d9e1d..e055fb579cc4 100644
--- a/compat/fsmonitor/fsmonitor-fs-listen-macos.c
+++ b/compat/fsmonitor/fsmonitor-fs-listen-macos.c
@@ -97,20 +97,388 @@ void FSEventStreamRelease(FSEventStreamRef stream);
 #include "cache.h"
 #include "fsmonitor.h"
 #include "fsmonitor-fs-listen.h"
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
+		 * trace_printf_key(&trace_fsmonitor, "XXX '%s'", path_k);
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
+		if ((event_flags[k] & kFSEventStreamEventFlagKernelDropped) ||
+		    (event_flags[k] & kFSEventStreamEventFlagUserDropped)) {
+			/*
+			 * see also kFSEventStreamEventFlagMustScanSubDirs
+			 */
+			trace2_data_string("fsmonitor", NULL,
+					   "fsm-listen/kernel", "dropped");
+
+			fsmonitor_force_resync(state);
+
+			if (fsmonitor_batch__free(batch))
+				BUG("batch should not have a next");
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
+				trace2_data_string("fsmonitor", NULL,
+						   "fsm-listen/gitdir",
+						   "removed");
+				goto force_shutdown;
+			}
+			if (ef_is_root_renamed(event_flags[k])) {
+				trace2_data_string("fsmonitor", NULL,
+						   "fsm-listen/gitdir",
+						   "renamed");
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
+			/* fsevent could be marked as both a file and directory */
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
+				char *p = xstrfmt("%s/", rel);
+
+				if (!batch)
+					batch = fsmonitor_batch__new();
+				fsmonitor_batch__add_path(batch, p);
+
+				free(p);
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
+	return;
+
+force_shutdown:
+	if (fsmonitor_batch__free(batch))
+		BUG("batch should not have a next");
+	string_list_clear(&cookie_list, 0);
+
+	data->shutdown_style = FORCE_SHUTDOWN;
+	CFRunLoopStop(data->rl);
+	return;
+}
+
+/*
+ * TODO Investigate the proper value for the `latency` argument in the call
+ * TODO to `FSEventStreamCreate()`.  I'm not sure that this needs to be a
+ * TODO config setting or just something that we tune after some testing.
+ * TODO
+ * TODO With a latency of 0.1, I was seeing lots of dropped events during
+ * TODO the "touch 100000" files test within t/perf/p7519, but with a
+ * TODO latency of 0.001 I did not see any dropped events.  So the "correct"
+ * TODO value may be somewhere in between.
+ * TODO
+ * TODO https://developer.apple.com/documentation/coreservices/1443980-fseventstreamcreate
+ */
 
 int fsmonitor_fs_listen__ctor(struct fsmonitor_daemon_state *state)
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
+	data = xcalloc(1, sizeof(*data));
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
 
 void fsmonitor_fs_listen__dtor(struct fsmonitor_daemon_state *state)
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
 
 void fsmonitor_fs_listen__stop_async(struct fsmonitor_daemon_state *state)
 {
+	struct fsmonitor_daemon_backend_data *data;
+
+	data = state->backend_data;
+	data->shutdown_style = SHUTDOWN_EVENT;
+
+	CFRunLoopStop(data->rl);
 }
 
 void fsmonitor_fs_listen__loop(struct fsmonitor_daemon_state *state)
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

