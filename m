Return-Path: <SRS0=S9iH=BU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD9D8C433DF
	for <git@archiver.kernel.org>; Mon, 10 Aug 2020 21:35:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1E0B206DA
	for <git@archiver.kernel.org>; Mon, 10 Aug 2020 21:35:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="kH18h29A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726679AbgHJVfY (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Aug 2020 17:35:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726472AbgHJVfX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Aug 2020 17:35:23 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1FE3C061756
        for <git@vger.kernel.org>; Mon, 10 Aug 2020 14:35:22 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id x69so9892763qkb.1
        for <git@vger.kernel.org>; Mon, 10 Aug 2020 14:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jBwE97t+9764gI7oLRHp0q8Zfh9t9w578Xwe4bC6nC8=;
        b=kH18h29A87Bekqudq4yIhwZMObSB59yvlltxm1e85aaHKq5yKve8STcejALoLAQW1c
         KB0W2v9F1h7a2Z7zIzloqv+wRrNvjvi8df1/odib/Kt3Bhbi0hxd3aief+rMyIdOVxrD
         cbtMr2GSTFwkY01HcJOBbnG3if7qvnZBs0Dl8unfGHW4akuJ52kdyQjnMv9gc/vlWCQ/
         P8rSxv9kbGYLq8mWSc1ZGRSgV/rVJ/c+GCPBHYPbh44CaHCrarX/CrKhPmUsk0yIuawS
         /vEbGiCXydpR3Ej69q0RsxKZNOy+FKDC9MlhjjDdKc4Q7KYhky9j4U6cqIpw+qh5982b
         qTsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jBwE97t+9764gI7oLRHp0q8Zfh9t9w578Xwe4bC6nC8=;
        b=lm20hZ/Y3myyi1XgqUrwwXou0rxjTY0TbK3TQvzJC5REawWCCInZY7HZFaDEyPi7GV
         K3t6LhtxlGZQr9hYmRchSWbr/V3LuYuEEOG4UxMDX8B4E5ELWR6o8Crboz4Ue0pHh9UK
         eYu+cnYqDmcU9o+5IQYP40HWhXLqj8ljerUipg5s4YUKZeI+r4humhPre/LoycucSZde
         lEByABRWsxbnIpsAvndfX4YE13U+DA7BovCPx7puUsAi4odhET85OnJyDFXMTk14ZVuv
         qDDBPfAdZnHK/Y8D0rCVSLmM19HYrQUXGZjf5tyJEnMBbnkC3ov+2TtGGPnoBKaxeUwH
         ORYg==
X-Gm-Message-State: AOAM530jSxwA0wjSE4TqkI1k7B7yHWeFsCOBMd0p5FB4ouwnm8EeqtI8
        QedAx6qSG9vnsHUNLR4lYc1vm9LvOxY=
X-Google-Smtp-Source: ABdhPJzY+uz5HG0tgN3dLpXuFLzt5+oKjh6aob4MuymFICKWMSmfNrQ/vTwiBG3Lsz5rr8dIPoF2kg==
X-Received: by 2002:a37:8484:: with SMTP id g126mr28251144qkd.230.1597095321768;
        Mon, 10 Aug 2020 14:35:21 -0700 (PDT)
Received: from localhost.localdomain ([2804:18:87c:466:1120:3c2c:21e4:5931])
        by smtp.gmail.com with ESMTPSA id z197sm15370674qkb.66.2020.08.10.14.35.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2020 14:35:21 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, jeffhost@microsoft.com,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>
Subject: [RFC PATCH 13/21] parallel-checkout: support progress displaying
Date:   Mon, 10 Aug 2020 18:33:21 -0300
Message-Id: <e271d73091de42b30123ae1fffaadb61ad23de44.1597093021.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1597093021.git.matheus.bernardino@usp.br>
References: <cover.1597093021.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Original-patch-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
 parallel-checkout.c | 40 +++++++++++++++++++++++++++++++++++++---
 parallel-checkout.h |  4 +++-
 unpack-trees.c      | 11 ++++++++---
 3 files changed, 48 insertions(+), 7 deletions(-)

