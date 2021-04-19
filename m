Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2B92C433B4
	for <git@archiver.kernel.org>; Mon, 19 Apr 2021 19:53:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 887CA61363
	for <git@archiver.kernel.org>; Mon, 19 Apr 2021 19:53:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241919AbhDSTyY (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Apr 2021 15:54:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241915AbhDSTyW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Apr 2021 15:54:22 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A7EBC06138A
        for <git@vger.kernel.org>; Mon, 19 Apr 2021 12:53:52 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id e13so27244266qkl.6
        for <git@vger.kernel.org>; Mon, 19 Apr 2021 12:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WkFrG3l+kM7XmDDgEvtgfAvzcfQkwheP7JO1Ypm9mMI=;
        b=VuuX1G3CJ4UFTbDlLoadmwgym9hjSzAK3YabMplZ6f2Dv2a3Bxun+hAEqVpcuamvzM
         c1pRc1EUSHXqRQbNWrTup7UwNaEu4kucdN+ptFP/kV/keGN7ClDQ+9cRy179ARvUpCG2
         YBbk26mNJQh0XWzw/ODqyEPBj7F3ijL64id/XTJkwMrDETv0ReBqyhuMW97Uhk62vzG3
         r99ykrGPScsnGp7LQP1k/UbrCq8xeTv2L4VWwtEaZnYC03NMax8U0U9OSoCMBtzGrIAo
         Ov2PxxuBw0tTJ3s/iX9KSU2md8sQJLP9E6rcaUiHcW0y65/XJRoWU/vfEi1T8e+oOkTq
         Gk8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WkFrG3l+kM7XmDDgEvtgfAvzcfQkwheP7JO1Ypm9mMI=;
        b=EXQPdbyynys4NPXU85Iu+glpHKmT039D1AEXeg7mGjKkD3aUSTMidLP2uLUdritTRu
         7ZkjE21Ws9EBVbA5OiyCamgdrk+esPDq3WTLcZkI4zpVohsxruGs+MS6IMz6t+p8EN6+
         VuIaSQfIhBBORO+c7f3ohSWM17+5Hfua0jgmZ5s6iSBSvcPKELowUS9v7shAJ6Syfu3m
         zSKkx+2ikPkHM0O4XNjf2umFdQiD1STWAk/R+a1BrBooYR9vr1DkCZDboETa6UJucWZx
         Bp++Gwpcvj5DFDg76XE4BcWrX2XIxtY3usy4yh4TM8WqrWiyQtuhxSke2KL191uQFszJ
         OEDg==
X-Gm-Message-State: AOAM530gELsqNWSd/Uk0727Il/AEUCfmPCjoxnB2VfbVbUJPyBp8RlTk
        xXYxTQFoGSb1CLmboXQDyHHHdA==
X-Google-Smtp-Source: ABdhPJwFm+YToD9kKtGjiUs19/1ehoIvIMjFp04K9Avdlbz6oovtTJOZlU6tobhvvlbT/2YsHrOyZQ==
X-Received: by 2002:a37:f612:: with SMTP id y18mr13601874qkj.406.1618862031339;
        Mon, 19 Apr 2021 12:53:51 -0700 (PDT)
Received: from mango.meuintelbras.local ([177.32.118.149])
        by smtp.gmail.com with ESMTPSA id h3sm4479987qka.122.2021.04.19.12.53.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Apr 2021 12:53:51 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, christian.couder@gmail.com,
        git@jeffhostetler.com
Subject: [PATCH v4 4/5] parallel-checkout: support progress displaying
Date:   Mon, 19 Apr 2021 16:53:34 -0300
Message-Id: <cf9e28dc0eddfc8e36a64b9738c94bb790349092.1618861380.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <cover.1618861380.git.matheus.bernardino@usp.br>
References: <cover.1618861380.git.matheus.bernardino@usp.br>
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
index 3cc2028861..09e8b10a35 100644
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
@@ -534,6 +552,9 @@ static void parse_and_save_result(const char *buffer, int len,
 	pc_item->status = res->status;
 	if (st)
 		pc_item->st = *st;
+
+	if (res->status != PC_ITEM_COLLIDED)
+		advance_progress_meter();
 }
 
 static void gather_results_from_workers(struct pc_worker *workers,
@@ -596,11 +617,16 @@ static void write_items_sequentially(struct checkout *state)
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
 
@@ -608,6 +634,8 @@ int run_parallel_checkout(struct checkout *state, int num_workers, int threshold
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

