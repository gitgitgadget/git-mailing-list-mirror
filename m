Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B020DC433F5
	for <git@archiver.kernel.org>; Fri, 11 Feb 2022 20:57:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353586AbiBKU5Z (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Feb 2022 15:57:25 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353615AbiBKU4w (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Feb 2022 15:56:52 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51D98D87
        for <git@vger.kernel.org>; Fri, 11 Feb 2022 12:56:44 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id e3so17265575wra.0
        for <git@vger.kernel.org>; Fri, 11 Feb 2022 12:56:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=OT4wk9P2uUf/lbNctyV/RDTLgCDHNMc8joLfeeBdOks=;
        b=UrjJRNnbQdKGFO+YlgkqlJ98RNKBJIWRG+3XtBSJ1lPcwiQnJFmZOUunIWQ78Rl8QF
         HNMDPUMhGL81SEtguEvyW38gvEQOb0962DCx2Buhk945MGQqrAws5qJGz+ibfcn8wCy8
         NpKfmPzKurDquWxEoPq6GLjlNAjmDFv/JNn0UqK5mVMFOO1ahPji4QDwb+8lVD1L6prz
         y3FBD9hUSFLmveq4dBhGBbaEMMh7Gwrn4Z6PrSh0HC23SlH+ohQIoseL/3yVm5988C5T
         xUWVVU6E1+B6qPEG1hJ373ibpN3SZG5IXAZPmGH0XLnZaissdzAqfabSQihSFvBx/I3g
         cSBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=OT4wk9P2uUf/lbNctyV/RDTLgCDHNMc8joLfeeBdOks=;
        b=hKzOTXNx6jHvz0QFmPlsjogcgrin3n3x1oeUZ19vUN5eGOZYO5gzHnoE+NifLdd28h
         PvPLujmNuGA7yTmZSsPAaWlJyAp2vqU8ucVBW0jWjM12wwVhRwOZHwvCF88NwcXf0DNj
         XbL8W6GfUbHeIT7CZPapwiIEVQpm+Gnl6tsDE35asahvtFg4VllHMjjOc8EMQ0F8ytLA
         jrmHPnpDpXgUfKpyjqLEppbdYgpLVIwjk7oxW687MZZ/kJhwKpQ7/BoBtRLiLd6jnFbu
         ZpsCGSXYnx6WWy+vUIxRil9ZqKK7EwPfFgCLLBQkRDywAKrlUKu/VXMV3SeIvU+mM5KG
         ogeA==
X-Gm-Message-State: AOAM532BHJHoJsIp73bY1397v47Toaxzlj7Y5d/K5mDFFjT+9/C8CpXq
        UIQ6+ei2ldsyBgpC3UdS+Ndoy5TzvD4=
X-Google-Smtp-Source: ABdhPJxrYzptRBA/TwAuiwaD6aQTT1svkwJwo5SVpbmv0nBufUViXSYZVpVD036IqfWviVR035+JoA==
X-Received: by 2002:a5d:4dcc:: with SMTP id f12mr2696245wru.598.1644613002739;
        Fri, 11 Feb 2022 12:56:42 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k28sm5456784wms.23.2022.02.11.12.56.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Feb 2022 12:56:42 -0800 (PST)
Message-Id: <19993c130d22b1f5f7beaee1a23ac2d6b377fec3.1644612979.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1041.v5.git.1644612979.gitgitgadget@gmail.com>
References: <pull.1041.v4.git.1634826309.gitgitgadget@gmail.com>
        <pull.1041.v5.git.1644612979.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 11 Feb 2022 20:56:15 +0000
Subject: [PATCH v5 26/30] fsmonitor--daemon: periodically truncate list of
 modified files
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

Teach fsmonitor--daemon to periodically truncate the list of
modified files to save some memory.

Clients will ask for the set of changes relative to a token that they
found in the FSMN index extension in the index.  (This token is like a
point in time, but different).  Clients will then update the index to
contain the response token (so that subsequent commands will be
relative to this new token).

Therefore, the daemon can gradually truncate the in-memory list of
changed paths as they become obsolete (older than the previous token).
Since we may have multiple clients making concurrent requests with a
skew of tokens and clients may be racing to the talk to the daemon,
we lazily truncate the list.

We introduce a 5 minute delay and truncate batches 5 minutes after
they are considered obsolete.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 builtin/fsmonitor--daemon.c | 88 +++++++++++++++++++++++++++++++++++++
 1 file changed, 88 insertions(+)

diff --git a/builtin/fsmonitor--daemon.c b/builtin/fsmonitor--daemon.c
index 4c88171e06c..962b24569e1 100644
--- a/builtin/fsmonitor--daemon.c
+++ b/builtin/fsmonitor--daemon.c
@@ -299,6 +299,75 @@ static void fsmonitor_batch__combine(struct fsmonitor_batch *batch_dest,
 			batch_src->interned_paths[k];
 }
 
+/*
+ * To keep the batch list from growing unbounded in response to filesystem
+ * activity, we try to truncate old batches from the end of the list as
+ * they become irrelevant.
+ *
+ * We assume that the .git/index will be updated with the most recent token
+ * any time the index is updated.  And future commands will only ask for
+ * recent changes *since* that new token.  So as tokens advance into the
+ * future, older batch items will never be requested/needed.  So we can
+ * truncate them without loss of functionality.
+ *
+ * However, multiple commands may be talking to the daemon concurrently
+ * or perform a slow command, so a little "token skew" is possible.
+ * Therefore, we want this to be a little bit lazy and have a generous
+ * delay.
+ *
+ * The current reader thread walked backwards in time from `token->batch_head`
+ * back to `batch_marker` somewhere in the middle of the batch list.
+ *
+ * Let's walk backwards in time from that marker an arbitrary delay
+ * and truncate the list there.  Note that these timestamps are completely
+ * artificial (based on when we pinned the batch item) and not on any
+ * filesystem activity.
+ *
+ * Return the obsolete portion of the list after we have removed it from
+ * the official list so that the caller can free it after leaving the lock.
+ */
+#define MY_TIME_DELAY_SECONDS (5 * 60) /* seconds */
+
+static struct fsmonitor_batch *with_lock__truncate_old_batches(
+	struct fsmonitor_daemon_state *state,
+	const struct fsmonitor_batch *batch_marker)
+{
+	/* assert current thread holding state->main_lock */
+
+	const struct fsmonitor_batch *batch;
+	struct fsmonitor_batch *remainder;
+
+	if (!batch_marker)
+		return NULL;
+
+	trace_printf_key(&trace_fsmonitor, "Truncate: mark (%"PRIu64",%"PRIu64")",
+			 batch_marker->batch_seq_nr,
+			 (uint64_t)batch_marker->pinned_time);
+
+	for (batch = batch_marker; batch; batch = batch->next) {
+		time_t t;
+
+		if (!batch->pinned_time) /* an overflow batch */
+			continue;
+
+		t = batch->pinned_time + MY_TIME_DELAY_SECONDS;
+		if (t > batch_marker->pinned_time) /* too close to marker */
+			continue;
+
+		goto truncate_past_here;
+	}
+
+	return NULL;
+
+truncate_past_here:
+	state->current_token_data->batch_tail = (struct fsmonitor_batch *)batch;
+
+	remainder = ((struct fsmonitor_batch *)batch)->next;
+	((struct fsmonitor_batch *)batch)->next = NULL;
+
+	return remainder;
+}
+
 static void fsmonitor_free_token_data(struct fsmonitor_token_data *token)
 {
 	if (!token)
@@ -412,6 +481,7 @@ static int do_handle_client(struct fsmonitor_daemon_state *state,
 	const char *p;
 	const struct fsmonitor_batch *batch_head;
 	const struct fsmonitor_batch *batch;
+	struct fsmonitor_batch *remainder = NULL;
 	intmax_t count = 0, duplicates = 0;
 	kh_str_t *shown;
 	int hash_ret;
@@ -641,11 +711,29 @@ static int do_handle_client(struct fsmonitor_daemon_state *state,
 			 * that work.
 			 */
 			fsmonitor_free_token_data(token_data);
+		} else if (batch) {
+			/*
+			 * We are holding the lock and are the only
+			 * reader of the ref-counted portion of the
+			 * list, so we get the honor of seeing if the
+			 * list can be truncated to save memory.
+			 *
+			 * The main loop did not walk to the end of the
+			 * list, so this batch is the first item in the
+			 * batch-list that is older than the requested
+			 * end-point sequence number.  See if the tail
+			 * end of the list is obsolete.
+			 */
+			remainder = with_lock__truncate_old_batches(state,
+								    batch);
 		}
 	}
 
 	pthread_mutex_unlock(&state->main_lock);
 
+	if (remainder)
+		fsmonitor_batch__free_list(remainder);
+
 	trace2_data_intmax("fsmonitor", the_repository, "response/length", total_response_len);
 	trace2_data_intmax("fsmonitor", the_repository, "response/count/files", count);
 	trace2_data_intmax("fsmonitor", the_repository, "response/count/duplicates", duplicates);
-- 
gitgitgadget

