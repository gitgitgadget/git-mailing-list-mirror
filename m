Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19C7F250F9
	for <git@vger.kernel.org>; Fri, 13 Oct 2023 19:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="Turjq6Yf"
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64DAADD
	for <git@vger.kernel.org>; Fri, 13 Oct 2023 12:25:32 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id 3f1490d57ef6-d849df4f1ffso2751421276.0
        for <git@vger.kernel.org>; Fri, 13 Oct 2023 12:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1697225131; x=1697829931; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IFDjdGK3sxCO5YC4i/yKtN+uSRJwHYxudzUbjnxuTLs=;
        b=Turjq6Yfpz3iUDQ9kbrymolK8NYhKqdHYxOuFd1yo5KRLBmZd8ODI9zC7NJlI6xhO9
         A/dlzlBXGm/OONMF7tSK56doyjHCBNvSQiFAsnoLzxOBnxVaj7I3g0Iwu/zgYFlRaSiw
         aVYTEQhsxn8CMuFjPFf/1i+n6gfJ/ZtQ42L2RvCtt24dc0JdfrJ99qYpFhrhZ9i5qfli
         rqhQxiAv/ZDj5wZ6ecU+0Uxw8dswpXcg2elW8s5zeKc7BrE4Lvt+6n10dCZGUVT2/tuk
         emrLCNax8F/v76hH6/oNTQLlmo2K3XJWwEtpLKh+PRIzSO1Zxx13C806IR0rKfUt5aM0
         4iCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697225131; x=1697829931;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IFDjdGK3sxCO5YC4i/yKtN+uSRJwHYxudzUbjnxuTLs=;
        b=GijrW0wvVapMlNAuRGCVj9p2KN9jcVPJ+sG+GfCOi7Ra1J9e5scgSjds/tBePISHyc
         eHYNEg7JJ9h2U/ot9oguIS21uBQIv8cPhcnEVoh6tNPf7knhYtoxmaAlxjTrjM+EHwzD
         +jBUWAWOh9NkST+1LDtMiTSDbBZoFKzE4TIF+Nvt/4STcTExD0aaOQ7bqedYQV4rgXIq
         vbj27R7KDira653ZJRBzpM9NUO/B52GunwAqRX1vlUGjY4k3VetqKvdLwzKPIjZv/v6b
         xB50IJsX9Q6XGySL9hjAZVXs0tuns57Xmr+8qfP36as6sndZkYzSLgKy3tH/RoLDFxm3
         kFOg==
X-Gm-Message-State: AOJu0YzmpxWNcHQEo53vDNRlyD+x5sVBx8rTcKLqarClPTaw+CLNBKJ9
	Py1e6+zGnxHCqsN8SG+lA0pmNEqSXqVbdW6GMMtYew==
X-Google-Smtp-Source: AGHT+IFSq2UjE1DWCqskohNnX6RkQtgPxXA+t3v80yu+1NwCaRGeknDDCCisP0h9i8l1GdOge30f5g==
X-Received: by 2002:a25:8901:0:b0:d7e:8175:4fa9 with SMTP id e1-20020a258901000000b00d7e81754fa9mr25970795ybl.4.1697225131192;
        Fri, 13 Oct 2023 12:25:31 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id d11-20020a05621416cb00b0066d15e2b73fsm880967qvz.145.2023.10.13.12.25.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 12:25:31 -0700 (PDT)
Date: Fri, 13 Oct 2023 15:25:30 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: [PATCH 5/8] commit-graph: read `BIDX` chunk with
 `pair_chunk_expect()`
Message-ID: <45cac29403e63483951f7766c6da3c022c68d9f0.1697225110.git.me@ttaylorr.com>
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

Perform an identical conversion as in previous commits to read the BIDX
chunk.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 commit-graph.c | 18 ++++--------------
 1 file changed, 4 insertions(+), 14 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index 0fab99f5dd..ad98f6334d 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -330,18 +330,6 @@ static int graph_read_oid_lookup(const unsigned char *chunk_start,
 	return 0;
 }
 
-static int graph_read_bloom_index(const unsigned char *chunk_start,
-				  size_t chunk_size, void *data)
-{
-	struct commit_graph *g = data;
-	if (chunk_size != g->num_commits * 4) {
-		warning("commit-graph changed-path index chunk is too small");
-		return -1;
-	}
-	g->chunk_bloom_indexes = chunk_start;
-	return 0;
-}
-
 static int graph_read_bloom_data(const unsigned char *chunk_start,
 				  size_t chunk_size, void *data)
 {
@@ -461,8 +449,10 @@ struct commit_graph *parse_commit_graph(struct repo_settings *s,
 	}
 
 	if (s->commit_graph_read_changed_paths) {
-		read_chunk(cf, GRAPH_CHUNKID_BLOOMINDEXES,
-			   graph_read_bloom_index, graph);
+		if (pair_chunk_expect(cf, GRAPH_CHUNKID_BLOOMINDEXES,
+				      &graph->chunk_bloom_indexes,
+				      st_mult(graph->num_commits, 4)) == -1)
+			warning(_("commit-graph changed-path index chunk is too small (%d)"), graph->num_commits * 4);
 		read_chunk(cf, GRAPH_CHUNKID_BLOOMDATA,
 			   graph_read_bloom_data, graph);
 	}
-- 
2.42.0.352.gd9c5062ff7.dirty

