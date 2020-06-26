Return-Path: <SRS0=gJGs=AH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12710C433E2
	for <git@archiver.kernel.org>; Fri, 26 Jun 2020 12:30:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E3B49207E8
	for <git@archiver.kernel.org>; Fri, 26 Jun 2020 12:30:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kP1NIPSU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728491AbgFZMao (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Jun 2020 08:30:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728471AbgFZMam (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Jun 2020 08:30:42 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4FBAC08C5DC
        for <git@vger.kernel.org>; Fri, 26 Jun 2020 05:30:41 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id f18so1268883wrs.0
        for <git@vger.kernel.org>; Fri, 26 Jun 2020 05:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=ppLWTMM/QtjlkJ6BAXu8a4TJ2DJ2gu6KkEEaeIgaoCc=;
        b=kP1NIPSUai/3jkpqide9MkZ9GOR+JKke8wCB21p/zc3FmyXKHsZPWpdhoag/5IAeNE
         72ZpZytsFZOqQOnCVodWVyzL3Sncdx0YfyvWX88YlZwYqup1hJg52TBCyWBPSLwQkNrA
         hTL1X8IEzWkUAXFmVusz3Ermwlv9Szc4srLG8RTBdisV7r/Rkm4fN+OaTOevL7a6I2/0
         iLiWbz8a03G8nZDlr0VUWRjnQGisuWSiyld8ikdbHDVthkpQGCOTSJ9QGYLV4fSjOF7f
         fh4k1jAYHVOLtHXpnSZJj0TfcgYK0WeMnQoQuu9l1zFq5oKM6mhZ3vj8Bvuml6VmVD6j
         UVng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=ppLWTMM/QtjlkJ6BAXu8a4TJ2DJ2gu6KkEEaeIgaoCc=;
        b=Ampt5BqmPR00K+8KW8V7UErC0Qz+Br2ZRIc4mZRO+UMzjVx0SFqr/FCoBbt7c8xZzU
         VQr0jDsMIW2jLykzbIEBIBdbOGlTVHaw5HiejM6JeSNDeqeUr1hFCuqdMT6+J8u+QXbA
         PCWIqUZu54MQKPEk3uJAegktpNc5nRQzT6Ws7rZMC68RaHXjoGELF4i3ZSiFoH4TaDOl
         bPZ3lYW+TymLwQARk1C+VY9pNmJXS5O9CQjSe55AldxumOiNK2azRAtsI/r2MHLbzTQx
         efU5J5R716ZpdzmTRv/cRBbKUSx9mP2Oagrt+Im2z3ZTyYii1pARVRezCLECj0+Npf/4
         vwKQ==
X-Gm-Message-State: AOAM532LOR9IQZsv1UjrnVDX8Unm6F/uPKsVFKZSQRH4xK/XkOZoq7fW
        7v8AF4sCDJG5zMrT2og8XjNEYVS3
X-Google-Smtp-Source: ABdhPJzIvmKeAV1esPVY5egf+BQZDvvOPYV/4K09sw4xzWGnkgXyMFlddEcAFZL5UslZyMiZ8vsM6Q==
X-Received: by 2002:a5d:610a:: with SMTP id v10mr3563726wrt.108.1593174639616;
        Fri, 26 Jun 2020 05:30:39 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c66sm18267499wma.20.2020.06.26.05.30.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2020 05:30:39 -0700 (PDT)
Message-Id: <57002040bc83668d4998da6a1e34a6efe287ae22.1593174637.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.659.v3.git.1593174636.gitgitgadget@gmail.com>
References: <pull.659.v2.git.1592934430.gitgitgadget@gmail.com>
        <pull.659.v3.git.1593174636.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 26 Jun 2020 12:30:27 +0000
Subject: [PATCH v3 01/10] commit-graph: place bloom_settings in context
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

