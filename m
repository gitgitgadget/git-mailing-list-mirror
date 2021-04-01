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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6AB8C43617
	for <git@archiver.kernel.org>; Thu,  1 Apr 2021 17:48:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A557360FF3
	for <git@archiver.kernel.org>; Thu,  1 Apr 2021 17:48:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235874AbhDARr7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Apr 2021 13:47:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235879AbhDARnR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Apr 2021 13:43:17 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D53D4C02D542
        for <git@vger.kernel.org>; Thu,  1 Apr 2021 08:41:16 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id u5-20020a7bcb050000b029010e9316b9d5so1131720wmj.2
        for <git@vger.kernel.org>; Thu, 01 Apr 2021 08:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=vKFtf8iU/88j++X/TQINz0X5kBgggdAz2WOyyunvvEs=;
        b=gYFGN3I9pf2R1hV4ottALnrGTfk+f/yrPlxFUZYEpvOIndDoJxs6zUZ0tcXRi6aD/Z
         YVShIOnB3U0+wqvoDBiXl0IQ2ICPTs7HZRXPFw26p057gyAP/TgeGG4EQY66ANmP2sLV
         3MslXiHABYbpuQyF0/GEl5z4rntXugVjMH0qckpk/HT3AFmQzp7ByaqaL/HPFBrSfjya
         c+nAIfXcIDw7ZtNn7+AJqqDKzdfhqVdnZhJd90MlqWws33T6VaczhAn+JYMboiKBhtaS
         jwRFQ7sr9XU43aeKUkgwjhPXouJhAK2SsKcF5JIq90y9RSAIi7MMXAaDeSxyZNozHhnj
         O5Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=vKFtf8iU/88j++X/TQINz0X5kBgggdAz2WOyyunvvEs=;
        b=uJmJY6q6k2YdjnQGxIvw+u9Gw6jdV4mRSQ/33kZ+2MREkidywV/QGmbacpw/qgULq3
         Ra/BFfZAtI0pQ/Codqan7eXXKDYNd4L8rUYhv+cTa3hfGpCW3L97LBfFGT9ujjSmX3b4
         iho6TKTdPRYxz3s0LhqEaC0PwGf5H1JEQhdVIPorsnTGwBLztNE2Tz7XJVKq4I6DB+ZO
         07nl4VF2sRSOXj3EQzicRnmIFkvaxoM3o97BbkPgK+D/8ldJet3k7W4zB8UW9Elir8Ep
         RlB7LpuUcgkVmXRaSxaihBqdAKIAt0aP2zE8mmQvxJmRjass43cTgnuxGZlW+aUpE0/o
         V3BQ==
X-Gm-Message-State: AOAM533eq0NwKPjLi8rIAFlbLbs7wIStLCtNcOdlhwsljL/Q3avRMKAp
        EfWsiv5pEN6XalDQehwNv04b718Agts=
X-Google-Smtp-Source: ABdhPJxd81Uj+F5Bhrf4UXgjx01ivL3Fkvb0MQdBSUu56QRLMp8LB+bzmEcyeDsmGd56Ftar2dfWZQ==
X-Received: by 2002:a7b:cb90:: with SMTP id m16mr8651825wmi.162.1617291675611;
        Thu, 01 Apr 2021 08:41:15 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v18sm10737642wru.85.2021.04.01.08.41.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Apr 2021 08:41:15 -0700 (PDT)
Message-Id: <f1fa803ebe9c9f78608c22e55ec590f8c6775c94.1617291666.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.923.git.1617291666.gitgitgadget@gmail.com>
References: <pull.923.git.1617291666.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 01 Apr 2021 15:40:54 +0000
Subject: [PATCH 12/23] fsmonitor--daemon: create token-based changed path
 cache
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

Teach fsmonitor--daemon to build lists of changed paths and associate
them with a token-id.  This will be used by the platform-specific
backends to accumulate changed paths in response to filesystem events.

The platform-specific event loops receive batches containing one or
more changed paths.  Their fs listener thread will accumulate them in
a `fsmonitor_batch` (and without locking) and then "publish" them to
associate them with the current token and to make them visible to the
client worker threads.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 builtin/fsmonitor--daemon.c | 192 ++++++++++++++++++++++++++++++++++++
 fsmonitor--daemon.h         |  40 ++++++++
 2 files changed, 232 insertions(+)

diff --git a/builtin/fsmonitor--daemon.c b/builtin/fsmonitor--daemon.c
index 2d25e36601fe..48071d445c49 100644
--- a/builtin/fsmonitor--daemon.c
+++ b/builtin/fsmonitor--daemon.c
@@ -255,6 +255,120 @@ static struct fsmonitor_token_data *fsmonitor_new_token_data(void)
 	return token;
 }
 
