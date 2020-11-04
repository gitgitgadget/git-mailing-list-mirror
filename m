Return-Path: <SRS0=V3lj=EK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A139AC2D0A3
	for <git@archiver.kernel.org>; Wed,  4 Nov 2020 20:34:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61EFE20782
	for <git@archiver.kernel.org>; Wed,  4 Nov 2020 20:34:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="cOugElVH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732109AbgKDUeO (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Nov 2020 15:34:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728607AbgKDUeO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Nov 2020 15:34:14 -0500
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E361C0613D3
        for <git@vger.kernel.org>; Wed,  4 Nov 2020 12:34:13 -0800 (PST)
Received: by mail-qt1-x843.google.com with SMTP id p12so5848497qtp.7
        for <git@vger.kernel.org>; Wed, 04 Nov 2020 12:34:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nniXm58SRqD73ZfcT3w97kXgUyF7Zil/o9rceqXrynk=;
        b=cOugElVHfk9Z9CZjaYpMsKlBJPqVDw/4hLTvHopKsUiJF8CHWWHR7+7n2MJ9YKlE5B
         9rV3PzsLzk3ixLUg+tbgXE8Xnn5ucMduDafShAvYaLmfscZqlJw5bh0dJpfj1fnKcgl2
         BR5vHPJCLr3rKdeCwNUfY2huFUTlVMSAyYgStDvP6XSY/19tIaCBRqOGytRMZeVI1+o6
         OlmzluA5vI69rlFVtH1nAxFj5vUDXKNI1dXw9nR7ScVBUFjwYNdRXy4IwbSXpKwZbsGz
         rchXxfxZSQnkejk26ZdmOubhCp82pyoCY8Lh3SrJvfP80iDVNPcIm/eBxZJsezuEGOme
         6zBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nniXm58SRqD73ZfcT3w97kXgUyF7Zil/o9rceqXrynk=;
        b=DMqYpl3evJLt+JBuRBbw1ynq1EsgWm+DVs8wowXzssjS9WRRQE9vJOC6/8I6d4X/rJ
         eLOqD6hqukMxPkazLVTzgS+RNgKN1zilpDvlp/Y0/of7gXtKC4emUgaqRaFd3PAo8fR1
         OSuiAq049pJR2YfwYJHkXNMvNWRZfgj+OuwOmkSuqK7qfhVceyE0f7mqWgAZd+uaDXtH
         GnZwPA3AfhVw1gPQnEO41dOpMQJIjZUxVmcK2PiQpm81LqDn7I7mApcRJQh3fxw1xvzd
         CRBm03x3CTpUHFKbeslBg+qXcx9g8gyUMAmCOe9UPT3FP0cFsn8qTj72M1gqxCVvFcQo
         Zj1g==
X-Gm-Message-State: AOAM531BGi5JTqNUJG+l8DFEM6RO9xwJT69D9TESMsmmbYqhXvBThdsC
        dcgEp1IoFk0yMXDI8pIkUodRNXxeSoEdJw==
X-Google-Smtp-Source: ABdhPJxi3+AjSJPc9j942WBnEqu/zX2RiK0TTRGhe/3I5eGoncIeuJj4UfCetr960D4zaZGkjOmNKQ==
X-Received: by 2002:ac8:2af0:: with SMTP id c45mr22392468qta.4.1604522052421;
        Wed, 04 Nov 2020 12:34:12 -0800 (PST)
Received: from mango.meuintelbras.local ([177.32.118.149])
        by smtp.gmail.com with ESMTPSA id m15sm1100971qtc.90.2020.11.04.12.34.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 12:34:11 -0800 (PST)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, git@jeffhostetler.com, chriscool@tuxfamily.org,
        peff@peff.net, newren@gmail.com, jrnieder@gmail.com,
        martin.agren@gmail.com
Subject: [PATCH v4 12/19] parallel-checkout: support progress displaying
Date:   Wed,  4 Nov 2020 17:33:11 -0300
Message-Id: <2b426215827cddc46f908feb3de38e67c95b5efa.1604521276.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1604521275.git.matheus.bernardino@usp.br>
References: <cover.1604521275.git.matheus.bernardino@usp.br>
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
index 2d77998f46..72ac93d541 100644
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
 
 static struct parallel_checkout parallel_checkout;
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
@@ -500,6 +518,9 @@ static void parse_and_save_result(const char *line, int len,
 	pc_item->status = res->status;
 	if (st)
 		pc_item->st = *st;
+
+	if (res->status != PC_ITEM_COLLIDED)
+		advance_progress_meter();
 }
 
 
@@ -559,11 +580,16 @@ static void write_items_sequentially(struct checkout *state)
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
 
@@ -571,6 +597,8 @@ int run_parallel_checkout(struct checkout *state, int num_workers, int threshold
 		BUG("cannot run parallel checkout: uninitialized or already running");
 
 	parallel_checkout.status = PC_RUNNING;
+	parallel_checkout.progress = progress;
+	parallel_checkout.progress_cnt = progress_cnt;
 
 	if (parallel_checkout.nr < num_workers)
 		num_workers = parallel_checkout.nr;
diff --git a/parallel-checkout.h b/parallel-checkout.h
index 54314ccdc5..8377b179d5 100644
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

