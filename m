Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF272C001B8
	for <git@archiver.kernel.org>; Thu,  1 Apr 2021 17:43:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 23ACF61374
	for <git@archiver.kernel.org>; Thu,  1 Apr 2021 17:43:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235684AbhDARnH (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Apr 2021 13:43:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234447AbhDARhk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Apr 2021 13:37:40 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3FD2C02D547
        for <git@vger.kernel.org>; Thu,  1 Apr 2021 08:41:19 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id j9so2255151wrx.12
        for <git@vger.kernel.org>; Thu, 01 Apr 2021 08:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=d7ttphpVx4NoDbT7tJHRrMQZ4D87byK9jMPJVinO5j0=;
        b=oki13NIsHZOef6SPkmFGkfJKfJftENn2DIVtpz48kn1Uz+MvxUu/HSucQ7AxG3M+rI
         JpOMjXuzR0CbKCZu+k7+GN6ovFUSxrRF8XfjFT1gv+ljxomrlcY7TG7L+f/2ruMQsi9f
         Jk++PSh3K7xtsPll0R6YIK73dxcge80AhNxqPXfCPNE8ytFtiomY56afO1O7+fWghSmx
         mQj69MOX5Ba20H9JX84L8Cu6fUXD7rKWo1q5fUcV3CqmY49JV/WBXJcngfygKzfm/hBq
         zMlwAdj4/fnFWJFB0H0M4G9/oEa0ukiCzQR31jEzCOwSYHS+mXhOZsA49X2PowayqtIY
         bR7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=d7ttphpVx4NoDbT7tJHRrMQZ4D87byK9jMPJVinO5j0=;
        b=nqIr9g8ASbhnLkNkHsCU5QUbZxuTqP+RGt+Wb25DddzYvNpqZlIl4inLndfi1sHw4S
         Qg0kuSxDGAHb3SSgESDhqcUKCg3k57eKUIFSFihXXt2rK2iZC+zba6EQWAFvzN3e4V+i
         Z5PdxRaagmV41GaHk7eYDEWc/UaKIuV0WxSIfRd3qZ/l6pQFjwEYrlxhMawsovBBaEv5
         VuO3TgkI767IihfJdBbIGx2qweWgSHfRqw5/YgHb+x5FHDeEUaBjrU8yKA3OFM2/pL1v
         hGmrZhdJ96pBsnk9qE/aZqipizrO4XvLEaSID2DK8r5QSqo1GezBwJ+WT2H8UHR/CnKx
         NPvA==
X-Gm-Message-State: AOAM530C9HTlvFj7M0LHTgpiStG828lVb8BST19i1sRt1V7QxUcuGdP4
        ofERHYOEfD+O1CTH8USHsSaL+MYypn8=
X-Google-Smtp-Source: ABdhPJxRygJvPv8S+E39Wm+p9iB14O+FY7+20DAM/WDtEMqKC0kSm/K1+lXcy9yrFSX8dMdavE48QA==
X-Received: by 2002:adf:c587:: with SMTP id m7mr10219563wrg.369.1617291678677;
        Thu, 01 Apr 2021 08:41:18 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l6sm9963338wrt.56.2021.04.01.08.41.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Apr 2021 08:41:18 -0700 (PDT)
Message-Id: <9f263e70c7245a01210ac743ce3dfda4dcc08308.1617291666.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.923.git.1617291666.gitgitgadget@gmail.com>
References: <pull.923.git.1617291666.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 01 Apr 2021 15:40:59 +0000
Subject: [PATCH 17/23] fsmonitor--daemon: periodically truncate list of
 modified files
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

Teach fsmonitor--daemon to periodically truncate the list of
modified files to save some memory.

Clients will ask for the set of changes relative to a token that they
found in the FSMN index extension in the index.  (This token is like a
point in time, but different).  Clients will then update the index to
contain the response token (so that subsequent commands will be
relative to this new token).

Therefore, the daemon can gradually truncate the in-memory list of
changed paths as they become obsolete (older that the previous token).
Since we may have multiple clients making concurrent requests with a
skew of tokens and clients may be racing to the talk to the daemon,
we lazily truncate the list.

We introduce a 5 minute delay and truncate batches 5 minutes after
they are considered obsolete.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 builtin/fsmonitor--daemon.c | 78 +++++++++++++++++++++++++++++++++++++
 1 file changed, 78 insertions(+)

diff --git a/builtin/fsmonitor--daemon.c b/builtin/fsmonitor--daemon.c
index 32df392b25d3..e9a9aea59ad6 100644
--- a/builtin/fsmonitor--daemon.c
+++ b/builtin/fsmonitor--daemon.c
@@ -316,6 +316,75 @@ static void fsmonitor_batch__combine(struct fsmonitor_batch *batch_dest,
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
+ */
+#define MY_TIME_DELAY (5 * 60) /* seconds */
+
+static void fsmonitor_batch__truncate(struct fsmonitor_daemon_state *state,
+				      const struct fsmonitor_batch *batch_marker)
+{
+	/* assert state->main_lock */
+
+	const struct fsmonitor_batch *batch;
+	struct fsmonitor_batch *rest;
+	struct fsmonitor_batch *p;
+	time_t t;
+
+	if (!batch_marker)
+		return;
+
+	trace_printf_key(&trace_fsmonitor, "TRNC mark (%"PRIu64",%"PRIu64")",
+			 batch_marker->batch_seq_nr,
+			 (uint64_t)batch_marker->pinned_time);
+
+	for (batch = batch_marker; batch; batch = batch->next) {
+		if (!batch->pinned_time) /* an overflow batch */
+			continue;
+
+		t = batch->pinned_time + MY_TIME_DELAY;
+		if (t > batch_marker->pinned_time) /* too close to marker */
+			continue;
+
+		goto truncate_past_here;
+	}
+
+	return;
+
+truncate_past_here:
+	state->current_token_data->batch_tail = (struct fsmonitor_batch *)batch;
+
+	rest = ((struct fsmonitor_batch *)batch)->next;
+	((struct fsmonitor_batch *)batch)->next = NULL;
+
+	for (p = rest; p; p = fsmonitor_batch__free(p)) {
+		trace_printf_key(&trace_fsmonitor,
+				 "TRNC kill (%"PRIu64",%"PRIu64")",
+				 p->batch_seq_nr, (uint64_t)p->pinned_time);
+	}
+}
+
 static void fsmonitor_free_token_data(struct fsmonitor_token_data *token)
 {
 	struct fsmonitor_batch *p;
@@ -647,6 +716,15 @@ static int do_handle_client(struct fsmonitor_daemon_state *state,
 			 * that work.
 			 */
 			fsmonitor_free_token_data(token_data);
+		} else if (batch) {
+			/*
+			 * This batch is the first item in the list
+			 * that is older than the requested sequence
+			 * number and might be considered to be
+			 * obsolete.  See if we can truncate the list
+			 * and save some memory.
+			 */
+			fsmonitor_batch__truncate(state, batch);
 		}
 	}
 
-- 
gitgitgadget

