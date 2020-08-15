Return-Path: <SRS0=NddV=BZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A399BC433E1
	for <git@archiver.kernel.org>; Sat, 15 Aug 2020 21:59:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79E2D206B6
	for <git@archiver.kernel.org>; Sat, 15 Aug 2020 21:59:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uUQR70QY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729554AbgHOV7B (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 15 Aug 2020 17:59:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728930AbgHOVvx (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Aug 2020 17:51:53 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45235C0A3BF5
        for <git@vger.kernel.org>; Sat, 15 Aug 2020 09:39:54 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id t14so10423080wmi.3
        for <git@vger.kernel.org>; Sat, 15 Aug 2020 09:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=uQlqr/gCizoF6WiYW8C6e1RMxvpJvuXmp1DBXcJ33U0=;
        b=uUQR70QYEcVwwCbj0BmyVUtA2y6IeQAWtQDaCXmetMHvgsvlpl2rX5FPtR6WztUskU
         KuRdZ9rQ9ororaOhhygkdl2jn6DQUDFF5AMOOn5cFxIjWlegqsTtLTtEHOC6PFkG29mY
         10CvzYvmdHlC1gsReOEz05v7t0X53ZjMYMrz3btAmFrdYzYUiXQajt4V7pKfi7vaMrpu
         DRZG9Ny5WXXyO+V5LyLWFqvBpHhBKM7J9lZeJyoHQsGurwH6hy00sTlL/NBQ8XJuZI3N
         2ecoXEqOWSMy696wkx879vnDdHSSw6C01zN5s53+YL9qJfdPfs7W68LFUlxXUmbV3hk2
         medA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=uQlqr/gCizoF6WiYW8C6e1RMxvpJvuXmp1DBXcJ33U0=;
        b=iwqJ5T/rV4zaQ0MBCbrfTyWrgSka8XqW9qE2T3RBWdUx3/qNcBUIwbKn8s3c72jdWw
         +/8cS1z3B0WtptPlJeNhjEp5LsnG2MKzJmKREbtCYkg1tCqxRc4twTRbJ3EBpPb6qxxJ
         P2Xl5fInFgWdNOIhiEED5DJnuILpUWapGqdlUphWl5LPeWIjrAcb9rFV9mWEdsCl7R+T
         3jCzr1g01R6BnP7XqzxNh2AaNw0+ebcSja/Dfo6Xt62Og6p9HizaZbC+VY3tykJdT34A
         MScKZdtrBc12PTa4aepT1ixuVzxrnBRadJjc3my1ok2IbYR9SFsjoWHsT5hxiejp79BJ
         1Hsw==
X-Gm-Message-State: AOAM532YyMXcgEEkk4o37EGS7RGO/07HI9KRGxzKn88BxXrC7vk/pjkt
        74RtsNvHoBjrU4ZHd4qFsk4UP9a6Mpo=
X-Google-Smtp-Source: ABdhPJztk50S5CY02oKigQb/BXAolb4gySDT3+dg7nxfkIqM5VVADHDfB9N3vLBkJgVMB8W1i/JyDQ==
X-Received: by 2002:a7b:c084:: with SMTP id r4mr7253322wmh.23.1597509592795;
        Sat, 15 Aug 2020 09:39:52 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g145sm29769305wmg.23.2020.08.15.09.39.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Aug 2020 09:39:52 -0700 (PDT)
Message-Id: <5a147a9704f0f8d8644c92ea38583e966378b931.1597509583.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.676.v3.git.1597509583.gitgitgadget@gmail.com>
References: <pull.676.v2.git.1596941624.gitgitgadget@gmail.com>
        <pull.676.v3.git.1597509583.gitgitgadget@gmail.com>
From:   "Abhishek Kumar via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 15 Aug 2020 16:39:41 +0000
Subject: [PATCH v3 09/11] commit-graph: use generation v2 only if entire chain
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
        Abhishek Kumar <abhishekkumar8222@gmail.com>
Sender: git-owner@vger.kernel.org
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

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
Signed-off-by: Abhishek Kumar <abhishekkumar8222@gmail.com>
---
 commit-graph.c                | 32 +++++++++++++++-
 commit-graph.h                |  1 +
 t/t5324-split-commit-graph.sh | 70 +++++++++++++++++++++++++++++++++++
 3 files changed, 102 insertions(+), 1 deletion(-)

diff --git a/commit-graph.c b/commit-graph.c
index b7a72b40db..c1292f8e08 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -597,6 +597,27 @@ static struct commit_graph *load_commit_graph_chain(struct repository *r,
 	return graph_chain;
 }
 
+static void validate_mixed_generation_chain(struct repository *r)
+{
+	struct commit_graph *g = r->objects->commit_graph;
+	int read_generation_data = 1;
+
+	while (g) {
+		if (!g->chunk_generation_data) {
+			read_generation_data = 0;
+			break;
+		}
+		g = g->base_graph;
+	}
+
+	g = r->objects->commit_graph;
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
@@ -605,6 +626,8 @@ struct commit_graph *read_commit_graph_one(struct repository *r,
 	if (!g)
 		g = load_commit_graph_chain(r, odb);
 
+	validate_mixed_generation_chain(r);
+
 	return g;
 }
 
@@ -763,7 +786,7 @@ static void fill_commit_graph_info(struct commit *item, struct commit_graph *g,
 	date_low = get_be32(commit_data + g->hash_len + 12);
 	item->date = (timestamp_t)((date_high << 32) | date_low);
 
-	if (g->chunk_generation_data)
+	if (g->chunk_generation_data && g->read_generation_data)
 		graph_data->generation = item->date +
 			(timestamp_t) get_be32(g->chunk_generation_data + sizeof(uint32_t) * lex_index);
 	else
@@ -885,6 +908,7 @@ void load_commit_graph_info(struct repository *r, struct commit *item)
 	uint32_t pos;
 	if (!prepare_commit_graph(r))
 		return;
+
 	if (find_commit_in_graph(item, r->objects->commit_graph, &pos))
 		fill_commit_graph_info(item, r->objects->commit_graph, pos);
 }
@@ -2192,6 +2216,9 @@ int write_commit_graph(struct object_directory *odb,
 
 		g = ctx->r->objects->commit_graph;
 
+		if (g && !g->chunk_generation_data)
+			ctx->write_generation_data = 0;
+
 		while (g) {
 			ctx->num_commit_graphs_before++;
 			g = g->base_graph;
@@ -2210,6 +2237,9 @@ int write_commit_graph(struct object_directory *odb,
 
 		if (ctx->split_opts)
 			replace = ctx->split_opts->flags & COMMIT_GRAPH_SPLIT_REPLACE;
+
+		if (replace)
+			ctx->write_generation_data = 1;
 	}
 
 	ctx->approx_nr_objects = approximate_object_count();
diff --git a/commit-graph.h b/commit-graph.h
index f78c892fc0..3cf89d895d 100644
--- a/commit-graph.h
+++ b/commit-graph.h
@@ -63,6 +63,7 @@ struct commit_graph {
 	struct object_directory *odb;
 
 	uint32_t num_commits_in_base;
+	uint32_t read_generation_data;
 	struct commit_graph *base_graph;
 
 	const uint32_t *chunk_oid_fanout;
diff --git a/t/t5324-split-commit-graph.sh b/t/t5324-split-commit-graph.sh
index 531016f405..ac5e7783fb 100755
--- a/t/t5324-split-commit-graph.sh
+++ b/t/t5324-split-commit-graph.sh
@@ -424,4 +424,74 @@ done <<\EOF
 0600 -r--------
 EOF
 
+test_expect_success 'setup repo for mixed generation commit-graph-chain' '
+	mkdir mixed &&
+	graphdir=".git/objects/info/commit-graphs" &&
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
+	header: 43475048 1 1 4 1
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
+	header: 43475048 1 1 4 2
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
 test_done
-- 
gitgitgadget

