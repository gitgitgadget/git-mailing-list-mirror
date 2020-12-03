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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6F29C433FE
	for <git@archiver.kernel.org>; Thu,  3 Dec 2020 16:18:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B430207AD
	for <git@archiver.kernel.org>; Thu,  3 Dec 2020 16:18:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2501890AbgLCQSV (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Dec 2020 11:18:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2501883AbgLCQST (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Dec 2020 11:18:19 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28FEFC08E862
        for <git@vger.kernel.org>; Thu,  3 Dec 2020 08:17:10 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id t4so2428016wrr.12
        for <git@vger.kernel.org>; Thu, 03 Dec 2020 08:17:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=+k5IPhjnFps1bPQ+fZLXw1kxy5QJksAzxhHBKv4+0wQ=;
        b=btTNDGsNqFyQ8exz7GIc7lWRJ9+Kt9+Pwf/utN4PbFAz/+YR/O4o2/gsUjAtWJrNOH
         OAMPyIsW1X2PvFYYfH5gFuZfNpaeF9h2KE1ZFbNovzdbzlazfNsdGizSw7Ep6zRzE3WX
         1m6EOsZEHhpKsGrWqemnproManV2nb0vO2p4f6pMYMSDHP8VtuIZWFkgYeqXGJdDib03
         8grmOnodW2/uJ1+oe+IIy+nTEnoqoi5599PRhjvlP44mjSNkDnL6fHmQ4mDyNbnKOYdK
         cEWTwpVn2q6t7kym/FXiJMDVTNgh7tZ+2Mby+Ixy54vcNtO4CRQ6i5B6npyF0z4SrtVA
         JB8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=+k5IPhjnFps1bPQ+fZLXw1kxy5QJksAzxhHBKv4+0wQ=;
        b=bvRCFs176dLjKAvc4bnAnF+m4bwm3r+QDTZBsV8FThDlfqSE2jDytqbxKRG1smuMq5
         doICdmW7hVNdk42BY1MRvI2VDhanXOmfEcSB1jWgNnjGDj1EsTGwAvmKcwsgLKZnJoJk
         4AwfGAHc/a81zUmGe8abCRx1ohzVhcHAVOsF/YFICQayIRfttitTiUQhH1apQ2Gg03fY
         AHtp9xlLc/jImn1X0JQgxAUvw6vzbOidgL10a8/KGfA1oXhFBKj52tFAJs3q3iybK84M
         m9NDmA2X6nRJwbVgBMd63guBzDkgOdhNU6uEG44LTVGlAGxaWj5DVTt0kIacvdVWcasI
         Aiqg==
X-Gm-Message-State: AOAM532HpZyECgWBxVHDRrpsyDjG+GDfBfiHH8NGGJ5LYWsRHxILo0zN
        Zn7paf4xM0d6npZ+umuIzarHFkvV5HU=
X-Google-Smtp-Source: ABdhPJy7cxIKdjJD4G/kJzz0WTtoRcJJwD6pc8Fbn5vsW2NVNssXbsXwBfv4oTgX+IybJB6Z0qFp6Q==
X-Received: by 2002:adf:94c3:: with SMTP id 61mr4555113wrr.143.1607012228513;
        Thu, 03 Dec 2020 08:17:08 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f23sm1883008wmb.43.2020.12.03.08.17.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Dec 2020 08:17:08 -0800 (PST)
Message-Id: <03f3255c8f4a953065b2ff8e61816f83534c23ed.1607012215.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.804.git.1607012215.gitgitgadget@gmail.com>
References: <pull.804.git.1607012215.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 03 Dec 2020 16:16:51 +0000
Subject: [PATCH 12/15] chunk-format: create write_chunks()
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

The commit-graph and multi-pack-index files both use a chunk-based file
format. They have already unified on using write_table_of_contents(),
but we expand upon that by unifying their chunk writing loop.

This takes the concepts already present in the commit-graph that were
dropped in the multi-pack-index code during refactoring, including:

* Check the hashfile for how much data was written by each write_fn.

* Allow write_fn() to report an error that results in a failure
  without using die() in the low-level commands.

This simplifies the code in commit-graph.c and midx.c while laying the
foundation for future formats using similar ideas.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 chunk-format.c | 23 +++++++++++++++++++++++
 chunk-format.h | 13 +++++++++++++
 commit-graph.c | 13 ++-----------
 midx.c         |  3 +--
 4 files changed, 39 insertions(+), 13 deletions(-)

diff --git a/chunk-format.c b/chunk-format.c
index 771b6d98d0..a6643a4fc8 100644
--- a/chunk-format.c
+++ b/chunk-format.c
@@ -24,3 +24,26 @@ void write_table_of_contents(struct hashfile *f,
 	hashwrite_be32(f, 0);
 	hashwrite_be64(f, cur_offset);
 }
+
+int write_chunks(struct hashfile *f,
+		 struct chunk_info *chunks,
+		 int nr,
+		 void *data)
+{
+	int i;
+
+	for (i = 0; i < nr; i++) {
+		uint64_t start_offset = f->total + f->offset;
+		int result = chunks[i].write_fn(f, data);
+
+		if (result)
+			return result;
+
+		if (f->total + f->offset != start_offset + chunks[i].size)
+			BUG("expected to write %"PRId64" bytes to chunk %"PRIx32", but wrote %"PRId64" instead",
+			    chunks[i].size, chunks[i].id,
+			    f->total + f->offset - start_offset);
+	}
+
+	return 0;
+}
diff --git a/chunk-format.h b/chunk-format.h
index 4b9cbeb372..a2c7ddb23b 100644
--- a/chunk-format.h
+++ b/chunk-format.h
@@ -33,4 +33,17 @@ void write_table_of_contents(struct hashfile *f,
 			     struct chunk_info *chunks,
 			     int nr);
 
+/*
+ * Write the data for the given chunk list using the provided
+ * write_fn values. The given 'data' parameter is passed to those
+ * methods.
+ *
+ * The data that is written by each write_fn is checked to be of
+ * the expected size, and a BUG() is thrown if not specified correctly.
+ */
+int write_chunks(struct hashfile *f,
+		 struct chunk_info *chunks,
+		 int nr,
+		 void *data);
+
 #endif
diff --git a/commit-graph.c b/commit-graph.c
index 5494fda1d3..10dcef9d6b 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -1809,17 +1809,8 @@ static int write_commit_graph_file(struct write_commit_graph_context *ctx)
 			num_chunks * ctx->commits.nr);
 	}
 
