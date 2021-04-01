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
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF55FC433ED
	for <git@archiver.kernel.org>; Thu,  1 Apr 2021 17:58:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9321561001
	for <git@archiver.kernel.org>; Thu,  1 Apr 2021 17:58:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235674AbhDAR6H (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Apr 2021 13:58:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236501AbhDARyj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Apr 2021 13:54:39 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 638FEC02D546
        for <git@vger.kernel.org>; Thu,  1 Apr 2021 08:41:19 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id g20so1264874wmk.3
        for <git@vger.kernel.org>; Thu, 01 Apr 2021 08:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=sUFSww/LIdrk0EXQfp6x5iXujoa+SRXqPGQmdJewi9Y=;
        b=et9V1fpxW2AGy3ffRBNOd4/Tg4SVmu7VIa7Ca2LmD3Z7ieTNQP7Xhp1pQoVkmmuj4A
         bXRYS7a6KKPRSpgeWT6lYYot++lkMfqMwGlyElKJlr8IrVuknsKxFFIKnGRerDsL7Iuy
         0wC1Jagx1uHz4YAzgC9YMEoj0BFpApPuW0NlLA/SRzdPLIStmDGvhbIuVNGfMh64cYPj
         UUjsz7IEblC9eiu6gsAPKITCn1AbJR+8DKo7yDU1/GBcGtBdQU8m4orezWHLzB59b1Es
         ABAS6ihTHDyxz1TbQy2T9RDzdY/+gf1ThC4Gw9EHviMth9FucgXt9LVM4oIrezTeYosr
         bDRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=sUFSww/LIdrk0EXQfp6x5iXujoa+SRXqPGQmdJewi9Y=;
        b=aM4nVjNRlXd/n5c7wl5Dm9ekuUG4Wbxe7n5R0z9AhatRiW+J60DuRtPKlCe+POoMNt
         FagWb00nWCmasVGi95Es7CebBIgHuFWyZM3O2wolY0AKdCYkHuVP7xHeVUeUc6LOSYez
         fCpAz/we2oq3cBkkJgiRaCAhoWb6aRD20W0JDTDtI4n8FuVubvtFbyPsZMeHMq5UHjnM
         GGX05/IGC8SQ5XkciWOWc2OtTrKquC+j+R6odyJXHwH9BQhfa1IQW8Cz7VVVXwp1C14b
         8kIauHnIkV096IT216sNJMcBw2TBkcmzOzMugA0kVVow33beK7tLfLaWKJCBWKJkE4aj
         cVVg==
X-Gm-Message-State: AOAM532lNjJ7CNVMvJxY3Gi7/q2L1VIQhqzN2nuGbhW26gzBop6vh+VB
        aXt62x9u3cea9qbrBooZfxk9qgbeC5Q=
X-Google-Smtp-Source: ABdhPJylYrBWnRdEIHebMjavyUdh8iEwHCOdvk1WR6T9bAk7CIOQGS16CxEn+XX9gFGnyBlff9bZig==
X-Received: by 2002:a1c:e18b:: with SMTP id y133mr8681866wmg.22.1617291678081;
        Thu, 01 Apr 2021 08:41:18 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p14sm8533546wmc.30.2021.04.01.08.41.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Apr 2021 08:41:17 -0700 (PDT)
Message-Id: <2b4ae4fc3d622f0fee8eb5e527a51467e13acfc5.1617291666.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.923.git.1617291666.gitgitgadget@gmail.com>
References: <pull.923.git.1617291666.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 01 Apr 2021 15:40:58 +0000
Subject: [PATCH 16/23] fsmonitor--daemon: implement handle_client callback
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

Teach fsmonitor--daemon to respond to IPC requests from client
Git processes and respond with a list of modified pathnames
relative to the provided token.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 builtin/fsmonitor--daemon.c | 335 +++++++++++++++++++++++++++++++++++-
 1 file changed, 333 insertions(+), 2 deletions(-)

diff --git a/builtin/fsmonitor--daemon.c b/builtin/fsmonitor--daemon.c
index 48071d445c49..32df392b25d3 100644
--- a/builtin/fsmonitor--daemon.c
+++ b/builtin/fsmonitor--daemon.c
@@ -7,6 +7,7 @@
 #include "fsmonitor--daemon.h"
 #include "simple-ipc.h"
 #include "khash.h"
+#include "pkt-line.h"
 
 static const char * const builtin_fsmonitor__daemon_usage[] = {
 	N_("git fsmonitor--daemon --start [<options>]"),
@@ -369,19 +370,349 @@ void fsmonitor_force_resync(struct fsmonitor_daemon_state *state)
 	fsmonitor_free_token_data(free_me);
 }
 
+/*
+ * Format an opaque token string to send to the client.
+ */
+static void fsmonitor_format_response_token(
+	struct strbuf *response_token,
+	const struct strbuf *response_token_id,
+	const struct fsmonitor_batch *batch)
+{
+	uint64_t seq_nr = (batch) ? batch->batch_seq_nr + 1 : 0;
+
+	strbuf_reset(response_token);
+	strbuf_addf(response_token, "builtin:%s:%"PRIu64,
+		    response_token_id->buf, seq_nr);
+}
+
+/*
+ * Parse an opaque token from the client.
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
+		return 1;
+
+	while (*p && *p != ':')
+		strbuf_addch(requested_token_id, *p++);
+	if (!*p++)
+		return 1;
+
+	*seq_nr = (uint64_t)strtoumax(p, &p_end, 10);
+	if (*p_end)
+		return 1;
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
+	int result;
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
+	}
+
+	if (!strcmp(command, "flush")) {
+		/*
+		 * Flush all of our cached data and generate a new token
+		 * just like if we lost sync with the filesystem.
+		 *
+		 * Then send a trivial response using the new token.
+		 */
+		fsmonitor_force_resync(state);
+		result = 0;
+		goto send_trivial_response;
+	}
+
+	if (!skip_prefix(command, "builtin:", &p)) {
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
+		result = -1;
+		goto send_trivial_response;
+	}
+
+	/* try V2 token */
+
+	if (fsmonitor_parse_client_token(command, &requested_token_id,
+					 &requested_oldest_seq_nr)) {
+		trace_printf_key(&trace_fsmonitor,
+				 "fsmonitor: invalid V2 protocol token '%s'",
+				 command);
+		result = -1;
+		goto send_trivial_response;
+	}
+
+	pthread_mutex_lock(&state->main_lock);
+
+	if (!state->current_token_data) {
+		/*
+		 * We don't have a current token.  This may mean that
+		 * the listener thread has not yet started.
+		 */
+		pthread_mutex_unlock(&state->main_lock);
+		result = 0;
+		goto send_trivial_response;
+	}
+	if (strcmp(requested_token_id.buf,
+		   state->current_token_data->token_id.buf)) {
+		/*
+		 * The client last spoke to a different daemon
+		 * instance -OR- the daemon had to resync with
+		 * the filesystem (and lost events), so reject.
+		 */
+		pthread_mutex_unlock(&state->main_lock);
+		result = 0;
+		trace2_data_string("fsmonitor", the_repository,
+				   "response/token", "different");
+		goto send_trivial_response;
+	}
+	if (!state->current_token_data->batch_tail) {
+		/*
+		 * The listener has not received any filesystem
+		 * events yet since we created the current token.
+		 * We can respond with an empty list, since the
+		 * client has already seen the current token and
+		 * we have nothing new to report.  (This is
+		 * instead of sending a trivial response.)
+		 */
+		pthread_mutex_unlock(&state->main_lock);
+		result = 0;
+		goto send_empty_response;
+	}
+	if (requested_oldest_seq_nr <
+	    state->current_token_data->batch_tail->batch_seq_nr) {
+		/*
+		 * The client wants older events than we have for
+		 * this token_id.  This means that the end of our
+		 * batch list was truncated and we cannot give the
+		 * client a complete snapshot relative to their
+		 * request.
+		 */
+		pthread_mutex_unlock(&state->main_lock);
+
+		trace_printf_key(&trace_fsmonitor,
+				 "client requested truncated data");
+		result = 0;
+		goto send_trivial_response;
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
+	 *
+	 * We mark the current head of the batch list as "pinned" so
+	 * that the listener thread will treat this item as read-only
+	 * (and prevent any more paths from being added to it) from
+	 * now on.
+	 */
+	token_data = state->current_token_data;
+	token_data->client_ref_count++;
+
+	batch_head = token_data->batch_head;
+	((struct fsmonitor_batch *)batch_head)->pinned_time = time(NULL);
+
+	pthread_mutex_unlock(&state->main_lock);
+
+	/*
+	 * FSMonitor Protocol V2 requires that we send a response header
+	 * with a "new current token" and then all of the paths that changed
+	 * since the "requested token".
+	 */
+	fsmonitor_format_response_token(&response_token,
+					&token_data->token_id,
+					batch_head);
+
+	reply(reply_data, response_token.buf, response_token.len + 1);
+	total_response_len += response_token.len + 1;
+
+	trace2_data_string("fsmonitor", the_repository, "response/token",
+			   response_token.buf);
+	trace_printf_key(&trace_fsmonitor, "response token: %s", response_token.buf);
+
+	shown = kh_init_str();
+	for (batch = batch_head;
+	     batch && batch->batch_seq_nr >= requested_oldest_seq_nr;
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
+
+send_trivial_response:
+	pthread_mutex_lock(&state->main_lock);
+	fsmonitor_format_response_token(&response_token,
+					&state->current_token_data->token_id,
+					state->current_token_data->batch_head);
+	pthread_mutex_unlock(&state->main_lock);
+
+	reply(reply_data, response_token.buf, response_token.len + 1);
+	trace2_data_string("fsmonitor", the_repository, "response/token",
+			   response_token.buf);
+	reply(reply_data, "/", 2);
+	trace2_data_intmax("fsmonitor", the_repository, "response/trivial", 1);
+
+	strbuf_release(&response_token);
+	strbuf_release(&requested_token_id);
+
+	return result;
+
+send_empty_response:
+	pthread_mutex_lock(&state->main_lock);
+	fsmonitor_format_response_token(&response_token,
+					&state->current_token_data->token_id,
+					NULL);
+	pthread_mutex_unlock(&state->main_lock);
+
+	reply(reply_data, response_token.buf, response_token.len + 1);
+	trace2_data_string("fsmonitor", the_repository, "response/token",
+			   response_token.buf);
+	trace2_data_intmax("fsmonitor", the_repository, "response/empty", 1);
+
+	strbuf_release(&response_token);
+	strbuf_release(&requested_token_id);
+
+	return 0;
+}
+
 static ipc_server_application_cb handle_client;
 
 static int handle_client(void *data, const char *command,
 			 ipc_server_reply_cb *reply,
 			 struct ipc_server_reply_data *reply_data)
 {
-	/* struct fsmonitor_daemon_state *state = data; */
+	struct fsmonitor_daemon_state *state = data;
 	int result;
 
+	trace_printf_key(&trace_fsmonitor, "requested token: %s", command);
+
 	trace2_region_enter("fsmonitor", "handle_client", the_repository);
 	trace2_data_string("fsmonitor", the_repository, "request", command);
 
-	result = 0; /* TODO Do something here. */
+	result = do_handle_client(state, command, reply, reply_data);
 
 	trace2_region_leave("fsmonitor", "handle_client", the_repository);
 
-- 
gitgitgadget

