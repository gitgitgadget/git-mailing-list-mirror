Return-Path: <SRS0=S9iH=BU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DD2BC433E0
	for <git@archiver.kernel.org>; Mon, 10 Aug 2020 21:35:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4CE652073E
	for <git@archiver.kernel.org>; Mon, 10 Aug 2020 21:35:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="oGXTqHf0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726632AbgHJVfU (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Aug 2020 17:35:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726472AbgHJVfT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Aug 2020 17:35:19 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D22AC061756
        for <git@vger.kernel.org>; Mon, 10 Aug 2020 14:35:19 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id 2so9840565qkf.10
        for <git@vger.kernel.org>; Mon, 10 Aug 2020 14:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Qs381WwVWvq+55aulTzUiJ3886qQM5oDZ5ByL3RhMkQ=;
        b=oGXTqHf0Zv2ieY0U6ipQOU24Y+zGiSz+knRSkL5w+qlEEX8vWJBevRWeW3WDfQ5gxf
         phmY+0TfY1DKltndDSH2LZys/ydyGBWd2Ma6BBHaCnBpSi+G95Tbghp8cnYCB9uKmx0y
         O8U4QOOtducR8YM+G8ZYjILGMCzZILuzX18j0jmA1bF7U6EBmMMtl1LdPuyPR0SmRXeL
         xzWHOqDF8RgLM7kHwkKWsLc4gryR9pSEo10oZrNRd8NI9xPMBF1sTtLbwfjl1dhrZa6J
         g4O6AyIPBStZZ3bWhVL1GC+c9ivFu6ocd/DWYC6TG6MtuljKJAn6OG5kiEDwK1TT36CJ
         nHNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Qs381WwVWvq+55aulTzUiJ3886qQM5oDZ5ByL3RhMkQ=;
        b=lB5VsQmFZ+zvb/dCEois/WOhCaMM7KA8OYFRtM8Lx3+MGARocW3YZXe5s33PflfTUd
         gqFzlh/Mt+nbKM3IHPBhwfqADeETkVlOnuGPCTgojLnGjLB8LVTsxpabd0dfXRpJ3pxz
         O9BjjbN9s3rRlwPN7ND4B0H9138ob/7vxsOz0Tt4a2uFiPsXDtjA+jnDnBoIKHq2krn4
         5v29rvHNPoHVAImO6rnz8xO+0NVsxo0dywHog2Fn4HNRXscRGYTvl24+B16E2VliUJza
         l7kgZwgSq7CXrdylhVeUSepHnGT3C+J3t9P4KUwCR/MECltIibGdwnwVEdA3fBJZFhqv
         l7nA==
X-Gm-Message-State: AOAM530d/A3X7KnHoAlJTVTIlYI86fHtlFfz5CcFyFYKTPHyd7Lo7fFK
        5y/WGratBq4lSLg3ErGWpu7n1+tiFQk=
X-Google-Smtp-Source: ABdhPJxDuFA4hCRnpm9MRgD1eN5uT4SjLiYrgwzeKESpgReBGkSDenElMq4CWunf1WKcyx/K0MW03w==
X-Received: by 2002:a37:614:: with SMTP id 20mr27945572qkg.456.1597095317743;
        Mon, 10 Aug 2020 14:35:17 -0700 (PDT)
Received: from localhost.localdomain ([2804:18:87c:466:1120:3c2c:21e4:5931])
        by smtp.gmail.com with ESMTPSA id z197sm15370674qkb.66.2020.08.10.14.35.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2020 14:35:17 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, jeffhost@microsoft.com,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Stefan Beller <stefanbeller@gmail.com>
Subject: [RFC PATCH 12/21] parallel-checkout: add configuration options
Date:   Mon, 10 Aug 2020 18:33:20 -0300
Message-Id: <1263342110bfc96480146df0f876a5c936b61ce1.1597093021.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1597093021.git.matheus.bernardino@usp.br>
References: <cover.1597093021.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add the checkout.workers and checkout.workerThreshold settings, which
allow users to configure and/or disable the parallel checkout feature as
desired. The first setting defines the number of workers and the second
defines the minimum number of entries to attempt parallel checkout.

Co-authored-by: Jeff Hostetler <jeffhost@microsoft.com>
Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---

I still have to evaluate what is the best default value for
checkout.workersThreshold. For now, I used 0 so that the test suite uses
parallel-checkout by default, exercising the new code. I'm open to
suggestions on how we can improve testing for it, once 
checkout.workersThreshold is no longer 0.

Note: the default number of workers can probably be better calculated as
well, multiplying the number of cores by some factor. My machine, for
example, has 8 logical cores but 10 workers leads to the fastest
execution.

 Documentation/config/checkout.txt | 16 ++++++++++++++++
 parallel-checkout.c               | 26 +++++++++++++++++++++-----
 parallel-checkout.h               | 11 +++++++++--
 unpack-trees.c                    | 10 +++++++---
 4 files changed, 53 insertions(+), 10 deletions(-)

diff --git a/Documentation/config/checkout.txt b/Documentation/config/checkout.txt
index 6b646813ab..9dabdf9231 100644
--- a/Documentation/config/checkout.txt
+++ b/Documentation/config/checkout.txt
@@ -16,3 +16,19 @@ will checkout the '<something>' branch on another remote,
 and by linkgit:git-worktree[1] when 'git worktree add' refers to a
 remote branch. This setting might be used for other checkout-like
 commands or functionality in the future.
