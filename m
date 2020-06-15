Return-Path: <SRS0=FGj8=74=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E1F0C433E1
	for <git@archiver.kernel.org>; Mon, 15 Jun 2020 20:15:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F15F8207D4
	for <git@archiver.kernel.org>; Mon, 15 Jun 2020 20:15:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t5mzNmLS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730275AbgFOUPA (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Jun 2020 16:15:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729983AbgFOUO7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Jun 2020 16:14:59 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A059C08C5C2
        for <git@vger.kernel.org>; Mon, 15 Jun 2020 13:14:58 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id j10so18443950wrw.8
        for <git@vger.kernel.org>; Mon, 15 Jun 2020 13:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=s8E4k7jePfVF6rH/auGpW6njtkY9UpgcNvHN76dZGgc=;
        b=t5mzNmLS/dHfognrotHWOnpjIO500OUSZ0Ph31N43ppyi9HZ1GEnbHdTczVl7H65jR
         anU4GwgiFtrKQWq7DGGDBFDaov8w7iiPkdtjPzUG1qCsf7TmbVSQIgN3gyikBFuiUBfl
         zke4dSZ9naKta/Zm6J0TaiZsOOWQxdl5YjpnA5W5pwqdVHohk7esd66HsurYPS4eTsIQ
         TkwXbxRjWykPgXy/EunyDhxrBgNmMNk0Kcfg9qsgB7+nv9sE6RRjcgek9ak0QFez6+eR
         qeHcqnr8zVA75885HjnBZfQGyUIuXsQO3LaCnjIBIenViqrohrxNBHRwNmCJtlQXePIN
         9sfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=s8E4k7jePfVF6rH/auGpW6njtkY9UpgcNvHN76dZGgc=;
        b=agPRWegye3kICuXs24JLTdX/Jg6X+OQZ9CrAjoHRgScEjpgxqrlz+t+DodjXD+GBbn
         hd0ucFxcaI+nGpV1JXuYZkTFnys0k1xeoFDL9ZT1fSagrVcRupSPP1FwU1mC1mVvXtfT
         4LxZV7z9NVZPT/hqf63/bxl6Avn6APf/AJyyz8FeYB+5U//BDzvCLDvf0DQpzaY6ICmV
         vNOhxrcjD+xrTu3s9T5UQM65ED/MrJW0Be/gNPD8I13imwpRixyxGnMoUYLuqp/IYt9P
         Zo376s0mAcPYZHYf9OE+jhvak3X3njWNmUmZ+udESP7ccxIYI2hS+Pzra7v5Z8TuRXzj
         Nr0Q==
X-Gm-Message-State: AOAM530n97MR6tmyBvp68jFcLbrKoQLaZK6A8nX8sr5duaZ7x62pkzxF
        me+S+cNLcs1hhzltyJYVoNYB95uU
X-Google-Smtp-Source: ABdhPJxL4/8X/pRB2afaBoLWgUPVd9YXaBhrD2ihP9oQKdfk3mhw5cj8KJZy2m+ZSi9ghAsczcHUew==
X-Received: by 2002:adf:fd81:: with SMTP id d1mr31319020wrr.96.1592252096573;
        Mon, 15 Jun 2020 13:14:56 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u74sm804880wmu.31.2020.06.15.13.14.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 13:14:56 -0700 (PDT)
Message-Id: <65eb15221c8d3b631d6d7105d0e901433bc7f23b.1592252093.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.659.git.1592252093.gitgitgadget@gmail.com>
References: <pull.659.git.1592252093.gitgitgadget@gmail.com>
From:   "=?UTF-8?q?SZEDER=20G=C3=A1bor?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Mon, 15 Jun 2020 20:14:47 +0000
Subject: [PATCH 2/8] commit-graph: unify the signatures of all
 write_graph_chunk_*() functions
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     me@ttaylorr.com, szeder.dev@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>

Update the write_graph_chunk_*() helper functions to have the same
signature:

  - Return an int error code from all these functions.
    write_graph_chunk_base() already has an int error code, now the
    others will have one, too, but since they don't indicate any
    error, they will always return 0.

  - Drop the hash size parameter of write_graph_chunk_oids() and
    write_graph_chunk_data(); its value can be read directly from
    'the_hash_algo' inside these functions as well.

This opens up the possibility for further cleanups and foolproofing in
the following two patches.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 commit-graph.c | 42 ++++++++++++++++++++++++++----------------
 1 file changed, 26 insertions(+), 16 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index 05b7035d8d5..3bae1e52ed0 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -885,8 +885,8 @@ struct write_commit_graph_context {
 	struct bloom_filter_settings bloom_settings;
 };
 
-static void write_graph_chunk_fanout(struct hashfile *f,
-				     struct write_commit_graph_context *ctx)
+static int write_graph_chunk_fanout(struct hashfile *f,
+				    struct write_commit_graph_context *ctx)
 {
 	int i, count = 0;
 	struct commit **list = ctx->commits.list;
@@ -907,17 +907,21 @@ static void write_graph_chunk_fanout(struct hashfile *f,
 
 		hashwrite_be32(f, count);
 	}
+
+	return 0;
 }
 
-static void write_graph_chunk_oids(struct hashfile *f, int hash_len,
-				   struct write_commit_graph_context *ctx)
+static int write_graph_chunk_oids(struct hashfile *f,
+				  struct write_commit_graph_context *ctx)
 {
 	struct commit **list = ctx->commits.list;
 	int count;
 	for (count = 0; count < ctx->commits.nr; count++, list++) {
 		display_progress(ctx->progress, ++ctx->progress_cnt);
-		hashwrite(f, (*list)->object.oid.hash, (int)hash_len);
+		hashwrite(f, (*list)->object.oid.hash, (int)the_hash_algo->rawsz);
 	}
+
+	return 0;
 }
 
 static const unsigned char *commit_to_sha1(size_t index, void *table)
@@ -926,8 +930,8 @@ static const unsigned char *commit_to_sha1(size_t index, void *table)
 	return commits[index]->object.oid.hash;
 }
 
