Return-Path: <SRS0=EAeL=AM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41639C433E0
	for <git@archiver.kernel.org>; Wed,  1 Jul 2020 13:27:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1BDFE206BE
	for <git@archiver.kernel.org>; Wed,  1 Jul 2020 13:27:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FCqozT7A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730771AbgGAN1f (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Jul 2020 09:27:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729689AbgGAN1e (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Jul 2020 09:27:34 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BF7EC08C5DB
        for <git@vger.kernel.org>; Wed,  1 Jul 2020 06:27:34 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id r12so23766497wrj.13
        for <git@vger.kernel.org>; Wed, 01 Jul 2020 06:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=ppLWTMM/QtjlkJ6BAXu8a4TJ2DJ2gu6KkEEaeIgaoCc=;
        b=FCqozT7AODSylQspbimbhvivLGmv5M5oKrC/q/JBoTPXtSe16xlK8ThDw1wE4ZBo7b
         KTryPluaclfpve3crSuC2M1/YWumanMSsSHMtzfY3QCuWqVissb5hQYZFug4P3Me0Ra4
         a/AFEKPxnW6JeylZ/0V4CBnOboiKN9ytPyQhvr4QVYrt3Milvur1/mjIiXZAvro50BgJ
         SS25yzA0QRSSC9Dtmy6meEFUjUvZ66AQIWxroIP717FV1ZwOiK9yx1z+JXlz7puOF9g+
         QD5s8jH6st0JjDFbpPlERFCqP22Qff8tvXyrlZI1g/L2WNdgUjsH6McvRXqf+tiA3WAN
         T+zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=ppLWTMM/QtjlkJ6BAXu8a4TJ2DJ2gu6KkEEaeIgaoCc=;
        b=YXnI1Mwii1qTXTbMXarpNysPntEEa2rrQbdnC+g+B2JlT+99pzK8oipahhM9+102ie
         bTPePEE2b6ijtCf957/oqQ/r+tOERiXg7trcl1D90xt4iWPhCFUs/WdBBQhGLkIbFrN6
         lUYg/h0j+pobFkJ72+gXVuTip0hHBjdb43OthAjeWCtp2S3E6resxiRxghQgaNxT2u69
         Fzei6ESFESPbFlZHzX82gRs7/CiCaxDT0TipT0ZfJnCbyNIyoFJcdbtdi1pxQFAuJnio
         hIHQIpkXtM+NfVF+nzldXQ61en0oPAWtK5kACgMOIxG+FDSQjE1AqE72M08Lcb042oPo
         aFxg==
X-Gm-Message-State: AOAM532OE3ROmUiqbqnezIwh6PlkrvkhiTQQOyRHg0URknGu+RF31V0T
        PLSw7gz8jH+B5nKptYMyDVGnMGrl
X-Google-Smtp-Source: ABdhPJxZQP6np7KqeUueYBTTlEs6PXE2g9hYnegFZkRcTKe0VCBIuP/NBi13hkT1mzSN9O4CJxYs2Q==
X-Received: by 2002:adf:f34f:: with SMTP id e15mr27119283wrp.415.1593610052767;
        Wed, 01 Jul 2020 06:27:32 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a22sm6838412wmb.4.2020.07.01.06.27.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2020 06:27:32 -0700 (PDT)
Message-Id: <57002040bc83668d4998da6a1e34a6efe287ae22.1593610050.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.659.v4.git.1593610050.gitgitgadget@gmail.com>
References: <pull.659.v3.git.1593174636.gitgitgadget@gmail.com>
        <pull.659.v4.git.1593610050.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 01 Jul 2020 13:27:21 +0000
Subject: [PATCH v4 01/10] commit-graph: place bloom_settings in context
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     me@ttaylorr.com, szeder.dev@gmail.com, l.s.r@web.de,
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

By using a pointer, we can later replace the settings to match those
that exist in the current commit-graph, in case a future Git version
allows customization of these parameters.

Reported-by: SZEDER Gábor <szeder.dev@gmail.com>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 commit-graph.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index 887837e882..d0fedcd9b1 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -882,6 +882,7 @@ struct write_commit_graph_context {
 
 	const struct split_commit_graph_opts *split_opts;
 	size_t total_bloom_filter_data_size;
+	const struct bloom_filter_settings *bloom_settings;
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
+	hashwrite_be32(f, ctx->bloom_settings->hash_version);
+	hashwrite_be32(f, ctx->bloom_settings->num_hashes);
+	hashwrite_be32(f, ctx->bloom_settings->bits_per_entry);
 
 	while (list < last) {
 		struct bloom_filter *filter = get_bloom_filter(ctx->r, *list, 0);
@@ -1541,6 +1541,8 @@ static int write_commit_graph_file(struct write_commit_graph_context *ctx)
 	struct object_id file_hash;
 	const struct bloom_filter_settings bloom_settings = DEFAULT_BLOOM_FILTER_SETTINGS;
 
+	ctx->bloom_settings = &bloom_settings;
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

