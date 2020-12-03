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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0938C4361A
	for <git@archiver.kernel.org>; Thu,  3 Dec 2020 16:17:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 58D61207AA
	for <git@archiver.kernel.org>; Thu,  3 Dec 2020 16:17:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389290AbgLCQRk (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Dec 2020 11:17:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726032AbgLCQRj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Dec 2020 11:17:39 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 189B4C061A51
        for <git@vger.kernel.org>; Thu,  3 Dec 2020 08:16:59 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id l1so2440827wrb.9
        for <git@vger.kernel.org>; Thu, 03 Dec 2020 08:16:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=EPPdLSsQ8z9O62xecWRL5UkGZdb9qdYM4+t9bIDnwC4=;
        b=P58uNl5nnH++aMd2gMBHaFhJPsC89Ie0rfB2Q0P2LL0Y+8XTpQQFan/k+5E45fgUZ1
         ujhKov5WTKmmcRElZTrk1O5YatrQnE41uX3J8ni5iIhlDafclxjGKkXyObbBVBY8frc7
         lNxW+eLQQ9NNms6nrpx2XKduGTNZN0YwvI7KxTnuWCISqT9kBM906EE8uMNbrlxlgjpg
         d7tGo5XWJr5EQoPLNYxN/VsiQrqOO+MBHDG4GrAXI2q6BqKIa14EbpnZ8Jy1n9UWfMx4
         V4IhQNM2mEoQEGM8es6J69Tg7XE0Zq8ukacf+W35s3C5yzjoUhckLxHk/bZMFtnOyv/u
         Aksg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=EPPdLSsQ8z9O62xecWRL5UkGZdb9qdYM4+t9bIDnwC4=;
        b=HHLQq6ZXpleUAVvW8TiY2aKOSSTILcM4ZQ1O4pANKnuU0VxuBcOcIov6nhwtyuztN/
         T5OWBRNwiZjYzk0Jj1sJzUxlZ5BFI4P7+QNw3qQWMUS00w/qNL7P2dfDm3Rtq7JsCE7B
         FEuCAQEkceL6R5xTEWelM5NdWRrj/6S5Up6YvVrr+D1Btf9zYbXfQIAYSNdijR+/gLVs
         5py5Hi0K8Q2jdZp3mtnbIPcDF3Xs4W1jaIw6idh0AvJ10eBZ+sUjeIVTmKOldWwVFXEa
         zjAfb3Q0gQ6RLL09BkjWvEodI63JE9ZupSnBi16ixrpqI59F+h+HD9NZpmukoUXRN2XX
         7WJA==
X-Gm-Message-State: AOAM5305psQ5r9Gzdksas8uYsM878ZxMeuEE75o7ptRtq/VptWx8Cra+
        4988TD018ySEZRfcAHr/lksD5dhJpc0=
X-Google-Smtp-Source: ABdhPJxNJpBdxjUgb2AN0i0kQUAjnioycFPSAxbJvGbmygdnWfrkq65U8SWdV+fTfvXUu4mBsU6+lA==
X-Received: by 2002:adf:f2c7:: with SMTP id d7mr4592646wrp.142.1607012217588;
        Thu, 03 Dec 2020 08:16:57 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n14sm2074610wmi.1.2020.12.03.08.16.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Dec 2020 08:16:57 -0800 (PST)
Message-Id: <191b0afba825fceb2721effeb6783961bf42b59e.1607012215.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.804.git.1607012215.gitgitgadget@gmail.com>
References: <pull.804.git.1607012215.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 03 Dec 2020 16:16:40 +0000
Subject: [PATCH 01/15] commit-graph: anonymize data in chunk_write_fn
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     szeder.dev@gmail.com, me@ttaylorr.com,
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
 commit-graph.c | 30 ++++++++++++++++++++++--------
 1 file changed, 22 insertions(+), 8 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index 6f62a07313..6b5bb8b6b8 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -980,8 +980,10 @@ struct write_commit_graph_context {
 };
 
 static int write_graph_chunk_fanout(struct hashfile *f,
-				    struct write_commit_graph_context *ctx)
+				    void *data)
 {
+	struct write_commit_graph_context *ctx =
+		(struct write_commit_graph_context *)data;
 	int i, count = 0;
 	struct commit **list = ctx->commits.list;
 
@@ -1006,8 +1008,10 @@ static int write_graph_chunk_fanout(struct hashfile *f,
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
@@ -1025,8 +1029,10 @@ static const unsigned char *commit_to_sha1(size_t index, void *table)
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
@@ -1127,8 +1133,10 @@ static int write_graph_chunk_data(struct hashfile *f,
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
@@ -1181,8 +1189,10 @@ static int write_graph_chunk_extra_edges(struct hashfile *f,
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
@@ -1216,8 +1226,10 @@ static void trace2_bloom_filter_settings(struct write_commit_graph_context *ctx)
 }
 
 static int write_graph_chunk_bloom_data(struct hashfile *f,
-					struct write_commit_graph_context *ctx)
+					void *data)
 {
+	struct write_commit_graph_context *ctx =
+		(struct write_commit_graph_context *)data;
 	struct commit **list = ctx->commits.list;
 	struct commit **last = ctx->commits.list + ctx->commits.nr;
 
@@ -1670,8 +1682,10 @@ static int write_graph_chunk_base_1(struct hashfile *f,
 }
 
 static int write_graph_chunk_base(struct hashfile *f,
-				  struct write_commit_graph_context *ctx)
+				    void *data)
 {
+	struct write_commit_graph_context *ctx =
+		(struct write_commit_graph_context *)data;
 	int num = write_graph_chunk_base_1(f, ctx->new_base_graph);
 
 	if (num != ctx->num_commit_graphs_after - 1) {
@@ -1683,7 +1697,7 @@ static int write_graph_chunk_base(struct hashfile *f,
 }
 
 typedef int (*chunk_write_fn)(struct hashfile *f,
-			      struct write_commit_graph_context *ctx);
+			      void *data);
 
 struct chunk_info {
 	uint32_t id;
-- 
gitgitgadget

