Return-Path: <SRS0=mJAO=7L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A63DFC433E2
	for <git@archiver.kernel.org>; Fri, 29 May 2020 08:51:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83C3220723
	for <git@archiver.kernel.org>; Fri, 29 May 2020 08:51:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TB3mNrCm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726934AbgE2Iva (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 May 2020 04:51:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726923AbgE2Iv1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 May 2020 04:51:27 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 828E0C03E969
        for <git@vger.kernel.org>; Fri, 29 May 2020 01:51:26 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id e1so2572640wrt.5
        for <git@vger.kernel.org>; Fri, 29 May 2020 01:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Md1ng4Rb3G8KOgVu8ZWyMssm3NvuqmttT7pdRQr6Zxc=;
        b=TB3mNrCmnYFlp+CFKzbbMazmEP6Ouglt/2YxX6NmY/lQrRD1ZjS8mLOaI9mCpLTUn0
         1R4RyoF2DZPVZ3GXywmcYxfsyyi9gNdSzpOrua16+GhWR8eEXZykl8OxI/6c5UcR0at9
         8fExYZwPd0B0YpXPQuR54ZcS6UYWZVx2wd7fjnpEw5FoP1bk4HL2iR4zTXTu/5SOLJ1y
         HTbq48aI+4CoFpqcoePBR3yLktcaxgdv5XykbQ7jRaFILooXMOwq96A1vqXONbjGoFUO
         BUHTqhm180zoQqPz/8SGUM3flV6xKmCbfC2S0RnOjBlwAQeClo/DSkxUHPRlgo8IBjDg
         FeAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Md1ng4Rb3G8KOgVu8ZWyMssm3NvuqmttT7pdRQr6Zxc=;
        b=gCsWsFww4i24+PHSQYHGSVTgTFxXK+qs8YC8ydB/28SssEBCaoKL4Uoq3qCBmI3UIU
         5VQs6qvzf+N+/XUTicDYehZzB4mOwvfquDEJ0BxcziXs9wuAENQ0svirVD/PdmMI4CwY
         KNvItcAX/1znshotbYnLWLp6qKjFllNwFhf89OC7cmMhwil38cMK0PhWhgL5FLD4MgDc
         sUx0CzvsOPVLGdjFijKOAmGwBWDPAEU/Ug+dfrtOu5wv1N5Q7HB4syMFUJxV8G2M6bc2
         c/fyV9YZeDV7I/m8H5pSN1gXWbZI/QnPR7AoHEiqHeqeAeXp3hNToSQ6Q1rqzJh873D2
         rBHA==
X-Gm-Message-State: AOAM533HTtxzIc8dmaAZc3EAYbp5tqYtvOUc29rXWrjeHUB5ibK3KkJp
        K+CMlSCA/6KrDPofX57wRg1kUn15
X-Google-Smtp-Source: ABdhPJzGhSIRJ6yMH9Pwjx7cfjfOM/HQkQoLabogi1DOz53Eq5a+7faV7qxM4UN50ojzpaiI4wSC7Q==
X-Received: by 2002:a5d:6391:: with SMTP id p17mr8222001wru.118.1590742284882;
        Fri, 29 May 2020 01:51:24 -0700 (PDT)
Received: from localhost.localdomain (84-236-109-105.pool.digikabel.hu. [84.236.109.105])
        by smtp.gmail.com with ESMTPSA id f11sm3525255wrj.2.2020.05.29.01.51.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 May 2020 01:51:23 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Garima Singh <garima.singh@microsoft.com>,
        Derrick Stolee <stolee@gmail.com>,
        Jakub Narebski <jnareb@gmail.com>, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 18/34] commit-graph: write "empty" Modified Path Bloom Filter Index chunk
Date:   Fri, 29 May 2020 10:50:22 +0200
Message-Id: <20200529085038.26008-19-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.27.0.rc1.431.g5c813f95dc
In-Reply-To: <20200529085038.26008-1-szeder.dev@gmail.com>
References: <20200529085038.26008-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Write the Modifed Path Bloom Filter Index chunk if the
'core.modifiedPathBloomFilters' configuration variable is set.  For
now store only "no Bloom filter for this commit" entries.

The format of the various modified path Bloom filter-related chunks
are not (yet) compatible with split commit-graph files, so ignore the
config setting and don't write modifed path Bloom filters with
'--split'.
---
 Documentation/config/core.txt |  6 ++++++
 commit-graph.c                | 40 +++++++++++++++++++++++++++++++++++
 2 files changed, 46 insertions(+)

diff --git a/Documentation/config/core.txt b/Documentation/config/core.txt
index 9e440b160d..820f7d3bcf 100644
--- a/Documentation/config/core.txt
+++ b/Documentation/config/core.txt
@@ -588,6 +588,12 @@ core.commitGraph::
 	to parse the graph structure of commits. Defaults to true. See
 	linkgit:git-commit-graph[1] for more information.
 
