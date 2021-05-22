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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0DFEC2B9F2
	for <git@archiver.kernel.org>; Sat, 22 May 2021 13:57:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B3AA66115C
	for <git@archiver.kernel.org>; Sat, 22 May 2021 13:57:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231355AbhEVN7J (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 22 May 2021 09:59:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231193AbhEVN6v (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 May 2021 09:58:51 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0AFBC06138D
        for <git@vger.kernel.org>; Sat, 22 May 2021 06:57:24 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id o127so12549199wmo.4
        for <git@vger.kernel.org>; Sat, 22 May 2021 06:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=C/2I6MzuLOLiUVsctx/0Xt+MswXfzfsVGvZCqKl/OD8=;
        b=iw/zf6AB88QNA/5xHva8w8wZvZO2mGvZS4YWXs8CNxYD+JsC08Q26Mh6lXreIsV4VW
         moVDSPSgpx/+sjbZTIJwbCWfWFa4VgxLVeO0C2HhPIxgjwU5Q7U6NGiGBVkfn8jHOMH1
         jWgsaulgnVJSDwx8UO6ek7Z/n4GzTtAKuK68KvPiJ1j/LCjcT4SkYVztMemuZ+3rFKSw
         Pn+TDEv9z1zaeULPY3Hu/+0JdjZiBqwQvwARCglt5YGdaDHwmHrtxbWLvsgNQvGHGYx6
         AonYqeRcAuCfrPxMjEAp892EfTq67iUqiFTeUFolQ7XFcy9xQkW7KUcB4Mj+x9V5rAR5
         kFqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=C/2I6MzuLOLiUVsctx/0Xt+MswXfzfsVGvZCqKl/OD8=;
        b=gJKtKeQPrCYSc37nthHTnSphQvUSwTh4m1W+PTwzi4AqjYmstiNnJ1FEHK+QlSJbyG
         b5V7vv5tmIXebz6bGuAljtnGkMgppuLuVjbnh2X5otGvuxZk70uCDMarT37pfwv6vKEj
         k5U3pC506icqiJqOkB8Q170ZmlhR0/cokhejsViskf/gH2bJ7tyKSY8Id554fFvteegO
         mGtnjgs21AseftaNCvy8rmYzFc5Aae3vjVq0pbOcpsPxr/bfOwJc5kdChFshjs+Qb/Yq
         9kLur7fP0VK+lpn1n2jW2lqnFS5Z6lBnZGFVRq56Iwjeosp9BOw4+uz4TRJWUgh5nhBb
         /j7w==
X-Gm-Message-State: AOAM530+bHclU1/YzWjrkGB/jrQ8hp9c5fISkHGKZUrIGONO+gHbIJLB
        8xNe1AuEjz7sTcVzecG7Eff5577KIv0=
X-Google-Smtp-Source: ABdhPJzpoktzYaRVqGzyo2Ve24gOEXDqDLEuLMHMWFfqWRjM4y11rusy6ofYccxXt0NCzA2QGoxQjw==
X-Received: by 2002:a7b:c185:: with SMTP id y5mr12769104wmi.63.1621691843629;
        Sat, 22 May 2021 06:57:23 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f14sm5409218wry.40.2021.05.22.06.57.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 May 2021 06:57:23 -0700 (PDT)
Message-Id: <f0da90e9b050173e2fffe7da3b54b6bc5d0056a1.1621691828.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.923.v2.git.1621691828.gitgitgadget@gmail.com>
References: <pull.923.git.1617291666.gitgitgadget@gmail.com>
        <pull.923.v2.git.1621691828.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 22 May 2021 13:57:00 +0000
Subject: [PATCH v2 21/28] fsmonitor--daemon: periodically truncate list of
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
index 33b4f09c72ca..e807aa8f6741 100644
--- a/builtin/fsmonitor--daemon.c
+++ b/builtin/fsmonitor--daemon.c
@@ -298,6 +298,77 @@ static void fsmonitor_batch__combine(struct fsmonitor_batch *batch_dest,
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
@@ -643,6 +714,15 @@ static int do_handle_client(struct fsmonitor_daemon_state *state,
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

