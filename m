Return-Path: <SRS0=EAeL=AM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA9D6C433E2
	for <git@archiver.kernel.org>; Wed,  1 Jul 2020 13:27:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C93B720809
	for <git@archiver.kernel.org>; Wed,  1 Jul 2020 13:27:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j3CP1p7P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731100AbgGAN1n (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Jul 2020 09:27:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731084AbgGAN1j (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Jul 2020 09:27:39 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D14FC08C5DC
        for <git@vger.kernel.org>; Wed,  1 Jul 2020 06:27:38 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id z13so23834060wrw.5
        for <git@vger.kernel.org>; Wed, 01 Jul 2020 06:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=qC2zQUw85XBuWBnNo0E+B0/zAE11gJ3LrNgTrM3pySo=;
        b=j3CP1p7PMR6ws3njDMdMdyaFza4kZhkf4LKr3cW3OHlHdeCj8o+wS2LniG9RXgEvC0
         sjuqYnFTGkYFWMPGIR9VdmRY4wx8Elua4fLCRJ4nx3oj2XT0spCmQsBxvYYZflmE+xuS
         BW0yDb+lycS1aWcDu6xrYYQXc3f41jpJJoMcNlTGXalqzSKaPA1llgLkq5CrNoOc5Ejx
         oWqSl5/RgUGy2MQZ/c91oeSPgVSRLx+9hkdRweyXe8wfQ5fkfkjBwElJimoO4QEKlJnQ
         /6Qcb5E8a8e1eZFq36M3erVNTmOMnfK0N2IuHttqzVzDJfXvtJpi3jn8isdSOM6HodGs
         ayWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=qC2zQUw85XBuWBnNo0E+B0/zAE11gJ3LrNgTrM3pySo=;
        b=OftNZYgDFm2vPBchBZKY9gzCbBG5MLeRQZMf3wvzidLa6nZ3oBvO0AJHhzSgCY+qbx
         23fhyBXwfXGB5lkLXrJ5Z+IPTyHUhQ2LGd/xB6LZGR5v1YeVh/diV4/Qigeu/YiTeEB4
         mLqDVPLGsJ5V372TeB7O/ODtO+wUjRNKt17NkMES4qrbT/vByDXHj79hHUIlWdPd8acw
         MsXvMAmt926xc4rSSk62Jfkyq0Gl0DrN2f02wcJFzrXg0gw74DqhuUtDj2RUzE2FbSVS
         UbgueVt++YEctKf/rHZtBgTyLr0+6OQTCb6aNcTsvs9Q7YO6zY2jHtD3qrRS1m5Gu3kV
         vfPQ==
X-Gm-Message-State: AOAM530bdPs68Ip0W5VC3mRgbmbr1aiFbwM+NYE9sWcBnKVqBQi2HYkt
        QFeX1nFq7npDm3wnXxuJ2NYiMljk
X-Google-Smtp-Source: ABdhPJwDfxytnLJJL5jU4bRLA6fuA2ix/xCLybJbYvIxXL8VVy4pvSzMcyVaHR0HMNOV1HyrCeFSAQ==
X-Received: by 2002:adf:e6cb:: with SMTP id y11mr26052329wrm.282.1593610056940;
        Wed, 01 Jul 2020 06:27:36 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u10sm7080199wml.29.2020.07.01.06.27.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2020 06:27:36 -0700 (PDT)
Message-Id: <5ed0ce20a4a82d09ec2e9b82e12b0315dc6fd7d4.1593610050.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.659.v4.git.1593610050.gitgitgadget@gmail.com>
References: <pull.659.v3.git.1593174636.gitgitgadget@gmail.com>
        <pull.659.v4.git.1593610050.gitgitgadget@gmail.com>
From:   "=?UTF-8?q?SZEDER=20G=C3=A1bor?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Wed, 01 Jul 2020 13:27:26 +0000
Subject: [PATCH v4 06/10] commit-graph: simplify chunk writes into loop
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

Helped-by: René Scharfe <l.s.r@web.de>
Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 commit-graph.c | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index 1a6d26f864..2b26a9dad3 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -1559,9 +1559,13 @@ static int write_graph_chunk_base(struct hashfile *f,
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
@@ -1624,27 +1628,34 @@ static int write_commit_graph_file(struct write_commit_graph_context *ctx)
 
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
 
@@ -1680,19 +1691,12 @@ static int write_commit_graph_file(struct write_commit_graph_context *ctx)
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
+		if (chunks[i].write_fn(f, ctx))
+			return -1;
 	}
+
 	stop_progress(&ctx->progress);
 	strbuf_release(&progress_title);
 
-- 
gitgitgadget

