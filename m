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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BB88C11F67
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 14:48:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 37A126140C
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 14:48:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233104AbhGAOui (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Jul 2021 10:50:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232934AbhGAOu2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jul 2021 10:50:28 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0D8BC061764
        for <git@vger.kernel.org>; Thu,  1 Jul 2021 07:47:57 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id i8so8666017wrc.0
        for <git@vger.kernel.org>; Thu, 01 Jul 2021 07:47:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=2KYx43qXPqIulIoUrZvaz5cMNrWrv3ENjl/SFqtWWDk=;
        b=WTzecqUd7o13ICzJ9R3s6Zcu5vfgaH6qmxyNV64+jos7Qb7VU0te9u/xTXRA0ODyjX
         UZdCnntTkvqaMwpg3YuLANw+l0QxnmXIxGZdwdZ9WGlEgA+9/hO6l+jz4RV6lVPPUKFF
         YIomyWJx1L4m8y/Bi1DPuEUp9pkZiZoowG7s5KUNyYM8ZrxhUzip0EQFLw1crij9eQ+y
         A1AP9ofL5m4KN5TYs58gctHbiajVLDhhEWnBxcqb/JyBUXurMKI1Pmk07Do2UHOyX3Eb
         xno08fUt8GxqyDKyoSANy/E9eP2pYVj+mw175EfX4mBducmBJ7NjfH27pgdJuPm2JivI
         nPCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=2KYx43qXPqIulIoUrZvaz5cMNrWrv3ENjl/SFqtWWDk=;
        b=M1VIoEOKMMX1ZeE3nazKQuas5vBqpdEWQKTVfyeqG+x2nj2ubZNjoidFE1AnTCTRrX
         nHgiFXf9duic7nc9W+C+LpYKGouNT+LDFynBKwWFlVsF0K9KK0kR1IBT/poFYCzNdsBk
         /V1afo1nuMg3iyqCuKs4Iti722lnShmZNhofoAE4qWuPHCpgACeIpX2VabA21Vb4DNQ6
         Zsza4D/owT494WqgBP1cCxNpKCvyAQeYZITQs4Qt5LnYWwkMbDhGdJWaMudLa1jJdKYD
         Q03F/xvQ1gr8XmHE0aDfHq+TgFIuD0WeGFWzVx2cnJ/OUdIdc8VjdcDSiIC/A+/bZiV8
         nyEA==
X-Gm-Message-State: AOAM532fm99XtvVYJOIz5Qqv5bp7115O9dY5fbnPBUsrGcjfIwFOlUlw
        +4fF2QUPT48KBkC9kIJsRXEFpU3Tiu4=
X-Google-Smtp-Source: ABdhPJzZAN/g14yqqBmIPn0TaxWzbutZCjhR5ZkfKJ36Kyvxmv1MXBkyGg/bbxOkMFrKhJIdnXUx8g==
X-Received: by 2002:a05:6000:108a:: with SMTP id y10mr2400wrw.49.1625150876289;
        Thu, 01 Jul 2021 07:47:56 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b187sm10959464wmh.32.2021.07.01.07.47.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jul 2021 07:47:56 -0700 (PDT)
Message-Id: <84444c44c324751ecaed30a4fa2a868014da4397.1625150864.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.923.v3.git.1625150864.gitgitgadget@gmail.com>
References: <pull.923.v2.git.1621691828.gitgitgadget@gmail.com>
        <pull.923.v3.git.1625150864.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 01 Jul 2021 14:47:28 +0000
Subject: [PATCH v3 18/34] fsmonitor--daemon: create token-based changed path
 cache
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

Teach fsmonitor--daemon to build a list of changed paths and associate
them with a token-id.  This will be used by the platform-specific
backends to accumulate changed paths in response to filesystem events.

The platform-specific file system listener thread receives file system
events containing one or more changed pathnames (with whatever bucketing
or grouping that is convenient for the file system).  These paths are
accumulated (without locking) by the file system layer into a `fsmonitor_batch`.

When the file system layer has drained the kernel event queue, it will
"publish" them to our token queue and make them visible to concurrent
client worker threads.  The token layer is free to combine and/or de-dup
paths within these batches for efficient presentation to clients.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 builtin/fsmonitor--daemon.c | 234 +++++++++++++++++++++++++++++++++++-
 fsmonitor--daemon.h         |  40 ++++++
 2 files changed, 272 insertions(+), 2 deletions(-)

diff --git a/builtin/fsmonitor--daemon.c b/builtin/fsmonitor--daemon.c
index e991925fafc..ea3a52d34e3 100644
--- a/builtin/fsmonitor--daemon.c
+++ b/builtin/fsmonitor--daemon.c
@@ -168,17 +168,27 @@ struct fsmonitor_token_data {
 	uint64_t client_ref_count;
 };
 
+struct fsmonitor_batch {
+	struct fsmonitor_batch *next;
+	uint64_t batch_seq_nr;
+	const char **interned_paths;
+	size_t nr, alloc;
+	time_t pinned_time;
+};
+
 static struct fsmonitor_token_data *fsmonitor_new_token_data(void)
 {
 	static int test_env_value = -1;
 	static uint64_t flush_count = 0;
 	struct fsmonitor_token_data *token;
+	struct fsmonitor_batch *batch;
 
 	CALLOC_ARRAY(token, 1);
+	batch = fsmonitor_batch__new();
 
 	strbuf_init(&token->token_id, 0);
-	token->batch_head = NULL;
-	token->batch_tail = NULL;
+	token->batch_head = batch;
+	token->batch_tail = batch;
 	token->client_ref_count = 0;
 
 	if (test_env_value < 0)
@@ -204,9 +214,147 @@ static struct fsmonitor_token_data *fsmonitor_new_token_data(void)
 		strbuf_addf(&token->token_id, "test_%08x", test_env_value++);
 	}
 
+	/*
+	 * We created a new <token_id> and are starting a new series
+	 * of tokens with a zero <seq_nr>.
+	 *
+	 * Since clients cannot guess our new (non test) <token_id>
+	 * they will always receive a trivial response (because of the
+	 * mismatch on the <token_id>).  The trivial response will
+	 * tell them our new <token_id> so that subsequent requests
+	 * will be relative to our new series.  (And when sending that
+	 * response, we pin the current head of the batch list.)
+	 *
+	 * Even if the client correctly guesses the <token_id>, their
+	 * request of "builtin:<token_id>:0" asks for all changes MORE
+	 * RECENT than batch/bin 0.
+	 *
+	 * This implies that it is a waste to accumulate paths in the
+	 * initial batch/bin (because they will never be transmitted).
+	 *
+	 * So the daemon could be running for days and watching the
+	 * file system, but doesn't need to actually accumulate any
+	 * paths UNTIL we need to set a reference point for a later
+	 * relative request.
+	 *
+	 * However, it is very useful for testing to always have a
+	 * reference point set.  Pin batch 0 to force early file system
+	 * events to accumulate.
+	 */
+	if (test_env_value)
+		batch->pinned_time = time(NULL);
+
 	return token;
 }
 
