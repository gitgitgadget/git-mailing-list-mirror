Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87E67C4332D
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 21:13:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38DC764F57
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 21:13:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233541AbhCQVNM (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Mar 2021 17:13:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231297AbhCQVMk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Mar 2021 17:12:40 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DA83C06174A
        for <git@vger.kernel.org>; Wed, 17 Mar 2021 14:12:40 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id s2so2530834qtx.10
        for <git@vger.kernel.org>; Wed, 17 Mar 2021 14:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8xLlA117lUMzQrOX4oiek+xP4aFlEJYs1qp+N036uKw=;
        b=JPNQN7GAcJBFQ9Pcw88Nku6Eg/Y7d4QJrUTXHR5E0F/KbJiIn+e+7NwnYAnNSP8BI3
         D5K3/NnlpCFCoaWSE85QxZteAb85lvNb3TZ4CiFmLgCFCKDoYF01hnz7el0vMCsFEBT3
         0VmGo+EWYV3EhNhJ1ZTMF5mQGRRxYw5jL8ootAz4bOlWtPkiQk5/+0G/98q81bcxh6R8
         MNdClqh2Kq3+MYtbf42rR5n792BkbsismB5B+wxaF2l37BL6xCxtK1TMJK5BF4ZiPWI4
         G2XhTFL+Az1kvk7O0f+WV4xvQpho8qx6cpdwtxfK5AouvQasUK+w8ttsvnI6si32uD7j
         oIYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8xLlA117lUMzQrOX4oiek+xP4aFlEJYs1qp+N036uKw=;
        b=DBqxqaWBcxaPVScf47r0RPENP4RnDFP8UO5EZijmWUp0Bk/4mVL1lizc1+idN/SYYE
         6VT8Hb4Dnylf6MO0MOMc6zF5gTNl7CS1cTOXwr0adkLPEPdgvsIBKBn+T8QeNwTyyo4l
         yg9Vt8gWEvmsEwW5vXvt5+xv4ggSHFmYCMlxGfRretISHD9mdCQGXg0uGGqldWXehz57
         CK09m4ATh9bw1G46mjYKm60MRtAKSaYcneg6P6SmUwTdv1a6pOrrKwjHCUbJRdamPRUF
         oEQEUDnn6JQL9pHpt2FSwDWuumx6Ycv+PuWcTt9C2xhSBcuRpuHcIS9VH2FNWh5an351
         ybvg==
X-Gm-Message-State: AOAM530PFk5C+ej7wq9UTspDHVGAacfuZAG4tVI40SBka4LodM0BsEgZ
        NSYS1WPl+KoLhgRhZ9uBTsPJ4PhbbBjfnQ==
X-Google-Smtp-Source: ABdhPJzK8y0l8w+H8HvzNPjP7EgVRc5leELe8XHX2f6C3vCQAnXBsmnB9sOXNsXOmh3dMUzajfCDvA==
X-Received: by 2002:ac8:5043:: with SMTP id h3mr933807qtm.97.1616015558911;
        Wed, 17 Mar 2021 14:12:38 -0700 (PDT)
Received: from mango.meuintelbras.local ([177.32.118.149])
        by smtp.gmail.com with ESMTPSA id f9sm131138qkk.115.2021.03.17.14.12.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 14:12:38 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     christian.couder@gmail.com, gitster@pobox.com,
        git@jeffhostetler.com
Subject: [PATCH 4/5] parallel-checkout: support progress displaying
Date:   Wed, 17 Mar 2021 18:12:22 -0300
Message-Id: <f7432e15ddc04a2279cc52b87283f08a5e6bc08b.1616015337.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <cover.1616015337.git.matheus.bernardino@usp.br>
References: <cover.1616015337.git.matheus.bernardino@usp.br>
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
index 92f3872653..2ba0bbb50f 100644
--- a/parallel-checkout.c
+++ b/parallel-checkout.c
@@ -3,6 +3,7 @@
 #include "entry.h"
 #include "parallel-checkout.h"
 #include "pkt-line.h"
+#include "progress.h"
 #include "run-command.h"
 #include "streaming.h"
 #include "thread-utils.h"
@@ -16,6 +17,8 @@ struct parallel_checkout {
 	enum pc_status status;
 	struct parallel_checkout_item *items;
 	size_t nr, alloc;
+	struct progress *progress;
+	unsigned int *progress_cnt;
 };
 
 static struct parallel_checkout parallel_checkout;
@@ -131,6 +134,20 @@ int enqueue_checkout(struct cache_entry *ce, struct conv_attrs *ca)
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
@@ -179,6 +196,7 @@ static int handle_results(struct checkout *state)
 			 */
 			ret |= checkout_entry_ca(pc_item->ce, &pc_item->ca,
 						 state, NULL, NULL);
+			advance_progress_meter();
 			break;
 		case PC_ITEM_PENDING:
 			have_pending = 1;
@@ -506,6 +524,9 @@ static void parse_and_save_result(const char *line, int len,
 	pc_item->status = res->status;
 	if (st)
 		pc_item->st = *st;
+
+	if (res->status != PC_ITEM_COLLIDED)
+		advance_progress_meter();
 }
 
 
@@ -565,11 +586,16 @@ static void write_items_sequentially(struct checkout *state)
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
 
@@ -577,6 +603,8 @@ int run_parallel_checkout(struct checkout *state, int num_workers, int threshold
 		BUG("cannot run parallel checkout: uninitialized or already running");
 
 	parallel_checkout.status = PC_RUNNING;
+	parallel_checkout.progress = progress;
+	parallel_checkout.progress_cnt = progress_cnt;
 
 	if (parallel_checkout.nr < num_workers)
 		num_workers = parallel_checkout.nr;
diff --git a/parallel-checkout.h b/parallel-checkout.h
index 26f61ed2ac..4114c6bda2 100644
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
  * Interface with checkout--helper
diff --git a/unpack-trees.c b/unpack-trees.c
index 8bc5061487..0e463870fd 100644
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