+
+checkout.workers::
+	The number of worker processes to use when updating the working tree.
+	If unset (or set to a value less than one), Git will use as many
+	workers as the number of logical cores available. One means sequential
+	execution. This and the checkout.workersThreshold settings affect all
+	commands which perform checkout. E.g. checkout, switch, clone,
+	sparse-checkout, read-tree, etc.
+
+checkout.workersThreshold::
+	If set to a positive number, parallel checkout will not be attempted
+	when the number of files to be updated is less than the defined limit.
+	When set to a negative number or unset, defaults to 0. The reasoning
+	behind this config is that, when modifying a small number of files, a
+	sequential execution might be faster, as it avoids the cost of spawning
+	subprocesses and inter-process communication.
diff --git a/parallel-checkout.c b/parallel-checkout.c
index ec42342bc8..e0fca4d380 100644
--- a/parallel-checkout.c
+++ b/parallel-checkout.c
@@ -4,6 +4,8 @@
 #include "pkt-line.h"
 #include "run-command.h"
 #include "streaming.h"
+#include "thread-utils.h"
+#include "config.h"
 
 struct parallel_checkout {
 	struct checkout_item *items;
@@ -18,6 +20,19 @@ enum pc_status parallel_checkout_status(void)
 	return pc_status;
 }
 
+#define DEFAULT_WORKERS_THRESHOLD 0
+
+void get_parallel_checkout_configs(int *num_workers, int *threshold)
+{
+	if (git_config_get_int("checkout.workers", num_workers) ||
+	    *num_workers < 1)
+		*num_workers = online_cpus();
+
+	if (git_config_get_int("checkout.workersThreshold", threshold) ||
+	    *threshold < 0)
+		*threshold = DEFAULT_WORKERS_THRESHOLD;
+}
+
 void init_parallel_checkout(void)
 {
 	if (parallel_checkout)
@@ -480,22 +495,23 @@ static int run_checkout_sequentially(struct checkout *state)
 	return handle_results(state);
 }
 
-static const int workers_threshold = 0;
-
-int run_parallel_checkout(struct checkout *state)
+int run_parallel_checkout(struct checkout *state, int num_workers, int threshold)
 {
-	int num_workers = online_cpus();
 	int ret = 0;
 	struct child_process *workers;
 
 	if (!parallel_checkout)
 		BUG("cannot run parallel checkout: not initialized yet");
 
+	if (num_workers < 1)
+		BUG("invalid number of workers for run_parallel_checkout: %d",
+		    num_workers);
+
 	pc_status = PC_RUNNING;
 
 	if (parallel_checkout->nr == 0) {
 		goto done;
-	} else if (parallel_checkout->nr < workers_threshold || num_workers == 1) {
+	} else if (parallel_checkout->nr < threshold || num_workers == 1) {
 		ret = run_checkout_sequentially(state);
 		goto done;
 	}
diff --git a/parallel-checkout.h b/parallel-checkout.h
index f25f2874ae..b4d412c8b5 100644
--- a/parallel-checkout.h
+++ b/parallel-checkout.h
@@ -18,6 +18,9 @@ enum pc_status {
 enum pc_status parallel_checkout_status(void);
 void init_parallel_checkout(void);
 
+/* Reads the checkout.workers and checkout.workersThreshold settings. */
+void get_parallel_checkout_configs(int *num_workers, int *threshold);
+
 /*
  * Return -1 if parallel checkout is currently not enabled or if the entry is
  * not eligible for parallel checkout. Otherwise, enqueue the entry for later
@@ -25,8 +28,12 @@ void init_parallel_checkout(void);
  */
 int enqueue_checkout(struct cache_entry *ce, struct conv_attrs *ca);
 
-/* Write all the queued entries, returning 0 on success. */
-int run_parallel_checkout(struct checkout *state);
+/*
+ * Write all the queued entries, returning 0 on success. If the number of
+ * entries is below the specified threshold, the operation is performed
+ * sequentially.
+ */
+int run_parallel_checkout(struct checkout *state, int num_workers, int threshold);
 
 /****************************************************************
  * Interface with checkout--helper
diff --git a/unpack-trees.c b/unpack-trees.c
index 1b1da7485a..117ed42370 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -399,7 +399,7 @@ static int check_updates(struct unpack_trees_options *o,
 	int errs = 0;
 	struct progress *progress;
 	struct checkout state = CHECKOUT_INIT;
-	int i;
+	int i, pc_workers, pc_threshold;
 
 	trace_performance_enter();
 	state.force = 1;
@@ -462,8 +462,11 @@ static int check_updates(struct unpack_trees_options *o,
 		oid_array_clear(&to_fetch);
 	}
 
+	get_parallel_checkout_configs(&pc_workers, &pc_threshold);
+
 	enable_delayed_checkout(&state);
-	init_parallel_checkout();
+	if (pc_workers > 1)
+		init_parallel_checkout();
 	for (i = 0; i < index->cache_nr; i++) {
 		struct cache_entry *ce = index->cache[i];
 
@@ -477,7 +480,8 @@ static int check_updates(struct unpack_trees_options *o,
 		}
 	}
 	stop_progress(&progress);
-	errs |= run_parallel_checkout(&state);
+	if (pc_workers > 1)
+		errs |= run_parallel_checkout(&state, pc_workers, pc_threshold);
 	errs |= finish_delayed_checkout(&state, NULL);
 	git_attr_set_direction(GIT_ATTR_CHECKIN);
 
-- 
2.27.0