+struct fsmonitor_batch *fsmonitor_batch__new(void)
+{
+	struct fsmonitor_batch *batch;
+
+	CALLOC_ARRAY(batch, 1);
+
+	return batch;
+}
+
+struct fsmonitor_batch *fsmonitor_batch__pop(struct fsmonitor_batch *batch)
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
+	for (p = token->batch_head; p; p = fsmonitor_batch__pop(p))
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
+ * If there are no concurrent threads readering the current token data
+ * series, we can free it now.  Otherwise, let the last reader free
+ * it.
+ *
+ * Either way, the old token data series is no longer associated with
+ * our state data.
+ */
+static void with_lock__do_force_resync(struct fsmonitor_daemon_state *state)
+{
+	/* assert current thread holding state->main_lock */
+
+	struct fsmonitor_token_data *free_me = NULL;
+	struct fsmonitor_token_data *new_one = NULL;
+
+	new_one = fsmonitor_new_token_data();
+
+	if (state->current_token_data->client_ref_count == 0)
+		free_me = state->current_token_data;
+	state->current_token_data = new_one;
+
+	fsmonitor_free_token_data(free_me);
+}
+
+void fsmonitor_force_resync(struct fsmonitor_daemon_state *state)
+{
+	pthread_mutex_lock(&state->main_lock);
+	with_lock__do_force_resync(state);
+	pthread_mutex_unlock(&state->main_lock);
+}
+
 static ipc_server_application_cb handle_client;
 
 static int handle_client(void *data,
@@ -316,6 +464,81 @@ enum fsmonitor_path_type fsmonitor_classify_path_absolute(
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
+			BUG("token does not have batch");
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
+		} else if (!head->batch_seq_nr) {
+			/*
+			 * Batch 0 is unpinned.  See the note in
+			 * `fsmonitor_new_token_data()` about why we
+			 * don't need to accumulate these paths.
+			 */
+			fsmonitor_batch__pop(batch);
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
+			fsmonitor_batch__pop(batch);
+		}
+	}
+
+	pthread_mutex_unlock(&state->main_lock);
+}
+
 static void *fsmonitor_fs_listen__thread_proc(void *_state)
 {
 	struct fsmonitor_daemon_state *state = _state;
@@ -330,6 +553,13 @@ static void *fsmonitor_fs_listen__thread_proc(void *_state)
 
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
index 7bbb3a27a1c..89a9ef20b24 100644
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
+struct fsmonitor_batch *fsmonitor_batch__pop(struct fsmonitor_batch *batch);
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
@@ -91,5 +112,24 @@ enum fsmonitor_path_type fsmonitor_classify_path_absolute(
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

