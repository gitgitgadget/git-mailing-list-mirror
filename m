Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24429250F6
	for <git@vger.kernel.org>; Fri, 13 Oct 2023 19:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="XyvAvn7J"
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8286AA9
	for <git@vger.kernel.org>; Fri, 13 Oct 2023 12:25:29 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id 3f1490d57ef6-d9a3d737d66so2544267276.2
        for <git@vger.kernel.org>; Fri, 13 Oct 2023 12:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1697225128; x=1697829928; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SPe4DvdLmwUNmMitt5VqvfCSMM5fb9QIx28EK/d4RTM=;
        b=XyvAvn7JqL/hqSe8tymCzvp6m+8VOSOh1bKpLf8yhEcGbG11UdF7h02kvNhl/+2h+v
         B5S26ilKD6AiErWEa9FwcJPEDsUeUOik0V/hFfmSbdNZahn5IBudJWjjbVsUGXF14D+q
         Zj7x6um3vZtHq7BRydV3t89VZYHpmXlKhf6JxiUv5qAlyIP+MJJXg/i5Klq/h8sPlbdQ
         m65v1tpiLpGmuuQG4LE/CYWNZLpOgXmI9ES/mfr5vvSJvbVLFu3sAvjeEmAmxDyy7Uhw
         7YspiL5wy9Kw5n81DpwHODcM3EXQ5xKixRm3I0Mr3/mJJ3y+v5/2dmPzDw87owlgJeQK
         2eUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697225128; x=1697829928;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SPe4DvdLmwUNmMitt5VqvfCSMM5fb9QIx28EK/d4RTM=;
        b=et32WoWOv4nuADBJrxW3NkzAYH74eqWqTwpGyaZwC9gpzM2z94crVXJgD2flFbpKt1
         5B2t7JcgeHiKJXgT91yUndpXnNrQKa7nylH60t6HkiV62RbhzWoxhcV/fCb2qBQLS8FA
         oLNGFOl2rbdwxs/qi2wcWxoYgBSs0d90a0ETor2xrjsyv9o0RTKWafWDHD5FC2mf5M2J
         lDpyt9igoMeoJXpKv/qdAEUL20TSjZFMcvR2g8SbZdGTaxeymoN4xlxlaDirljZ+Up3T
         S+CV8rISro7I9kr/7KSqyQysuaZdBxcPsCEo7hSMrx5e9Gn1ftxk6EpY9T+HkI1Gf2bv
         yAWA==
X-Gm-Message-State: AOJu0YwHEPJY4BfGYSzA/cs1umcdvR5E+LXqudNu8XI0zbOcmdaNnxW3
	kvn4aM4vNbxfSWfIlqkXcExXwV5xUirKeZlnHehdIA==
X-Google-Smtp-Source: AGHT+IEbKzC6zu6yiQ2FpzalXPEGn4uvRaCtTAbeNXfaCpkcYHGOBZm5Wo62EGwMgLFEqDVQURwauQ==
X-Received: by 2002:a25:ab8f:0:b0:d9a:fe8c:c29c with SMTP id v15-20020a25ab8f000000b00d9afe8cc29cmr3444045ybi.58.1697225128393;
        Fri, 13 Oct 2023 12:25:28 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id ph3-20020a0562144a4300b006585c7f64a3sm908617qvb.14.2023.10.13.12.25.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 12:25:28 -0700 (PDT)
Date: Fri, 13 Oct 2023 15:25:27 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: [PATCH 4/8] commit-graph: read `GDAT` chunk with
 `pair_chunk_expect()`
Message-ID: <898b5bdb033518f2022d41b3cb5f03f71cc90070.1697225110.git.me@ttaylorr.com>
References: <20231009205544.GA3281950@coredump.intra.peff.net>
 <cover.1697225110.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1697225110.git.me@ttaylorr.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Perform an identical conversion as in previous commits to read the GDAT
chunk.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 commit-graph.c | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index 97d4824673..0fab99f5dd 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -330,16 +330,6 @@ static int graph_read_oid_lookup(const unsigned char *chunk_start,
 	return 0;
 }
 
-static int graph_read_generation_data(const unsigned char *chunk_start,
-				      size_t chunk_size, void *data)
-{
-	struct commit_graph *g = data;
-	if (chunk_size != g->num_commits * sizeof(uint32_t))
-		return error("commit-graph generations chunk is wrong size");
-	g->chunk_generation_data = chunk_start;
-	return 0;
-}
-
 static int graph_read_bloom_index(const unsigned char *chunk_start,
 				  size_t chunk_size, void *data)
 {
@@ -457,8 +447,11 @@ struct commit_graph *parse_commit_graph(struct repo_settings *s,
 		   &graph->chunk_base_graphs_size);
 
 	if (s->commit_graph_generation_version >= 2) {
-		read_chunk(cf, GRAPH_CHUNKID_GENERATION_DATA,
-			   graph_read_generation_data, graph);
+		if (pair_chunk_expect(cf, GRAPH_CHUNKID_GENERATION_DATA,
+				      &graph->chunk_generation_data,
+				      st_mult(graph->num_commits,
+					      sizeof(uint32_t))))
+			error(_("commit-graph generations chunk is wrong size"));
 		pair_chunk(cf, GRAPH_CHUNKID_GENERATION_DATA_OVERFLOW,
 			   &graph->chunk_generation_data_overflow,
 			   &graph->chunk_generation_data_overflow_size);
-- 
2.42.0.352.gd9c5062ff7.dirty

