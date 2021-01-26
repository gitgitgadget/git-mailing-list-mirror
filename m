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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67FCFC43381
	for <git@archiver.kernel.org>; Tue, 26 Jan 2021 16:03:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 406D3221EC
	for <git@archiver.kernel.org>; Tue, 26 Jan 2021 16:03:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404432AbhAZQC0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Jan 2021 11:02:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389512AbhAZQCK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jan 2021 11:02:10 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D6C8C061A29
        for <git@vger.kernel.org>; Tue, 26 Jan 2021 08:01:30 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id v15so17006516wrx.4
        for <git@vger.kernel.org>; Tue, 26 Jan 2021 08:01:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=mqI9oFM5GZYrAmP0G9H5RpNNvBIP6Zj5HMIokaAsvG4=;
        b=Vwg+uNyEyNcIx5mr1qjKtSkoIRfJJJDjEuM/K2Bc8y+v8QIlwCTkWC4z2F0TC8mg2A
         wJUfcdou85DPrwA7Gvury+Zb+Ovs2jjWgil/+7xk7hj8kGtbmG9fgUsTjtLB8rRwaEG4
         dP8ljeS38P6PX5xq1DixmzZPMmFa+bNXg6OJhgI/uivBfj30gFSsb/1LWBo3ljpD/TEO
         Hmb73IFFNrfLpPZa9NuExdTMAw7k88cnLd1wKizHDE2/ybUIHHLoNs/rPEAvuX+qVKzq
         G5ZTC+1hEK2Khd4AXUf5lexgNxxl1UXI4L7U9hbEDGqKIQBNkMQ++6g+wATPkO8h1gbE
         CBfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=mqI9oFM5GZYrAmP0G9H5RpNNvBIP6Zj5HMIokaAsvG4=;
        b=lqErx7HUm3kRE7pQeL1XMzzp9KNHNdTyxo5K68MgdLymmpxkw4gQCRIflO2ewxmRjz
         6YFWPq8ct4Md9HwMkwIX2UpJnQV9tyAm2L+N+ypolDYjn2Q/e2EJMyY3D7Y6gsIs6DJs
         M1hUEelh5rYaRfMHzv/llMb2BJ64qelq+/7+LThgiz5onMD254m4/b8ZN8P3B1+On15h
         1NMkD6fTWLilIcegzg1gzZkxkR/Mrqo+RL7gRRKre0r+oyn+5BM1jPzA/FGTeBePS2Ey
         llVzszBzxr91x4OcrvmPWV+Bj8BRDtstKynAec0eluwFP7Mi1lx6r2rKZWnpnc7uT/4N
         GI/A==
X-Gm-Message-State: AOAM532YwiamerRKYbS3thYs7sCnu9KANs6hJIx+9x8TIeDwEL5XjEv3
        0QlRNX3gwIjE02wwc+xIQLy5X6nptoY=
X-Google-Smtp-Source: ABdhPJzj9oW3sqknA9TkCnU1pD1jHt5a+8e7MqSmx9WdLevDw0m6V2u1HxFcQM76nq7kdVn+XpPqmA==
X-Received: by 2002:a05:6000:1543:: with SMTP id 3mr6952114wry.254.1611676889048;
        Tue, 26 Jan 2021 08:01:29 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w14sm16278705wro.86.2021.01.26.08.01.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jan 2021 08:01:28 -0800 (PST)
