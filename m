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
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAFB3C11F6A
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 14:48:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B41BD6141C
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 14:48:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233339AbhGAOuu (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Jul 2021 10:50:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232866AbhGAOuf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jul 2021 10:50:35 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A5B0C061786
        for <git@vger.kernel.org>; Thu,  1 Jul 2021 07:48:03 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id u6so8581472wrs.5
        for <git@vger.kernel.org>; Thu, 01 Jul 2021 07:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ev14wSKF78AibylIM3i+MwqoPuIbXki/gTA9K5amaaI=;
        b=dA7n8EWZajS8LJVp3LmVcdiC41CkqMMMgSCkBbq3UC17rzOIjSlfwbTSA0eZMtA+3G
         OH3QNo8o+KPSj7ziyA2N7UR0lWbAaMZmxXc8FVWDerfiliDZzpGeyogurv9ka7sluLkI
         6hVfUU4nUavyIGfSvsr282ApbnqaR+YMaDL5jRQiVFAfxs6pC0ZQRrs0q+Bdsz+kvxPl
         rUABYGakvp2NWMcNFG/Wa5mjRCOOB5HUlIjaozbEEoWEIZazDlclxwRBdGXIg6QUOp5A
         zPctQmYLHw02RTXPdzwhucqt51vFCrdfK1SoVo/hprzF46B8z39MzpiKO85cHKkLAID1
         MjFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ev14wSKF78AibylIM3i+MwqoPuIbXki/gTA9K5amaaI=;
        b=blZMUxCtB80UH6H9G1uXeGNjeKg7civPB/jrBDhW0TsJGvO4tBN1zosliKbQGf/mNG
         p3HzHHP8x6x/+7L2/nLkYpFrLzczG6YhWOCSHCT0lU8dRphzHqgtI8s/vITPi4DW+CHX
         DZ10znD0h7a6nV2on+psHZHK4heptY9g6oOnl+FEsUttsJuX/Y9MRYRSMMVS+4AG9tIo
         b20itLVAy03pOA2FvYEI7r5jh4RnxwKblI+CgHywT9++x3sJKeqGamBYCLH8tggLjU4o
         x+Ew5KUDb+UFyA+S5mPFP+DU6NrblxdLaUTUVZdCQ/btuEd87yIVQykAsN7RGPhxPYON
         B4hw==
X-Gm-Message-State: AOAM530i5gHthslvNv/dh7hS1v+EoDgGIK5Sm8m4ME3DrNKZfsWEWLJl
        e2qCgyGfMKaHh+sh2yhZAitykoLUejQ=
X-Google-Smtp-Source: ABdhPJwR5buY4VnU/Azt5EaPlFxqgk32nm37lFaMvPrzDfn/8XPQ222WfVGjwe58qDcWIloupfLNpw==
X-Received: by 2002:a5d:66d0:: with SMTP id k16mr40735wrw.124.1625150881746;
        Thu, 01 Jul 2021 07:48:01 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f18sm150042wru.53.2021.07.01.07.48.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jul 2021 07:48:01 -0700 (PDT)
Message-Id: <3f36a31eb42147867f2cfd33f95187bb16c44a8b.1625150864.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.923.v3.git.1625150864.gitgitgadget@gmail.com>
References: <pull.923.v2.git.1621691828.gitgitgadget@gmail.com>
        <pull.923.v3.git.1625150864.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 01 Jul 2021 14:47:38 +0000
Subject: [PATCH v3 28/34] fsmonitor--daemon: periodically truncate list of
 modified files
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
 builtin/fsmonitor--daemon.c | 80 +++++++++++++++++++++++++++++++++++++
 1 file changed, 80 insertions(+)

diff --git a/builtin/fsmonitor--daemon.c b/builtin/fsmonitor--daemon.c
index 7a7fef681fe..8249420ba18 100644
--- a/builtin/fsmonitor--daemon.c
+++ b/builtin/fsmonitor--daemon.c
@@ -300,6 +300,77 @@ static void fsmonitor_batch__combine(struct fsmonitor_batch *batch_dest,
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
+#define MY_TIME_DELAY_SECONDS (5 * 60) /* seconds */
+
+static void with_lock__truncate_old_batches(
+	struct fsmonitor_daemon_state *state,
+	const struct fsmonitor_batch *batch_marker)
+{
+	/* assert current thread holding state->main_lock */
+
+	const struct fsmonitor_batch *batch;
+	struct fsmonitor_batch *rest;
+	struct fsmonitor_batch *p;
+
+	if (!batch_marker)
+		return;
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
+	return;
+
+truncate_past_here:
+	state->current_token_data->batch_tail = (struct fsmonitor_batch *)batch;
+
+	rest = ((struct fsmonitor_batch *)batch)->next;
+	((struct fsmonitor_batch *)batch)->next = NULL;
+
+	for (p = rest; p; p = fsmonitor_batch__pop(p)) {
+		trace_printf_key(&trace_fsmonitor,
+				 "Truncate: kill (%"PRIu64",%"PRIu64")",
+				 p->batch_seq_nr, (uint64_t)p->pinned_time);
+	}
+}
+
 static void fsmonitor_free_token_data(struct fsmonitor_token_data *token)
 {
 	struct fsmonitor_batch *p;
@@ -645,6 +716,15 @@ static int do_handle_client(struct fsmonitor_daemon_state *state,
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
+			with_lock__truncate_old_batches(state, batch);
 		}
 	}
 
-- 
gitgitgadget

