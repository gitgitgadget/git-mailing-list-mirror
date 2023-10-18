Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78C629CA5C
	for <git@vger.kernel.org>; Wed, 18 Oct 2023 18:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="Hq04RakE"
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DB07122
	for <git@vger.kernel.org>; Wed, 18 Oct 2023 11:33:17 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id af79cd13be357-776f84c6cc7so479864885a.2
        for <git@vger.kernel.org>; Wed, 18 Oct 2023 11:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1697653996; x=1698258796; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sI5ZrjQEuF57E4hAqiEKGE2dRM6QFWR1Zi3nxln3p1U=;
        b=Hq04RakEGn70QypyxW7M0e3ZhatnZBFwRsS7IVBZ32bKH0oshjnpGrt9FdrZ1wvbPd
         FLNVrCAMUHE85Y7aPu9HlqS7v0WGPY0a2ccK9I2Ev1SFPi8GvgFDIjRKACT7+G2nZkzc
         LgZpBS11VVe96rTLxlIDtNmzo4nSCn5/h8E9kMNdmqRXmgO1gfS8AxVxAbfA45Bov7Zr
         NvnmiaGsNWPB5yh4TNSkliBlwi4wOb8IXUENgV8rhJRfSkOwB1Ep0rQzrrVp9rw5BnIw
         98IVX9N4lJWcrsgAzJ3MDdJV9uGGz1V5Bkl82OBPu66cgqBGc/zuSrg0HxeP90ziqVKR
         Y2bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697653996; x=1698258796;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sI5ZrjQEuF57E4hAqiEKGE2dRM6QFWR1Zi3nxln3p1U=;
        b=gGb44zXnZwvqq07X28TJbpF6Rx1fOAFx3GuVJFvABF4u0hPYxw2GJeJrozZo34YM26
         nDxINEi26qgUEJ874n65Sr3PbxFcTSryBda8MjMRoRuEwfM0yf7tYGa1m0YEm9sK3j1R
         nmBBW0pcwUWPqvxg+RWcEEtR7TBougxTn+C7WvUyc2J5VAC35IDTOVdMAhbA/zoOdlvx
         lSSEOUZ9YPAi7ZBnitnxCsBYxHztQoMxHxre9u0xxaw6zggoCRgHUSTS4npFDWnsta+D
         IA05fRsO1fOszcHvT9224tVtmcwoclJ8LT7M3ZUKQFXzIv86YIgejZ05+t4krmLwoZT5
         +E5A==
X-Gm-Message-State: AOJu0YxkfCluq5JGQnl6JrLB8TF+zvWMXsjKrYjIJVZka7oGOBdLeK+y
	sim3V7olLWr9CEaThkhKQtFCEAgz1PAM41773mtgbw==
X-Google-Smtp-Source: AGHT+IFJ/APCp7A/TxYY3NQZx5Yrj299lgGTs97GvDWaZ9R6MB2jRzvVX8W6BSqQJP9tY4SXTDYwNg==
X-Received: by 2002:ae9:f208:0:b0:775:d49d:b439 with SMTP id m8-20020ae9f208000000b00775d49db439mr5330477qkg.76.1697653996005;
        Wed, 18 Oct 2023 11:33:16 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id w12-20020a05620a148c00b0076f0744ff50sm145029qkj.136.2023.10.18.11.33.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 11:33:15 -0700 (PDT)
Date: Wed, 18 Oct 2023 14:33:14 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>,
	"Eric W. Biederman" <ebiederm@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v4 14/17] commit-graph: drop unnecessary
 `graph_read_bloom_data_context`
Message-ID: <1c78e3d17804f64797fc13cd31dadfd51e550bf4.1697653929.git.me@ttaylorr.com>
References: <cover.1696629697.git.me@ttaylorr.com>
 <cover.1697653929.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1697653929.git.me@ttaylorr.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

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
index 7d0fb32107..b70d57b085 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -314,16 +314,10 @@ static int graph_read_oid_lookup(const unsigned char *chunk_start,
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
 
@@ -415,14 +409,10 @@ struct commit_graph *parse_commit_graph(struct repo_settings *s,
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
2.42.0.415.g8942f205c8

