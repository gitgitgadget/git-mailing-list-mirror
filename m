Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80493241FE
	for <git@vger.kernel.org>; Fri, 13 Oct 2023 19:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="Chgf/1C+"
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D515A9
	for <git@vger.kernel.org>; Fri, 13 Oct 2023 12:25:26 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id af79cd13be357-7757523362fso160009985a.0
        for <git@vger.kernel.org>; Fri, 13 Oct 2023 12:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1697225125; x=1697829925; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yFYevAyqGF2fzM/byjA8sl8kvwPTdFxSbuVDY0sx25w=;
        b=Chgf/1C+YDaxf7EGUYdDGYqcRdLab6MhpaA2sEUrapRM6s5S/F6WPj6qrPX0he8FUI
         8OXjpFS24gN3ICkPLev51D7DOjlfTK+bBpwIEKPx/Z2EwbvL1sKqBQy+MlslbjAo8SNQ
         qWvXZ8jhFT9NecFkF+SPC9eSVCAMyQmukAFvlk3GqMfZlgBEudIQ/wGBdL0P24O45Hvb
         6bTWOQ7xFRLabbfYOWxa1lxbeJlbN13F8Jt/fPbZg40+6f20vcrSB6ftZFDBt1nJ1oVd
         QGwUeTP+hE7HY77rA6eFFUD16f7sdd29bkKss1ZKzHCaKRhAgTnIAstl8Zx9FEjaMqgk
         GO/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697225125; x=1697829925;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yFYevAyqGF2fzM/byjA8sl8kvwPTdFxSbuVDY0sx25w=;
        b=N0p1f2L9NAMJvUAbqxjlgDztuA6ENfobV5ER9Bf8xF9SvPQArvAxigpZ5u6iCzFzmd
         661LhQvvMKWvkPGx6xSLqR4n0LLuVPp1uLZAamolVM576Ujo/pbkmAU1cHf1d+9v2q2m
         M5RbDWzH9VEi/uX8R6yHBa07ibs1xcXq2Vic7dVbKtiEyKoFQm13EYtZPn/8dZaHzxNp
         jbLTxUp29ikf/JUNQfm5ILZTf0gHAVFqYZYRPql67uFgZefGf5Y7RfOAcejvYqcmgoLE
         VH8tjXApNGlYBhoYD7RiNq/tqQai/RMD9jLbdLeVwZAoc3HT3C4IJfpWSNVSYJRngCeu
         QEbg==
X-Gm-Message-State: AOJu0YzAASbTyjUGsJoPsaO3oMIv/GXXgSRzQrBsQytIwU+/vKYUpTvz
	1MXAxl4od3xwQxPja0WHE0vEPAwawzgTmmQ6XxRXJA==
X-Google-Smtp-Source: AGHT+IHCN0tL8xzUP+nJrw5caGM1UlU2N6I9IHXKhuwbc18LXWD88beWIKveW6cab8WGb4T2OHc4gw==
X-Received: by 2002:a0c:b551:0:b0:66d:e4a:f2eb with SMTP id w17-20020a0cb551000000b0066d0e4af2ebmr7233933qvd.36.1697225125545;
        Fri, 13 Oct 2023 12:25:25 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id a10-20020a0ccdca000000b0065afe284b3csm897030qvn.125.2023.10.13.12.25.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 12:25:25 -0700 (PDT)
Date: Fri, 13 Oct 2023 15:25:24 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: [PATCH 3/8] commit-graph: read `CDAT` chunk with
 `pair_chunk_expect()`
Message-ID: <141ab00a1eec89666f3fb23e9bb428667f774e14.1697225110.git.me@ttaylorr.com>
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

Perform a similar conversion as in the previous commit read the CDAT
bits.

While we're here, mark the error() string for translation, and guard
against overflow when computing the expected size by wrapping it in an
st_mult() call.

Note that the pre-image of this patch was already sufficiently guarded
against overflow, since GRAPH_DATA_WIDTH is defined as
(the_hash_algo->rawsz + 16), so the expression in the parenthesis would
get performed as a size_t, and then g->num_commits would be promoted to
the width of size_t for the purposes of evaluating this expression.

But let's make it explicitly clear that this computation is safe by
wrapping it in an st_mult() call.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 commit-graph.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index cdefd7f926..97d4824673 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -330,16 +330,6 @@ static int graph_read_oid_lookup(const unsigned char *chunk_start,
 	return 0;
 }
 
-static int graph_read_commit_data(const unsigned char *chunk_start,
-				  size_t chunk_size, void *data)
-{
-	struct commit_graph *g = data;
-	if (chunk_size != g->num_commits * GRAPH_DATA_WIDTH)
-		return error("commit-graph commit data chunk is wrong size");
-	g->chunk_commit_data = chunk_start;
-	return 0;
-}
-
 static int graph_read_generation_data(const unsigned char *chunk_start,
 				      size_t chunk_size, void *data)
 {
@@ -457,7 +447,10 @@ struct commit_graph *parse_commit_graph(struct repo_settings *s,
 			      256 * sizeof(uint32_t)))
 		error(_("commit-graph oid fanout chunk is wrong size"));
 	read_chunk(cf, GRAPH_CHUNKID_OIDLOOKUP, graph_read_oid_lookup, graph);
-	read_chunk(cf, GRAPH_CHUNKID_DATA, graph_read_commit_data, graph);
+	if (pair_chunk_expect(cf, GRAPH_CHUNKID_DATA,
+			      &graph->chunk_commit_data,
+			      st_mult(graph->num_commits, GRAPH_DATA_WIDTH)))
+		error(_("commit-graph commit data chunk is wrong size"));
 	pair_chunk(cf, GRAPH_CHUNKID_EXTRAEDGES, &graph->chunk_extra_edges,
 		   &graph->chunk_extra_edges_size);
 	pair_chunk(cf, GRAPH_CHUNKID_BASE, &graph->chunk_base_graphs,
-- 
2.42.0.352.gd9c5062ff7.dirty