-static void write_graph_chunk_data(struct hashfile *f, int hash_len,
-				   struct write_commit_graph_context *ctx)
+static int write_graph_chunk_data(struct hashfile *f,
+				  struct write_commit_graph_context *ctx)
 {
 	struct commit **list = ctx->commits.list;
 	struct commit **last = ctx->commits.list + ctx->commits.nr;
@@ -944,7 +948,7 @@ static void write_graph_chunk_data(struct hashfile *f, int hash_len,
 			die(_("unable to parse commit %s"),
 				oid_to_hex(&(*list)->object.oid));
 		tree = get_commit_tree_oid(*list);
-		hashwrite(f, tree->hash, hash_len);
+		hashwrite(f, tree->hash, the_hash_algo->rawsz);
 
 		parent = (*list)->parents;
 
@@ -1024,10 +1028,12 @@ static void write_graph_chunk_data(struct hashfile *f, int hash_len,
 
 		list++;
 	}
+
+	return 0;
 }
 
-static void write_graph_chunk_extra_edges(struct hashfile *f,
-					  struct write_commit_graph_context *ctx)
+static int write_graph_chunk_extra_edges(struct hashfile *f,
+					 struct write_commit_graph_context *ctx)
 {
 	struct commit **list = ctx->commits.list;
 	struct commit **last = ctx->commits.list + ctx->commits.nr;
@@ -1076,10 +1082,12 @@ static void write_graph_chunk_extra_edges(struct hashfile *f,
 
 		list++;
 	}
+
+	return 0;
 }
 
-static void write_graph_chunk_bloom_indexes(struct hashfile *f,
-					    struct write_commit_graph_context *ctx)
+static int write_graph_chunk_bloom_indexes(struct hashfile *f,
+					   struct write_commit_graph_context *ctx)
 {
 	struct commit **list = ctx->commits.list;
 	struct commit **last = ctx->commits.list + ctx->commits.nr;
@@ -1101,10 +1109,11 @@ static void write_graph_chunk_bloom_indexes(struct hashfile *f,
 	}
 
 	stop_progress(&progress);
+	return 0;
 }
 
-static void write_graph_chunk_bloom_data(struct hashfile *f,
-					 struct write_commit_graph_context *ctx)
+static int write_graph_chunk_bloom_data(struct hashfile *f,
+					struct write_commit_graph_context *ctx)
 {
 	struct commit **list = ctx->commits.list;
 	struct commit **last = ctx->commits.list + ctx->commits.nr;
@@ -1128,6 +1137,7 @@ static void write_graph_chunk_bloom_data(struct hashfile *f,
 	}
 
 	stop_progress(&progress);
+	return 0;
 }
 
 static int oid_compare(const void *_a, const void *_b)
@@ -1638,8 +1648,8 @@ static int write_commit_graph_file(struct write_commit_graph_context *ctx)
 			num_chunks * ctx->commits.nr);
 	}
 	write_graph_chunk_fanout(f, ctx);
-	write_graph_chunk_oids(f, hashsz, ctx);
-	write_graph_chunk_data(f, hashsz, ctx);
+	write_graph_chunk_oids(f, ctx);
+	write_graph_chunk_data(f, ctx);
 	if (ctx->num_extra_edges)
 		write_graph_chunk_extra_edges(f, ctx);
 	if (ctx->changed_paths) {
-- 
gitgitgadget

