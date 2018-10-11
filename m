Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 272A91F97F
	for <e@80x24.org>; Thu, 11 Oct 2018 19:11:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729933AbeJLCkP (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Oct 2018 22:40:15 -0400
Received: from mail-io1-f74.google.com ([209.85.166.74]:50067 "EHLO
        mail-io1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729557AbeJLCkO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Oct 2018 22:40:14 -0400
Received: by mail-io1-f74.google.com with SMTP id k9-v6so8827473iob.16
        for <git@vger.kernel.org>; Thu, 11 Oct 2018 12:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=q3zHjk5w/DGctd5XkipjWR6G/gm2AAYHYF5Mq+ztQ6Q=;
        b=atQ26UwZW7jqAInRE/XyfFGab67SnjjAhOEmS/gev3oqF5ebkP5l3N/+Q6c7nRvW4H
         dQ6PSmxuXjfpRJ6nAUT897NuTACjME2lHjTqk5tLRxYlOtgEIS51YUeFWTUDXVmTtTlW
         FNOC+wMF6962SX8G56HspMfcSiXta/fGZDFd+4DA5nTWhnbJbVQJwGdBRBUrWoyF9B3K
         HvthGfkne2h7KKnLd+02acAVmfoxCqjDeyU6wJHY7+yCIIBFwTSdTB4jNANh51Uk8Y8m
         kXuZun16Lc0O9NScLdIUAZGRF3m3nMzSjXW7r652331uh29G090/XIbMOSKGB/iFLjon
         AHZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=q3zHjk5w/DGctd5XkipjWR6G/gm2AAYHYF5Mq+ztQ6Q=;
        b=uCSQbLqInT3JbAdxbG+ATJ6DFLbIri+OUQiQaEReouFRGZNnnmS1YlL3YG1MlBR452
         Ac3bP1146fodmHcrlqx0b6j6Y77fyWmUTC04eRs1oWi5s+K7hgBWd9xVwANllMjuoHbn
         8xC8aF74ECqBs2OaCpNBt44KsDYpVWqjp7FcYajeK27TNY4QTn6XBKJ5xVX4NTmk52Ag
         Q2nSyBRZbquMJS7SbGXX08Wlygekk/MGwyZYUMW9uIHPcbdqWvY/briknMt5FOcB8sdE
         nG+yGP7qVIe5liv6up+PIsbGiWcmC4kvALPh625+JlwIEfqFkZUiE+eSFVJn6zib6ytk
         DWEw==
X-Gm-Message-State: ABuFfohtVQswRZ66WESlGLSzDSBAUOs3l2IYlZ419WMQxjYu/srDdrFh
        RNTCmr0kRW3NrzKCTREGx8G9f76yh5INaoLUO7HOFH5QVrMacxjFHqeohkCZ3+lUV5nNmD5NjSC
        65An+07YqwsJnMvwTbEBuLbaD34BLoOiLzw/81wjNjuM9btTF2CsrwcxOT1WZGNOmJ2UXcZyhpO
        D9
X-Google-Smtp-Source: ACcGV639AN87NBXcsSmTAAaHj2ubbHSkdflg3MootO49mfXIwUQ/WoZ6K1gmc2H13KQIJyrtp+V1FPSYdvxc3iz34U1t
X-Received: by 2002:a24:fe01:: with SMTP id w1-v6mr5517525ith.0.1539285101165;
 Thu, 11 Oct 2018 12:11:41 -0700 (PDT)
Date:   Thu, 11 Oct 2018 12:11:31 -0700
In-Reply-To: <2f49b953-4e07-0eb6-05b8-90d2eb72994b@gmail.com>
Message-Id: <20181011191131.154425-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <2f49b953-4e07-0eb6-05b8-90d2eb72994b@gmail.com>
X-Mailer: git-send-email 2.19.0.271.gfe8321ec05.dirty
Subject: [PATCH] Per-commit and per-parent filters for 2 parents
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, stolee@gmail.com,
        peff@peff.net, avarab@gmail.com, szeder.dev@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
> One main benefit of storing on Bloom filter per commit is to avoid
> recomputing hashes at every commit. Currently, this patch only improves
> locality when checking membership at the cost of taking up more space.
> Drop the dependence on the parent oid and then we can save the time
> spent hashing during history queries.

I've removed the hashing of the parent OID here and tried having
per-parent and per-commit hashes for the first 2 parents of each commit
instead of only 1, thus doubling the filter size. The results are not
much of an improvement though:

bloom filter total queries: 66409 definitely not: 56424 maybe: 9985 false positives: 9099 fp ratio: 0.137015
0:01.17
---
 bloom-filter.c | 25 ++++++++++++-------------
 bloom-filter.h |  4 ++--
 commit-graph.c | 13 ++++++++-----
 revision.c     | 11 +++++------
 4 files changed, 27 insertions(+), 26 deletions(-)

diff --git a/bloom-filter.c b/bloom-filter.c
index 39b453908f..10c73c45ae 100644
--- a/bloom-filter.c
+++ b/bloom-filter.c
@@ -11,7 +11,7 @@ void bloom_filter_init(struct bloom_filter *bf, uint32_t commit_nr, uint32_t bit
 	bf->nr_entries = 0;
 	bf->commit_nr = commit_nr;
 	bf->bit_size = bit_size;
-	bf->bits = xcalloc(1, commit_nr * bit_size / CHAR_BIT);
+	bf->bits = xcalloc(1, 2 * commit_nr * bit_size / CHAR_BIT);
 }
 
 void bloom_filter_free(struct bloom_filter *bf)
@@ -22,24 +22,24 @@ void bloom_filter_free(struct bloom_filter *bf)
 }
 
 
-static void bloom_filter_set_bits(struct bloom_filter *bf, uint32_t graph_pos, const uint32_t *offsets,
+static void bloom_filter_set_bits(struct bloom_filter *bf, uint32_t graph_pos, int parent_index, const uint32_t *offsets,
 			   int nr_offsets, int nr_entries)
 {
 	int i;
 	for (i = 0; i < nr_offsets; i++) {
-		uint32_t byte_offset = (offsets[i] % bf->bit_size + graph_pos * bf->bit_size) / CHAR_BIT;
+		uint32_t byte_offset = (offsets[i] % bf->bit_size + (2 * graph_pos + parent_index) * bf->bit_size) / CHAR_BIT;
 		unsigned char mask = 1 << offsets[i] % CHAR_BIT;
 		bf->bits[byte_offset] |= mask;
 	}
 	bf->nr_entries += nr_entries;
 }
 
-static int bloom_filter_check_bits(struct bloom_filter *bf, uint32_t graph_pos, const uint32_t *offsets,
+static int bloom_filter_check_bits(struct bloom_filter *bf, uint32_t graph_pos, int parent_index, const uint32_t *offsets,
 			    int nr)
 {
 	int i;
 	for (i = 0; i < nr; i++) {
-		uint32_t byte_offset = (offsets[i] % bf->bit_size + graph_pos * bf->bit_size) / CHAR_BIT;
+		uint32_t byte_offset = (offsets[i] % bf->bit_size + (2 * graph_pos + parent_index) * bf->bit_size) / CHAR_BIT;
 		unsigned char mask = 1 << offsets[i] % CHAR_BIT;
 		if (!(bf->bits[byte_offset] & mask))
 			return 0;
@@ -48,19 +48,18 @@ static int bloom_filter_check_bits(struct bloom_filter *bf, uint32_t graph_pos,
 }
 
 
-void bloom_filter_add_hash(struct bloom_filter *bf, uint32_t graph_pos, const unsigned char *hash)
+void bloom_filter_add_hash(struct bloom_filter *bf, uint32_t graph_pos, int parent_index, const unsigned char *hash)
 {
 	uint32_t offsets[GIT_MAX_RAWSZ / sizeof(uint32_t)];
 	hashcpy((unsigned char*)offsets, hash);
-	bloom_filter_set_bits(bf, graph_pos, offsets,
-			     the_hash_algo->rawsz / sizeof(*offsets), 1);
+	bloom_filter_set_bits(bf, graph_pos, parent_index, offsets, the_hash_algo->rawsz / sizeof(*offsets), 1);
 }
 
-int bloom_filter_check_hash(struct bloom_filter *bf, uint32_t graph_pos, const unsigned char *hash)
+int bloom_filter_check_hash(struct bloom_filter *bf, uint32_t graph_pos, int parent_index, const unsigned char *hash)
 {
 	uint32_t offsets[GIT_MAX_RAWSZ / sizeof(uint32_t)];
 	hashcpy((unsigned char*)offsets, hash);
-	return bloom_filter_check_bits(bf, graph_pos, offsets,
+	return bloom_filter_check_bits(bf, graph_pos, parent_index, offsets,
 			the_hash_algo->rawsz / sizeof(*offsets));
 }
 
@@ -87,8 +86,8 @@ int bloom_filter_load(struct bloom_filter *bf)
 	read_in_full(fd, &bf->bit_size, sizeof(bf->bit_size));
 	if (bf->bit_size % CHAR_BIT)
 		BUG("invalid size for bloom filter");
-	bf->bits = xmalloc(bf->commit_nr * bf->bit_size / CHAR_BIT);
-	read_in_full(fd, bf->bits, bf->commit_nr * bf->bit_size / CHAR_BIT);
+	bf->bits = xmalloc(2 * bf->commit_nr * bf->bit_size / CHAR_BIT);
+	read_in_full(fd, bf->bits, 2 * bf->commit_nr * bf->bit_size / CHAR_BIT);
 
 	close(fd);
 
@@ -102,7 +101,7 @@ void bloom_filter_write(struct bloom_filter *bf)
 	write_in_full(fd, &bf->nr_entries, sizeof(bf->nr_entries));
 	write_in_full(fd, &bf->commit_nr, sizeof(bf->commit_nr));
 	write_in_full(fd, &bf->bit_size, sizeof(bf->bit_size));
-	write_in_full(fd, bf->bits, bf->commit_nr * bf->bit_size / CHAR_BIT);
+	write_in_full(fd, bf->bits, 2 * bf->commit_nr * bf->bit_size / CHAR_BIT);
 
 	close(fd);
 }
diff --git a/bloom-filter.h b/bloom-filter.h
index 607649b8db..20e0527451 100644
--- a/bloom-filter.h
+++ b/bloom-filter.h
@@ -18,13 +18,13 @@ void bloom_filter_free(struct bloom_filter *bf);
  * Turns the given (SHA1) hash into 5 unsigned ints, and sets the bits at
  * those positions (modulo the bitmap's size) in the Bloom filter.
  */
-void bloom_filter_add_hash(struct bloom_filter *bf, uint32_t graph_pos, const unsigned char *hash);
+void bloom_filter_add_hash(struct bloom_filter *bf, uint32_t graph_pos, int parent_index, const unsigned char *hash);
 /*
  * Turns the given (SHA1) hash into 5 unsigned ints, and checks the bits at
  * those positions (modulo the bitmap's size) in the Bloom filter.
  * Returns 1 if all those bits are set, 0 otherwise.
  */
-int bloom_filter_check_hash(struct bloom_filter *bf, uint32_t graph_pos, const unsigned char *hash);
+int bloom_filter_check_hash(struct bloom_filter *bf, uint32_t graph_pos, int parent_index, const unsigned char *hash);
 
 void hashxor(const unsigned char *hash1, const unsigned char *hash2,
 	     unsigned char *out);
diff --git a/commit-graph.c b/commit-graph.c
index d21d555611..ca869c10e1 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -716,6 +716,7 @@ static void add_changes_to_bloom_filter(struct bloom_filter *bf,
 					struct commit *parent,
 					struct commit *commit,
 					int index,
+					int parent_index,
 					struct diff_options *diffopt)
 {
 	int i;
@@ -738,7 +739,6 @@ static void add_changes_to_bloom_filter(struct bloom_filter *bf,
 		do {
 			git_hash_ctx ctx;
 			unsigned char name_hash[GIT_MAX_RAWSZ];
-			unsigned char hash[GIT_MAX_RAWSZ];
 
 			p = strchrnul(p + 1, '/');
 
@@ -754,8 +754,7 @@ static void add_changes_to_bloom_filter(struct bloom_filter *bf,
 			the_hash_algo->update_fn(&ctx, path, p - path);
 			the_hash_algo->final_fn(name_hash, &ctx);
 
-			hashxor(name_hash, parent->object.oid.hash, hash);
-			bloom_filter_add_hash(bf, index, hash);
+			bloom_filter_add_hash(bf, index, parent_index, name_hash);
 		} while (*p);
 
 		diff_free_filepair(diff_queued_diff.queue[i]);
@@ -784,9 +783,13 @@ static void fill_bloom_filter(struct bloom_filter *bf,
 		struct commit *commit = commits[i];
 		struct commit_list *parent = commit->parents;
 
-		if (parent)
-			add_changes_to_bloom_filter(bf, parent->item, commit, i,
+		if (parent) {
+			add_changes_to_bloom_filter(bf, parent->item, commit, i, 0,
 						    &revs.diffopt);
+			if (parent->next)
+				add_changes_to_bloom_filter(bf, parent->next->item, commit, i, 1,
+							    &revs.diffopt);
+		}
 
 		display_progress(progress, i);
 	}
diff --git a/revision.c b/revision.c
index 5a433a5878..5478d08344 100644
--- a/revision.c
+++ b/revision.c
@@ -488,6 +488,7 @@ static void print_bloom_filter_stats_atexit(void)
 
 static int check_maybe_different_in_bloom_filter(struct rev_info *revs,
 						 struct commit *parent,
+						 int parent_index,
 						 struct commit *commit)
 {
 	int i;
@@ -513,10 +514,8 @@ static int check_maybe_different_in_bloom_filter(struct rev_info *revs,
 
 	for (i = 0; i < revs->pruning.pathspec.nr; i++) {
 		struct pathspec_item *pi = &revs->pruning.pathspec.items[i];
-		unsigned char hash[GIT_MAX_RAWSZ];
 
-		hashxor(pi->name_hash, parent->object.oid.hash, hash);
-		if (bloom_filter_check_hash(&bf, commit->graph_pos, hash)) {
+		if (bloom_filter_check_hash(&bf, commit->graph_pos, parent_index, pi->name_hash)) {
 			/*
 			 * At least one of the interesting pathspecs differs,
 			 * so we can return early and let the diff machinery
@@ -568,8 +567,8 @@ static int rev_compare_tree(struct rev_info *revs,
 			return REV_TREE_SAME;
 	}
 
-	if (!nth_parent) {
-		bloom_ret = check_maybe_different_in_bloom_filter(revs, parent, commit);
+	if (nth_parent <= 1) {
+		bloom_ret = check_maybe_different_in_bloom_filter(revs, parent, nth_parent, commit);
 		if (bloom_ret == 0)
 			return REV_TREE_SAME;
 	}
@@ -579,7 +578,7 @@ static int rev_compare_tree(struct rev_info *revs,
 	if (diff_tree_oid(&t1->object.oid, &t2->object.oid, "",
 			   &revs->pruning) < 0)
 		return REV_TREE_DIFFERENT;
-	if (!nth_parent) {
+	if (nth_parent <= 1) {
 		if (bloom_ret == 1 && tree_difference == REV_TREE_SAME)
 			bloom_filter_count_false_positive++;
 	}
-- 
2.19.0.271.gfe8321ec05.dirty