-	for (i = 0; i < num_chunks; i++) {
-		uint64_t start_offset = f->total + f->offset;
-
-		if (chunks[i].write_fn(f, ctx))
-			return -1;
-
-		if (f->total + f->offset != start_offset + chunks[i].size)
-			BUG("expected to write %"PRId64" bytes to chunk %"PRIx32", but wrote %"PRId64" instead",
-			    chunks[i].size, chunks[i].id,
-			    f->total + f->offset - start_offset);
-	}
+	if (write_chunks(f, chunks, num_chunks, ctx))
+		return -1;
 
 	stop_progress(&ctx->progress);
 	strbuf_release(&progress_title);
diff --git a/midx.c b/midx.c
index 47f5f60fcd..67ac232a81 100644
--- a/midx.c
+++ b/midx.c
@@ -957,8 +957,7 @@ static int write_midx_internal(const char *object_dir, struct multi_pack_index *
 
 	write_table_of_contents(f, header_size, chunks, num_chunks);
 
-	for (i = 0; i < num_chunks; i++)
-		chunks[i].write_fn(f, &ctx);
+	result = write_chunks(f, chunks, num_chunks, &ctx);
 
 	finalize_hashfile(f, NULL, CSUM_FSYNC | CSUM_HASH_IN_STREAM);
 	commit_lock_file(&lk);
-- 
gitgitgadget

