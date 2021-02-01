Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD450C433E0
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 07:00:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 854D764E31
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 07:00:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231530AbhBAHAl (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Feb 2021 02:00:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230273AbhBAHAQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Feb 2021 02:00:16 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29D0FC06178C
        for <git@vger.kernel.org>; Sun, 31 Jan 2021 22:59:01 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id l12so15340471wry.2
        for <git@vger.kernel.org>; Sun, 31 Jan 2021 22:59:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=UYJgOKWJ/XWhk8Iv45XU12uhxalFQCYx0vedEBag57A=;
        b=dsQC4ypQV9wgBhGcLh8evjUTWCEaPBg5FzFCvDSV+UJILtpiiKqzcNHCPfG+vXWlLy
         r1shfW89T981muqFNO+mQr/PJrmuV5qKbxcP4zzDX13ltSWBYL9zMZF0IC9TXthsGRZH
         HdWPwXVnEzafS3fKXj4KhIu9B6Hfpa59WA9V3hN1Mw4/Cs0XKHCCpscyn8TGaVDGFOYv
         aI4z4tho6uALEk7GjLhPyoq5tC05X5t/iFcxZVdaNiSFSu2IPQmwbBrZNQ/CFos2Tpr8
         vdtl81D9C3iRvuILcuk3D7vgBztmfjaUvk6BjgNcRcYWDMyCadA2gBhKV9LZSeloR0gm
         Y3aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=UYJgOKWJ/XWhk8Iv45XU12uhxalFQCYx0vedEBag57A=;
        b=d7SfOsLepUkRxD9LvaP/JmqSIS8DZgFndRUBsIg82cRMjQB3k1pgeULKcxAT6okfbA
         SAHZShL4quep3VReLCYdwZojnmAuGEhhKlwWPxqEpahcMFFQz4F0atKeC0FxJD9uPpyx
         xyjRloIPFS7x8eu2egaTW28JRlFago3eSc88uZZbKXnnAOVjknApJQJPjBaNcUaJJZ5t
         GTwwkD0XZD5n80kTvm1VLVAsCZpyPXLxLcf4Ma15OAGCKkdT43jMcQfQ2VumeUfrICKL
         ZDZgxTInfUTbCN4FN7tay907cPM5YH3j6RzfFU7jOEV/bAUGUkaLVPtzjCdkwvdOq//Q
         S2DQ==
X-Gm-Message-State: AOAM531DeqI2Uc27fCK3ABVcnEpwfc/XdUsYEWUjRREuXbJuB7FD7ISd
        yWslSoaLv3JzgYYq3lyaprtmH1zsZeg=
X-Google-Smtp-Source: ABdhPJzRdyKgrnS8zsBCbdXdGBw5htyZ3uaMBvVZSIx1dsawGc7oL89/DA0WV3YcGumJq63akuH66Q==
X-Received: by 2002:a5d:470f:: with SMTP id y15mr16247362wrq.187.1612162739583;
        Sun, 31 Jan 2021 22:58:59 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v25sm20517098wmh.4.2021.01.31.22.58.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Jan 2021 22:58:58 -0800 (PST)
Message-Id: <07a88f1aae6f7f7812ab7a5937eac73131c2139e.1612162726.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.676.v7.git.1612162726.gitgitgadget@gmail.com>
References: <pull.676.v6.git.1610820679.gitgitgadget@gmail.com>
        <pull.676.v7.git.1612162726.gitgitgadget@gmail.com>
From:   "Abhishek Kumar via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 01 Feb 2021 06:58:44 +0000
Subject: [PATCH v7 10/11] commit-graph: use generation v2 only if entire chain
 does
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <stolee@gmail.com>,
        Jakub =?UTF-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>,
        Abhishek Kumar <abhishekkumar8222@gmail.com>,
        SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Abhishek Kumar <abhishekkumar8222@gmail.com>,
        Abhishek Kumar <abhishekkumar8222@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Abhishek Kumar <abhishekkumar8222@gmail.com>

Since there are released versions of Git that understand generation
numbers in the commit-graph's CDAT chunk but do not understand the GDAT
chunk, the following scenario is possible:

1. "New" Git writes a commit-graph with the GDAT chunk.
2. "Old" Git writes a split commit-graph on top without a GDAT chunk.

If each layer of split commit-graph is treated independently, as it was
the case before this commit, with Git inspecting only the current layer
for chunk_generation_data pointer, commits in the lower layer (one with
GDAT) whould have corrected commit date as their generation number,
while commits in the upper layer would have topological levels as their
generation. Corrected commit dates usually have much larger values than
topological levels. This means that if we take two commits, one from the
upper layer, and one reachable from it in the lower layer, then the
expectation that the generation of a parent is smaller than the
generation of a child would be violated.

It is difficult to expose this issue in a test. Since we _start_ with
artificially low generation numbers, any commit walk that prioritizes
generation numbers will walk all of the commits with high generation
number before walking the commits with low generation number. In all the
cases I tried, the commit-graph layers themselves "protect" any
incorrect behavior since none of the commits in the lower layer can
reach the commits in the upper layer.

This issue would manifest itself as a performance problem in this case,
especially with something like "git log --graph" since the low
generation numbers would cause the in-degree queue to walk all of the
commits in the lower layer before allowing the topo-order queue to write
anything to output (depending on the size of the upper layer).

Therefore, When writing the new layer in split commit-graph, we write a
GDAT chunk only if the topmost layer has a GDAT chunk. This guarantees
that if a layer has GDAT chunk, all lower layers must have a GDAT chunk
as well.

Rewriting layers follows similar approach: if the topmost layer below
the set of layers being rewritten (in the split commit-graph chain)
exists, and it does not contain GDAT chunk, then the result of rewrite
does not have GDAT chunks either.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
Signed-off-by: Abhishek Kumar <abhishekkumar8222@gmail.com>
---
 commit-graph.c                |  30 +++++-
 commit-graph.h                |   1 +
 t/t5324-split-commit-graph.sh | 181 ++++++++++++++++++++++++++++++++++
 3 files changed, 210 insertions(+), 2 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index d2afcc83283..77fef5a240e 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -614,6 +614,21 @@ static struct commit_graph *load_commit_graph_chain(struct repository *r,
 	return graph_chain;
 }
 
+static void validate_mixed_generation_chain(struct commit_graph *g)
+{
+	int read_generation_data;
+
+	if (!g)
+		return;
+
+	read_generation_data = !!g->chunk_generation_data;
+
+	while (g) {
+		g->read_generation_data = read_generation_data;
+		g = g->base_graph;
+	}
+}
+
 struct commit_graph *read_commit_graph_one(struct repository *r,
 					   struct object_directory *odb)
 {
@@ -622,6 +637,8 @@ struct commit_graph *read_commit_graph_one(struct repository *r,
 	if (!g)
 		g = load_commit_graph_chain(r, odb);
 
+	validate_mixed_generation_chain(g);
+
 	return g;
 }
 
@@ -791,7 +808,7 @@ static void fill_commit_graph_info(struct commit *item, struct commit_graph *g,
 	date_low = get_be32(commit_data + g->hash_len + 12);
 	item->date = (timestamp_t)((date_high << 32) | date_low);
 
-	if (g->chunk_generation_data) {
+	if (g->read_generation_data) {
 		offset = (timestamp_t)get_be32(g->chunk_generation_data + sizeof(uint32_t) * lex_index);
 
 		if (offset & CORRECTED_COMMIT_DATE_OFFSET_OVERFLOW) {
@@ -2019,6 +2036,13 @@ static void split_graph_merge_strategy(struct write_commit_graph_context *ctx)
 		if (i < ctx->num_commit_graphs_after)
 			ctx->commit_graph_hash_after[i] = xstrdup(oid_to_hex(&g->oid));
 
+		/*
+		 * If the topmost remaining layer has generation data chunk, the
+		 * resultant layer also has generation data chunk.
+		 */
+		if (i == ctx->num_commit_graphs_after - 2)
+			ctx->write_generation_data = !!g->chunk_generation_data;
+
 		i--;
 		g = g->base_graph;
 	}
@@ -2343,6 +2367,8 @@ int write_commit_graph(struct object_directory *odb,
 	} else
 		ctx->num_commit_graphs_after = 1;
 
+	validate_mixed_generation_chain(ctx->r->objects->commit_graph);
+
 	compute_generation_numbers(ctx);
 
 	if (ctx->changed_paths)
@@ -2541,7 +2567,7 @@ int verify_commit_graph(struct repository *r, struct commit_graph *g, int flags)
 		 * also GENERATION_NUMBER_V1_MAX. Decrement to avoid extra logic
 		 * in the following condition.
 		 */
-		if (!g->chunk_generation_data && max_generation == GENERATION_NUMBER_V1_MAX)
+		if (!g->read_generation_data && max_generation == GENERATION_NUMBER_V1_MAX)
 			max_generation--;
 
 		generation = commit_graph_generation(graph_commit);
diff --git a/commit-graph.h b/commit-graph.h
index 19a02001fde..ad52130883b 100644
--- a/commit-graph.h
+++ b/commit-graph.h
@@ -64,6 +64,7 @@ struct commit_graph {
 	struct object_directory *odb;
 
 	uint32_t num_commits_in_base;
+	unsigned int read_generation_data;
 	struct commit_graph *base_graph;
 
 	const uint32_t *chunk_oid_fanout;
diff --git a/t/t5324-split-commit-graph.sh b/t/t5324-split-commit-graph.sh
index 587757b62d9..8e90f3423b8 100755
--- a/t/t5324-split-commit-graph.sh
+++ b/t/t5324-split-commit-graph.sh
@@ -453,4 +453,185 @@ test_expect_success 'prevent regression for duplicate commits across layers' '
 	git -C dup commit-graph verify
 '
 
+NUM_FIRST_LAYER_COMMITS=64
+NUM_SECOND_LAYER_COMMITS=16
+NUM_THIRD_LAYER_COMMITS=7
+NUM_FOURTH_LAYER_COMMITS=8
+NUM_FIFTH_LAYER_COMMITS=16
+SECOND_LAYER_SEQUENCE_START=$(($NUM_FIRST_LAYER_COMMITS + 1))
+SECOND_LAYER_SEQUENCE_END=$(($SECOND_LAYER_SEQUENCE_START + $NUM_SECOND_LAYER_COMMITS - 1))
+THIRD_LAYER_SEQUENCE_START=$(($SECOND_LAYER_SEQUENCE_END + 1))
+THIRD_LAYER_SEQUENCE_END=$(($THIRD_LAYER_SEQUENCE_START + $NUM_THIRD_LAYER_COMMITS - 1))
+FOURTH_LAYER_SEQUENCE_START=$(($THIRD_LAYER_SEQUENCE_END + 1))
+FOURTH_LAYER_SEQUENCE_END=$(($FOURTH_LAYER_SEQUENCE_START + $NUM_FOURTH_LAYER_COMMITS - 1))
+FIFTH_LAYER_SEQUENCE_START=$(($FOURTH_LAYER_SEQUENCE_END + 1))
+FIFTH_LAYER_SEQUENCE_END=$(($FIFTH_LAYER_SEQUENCE_START + $NUM_FIFTH_LAYER_COMMITS - 1))
+
+# Current split graph chain:
+#
+#     16 commits (No GDAT)
+# ------------------------
+#     64 commits (GDAT)
+#
+test_expect_success 'setup repo for mixed generation commit-graph-chain' '
+	graphdir=".git/objects/info/commit-graphs" &&
+	test_oid_cache <<-EOF &&
+	oid_version sha1:1
+	oid_version sha256:2
+	EOF
+	git init mixed &&
+	(
+		cd mixed &&
+		git config core.commitGraph true &&
+		git config gc.writeCommitGraph false &&
+		for i in $(test_seq $NUM_FIRST_LAYER_COMMITS)
+		do
+			test_commit $i &&
+			git branch commits/$i || return 1
+		done &&
+		git commit-graph write --reachable --split &&
+		graph_read_expect $NUM_FIRST_LAYER_COMMITS &&
+		test_line_count = 1 $graphdir/commit-graph-chain &&
+		for i in $(test_seq $SECOND_LAYER_SEQUENCE_START $SECOND_LAYER_SEQUENCE_END)
+		do
+			test_commit $i &&
+			git branch commits/$i || return 1
+		done &&
+		GIT_TEST_COMMIT_GRAPH_NO_GDAT=1 git commit-graph write --reachable --split=no-merge &&
+		test_line_count = 2 $graphdir/commit-graph-chain &&
+		test-tool read-graph >output &&
+		cat >expect <<-EOF &&
+		header: 43475048 1 $(test_oid oid_version) 4 1
+		num_commits: $NUM_SECOND_LAYER_COMMITS
+		chunks: oid_fanout oid_lookup commit_metadata
+		EOF
+		test_cmp expect output &&
+		git commit-graph verify &&
+		cat $graphdir/commit-graph-chain
+	)
+'
+
+# The new layer will be added without generation data chunk as it was not
+# present on the layer underneath it.
+#
+#      7 commits (No GDAT)
+# ------------------------
+#     16 commits (No GDAT)
+# ------------------------
+#     64 commits (GDAT)
+#
+test_expect_success 'do not write generation data chunk if not present on existing tip' '
+	git clone mixed mixed-no-gdat &&
+	(
+		cd mixed-no-gdat &&
+		for i in $(test_seq $THIRD_LAYER_SEQUENCE_START $THIRD_LAYER_SEQUENCE_END)
+		do
+			test_commit $i &&
+			git branch commits/$i || return 1
+		done &&
+		git commit-graph write --reachable --split=no-merge &&
+		test_line_count = 3 $graphdir/commit-graph-chain &&
+		test-tool read-graph >output &&
+		cat >expect <<-EOF &&
+		header: 43475048 1 $(test_oid oid_version) 4 2
+		num_commits: $NUM_THIRD_LAYER_COMMITS
+		chunks: oid_fanout oid_lookup commit_metadata
+		EOF
+		test_cmp expect output &&
+		git commit-graph verify
+	)
+'
+
+# Number of commits in each layer of the split-commit graph before merge:
+#
+#      8 commits (No GDAT)
+# ------------------------
+#      7 commits (No GDAT)
+# ------------------------
+#     16 commits (No GDAT)
+# ------------------------
+#     64 commits (GDAT)
+#
+# The top two layers are merged and do not have generation data chunk as layer below them does
+# not have generation data chunk.
+#
+#     15 commits (No GDAT)
+# ------------------------
+#     16 commits (No GDAT)
+# ------------------------
+#     64 commits (GDAT)
+#
+test_expect_success 'do not write generation data chunk if the topmost remaining layer does not have generation data chunk' '
+	git clone mixed-no-gdat mixed-merge-no-gdat &&
+	(
+		cd mixed-merge-no-gdat &&
+		for i in $(test_seq $FOURTH_LAYER_SEQUENCE_START $FOURTH_LAYER_SEQUENCE_END)
+		do
+			test_commit $i &&
+			git branch commits/$i || return 1
+		done &&
+		git commit-graph write --reachable --split --size-multiple 1 &&
+		test_line_count = 3 $graphdir/commit-graph-chain &&
+		test-tool read-graph >output &&
+		cat >expect <<-EOF &&
+		header: 43475048 1 $(test_oid oid_version) 4 2
+		num_commits: $(($NUM_THIRD_LAYER_COMMITS + $NUM_FOURTH_LAYER_COMMITS))
+		chunks: oid_fanout oid_lookup commit_metadata
+		EOF
+		test_cmp expect output &&
+		git commit-graph verify
+	)
+'
+
+# Number of commits in each layer of the split-commit graph before merge:
+#
+#     16 commits (No GDAT)
+# ------------------------
+#     15 commits (No GDAT)
+# ------------------------
+#     16 commits (No GDAT)
+# ------------------------
+#     64 commits (GDAT)
+#
+# The top three layers are merged and has generation data chunk as the topmost remaining layer
+# has generation data chunk.
+#
+#     47 commits (GDAT)
+# ------------------------
+#     64 commits (GDAT)
+#
+test_expect_success 'write generation data chunk if topmost remaining layer has generation data chunk' '
+	git clone mixed-merge-no-gdat mixed-merge-gdat &&
+	(
+		cd mixed-merge-gdat &&
+		for i in $(test_seq $FIFTH_LAYER_SEQUENCE_START $FIFTH_LAYER_SEQUENCE_END)
+		do
+			test_commit $i &&
+			git branch commits/$i || return 1
+		done &&
+		git commit-graph write --reachable --split --size-multiple 1 &&
+		test_line_count = 2 $graphdir/commit-graph-chain &&
+		test-tool read-graph >output &&
+		cat >expect <<-EOF &&
+		header: 43475048 1 $(test_oid oid_version) 5 1
+		num_commits: $(($NUM_SECOND_LAYER_COMMITS + $NUM_THIRD_LAYER_COMMITS + $NUM_FOURTH_LAYER_COMMITS + $NUM_FIFTH_LAYER_COMMITS))
+		chunks: oid_fanout oid_lookup commit_metadata generation_data
+		EOF
+		test_cmp expect output
+	)
+'
+
+test_expect_success 'write generation data chunk when commit-graph chain is replaced' '
+	git clone mixed mixed-replace &&
+	(
+		cd mixed-replace &&
+		git commit-graph write --reachable --split=replace &&
+		test_path_is_file $graphdir/commit-graph-chain &&
+		test_line_count = 1 $graphdir/commit-graph-chain &&
+		verify_chain_files_exist $graphdir &&
+		graph_read_expect $(($NUM_FIRST_LAYER_COMMITS + $NUM_SECOND_LAYER_COMMITS)) &&
+		git commit-graph verify
+	)
+'
+
 test_done
-- 
gitgitgadget

