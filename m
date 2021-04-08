Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EA3EC433B4
	for <git@archiver.kernel.org>; Thu,  8 Apr 2021 16:17:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 445EA61057
	for <git@archiver.kernel.org>; Thu,  8 Apr 2021 16:17:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232208AbhDHQRj (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Apr 2021 12:17:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232085AbhDHQRd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Apr 2021 12:17:33 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E1BBC061763
        for <git@vger.kernel.org>; Thu,  8 Apr 2021 09:17:19 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id bs7so670233qvb.12
        for <git@vger.kernel.org>; Thu, 08 Apr 2021 09:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mzGNrNakRCvDjDfnG1Ky81Kkdp5IkRZp9tXGzUcLUWI=;
        b=pVNKC6kMGYxfZBkE0e3J/6vB5NSYfhosfU4E6FVV47cHNRQ5rHTwYwdWHeBYLHA3CE
         ObFm9FZ2J0ztQXCXVrXkjfRwOeIpmyN14ibBUGj27o1rUIXeMSVpTNdcCD8hobEhcez7
         8kgnWxtJhqdf3mEtfhn6f1SP+9dJGNk7XFKGSo/yyCHeeVNB/QSWVkzETTjnJPvseTi5
         UzabRlWLQCG9u77dQEOhe7y/U4qCo4W4Lr7KGSd8PG2GSxEO/OXkwcQ+AJlWWchbRAf9
         JI5/v6FN18Za2MOE9hAD2QoJjtK7eKN/DUISOrfwQAA/yQ1J3PbsHtmX90jIIRBVTrfx
         pB/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mzGNrNakRCvDjDfnG1Ky81Kkdp5IkRZp9tXGzUcLUWI=;
        b=Jy8RHviqtmvVm9HOjeigNAmvp64aIlIcxRAzq4F1Zn41en/66u0YZca+KT8iJ1/JtU
         zw8nkuT9u4skZ6E1MdyVFsjOc2lue41f1S5xXrQclxC40A9Gq6/5AUXeXjyx1rARYbXR
         oszOdAkMUa6ueL6SSzDM403Ii5b7g7wk6jia+MMY3szJvsVpNnU8WBjDO6nm4hYODiKG
         8iEu0kGrqRQOVE1U9RB/pTirXnKfgXiMCy2uBatnOr3oTFtCEeWm2ckKRNOr2Y0zAYB/
         VR7a6iyjf7THHUsi1WCqcnlOYyQpxsuXv2Bi+3nekKSxjXpI+x34vF79o+L4dQxBHuK0
         CdgA==
X-Gm-Message-State: AOAM530lTrHdHsG8ob/MEjEEm4FftBxEPaH8h9sczM+UlAUrcKp7CNN3
        4bjXDNbfwplsw+TMeX86CWWq+fi68Ks3qA==
X-Google-Smtp-Source: ABdhPJwcweLnEXVuKwCIQhLe6tMNFg19ENhnfsthfDueQ8mdhKiPNz0cow5xmL/DOSLyV9xTu628dg==
X-Received: by 2002:a0c:aa98:: with SMTP id f24mr2903592qvb.19.1617898638119;
        Thu, 08 Apr 2021 09:17:18 -0700 (PDT)
Received: from mango.meuintelbras.local ([177.32.118.149])
        by smtp.gmail.com with ESMTPSA id d18sm18087369qtd.85.2021.04.08.09.17.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Apr 2021 09:17:17 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     christian.couder@gmail.com, gitster@pobox.com,
        git@jeffhostetler.com
Subject: [PATCH v2 3/5] parallel-checkout: add configuration options
Date:   Thu,  8 Apr 2021 13:17:02 -0300
Message-Id: <6ea057f9c555882d8aa67bc9a2952f7d5a79548d.1617893234.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <cover.1617893234.git.matheus.bernardino@usp.br>
References: <cover.1617893234.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Make parallel checkout configurable by introducing two new settings:
checkout.workers and checkout.thresholdForParallelism. The first defines
the number of workers (where one means sequential checkout), and the
second defines the minimum number of entries to attempt parallel
checkout.

To decide the default value for checkout.workers, the parallel version
was benchmarked during three operations in the linux repo, with cold
cache: cloning v5.8, checking out v5.8 from v2.6.15 (checkout I) and
checking out v5.8 from v5.7 (checkout II). The four tables below show
the mean run times and standard deviations for 5 runs in: a local file
system on SSD, a local file system on HDD, a Linux NFS server, and
Amazon EFS (all on Linux). Each parallel checkout test was executed with
the number of workers that brings the best overall results in that
environment.

Local SSD:
             Sequential             10 workers            Speedup
Clone        8.805 s ± 0.043 s      3.564 s ± 0.041 s     2.47 ± 0.03
Checkout I   9.678 s ± 0.057 s      4.486 s ± 0.050 s     2.16 ± 0.03
Checkout II  5.034 s ± 0.072 s      3.021 s ± 0.038 s     1.67 ± 0.03

Local HDD:
             Sequential             10 workers             Speedup
Clone        32.288 s ± 0.580 s     30.724 s ± 0.522 s    1.05 ± 0.03
Checkout I   54.172 s ±  7.119 s    54.429 s ± 6.738 s    1.00 ± 0.18
Checkout II  40.465 s ± 2.402 s     38.682 s ± 1.365 s    1.05 ± 0.07

Linux NFS server (v4.1, on EBS, single availability zone):

             Sequential             32 workers            Speedup
Clone        240.368 s ± 6.347 s    57.349 s ± 0.870 s    4.19 ± 0.13
Checkout I   242.862 s ± 2.215 s    58.700 s ± 0.904 s    4.14 ± 0.07
Checkout II  65.751 s ± 1.577 s     23.820 s ± 0.407 s    2.76 ± 0.08

EFS (v4.1, replicated over multiple availability zones):

             Sequential             32 workers            Speedup
Clone        922.321 s ± 2.274 s    210.453 s ± 3.412 s   4.38 ± 0.07
Checkout I   1011.300 s ± 7.346 s   297.828 s ± 0.964 s   3.40 ± 0.03
Checkout II  294.104 s ± 1.836 s    126.017 s ± 1.190 s   2.33 ± 0.03

The above benchmarks show that parallel checkout is most effective on
repositories located on an SSD or over a distributed file system. For
local file systems on spinning disks, and/or older machines, the
parallelism does not always bring a good performance. For this reason,
the default value for checkout.workers is one, a.k.a. sequential
checkout.

To decide the default value for checkout.thresholdForParallelism,
another benchmark was executed in the "Local SSD" setup, where parallel
checkout showed to be beneficial. This time, we compared the runtime of
a `git checkout -f`, with and without parallelism, after randomly
removing an increasing number of files from the Linux working tree. The
"sequential fallback" column below corresponds to the executions where
checkout.workers was 10 but checkout.thresholdForParallelism was equal
to the number of to-be-updated files plus one (so that we end up writing
sequentially). Each test case was sampled 15 times, and each sample had
a randomly different set of files removed. Here are the results:

             sequential fallback   10 workers           speedup
10   files    772.3 ms ± 12.6 ms   769.0 ms ± 13.6 ms   1.00 ± 0.02
20   files    780.5 ms ± 15.8 ms   775.2 ms ±  9.2 ms   1.01 ± 0.02
50   files    806.2 ms ± 13.8 ms   767.4 ms ±  8.5 ms   1.05 ± 0.02
100  files    833.7 ms ± 21.4 ms   750.5 ms ± 16.8 ms   1.11 ± 0.04
200  files    897.6 ms ± 30.9 ms   730.5 ms ± 14.7 ms   1.23 ± 0.05
500  files   1035.4 ms ± 48.0 ms   677.1 ms ± 22.3 ms   1.53 ± 0.09
1000 files   1244.6 ms ± 35.6 ms   654.0 ms ± 38.3 ms   1.90 ± 0.12
2000 files   1488.8 ms ± 53.4 ms   658.8 ms ± 23.8 ms   2.26 ± 0.12

From the above numbers, 100 files seems to be a reasonable default value
for the threshold setting.

Note: Up to 1000 files, we observe a drop in the execution time of the
parallel code with an increase in the number of files. This is a rather
odd behavior, but it was observed in multiple repetitions. Above 1000
files, the execution time increases according to the number of files, as
one would expect.

About the test environments: Local SSD tests were executed on an
i7-7700HQ (4 cores with hyper-threading) running Manjaro Linux. Local
HDD tests were executed on an Intel(R) Xeon(R) E3-1230 (also 4 cores
with hyper-threading), HDD Seagate Barracuda 7200.14 SATA 3.1, running
Debian. NFS and EFS tests were executed on an Amazon EC2 c5n.xlarge
instance, with 4 vCPUs. The Linux NFS server was running on a m6g.large
instance with 2 vCPUSs and a 1 TB EBS GP2 volume. Before each timing,
the linux repository was removed (or checked out back to its previous
state), and `sync && sysctl vm.drop_caches=3` was executed.

Co-authored-by: Jeff Hostetler <jeffhost@microsoft.com>
Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
 Documentation/config/checkout.txt | 21 +++++++++++++++++++++
 parallel-checkout.c               | 24 +++++++++++++++++++-----
 parallel-checkout.h               |  9 +++++++--
 unpack-trees.c                    | 10 +++++++---
 4 files changed, 54 insertions(+), 10 deletions(-)

diff --git a/Documentation/config/checkout.txt b/Documentation/config/checkout.txt
index 2cddf7b4b4..bfbca90f0e 100644
--- a/Documentation/config/checkout.txt
+++ b/Documentation/config/checkout.txt
@@ -21,3 +21,24 @@ checkout.guess::
 	Provides the default value for the `--guess` or `--no-guess`
 	option in `git checkout` and `git switch`. See
 	linkgit:git-switch[1] and linkgit:git-checkout[1].
+
+checkout.workers::
+	The number of parallel workers to use when updating the working tree.
+	The default is one, i.e. sequential execution. If set to a value less
+	than one, Git will use as many workers as the number of logical cores
+	available. This setting and `checkout.thresholdForParallelism` affect
+	all commands that perform checkout. E.g. checkout, clone, reset,
+	sparse-checkout, etc.
++
+Note: parallel checkout usually delivers better performance for repositories
+located on SSDs or over NFS. For repositories on spinning disks and/or machines
+with a small number of cores, the default sequential checkout often performs
+better. The size and compression level of a repository might also influence how
+well the parallel version performs.
+
+checkout.thresholdForParallelism::
+	When running parallel checkout with a small number of files, the cost
+	of subprocess spawning and inter-process communication might outweigh
+	the parallelization gains. This setting allows to define the minimum
+	number of files for which parallel checkout should be attempted. The
+	default is 100.
diff --git a/parallel-checkout.c b/parallel-checkout.c
index 41c301bbda..d6a0f31664 100644
--- a/parallel-checkout.c
+++ b/parallel-checkout.c
@@ -1,10 +1,12 @@
 #include "cache.h"
+#include "config.h"
 #include "entry.h"
 #include "parallel-checkout.h"
 #include "pkt-line.h"
 #include "run-command.h"
 #include "sigchain.h"
 #include "streaming.h"
+#include "thread-utils.h"
 
 struct pc_worker {
 	struct child_process cp;
@@ -24,6 +26,20 @@ enum pc_status parallel_checkout_status(void)
 	return parallel_checkout.status;
 }
 
+static const int DEFAULT_THRESHOLD_FOR_PARALLELISM = 100;
+static const int DEFAULT_NUM_WORKERS = 1;
+
+void get_parallel_checkout_configs(int *num_workers, int *threshold)
+{
+	if (git_config_get_int("checkout.workers", num_workers))
+		*num_workers = DEFAULT_NUM_WORKERS;
+	else if (*num_workers < 1)
+		*num_workers = online_cpus();
+
+	if (git_config_get_int("checkout.thresholdForParallelism", threshold))
+		*threshold = DEFAULT_THRESHOLD_FOR_PARALLELISM;
+}
+
 void init_parallel_checkout(void)
 {
 	if (parallel_checkout.status != PC_UNINITIALIZED)
@@ -587,11 +603,9 @@ static void write_items_sequentially(struct checkout *state)
 		write_pc_item(&parallel_checkout.items[i], state);
 }
 
-static const int DEFAULT_NUM_WORKERS = 2;
-
-int run_parallel_checkout(struct checkout *state)
+int run_parallel_checkout(struct checkout *state, int num_workers, int threshold)
 {
-	int ret, num_workers = DEFAULT_NUM_WORKERS;
+	int ret;
 
 	if (parallel_checkout.status != PC_ACCEPTING_ENTRIES)
 		BUG("cannot run parallel checkout: uninitialized or already running");
@@ -601,7 +615,7 @@ int run_parallel_checkout(struct checkout *state)
 	if (parallel_checkout.nr < num_workers)
 		num_workers = parallel_checkout.nr;
 
-	if (num_workers <= 1) {
+	if (num_workers <= 1 || parallel_checkout.nr < threshold) {
 		write_items_sequentially(state);
 	} else {
 		struct pc_worker *workers = setup_workers(state, num_workers);
diff --git a/parallel-checkout.h b/parallel-checkout.h
index ec58716519..2a68ab954d 100644
--- a/parallel-checkout.h
+++ b/parallel-checkout.h
@@ -17,6 +17,7 @@ enum pc_status {
 };
 
 enum pc_status parallel_checkout_status(void);
+void get_parallel_checkout_configs(int *num_workers, int *threshold);
 
 /*
  * Put parallel checkout into the PC_ACCEPTING_ENTRIES state. Should be used
@@ -31,8 +32,12 @@ void init_parallel_checkout(void);
  */
 int enqueue_checkout(struct cache_entry *ce, struct conv_attrs *ca);
 
-/* Write all the queued entries, returning 0 on success.*/
-int run_parallel_checkout(struct checkout *state);
+/*
+ * Write all the queued entries, returning 0 on success. If the number of
+ * entries is smaller than the specified threshold, the operation is performed
+ * sequentially.
+ */
+int run_parallel_checkout(struct checkout *state, int num_workers, int threshold);
 
 /****************************************************************
  * Interface with checkout--worker
diff --git a/unpack-trees.c b/unpack-trees.c
index f0430d458d..0669748f21 100644
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
@@ -465,8 +465,11 @@ static int check_updates(struct unpack_trees_options *o,
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
 
@@ -480,7 +483,8 @@ static int check_updates(struct unpack_trees_options *o,
 		}
 	}
 	stop_progress(&progress);
-	errs |= run_parallel_checkout(&state);
+	if (pc_workers > 1)
+		errs |= run_parallel_checkout(&state, pc_workers, pc_threshold);
 	errs |= finish_delayed_checkout(&state, NULL);
 	git_attr_set_direction(GIT_ATTR_CHECKIN);
 
-- 
2.30.1

