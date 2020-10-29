Return-Path: <SRS0=U/aV=EE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D831C56201
	for <git@archiver.kernel.org>; Thu, 29 Oct 2020 02:16:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 020002076B
	for <git@archiver.kernel.org>; Thu, 29 Oct 2020 02:16:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="WWC23hif"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391077AbgJ2CQr (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Oct 2020 22:16:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729870AbgJ2CQI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Oct 2020 22:16:08 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3499AC0613CF
        for <git@vger.kernel.org>; Wed, 28 Oct 2020 19:16:08 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id b18so866689qkc.9
        for <git@vger.kernel.org>; Wed, 28 Oct 2020 19:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=w74KLyxJJrZ35tgyAAxi/gyAxURp+mAbLnstGNoRi3o=;
        b=WWC23hifQ2zxGXf4XjDVGScxtAe8/RDhDa6iRguGG6xI4fZJKDfDUkw82dyVvIupgQ
         iYy0aAtM1TMY+oQqXkBz/saAjgsqxZMXnZ10/CritHy1XgV1vyooO38qdYcG7E7mr2zM
         G7KdFqo4VtDcbV1bVKbH8W1myZ2aPO58mA09kg5ZLuniFevrMaeJEz80S5Rk95Z9q3I6
         1hPs7Zeqaj41QhiWZEaSiMoABYUMfgQob8Xs5lediQVDS/QgqT9hRVsuA09JLyDsfFNT
         bkwsx3Tr1PuMpSWDxk9QJ4Ym4yS/T0PXUcguhmv5dlr7sY4dysBUgmm9DQrtaRoR2v3m
         ujkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=w74KLyxJJrZ35tgyAAxi/gyAxURp+mAbLnstGNoRi3o=;
        b=onqIwFORUnVLalo4kx9jnd2vWhTSvYfZxhy2SchrRvZA+uwuoXRngpz/8sr5oqEJAX
         L3rG270AjJAuk4FiGUVbaAu9mT+ePWg5eAJ9HNDG4okIzv139ZaplaaQCsZ+AUXduT8H
         jJJaRr95gglr0uTWxwDjFySHrXniAZEtR+DIH4iS6j1+s44IidcLjtZtqE1o/2NfnsbR
         svQK67B5JRZGIexy8ETv7UltUpQ7AqqrjrKbjD2LPhq/v0Tv6K1R4UEUzk+xdB85k0Jn
         FwGZt4pHxexbqj9UqK8aKrwei8KJSYOsD5hvipVXxtT8BLevxN2CoHbFSqPA7mpMV1IH
         ASjg==
X-Gm-Message-State: AOAM5336dH5FLS/sL5xTveOkTSPWRcMzbG98FhZzMpBHRkydR54ONyyz
        b3VH4+QkKf41cp1h4Ii7B0lwVIRWoA9BOQ==
X-Google-Smtp-Source: ABdhPJzs7lgts87MQV4ng5/H2++YDQy1P6tLQpvmbq181IAlY0YYexv++AGvxLZsXeR31KSok2eCug==
X-Received: by 2002:a37:448c:: with SMTP id r134mr1735581qka.357.1603937767034;
        Wed, 28 Oct 2020 19:16:07 -0700 (PDT)
Received: from mango.meuintelbras.local ([177.32.118.149])
        by smtp.gmail.com with ESMTPSA id n201sm608371qka.32.2020.10.28.19.16.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2020 19:16:06 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, git@jeffhostetler.com, chriscool@tuxfamily.org,
        peff@peff.net, newren@gmail.com, jrnieder@gmail.com,
        martin.agren@gmail.com
Subject: [PATCH v3 12/19] parallel-checkout: support progress displaying
Date:   Wed, 28 Oct 2020 23:14:49 -0300
Message-Id: <9cfeb4821ca88fe25122798239316c4524f28c92.1603937110.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1603937110.git.matheus.bernardino@usp.br>
References: <cover.1603937110.git.matheus.bernardino@usp.br>
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
index a5508e27c2..c5c449d224 100644
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
 
@@ -577,6 +603,8 @@ int run_parallel_checkout(struct checkout *state, int num_workers, int threshold
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

