Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34E0EC43460
	for <git@archiver.kernel.org>; Thu,  8 Apr 2021 16:17:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 03A2B6113B
	for <git@archiver.kernel.org>; Thu,  8 Apr 2021 16:17:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232225AbhDHQRk (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Apr 2021 12:17:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232017AbhDHQRf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Apr 2021 12:17:35 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D451C061764
        for <git@vger.kernel.org>; Thu,  8 Apr 2021 09:17:21 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id es6so1190710qvb.0
        for <git@vger.kernel.org>; Thu, 08 Apr 2021 09:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sH5EFyfynsJ4ynH11KbWmW35abqllWQaVzPnfowEUjw=;
        b=wWMWvdblkm9iQTVnK0qDw/U0oZywdnOobs1RDvcSr0cC2Dj+uBcV4kEJ4g0/9Bkfiv
         9aVAYDR9t7w71x2PZiYV1SOQXw86uRLKADdqlG12KeCbgSAAKrCtVpWRbgMfQ4pcyg+Z
         3nt9L6tblc8gJ5rkdQ8wstqtWDDqvvOie+UB73xy9ZA/h0G2p0GpXKPGVx9hx5mOvzC4
         zTnDnD4DTUaSceFMetpoS0JcGrw23mINxCzM/ASodS5xYu4+xQUmjbblLTwlWa+RFWvF
         uZHUfcSHdn23JmvUCF0MR6slCdVNlaUhAvNUUwoyQeSGe8pSKUw+Wv1VOhZJf40fa82A
         ZKOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sH5EFyfynsJ4ynH11KbWmW35abqllWQaVzPnfowEUjw=;
        b=bUUc0MP6sy3ZgsSsWFCiPrjLmQA+3AQ/8jwIwVQX74yPqqR4seVIjndbl75M9wGqJu
         xUKIRO1CU5EWMsI6yrJJDGzrkrIemKKqwwrBuAHtc5pvFYrVVOxBar7LUKJhh/XxqIjR
         gD57RPcAIoMmwAoN+1Jtq4ih8jEddyTRcMagKyUi5fMmZC1yPK8kNLEcbuVAZwF6xA5O
         jXCbBM+O50EFdVB/SrsolNa5ltY7Yl35fDCaDmhYpvDLBi3ZDqU6sQJewCDVsbN5Me44
         8X/0VNPeP5re/Bdd2rpqK6DbEayMISBHYE3grPHN1zpxpn5WUgXTJnZxVw1AIyGv4uCa
         gVRA==
X-Gm-Message-State: AOAM532Xx7yB6kG0UO4nn7irIKaIM+cevQTjsmePAAFS7NLBFG58E/UV
        t/GSzgxSxY2bBtONzk1lyVIXI+t2mrKfVA==
X-Google-Smtp-Source: ABdhPJxfyH6/LXJ+Pae9Nex2gcVYIbA3UFeweTEJ+ZNi8i79Dbcem4LVNEp9g4xgF/lUxewZaKvcJA==
X-Received: by 2002:a05:6214:2607:: with SMTP id gu7mr9394671qvb.18.1617898640280;
        Thu, 08 Apr 2021 09:17:20 -0700 (PDT)
Received: from mango.meuintelbras.local ([177.32.118.149])
        by smtp.gmail.com with ESMTPSA id d18sm18087369qtd.85.2021.04.08.09.17.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Apr 2021 09:17:19 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     christian.couder@gmail.com, gitster@pobox.com,
        git@jeffhostetler.com
Subject: [PATCH v2 4/5] parallel-checkout: support progress displaying
Date:   Thu,  8 Apr 2021 13:17:03 -0300
Message-Id: <0ac4bee67e5ed43ba87e7beb3f119f11d90706fd.1617893234.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <cover.1617893234.git.matheus.bernardino@usp.br>
References: <cover.1617893234.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Original-patch-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
 parallel-checkout.c | 34 +++++++++++++++++++++++++++++++---
 parallel-checkout.h |  5 ++++-
 unpack-trees.c      | 11 ++++++++---
 3 files changed, 43 insertions(+), 7 deletions(-)

diff --git a/parallel-checkout.c b/parallel-checkout.c
index d6a0f31664..d09ad8a7c6 100644
--- a/parallel-checkout.c
+++ b/parallel-checkout.c
@@ -3,6 +3,7 @@
 #include "entry.h"
 #include "parallel-checkout.h"
 #include "pkt-line.h"
+#include "progress.h"
 #include "run-command.h"
 #include "sigchain.h"
 #include "streaming.h"
@@ -17,6 +18,8 @@ struct parallel_checkout {
 	enum pc_status status;
 	struct parallel_checkout_item *items; /* The parallel checkout queue. */
 	size_t nr, alloc;
+	struct progress *progress;
+	unsigned int *progress_cnt;
 };
 
 static struct parallel_checkout parallel_checkout;
@@ -146,6 +149,20 @@ int enqueue_checkout(struct cache_entry *ce, struct conv_attrs *ca)
 	return 0;
 }
 
