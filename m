Return-Path: <SRS0=lBg5=3Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,LOTS_OF_MONEY,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A0C0C35247
	for <git@archiver.kernel.org>; Wed,  5 Feb 2020 22:56:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBD2520730
	for <git@archiver.kernel.org>; Wed,  5 Feb 2020 22:56:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i1Ukbqmh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727793AbgBEW4r (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Feb 2020 17:56:47 -0500
Received: from mail-wm1-f49.google.com ([209.85.128.49]:36396 "EHLO
        mail-wm1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727779AbgBEW4m (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Feb 2020 17:56:42 -0500
Received: by mail-wm1-f49.google.com with SMTP id p17so4814314wma.1
        for <git@vger.kernel.org>; Wed, 05 Feb 2020 14:56:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=xfkP7ScVGtvrng0rFRV+dM9vEmV9abRzuEnBH5GKtLA=;
        b=i1Ukbqmh8mfEDZpdfHQVq2q9i3XsSYoAFg0iIZFGIMxjKL4yYUjw6C0AQSgNT2lHpD
         ooZoCeBXRBbh8sVep1LLN1CZ5msSGgngn+k1ggOi+QHxyp68H1wgzgfs8mLZBfH8b+9t
         r91BpDFhSTkEyOdFmeDgobQ/DOqVemA27EydifRaCbg2x2qlxzQuBf+ujruJU7vP13fm
         tKe2faFsebLpzYmuE6Ru6AtzSxx4EHeOt93a8b55P7Qlx/1WOVrLJrkoX8TjZVSoVy4h
         nQOSvrmeznzNvcrLM+UZBrDk02IAp6W4vVteeOCAegP34KAxZP3RZDKA+Y6TqTy9JdXy
         IP7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=xfkP7ScVGtvrng0rFRV+dM9vEmV9abRzuEnBH5GKtLA=;
        b=gdNBqEus+c/+gDTQ6exv2AcZayCI1Gr7MI1TdztJ+wEKtm+1IBIfP/lRHj7Af/cpD/
         dAkqF7H2qPFk4h6zfiCc8wb7zS7zRELRwasep7JcLL4qX0vQZGlfMC/9HxQKtoBMVVDW
         NBPm9rRwILiO7Lophh5LRIHjTOFMDLarUlPXYUz+zQOKcQdEvH/4LYSLtKiAT3LgFECa
         Ccg9+CODYavXLaI4gIgvQbvlDWm7eRlah6H9/4mvacBHJnojw80RS31ubPLVrD0kIEww
         PYg53C3A/LGbquoGhA/UJF+nEYI3pJp2PJoy8VZ+FD1YAgC5KQH4z6BnP7CEGsEeUVL8
         I6IA==
X-Gm-Message-State: APjAAAXrUgBDjdILQv2oKqHTxwtMrL+Bpb/f3WUfHx7orPuI/3y6bIsq
        PYuVDn/rZj7rYuOtfNjeLvmUg69Z
X-Google-Smtp-Source: APXvYqzGvLV9RjgaPc4eYo4gfAP81TkalOLvw7CWK1iqeqjxdfJtmWHPRc/377KsNH+NRvx1IiEimA==
X-Received: by 2002:a1c:7419:: with SMTP id p25mr7741350wmc.129.1580943398997;
        Wed, 05 Feb 2020 14:56:38 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g2sm1619734wrw.76.2020.02.05.14.56.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2020 14:56:38 -0800 (PST)
Message-Id: <77f1c561e8205c0598b57bf572640d21d64757f8.1580943390.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.497.v2.git.1580943390.gitgitgadget@gmail.com>
References: <pull.497.git.1576879520.gitgitgadget@gmail.com>
        <pull.497.v2.git.1580943390.gitgitgadget@gmail.com>
From:   "Garima Singh via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 05 Feb 2020 22:56:29 +0000
Subject: [PATCH v2 10/11] revision.c: use Bloom filters to speed up path based
 revision walks
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, szeder.dev@gmail.com, jonathantanmy@google.com,
        jeffhost@microsoft.com, me@ttaylorr.com, peff@peff.net,
        garimasigit@gmail.com, jnareb@gmail.com,
        christian.couder@gmail.com, emilyshaffer@gmail.com,
        gitster@pobox.com, Garima Singh <garima.singh@microsoft.com>,
        Garima Singh <garima.singh@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Garima Singh <garima.singh@microsoft.com>

Revision walk will now use Bloom filters for commits to speed up revision
walks for a particular path (for computing history for that path), if they
are present in the commit-graph file.

We load the Bloom filters during the prepare_revision_walk step, but only
when dealing with a single pathspec. While comparing trees in
rev_compare_trees(), if the Bloom filter says that the file is not different
between the two trees, we don't need to compute the expensive diff. This is
where we get our performance gains. The other response of the Bloom filter
is `maybe`, in which case we fall back to the full diff calculation to
determine if the path was changed in the commit.

Performance Gains:
We tested the performance of `git log -- <path>` on the git repo, the linux
and some internal large repos, with a variety of paths of varying depths.

On the git and linux repos:
- we observed a 2x to 5x speed up.

On a large internal repo with files seated 6-10 levels deep in the tree:
- we observed 10x to 20x speed ups, with some paths going up to 28 times
  faster.

Helped-by: Derrick Stolee <dstolee@microsoft.com
Helped-by: SZEDER Gábor <szeder.dev@gmail.com>
Helped-by: Jonathan Tan <jonathantanmy@google.com>
Signed-off-by: Garima Singh <garima.singh@microsoft.com>
---
 revision.c                 | 124 +++++++++++++++++++++++++++++++-
 revision.h                 |  11 +++
 t/helper/test-read-graph.c |   4 ++
 t/t4216-log-bloom.sh       | 140 +++++++++++++++++++++++++++++++++++++
 4 files changed, 277 insertions(+), 2 deletions(-)
 create mode 100755 t/t4216-log-bloom.sh

diff --git a/revision.c b/revision.c
index 8136929e23..d1622afa17 100644
--- a/revision.c
+++ b/revision.c
@@ -29,6 +29,8 @@
 #include "prio-queue.h"
 #include "hashmap.h"
 #include "utf8.h"
+#include "bloom.h"
+#include "json-writer.h"
 
 volatile show_early_output_fn_t show_early_output;
 
@@ -624,11 +626,114 @@ static void file_change(struct diff_options *options,
 	options->flags.has_changes = 1;
 }
 
+static int bloom_filter_atexit_registered;
+static unsigned int count_bloom_filter_maybe;
+static unsigned int count_bloom_filter_definitely_not;
+static unsigned int count_bloom_filter_false_positive;
+static unsigned int count_bloom_filter_not_present;
+static unsigned int count_bloom_filter_length_zero;
+
+static void trace2_bloom_filter_statistics_atexit(void)
+{
+	struct json_writer jw = JSON_WRITER_INIT;
+
+	jw_object_begin(&jw, 0);
+	jw_object_intmax(&jw, "filter_not_present", count_bloom_filter_not_present);
+	jw_object_intmax(&jw, "zero_length_filter", count_bloom_filter_length_zero);
+	jw_object_intmax(&jw, "maybe", count_bloom_filter_maybe);
+	jw_object_intmax(&jw, "definitely_not", count_bloom_filter_definitely_not);
+	jw_end(&jw);
+
+	trace2_data_json("bloom", the_repository, "statistics", &jw);
+
+	jw_release(&jw);
+}
+
+static void prepare_to_use_bloom_filter(struct rev_info *revs)
+{
+	struct pathspec_item *pi;
+	char *path_alloc = NULL;
+	const char *path;
+	int last_index;
+	int len;
+
+	if (!revs->commits)
+	    return;
+
+	repo_parse_commit(revs->repo, revs->commits->item);
+
+	if (!revs->repo->objects->commit_graph)
+		return;
+
+	revs->bloom_filter_settings = revs->repo->objects->commit_graph->bloom_filter_settings;
+	if (!revs->bloom_filter_settings)
+		return;
+
+	pi = &revs->pruning.pathspec.items[0];
+	last_index = pi->len - 1;
+
+	if (pi->match[last_index] == '/') {
+	    path_alloc = xstrdup(pi->match);
+	    path_alloc[last_index] = '\0';
+	    path = path_alloc;
+	} else
+	    path = pi->match;
+
+	len = strlen(path);
+
+	revs->bloom_key = xmalloc(sizeof(struct bloom_key));
+	fill_bloom_key(path, len, revs->bloom_key, revs->bloom_filter_settings);
+
+	if (trace2_is_enabled() && !bloom_filter_atexit_registered) {
+		atexit(trace2_bloom_filter_statistics_atexit);
+		bloom_filter_atexit_registered = 1;
+	}
+
+	free(path_alloc);
+}
+
+static int check_maybe_different_in_bloom_filter(struct rev_info *revs,
+						 struct commit *commit)
+{
+	struct bloom_filter *filter;
+	int result;
+
+	if (!revs->repo->objects->commit_graph)
+		return -1;
+
+	if (commit->generation == GENERATION_NUMBER_INFINITY)
+		return -1;
+
+	filter = get_bloom_filter(revs->repo, commit, 0);
+
+	if (!filter) {
+		count_bloom_filter_not_present++;
+		return -1;
+	}
+
+	if (!filter->len) {
+		count_bloom_filter_length_zero++;
+		return -1;
+	}
+
+	result = bloom_filter_contains(filter,
+				       revs->bloom_key,
+				       revs->bloom_filter_settings);
+
+	if (result)
+		count_bloom_filter_maybe++;
+	else
+		count_bloom_filter_definitely_not++;
+
+	return result;
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
@@ -653,11 +758,23 @@ static int rev_compare_tree(struct rev_info *revs,
 			return REV_TREE_SAME;
 	}
 
+	if (revs->pruning.pathspec.nr == 1 && !revs->reflog_info && !nth_parent) {
+		bloom_ret = check_maybe_different_in_bloom_filter(revs, commit);
+
+		if (bloom_ret == 0)
+			return REV_TREE_SAME;
+	}
+
 	tree_difference = REV_TREE_SAME;
 	revs->pruning.flags.has_changes = 0;
 	if (diff_tree_oid(&t1->object.oid, &t2->object.oid, "",
 			   &revs->pruning) < 0)
 		return REV_TREE_DIFFERENT;
+
+	if (!nth_parent)
+		if (bloom_ret == 1 && tree_difference == REV_TREE_SAME)
+			count_bloom_filter_false_positive++;
+
 	return tree_difference;
 }
 
@@ -855,7 +972,7 @@ static void try_to_simplify_commit(struct rev_info *revs, struct commit *commit)
 			die("cannot simplify commit %s (because of %s)",
 			    oid_to_hex(&commit->object.oid),
 			    oid_to_hex(&p->object.oid));
-		switch (rev_compare_tree(revs, p, commit)) {
+		switch (rev_compare_tree(revs, p, commit, nth_parent)) {
 		case REV_TREE_SAME:
 			if (!revs->simplify_history || !relevant_commit(p)) {
 				/* Even if a merge with an uninteresting
@@ -3362,6 +3479,8 @@ int prepare_revision_walk(struct rev_info *revs)
 				       FOR_EACH_OBJECT_PROMISOR_ONLY);
 	}
 
+	if (revs->pruning.pathspec.nr == 1 && !revs->reflog_info)
+		prepare_to_use_bloom_filter(revs);
 	if (revs->no_walk != REVISION_WALK_NO_WALK_UNSORTED)
 		commit_list_sort_by_date(&revs->commits);
 	if (revs->no_walk)
@@ -3379,6 +3498,7 @@ int prepare_revision_walk(struct rev_info *revs)
 		simplify_merges(revs);
 	if (revs->children.name)
 		set_children(revs);
+
 	return 0;
 }
 
diff --git a/revision.h b/revision.h
index 475f048fb6..7c026fe41f 100644
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
@@ -291,6 +293,15 @@ struct rev_info {
 	struct revision_sources *sources;
 
 	struct topo_walk_info *topo_walk_info;
+
+	/* Commit graph bloom filter fields */
+	/* The bloom filter key for the pathspec */
+	struct bloom_key *bloom_key;
+	/*
+	 * The bloom filter settings used to generate the key.
+	 * This is loaded from the commit-graph being used.
+	 */
+	struct bloom_filter_settings *bloom_filter_settings;
 };
 
 int ref_excluded(struct string_list *, const char *path);
diff --git a/t/helper/test-read-graph.c b/t/helper/test-read-graph.c
index d2884efe0a..aff597c7a3 100644
--- a/t/helper/test-read-graph.c
+++ b/t/helper/test-read-graph.c
@@ -45,6 +45,10 @@ int cmd__read_graph(int argc, const char **argv)
 		printf(" commit_metadata");
 	if (graph->chunk_extra_edges)
 		printf(" extra_edges");
+	if (graph->chunk_bloom_indexes)
+		printf(" bloom_indexes");
+	if (graph->chunk_bloom_data)
+		printf(" bloom_data");
 	printf("\n");
 
 	UNLEAK(graph);
diff --git a/t/t4216-log-bloom.sh b/t/t4216-log-bloom.sh
new file mode 100755
index 0000000000..19eca1864b
--- /dev/null
+++ b/t/t4216-log-bloom.sh
@@ -0,0 +1,140 @@
+#!/bin/sh
+
+test_description='git log for a path with bloom filters'
+. ./test-lib.sh
+
+test_expect_success 'setup test - repo, commits, commit graph, log outputs' '
+	git init &&
+	mkdir A A/B A/B/C &&
+	test_commit c1 A/file1 &&
+	test_commit c2 A/B/file2 &&
+	test_commit c3 A/B/C/file3 &&
+	test_commit c4 A/file1 &&
+	test_commit c5 A/B/file2 &&
+	test_commit c6 A/B/C/file3 &&
+	test_commit c7 A/file1 &&
+	test_commit c8 A/B/file2 &&
+	test_commit c9 A/B/C/file3 &&
+	git checkout -b side HEAD~4 &&
+	test_commit side-1 file4 &&
+	git checkout master &&
+	git merge side &&
+	test_commit c10 file5 &&
+	mv file5 file5_renamed &&
+	git add file5_renamed &&
+	git commit -m "rename" &&
+	git commit-graph write --reachable --changed-paths
+'
+graph_read_expect() {
+	OPTIONAL=""
+	NUM_CHUNKS=5
+	cat >expect <<- EOF
+	header: 43475048 1 1 $NUM_CHUNKS 0
+	num_commits: $1
+	chunks: oid_fanout oid_lookup commit_metadata bloom_indexes bloom_data
+	EOF
+	test-tool read-graph >output &&
+	test_cmp expect output
+}
+
+test_expect_success 'commit-graph write wrote out the bloom chunks' '
+	graph_read_expect 13
+'
+
+setup() {
+	rm output
+	rm "$TRASH_DIRECTORY/trace.perf"
+	git -c core.commitGraph=false log --pretty="format:%s" $1 >log_wo_bloom
+	GIT_TRACE2_PERF="$TRASH_DIRECTORY/trace.perf" git -c core.commitGraph=true log --pretty="format:%s" $1 >log_w_bloom
+}
+
+test_bloom_filters_used() {
+	log_args=$1
+	bloom_trace_prefix="statistics:{\"filter_not_present\":0,\"zero_length_filter\":0,\"maybe\""
+	setup "$log_args"
+	grep -q "$bloom_trace_prefix" "$TRASH_DIRECTORY/trace.perf" && test_cmp log_wo_bloom log_w_bloom
+}
+
+test_bloom_filters_not_used() {
+	log_args=$1
+	setup "$log_args"
+	!(grep -q "statistics:{\"filter_not_present\":" "$TRASH_DIRECTORY/trace.perf") && test_cmp log_wo_bloom log_w_bloom
+}
+
+for path in A A/B A/B/C A/file1 A/B/file2 A/B/C/file3 file4 file5_renamed
+do
+	for option in "" \
+		      "--full-history" \
+		      "--full-history --simplify-merges" \
+		      "--simplify-merges" \
+		      "--simplify-by-decoration" \
+		      "--follow" \
+		      "--first-parent" \
+		      "--topo-order" \
+		      "--date-order" \
+		      "--author-date-order" \
+		      "--ancestry-path side..master"
+	do
+		test_expect_success "git log option: $option for path: $path" '
+			test_bloom_filters_used "$option -- $path"
+		'
+	done
+done
+
+test_expect_success 'git log -- folder works with and without the trailing slash' '
+	test_bloom_filters_used "-- A" &&
+	test_bloom_filters_used "-- A/"
+'
+
+test_expect_success 'git log for path that does not exist. ' '
+	test_bloom_filters_used "-- path_does_not_exist"
+'
+
+test_expect_success 'git log with --walk-reflogs does not use bloom filters' '
+	test_bloom_filters_not_used "--walk-reflogs -- A"
+'
+
+test_expect_success 'git log -- multiple path specs does not use bloom filters' '
+	test_bloom_filters_not_used "-- file4 A/file1"
+'
+
+test_expect_success 'git log with wildcard that resolves to a single path uses bloom filters' '
+	test_bloom_filters_used "-- *4" &&
+	test_bloom_filters_used "-- *renamed"
+'
+
+test_expect_success 'git log with wildcard that resolves to a multiple paths does not uses bloom filters' '
+	test_bloom_filters_not_used "-- *" &&
+	test_bloom_filters_not_used "-- file*"
+'
+
+test_expect_success 'setup - add commit-graph to the chain without bloom filters' '
+	test_commit c14 A/anotherFile2 &&
+	test_commit c15 A/B/anotherFile2 &&
+	test_commit c16 A/B/C/anotherFile2 &&
+	GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS=0 git commit-graph write --reachable --split &&
+	test_line_count = 2 .git/objects/info/commit-graphs/commit-graph-chain
+'
+
+test_expect_success 'git log does not use bloom filters if the latest graph does not have bloom filters.' '
+	test_bloom_filters_not_used "-- A/B"
+'
+
+test_expect_success 'setup - add commit-graph to the chain with bloom filters' '
+	test_commit c17 A/anotherFile3 &&
+	git commit-graph write --reachable --changed-paths --split &&
+	test_line_count = 3 .git/objects/info/commit-graphs/commit-graph-chain
+'
+
+test_bloom_filters_used_when_some_filters_are_missing() {
+	log_args=$1
+	bloom_trace_prefix="statistics:{\"filter_not_present\":3,\"zero_length_filter\":0,\"maybe\":6,\"definitely_not\":6"
+	setup "$log_args"
+	grep -q "$bloom_trace_prefix" "$TRASH_DIRECTORY/trace.perf" && test_cmp log_wo_bloom log_w_bloom
+}
+
+test_expect_success 'git log uses bloom filters if they exist in the latest but not all commit graphs in the chain.' '
+	test_bloom_filters_used_when_some_filters_are_missing "-- A/B"
+'
+
+test_done
-- 
gitgitgadget