+struct fsmonitor_batch {
+	struct fsmonitor_batch *next;
+	uint64_t batch_seq_nr;
+	const char **interned_paths;
+	size_t nr, alloc;
+	time_t pinned_time;
+};
+
+struct fsmonitor_batch *fsmonitor_batch__new(void)
+{
+	struct fsmonitor_batch *batch = xcalloc(1, sizeof(*batch));
+
+	return batch;
+}
+
+struct fsmonitor_batch *fsmonitor_batch__free(struct fsmonitor_batch *batch)
+{
+	struct fsmonitor_batch *next;
+
+	if (!batch)
+		return NULL;
+
+	next = batch->next;
+
+	/*
+	 * The actual strings within the array are interned, so we don't
+	 * own them.
+	 */
+	free(batch->interned_paths);
+
+	return next;
+}
+
+void fsmonitor_batch__add_path(struct fsmonitor_batch *batch,
+			       const char *path)
+{
+	const char *interned_path = strintern(path);
+
+	trace_printf_key(&trace_fsmonitor, "event: %s", interned_path);
+
+	ALLOC_GROW(batch->interned_paths, batch->nr + 1, batch->alloc);
+	batch->interned_paths[batch->nr++] = interned_path;
+}
+
+static void fsmonitor_batch__combine(struct fsmonitor_batch *batch_dest,
+				     const struct fsmonitor_batch *batch_src)
+{
+	/* assert state->main_lock */
+
+	size_t k;
+
+	ALLOC_GROW(batch_dest->interned_paths,
+		   batch_dest->nr + batch_src->nr + 1,
+		   batch_dest->alloc);
+
+	for (k = 0; k < batch_src->nr; k++)
+		batch_dest->interned_paths[batch_dest->nr++] =
+			batch_src->interned_paths[k];
+}
+
+static void fsmonitor_free_token_data(struct fsmonitor_token_data *token)
+{
+	struct fsmonitor_batch *p;
+
+	if (!token)
+		return;
+
+	assert(token->client_ref_count == 0);
+
+	strbuf_release(&token->token_id);
+
+	for (p = token->batch_head; p; p = fsmonitor_batch__free(p))
+		;
+
+	free(token);
+}
+
+/*
+ * Flush all of our cached data about the filesystem.  Call this if we
+ * lose sync with the filesystem and miss some notification events.
+ *
+ * [1] If we are missing events, then we no longer have a complete
+ *     history of the directory (relative to our current start token).
+ *     We should create a new token and start fresh (as if we just
+ *     booted up).
+ *
+ * If there are no readers of the the current token data series, we
+ * can free it now.  Otherwise, let the last reader free it.  Either
+ * way, the old token data series is no longer associated with our
+ * state data.
+ */
+void fsmonitor_force_resync(struct fsmonitor_daemon_state *state)
+{
+	struct fsmonitor_token_data *free_me = NULL;
+	struct fsmonitor_token_data *new_one = NULL;
+
+	new_one = fsmonitor_new_token_data();
+
+	pthread_mutex_lock(&state->main_lock);
+
+	trace_printf_key(&trace_fsmonitor,
+			 "force resync [old '%s'][new '%s']",
+			 state->current_token_data->token_id.buf,
+			 new_one->token_id.buf);
+
+	if (state->current_token_data->client_ref_count == 0)
+		free_me = state->current_token_data;
+	state->current_token_data = new_one;
+
+	pthread_mutex_unlock(&state->main_lock);
+
+	fsmonitor_free_token_data(free_me);
+}
+
 static ipc_server_application_cb handle_client;
 
 static int handle_client(void *data, const char *command,
@@ -355,6 +469,77 @@ enum fsmonitor_path_type fsmonitor_classify_path_absolute(
 	return fsmonitor_classify_path_gitdir_relative(rel);
 }
 
+/*
+ * We try to combine small batches at the front of the batch-list to avoid
+ * having a long list.  This hopefully makes it a little easier when we want
+ * to truncate and maintain the list.  However, we don't want the paths array
+ * to just keep growing and growing with realloc, so we insert an arbitrary
+ * limit.
+ */
+#define MY_COMBINE_LIMIT (1024)
+
+void fsmonitor_publish(struct fsmonitor_daemon_state *state,
+		       struct fsmonitor_batch *batch,
+		       const struct string_list *cookie_names)
+{
+	if (!batch && !cookie_names->nr)
+		return;
+
+	pthread_mutex_lock(&state->main_lock);
+
+	if (batch) {
+		struct fsmonitor_batch *head;
+
+		head = state->current_token_data->batch_head;
+		if (!head) {
+			batch->batch_seq_nr = 0;
+			batch->next = NULL;
+			state->current_token_data->batch_head = batch;
+			state->current_token_data->batch_tail = batch;
+		} else if (head->pinned_time) {
+			/*
+			 * We cannot alter the current batch list
+			 * because:
+			 *
+			 * [a] it is being transmitted to at least one
+			 * client and the handle_client() thread has a
+			 * ref-count, but not a lock on the batch list
+			 * starting with this item.
+			 *
+			 * [b] it has been transmitted in the past to
+			 * at least one client such that future
+			 * requests are relative to this head batch.
+			 *
+			 * So, we can only prepend a new batch onto
+			 * the front of the list.
+			 */
+			batch->batch_seq_nr = head->batch_seq_nr + 1;
+			batch->next = head;
+			state->current_token_data->batch_head = batch;
+		} else if (head->nr + batch->nr > MY_COMBINE_LIMIT) {
+			/*
+			 * The head batch in the list has never been
+			 * transmitted to a client, but folding the
+			 * contents of the new batch onto it would
+			 * exceed our arbitrary limit, so just prepend
+			 * the new batch onto the list.
+			 */
+			batch->batch_seq_nr = head->batch_seq_nr + 1;
+			batch->next = head;
+			state->current_token_data->batch_head = batch;
+		} else {
+			/*
+			 * We are free to append the paths in the given
+			 * batch onto the end of the current head batch.
+			 */
+			fsmonitor_batch__combine(head, batch);
+			fsmonitor_batch__free(batch);
+		}
+	}
+
+	pthread_mutex_unlock(&state->main_lock);
+}
+
 static void *fsmonitor_fs_listen__thread_proc(void *_state)
 {
 	struct fsmonitor_daemon_state *state = _state;
@@ -369,6 +554,13 @@ static void *fsmonitor_fs_listen__thread_proc(void *_state)
 
 	fsmonitor_fs_listen__loop(state);
 
+	pthread_mutex_lock(&state->main_lock);
+	if (state->current_token_data &&
+	    state->current_token_data->client_ref_count == 0)
+		fsmonitor_free_token_data(state->current_token_data);
+	state->current_token_data = NULL;
+	pthread_mutex_unlock(&state->main_lock);
+
 	trace2_thread_exit();
 	return NULL;
 }
diff --git a/fsmonitor--daemon.h b/fsmonitor--daemon.h
index 97ea3766e900..06563b6ed56c 100644
--- a/fsmonitor--daemon.h
+++ b/fsmonitor--daemon.h
@@ -12,6 +12,27 @@
 struct fsmonitor_batch;
 struct fsmonitor_token_data;
 
+/*
+ * Create a new batch of path(s).  The returned batch is considered
+ * private and not linked into the fsmonitor daemon state.  The caller
+ * should fill this batch with one or more paths and then publish it.
+ */
+struct fsmonitor_batch *fsmonitor_batch__new(void);
+
+/*
+ * Free this batch and return the value of the batch->next field.
+ */
+struct fsmonitor_batch *fsmonitor_batch__free(struct fsmonitor_batch *batch);
+
+/*
+ * Add this path to this batch of modified files.
+ *
+ * The batch should be private and NOT (yet) linked into the fsmonitor
+ * daemon state and therefore not yet visible to worker threads and so
+ * no locking is required.
+ */
+void fsmonitor_batch__add_path(struct fsmonitor_batch *batch, const char *path);
+
 struct fsmonitor_daemon_backend_data; /* opaque platform-specific data */
 
 struct fsmonitor_daemon_state {
@@ -93,5 +114,24 @@ enum fsmonitor_path_type fsmonitor_classify_path_absolute(
 	struct fsmonitor_daemon_state *state,
 	const char *path);
 
+/*
+ * Prepend the this batch of path(s) onto the list of batches associated
+ * with the current token.  This makes the batch visible to worker threads.
+ *
+ * The caller no longer owns the batch and must not free it.
+ *
+ * Wake up the client threads waiting on these cookies.
+ */
+void fsmonitor_publish(struct fsmonitor_daemon_state *state,
+		       struct fsmonitor_batch *batch,
+		       const struct string_list *cookie_names);
+
+/*
+ * If the platform-specific layer loses sync with the filesystem,
+ * it should call this to invalidate cached data and abort waiting
+ * threads.
+ */
+void fsmonitor_force_resync(struct fsmonitor_daemon_state *state);
+
 #endif /* HAVE_FSMONITOR_DAEMON_BACKEND */
 #endif /* FSMONITOR_DAEMON_H */
-- 
gitgitgadget