diff --git a/parallel-checkout.c b/parallel-checkout.c
index e0fca4d380..78bf2de5ea 100644
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
@@ -10,6 +11,8 @@
 struct parallel_checkout {
 	struct checkout_item *items;
 	size_t nr, alloc;
+	struct progress *progress;
+	unsigned int *progress_cnt;
 };
 
 static struct parallel_checkout *parallel_checkout = NULL;
@@ -121,6 +124,22 @@ int enqueue_checkout(struct cache_entry *ce, struct conv_attrs *ca)
 	return 0;
 }
 
+size_t pc_queue_size(void)
+{
+	if (!parallel_checkout)
+		return 0;
+	return parallel_checkout->nr;
+}
+
+static void advance_progress_meter(void)
+{
+	if (parallel_checkout && parallel_checkout->progress) {
+		(*parallel_checkout->progress_cnt)++;
+		display_progress(parallel_checkout->progress,
+				 *parallel_checkout->progress_cnt);
+	}
+}
+
 static int handle_results(struct checkout *state)
 {
 	int ret = 0;
@@ -132,6 +151,10 @@ static int handle_results(struct checkout *state)
 		struct checkout_item *ci = &parallel_checkout->items[i];
 		struct stat *st = &ci->st;
 
+		/*
+		 * Note: progress meter was already incremented for CI_SUCCESS
+		 * and CI_FAILED.
+		 */
 		switch(ci->status) {
 		case CI_SUCCESS:
 			update_ce_after_write(state, ci->ce, st);
@@ -145,6 +168,7 @@ static int handle_results(struct checkout *state)
 			 * leading dirs in the entry's path.
 			 */
 			ret |= checkout_entry_ca(ci->ce, &ci->ca, state, NULL, NULL);
+			advance_progress_meter();
 			break;
 		case CI_FAILED:
 			ret = -1;
@@ -434,6 +458,9 @@ static void parse_and_save_result(const char *line, int len)
 	 */
 	if (res->status == CI_SUCCESS)
 		ci->st = res->st;
+
+	if (res->status != CI_RETRY)
+		advance_progress_meter();
 }
 
 static void gather_results_from_workers(struct child_process *workers,
@@ -490,12 +517,17 @@ static void gather_results_from_workers(struct child_process *workers,
 static int run_checkout_sequentially(struct checkout *state)
 {
 	size_t i;
-	for (i = 0; i < parallel_checkout->nr; ++i)
-		write_checkout_item(state, &parallel_checkout->items[i]);
+	for (i = 0; i < parallel_checkout->nr; ++i) {
+		struct checkout_item *ci = &parallel_checkout->items[i];
+		write_checkout_item(state, ci);
+		if (ci->status != CI_RETRY)
+			advance_progress_meter();
+	}
 	return handle_results(state);
 }
 
-int run_parallel_checkout(struct checkout *state, int num_workers, int threshold)
+int run_parallel_checkout(struct checkout *state, int num_workers, int threshold,
+			  struct progress *progress, unsigned int *progress_cnt)
 {
 	int ret = 0;
 	struct child_process *workers;
@@ -508,6 +540,8 @@ int run_parallel_checkout(struct checkout *state, int num_workers, int threshold
 		    num_workers);
 
 	pc_status = PC_RUNNING;
+	parallel_checkout->progress = progress;
+	parallel_checkout->progress_cnt = progress_cnt;
 
 	if (parallel_checkout->nr == 0) {
 		goto done;
diff --git a/parallel-checkout.h b/parallel-checkout.h
index b4d412c8b5..2b81a5db6c 100644
--- a/parallel-checkout.h
+++ b/parallel-checkout.h
@@ -27,13 +27,15 @@ void get_parallel_checkout_configs(int *num_workers, int *threshold);
  * write and return 0.
  */
 int enqueue_checkout(struct cache_entry *ce, struct conv_attrs *ca);
+size_t pc_queue_size(void);
 
 /*
  * Write all the queued entries, returning 0 on success. If the number of
  * entries is below the specified threshold, the operation is performed
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
2.27.0

