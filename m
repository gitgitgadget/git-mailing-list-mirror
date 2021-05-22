Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79846C2B9FB
	for <git@archiver.kernel.org>; Sat, 22 May 2021 13:57:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 581A86115C
	for <git@archiver.kernel.org>; Sat, 22 May 2021 13:57:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231405AbhEVN7H (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 22 May 2021 09:59:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231279AbhEVN6u (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 May 2021 09:58:50 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85678C06138C
        for <git@vger.kernel.org>; Sat, 22 May 2021 06:57:24 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id n2so23816201wrm.0
        for <git@vger.kernel.org>; Sat, 22 May 2021 06:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=8w2tffOGt/kmaTT7ylsf+xJSswz23K2L+q3i3VMMYS8=;
        b=oIIz3TvBsBiipZ+RrUkDThvvmRM5aHB0mpda+COwfKY/A7cTXfKFBPG/38FwO0kEpS
         nONbSOBWKjByeVDqE7oWW6g0ZjBnoYZKXUJavf/mBWrfPeENk/ywxqIJ1OKslVja4Cu3
         a+5FWmU2hTkDhLJjvDyGfuG53V+g906szvPSXVxHomAnhVzELfdd94kf71O2DIZqBhrO
         eovMoKGbi/wPvm5PHOXJrryhdCq2NwviZhJX9wS6ANwFdb84vOLxVy6ZlamweSDM5FHe
         xOoFBPpNCulUQcMedq3jGlnQIZuNsUdXWsfwqYZYyj5KsMEAl9UZkO/do96QQkLbFQxk
         x6qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=8w2tffOGt/kmaTT7ylsf+xJSswz23K2L+q3i3VMMYS8=;
        b=Qw8pmXs5qBUtdN/t0dylayV/O0wsN7EC4IT5fR/WTPRBnXrv/xvPP523kUiuBKpCR5
         1/jFoPbZ5TMntIpy+PW10eBlUStGZ1bibcVfXs0fcYH9heb1f8EzgI7iduDTWsrF8Kis
         b3ig1Tn/OHoH+qGTgcZ1efXBhrB5e+x6nTcgOGaQE45XFRlcJEzjbhwSBleCPeLVbQtW
         g8zXT7AttrcZv8LqRw0xcaqX+OGvo24L/eZDTjlU+0lu2twNE+woPDmBoETQZJTbfIWk
         o5k1T7nbJzBxcVucQkKypVpBydeMpK7cpNDMUCVn4CdN3od/gaJ1yMj1rPSqJCJPuYkR
         3Buw==
X-Gm-Message-State: AOAM530FE/VEyYk/mK/IeniVORk9d5N+vC5AD5K4EStJiHCBUUXlU347
        vXWr0s909ovBuSVkZbSLF+GdB5tevkc=
X-Google-Smtp-Source: ABdhPJzv0xZoOr7/pDPSLdJ8VXp/PHeZxYD6jBrUpnjzQ5WazHRnOWsA1h4p2L0hKDYgUoQmW+ULhQ==
X-Received: by 2002:a5d:4346:: with SMTP id u6mr14302585wrr.304.1621691843104;
        Sat, 22 May 2021 06:57:23 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l18sm5412477wrt.97.2021.05.22.06.57.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 May 2021 06:57:22 -0700 (PDT)
Message-Id: <cc4a596d17c7036534bae9865170a8c9b7ad0818.1621691828.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.923.v2.git.1621691828.gitgitgadget@gmail.com>
References: <pull.923.git.1617291666.gitgitgadget@gmail.com>
        <pull.923.v2.git.1621691828.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 22 May 2021 13:56:59 +0000
Subject: [PATCH v2 20/28] fsmonitor--daemon: implement handle_client callback
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

Teach fsmonitor--daemon to respond to IPC requests from client
Git processes and respond with a list of modified pathnames
relative to the provided token.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 builtin/fsmonitor--daemon.c | 312 +++++++++++++++++++++++++++++++++++-
 1 file changed, 310 insertions(+), 2 deletions(-)

diff --git a/builtin/fsmonitor--daemon.c b/builtin/fsmonitor--daemon.c
index 663fead0d66e..33b4f09c72ca 100644
--- a/builtin/fsmonitor--daemon.c
+++ b/builtin/fsmonitor--daemon.c
@@ -7,6 +7,7 @@
 #include "fsmonitor--daemon.h"
 #include "simple-ipc.h"
 #include "khash.h"
+#include "pkt-line.h"
 
 static const char * const builtin_fsmonitor__daemon_usage[] = {
 	N_("git fsmonitor--daemon start [<options>]"),
@@ -353,6 +354,311 @@ void fsmonitor_force_resync(struct fsmonitor_daemon_state *state)
 	pthread_mutex_unlock(&state->main_lock);
 }
 
+/*
+ * Format an opaque token string to send to the client.
+ */
+static void with_lock__format_response_token(
+	struct strbuf *response_token,
+	const struct strbuf *response_token_id,
+	const struct fsmonitor_batch *batch)
+{
+	/* assert current thread holding state->main_lock */
+
+	strbuf_reset(response_token);
+	strbuf_addf(response_token, "builtin:%s:%"PRIu64,
+		    response_token_id->buf, batch->batch_seq_nr);
+}
+
+/*
+ * Parse an opaque token from the client.
+ * Returns -1 on error.
+ */
+static int fsmonitor_parse_client_token(const char *buf_token,
+					struct strbuf *requested_token_id,
+					uint64_t *seq_nr)
+{
+	const char *p;
+	char *p_end;
+
+	strbuf_reset(requested_token_id);
+	*seq_nr = 0;
+
+	if (!skip_prefix(buf_token, "builtin:", &p))
+		return -1;
+
+	while (*p && *p != ':')
+		strbuf_addch(requested_token_id, *p++);
+	if (!*p++)
+		return -1;
+
+	*seq_nr = (uint64_t)strtoumax(p, &p_end, 10);
+	if (*p_end)
+		return -1;
+
+	return 0;
+}
+
+KHASH_INIT(str, const char *, int, 0, kh_str_hash_func, kh_str_hash_equal);
+
+static int do_handle_client(struct fsmonitor_daemon_state *state,
+			    const char *command,
+			    ipc_server_reply_cb *reply,
+			    struct ipc_server_reply_data *reply_data)
+{
+	struct fsmonitor_token_data *token_data = NULL;
+	struct strbuf response_token = STRBUF_INIT;
+	struct strbuf requested_token_id = STRBUF_INIT;
+	struct strbuf payload = STRBUF_INIT;
+	uint64_t requested_oldest_seq_nr = 0;
+	uint64_t total_response_len = 0;
+	const char *p;
+	const struct fsmonitor_batch *batch_head;
+	const struct fsmonitor_batch *batch;
+	intmax_t count = 0, duplicates = 0;
+	kh_str_t *shown;
+	int hash_ret;
+	int do_trivial = 0;
+	int do_flush = 0;
+
+	/*
+	 * We expect `command` to be of the form:
+	 *
+	 * <command> := quit NUL
+	 *            | flush NUL
+	 *            | <V1-time-since-epoch-ns> NUL
+	 *            | <V2-opaque-fsmonitor-token> NUL
+	 */
+
+	if (!strcmp(command, "quit")) {
+		/*
+		 * A client has requested over the socket/pipe that the
+		 * daemon shutdown.
+		 *
+		 * Tell the IPC thread pool to shutdown (which completes
+		 * the await in the main thread (which can stop the
+		 * fsmonitor listener thread)).
+		 *
+		 * There is no reply to the client.
+		 */
+		return SIMPLE_IPC_QUIT;
+
+	} else if (!strcmp(command, "flush")) {
+		/*
+		 * Flush all of our cached data and generate a new token
+		 * just like if we lost sync with the filesystem.
+		 *
+		 * Then send a trivial response using the new token.
+		 */
+		do_flush = 1;
+		do_trivial = 1;
+
+	} else if (!skip_prefix(command, "builtin:", &p)) {
+		/* assume V1 timestamp or garbage */
+
+		char *p_end;
+
+		strtoumax(command, &p_end, 10);
+		trace_printf_key(&trace_fsmonitor,
+				 ((*p_end) ?
+				  "fsmonitor: invalid command line '%s'" :
+				  "fsmonitor: unsupported V1 protocol '%s'"),
+				 command);
+		do_trivial = 1;
+
+	} else {
+		/* We have "builtin:*" */
+		if (fsmonitor_parse_client_token(command, &requested_token_id,
+						 &requested_oldest_seq_nr)) {
+			trace_printf_key(&trace_fsmonitor,
+					 "fsmonitor: invalid V2 protocol token '%s'",
+					 command);
+			do_trivial = 1;
+
+		} else {
+			/*
+			 * We have a V2 valid token:
+			 *     "builtin:<token_id>:<seq_nr>"
+			 */
+		}
+	}
+
+	pthread_mutex_lock(&state->main_lock);
+
+	if (!state->current_token_data)
+		BUG("fsmonitor state does not have a current token");
+
+	if (do_flush)
+		with_lock__do_force_resync(state);
+
+	/*
+	 * We mark the current head of the batch list as "pinned" so
+	 * that the listener thread will treat this item as read-only
+	 * (and prevent any more paths from being added to it) from
+	 * now on.
+	 */
+	token_data = state->current_token_data;
+	batch_head = token_data->batch_head;
+	((struct fsmonitor_batch *)batch_head)->pinned_time = time(NULL);
+
+	/*
+	 * FSMonitor Protocol V2 requires that we send a response header
+	 * with a "new current token" and then all of the paths that changed
+	 * since the "requested token".  We send the seq_nr of the just-pinned
+	 * head batch so that future requests from a client will be relative
+	 * to it.
+	 */
+	with_lock__format_response_token(&response_token,
+					 &token_data->token_id, batch_head);
+
+	reply(reply_data, response_token.buf, response_token.len + 1);
+	total_response_len += response_token.len + 1;
+
+	trace2_data_string("fsmonitor", the_repository, "response/token",
+			   response_token.buf);
+	trace_printf_key(&trace_fsmonitor, "response token: %s",
+			 response_token.buf);
+
+	if (!do_trivial) {
+		if (strcmp(requested_token_id.buf, token_data->token_id.buf)) {
+			/*
+			 * The client last spoke to a different daemon
+			 * instance -OR- the daemon had to resync with
+			 * the filesystem (and lost events), so reject.
+			 */
+			trace2_data_string("fsmonitor", the_repository,
+					   "response/token", "different");
+			do_trivial = 1;
+
+		} else if (requested_oldest_seq_nr <
+			   token_data->batch_tail->batch_seq_nr) {
+			/*
+			 * The client wants older events than we have for
+			 * this token_id.  This means that the end of our
+			 * batch list was truncated and we cannot give the
+			 * client a complete snapshot relative to their
+			 * request.
+			 */
+			trace_printf_key(&trace_fsmonitor,
+					 "client requested truncated data");
+			do_trivial = 1;
+		}
+	}
+
+	if (do_trivial) {
+		pthread_mutex_unlock(&state->main_lock);
+
+		reply(reply_data, "/", 2);
+
+		trace2_data_intmax("fsmonitor", the_repository,
+				   "response/trivial", 1);
+
+		strbuf_release(&response_token);
+		strbuf_release(&requested_token_id);
+		return 0;
+	}
+
+	/*
+	 * We're going to hold onto a pointer to the current
+	 * token-data while we walk the list of batches of files.
+	 * During this time, we will NOT be under the lock.
+	 * So we ref-count it.
+	 *
+	 * This allows the listener thread to continue prepending
+	 * new batches of items to the token-data (which we'll ignore).
+	 *
+	 * AND it allows the listener thread to do a token-reset
+	 * (and install a new `current_token_data`).
+	 */
+	token_data->client_ref_count++;
+
+	pthread_mutex_unlock(&state->main_lock);
+
+	/*
+	 * The client request is relative to the token that they sent,
+	 * so walk the batch list backwards from the current head back
+	 * to the batch (sequence number) they named.
+	 *
+	 * We use khash to de-dup the list of pathnames.
+	 *
+	 * NEEDSWORK: each batch contains a list of interned strings,
+	 * so we only need to do pointer comparisons here to build the
+	 * hash table.  Currently, we're still comparing the string
+	 * values.
+	 */
+	shown = kh_init_str();
+	for (batch = batch_head;
+	     batch && batch->batch_seq_nr > requested_oldest_seq_nr;
+	     batch = batch->next) {
+		size_t k;
+
+		for (k = 0; k < batch->nr; k++) {
+			const char *s = batch->interned_paths[k];
+			size_t s_len;
+
+			if (kh_get_str(shown, s) != kh_end(shown))
+				duplicates++;
+			else {
+				kh_put_str(shown, s, &hash_ret);
+
+				trace_printf_key(&trace_fsmonitor,
+						 "send[%"PRIuMAX"]: %s",
+						 count, s);
+
+				/* Each path gets written with a trailing NUL */
+				s_len = strlen(s) + 1;
+
+				if (payload.len + s_len >=
+				    LARGE_PACKET_DATA_MAX) {
+					reply(reply_data, payload.buf,
+					      payload.len);
+					total_response_len += payload.len;
+					strbuf_reset(&payload);
+				}
+
+				strbuf_add(&payload, s, s_len);
+				count++;
+			}
+		}
+	}
+
+	if (payload.len) {
+		reply(reply_data, payload.buf, payload.len);
+		total_response_len += payload.len;
+	}
+
+	kh_release_str(shown);
+
+	pthread_mutex_lock(&state->main_lock);
+
+	if (token_data->client_ref_count > 0)
+		token_data->client_ref_count--;
+
+	if (token_data->client_ref_count == 0) {
+		if (token_data != state->current_token_data) {
+			/*
+			 * The listener thread did a token-reset while we were
+			 * walking the batch list.  Therefore, this token is
+			 * stale and can be discarded completely.  If we are
+			 * the last reader thread using this token, we own
+			 * that work.
+			 */
+			fsmonitor_free_token_data(token_data);
+		}
+	}
+
+	pthread_mutex_unlock(&state->main_lock);
+
+	trace2_data_intmax("fsmonitor", the_repository, "response/length", total_response_len);
+	trace2_data_intmax("fsmonitor", the_repository, "response/count/files", count);
+	trace2_data_intmax("fsmonitor", the_repository, "response/count/duplicates", duplicates);
+
+	strbuf_release(&response_token);
+	strbuf_release(&requested_token_id);
+	strbuf_release(&payload);
+
+	return 0;
+}
+
 static ipc_server_application_cb handle_client;
 
 static int handle_client(void *data,
@@ -360,7 +666,7 @@ static int handle_client(void *data,
 			 ipc_server_reply_cb *reply,
 			 struct ipc_server_reply_data *reply_data)
 {
-	/* struct fsmonitor_daemon_state *state = data; */
+	struct fsmonitor_daemon_state *state = data;
 	int result;
 
 	/*
@@ -371,10 +677,12 @@ static int handle_client(void *data,
 	if (command_len != strlen(command))
 		BUG("FSMonitor assumes text messages");
 
+	trace_printf_key(&trace_fsmonitor, "requested token: %s", command);
+
 	trace2_region_enter("fsmonitor", "handle_client", the_repository);
 	trace2_data_string("fsmonitor", the_repository, "request", command);
 
-	result = 0; /* TODO Do something here. */
+	result = do_handle_client(state, command, reply, reply_data);
 
 	trace2_region_leave("fsmonitor", "handle_client", the_repository);
 
-- 
gitgitgadget

