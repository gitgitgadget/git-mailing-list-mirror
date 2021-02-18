Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 218E6C433E0
	for <git@archiver.kernel.org>; Thu, 18 Feb 2021 16:48:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE1B76146D
	for <git@archiver.kernel.org>; Thu, 18 Feb 2021 16:48:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233395AbhBRQrY (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Feb 2021 11:47:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233530AbhBROI3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Feb 2021 09:08:29 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10DF2C061786
        for <git@vger.kernel.org>; Thu, 18 Feb 2021 06:07:44 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id l12so3146665wry.2
        for <git@vger.kernel.org>; Thu, 18 Feb 2021 06:07:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=5AF9N0vk+cHk5hTxJy9cJp3P1lCV7muF3iRhjAsxxzE=;
        b=aTaoCZMBr/g5yfFWKjXObLP02VejX5q/uwJSeGnd1wBAMlbzyDsGKmNOst0I0vME3S
         YZEHGhRuDw0SqoYRr7+4YWndT/IYdu6yegyA2TFw0jwFSy3vehxOnDXU0AsqvMg0vgpm
         3KYsj6KtP4baGIA+ssLjgwL1Q1xOLs1YPllnWm9Aoc1rfbBTPmZVYLdsFYtz4b+sVga1
         MQPyrYR5+grfpgsg0leEFbCG35pDTV6c7uJ1PE34u6Xq2NxLHF7Gs7+dIiAGWvFjXiJA
         l9JSaI+EygRaioGaNk3uqFmuijUWf1q6Zu1tzMICcIBth6XIPwqGiZ4sVm4bDe+tsePd
         /x+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=5AF9N0vk+cHk5hTxJy9cJp3P1lCV7muF3iRhjAsxxzE=;
        b=IYPu8jFpnIHf0JL/aizEFnLWyWiuEi5mvfSgY/4nRAaFlh0KnD1O9nQ/DmmccyvvIV
         mmlpr7Jarewe7+dTaj+4JzZmLUQnn4F/Wwp9YZuL9Srcfr7s9cPMdJOsx3CgeFH9tllk
         qGN0ibm7xH9mpOdeAy0PlH981QV9hICILI0p69dcV7KiBl/IuHuInSq4devEy76cH3RZ
         SkAJqlRjuz/hTRJD57xCGEkbFoDUmz6E/RNbBsZ6+t8O0QsZMxeoAfVSh+gv3tNHojFq
         0ZHEI8B1etjap8zSpew/NhtL3StKjBXSSrI6DFgcDAoNDACt561iCTtah6DPaKE/RYca
         LELQ==
X-Gm-Message-State: AOAM533X+847K4RnuunEDhhnAfuq8vSNYo7rLmq5e20fG7szCamd/s7B
        S/64beAANJ8J5Wn+AW17e8jmwdUL3MM=
X-Google-Smtp-Source: ABdhPJxqzDn7PlBaI3zjDCYm33GoEHDnGPuP8X3J69oWVbq143tFABkzMB2HXY6xhOJOPm6zLdukKg==
X-Received: by 2002:a5d:448c:: with SMTP id j12mr4674484wrq.63.1613657262696;
        Thu, 18 Feb 2021 06:07:42 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t2sm8291419wru.53.2021.02.18.06.07.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Feb 2021 06:07:42 -0800 (PST)
Message-Id: <243dcec9436853ff8d1bf2580e76ab909b7cb324.1613657259.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.848.v4.git.1613657259.gitgitgadget@gmail.com>
References: <pull.848.v3.git.1612535452.gitgitgadget@gmail.com>
        <pull.848.v4.git.1613657259.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 18 Feb 2021 14:07:23 +0000
Subject: [PATCH v4 01/17] commit-graph: anonymize data in chunk_write_fn
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     me@ttaylorr.com, gitster@pobox.com, l.s.r@web.de,
        szeder.dev@gmail.com, Chris Torek <chris.torek@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

In preparation for creating an API around file formats using chunks and
tables of contents, prepare the commit-graph write code to use
prototypes that will match this new API.

Specifically, convert chunk_write_fn to take a "void *data" parameter
instead of the commit-graph-specific "struct write_commit_graph_context"
pointer.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 commit-graph.c | 29 +++++++++++++++++++----------
 1 file changed, 19 insertions(+), 10 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index f3bde2ad95a1..fae7d1b63931 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -1040,8 +1040,9 @@ struct write_commit_graph_context {
 };
 
 static int write_graph_chunk_fanout(struct hashfile *f,
-				    struct write_commit_graph_context *ctx)
+				    void *data)
 {
+	struct write_commit_graph_context *ctx = data;
 	int i, count = 0;
 	struct commit **list = ctx->commits.list;
 
@@ -1066,8 +1067,9 @@ static int write_graph_chunk_fanout(struct hashfile *f,
 }
 
 static int write_graph_chunk_oids(struct hashfile *f,
-				  struct write_commit_graph_context *ctx)
+				  void *data)
 {
+	struct write_commit_graph_context *ctx = data;
 	struct commit **list = ctx->commits.list;
 	int count;
 	for (count = 0; count < ctx->commits.nr; count++, list++) {
@@ -1085,8 +1087,9 @@ static const unsigned char *commit_to_sha1(size_t index, void *table)
 }
 
 static int write_graph_chunk_data(struct hashfile *f,
-				  struct write_commit_graph_context *ctx)
+				  void *data)
 {
+	struct write_commit_graph_context *ctx = data;
 	struct commit **list = ctx->commits.list;
 	struct commit **last = ctx->commits.list + ctx->commits.nr;
 	uint32_t num_extra_edges = 0;
@@ -1187,8 +1190,9 @@ static int write_graph_chunk_data(struct hashfile *f,
 }
 
 static int write_graph_chunk_generation_data(struct hashfile *f,
-					      struct write_commit_graph_context *ctx)
+					     void *data)
 {
+	struct write_commit_graph_context *ctx = data;
 	int i, num_generation_data_overflows = 0;
 
 	for (i = 0; i < ctx->commits.nr; i++) {
@@ -1208,8 +1212,9 @@ static int write_graph_chunk_generation_data(struct hashfile *f,
 }
 
 static int write_graph_chunk_generation_data_overflow(struct hashfile *f,
-						       struct write_commit_graph_context *ctx)
+						      void *data)
 {
+	struct write_commit_graph_context *ctx = data;
 	int i;
 	for (i = 0; i < ctx->commits.nr; i++) {
 		struct commit *c = ctx->commits.list[i];
@@ -1226,8 +1231,9 @@ static int write_graph_chunk_generation_data_overflow(struct hashfile *f,
 }
 
 static int write_graph_chunk_extra_edges(struct hashfile *f,
-					 struct write_commit_graph_context *ctx)
+					 void *data)
 {
+	struct write_commit_graph_context *ctx = data;
 	struct commit **list = ctx->commits.list;
 	struct commit **last = ctx->commits.list + ctx->commits.nr;
 	struct commit_list *parent;
@@ -1280,8 +1286,9 @@ static int write_graph_chunk_extra_edges(struct hashfile *f,
 }
 
 static int write_graph_chunk_bloom_indexes(struct hashfile *f,
-					   struct write_commit_graph_context *ctx)
+					   void *data)
 {
+	struct write_commit_graph_context *ctx = data;
 	struct commit **list = ctx->commits.list;
 	struct commit **last = ctx->commits.list + ctx->commits.nr;
 	uint32_t cur_pos = 0;
@@ -1315,8 +1322,9 @@ static void trace2_bloom_filter_settings(struct write_commit_graph_context *ctx)
 }
 
 static int write_graph_chunk_bloom_data(struct hashfile *f,
-					struct write_commit_graph_context *ctx)
+					void *data)
 {
+	struct write_commit_graph_context *ctx = data;
 	struct commit **list = ctx->commits.list;
 	struct commit **last = ctx->commits.list + ctx->commits.nr;
 
@@ -1737,8 +1745,9 @@ static int write_graph_chunk_base_1(struct hashfile *f,
 }
 
 static int write_graph_chunk_base(struct hashfile *f,
-				  struct write_commit_graph_context *ctx)
+				    void *data)
 {
+	struct write_commit_graph_context *ctx = data;
 	int num = write_graph_chunk_base_1(f, ctx->new_base_graph);
 
 	if (num != ctx->num_commit_graphs_after - 1) {
@@ -1750,7 +1759,7 @@ static int write_graph_chunk_base(struct hashfile *f,
 }
 
 typedef int (*chunk_write_fn)(struct hashfile *f,
-			      struct write_commit_graph_context *ctx);
+			      void *data);
 
 struct chunk_info {
 	uint32_t id;
-- 
gitgitgadget

