Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C8BEC43462
	for <git@archiver.kernel.org>; Mon, 19 Apr 2021 00:15:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15AAA610CB
	for <git@archiver.kernel.org>; Mon, 19 Apr 2021 00:15:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235958AbhDSAPo (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 18 Apr 2021 20:15:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235947AbhDSAPm (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Apr 2021 20:15:42 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DE2BC06174A
        for <git@vger.kernel.org>; Sun, 18 Apr 2021 17:15:13 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id h15so6320138qvu.4
        for <git@vger.kernel.org>; Sun, 18 Apr 2021 17:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WkFrG3l+kM7XmDDgEvtgfAvzcfQkwheP7JO1Ypm9mMI=;
        b=QhcIAKpZnRrFAPDRVbyFhHPG1ctigrlfn0foiGINAtbcHuXuXlz52dj5t/f//k9uFN
         pvfchrlBrFce5Sw6q4ycZ+z3LjzzMqexk3+R8+ApaOKPL+jtyVj7PhdQ79Cb39WYxQHE
         QWnwjqzQDVFdOPOGpJuXh+yPbZiWAQ5h4pMLmNdfL/5GqiKGWiHa1D82JFIWO88UAnWZ
         k3gO6wZ+xybynai3xoxR6kb9rkLV49cUNtBOwFwwDjNE56mUiz+74KxrUzDENSzIyz06
         d85Jp7XM2p4Zxy7DluGRCVzKf6VN4axdNKQqbuzTaNTk4TkQCagwOMF6kXQy0J6wkD2l
         q8UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WkFrG3l+kM7XmDDgEvtgfAvzcfQkwheP7JO1Ypm9mMI=;
        b=Jx5aNng7eMHxfNpP6krSyimutA4tdWtz9RAwr5LAepdo3oW30Sa5+92yhTlhfWM9y4
         JdGFuObYcBAA5hKRLpkyyWm0L+ey+aXUUtznl8yGCbFXLUaPFG9r5SlqQmGmLA7PaIu5
         yE7fDRrpcaVpykJZAHEu1cBefNKxjTZgDKgTnFs/7tibqQjIT3jGlK2IhGpusyi9J+N9
         iIE6LWHHVoivf/eGyRaJyIS5c7+K4SirguLN9js08wKvr/SGKGLHqiSg/Mi4Lo0IMTLg
         nl7MFoyVzPO01NXMv3afVpmFXjfmFD26TRw8sIlKlyAXHDhTmwgVflCnWlAWjmaBNnew
         ZkIQ==
X-Gm-Message-State: AOAM533bTeIVaOJGGAGd5ysCTPW88w9oTVBD46IeFq5en8fjerS3/HqZ
        2aLSSjhXpTvLw6C6hcFSVqvU1A==
X-Google-Smtp-Source: ABdhPJzWf/6SQEEehCips3whRl3c0y+QDiiYo9aqqecayoUL0bzccvZcy+327IP5t13TXMUqH/x0RA==
X-Received: by 2002:a0c:f147:: with SMTP id y7mr7349644qvl.17.1618791312875;
        Sun, 18 Apr 2021 17:15:12 -0700 (PDT)
Received: from mango.meuintelbras.local ([177.32.118.149])
        by smtp.gmail.com with ESMTPSA id f12sm8272062qti.63.2021.04.18.17.15.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Apr 2021 17:15:12 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, christian.couder@gmail.com,
        git@jeffhostetler.com
Subject: [PATCH v3 4/5] parallel-checkout: support progress displaying
Date:   Sun, 18 Apr 2021 21:14:56 -0300
Message-Id: <cf9e28dc0eddfc8e36a64b9738c94bb790349092.1618790794.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <cover.1618790794.git.matheus.bernardino@usp.br>
References: <cover.1618790794.git.matheus.bernardino@usp.br>
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

