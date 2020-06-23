Return-Path: <SRS0=IiYM=AE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA355C433E0
	for <git@archiver.kernel.org>; Tue, 23 Jun 2020 17:47:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BFA30206D4
	for <git@archiver.kernel.org>; Tue, 23 Jun 2020 17:47:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KT98GLqL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733092AbgFWRrP (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Jun 2020 13:47:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732549AbgFWRrO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Jun 2020 13:47:14 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C8D4C061755
        for <git@vger.kernel.org>; Tue, 23 Jun 2020 10:47:14 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id f139so2742558wmf.5
        for <git@vger.kernel.org>; Tue, 23 Jun 2020 10:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=ppLWTMM/QtjlkJ6BAXu8a4TJ2DJ2gu6KkEEaeIgaoCc=;
        b=KT98GLqLfpDu/1PLBRXoXQAyUcwnzeNdZxeATapa+ltfGbVxXRLbTr7h9TRyyjLEUc
         8dK4ZSl8uLApLyN9OeZwCzxAloHwOw960FwHal+8p+ZNzEsggCVJoRYtmqy8ZURTIYVB
         GTcXuXNE/8SwPljL05T0/nBZSAFh5jxbXoqaZ4qorrmuWaHyUfidWN7diPXpQNMbk743
         aGoL/oAzNytE5zi8wX5lVxvX9ApwJH+gt6v5+GoPHZNGRzxRHkVXFLua9fzBm7PyhH1Y
         1QznuzzajggXhag0iBRCJ6JlDQJoBIgb2GFZSDvCO+WBeVmqBfufBsNXwLQ/nplGTMWm
         SnUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=ppLWTMM/QtjlkJ6BAXu8a4TJ2DJ2gu6KkEEaeIgaoCc=;
        b=Gi1ummWsEt2L17dVZ6lPMreWopjnBpCop1jWHUqyOjANfp5CMt0DiTIINwQbj3xz2u
         bU3SnPXUcGjDraIi3a1WZUTDSYmSWUXNy4wPQ2kxeezQUqiAy8QbOjCoomJCzoU4u9am
         GDf9UVB15XDcRRaapit3XaTQJx9NIjWlJbZGMfqTHFT2IsEQHgffgN5F8QrbqsI7t917
         /vbsucC1wR68haaTyPrCcNqjLEgnkSPonr/aVTX3gmxPfG+Qu9IU3hedjJmbfT/7dhpu
         IADGfg90FZFuGMoLAKIAEiUiQtiZR7N/ALsqeAnl67YeR0aHp2OYg4m4/8CAjHfc2fPq
         eoEw==
X-Gm-Message-State: AOAM533XxL9tmxMYeHkHqehHwWxAETsIFk+gE6wJQM/mYbS50A7tf/1H
        33Mx0EUPoeP/YP8lKwqvEoSv8+Yl
X-Google-Smtp-Source: ABdhPJyaG4mHYZTWF71D5yYcuup2xu9S+o2G5FDnpUsPrT+PIok90FH2YD2HL3sDWmpvCxSiyEmzjA==
X-Received: by 2002:a05:600c:221a:: with SMTP id z26mr18661697wml.177.1592934432882;
        Tue, 23 Jun 2020 10:47:12 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v20sm4404664wmh.26.2020.06.23.10.47.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2020 10:47:12 -0700 (PDT)
Message-Id: <57002040bc83668d4998da6a1e34a6efe287ae22.1592934430.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.659.v2.git.1592934430.gitgitgadget@gmail.com>
References: <pull.659.git.1592252093.gitgitgadget@gmail.com>
        <pull.659.v2.git.1592934430.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 23 Jun 2020 17:47:00 +0000
Subject: [PATCH v2 01/11] commit-graph: place bloom_settings in context
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

