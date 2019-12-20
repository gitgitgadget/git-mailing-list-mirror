Return-Path: <SRS0=PG55=2K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,LOTS_OF_MONEY,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34CA1C43603
	for <git@archiver.kernel.org>; Fri, 20 Dec 2019 22:05:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E40422146E
	for <git@archiver.kernel.org>; Fri, 20 Dec 2019 22:05:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SjtC915o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727609AbfLTWFc (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Dec 2019 17:05:32 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:43707 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727567AbfLTWFb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Dec 2019 17:05:31 -0500
Received: by mail-ed1-f68.google.com with SMTP id dc19so9829341edb.10
        for <git@vger.kernel.org>; Fri, 20 Dec 2019 14:05:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=MNI8K+6ckk6lzOLvdRYflsgweImhuQh9MCR5egEQClE=;
        b=SjtC915oTCQRaS92tXSJ+DO8GxV8VWcqB0xEBv32Jh5QWO+aFJ0X5QD7Ge9uMMbBXq
         FJ46BDd8Q8GdfPISxAg/LrFsgrL5qZ19yZAAK5Km+OPx2LLUl31OZ87nX13RSHD2v8Gj
         914tiBRhrDGp7In7vvNRWmUS8+WDZf+nT+W47zQUCS8yDH8ziYM7r293G9d8fXKWMP0h
         o7ufIsVP2wSrj8QdCNHM9AwOgR8DV2XWADeG8+LjdZJj6Ae0bj9qXOTW5E239b0DwWc1
         Oq/st68FjWbIDQxPZivpvzktRiqKpH/dpeWLmOZmQmcfOCJSakaiuCYH5t0gGPNBtjaL
         VG4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=MNI8K+6ckk6lzOLvdRYflsgweImhuQh9MCR5egEQClE=;
        b=O6pnY6tgwqu3FSNAeanpV0e1idbc8uHD28G07Ol3cGvegBR1aKmHH5UN99xOC2s8zO
         MmN06ZLbYqMsfybwnDyLE0bcIG0DUuztD1KoaXGuz8guBI4GUGs5v6PFt1zbM7bmGew7
         zGGgPhbUQqVk56jp06O57u+h2CDkMT6fl3JklNN7AL4vHhdxN/pYjU8kqEWtnbd1t+NQ
         GxGAEE48b3sWS0S2U9ZdE0CeexkUYod+HkN0upLZrJj1vFhPpXm6SoA9VV29Uu4eekwy
         ttyiLRXVDRMnctSBrxC5hliW2iHlRTWJrxFIp/HtragoZFQ+Rw2wvs4tIuZqu8at9rAf
         2rHg==
X-Gm-Message-State: APjAAAXrWFVYo7zeLNp193ETM5Mxjb1S7+usB5wS+8/ugfzB/J48M7Eq
        fVR/scD9sv24d0KaCsIK7aiNT79j
X-Google-Smtp-Source: APXvYqzHfS+8l7Tr5x84EPCidqRrWZVALKimzGSV6dTl7WJLsI3hKyHVAaGPnGH+Rhzmbf/e/F4RqQ==
X-Received: by 2002:a17:906:8511:: with SMTP id i17mr18949269ejx.267.1576879529049;
        Fri, 20 Dec 2019 14:05:29 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y19sm1250173ejw.65.2019.12.20.14.05.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Dec 2019 14:05:28 -0800 (PST)
Message-Id: <72a2bbf6765a1e99a3a23372f801099a07fe11a5.1576879520.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.497.git.1576879520.gitgitgadget@gmail.com>
References: <pull.497.git.1576879520.gitgitgadget@gmail.com>
From:   "Garima Singh via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 20 Dec 2019 22:05:19 +0000
Subject: [PATCH 8/9] revision.c: use bloom filters to speed up path based
 revision walks
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, szeder.dev@gmail.com, jonathantanmy@google.com,
        jeffhost@microsoft.com, me@ttaylorr.com, peff@peff.net,
        Junio C Hamano <gitster@pobox.com>,
        Garima Singh <garima.singh@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Garima Singh <garima.singh@microsoft.com>

If bloom filters have been written to the commit-graph file, revision walk will
use them to speed up revision walks for a particular path.
Note: The current implementation does this in the case of single pathspec
case only.

We load the bloom filters during the prepare_revision_walk step when dealing
with a single pathspec. While comparing trees in rev_compare_trees(), if the
bloom filter says that the file is not different between the two trees, we
don't need to compute the expensive diff. This is where we get our performance
gains.

Performance Gains:
We tested the performance of `git log --path` on the git repo, the linux and
some internal large repos, with a variety of paths of varying depths.

On the git and linux repos:
we observed a 2x to 5x speed up.

On a large internal repo with files seated 6-10 levels deep in the tree:
we observed 10x to 20x speed ups, with some paths going up to 28 times faster.

RFC Notes:
I plan to collect the folloowing statistics around this usage of bloom filters
and trace them out using trace2.
- number of bloom filter queries,
- number of "No" responses (file hasn't changed)
- number of "Maybe" responses (file may have changed)
- number of "Commit not parsed" cases (commit had too many changes to have a
  bloom filter written out, currently our limit is 512 diffs)

Helped-by: Derrick Stolee <dstolee@microsoft.com
Helped-by: SZEDER Gábor <szeder.dev@gmail.com>
Helped-by: Jonathan Tan <jonathantanmy@google.com>
Signed-off-by: Garima Singh <garima.singh@microsoft.com>
---
 bloom.c              | 20 ++++++++++++
 bloom.h              |  4 +++
 revision.c           | 67 +++++++++++++++++++++++++++++++++++++--
 revision.h           |  5 +++
 t/t4216-log-bloom.sh | 74 ++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 168 insertions(+), 2 deletions(-)
 create mode 100755 t/t4216-log-bloom.sh

diff --git a/bloom.c b/bloom.c
index 86b1005802..0c7505d3d6 100644
--- a/bloom.c
+++ b/bloom.c
@@ -235,3 +235,23 @@ struct bloom_filter *get_bloom_filter(struct repository *r,
 
 	return filter;
 }
+
+int bloom_filter_contains(struct bloom_filter *filter,
+			  struct bloom_key *key,
+			  struct bloom_filter_settings *settings)
+{
+	int i;
+	uint64_t mod = filter->len * BITS_PER_BLOCK;
+
+	if (!mod)
+		return 1;
+
+	for (i = 0; i < settings->num_hashes; i++) {
+		uint64_t hash_mod = key->hashes[i] % mod;
+		uint64_t block_pos = hash_mod / BITS_PER_BLOCK;
+		if (!(filter->data[block_pos] & get_bitmask(hash_mod)))
+			return 0;
+	}
+
+	return 1;
+}
diff --git a/bloom.h b/bloom.h
index 101d689bbd..9bdacd0a8e 100644
--- a/bloom.h
+++ b/bloom.h
@@ -44,4 +44,8 @@ void fill_bloom_key(const char *data,
 		    struct bloom_key *key,
 		    struct bloom_filter_settings *settings);
 
+int bloom_filter_contains(struct bloom_filter *filter,
+			  struct bloom_key *key,
+			  struct bloom_filter_settings *settings);
+
 #endif
diff --git a/revision.c b/revision.c
index 39a25e7a5d..01f5330740 100644
--- a/revision.c
+++ b/revision.c
@@ -29,6 +29,7 @@
 #include "prio-queue.h"
 #include "hashmap.h"
 #include "utf8.h"
+#include "bloom.h"
 
 volatile show_early_output_fn_t show_early_output;
 
@@ -624,11 +625,34 @@ static void file_change(struct diff_options *options,
 	options->flags.has_changes = 1;
 }
 
+static int check_maybe_different_in_bloom_filter(struct rev_info *revs,
+						 struct commit *commit,
+						 struct bloom_key *key,
+						 struct bloom_filter_settings *settings)
+{
+	struct bloom_filter *filter;
+
+	if (!revs->repo->objects->commit_graph)
+		return -1;
+	if (commit->generation == GENERATION_NUMBER_INFINITY)
+		return -1;
+	if (!key || !settings)
+		return -1;
+
+	filter = get_bloom_filter(revs->repo, commit, 0);
+
+	if (!filter || !filter->len)
+		return 1;
+
+	return bloom_filter_contains(filter, key, settings);
+}
+
 static int rev_compare_tree(struct rev_info *revs,
-			    struct commit *parent, struct commit *commit)
+			    struct commit *parent, struct commit *commit, int nth_parent)
 {
 	struct tree *t1 = get_commit_tree(parent);
 	struct tree *t2 = get_commit_tree(commit);
+	int bloom_ret = 1;
 
 	if (!t1)
 		return REV_TREE_NEW;
@@ -653,6 +677,16 @@ static int rev_compare_tree(struct rev_info *revs,
 			return REV_TREE_SAME;
 	}
 
+	if (revs->pruning.pathspec.nr == 1 && !nth_parent) {
+		bloom_ret = check_maybe_different_in_bloom_filter(revs,
+								  commit,
+								  revs->bloom_key,
+								  revs->bloom_filter_settings);
+
+		if (bloom_ret == 0)
+			return REV_TREE_SAME;
+	}
+
 	tree_difference = REV_TREE_SAME;
 	revs->pruning.flags.has_changes = 0;
 	if (diff_tree_oid(&t1->object.oid, &t2->object.oid, "",
@@ -855,7 +889,7 @@ static void try_to_simplify_commit(struct rev_info *revs, struct commit *commit)
 			die("cannot simplify commit %s (because of %s)",
 			    oid_to_hex(&commit->object.oid),
 			    oid_to_hex(&p->object.oid));
-		switch (rev_compare_tree(revs, p, commit)) {
+		switch (rev_compare_tree(revs, p, commit, nth_parent)) {
 		case REV_TREE_SAME:
 			if (!revs->simplify_history || !relevant_commit(p)) {
 				/* Even if a merge with an uninteresting
@@ -3342,6 +3376,33 @@ static void expand_topo_walk(struct rev_info *revs, struct commit *commit)
 	}
 }
 
+static void prepare_to_use_bloom_filter(struct rev_info *revs)
+{
+	struct pathspec_item *pi;
+	const char *path;
+	size_t len;
+
+	if (!revs->commits)
+	    return;
+
+	parse_commit(revs->commits->item);
+
+	if (!revs->repo->objects->commit_graph)
+		return;
+
+	revs->bloom_filter_settings = revs->repo->objects->commit_graph->settings;
+	if (!revs->bloom_filter_settings)
+		return;
+
+	pi = &revs->pruning.pathspec.items[0];
+	path = pi->match;
+	len = strlen(path);
+
+	load_bloom_filters();
+	revs->bloom_key = xmalloc(sizeof(struct bloom_key));
+	fill_bloom_key(path, len, revs->bloom_key, revs->bloom_filter_settings);
+}
+
 int prepare_revision_walk(struct rev_info *revs)
 {
 	int i;
@@ -3391,6 +3452,8 @@ int prepare_revision_walk(struct rev_info *revs)
 		simplify_merges(revs);
 	if (revs->children.name)
 		set_children(revs);
+	if (revs->pruning.pathspec.nr == 1)
+	    prepare_to_use_bloom_filter(revs);
 	return 0;
 }
 
diff --git a/revision.h b/revision.h
index a1a804bd3d..65dc11e8f1 100644
--- a/revision.h
+++ b/revision.h
@@ -56,6 +56,8 @@ struct repository;
 struct rev_info;
 struct string_list;
 struct saved_parents;
+struct bloom_key;
+struct bloom_filter_settings;
 define_shared_commit_slab(revision_sources, char *);
 
 struct rev_cmdline_info {
@@ -291,6 +293,9 @@ struct rev_info {
 	struct revision_sources *sources;
 
 	struct topo_walk_info *topo_walk_info;
+
+	struct bloom_key *bloom_key;
+	struct bloom_filter_settings *bloom_filter_settings;
 };
 
 int ref_excluded(struct string_list *, const char *path);
diff --git a/t/t4216-log-bloom.sh b/t/t4216-log-bloom.sh
new file mode 100755
index 0000000000..d42f077998
--- /dev/null
+++ b/t/t4216-log-bloom.sh
@@ -0,0 +1,74 @@
+#!/bin/sh
+
+test_description='git log for a path with bloom filters'
+. ./test-lib.sh
+
+test_expect_success 'setup repo' '
+	git init &&
+	git config core.commitGraph true &&
+	git config gc.writeCommitGraph false &&
+	infodir=".git/objects/info" &&
+	graphdir="$infodir/commit-graphs" &&
+	test_oid_init
+'
+
+test_expect_success 'create 9 commits and repack' '
+	test_commit c1 file1 &&
+	test_commit c2 file2 &&
+	test_commit c3 file3 &&
+	test_commit c4 file1 &&
+	test_commit c5 file2 &&
+	test_commit c6 file3 &&
+	test_commit c7 file1 &&
+	test_commit c8 file2 &&
+	test_commit c9 file3
+'
+
+printf "c7\nc4\nc1" > expect_file1
+
+test_expect_success 'log without bloom filters' '
+	git log --pretty="format:%s"  -- file1 > actual &&
+	test_cmp expect_file1 actual
+'
+
+printf "c8\nc7\nc5\nc4\nc2\nc1" > expect_file1_file2
+
+test_expect_success 'multi-path log without bloom filters' '
+	git log --pretty="format:%s"  -- file1 file2 > actual &&
+	test_cmp expect_file1_file2 actual
+'
+
+graph_read_expect() {
+	OPTIONAL=""
+	NUM_CHUNKS=5
+	if test ! -z $2
+	then
+		OPTIONAL=" $2"
+		NUM_CHUNKS=$((3 + $(echo "$2" | wc -w)))
+	fi
+	cat >expect <<- EOF
+	header: 43475048 1 1 $NUM_CHUNKS 0
+	num_commits: $1
+	chunks: oid_fanout oid_lookup commit_metadata bloom_indexes bloom_data$OPTIONAL
+	EOF
+	test-tool read-graph >output &&
+	test_cmp expect output
+}
+
+test_expect_success 'write commit graph with bloom filters' '
+	git commit-graph write --reachable --changed-paths &&
+	test_path_is_file $infodir/commit-graph &&
+	graph_read_expect "9"
+'
+
+test_expect_success 'log using bloom filters' '
+	git log --pretty="format:%s" -- file1 > actual &&
+	test_cmp expect_file1 actual
+'
+
+test_expect_success 'multi-path log using bloom filters' '
+	git log --pretty="format:%s"  -- file1 file2 > actual &&
+	test_cmp expect_file1_file2 actual
+'
+
+test_done
-- 
gitgitgadget

