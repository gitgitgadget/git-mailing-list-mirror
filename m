Return-Path: <SRS0=dguO=BT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87297C433E4
	for <git@archiver.kernel.org>; Sun,  9 Aug 2020 02:54:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61BC5206D8
	for <git@archiver.kernel.org>; Sun,  9 Aug 2020 02:54:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ORClujzL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726380AbgHICyB (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 8 Aug 2020 22:54:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726293AbgHICx7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Aug 2020 22:53:59 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB42EC061756
        for <git@vger.kernel.org>; Sat,  8 Aug 2020 19:53:58 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id y3so5048583wrl.4
        for <git@vger.kernel.org>; Sat, 08 Aug 2020 19:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=/kisH7idb9PejmUQk6u8VOA3OdZBoJWM11ilrahD6zw=;
        b=ORClujzL9ZJaZ4jmESy66WPbnL6ZZjuk/ABZm/R75V++1iL8wuM9ms6cE16bU4CT2z
         fN+ACH5451zk6f3Pr9gqFI4VD9VSznphoC46hAkkBzS44u09wMzuA9fivATs90VUcMLE
         LuSBd2gJqSVG9+kiorkVCmJxI/yUeqv+TwUv7YVv5+YjFYGJwmZwDrNWlzR0RsUrahVw
         a3NxImzcFFDnXlEzS5+z7/9sKHusekpfRcunySFgebcHeDajio0ysT++jxrDfCpb7l9u
         2GUgOVHomtSeKHjDM50thEfoAxzSEsA99ub8GKWU3k18eZlg2yOcfb/uuCtmXkM9hX+1
         pO1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=/kisH7idb9PejmUQk6u8VOA3OdZBoJWM11ilrahD6zw=;
        b=gT0eKq9dbMdB0XPxyxsq+6SohonyrF8LkBPias96GadICN58//xtjBK+4/gdKwQOoy
         Qz4AcqY3gcDsTVm4zlwPOPJSRzOq89y/+Tmcd92wlQXpHA9CHQxtwN+OXMu3K+YZlf1C
         6LzNOFCr1TZy+HNjL140SY2xMJ8E18nfvBlz3yMziIlTjXAOT7BQhz9NLk04oD05I9KI
         M9ZxEAobafvjxXSYRelufY6xV+zfjG7XnQ8WGXjEfDXp1xE1W7VTr6wQIbfqXnBbAVin
         OjOQoDUbkwMZ0930+LPFmNwlQaElGEPJsTbvHGqmn7OCM+/iB54woCqV/vYMs9TQ65M3
         9g9g==
X-Gm-Message-State: AOAM533OU2GnAsBbR40wCInxF/obd6FD5wU3bld1uL4g19gfTQWKIqV/
        wxwD4jnrAwCmB8GmIwRB6mIVKXEZ
X-Google-Smtp-Source: ABdhPJxaZtQMdf4/yGr3Q+lodCvEEBpBwc6s8Q855yr+rAgpzc1VHLNgpuyfIbc9XIkEO0pKkGLRUQ==
X-Received: by 2002:adf:f74f:: with SMTP id z15mr5561330wrp.365.1596941637241;
        Sat, 08 Aug 2020 19:53:57 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y84sm16249868wmg.38.2020.08.08.19.53.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Aug 2020 19:53:56 -0700 (PDT)
Message-Id: <833779ad53eb4f57ae514f4e8964e397845f1ddd.1596941625.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.676.v2.git.1596941624.gitgitgadget@gmail.com>
References: <pull.676.git.1595927632.gitgitgadget@gmail.com>
        <pull.676.v2.git.1596941624.gitgitgadget@gmail.com>
From:   "Abhishek Kumar via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 09 Aug 2020 02:53:42 +0000
Subject: [PATCH v2 08/10] commit-graph: handle mixed generation commit chains
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

As corrected commit dates and topological levels cannot be compared
directly, we must handle commit graph chains with mixed generation
number definitions.

While reading a commit graph file, we disable generation numbers if the
chain contains mixed generation numbers.

While writing to commit graph chain, we write generation data chunk only
if the previous tip of chain had a generation data chunk. Using
`--split=replace` overwrites the existing chain and writes generation
data chunk regardless of previous tip.

In t5324-split-commit-graph, we set up a repo with twelve commits and
write a base commit graph file with no generation data chunk. When add
three commits and write to chain again, Git does not write generation
data chunk even without setting GIT_TEST_COMMIT_GRAPH_NO_GDAT=1. Then,
as we replace the existing chain, Git writes a commit graph file with
generation data chunk.

Signed-off-by: Abhishek Kumar <abhishekkumar8222@gmail.com>
---
 commit-graph.c                | 14 ++++++++
 t/t5324-split-commit-graph.sh | 66 +++++++++++++++++++++++++++++++++++
 2 files changed, 80 insertions(+)

diff --git a/commit-graph.c b/commit-graph.c
index d0f977852b..c6b6111adf 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -674,6 +674,14 @@ int generation_numbers_enabled(struct repository *r)
 	if (!g->num_commits)
 		return 0;
 
+	/* We cannot compare topological levels and corrected commit dates */
+	while (g->base_graph) {
+		warning(_("commit-graph-chain contains mixed generation versions"));
+		if ((g->chunk_generation_data == NULL) ^ (g->base_graph->chunk_generation_data == NULL))
+			return 0;
+		g = g->base_graph;
+	}
+
 	first_generation = get_be32(g->chunk_commit_data +
 				    g->hash_len + 8) >> 2;
 
@@ -2186,6 +2194,9 @@ int write_commit_graph(struct object_directory *odb,
 
 		g = ctx->r->objects->commit_graph;
 
+		if (g && !g->chunk_generation_data)
+			ctx->write_generation_data = 0;
+
 		while (g) {
 			ctx->num_commit_graphs_before++;
 			g = g->base_graph;
@@ -2204,6 +2215,9 @@ int write_commit_graph(struct object_directory *odb,
 
 		if (ctx->split_opts)
 			replace = ctx->split_opts->flags & COMMIT_GRAPH_SPLIT_REPLACE;
+
+		if (replace)
+			ctx->write_generation_data = 1;
 	}
 
 	ctx->approx_nr_objects = approximate_object_count();
diff --git a/t/t5324-split-commit-graph.sh b/t/t5324-split-commit-graph.sh
index 6b25c3d9ce..1a9be5e656 100755
--- a/t/t5324-split-commit-graph.sh
+++ b/t/t5324-split-commit-graph.sh
@@ -425,4 +425,70 @@ done <<\EOF
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
+	git reset --hard commits/2 &&
+	git merge commits/4 &&
+	git branch merge/1 &&
+	git reset --hard commits/4 &&
+	git merge commits/6 &&
+	git branch merge/2 &&
+	GIT_TEST_COMMIT_GRAPH_NO_GDAT=1 git commit-graph write --reachable --split &&
+	test-tool read-graph >output &&
+	cat >expect <<-EOF &&
+	header: 43475048 1 1 3 0
+	num_commits: 12
+	chunks: oid_fanout oid_lookup commit_metadata
+	EOF
+	test_cmp expect output
+'
+
+test_expect_success 'does not write generation data chunk if not present on existing tip' '
+	cd "$TRASH_DIRECTORY/mixed" &&
+	git reset --hard commits/3 &&
+	git merge merge/1 &&
+	git merge commits/5 &&
+	git merge merge/2 &&
+	git branch merge/3 &&
+	git commit-graph write --reachable --split &&
+	test-tool read-graph >output &&
+	cat >expect <<-EOF &&
+	header: 43475048 1 1 4 1
+	num_commits: 3
+	chunks: oid_fanout oid_lookup commit_metadata
+	EOF
+	test_cmp expect output
+'
+
+test_expect_success 'writes generation data chunk when commit-graph chain is replaced' '
+	cd "$TRASH_DIRECTORY/mixed" &&
+	git commit-graph write --reachable --split='replace' &&
+	test_path_is_file $graphdir/commit-graph-chain &&
+	test_line_count = 1 $graphdir/commit-graph-chain &&
+	verify_chain_files_exist $graphdir &&
+	graph_read_expect 15
+'
+
 test_done
-- 
gitgitgadget

