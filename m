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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35F7EC433E9
	for <git@archiver.kernel.org>; Wed, 27 Jan 2021 15:59:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E07C9207D0
	for <git@archiver.kernel.org>; Wed, 27 Jan 2021 15:59:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235521AbhA0P7D (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Jan 2021 10:59:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235418AbhA0PCi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Jan 2021 10:02:38 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04A6BC061756
        for <git@vger.kernel.org>; Wed, 27 Jan 2021 07:02:01 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id v15so2256210wrx.4
        for <git@vger.kernel.org>; Wed, 27 Jan 2021 07:02:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=4jAJyZj2vuArliZTGrCmiku/Z3yLQwa3mMfot5zJvI0=;
        b=p/Nz+Ba6J2Wxi/vQdSda95wdnWWPBjo4Mw9oFk4Y5i4XUBfTso/H97C+RJyDfAwvoY
         13AeNPAtCbYR9xETZEznJI53BS4S6xtNzyiWRWd70pny6ac6bwgHxyHXUVdkI6q2emt5
         x/AGndKmJOOrmUIuHIupmnYvMAoP5t5PiMqBcASGdoJL6kY4Xz+s4rs71A6ZWtm0pofS
         tl2yOLWTXzcuY0o2cYe2o3Eil4nFldI6XZfBv+URnBRg8nM5uF1QXGMIsP+RNL1sbXVV
         I8oAR63XKINDw/rz+qqNQnNToTC3icAcEBZRYTZvw9Ak0jFMt1hVvEhnzQxY1OWnk2kp
         kTXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=4jAJyZj2vuArliZTGrCmiku/Z3yLQwa3mMfot5zJvI0=;
        b=gTz7W+2mo7ZSeJwhrVUheKEV0VzapaTZDK7pxdBgEYeoHd9Gmi1pS0737+g5gjZt7R
         6tq0CyjVp1baoaWnn80HTZuCfSbQD4hSdmkOVibVMxpiqL9HQ4C74mFiVUpN0HGgXwhL
         KUXcGzdVYdE/Ssnn7b6NEOUsV1WNzXnm11F4yRIo/tbN4da6tKq0gqK7gmVczWwC0Ng9
         fE3Jr/W+HfS7GXEOjqphCFvz5r+6SO//2BdI+mGKsJW7QywNOw7rcX6dVhOz5HKck9oh
         5PvnTMrohbEPo5kKusmX/12xiLmOcIXmdt6zfsDBum96GYMBv09zo0xPFBl3rhVlHiJ+
         p2tA==
X-Gm-Message-State: AOAM531OE1y8eQ2aS7BiyJQghxODX5Ln0hlxkssHXpdwEBFoCkCIcPQH
        iSIF5VCfRgziEr1ydykMR8N6CwDGpz8=
X-Google-Smtp-Source: ABdhPJzwuEatrXqmKdGxDlGTqgJVCUQ2gVDiCX1VLclPVlEArtWsbWSz7tnfaFSh7FxqALpJe8N9jA==
X-Received: by 2002:a5d:4d86:: with SMTP id b6mr11539184wru.152.1611759719418;
        Wed, 27 Jan 2021 07:01:59 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i6sm3185562wrs.71.2021.01.27.07.01.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jan 2021 07:01:58 -0800 (PST)
Message-Id: <243dcec9436853ff8d1bf2580e76ab909b7cb324.1611759716.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.848.v2.git.1611759716.gitgitgadget@gmail.com>
References: <pull.848.git.1611676886.gitgitgadget@gmail.com>
        <pull.848.v2.git.1611759716.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 27 Jan 2021 15:01:40 +0000
Subject: [PATCH v2 01/17] commit-graph: anonymize data in chunk_write_fn
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
index f3bde2ad95a..fae7d1b6393 100644
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

