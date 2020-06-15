Return-Path: <SRS0=FGj8=74=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 048DCC433E6
	for <git@archiver.kernel.org>; Mon, 15 Jun 2020 20:15:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C5F4C206F1
	for <git@archiver.kernel.org>; Mon, 15 Jun 2020 20:15:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IFI9Xqdf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731116AbgFOUPC (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Jun 2020 16:15:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729943AbgFOUPA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Jun 2020 16:15:00 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7D0FC061A0E
        for <git@vger.kernel.org>; Mon, 15 Jun 2020 13:14:58 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id y20so872658wmi.2
        for <git@vger.kernel.org>; Mon, 15 Jun 2020 13:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=PpxyZHsz8lsbQZXZV1lE0xMtLxuGm6QGVb2pCrSf8sw=;
        b=IFI9Xqdf8aQma8VDu/Q5DeZJIybC+lz2WIwpNYXxjQAIR3fPfCPaT87Tcl7WdA25e/
         MdEns6bdpRuY18Nhj1j2Mr7lZBRdGRgrBOlG1AcxYGNMF7no0di/17ct7IsY/Z9dDmk1
         fb8xMg4igBsORwMomU5LxEnaDuxZo6CEi+u0405FKceSOupmOE29R4fDytyOTCI4jTP4
         mo2TNHg35brKnYBiEzLoMeuz+jYGhUvc6Ah210O8PRghkPPI1t+g4RqUvH4Dtux/AdjB
         /+VCvzVOc3CfltDG3SPa+0X0IxBjEAoJ+ljdwLTXZapqbPSPnokSA6ZmchMFOFdHbz2I
         E9tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=PpxyZHsz8lsbQZXZV1lE0xMtLxuGm6QGVb2pCrSf8sw=;
        b=PeUOHrQjHiGYTpvzYqooILRMcariA1iIyYpCxlvuqhFTI0A9ozSDBIB8CV0QLfEAIG
         pAaUwXEuaafhMVaLzz7+VQPq6izCChk+1dtlnBiXKNBwDYyV6AfU6fgLgBuZVtl0O11P
         lO8wWMh4kw6Oxh6gdnupxLJ61WS1Eh+HX6QvaQkxFBJbvcHt2oFsGyIKZJj2h0GJfGdB
         kPNBG5gmzdcb5gffiCY8MaXy5+IGnsViRvXrruaBt5iuU+CX7xrZGdhP63ocMvxc56MJ
         57KycIN+fQNwQI/0SlozlJl3gHBY01KFNlYJ0QwOpoF4S1asoTUUqbnFKBY80Skydw+D
         Hdyw==
X-Gm-Message-State: AOAM532R743QYtoqcIuuoM4yaQ03QTPMebA7SerMUZ4iCduU8KQHBizI
        2/1r1pG3TRKkLH8dkL0mKDcWzN+9
X-Google-Smtp-Source: ABdhPJy+o5uk5VFNZXWdDc3QJiBn8m5YrjD3GTrEHeQ8gQkTcKbfCl+VGYLBCq4+de8mk0ykCuFTEQ==
X-Received: by 2002:a1c:9a57:: with SMTP id c84mr1009169wme.62.1592252097337;
        Mon, 15 Jun 2020 13:14:57 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a14sm26824966wrv.20.2020.06.15.13.14.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 13:14:56 -0700 (PDT)
Message-Id: <3d24b9802df3d1fe8c670ba602890c95df96f2f5.1592252093.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.659.git.1592252093.gitgitgadget@gmail.com>
References: <pull.659.git.1592252093.gitgitgadget@gmail.com>
From:   "=?UTF-8?q?SZEDER=20G=C3=A1bor?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Mon, 15 Jun 2020 20:14:48 +0000
Subject: [PATCH 3/8] commit-graph: simplify chunk writes into loop
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     me@ttaylorr.com, szeder.dev@gmail.com,
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
index 3bae1e52ed0..78e023be664 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -1532,9 +1532,13 @@ static int write_graph_chunk_base(struct hashfile *f,
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
@@ -1591,27 +1595,34 @@ static int write_commit_graph_file(struct write_commit_graph_context *ctx)
 
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
 
@@ -1647,19 +1658,15 @@ static int write_commit_graph_file(struct write_commit_graph_context *ctx)
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