+core.modifiedPathBloomFilters::
+	EXPERIMENTAL!!
+	If true, then Git will store and use Bloom filters in the
+	commit-graph file to speed up pathspec-limited revision walks.
+	Defaults to false.
+
 core.useReplaceRefs::
 	If set to `false`, behave as if the `--no-replace-objects`
 	option was given on the command line. See linkgit:git[1] and
diff --git a/commit-graph.c b/commit-graph.c
index e3adffd58b..28f147a418 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -21,6 +21,7 @@
 #define GRAPH_CHUNKID_DATA 0x43444154 /* "CDAT" */
 #define GRAPH_CHUNKID_EXTRAEDGES 0x45444745 /* "EDGE" */
 #define GRAPH_CHUNKID_BASE 0x42415345 /* "BASE" */
+#define GRAPH_CHUNKID_MODIFIED_PATH_BLOOM_FILTER_INDEX 0x4d504249 /* "MPBI" */
 
 #define GRAPH_DATA_WIDTH (the_hash_algo->rawsz + 16)
 
@@ -33,6 +34,10 @@
 
 #define GRAPH_LAST_EDGE 0x80000000
 
+#define GRAPH_MODIFIED_PATH_BLOOM_FILTER_NONE 0xffffffffffffffff
+
+#define GRAPH_MODIFIED_PATH_BLOOM_FILTER_DEFAULT_NR_HASHES 7
+
 #define GRAPH_HEADER_SIZE 8
 #define GRAPH_FANOUT_SIZE (4 * 256)
 #define GRAPH_CHUNKLOOKUP_WIDTH 12
@@ -791,6 +796,11 @@ struct write_commit_graph_context {
 		 check_oids:1;
 
 	const struct split_commit_graph_opts *split_opts;
+
+	struct modified_path_bloom_filter_context {
+		unsigned use_modified_path_bloom_filters:1;
+		unsigned int num_hashes;
+	} mpbfctx;
 };
 
 static int write_graph_chunk_fanout(struct hashfile *f,
@@ -990,6 +1000,20 @@ static int write_graph_chunk_extra_edges(struct hashfile *f,
 	return 0;
 }
 
+static int write_graph_chunk_modified_path_bloom_index(struct hashfile *f,
+		struct write_commit_graph_context *ctx)
+{
+	const uint64_t no_bloom_filter = GRAPH_MODIFIED_PATH_BLOOM_FILTER_NONE;
+	int i;
+
+	hashwrite(f, &ctx->mpbfctx.num_hashes, sizeof(uint8_t));
+	for (i = 0; i < ctx->commits.nr; i++) {
+		display_progress(ctx->progress, ++ctx->progress_cnt);
+		hashwrite(f, &no_bloom_filter, sizeof(no_bloom_filter));
+	}
+	return 0;
+}
+
 static int oid_compare(const void *_a, const void *_b)
 {
 	const struct object_id *a = (const struct object_id *)_a;
@@ -1428,6 +1452,14 @@ static int write_commit_graph_file(struct write_commit_graph_context *ctx)
 		chunks[chunks_nr].write_fn = write_graph_chunk_extra_edges;
 		chunks_nr++;
 	}
+	if (ctx->mpbfctx.use_modified_path_bloom_filters) {
+		ALLOC_GROW(chunks, chunks_nr + 1, chunks_alloc);
+		chunks[chunks_nr].id = GRAPH_CHUNKID_MODIFIED_PATH_BLOOM_FILTER_INDEX;
+		chunks[chunks_nr].size = sizeof(uint8_t) +
+					 ctx->commits.nr * sizeof(uint64_t);
+		chunks[chunks_nr].write_fn = write_graph_chunk_modified_path_bloom_index;
+		chunks_nr++;
+	}
 	if (ctx->num_commit_graphs_after > 1) {
 		ALLOC_GROW(chunks, chunks_nr + 1, chunks_alloc);
 		chunks[chunks_nr].id = GRAPH_CHUNKID_BASE;
@@ -1824,6 +1856,14 @@ int write_commit_graph(const char *obj_dir,
 	ctx->check_oids = flags & COMMIT_GRAPH_WRITE_CHECK_OIDS ? 1 : 0;
 	ctx->split_opts = split_opts;
 
+	git_config_get_bool("core.modifiedPathBloomFilters", &res);
+	if (res && ctx->split) {
+		warning("not writing modified path Bloom filters with --split");
+	} else if (res) {
+		ctx->mpbfctx.use_modified_path_bloom_filters = 1;
+		ctx->mpbfctx.num_hashes = GRAPH_MODIFIED_PATH_BLOOM_FILTER_DEFAULT_NR_HASHES;
+	}
+
 	if (ctx->split) {
 		struct commit_graph *g;
 		prepare_commit_graph(ctx->r);
-- 
2.27.0.rc1.431.g5c813f95dc

