Return-Path: <SRS0=U/aV=EE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10CE5C5517A
	for <git@archiver.kernel.org>; Thu, 29 Oct 2020 02:16:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D61420738
	for <git@archiver.kernel.org>; Thu, 29 Oct 2020 02:16:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="fwv5XlGR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391082AbgJ2CQs (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Oct 2020 22:16:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729868AbgJ2CQE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Oct 2020 22:16:04 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BE04C0613CF
        for <git@vger.kernel.org>; Wed, 28 Oct 2020 19:16:04 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id q199so859662qke.10
        for <git@vger.kernel.org>; Wed, 28 Oct 2020 19:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FWT42qj1Qj723mVCon98hA86fVqcoBR0TQZlh3RTs4g=;
        b=fwv5XlGR0lYFXNau19ukEUinylXFqI66+ekSfw/9k7Lt6Ry2L1D6uiO0GaRu+utbLf
         HRq5grP42+0GvgbSQy91MRa8/SILx2Gg05aPNh5Yb/JJ3DVcipNBUkkridcK5k6zs4ef
         U1ldfOx66or4dp51MmlMR/hixyqRs/ZsX/SN3bqhIFX/H+tQyJYoi57RpsDNAodZFaf2
         YKoN6CTQpDiLXEsXBCsY3Vhea+uCdbmbVdICE8buP4dIH4FmFISo2jHGOypm6MO/rcHx
         SbjRLPQR7P2FYXgsExfq8iqafTDsTcBLlodMwzSVEJuMl/7tK52tLtCHEPtdzQgW0GjW
         +HOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FWT42qj1Qj723mVCon98hA86fVqcoBR0TQZlh3RTs4g=;
        b=eMDWv1j5V5ckXgl4021rAeHOgDY5idK3E3L8LhkzTEECS1hWCfD7uKx4lFocO00b/c
         i0j5pIbBvMOwytPlKfx2q7qh3w63h/N4F2GTisxijmD9fdryMcH8AkMOEvVGFGUBvKU4
         fmfqNJha+QP6CyGGVjvrh6mYR3OEzax+wH706bgGppVNEMH6wtaYgQcGco/6tM5EFhLN
         rkie4Ya1a8MH3awkKSeHMD8BJbOMRUzMardHxBxpUSoXIxSMuYEyopmBXyRVGDzhuLJC
         piHjZvy72Qodbqd/vXMYq2mMasr9Eq5QvwoFdkPcOVyj8OLZc+aU1UgAy9K4jAzLJpXB
         A5HQ==
X-Gm-Message-State: AOAM531mqrw6FuIDp0isIKNtR4/fYhnmsv2WWWFq1F1aSABM0zFla4Um
        S7jDX4UqRozT+HfwTmRtnaS3Ll7phZL5yw==
X-Google-Smtp-Source: ABdhPJz3SkzrwTNaDy67/Fyp3klFGajkvl5Qo/z9P0JIqEkcX/LavwE9O6u8zLDfxj1C5K6YZdDk9Q==
X-Received: by 2002:a05:620a:214a:: with SMTP id m10mr1733346qkm.210.1603937762720;
        Wed, 28 Oct 2020 19:16:02 -0700 (PDT)
Received: from mango.meuintelbras.local ([177.32.118.149])
        by smtp.gmail.com with ESMTPSA id n201sm608371qka.32.2020.10.28.19.15.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2020 19:16:02 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, git@jeffhostetler.com, chriscool@tuxfamily.org,
        peff@peff.net, newren@gmail.com, jrnieder@gmail.com,
        martin.agren@gmail.com
Subject: [PATCH v3 11/19] parallel-checkout: make it truly parallel
Date:   Wed, 28 Oct 2020 23:14:48 -0300
Message-Id: <096e543fd208d18cae875d3ea1a0ecfacf10fa08.1603937110.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1603937110.git.matheus.bernardino@usp.br>
References: <cover.1603937110.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Use multiple worker processes to distribute the queued entries and call
write_checkout_item() in parallel for them. The items are distributed
uniformly in contiguous chunks. This minimizes the chances of two
workers writing to the same directory simultaneously, which could
affect performance due to lock contention in the kernel. Work stealing
(or any other format of re-distribution) is not implemented yet.

