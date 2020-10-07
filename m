Return-Path: <SRS0=6EDX=DO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38087C4727F
	for <git@archiver.kernel.org>; Wed,  7 Oct 2020 14:10:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D3FC421531
	for <git@archiver.kernel.org>; Wed,  7 Oct 2020 14:10:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="frsJx7Gf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728596AbgJGOKD (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Oct 2020 10:10:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728586AbgJGOJ7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Oct 2020 10:09:59 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BEBDC0613D4
        for <git@vger.kernel.org>; Wed,  7 Oct 2020 07:09:59 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id w5so2334482wrp.8
        for <git@vger.kernel.org>; Wed, 07 Oct 2020 07:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=wuBwySB8Ix03KXrrpRqQJSaf3en/EhrTFRYzWh2SViU=;
        b=frsJx7Gf/YB1u67lvMJ6yIyFa44GJMDesv7xSJZLfLfXhiBzG3PrES9eo22Idq+nSZ
         NBwxU51HLXbk/nfH7RhAF3d7UBIpJrnYQ9SbEZrQcDqnqXGwYjvBgmGoX/xdesRw7+Bl
         VnVzBWmdBeHbHvrpgY+o7NkO5L3tpkG0XHr5y3ZB34X30Eg8SIKCXOZOgRTAlpCiElD5
         k7LQyWcEHH4dpVYcF5ev1Dz5yjz5Yw2MbsQdJDuZ1aowpO7e+ZVBHwLKbWTlnDkDixls
         m54plAzv6D8l60+CFzjdYPbXHtwL/Aqj2u7HX44ONqgPRYS0Win+4tP2nW7AKtGoXCmV
         RhMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=wuBwySB8Ix03KXrrpRqQJSaf3en/EhrTFRYzWh2SViU=;
        b=h/l+4YJAF0ncvC08WSs6ZAGlbHwDgM3LLl/7673wuqmyqrKkb5nUl3iqz7SEXXnztM
         YsFpd7QKDDHKLAdEMONmSYPQMZNsB4Ye7sHCtzvtdpV5GePPnWtDu6jUbwCJTgMLtU3w
         JNSapFaugNXF7jjCA/FR3hyF4PB7Zw1WO8jVY0lSmFpz3RR9PWxjubHyVbZHUfLCERq5
         L6pnXp35qIFJ2XY23Zns/O0JxCKQrZ6huCfDScKwDrS9EiBBX5QfKEznodPkmZUahSjY
         8JmRZOKawZcYjblzhngw1sVLOSX7tutzIgXCaDjmFeXRSxqgM9OnrK8tN11maqBXS3+p
         XABQ==
X-Gm-Message-State: AOAM532XrDFIDdr2Qoa1AGFmv9URlo2p1OBKQAFbjjsCMvYV54Vrw1wp
        hyfvtMIKODyA3boLkkasxZw3hZYucRE=
X-Google-Smtp-Source: ABdhPJybuXvnK9wJpG/WdNlvTbkkPO6hfjtV8JokJL61h9ia7OIurt5WY93f0ywpGN2z0bRNDQkH2Q==
X-Received: by 2002:adf:f70d:: with SMTP id r13mr3828381wrp.317.1602079797452;
        Wed, 07 Oct 2020 07:09:57 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g144sm2972999wmg.30.2020.10.07.07.09.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2020 07:09:56 -0700 (PDT)
Message-Id: <8ec119edc66814ad4d63908c79437a7f9dd3c08c.1602079786.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.676.v4.git.1602079785.gitgitgadget@gmail.com>
References: <pull.676.v3.git.1597509583.gitgitgadget@gmail.com>
        <pull.676.v4.git.1602079785.gitgitgadget@gmail.com>
From:   "Abhishek Kumar via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 07 Oct 2020 14:09:43 +0000
Subject: [PATCH v4 08/10] commit-graph: use generation v2 only if entire chain
 does
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <stolee@gmail.com>,
        Jakub =?UTF-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>,
        Taylor Blau <me@ttaylor.com>,
        Abhishek Kumar <abhishekkumar8222@gmail.com>,
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

