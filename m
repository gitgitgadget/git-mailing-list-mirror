Return-Path: <SRS0=FGj8=74=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D1A9C433DF
	for <git@archiver.kernel.org>; Mon, 15 Jun 2020 20:15:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50329206F1
	for <git@archiver.kernel.org>; Mon, 15 Jun 2020 20:15:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gKu3cF6V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731105AbgFOUPB (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Jun 2020 16:15:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730152AbgFOUO7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Jun 2020 16:14:59 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33DA1C05BD43
        for <git@vger.kernel.org>; Mon, 15 Jun 2020 13:14:57 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id c71so790948wmd.5
        for <git@vger.kernel.org>; Mon, 15 Jun 2020 13:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=9r6663FH+6X6xTTzOgN3rPMAjY3smpEkr6Dq0H3aluY=;
        b=gKu3cF6V4PS9naM9ga9Euvb529bPxLQGyMbgi+d7I1vxt9bCShRF3eDRzkN6efxt90
         MZVpeoFGetMFsklCDv8V/mmiXdWJINW2gn8RKQVlOve7tW6oJs7TAZsiVbGw/aZ7gu6b
         Z2Ng0rCaGKktr6GieAJ0xZ9mjqI5/0ZmtFW35oSgW6dRd8MGq6nI0tVIsLquDVEXGqxs
         VfyxbU+B8ptdlaVXmMk13ttoDRLkOR/bKKXJVhioxuBFyU4IFszvc3K8QwxQMtEz/XNn
         ioIZw+lYQ4+KoUmGnAK8UX+DVk4eg9rAVXiipb00w5rg51XcE5xIx69u8krvoNmf0Rv/
         Oaig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=9r6663FH+6X6xTTzOgN3rPMAjY3smpEkr6Dq0H3aluY=;
        b=VNLGNa1TeB0+8GsymdBOyWw/PcTYMkbQMwMhhkx3EzIaLsXbc3/+oNWdagdG8kIygW
         S9glGTQx3ML2Nr8LSUPHf06CwxzozX+PzvaTaiFyXpo5YEmOQwdWCcVy02p0xziXWCL5
         YLIjBIU8owRdWJZoXzKm/evJepEUh+hMOjD5A92VMArSSAbzjPmtw/vSN6yCdk0MLU6v
         YhrMeViaVz31vlnVLn2OKLeKhFXw+KA2r4MxgRcDMi017qXAvtdAaqjHW7Rzi5jdxEzx
         YKyuWMrPYiLD/yvut2p2elVxJE9GFJsYlf9J1NdjtieOXkNvOywprYNholK/WFEN3O6K
         ZeyA==
X-Gm-Message-State: AOAM530Z+9At/1Q/E/oUS90+fovoA66EVMzMuACpzib/ext0ISIk4K0S
        rpbMt0Epsc+NlyII0x9mfxdCkuGZ
X-Google-Smtp-Source: ABdhPJzFdVOfDXEHPnbfkLhLxte0OyISF3VR1F0mjVzf195t/LhkWw5MywEcwBz61GbOUfAdHd90pg==
X-Received: by 2002:a1c:7717:: with SMTP id t23mr963602wmi.175.1592252095751;
        Mon, 15 Jun 2020 13:14:55 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c16sm26265536wrx.4.2020.06.15.13.14.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 13:14:55 -0700 (PDT)
Message-Id: <c966969071bf0ba135d304bbc0d5c16fbcbedc1e.1592252093.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.659.git.1592252093.gitgitgadget@gmail.com>
References: <pull.659.git.1592252093.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 15 Jun 2020 20:14:46 +0000
Subject: [PATCH 1/8] commit-graph: place bloom_settings in context
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     me@ttaylorr.com, szeder.dev@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

Place an instance of struct bloom_settings into the struct
write_commit_graph_context. This allows simplifying the function
prototype of write_graph_chunk_bloom_data(). This will allow us
to combine the function prototypes and use function pointers to
simplify write_commit_graph_file().

Reported-by: SZEDER Gábor <szeder.dev@gmail.com>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 commit-graph.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index 887837e8826..05b7035d8d5 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -882,6 +882,7 @@ struct write_commit_graph_context {
 
 	const struct split_commit_graph_opts *split_opts;
 	size_t total_bloom_filter_data_size;
+	struct bloom_filter_settings bloom_settings;
 };
 
 static void write_graph_chunk_fanout(struct hashfile *f,
@@ -1103,8 +1104,7 @@ static void write_graph_chunk_bloom_indexes(struct hashfile *f,
 }
 
 static void write_graph_chunk_bloom_data(struct hashfile *f,
-					 struct write_commit_graph_context *ctx,
-					 const struct bloom_filter_settings *settings)
+					 struct write_commit_graph_context *ctx)
 {
 	struct commit **list = ctx->commits.list;
 	struct commit **last = ctx->commits.list + ctx->commits.nr;
@@ -1116,9 +1116,9 @@ static void write_graph_chunk_bloom_data(struct hashfile *f,
 			_("Writing changed paths Bloom filters data"),
 			ctx->commits.nr);
 
-	hashwrite_be32(f, settings->hash_version);
-	hashwrite_be32(f, settings->num_hashes);
-	hashwrite_be32(f, settings->bits_per_entry);
+	hashwrite_be32(f, ctx->bloom_settings.hash_version);
+	hashwrite_be32(f, ctx->bloom_settings.num_hashes);
+	hashwrite_be32(f, ctx->bloom_settings.bits_per_entry);
 
 	while (list < last) {
 		struct bloom_filter *filter = get_bloom_filter(ctx->r, *list, 0);
@@ -1541,6 +1541,8 @@ static int write_commit_graph_file(struct write_commit_graph_context *ctx)
 	struct object_id file_hash;
 	const struct bloom_filter_settings bloom_settings = DEFAULT_BLOOM_FILTER_SETTINGS;
 
+	ctx->bloom_settings = bloom_settings;
+
 	if (ctx->split) {
 		struct strbuf tmp_file = STRBUF_INIT;
 
@@ -1642,7 +1644,7 @@ static int write_commit_graph_file(struct write_commit_graph_context *ctx)
 		write_graph_chunk_extra_edges(f, ctx);
 	if (ctx->changed_paths) {
 		write_graph_chunk_bloom_indexes(f, ctx);
-		write_graph_chunk_bloom_data(f, ctx, &bloom_settings);
+		write_graph_chunk_bloom_data(f, ctx);
 	}
 	if (ctx->num_commit_graphs_after > 1 &&
 	    write_graph_chunk_base(f, ctx)) {
-- 
gitgitgadget