The parallel version was benchmarked during three operations in the
linux repo, with cold cache: cloning v5.8, checking out v5.8 from
v2.6.15 (checkout I) and checking out v5.8 from v5.7 (checkout II). The
four tables below show the mean run times and standard deviations for
5 runs in: a local file system with SSD, a local file system with HDD, a
Linux NFS server, and Amazon EFS. The numbers of workers were chosen
based on what produces the best result for each case.

Local SSD:

            Clone                  Checkout I             Checkout II
Sequential  8.171 s ± 0.206 s      8.735 s ± 0.230 s      4.166 s ± 0.246 s
10 workers  3.277 s ± 0.138 s      3.774 s ± 0.188 s      2.561 s ± 0.120 s
Speedup     2.49 ± 0.12            2.31 ± 0.13            1.63 ± 0.12

Local HDD:

            Clone                  Checkout I             Checkout II
Sequential  35.157 s ± 0.205 s     48.835 s ± 0.407 s     47.302 s ± 1.435 s
8 workers   35.538 s ± 0.325 s     49.353 s ± 0.826 s     48.919 s ± 0.416 s
Speedup     0.99 ± 0.01            0.99 ± 0.02            0.97 ± 0.03

Linux NFS server (v4.1, on EBS, single availability zone):

            Clone                  Checkout I             Checkout II
Sequential  216.070 s ± 3.611 s    211.169 s ± 3.147 s    57.446 s ± 1.301 s
32 workers  67.997 s ± 0.740 s     66.563 s ± 0.457 s     23.708 s ± 0.622 s
Speedup     3.18 ± 0.06            3.17 ± 0.05            2.42 ± 0.08

EFS (v4.1, replicated over multiple availability zones):

            Clone                  Checkout I             Checkout II
Sequential  1249.329 s ± 13.857 s  1438.979 s ± 78.792 s  543.919 s ± 18.745 s
64 workers  225.864 s ± 12.433 s   316.345 s ± 1.887 s    183.648 s ± 10.095 s
Speedup     5.53 ± 0.31            4.55 ± 0.25            2.96 ± 0.19

The above benchmarks show that parallel checkout is most effective on
repositories located on an SSD or over a distributed file system. For
local file systems on spinning disks, and/or older machines, the
parallelism does not always bring a good performance. In fact, it can
even increase the run time. For this reason, the sequential code is
still the default. Two settings are added to optionally enable and
configure the new parallel version as desired.

Local SSD tests were executed in an i7-7700HQ (4 cores with
hyper-threading) running Manjaro Linux. Local HDD tests were executed in
an i7-2600 (also 4 cores with hyper-threading), HDD Seagate Barracuda
7200 rpm SATA 3.0, running Debian 9.13. NFS and EFS tests were
executed in an Amazon EC2 c5n.large instance, with 2 vCPUs. The Linux
NFS server was running on a m6g.large instance with 1 TB, EBS GP2
volume. Before each timing, the linux repository was removed (or checked
out back), and `sync && sysctl vm.drop_caches=3` was executed.

Co-authored-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
Co-authored-by: Jeff Hostetler <jeffhost@microsoft.com>
Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
 .gitignore                        |   1 +
 Documentation/config/checkout.txt |  21 +++
 Makefile                          |   1 +
 builtin.h                         |   1 +
 builtin/checkout--helper.c        | 142 +++++++++++++++
 git.c                             |   2 +
 parallel-checkout.c               | 280 +++++++++++++++++++++++++++---
 parallel-checkout.h               |  84 ++++++++-
 unpack-trees.c                    |  10 +-
 9 files changed, 508 insertions(+), 34 deletions(-)
 create mode 100644 builtin/checkout--helper.c

