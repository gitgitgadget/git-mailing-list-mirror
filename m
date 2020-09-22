Return-Path: <SRS0=uwne=C7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76901C2D0E2
	for <git@archiver.kernel.org>; Tue, 22 Sep 2020 22:51:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 409E32071A
	for <git@archiver.kernel.org>; Tue, 22 Sep 2020 22:51:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="fILpvfYZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726829AbgIVWvK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Sep 2020 18:51:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726617AbgIVWvK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Sep 2020 18:51:10 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06743C061755
        for <git@vger.kernel.org>; Tue, 22 Sep 2020 15:51:10 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id b2so17052491qtp.8
        for <git@vger.kernel.org>; Tue, 22 Sep 2020 15:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oG2TFWae6qgA8+hB1Rk7fweaT00Ae9ltZ2welbLce+Q=;
        b=fILpvfYZ0rB+Oe/9wQrYEiR1QUi+SA87YiH5OVafsnqFczl4Y2mjvWX7ltWpPIJ7X6
         EhHgqkrsb+kyUuzZWLmo1IVcOOuIyWOrYazzwMusD7Nt2vinOYL0NIZC8HkX2Z8cjKvy
         X9iFP2soDc7jojWGGW14g9/2cRGi85Jv8ByhhPEUAtYOJNNG+9ei6l1L0KJTklRa/Ypr
         itvrRnEZ+YfMWsNgiyDt3/FWmTEgVoot6MtUfkAw9YTYMf+xZih0NiGzGr1Zc/nw7+m5
         H66IuodLFmff2TIJfYkfKQToGHwEwbAtKJM4hZhgOs/aURQhXDD9whXg3LhriwqmKUua
         je3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oG2TFWae6qgA8+hB1Rk7fweaT00Ae9ltZ2welbLce+Q=;
        b=SAg5sd+sZiXfcVYnVd+aukE34CrYWlWAs7+1W8pkA7sQnrlhcwKqzSc/YZksKeRuuk
         gifE7MD7LS8BnaXNlfZRXuL7qlRmXrxl+HL3hSHmoEzuFw7iz/TOdjE6OGTl3TmXaf/A
         xoWF3Z2a0wof4BZ/OMccsPev200PpNWmTJUA6K3it6kOT9R5LcOGuPr4r5lP64I5C1Up
         GVGDJWacAUhs4HYjxiBScnzWzci9RDohquS1vf54qMUdweX1Jprv2YXV4lKGhX0bWk9G
         3XrsAf4BQV6j8DhofUF5IxGm1bWYs2A2uR3iOQcozEQh+ELYieWTOnzVJFXAFALAfK19
         hLxg==
X-Gm-Message-State: AOAM5327enTVYRvC6W/opwuIKeFVoxMyAhoKFmJ5ZXwz4FYAY7NRmY73
        Ryb4p0P5Lbef/EndHdFstVZyuphIlgPgcw==
X-Google-Smtp-Source: ABdhPJySvvQxj0zMQ87zNd+d4DELKYFEyOI1g0ObceXSKTPcernjEceh5mnFlBMlNmUA5wzTHdDHGw==
X-Received: by 2002:ac8:5d0d:: with SMTP id f13mr7143150qtx.87.1600815068783;
        Tue, 22 Sep 2020 15:51:08 -0700 (PDT)
Received: from mango.meuintelbras.local ([177.32.96.45])
        by smtp.gmail.com with ESMTPSA id p187sm12342359qkd.129.2020.09.22.15.51.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2020 15:51:07 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     jeffhost@microsoft.com, chriscool@tuxfamily.org, peff@peff.net,
        t.gummerer@gmail.com, newren@gmail.com
Subject: [PATCH v2 12/19] parallel-checkout: support progress displaying
Date:   Tue, 22 Sep 2020 19:49:26 -0300
Message-Id: <7ceadf2427b5c9b04c0943c0b257b8ebcaa13f19.1600814153.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1600814153.git.matheus.bernardino@usp.br>
References: <cover.1600814153.git.matheus.bernardino@usp.br>
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
 parallel-checkout.h |  4 +++-
 unpack-trees.c      | 11 ++++++++---
 3 files changed, 42 insertions(+), 7 deletions(-)

diff --git a/parallel-checkout.c b/parallel-checkout.c
index 7ea0faa526..5156b14c53 100644
--- a/parallel-checkout.c
+++ b/parallel-checkout.c
@@ -2,6 +2,7 @@
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
 
 static struct parallel_checkout parallel_checkout = { 0 };
@@ -125,6 +128,20 @@ int enqueue_checkout(struct cache_entry *ce, struct conv_attrs *ca)
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
@@ -173,6 +190,7 @@ static int handle_results(struct checkout *state)
 			 */
 			ret |= checkout_entry_ca(pc_item->ce, &pc_item->ca,
 						 state, NULL, NULL);
+			advance_progress_meter();
 			break;
 		case PC_ITEM_PENDING:
 			have_pending = 1;
@@ -499,6 +517,9 @@ static void parse_and_save_result(const char *line, int len,
 	pc_item->status = res->status;
 	if (st)
 		pc_item->st = *st;
+
+	if (res->status != PC_ITEM_COLLIDED)
+		advance_progress_meter();
 }
 
 
@@ -558,11 +579,16 @@ static void write_items_sequentially(struct checkout *state)
 {
 	size_t i;
 
-	for (i = 0; i < parallel_checkout.nr; ++i)
-		write_pc_item(&parallel_checkout.items[i], state);
+	for (i = 0; i < parallel_checkout.nr; ++i) {
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
 
@@ -570,6 +596,8 @@ int run_parallel_checkout(struct checkout *state, int num_workers, int threshold
 		BUG("cannot run parallel checkout: uninitialized or already running");
 
 	parallel_checkout.status = PC_RUNNING;
+	parallel_checkout.progress = progress;
+	parallel_checkout.progress_cnt = progress_cnt;
 
 	if (parallel_checkout.nr < num_workers)
 		num_workers = parallel_checkout.nr;
diff --git a/parallel-checkout.h b/parallel-checkout.h
index 0c9984584e..6c3a016c0b 100644
--- a/parallel-checkout.h
+++ b/parallel-checkout.h
@@ -24,13 +24,15 @@ void init_parallel_checkout(void);
  * write and return 0.
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
index 117ed42370..e05e6ceff2 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -471,17 +471,22 @@ static int check_updates(struct unpack_trees_options *o,
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
2.28.0

