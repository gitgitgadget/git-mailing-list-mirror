Return-Path: <SRS0=IiYM=AE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4C97C433E4
	for <git@archiver.kernel.org>; Tue, 23 Jun 2020 17:47:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A75A3206D4
	for <git@archiver.kernel.org>; Tue, 23 Jun 2020 17:47:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rUTMCrGP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733276AbgFWRrW (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Jun 2020 13:47:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733231AbgFWRrS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Jun 2020 13:47:18 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FE3FC061573
        for <git@vger.kernel.org>; Tue, 23 Jun 2020 10:47:18 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id g18so12411558wrm.2
        for <git@vger.kernel.org>; Tue, 23 Jun 2020 10:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=3lTgw40VlzHMU5pcjBu2me3VuAGVwZ3m4hYCYgAyiL0=;
        b=rUTMCrGPCPYD4nK88ILvz1RsAfDduXN8WcAwh0RLFrqanvQH/dF2OagZnMYRIEfsiF
         WXTqTnEyZYyqFPevcIRngWBBgKvTRflQG+sm49jTRBTz6oZOYFblItnS95+BJU5SVWgZ
         q4mzZEugPFe27dBsYIHMo62UQN9rMtof41VF6EtblC0h66TzKL2uANpJY0QgCJ1+N5M+
         3TP3T9NHNWh2gohY523NfXoAD3BTuJqT404Rgh02RSFbPR7sEdq+iGL8rYv8yuutDfox
         CI2RusISwpu8PLmvoeu4ziM80SstVTSvmdpCqxHXfcrCf3JTPx/HHr0Q+9PKbZCWIlxN
         0k1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=3lTgw40VlzHMU5pcjBu2me3VuAGVwZ3m4hYCYgAyiL0=;
        b=thWlK5El84eq/WzzQg+JzFIwKWo33MeeKO/4snbRJvE7v+Y3kuRdjBhFO0sdz1MJHT
         d3/rVRWgN4aH0bmHVdzAUhYIbjd3Aacdb1fqUD+5BttGvZxSFOrd8u0ORPiC6/M8JMS/
         TkgefkiN/RwneezuW+LDy+utpNkOcVUBOpk7RisZIsVqutYayJFtStOeQhygNQltDA/I
         ctax+3K9+O6+3k7FTtMRCJ5d1cIzHSben5NeP3wxSAXJI07q6mepgvFJubQ3d+g+r8lZ
         fthXvCleYr2c4BV1IZiEjN/wafwDV7+2LjlajQo0Vj/bYlead7TL1rpcTpimxisBObSf
         O2nA==
X-Gm-Message-State: AOAM530j8T8rg+yEswXy7SH1gQNzvvMPMGd5Xnpe9pTKhpugLoPwmbY3
        veYY2YGV+PAO/ZFsCEaIaxX8O0ks
X-Google-Smtp-Source: ABdhPJwFKxUZ3fc4/wBpmlYtb8yizTQK3HSpcWxCKXl53Nm46HmFJSvKI64/RP8pI6xlMo+32npV4Q==
X-Received: by 2002:a5d:6651:: with SMTP id f17mr13167030wrw.29.1592934437015;
        Tue, 23 Jun 2020 10:47:17 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j6sm5111830wmb.3.2020.06.23.10.47.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2020 10:47:16 -0700 (PDT)
Message-Id: <8b959f2f374654aeb87b847560761890c2f9aa2c.1592934430.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.659.v2.git.1592934430.gitgitgadget@gmail.com>
References: <pull.659.git.1592252093.gitgitgadget@gmail.com>
        <pull.659.v2.git.1592934430.gitgitgadget@gmail.com>
From:   "=?UTF-8?q?SZEDER=20G=C3=A1bor?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Tue, 23 Jun 2020 17:47:05 +0000
Subject: [PATCH v2 06/11] commit-graph: simplify chunk writes into loop
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     me@ttaylorr.com, szeder.dev@gmail.com, l.s.r@web.de,
        Derrick Stolee <dstolee@microsoft.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>

In write_commit_graph_file() we now have one block of code filling the
array of 'struct chunk_info' with the IDs and sizes of chunks to be
written, and an other block of code calling the functions responsible
for writing individual chunks.  In case of optional chunks like Extra
Edge List an Base Graphs List there is also a condition checking
whether that chunk is necessary/desired, and that same condition is
repeated in both blocks of code. Other, newer chunks have similar
optional conditions.

Eliminate these repeated conditions by storing the function pointers
responsible for writing individual chunks in the 'struct chunk_info'
array as well, and calling them in a loop to write the commit-graph
file.  This will open up the possibility for a bit of foolproofing in
the following patch.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 commit-graph.c | 31 +++++++++++++++++++------------
 1 file changed, 19 insertions(+), 12 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index f33bfe49b3..086fc2d070 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -1555,9 +1555,13 @@ static int write_graph_chunk_base(struct hashfile *f,
 	return 0;
 }
 
+typedef int (*chunk_write_fn)(struct hashfile *f,
+			      struct write_commit_graph_context *ctx);
+
 struct chunk_info {
 	uint32_t id;
 	uint64_t size;
+	chunk_write_fn write_fn;
 };
 
 static int write_commit_graph_file(struct write_commit_graph_context *ctx)
@@ -1615,27 +1619,34 @@ static int write_commit_graph_file(struct write_commit_graph_context *ctx)
 
 	chunks[0].id = GRAPH_CHUNKID_OIDFANOUT;
 	chunks[0].size = GRAPH_FANOUT_SIZE;
+	chunks[0].write_fn = write_graph_chunk_fanout;
 	chunks[1].id = GRAPH_CHUNKID_OIDLOOKUP;
 	chunks[1].size = hashsz * ctx->commits.nr;
+	chunks[1].write_fn = write_graph_chunk_oids;
 	chunks[2].id = GRAPH_CHUNKID_DATA;
 	chunks[2].size = (hashsz + 16) * ctx->commits.nr;
+	chunks[2].write_fn = write_graph_chunk_data;
 	if (ctx->num_extra_edges) {
 		chunks[num_chunks].id = GRAPH_CHUNKID_EXTRAEDGES;
 		chunks[num_chunks].size = 4 * ctx->num_extra_edges;
+		chunks[num_chunks].write_fn = write_graph_chunk_extra_edges;
 		num_chunks++;
 	}
 	if (ctx->changed_paths) {
 		chunks[num_chunks].id = GRAPH_CHUNKID_BLOOMINDEXES;
 		chunks[num_chunks].size = sizeof(uint32_t) * ctx->commits.nr;
+		chunks[num_chunks].write_fn = write_graph_chunk_bloom_indexes;
 		num_chunks++;
 		chunks[num_chunks].id = GRAPH_CHUNKID_BLOOMDATA;
 		chunks[num_chunks].size = sizeof(uint32_t) * 3
 					  + ctx->total_bloom_filter_data_size;
+		chunks[num_chunks].write_fn = write_graph_chunk_bloom_data;
 		num_chunks++;
 	}
 	if (ctx->num_commit_graphs_after > 1) {
 		chunks[num_chunks].id = GRAPH_CHUNKID_BASE;
 		chunks[num_chunks].size = hashsz * (ctx->num_commit_graphs_after - 1);
+		chunks[num_chunks].write_fn = write_graph_chunk_base;
 		num_chunks++;
 	}
 
@@ -1671,19 +1682,15 @@ static int write_commit_graph_file(struct write_commit_graph_context *ctx)
 			progress_title.buf,
 			num_chunks * ctx->commits.nr);
 	}
-	write_graph_chunk_fanout(f, ctx);
-	write_graph_chunk_oids(f, ctx);
-	write_graph_chunk_data(f, ctx);
-	if (ctx->num_extra_edges)
-		write_graph_chunk_extra_edges(f, ctx);
-	if (ctx->changed_paths) {
-		write_graph_chunk_bloom_indexes(f, ctx);
-		write_graph_chunk_bloom_data(f, ctx);
-	}
-	if (ctx->num_commit_graphs_after > 1 &&
-	    write_graph_chunk_base(f, ctx)) {
-		return -1;
+
+	for (i = 0; i < num_chunks; i++) {
+		if (chunks[i].write_fn(f, ctx)) {
+			error(_("failed writing chunk with id %"PRIx32""),
+			      chunks[i].id);
+			return -1;
+		}
 	}
+
 	stop_progress(&ctx->progress);
 	strbuf_release(&progress_title);
 
-- 
gitgitgadget

