Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE93CC433E9
	for <git@archiver.kernel.org>; Fri,  5 Feb 2021 22:17:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C691164EE4
	for <git@archiver.kernel.org>; Fri,  5 Feb 2021 22:17:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232932AbhBEWRC (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Feb 2021 17:17:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232746AbhBEOf7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Feb 2021 09:35:59 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11509C061223
        for <git@vger.kernel.org>; Fri,  5 Feb 2021 08:14:05 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id u14so6316467wmq.4
        for <git@vger.kernel.org>; Fri, 05 Feb 2021 08:14:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=5AF9N0vk+cHk5hTxJy9cJp3P1lCV7muF3iRhjAsxxzE=;
        b=VXY+7lLHwLTI2ONwyxAS920n4M+9TeyreMdheNEGge8PwpybENAj6mTq+vKSyFQw81
         MJrmK49Krg0piPBdqNKCwahbbf+wCXUhBhd5iA4xvFihldizCK6p8TSla9JEpntfwH5I
         M/UNS3jggJa+1zhclJaLVHsBolNoxRre/iOlB7ZGM4lsM7rgulonjOJrX1k0dOWwtemB
         LX1kOWDohm3EWmHHp0Rg0e09J7+ruqsVAbFNl/kFB7FcheXLBwoFKD001iVE0gpcaHB/
         sqMsU8j7UDJu8IygwtVT9WBMQZMU45+dXvWbcVQnKE1pCa+cl7nMSo+clzTMLS71t/Z9
         oAeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=5AF9N0vk+cHk5hTxJy9cJp3P1lCV7muF3iRhjAsxxzE=;
        b=qYmMr42gJvfvWopsrWgFvQHnhYQfoKeD5naKGRGoJteT3D1/VjtBQwH3t4TwPqXTW9
         silIjy0Iu7NW5bysxcqraovBsp4eDY+gLkGbEJhC7M/bolIxckbziv0ab0dSMXzFWhzl
         TISlwpyoVLe+bOciQMfh9gIeB9sqjC5U63e5VbYo0uhmme3mpCLSfdsZsW49Lqpiw3DM
         bIqzGi7VI9czmGmaLydsonWA9k8qzb/8RNxsJmR7Qa8uo7L0ThdL/8sxhjqR5U+gYKvR
         0/s6hVzVNtbtyYCjGhFdYqPsL5TE2fQbbfR5gDnOY+SxhqMfnTUO/JtUqwMVJo38DBZG
         UnSQ==
X-Gm-Message-State: AOAM530ozdvG8d37/k/uN0slXi0VVaiVRz+3B40zsKdrDjjq4Jt3HfM2
        33S/T/OJR6mnP0SyWQbYPx/gejwfi4s=
X-Google-Smtp-Source: ABdhPJx986be56j5ZZ9nOBz7DopezkzuO47Urd5u4wO0azdb582vCMG6ntPgHyEK8wTfoDe+emmuQQ==
X-Received: by 2002:a1c:b782:: with SMTP id h124mr3887150wmf.67.1612535455469;
        Fri, 05 Feb 2021 06:30:55 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u70sm7600558wmu.20.2021.02.05.06.30.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Feb 2021 06:30:54 -0800 (PST)
Message-Id: <243dcec9436853ff8d1bf2580e76ab909b7cb324.1612535453.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.848.v3.git.1612535452.gitgitgadget@gmail.com>
References: <pull.848.v2.git.1611759716.gitgitgadget@gmail.com>
        <pull.848.v3.git.1612535452.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 05 Feb 2021 14:30:36 +0000
Subject: [PATCH v3 01/17] commit-graph: anonymize data in chunk_write_fn
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

