Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB03BEE49A5
	for <git@archiver.kernel.org>; Mon, 21 Aug 2023 21:44:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231130AbjHUVoq (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Aug 2023 17:44:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231156AbjHUVoo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Aug 2023 17:44:44 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B56618E
        for <git@vger.kernel.org>; Mon, 21 Aug 2023 14:44:38 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-58caaedb20bso43622027b3.1
        for <git@vger.kernel.org>; Mon, 21 Aug 2023 14:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1692654277; x=1693259077;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4e6CTo3zCBO/PX00stZfCGUtsN45iWmh3zhdV8cVHmQ=;
        b=4O9U+6bbH73iDJrifbaYswWr10Hh+ZsJTe8uLblpNMOyCQSNTdKELU/AbqKru1UpWw
         UT/XoMnXXtXGF1q4EUaSSTQ+bSUjU85h8I9cnmkMWN3wzLllhEnspVPBIrpgXdurJz5I
         ZY7BYSO/VAy0hh/eLzp7sjLuWgFXAWXEDJrWunW/rpekJO5M2DVvKu8awD3jTjuHF1Wm
         PzUrzmt5HiNxKrJLcpqrANWRkrTxw/pmTwRFhZY1fN5gFxO8WCIT+aRl9dkvm+TADaHQ
         WibPLXVOMe2iMb8+4qrT8+LK0hJ6JmBXrUt0BvAjER/+LxKcLWfoo8ul4ZPp6eIP46xL
         AIXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692654277; x=1693259077;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4e6CTo3zCBO/PX00stZfCGUtsN45iWmh3zhdV8cVHmQ=;
        b=c5SrN0MSoQ4IgJVDP8FaGlpA+AJ2cvJ1ZopTbyhESNCBDT9uWqfooFtGc3dIM8IALv
         6fW0KbzlqZspHdMfrRsazRiU0d1FNrE605xJzwkOikLVzHpcSk/m2zQLQuPpa/Bvj32g
         JTjw4/RIe/jmz+pFyZk9/XPXEesufCX5ekwIr7vATSzFVzEQXVkyP1mJUy4BBZ08YjN3
         kV59E2QK9hMVvXIuoEgKyOFQvJTcYo9/MRRWFDsAIYjghS5YZhursSIQ77Uu6eTVvN0v
         zCQfNmEZbjLZMyzrYOcHoTxqCqT1EOhsLvkMdI7usoP3AXgmLJ2xbSI5Rb98mlj9mxO+
         1bFg==
X-Gm-Message-State: AOJu0YwDvJA/mriqzbmKmsLPa6NzIVYfVYjdZLaZoUlpUn7VYRv9Woih
        5kJatlhSKNxs3BANZflugbXWc07d3uhRXiH7N31JAA==
X-Google-Smtp-Source: AGHT+IFqZqMzJ8hNRI8ivMv5cQWepWdGp4VTcvu3Pm3F5dP66YQsmotI4M80+BI7YNGZSpPja1npsw==
X-Received: by 2002:a0d:d608:0:b0:584:61df:45e8 with SMTP id y8-20020a0dd608000000b0058461df45e8mr7395486ywd.13.1692654277143;
        Mon, 21 Aug 2023 14:44:37 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id x185-20020a817cc2000000b00577269ba9e9sm2429770ywc.86.2023.08.21.14.44.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Aug 2023 14:44:36 -0700 (PDT)
Date:   Mon, 21 Aug 2023 17:44:36 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>
Subject: [PATCH 12/15] commit-graph: drop unnecessary
 `graph_read_bloom_data_context`
Message-ID: <7c144a535d30dbccff5e9b32b18571058d16c809.1692654233.git.me@ttaylorr.com>
References: <cover.1692654233.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1692654233.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The `graph_read_bloom_data_context` struct was introduced in an earlier
commit in order to pass pointers to the commit-graph and changed-path
Bloom filter version when reading the BDAT chunk.

The previous commit no longer writes through the changed_paths_version
pointer, making the surrounding context structure unnecessary. Drop it
and pass a pointer to the commit-graph directly when reading the BDAT
chunk.

Noticed-by: Jonathan Tan <jonathantanmy@google.com>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 commit-graph.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index 665a3edf78..a8e33c0739 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -304,16 +304,10 @@ static int graph_read_oid_lookup(const unsigned char *chunk_start,
 	return 0;
 }
 
-struct graph_read_bloom_data_context {
-	struct commit_graph *g;
-	int *commit_graph_changed_paths_version;
-};
-
 static int graph_read_bloom_data(const unsigned char *chunk_start,
 				  size_t chunk_size, void *data)
 {
-	struct graph_read_bloom_data_context *c = data;
-	struct commit_graph *g = c->g;
+	struct commit_graph *g = data;
 	uint32_t hash_version;
 	hash_version = get_be32(chunk_start);
 
@@ -405,14 +399,10 @@ struct commit_graph *parse_commit_graph(struct repo_settings *s,
 	}
 
 	if (s->commit_graph_changed_paths_version) {
-		struct graph_read_bloom_data_context context = {
-			.g = graph,
-			.commit_graph_changed_paths_version = &s->commit_graph_changed_paths_version
-		};
 		pair_chunk(cf, GRAPH_CHUNKID_BLOOMINDEXES,
 			   &graph->chunk_bloom_indexes);
 		read_chunk(cf, GRAPH_CHUNKID_BLOOMDATA,
-			   graph_read_bloom_data, &context);
+			   graph_read_bloom_data, graph);
 	}
 
 	if (graph->chunk_bloom_indexes && graph->chunk_bloom_data) {
-- 
2.42.0.4.g52b49bb434