diff --git a/.gitignore b/.gitignore
index 6232d33924..1a341ea184 100644
--- a/.gitignore
+++ b/.gitignore
@@ -33,6 +33,7 @@
 /git-check-mailmap
 /git-check-ref-format
 /git-checkout
+/git-checkout--helper
 /git-checkout-index
 /git-cherry
 /git-cherry-pick
diff --git a/Documentation/config/checkout.txt b/Documentation/config/checkout.txt
index 6b646813ab..23e8f7cde0 100644
--- a/Documentation/config/checkout.txt
+++ b/Documentation/config/checkout.txt
@@ -16,3 +16,24 @@ will checkout the '<something>' branch on another remote,
 and by linkgit:git-worktree[1] when 'git worktree add' refers to a
 remote branch. This setting might be used for other checkout-like
 commands or functionality in the future.
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
diff --git a/Makefile b/Makefile
index 10ee5e709b..535e6e94aa 100644
--- a/Makefile
+++ b/Makefile
@@ -1063,6 +1063,7 @@ BUILTIN_OBJS += builtin/check-attr.o
 BUILTIN_OBJS += builtin/check-ignore.o
 BUILTIN_OBJS += builtin/check-mailmap.o
 BUILTIN_OBJS += builtin/check-ref-format.o
+BUILTIN_OBJS += builtin/checkout--helper.o
 BUILTIN_OBJS += builtin/checkout-index.o
 BUILTIN_OBJS += builtin/checkout.o
 BUILTIN_OBJS += builtin/clean.o
diff --git a/builtin.h b/builtin.h
index 53fb290963..2abbe14b0b 100644
--- a/builtin.h
+++ b/builtin.h
@@ -123,6 +123,7 @@ int cmd_bugreport(int argc, const char **argv, const char *prefix);
 int cmd_bundle(int argc, const char **argv, const char *prefix);
 int cmd_cat_file(int argc, const char **argv, const char *prefix);
 int cmd_checkout(int argc, const char **argv, const char *prefix);
+int cmd_checkout__helper(int argc, const char **argv, const char *prefix);
 int cmd_checkout_index(int argc, const char **argv, const char *prefix);
 int cmd_check_attr(int argc, const char **argv, const char *prefix);
 int cmd_check_ignore(int argc, const char **argv, const char *prefix);