Because of the current use of inspecting the current layer for a
chunk_generation_data pointer, the commits in the lower layer will be
interpreted as having very large generation values (commit date plus
offset) compared to the generation numbers in the top layer (topological
level). This violates the expectation that the generation of a parent is
strictly smaller than the generation of a child.

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

When writing the new layer in split commit-graph, we write a GDAT chunk
only if the topmost layer has a GDAT chunk. This guarantees that if a
layer has GDAT chunk, all lower layers must have a GDAT chunk as well.

Rewriting layers follows similar approach: if the topmost layer below
the set of layers being rewritten (in the split commit-graph chain)
exists, and it does not contain GDAT chunk, then the result of rewrite
does not have GDAT chunks either.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
Signed-off-by: Abhishek Kumar <abhishekkumar8222@gmail.com>
---
 commit-graph.c                | 29 +++++++++++-
 commit-graph.h                |  1 +
 t/t5324-split-commit-graph.sh | 86 +++++++++++++++++++++++++++++++++++
 3 files changed, 115 insertions(+), 1 deletion(-)

diff --git a/commit-graph.c b/commit-graph.c
index 71d0b243db..5d15a1399b 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -605,6 +605,21 @@ static struct commit_graph *load_commit_graph_chain(struct repository *r,
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
@@ -613,6 +628,8 @@ struct commit_graph *read_commit_graph_one(struct repository *r,
 	if (!g)
 		g = load_commit_graph_chain(r, odb);
 
+	validate_mixed_generation_chain(g);
+
 	return g;
 }
 
@@ -782,7 +799,7 @@ static void fill_commit_graph_info(struct commit *item, struct commit_graph *g,
 	date_low = get_be32(commit_data + g->hash_len + 12);
 	item->date = (timestamp_t)((date_high << 32) | date_low);
 
-	if (g->chunk_generation_data) {
+	if (g->chunk_generation_data && g->read_generation_data) {
 		offset = (timestamp_t) get_be32(g->chunk_generation_data + sizeof(uint32_t) * lex_index);
 
 		if (offset & CORRECTED_COMMIT_DATE_OFFSET_OVERFLOW) {
@@ -2030,6 +2047,9 @@ static void split_graph_merge_strategy(struct write_commit_graph_context *ctx)
 		}
 	}
 
+	if (!ctx->write_generation_data && g->chunk_generation_data)
+		ctx->write_generation_data = 1;
+
 	if (flags != COMMIT_GRAPH_SPLIT_REPLACE)
 		ctx->new_base_graph = g;
 	else if (ctx->num_commit_graphs_after != 1)
@@ -2274,6 +2294,7 @@ int write_commit_graph(struct object_directory *odb,
 		struct commit_graph *g = ctx->r->objects->commit_graph;
 
 		while (g) {
+			g->read_generation_data = 1;
 			g->topo_levels = &topo_levels;
 			g = g->base_graph;
 		}
@@ -2300,6 +2321,9 @@ int write_commit_graph(struct object_directory *odb,
 
 		g = ctx->r->objects->commit_graph;
 
+		if (g && !g->chunk_generation_data)
+			ctx->write_generation_data = 0;
+
 		while (g) {
 			ctx->num_commit_graphs_before++;
 			g = g->base_graph;
@@ -2318,6 +2342,9 @@ int write_commit_graph(struct object_directory *odb,
 
 		if (ctx->opts)
 			replace = ctx->opts->split_flags & COMMIT_GRAPH_SPLIT_REPLACE;
+
+		if (replace)
+			ctx->write_generation_data = 1;
 	}
 
 	ctx->approx_nr_objects = approximate_object_count();
diff --git a/commit-graph.h b/commit-graph.h
index 19a02001fd..ad52130883 100644
--- a/commit-graph.h
+++ b/commit-graph.h
@@ -64,6 +64,7 @@ struct commit_graph {
 	struct object_directory *odb;
 
 	uint32_t num_commits_in_base;
+	unsigned int read_generation_data;
 	struct commit_graph *base_graph;
 
 	const uint32_t *chunk_oid_fanout;
diff --git a/t/t5324-split-commit-graph.sh b/t/t5324-split-commit-graph.sh
index 651df89ab2..d0949a9eb8 100755
--- a/t/t5324-split-commit-graph.sh
+++ b/t/t5324-split-commit-graph.sh
@@ -440,4 +440,90 @@ test_expect_success '--split=replace with partial Bloom data' '
 	verify_chain_files_exist $graphdir
 '
 
+test_expect_success 'setup repo for mixed generation commit-graph-chain' '
+	mkdir mixed &&
+	graphdir=".git/objects/info/commit-graphs" &&
+	test_oid_cache <<-EOM &&
+	oid_version sha1:1
+	oid_version sha256:2
+	EOM
+	cd "$TRASH_DIRECTORY/mixed" &&
+	git init &&
+	git config core.commitGraph true &&
+	git config gc.writeCommitGraph false &&
+	for i in $(test_seq 3)
+	do
+		test_commit $i &&
+		git branch commits/$i || return 1
+	done &&
+	git reset --hard commits/1 &&
+	for i in $(test_seq 4 5)
+	do
+		test_commit $i &&
+		git branch commits/$i || return 1
+	done &&
+	git reset --hard commits/2 &&
+	for i in $(test_seq 6 10)
+	do
+		test_commit $i &&
+		git branch commits/$i || return 1
+	done &&
+	git commit-graph write --reachable --split &&
+	git reset --hard commits/2 &&
+	git merge commits/4 &&
+	git branch merge/1 &&
+	git reset --hard commits/4 &&
+	git merge commits/6 &&
+	git branch merge/2 &&
+	GIT_TEST_COMMIT_GRAPH_NO_GDAT=1 git commit-graph write --reachable --split=no-merge &&
+	test-tool read-graph >output &&
+	cat >expect <<-EOF &&
+	header: 43475048 1 $(test_oid oid_version) 4 1
+	num_commits: 2
+	chunks: oid_fanout oid_lookup commit_metadata
+	EOF
+	test_cmp expect output &&
+	git commit-graph verify
+'
+
+test_expect_success 'does not write generation data chunk if not present on existing tip' '
+	cd "$TRASH_DIRECTORY/mixed" &&
+	git reset --hard commits/3 &&
+	git merge merge/1 &&
+	git merge commits/5 &&
+	git merge merge/2 &&
+	git branch merge/3 &&
+	git commit-graph write --reachable --split=no-merge &&
+	test-tool read-graph >output &&
+	cat >expect <<-EOF &&
+	header: 43475048 1 $(test_oid oid_version) 4 2
+	num_commits: 3
+	chunks: oid_fanout oid_lookup commit_metadata
+	EOF
+	test_cmp expect output &&
+	git commit-graph verify
+'
+
+test_expect_success 'writes generation data chunk when commit-graph chain is replaced' '
+	cd "$TRASH_DIRECTORY/mixed" &&
+	git commit-graph write --reachable --split=replace &&
+	test_path_is_file $graphdir/commit-graph-chain &&
+	test_line_count = 1 $graphdir/commit-graph-chain &&
+	verify_chain_files_exist $graphdir &&
+	graph_read_expect 15 &&
+	git commit-graph verify
+'
+
+test_expect_success 'add one commit, write a tip graph' '
+	cd "$TRASH_DIRECTORY/mixed" &&
+	test_commit 11 &&
+	git branch commits/11 &&
+	git commit-graph write --reachable --split &&
+	test_path_is_missing $infodir/commit-graph &&
+	test_path_is_file $graphdir/commit-graph-chain &&
+	ls $graphdir/graph-*.graph >graph-files &&
+	test_line_count = 2 graph-files &&
+	verify_chain_files_exist $graphdir
+'
+
 test_done
-- 
gitgitgadget

