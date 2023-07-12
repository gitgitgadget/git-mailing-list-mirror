Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E705C0015E
	for <git@archiver.kernel.org>; Wed, 12 Jul 2023 23:38:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233243AbjGLXiK (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Jul 2023 19:38:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233423AbjGLXiA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jul 2023 19:38:00 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E42B9173B
        for <git@vger.kernel.org>; Wed, 12 Jul 2023 16:37:56 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-576a9507a9bso20241797b3.1
        for <git@vger.kernel.org>; Wed, 12 Jul 2023 16:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1689205076; x=1691797076;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XQw6P6gSvELa1/+kANjPKHLJEckVwwMT5jiBPmjT8PE=;
        b=LBBZBznfjWQTrwxF/xeHvZkF9jZ75IZxS8sBe+6BLtI8YOChPQ2Q7/gHvTZY7rJLQ4
         yYjlZoY1r7W5DpA06sV2RXExoRwz7JzDKJMCbDkkiEz0Df7Gz60emsc0EJvDQpvLxNsy
         fKimQeRhi3oyaVc7vtrWDkB/3Bmkya/mCWX6bbaWHcTcDNpNhaN6Q9d0avFLo/ZFi9Ux
         P1BLSeDMPDzNHJamiXsR62XRjpJo/p/amS/vSchO8KbpuDJuCg68C3lP2MI5bqjwNLet
         2T2/0oc2WzwBLvIozJ+Kkv1NDA9GLCR9ctpdkRIAb0fDCvYbGCF+/lP2Cp6k4XNdkCxM
         PRjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689205076; x=1691797076;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XQw6P6gSvELa1/+kANjPKHLJEckVwwMT5jiBPmjT8PE=;
        b=fg35c96Eh8p2B7OW08t/SBNatmNyij3HLZV9r50G34PLid78Dk+pDbgU0MjAaxQKY1
         mJkzTLoFMo1SWo5X+oXyfWV8lved6L0CCnht/emeWzL+OuyT8m7meKCviR96MZaoo6vL
         UQU/06pirSJalxuiinFp97TSPTwy0ig3KT7HybR48dHSeT4JGQTpWnIUJiCT0bIYNrRV
         +h4AXFcbcXMXn6Z9SAR5sMHlak74DXxU3c6D45sCPQ8Hk5CRe++E90xF7gOZVyoEiouy
         14LUxXgl4a78obmgosNXG89xntzSU8cKQqi2R2pEVB0sMsnh8FhkPLw9CUjPQlU1D7Hk
         G87Q==
X-Gm-Message-State: ABy/qLY34rM70lPe9dOwgFWgNYhrMJUgwQuHycsJ0lawLu2FROwJwDLU
        /qPA99mH+qI0tAiBAc7Fhmqwck1xmQCnZtnQ7F32NQ==
X-Google-Smtp-Source: APBJJlH6l+bW8F65n8kbxvA2486mnst9tpl2cv4fvvCQXlPKqX/nKMUN0CJEH4epID3VzY+DS+cvJw==
X-Received: by 2002:a0d:e6c6:0:b0:57a:8ba5:224b with SMTP id p189-20020a0de6c6000000b0057a8ba5224bmr4076732ywe.9.1689205076001;
        Wed, 12 Jul 2023 16:37:56 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id q63-20020a817542000000b0057a68b6c2f4sm1463873ywc.133.2023.07.12.16.37.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 16:37:55 -0700 (PDT)
Date:   Wed, 12 Jul 2023 19:37:54 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Victoria Dye <vdye@github.com>
Subject: [PATCH 11/20] commit-graph.c: prevent overflow in
 `write_commit_graph_file()`
Message-ID: <66e57bf359dad6c83e103f2b6ffa51d82f604d8d.1689205042.git.me@ttaylorr.com>
References: <cover.1689205042.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1689205042.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When writing a commit-graph, we use the chunk-format API to write out
each individual chunk of the commit-graph. Each chunk of the
commit-graph is tracked via a call to `add_chunk()`, along with the
expected size of that chunk.

Similar to an earlier commit which handled the identical issue in the
MIDX machinery, guard against overflow when dealing with a commit-graph
with a large number of entries to avoid corrupting the contents of the
commit-graph itself.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 commit-graph.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index f70afccada..538f96b27a 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -1952,35 +1952,35 @@ static int write_commit_graph_file(struct write_commit_graph_context *ctx)
 
 	add_chunk(cf, GRAPH_CHUNKID_OIDFANOUT, GRAPH_FANOUT_SIZE,
 		  write_graph_chunk_fanout);
-	add_chunk(cf, GRAPH_CHUNKID_OIDLOOKUP, hashsz * ctx->commits.nr,
+	add_chunk(cf, GRAPH_CHUNKID_OIDLOOKUP, st_mult(hashsz, ctx->commits.nr),
 		  write_graph_chunk_oids);
-	add_chunk(cf, GRAPH_CHUNKID_DATA, (hashsz + 16) * ctx->commits.nr,
+	add_chunk(cf, GRAPH_CHUNKID_DATA, st_mult(hashsz + 16, ctx->commits.nr),
 		  write_graph_chunk_data);
 
 	if (ctx->write_generation_data)
 		add_chunk(cf, GRAPH_CHUNKID_GENERATION_DATA,
-			  sizeof(uint32_t) * ctx->commits.nr,
+			  st_mult(sizeof(uint32_t), ctx->commits.nr),
 			  write_graph_chunk_generation_data);
 	if (ctx->num_generation_data_overflows)
 		add_chunk(cf, GRAPH_CHUNKID_GENERATION_DATA_OVERFLOW,
-			  sizeof(timestamp_t) * ctx->num_generation_data_overflows,
+			  st_mult(sizeof(timestamp_t), ctx->num_generation_data_overflows),
 			  write_graph_chunk_generation_data_overflow);
 	if (ctx->num_extra_edges)
 		add_chunk(cf, GRAPH_CHUNKID_EXTRAEDGES,
-			  4 * ctx->num_extra_edges,
+			  st_mult(4, ctx->num_extra_edges),
 			  write_graph_chunk_extra_edges);
 	if (ctx->changed_paths) {
 		add_chunk(cf, GRAPH_CHUNKID_BLOOMINDEXES,
-			  sizeof(uint32_t) * ctx->commits.nr,
+			  st_mult(sizeof(uint32_t), ctx->commits.nr),
 			  write_graph_chunk_bloom_indexes);
 		add_chunk(cf, GRAPH_CHUNKID_BLOOMDATA,
-			  sizeof(uint32_t) * 3
-				+ ctx->total_bloom_filter_data_size,
+			  st_add(sizeof(uint32_t) * 3,
+				 ctx->total_bloom_filter_data_size),
 			  write_graph_chunk_bloom_data);
 	}
 	if (ctx->num_commit_graphs_after > 1)
 		add_chunk(cf, GRAPH_CHUNKID_BASE,
-			  hashsz * (ctx->num_commit_graphs_after - 1),
+			  st_mult(hashsz, ctx->num_commit_graphs_after - 1),
 			  write_graph_chunk_base);
 
 	hashwrite_be32(f, GRAPH_SIGNATURE);
@@ -1998,7 +1998,7 @@ static int write_commit_graph_file(struct write_commit_graph_context *ctx)
 			    get_num_chunks(cf));
 		ctx->progress = start_delayed_progress(
 			progress_title.buf,
-			get_num_chunks(cf) * ctx->commits.nr);
+			st_mult(get_num_chunks(cf), ctx->commits.nr));
 	}
 
 	write_chunkfile(cf, ctx);
-- 
2.41.0.347.g7b976b8871f