Message-Id: <09b32829e4ff2384cb35afaf1a34385e25bac8d8.1611676886.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.848.git.1611676886.gitgitgadget@gmail.com>
References: <pull.848.git.1611676886.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 26 Jan 2021 16:01:10 +0000
Subject: [PATCH 01/17] commit-graph: anonymize data in chunk_write_fn
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     me@ttaylorr.com, gitster@pobox.com, l.s.r@web.de,
        szeder.dev@gmail.com, Derrick Stolee <derrickstolee@github.com>,
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
 commit-graph.c | 38 ++++++++++++++++++++++++++++----------
 1 file changed, 28 insertions(+), 10 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index f3bde2ad95a..b26ed72396e 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -1040,8 +1040,10 @@ struct write_commit_graph_context {
 };
 
 static int write_graph_chunk_fanout(struct hashfile *f,
-				    struct write_commit_graph_context *ctx)
+				    void *data)
 {
+	struct write_commit_graph_context *ctx =
+		(struct write_commit_graph_context *)data;
 	int i, count = 0;
 	struct commit **list = ctx->commits.list;
 
@@ -1066,8 +1068,10 @@ static int write_graph_chunk_fanout(struct hashfile *f,
 }
 
 static int write_graph_chunk_oids(struct hashfile *f,
-				  struct write_commit_graph_context *ctx)
+				  void *data)
 {
+	struct write_commit_graph_context *ctx =
+		(struct write_commit_graph_context *)data;
 	struct commit **list = ctx->commits.list;
 	int count;
 	for (count = 0; count < ctx->commits.nr; count++, list++) {
@@ -1085,8 +1089,10 @@ static const unsigned char *commit_to_sha1(size_t index, void *table)
 }
 
 static int write_graph_chunk_data(struct hashfile *f,
-				  struct write_commit_graph_context *ctx)
+				  void *data)
 {
+	struct write_commit_graph_context *ctx =
+		(struct write_commit_graph_context *)data;
 	struct commit **list = ctx->commits.list;
 	struct commit **last = ctx->commits.list + ctx->commits.nr;
 	uint32_t num_extra_edges = 0;
@@ -1187,8 +1193,10 @@ static int write_graph_chunk_data(struct hashfile *f,
 }
 
 static int write_graph_chunk_generation_data(struct hashfile *f,
-					      struct write_commit_graph_context *ctx)
+					     void *data)
 {
+	struct write_commit_graph_context *ctx =
+		(struct write_commit_graph_context *)data;
 	int i, num_generation_data_overflows = 0;
 
 	for (i = 0; i < ctx->commits.nr; i++) {
@@ -1208,8 +1216,10 @@ static int write_graph_chunk_generation_data(struct hashfile *f,
 }
 
 static int write_graph_chunk_generation_data_overflow(struct hashfile *f,
-						       struct write_commit_graph_context *ctx)
+						      void *data)
 {
+	struct write_commit_graph_context *ctx =
+		(struct write_commit_graph_context *)data;
 	int i;
 	for (i = 0; i < ctx->commits.nr; i++) {
 		struct commit *c = ctx->commits.list[i];
@@ -1226,8 +1236,10 @@ static int write_graph_chunk_generation_data_overflow(struct hashfile *f,
 }
 
 static int write_graph_chunk_extra_edges(struct hashfile *f,
-					 struct write_commit_graph_context *ctx)
+					 void *data)
 {
+	struct write_commit_graph_context *ctx =
+		(struct write_commit_graph_context *)data;
 	struct commit **list = ctx->commits.list;
 	struct commit **last = ctx->commits.list + ctx->commits.nr;
 	struct commit_list *parent;
@@ -1280,8 +1292,10 @@ static int write_graph_chunk_extra_edges(struct hashfile *f,
 }
 
 static int write_graph_chunk_bloom_indexes(struct hashfile *f,
-					   struct write_commit_graph_context *ctx)
+					   void *data)
 {
+	struct write_commit_graph_context *ctx =
+		(struct write_commit_graph_context *)data;
 	struct commit **list = ctx->commits.list;
 	struct commit **last = ctx->commits.list + ctx->commits.nr;
 	uint32_t cur_pos = 0;
@@ -1315,8 +1329,10 @@ static void trace2_bloom_filter_settings(struct write_commit_graph_context *ctx)
 }
 
 static int write_graph_chunk_bloom_data(struct hashfile *f,
-					struct write_commit_graph_context *ctx)
+					void *data)
 {
+	struct write_commit_graph_context *ctx =
+		(struct write_commit_graph_context *)data;
 	struct commit **list = ctx->commits.list;
 	struct commit **last = ctx->commits.list + ctx->commits.nr;
 
@@ -1737,8 +1753,10 @@ static int write_graph_chunk_base_1(struct hashfile *f,
 }
 
 static int write_graph_chunk_base(struct hashfile *f,
-				  struct write_commit_graph_context *ctx)
+				    void *data)
 {
+	struct write_commit_graph_context *ctx =
+		(struct write_commit_graph_context *)data;
 	int num = write_graph_chunk_base_1(f, ctx->new_base_graph);
 
 	if (num != ctx->num_commit_graphs_after - 1) {
@@ -1750,7 +1768,7 @@ static int write_graph_chunk_base(struct hashfile *f,
 }
 
 typedef int (*chunk_write_fn)(struct hashfile *f,
-			      struct write_commit_graph_context *ctx);
+			      void *data);
 
 struct chunk_info {
 	uint32_t id;
-- 
gitgitgadget