diff --git a/builtin/checkout--helper.c b/builtin/checkout--helper.c
new file mode 100644
index 0000000000..67fe37cf11
--- /dev/null
+++ b/builtin/checkout--helper.c
@@ -0,0 +1,142 @@
+#include "builtin.h"
+#include "config.h"
+#include "entry.h"
+#include "parallel-checkout.h"
+#include "parse-options.h"
+#include "pkt-line.h"
+
+static void packet_to_pc_item(char *line, int len,
+			      struct parallel_checkout_item *pc_item)
+{
+	struct pc_item_fixed_portion *fixed_portion;
+	char *encoding, *variant;
+
+	if (len < sizeof(struct pc_item_fixed_portion))
+		BUG("checkout worker received too short item (got %dB, exp %dB)",
+		    len, (int)sizeof(struct pc_item_fixed_portion));
+
+	fixed_portion = (struct pc_item_fixed_portion *)line;
+
+	if (len - sizeof(struct pc_item_fixed_portion) !=
+		fixed_portion->name_len + fixed_portion->working_tree_encoding_len)
+		BUG("checkout worker received corrupted item");
+
+	variant = line + sizeof(struct pc_item_fixed_portion);
+
+	/*
+	 * Note: the main process uses zero length to communicate that the
+	 * encoding is NULL. There is no use case in actually sending an empty
+	 * string since it's considered as NULL when ca.working_tree_encoding
+	 * is set at git_path_check_encoding().
+	 */
+	if (fixed_portion->working_tree_encoding_len) {
+		encoding = xmemdupz(variant,
+				    fixed_portion->working_tree_encoding_len);
+		variant += fixed_portion->working_tree_encoding_len;
+	} else {
+		encoding = NULL;
+	}
+
+	memset(pc_item, 0, sizeof(*pc_item));
+	pc_item->ce = make_empty_transient_cache_entry(fixed_portion->name_len);
+	pc_item->ce->ce_namelen = fixed_portion->name_len;
+	pc_item->ce->ce_mode = fixed_portion->ce_mode;
+	memcpy(pc_item->ce->name, variant, pc_item->ce->ce_namelen);
+	oidcpy(&pc_item->ce->oid, &fixed_portion->oid);
+
+	pc_item->id = fixed_portion->id;
+	pc_item->ca.crlf_action = fixed_portion->crlf_action;
+	pc_item->ca.ident = fixed_portion->ident;
+	pc_item->ca.working_tree_encoding = encoding;
+}
+
+static void report_result(struct parallel_checkout_item *pc_item)
+{
+	struct pc_item_result res = { 0 };
+	size_t size;
+
+	res.id = pc_item->id;
+	res.status = pc_item->status;
+
+	if (pc_item->status == PC_ITEM_WRITTEN) {
+		res.st = pc_item->st;
+		size = sizeof(res);
+	} else {
+		size = PC_ITEM_RESULT_BASE_SIZE;
+	}
+
+	packet_write(1, (const char *)&res, size);
+}
+
+/* Free the worker-side malloced data, but not pc_item itself. */
+static void release_pc_item_data(struct parallel_checkout_item *pc_item)
+{
+	free((char *)pc_item->ca.working_tree_encoding);
+	discard_cache_entry(pc_item->ce);
+}
+
+static void worker_loop(struct checkout *state)
+{
+	struct parallel_checkout_item *items = NULL;
+	size_t i, nr = 0, alloc = 0;
+
+	while (1) {
+		int len;
+		char *line = packet_read_line(0, &len);
+
+		if (!line)
+			break;
+
+		ALLOC_GROW(items, nr + 1, alloc);
+		packet_to_pc_item(line, len, &items[nr++]);
+	}
+
+	for (i = 0; i < nr; ++i) {
+		struct parallel_checkout_item *pc_item = &items[i];
+		write_pc_item(pc_item, state);
+		report_result(pc_item);
+		release_pc_item_data(pc_item);
+	}
+
+	packet_flush(1);
+
+	free(items);
+}
+
+static const char * const checkout_helper_usage[] = {
+	N_("git checkout--helper [<options>]"),
+	NULL
+};
+
+int cmd_checkout__helper(int argc, const char **argv, const char *prefix)
+{
+	struct checkout state = CHECKOUT_INIT;
+	struct option checkout_helper_options[] = {
+		OPT_STRING(0, "prefix", &state.base_dir, N_("string"),
+			N_("when creating files, prepend <string>")),
+		OPT_END()
+	};
+
+	if (argc == 2 && !strcmp(argv[1], "-h"))
+		usage_with_options(checkout_helper_usage,
+				   checkout_helper_options);
+
+	git_config(git_default_config, NULL);
+	argc = parse_options(argc, argv, prefix, checkout_helper_options,
+			     checkout_helper_usage, 0);
+	if (argc > 0)
+		usage_with_options(checkout_helper_usage, checkout_helper_options);
+
+	if (state.base_dir)
+		state.base_dir_len = strlen(state.base_dir);
+
+	/*
+	 * Setting this on worker won't actually update the index. We just need
+	 * to pretend so to induce the checkout machinery to stat() the written
+	 * entries.
+	 */
+	state.refresh_cache = 1;
+
+	worker_loop(&state);
+	return 0;
+}
diff --git a/git.c b/git.c
index 4bdcdad2cc..384f144593 100644
--- a/git.c
+++ b/git.c
@@ -487,6 +487,8 @@ static struct cmd_struct commands[] = {
 	{ "check-mailmap", cmd_check_mailmap, RUN_SETUP },
 	{ "check-ref-format", cmd_check_ref_format, NO_PARSEOPT  },
 	{ "checkout", cmd_checkout, RUN_SETUP | NEED_WORK_TREE },
+	{ "checkout--helper", cmd_checkout__helper,
+		RUN_SETUP | NEED_WORK_TREE | SUPPORT_SUPER_PREFIX },
 	{ "checkout-index", cmd_checkout_index,
 		RUN_SETUP | NEED_WORK_TREE},
 	{ "cherry", cmd_cherry, RUN_SETUP },
diff --git a/parallel-checkout.c b/parallel-checkout.c
index 981dbe6ff3..a5508e27c2 100644
--- a/parallel-checkout.c
+++ b/parallel-checkout.c
@@ -1,28 +1,15 @@
 #include "cache.h"
 #include "entry.h"
 #include "parallel-checkout.h"
+#include "pkt-line.h"
+#include "run-command.h"
 #include "streaming.h"
+#include "thread-utils.h"
+#include "config.h"
 
-enum pc_item_status {
-	PC_ITEM_PENDING = 0,
-	PC_ITEM_WRITTEN,
-	/*
-	 * The entry could not be written because there was another file
-	 * already present in its path or leading directories. Since
-	 * checkout_entry_ca() removes such files from the working tree before
-	 * enqueueing the entry for parallel checkout, it means that there was
-	 * a path collision among the entries being written.
-	 */
-	PC_ITEM_COLLIDED,
-	PC_ITEM_FAILED,
-};
-
-struct parallel_checkout_item {
-	/* pointer to a istate->cache[] entry. Not owned by us. */
-	struct cache_entry *ce;
-	struct conv_attrs ca;
-	struct stat st;
-	enum pc_item_status status;
+struct pc_worker {
+	struct child_process cp;
+	size_t next_to_complete, nr_to_complete;
 };
 
 struct parallel_checkout {
@@ -38,6 +25,19 @@ enum pc_status parallel_checkout_status(void)
 	return parallel_checkout.status;
 }
 
+#define DEFAULT_THRESHOLD_FOR_PARALLELISM 100
+
+void get_parallel_checkout_configs(int *num_workers, int *threshold)
+{
+	if (git_config_get_int("checkout.workers", num_workers))
+		*num_workers = 1;
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
@@ -115,10 +115,12 @@ int enqueue_checkout(struct cache_entry *ce, struct conv_attrs *ca)
 	ALLOC_GROW(parallel_checkout.items, parallel_checkout.nr + 1,
 		   parallel_checkout.alloc);
 
-	pc_item = &parallel_checkout.items[parallel_checkout.nr++];
+	pc_item = &parallel_checkout.items[parallel_checkout.nr];
 	pc_item->ce = ce;
 	memcpy(&pc_item->ca, ca, sizeof(pc_item->ca));
 	pc_item->status = PC_ITEM_PENDING;
+	pc_item->id = parallel_checkout.nr;
+	parallel_checkout.nr++;
 
 	return 0;
 }
@@ -231,7 +233,8 @@ static int write_pc_item_to_fd(struct parallel_checkout_item *pc_item, int fd,
 	/*
 	 * checkout metadata is used to give context for external process
 	 * filters. Files requiring such filters are not eligible for parallel
-	 * checkout, so pass NULL.
+	 * checkout, so pass NULL. Note: if that changes, the metadata must also
+	 * be passed from the main process to the workers.
 	 */
 	ret = convert_to_working_tree_ca(&pc_item->ca, pc_item->ce->name,
 					 new_blob, size, &buf, NULL);
@@ -272,8 +275,8 @@ static int check_leading_dirs(const char *path, int len, int prefix_len)
 	return has_dirs_only_path(path, slash - path, prefix_len);
 }
 
-static void write_pc_item(struct parallel_checkout_item *pc_item,
-			  struct checkout *state)
+void write_pc_item(struct parallel_checkout_item *pc_item,
+		   struct checkout *state)
 {
 	unsigned int mode = (pc_item->ce->ce_mode & 0100) ? 0777 : 0666;
 	int fd = -1, fstat_done = 0;
@@ -343,6 +346,221 @@ static void write_pc_item(struct parallel_checkout_item *pc_item,
 	strbuf_release(&path);
 }
 
+static void send_one_item(int fd, struct parallel_checkout_item *pc_item)
+{
+	size_t len_data;
+	char *data, *variant;
+	struct pc_item_fixed_portion *fixed_portion;
+	const char *working_tree_encoding = pc_item->ca.working_tree_encoding;
+	size_t name_len = pc_item->ce->ce_namelen;
+	size_t working_tree_encoding_len = working_tree_encoding ?
+					   strlen(working_tree_encoding) : 0;
+
+	len_data = sizeof(struct pc_item_fixed_portion) + name_len +
+		   working_tree_encoding_len;
+
+	data = xcalloc(1, len_data);
+
+	fixed_portion = (struct pc_item_fixed_portion *)data;
+	fixed_portion->id = pc_item->id;
+	fixed_portion->ce_mode = pc_item->ce->ce_mode;
+	fixed_portion->crlf_action = pc_item->ca.crlf_action;
+	fixed_portion->ident = pc_item->ca.ident;
+	fixed_portion->name_len = name_len;
+	fixed_portion->working_tree_encoding_len = working_tree_encoding_len;
+	/*
+	 * We use hashcpy() instead of oidcpy() because the hash[] positions
+	 * after `the_hash_algo->rawsz` might not be initialized. And Valgrind
+	 * would complain about passing uninitialized bytes to a syscall
+	 * (write(2)). There is no real harm in this case, but the warning could
+	 * hinder the detection of actual errors.
+	 */
+	hashcpy(fixed_portion->oid.hash, pc_item->ce->oid.hash);
+
+	variant = data + sizeof(*fixed_portion);
+	if (working_tree_encoding_len) {
+		memcpy(variant, working_tree_encoding, working_tree_encoding_len);
+		variant += working_tree_encoding_len;
+	}
+	memcpy(variant, pc_item->ce->name, name_len);
+
+	packet_write(fd, data, len_data);
+
+	free(data);
+}
+
+static void send_batch(int fd, size_t start, size_t nr)
+{
+	size_t i;
+	for (i = 0; i < nr; ++i)
+		send_one_item(fd, &parallel_checkout.items[start + i]);
+	packet_flush(fd);
+}
+
+static struct pc_worker *setup_workers(struct checkout *state, int num_workers)
+{
+	struct pc_worker *workers;
+	int i, workers_with_one_extra_item;
+	size_t base_batch_size, next_to_assign = 0;
+
+	ALLOC_ARRAY(workers, num_workers);
+
+	for (i = 0; i < num_workers; ++i) {
+		struct child_process *cp = &workers[i].cp;
+
+		child_process_init(cp);
+		cp->git_cmd = 1;
+		cp->in = -1;
+		cp->out = -1;
+		cp->clean_on_exit = 1;
+		strvec_push(&cp->args, "checkout--helper");
+		if (state->base_dir_len)
+			strvec_pushf(&cp->args, "--prefix=%s", state->base_dir);
+		if (start_command(cp))
+			die(_("failed to spawn checkout worker"));
+	}
+
+	base_batch_size = parallel_checkout.nr / num_workers;
+	workers_with_one_extra_item = parallel_checkout.nr % num_workers;
+
+	for (i = 0; i < num_workers; ++i) {
+		struct pc_worker *worker = &workers[i];
+		size_t batch_size = base_batch_size;
+
+		/* distribute the extra work evenly */
+		if (i < workers_with_one_extra_item)
+			batch_size++;
+
+		send_batch(worker->cp.in, next_to_assign, batch_size);
+		worker->next_to_complete = next_to_assign;
+		worker->nr_to_complete = batch_size;
+
+		next_to_assign += batch_size;
+	}
+
+	return workers;
+}
+
+static void finish_workers(struct pc_worker *workers, int num_workers)
+{
+	int i;
+
+	/*
+	 * Close pipes before calling finish_command() to let the workers
+	 * exit asynchronously and avoid spending extra time on wait().
+	 */
+	for (i = 0; i < num_workers; ++i) {
+		struct child_process *cp = &workers[i].cp;
+		if (cp->in >= 0)
+			close(cp->in);
+		if (cp->out >= 0)
+			close(cp->out);
+	}
+
+	for (i = 0; i < num_workers; ++i) {
+		if (finish_command(&workers[i].cp))
+			error(_("checkout worker %d finished with error"), i);
+	}
+
+	free(workers);
+}
+
+#define ASSERT_PC_ITEM_RESULT_SIZE(got, exp) \
+{ \
+	if (got != exp) \
+		BUG("corrupted result from checkout worker (got %dB, exp %dB)", \
+		    got, exp); \
+} while(0)
+
+static void parse_and_save_result(const char *line, int len,
+				  struct pc_worker *worker)
+{
+	struct pc_item_result *res;
+	struct parallel_checkout_item *pc_item;
+	struct stat *st = NULL;
+
+	if (len < PC_ITEM_RESULT_BASE_SIZE)
+		BUG("too short result from checkout worker (got %dB, exp %dB)",
+		    len, (int)PC_ITEM_RESULT_BASE_SIZE);
+
+	res = (struct pc_item_result *)line;
+
+	/*
+	 * Worker should send either the full result struct on success, or
+	 * just the base (i.e. no stat data), otherwise.
+	 */
+	if (res->status == PC_ITEM_WRITTEN) {
+		ASSERT_PC_ITEM_RESULT_SIZE(len, (int)sizeof(struct pc_item_result));
+		st = &res->st;
+	} else {
+		ASSERT_PC_ITEM_RESULT_SIZE(len, (int)PC_ITEM_RESULT_BASE_SIZE);
+	}
+
+	if (!worker->nr_to_complete || res->id != worker->next_to_complete)
+		BUG("checkout worker sent unexpected item id");
+
+	worker->next_to_complete++;
+	worker->nr_to_complete--;
+
+	pc_item = &parallel_checkout.items[res->id];
+	pc_item->status = res->status;
+	if (st)
+		pc_item->st = *st;
+}
+
+
+static void gather_results_from_workers(struct pc_worker *workers,
+					int num_workers)
+{
+	int i, active_workers = num_workers;
+	struct pollfd *pfds;
+
+	CALLOC_ARRAY(pfds, num_workers);
+	for (i = 0; i < num_workers; ++i) {
+		pfds[i].fd = workers[i].cp.out;
+		pfds[i].events = POLLIN;
+	}
+
+	while (active_workers) {
+		int nr = poll(pfds, num_workers, -1);
+
+		if (nr < 0) {
+			if (errno == EINTR)
+				continue;
+			die_errno("failed to poll checkout workers");
+		}
+
+		for (i = 0; i < num_workers && nr > 0; ++i) {
+			struct pc_worker *worker = &workers[i];
+			struct pollfd *pfd = &pfds[i];
+
+			if (!pfd->revents)
+				continue;
+
+			if (pfd->revents & POLLIN) {
+				int len;
+				const char *line = packet_read_line(pfd->fd, &len);
+
+				if (!line) {
+					pfd->fd = -1;
+					active_workers--;
+				} else {
+					parse_and_save_result(line, len, worker);
+				}
+			} else if (pfd->revents & POLLHUP) {
+				pfd->fd = -1;
+				active_workers--;
+			} else if (pfd->revents & (POLLNVAL | POLLERR)) {
+				die(_("error polling from checkout worker"));
+			}
+
+			nr--;
+		}
+	}
+
+	free(pfds);
+}
+
 static void write_items_sequentially(struct checkout *state)
 {
 	size_t i;
@@ -351,7 +569,7 @@ static void write_items_sequentially(struct checkout *state)
 		write_pc_item(&parallel_checkout.items[i], state);
 }
 
-int run_parallel_checkout(struct checkout *state)
+int run_parallel_checkout(struct checkout *state, int num_workers, int threshold)
 {
 	int ret;
 
@@ -360,7 +578,17 @@ int run_parallel_checkout(struct checkout *state)
 
 	parallel_checkout.status = PC_RUNNING;
 
-	write_items_sequentially(state);
+	if (parallel_checkout.nr < num_workers)
+		num_workers = parallel_checkout.nr;
+
+	if (num_workers <= 1 || parallel_checkout.nr < threshold) {
+		write_items_sequentially(state);
+	} else {
+		struct pc_worker *workers = setup_workers(state, num_workers);
+		gather_results_from_workers(workers, num_workers);
+		finish_workers(workers, num_workers);
+	}
+
 	ret = handle_results(state);
 
 	finish_parallel_checkout();
diff --git a/parallel-checkout.h b/parallel-checkout.h
index e6d6fc01ea..0c9984584e 100644
--- a/parallel-checkout.h
+++ b/parallel-checkout.h
@@ -1,9 +1,12 @@
 #ifndef PARALLEL_CHECKOUT_H
 #define PARALLEL_CHECKOUT_H
 
-struct cache_entry;
-struct checkout;
-struct conv_attrs;
+#include "entry.h"
+#include "convert.h"
+
+/****************************************************************
+ * Users of parallel checkout
+ ****************************************************************/
 
 enum pc_status {
 	PC_UNINITIALIZED = 0,
@@ -12,6 +15,7 @@ enum pc_status {
 };
 
 enum pc_status parallel_checkout_status(void);
+void get_parallel_checkout_configs(int *num_workers, int *threshold);
 void init_parallel_checkout(void);
 
 /*
@@ -21,7 +25,77 @@ void init_parallel_checkout(void);
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
+
+/****************************************************************
+ * Interface with checkout--helper
+ ****************************************************************/
+
+enum pc_item_status {
+	PC_ITEM_PENDING = 0,
+	PC_ITEM_WRITTEN,
+	/*
+	 * The entry could not be written because there was another file
+	 * already present in its path or leading directories. Since
+	 * checkout_entry_ca() removes such files from the working tree before
+	 * enqueueing the entry for parallel checkout, it means that there was
+	 * a path collision among the entries being written.
+	 */
+	PC_ITEM_COLLIDED,
+	PC_ITEM_FAILED,
+};
+
+struct parallel_checkout_item {
+	/*
+	 * In main process ce points to a istate->cache[] entry. Thus, it's not
+	 * owned by us. In workers they own the memory, which *must be* released.
+	 */
+	struct cache_entry *ce;
+	struct conv_attrs ca;
+	size_t id; /* position in parallel_checkout.items[] of main process */
+
+	/* Output fields, sent from workers. */
+	enum pc_item_status status;
+	struct stat st;
+};
+
+/*
+ * The fixed-size portion of `struct parallel_checkout_item` that is sent to the
+ * workers. Following this will be 2 strings: ca.working_tree_encoding and
+ * ce.name; These are NOT null terminated, since we have the size in the fixed
+ * portion.
+ *
+ * Note that not all fields of conv_attrs and cache_entry are passed, only the
+ * ones that will be required by the workers to smudge and write the entry.
+ */
+struct pc_item_fixed_portion {
+	size_t id;
+	struct object_id oid;
+	unsigned int ce_mode;
+	enum crlf_action crlf_action;
+	int ident;
+	size_t working_tree_encoding_len;
+	size_t name_len;
+};
+
+/*
+ * The fields of `struct parallel_checkout_item` that are returned by the
+ * workers. Note: `st` must be the last one, as it is omitted on error.
+ */
+struct pc_item_result {
+	size_t id;
+	enum pc_item_status status;
+	struct stat st;
+};
+
+#define PC_ITEM_RESULT_BASE_SIZE offsetof(struct pc_item_result, st)
+
+void write_pc_item(struct parallel_checkout_item *pc_item,
+		   struct checkout *state);
 
 #endif /* PARALLEL_CHECKOUT_H */
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
2.28.0

