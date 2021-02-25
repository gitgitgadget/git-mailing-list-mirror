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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A450C433E6
	for <git@archiver.kernel.org>; Thu, 25 Feb 2021 18:20:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 073B464F2A
	for <git@archiver.kernel.org>; Thu, 25 Feb 2021 18:20:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232557AbhBYSUh (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Feb 2021 13:20:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232282AbhBYSU1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Feb 2021 13:20:27 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6660DC061756
        for <git@vger.kernel.org>; Thu, 25 Feb 2021 10:19:47 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id r3so6183807wro.9
        for <git@vger.kernel.org>; Thu, 25 Feb 2021 10:19:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=dkcf9AdrsrtFoG+SzQ3g8vOdL8Kiu782esF+r61FBcs=;
        b=uvibzc+1I+zrps+xrPGqdTm1dxe1xVXMx6QZ/fIaEfq1+8F9Cz1TJrdUa8T6s/c5YZ
         KtCyn12biWGsfelUHPPa23PHoTJEOlibiAju2CN30uTlMRqDR78MTM9G7tH7K/9KguxW
         4rt7FmaDE2a3aCWZ/A4O3sTxkjeWmI5/jnmnQUtWyeKKbYKwAEp+PVhbWpuVgZmnzXxh
         fAdzV+fUpk7JD8naMPGq2uxUjtIJh63eAcOsBVoPw8lDXKcAFw/QQ9ZAYZnX94HFTI/9
         QxbwfiP6CqylUjD1C7qQGUYflHr7OBg/5Y1AYSEcEGTmKY7OquYo6wUrNRjDOdvG6JBE
         tXVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=dkcf9AdrsrtFoG+SzQ3g8vOdL8Kiu782esF+r61FBcs=;
        b=jOWMxOTC4tVykCocs9ShEcQRfZhU3k5fe4faFIb+fezliHTYBk/KqKGj5vCe6MoISA
         n6XFvrSCmtvFbUmtwKHWoDCaYVhCvTXQz5bimiq6owvGEXneGfRk/xbWWRy155/PakYH
         2jiS3lIzv/OGl58gam4X4/JYsuHpR7a3U+RJU8weqVsYuKUxKC5/VXhq6TNj+ESs/2lJ
         2SjUIpL0I6nePq5L4aBcYQqqxce3OUiff/jMPwwq4iDnKol60Q57IBFBDidVPmChaeBR
         wkikuWyECvY1qa7WQBhRxI7/zmLdxm6/H3wBlfEjr9wIBUkj4W+qX+arTombiyWAOEry
         sBbw==
X-Gm-Message-State: AOAM530TskrO7v7bKM6XZSE9K2XOHa2FyahnaryhvhJGD6mfhdkr8AVc
        6VpRTXMyynrTL38eiWH6dOeaYRxbUNY=
X-Google-Smtp-Source: ABdhPJxN5on8V9fbXsq2L8rQPBMIWK2khTjSGgmjfu56NHOkpTEumubHu5Fo4bFnadG6pWrhQgIu4g==
X-Received: by 2002:a05:6000:192:: with SMTP id p18mr4713579wrx.403.1614277186136;
        Thu, 25 Feb 2021 10:19:46 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x18sm9188833wrs.16.2021.02.25.10.19.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Feb 2021 10:19:45 -0800 (PST)
Message-Id: <8eca11e6d4c9c1796418c28f13301223c11da01a.1614277183.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.886.git.1614277183.gitgitgadget@gmail.com>
References: <pull.886.git.1614277183.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 25 Feb 2021 18:19:43 +0000
Subject: [PATCH 2/2] commit-graph: use config to specify generation type
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     me@ttaylorr.com, abhishekkumar8222@gmail.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

We have two established generation number versions:

 1: topological levels
 2: corrected commit dates

The corrected commit dates are enabled by default, but they also write
extra data in the GDAT and GDOV chunks. Services that host Git data
might want to have more control over when this feature rolls out than
just updating the Git binaries.

Add a new "commitGraph.generationVersion" config option that specifies
the intended generation number version. If this value is less than 2,
then the GDAT chunk is never written _or read_ from an existing file.

This can replace our use of the GIT_TEST_COMMIT_GRAPH_NO_GDAT
environment variable in the test suite. Remove it.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/config/commitgraph.txt |  6 ++++++
 commit-graph.c                       | 22 +++++++++++++++-------
 commit-graph.h                       |  1 -
 t/README                             |  3 ---
 t/t5318-commit-graph.sh              |  2 +-
 t/t5324-split-commit-graph.sh        |  4 ++--
 t/t6600-test-reach.sh                |  2 +-
 7 files changed, 25 insertions(+), 15 deletions(-)

diff --git a/Documentation/config/commitgraph.txt b/Documentation/config/commitgraph.txt
index 4582c39fc462..30604e4a4c29 100644
--- a/Documentation/config/commitgraph.txt
+++ b/Documentation/config/commitgraph.txt
@@ -1,3 +1,9 @@
+commitGraph.generationVersion::
+	Specifies the type of generation number version to use when writing
+	or reading the commit-graph file. If version 1 is specified, then
+	the corrected commit dates will not be written or read. Defaults to
+	2.
+
 commitGraph.maxNewFilters::
 	Specifies the default value for the `--max-new-filters` option of `git
 	commit-graph write` (c.f., linkgit:git-commit-graph[1]).
diff --git a/commit-graph.c b/commit-graph.c
index 8b07a9a0a6df..1e9b88c003d7 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -96,6 +96,13 @@ define_commit_slab(commit_graph_data_slab, struct commit_graph_data);
 static struct commit_graph_data_slab commit_graph_data_slab =
 	COMMIT_SLAB_INIT(1, commit_graph_data_slab);
 
+static int get_configured_generation_version(struct repository *r)
+{
+	int version = 2;
+	repo_config_get_int(r, "commitgraph.generationversion", &version);
+	return version;
+}
+
 uint32_t commit_graph_position(const struct commit *c)
 {
 	struct commit_graph_data *data =
@@ -394,10 +401,13 @@ struct commit_graph *parse_commit_graph(struct repository *r,
 	pair_chunk(cf, GRAPH_CHUNKID_DATA, &graph->chunk_commit_data);
 	pair_chunk(cf, GRAPH_CHUNKID_EXTRAEDGES, &graph->chunk_extra_edges);
 	pair_chunk(cf, GRAPH_CHUNKID_BASE, &graph->chunk_base_graphs);
-	pair_chunk(cf, GRAPH_CHUNKID_GENERATION_DATA,
-		   &graph->chunk_generation_data);
-	pair_chunk(cf, GRAPH_CHUNKID_GENERATION_DATA_OVERFLOW,
-		   &graph->chunk_generation_data_overflow);
+
+	if (get_configured_generation_version(r) >= 2) {
+		pair_chunk(cf, GRAPH_CHUNKID_GENERATION_DATA,
+			&graph->chunk_generation_data);
+		pair_chunk(cf, GRAPH_CHUNKID_GENERATION_DATA_OVERFLOW,
+			&graph->chunk_generation_data_overflow);
+	}
 
 	if (r->settings.commit_graph_read_changed_paths) {
 		pair_chunk(cf, GRAPH_CHUNKID_BLOOMINDEXES,
@@ -1771,8 +1781,6 @@ static int write_commit_graph_file(struct write_commit_graph_context *ctx)
 	add_chunk(cf, GRAPH_CHUNKID_DATA, (hashsz + 16) * ctx->commits.nr,
 		  write_graph_chunk_data);
 
-	if (git_env_bool(GIT_TEST_COMMIT_GRAPH_NO_GDAT, 0))
-		ctx->write_generation_data = 0;
 	if (ctx->write_generation_data)
 		add_chunk(cf, GRAPH_CHUNKID_GENERATION_DATA,
 			  sizeof(uint32_t) * ctx->commits.nr,
@@ -2179,7 +2187,7 @@ int write_commit_graph(struct object_directory *odb,
 	ctx->split = flags & COMMIT_GRAPH_WRITE_SPLIT ? 1 : 0;
 	ctx->opts = opts;
 	ctx->total_bloom_filter_data_size = 0;
-	ctx->write_generation_data = 1;
+	ctx->write_generation_data = (get_configured_generation_version(r) == 2);
 	ctx->num_generation_data_overflows = 0;
 
 	bloom_settings.bits_per_entry = git_env_ulong("GIT_TEST_BLOOM_SETTINGS_BITS_PER_ENTRY",
diff --git a/commit-graph.h b/commit-graph.h
index 97f3497c2790..96c24fb5777d 100644
--- a/commit-graph.h
+++ b/commit-graph.h
@@ -6,7 +6,6 @@
 #include "oidset.h"
 
 #define GIT_TEST_COMMIT_GRAPH "GIT_TEST_COMMIT_GRAPH"
-#define GIT_TEST_COMMIT_GRAPH_NO_GDAT "GIT_TEST_COMMIT_GRAPH_NO_GDAT"
 #define GIT_TEST_COMMIT_GRAPH_DIE_ON_PARSE "GIT_TEST_COMMIT_GRAPH_DIE_ON_PARSE"
 #define GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS "GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS"
 
diff --git a/t/README b/t/README
index 8a121487279b..c730a7077057 100644
--- a/t/README
+++ b/t/README
@@ -393,9 +393,6 @@ GIT_TEST_COMMIT_GRAPH=<boolean>, when true, forces the commit-graph to
 be written after every 'git commit' command, and overrides the
 'core.commitGraph' setting to true.
 
-GIT_TEST_COMMIT_GRAPH_NO_GDAT=<boolean>, when true, forces the
-commit-graph to be written without generation data chunk.
-
 GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS=<boolean>, when true, forces
 commit-graph write to compute and write changed path Bloom filters for
 every 'git commit-graph write', as if the `--changed-paths` option was
diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
index c7da741284e5..6c051ca6bcf7 100755
--- a/t/t5318-commit-graph.sh
+++ b/t/t5318-commit-graph.sh
@@ -454,7 +454,7 @@ test_expect_success 'warn on improper hash version' '
 
 test_expect_success 'git commit-graph verify' '
 	cd "$TRASH_DIRECTORY/full" &&
-	git rev-parse commits/8 | GIT_TEST_COMMIT_GRAPH_NO_GDAT=1 git commit-graph write --stdin-commits &&
+	git rev-parse commits/8 | git -c commitGraph.generationVersion=1 commit-graph write --stdin-commits &&
 	git commit-graph verify >output &&
 	graph_read_expect 9 extra_edges
 '
diff --git a/t/t5324-split-commit-graph.sh b/t/t5324-split-commit-graph.sh
index 8e90f3423b8f..587226ed1032 100755
--- a/t/t5324-split-commit-graph.sh
+++ b/t/t5324-split-commit-graph.sh
@@ -489,7 +489,7 @@ test_expect_success 'setup repo for mixed generation commit-graph-chain' '
 			test_commit $i &&
 			git branch commits/$i || return 1
 		done &&
-		git commit-graph write --reachable --split &&
+		git -c commitGraph.generationVersion=2 commit-graph write --reachable --split &&
 		graph_read_expect $NUM_FIRST_LAYER_COMMITS &&
 		test_line_count = 1 $graphdir/commit-graph-chain &&
 		for i in $(test_seq $SECOND_LAYER_SEQUENCE_START $SECOND_LAYER_SEQUENCE_END)
@@ -497,7 +497,7 @@ test_expect_success 'setup repo for mixed generation commit-graph-chain' '
 			test_commit $i &&
 			git branch commits/$i || return 1
 		done &&
-		GIT_TEST_COMMIT_GRAPH_NO_GDAT=1 git commit-graph write --reachable --split=no-merge &&
+		git -c commitGraph.generationVersion=1 commit-graph write --reachable --split=no-merge &&
 		test_line_count = 2 $graphdir/commit-graph-chain &&
 		test-tool read-graph >output &&
 		cat >expect <<-EOF &&
diff --git a/t/t6600-test-reach.sh b/t/t6600-test-reach.sh
index e2d33a8a4c46..3d7a62ddab61 100755
--- a/t/t6600-test-reach.sh
+++ b/t/t6600-test-reach.sh
@@ -55,7 +55,7 @@ test_expect_success 'setup' '
 	git show-ref -s commit-5-5 | git commit-graph write --stdin-commits &&
 	mv .git/objects/info/commit-graph commit-graph-half &&
 	chmod u+w commit-graph-half &&
-	GIT_TEST_COMMIT_GRAPH_NO_GDAT=1 git commit-graph write --reachable &&
+	git -c commitGraph.generationVersion=1 commit-graph write --reachable &&
 	mv .git/objects/info/commit-graph commit-graph-no-gdat &&
 	chmod u+w commit-graph-no-gdat &&
 	git config core.commitGraph true
-- 
gitgitgadget