+size_t pc_queue_size(void)
+{
+	return parallel_checkout.nr;
+}
+
+static void advance_progress_meter(void)
+{
+	if (parallel_checkout.progress) {
+		(*parallel_checkout.progress_cnt)++;
+		display_progress(parallel_checkout.progress,
+				 *parallel_checkout.progress_cnt);
+	}
+}
+
 static int handle_results(struct checkout *state)
 {
 	int ret = 0;
@@ -194,6 +211,7 @@ static int handle_results(struct checkout *state)
 			 */
 			ret |= checkout_entry_ca(pc_item->ce, &pc_item->ca,
 						 state, NULL, NULL);
+			advance_progress_meter();
 			break;
 		case PC_ITEM_PENDING:
 			have_pending = 1;
@@ -537,6 +555,9 @@ static void parse_and_save_result(const char *buffer, int len,
 	pc_item->status = res->status;
 	if (st)
 		pc_item->st = *st;
+
+	if (res->status != PC_ITEM_COLLIDED)
+		advance_progress_meter();
 }
 
 static void gather_results_from_workers(struct pc_worker *workers,
@@ -599,11 +620,16 @@ static void write_items_sequentially(struct checkout *state)
 {
 	size_t i;
 
-	for (i = 0; i < parallel_checkout.nr; i++)
-		write_pc_item(&parallel_checkout.items[i], state);
+	for (i = 0; i < parallel_checkout.nr; i++) {
+		struct parallel_checkout_item *pc_item = &parallel_checkout.items[i];
+		write_pc_item(pc_item, state);
+		if (pc_item->status != PC_ITEM_COLLIDED)
+			advance_progress_meter();
+	}
 }
 
-int run_parallel_checkout(struct checkout *state, int num_workers, int threshold)
+int run_parallel_checkout(struct checkout *state, int num_workers, int threshold,
+			  struct progress *progress, unsigned int *progress_cnt)
 {
 	int ret;
 
@@ -611,6 +637,8 @@ int run_parallel_checkout(struct checkout *state, int num_workers, int threshold
 		BUG("cannot run parallel checkout: uninitialized or already running");
 
 	parallel_checkout.status = PC_RUNNING;
+	parallel_checkout.progress = progress;
+	parallel_checkout.progress_cnt = progress_cnt;
 
 	if (parallel_checkout.nr < num_workers)
 		num_workers = parallel_checkout.nr;
diff --git a/parallel-checkout.h b/parallel-checkout.h
index 2a68ab954d..80f539bcb7 100644
--- a/parallel-checkout.h
+++ b/parallel-checkout.h
@@ -5,6 +5,7 @@
 
 struct cache_entry;
 struct checkout;
+struct progress;
 
 /****************************************************************
  * Users of parallel checkout
@@ -31,13 +32,15 @@ void init_parallel_checkout(void);
  * for later write and return 0.
  */
 int enqueue_checkout(struct cache_entry *ce, struct conv_attrs *ca);
+size_t pc_queue_size(void);
 
 /*
  * Write all the queued entries, returning 0 on success. If the number of
  * entries is smaller than the specified threshold, the operation is performed
  * sequentially.
  */
-int run_parallel_checkout(struct checkout *state, int num_workers, int threshold);
+int run_parallel_checkout(struct checkout *state, int num_workers, int threshold,
+			  struct progress *progress, unsigned int *progress_cnt);
 
 /****************************************************************
  * Interface with checkout--worker
diff --git a/unpack-trees.c b/unpack-trees.c
index 0669748f21..4b77e52c6b 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -474,17 +474,22 @@ static int check_updates(struct unpack_trees_options *o,
 		struct cache_entry *ce = index->cache[i];
 
 		if (ce->ce_flags & CE_UPDATE) {
+			size_t last_pc_queue_size = pc_queue_size();
+
 			if (ce->ce_flags & CE_WT_REMOVE)
 				BUG("both update and delete flags are set on %s",
 				    ce->name);
-			display_progress(progress, ++cnt);
 			ce->ce_flags &= ~CE_UPDATE;
 			errs |= checkout_entry(ce, &state, NULL, NULL);
+
+			if (last_pc_queue_size == pc_queue_size())
+				display_progress(progress, ++cnt);
 		}
 	}
-	stop_progress(&progress);
 	if (pc_workers > 1)
-		errs |= run_parallel_checkout(&state, pc_workers, pc_threshold);
+		errs |= run_parallel_checkout(&state, pc_workers, pc_threshold,
+					      progress, &cnt);
+	stop_progress(&progress);
 	errs |= finish_delayed_checkout(&state, NULL);
 	git_attr_set_direction(GIT_ATTR_CHECKIN);
 
-- 
2.30.1

