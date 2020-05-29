Return-Path: <SRS0=mJAO=7L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8C2BC433E1
	for <git@archiver.kernel.org>; Fri, 29 May 2020 08:51:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96CB7207BC
	for <git@archiver.kernel.org>; Fri, 29 May 2020 08:51:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BuNCFk1e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726893AbgE2IvV (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 May 2020 04:51:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726451AbgE2IvR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 May 2020 04:51:17 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8C16C03E969
        for <git@vger.kernel.org>; Fri, 29 May 2020 01:51:16 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id f5so2446108wmh.2
        for <git@vger.kernel.org>; Fri, 29 May 2020 01:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1TeN09yRt1/4eMt06pjBn+7kZntign7fMUBusi+VkRU=;
        b=BuNCFk1eD8ZwH4ggbvN9D/D8uXNYRfzdbroFBRhTbsJNo1mOj6+yWJ/zMo+kAf9qJ5
         v/56UK51asXIczuW0WtCZwYkrBU3+9AIJueXb8ZoL8KBuIcVsCTmogPEyYVAwA19QE5c
         0Sw6Jq8/6LyaRVwMDGRwyofApJIa+XquDbI+EQwvscjnf7Qw1sG0cr+sOBZoaRQG/hZr
         1geSrn5zbOPl71GKdTolr4WH4w8/kZqyAtO9N26ZDUKTlSFvr9DS7taUkxaN5hd/nyVT
         jVfRRSwutCucJ5nnB4qujPNprMge7LA4Go0BMBLdGhCagpuaKdGidVibqEMT3XHhNiM1
         yi4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1TeN09yRt1/4eMt06pjBn+7kZntign7fMUBusi+VkRU=;
        b=PBjqC3B1zNTOewagydT3NXHAyIl+ETGNPfgvuHmlgoKtpM+XrngbncCaLUc0JHPoZE
         ZQeKcN8W8DdGRfoi+mwLbtQGCq3BhGttjcqIgBylBOFP96A+fXLbziDbMR4C9Lu8Eb28
         oQBIdOJGJ6Q8NXgvZvTYUxrz1Ub3xr5v7a9ltApbxv7d89hAPksvIJZMTbGoRqAFCE01
         b3VzwW+72Jge51E4o+cFgOvzdVNmUYrqaQIHpcaVNzNTXyhYjigQH5Y0Acrl1fGDHZ4s
         69GYEzI6t6yvHDMjWYXVY7YmbgN1WDIJesctQmboWuw+h/xNQYPFFyRfbvHCMPzYn1qV
         f2sA==
X-Gm-Message-State: AOAM5332J/0qEOQn460ThWB8kbna1xt8s6dbKUZMMNN8sVKcB7H7q3P6
        rpvvqSedVMdGKcs9LhYuibszbuaH
X-Google-Smtp-Source: ABdhPJzgjVLqpL1kwjHzrK09KQF1BjIQ+fmj8S8gs+j++ViqjqSDe4H2rrYqPrK28U+7lZ5+R3wUxw==
X-Received: by 2002:a1c:df57:: with SMTP id w84mr7985604wmg.52.1590742275085;
        Fri, 29 May 2020 01:51:15 -0700 (PDT)
Received: from localhost.localdomain (84-236-109-105.pool.digikabel.hu. [84.236.109.105])
        by smtp.gmail.com with ESMTPSA id f11sm3525255wrj.2.2020.05.29.01.51.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 May 2020 01:51:14 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Garima Singh <garima.singh@microsoft.com>,
        Derrick Stolee <stolee@gmail.com>,
        Jakub Narebski <jnareb@gmail.com>, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 12/34] commit-graph: unify the signatures of all write_graph_chunk_*() functions
Date:   Fri, 29 May 2020 10:50:16 +0200
Message-Id: <20200529085038.26008-13-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.27.0.rc1.431.g5c813f95dc
In-Reply-To: <20200529085038.26008-1-szeder.dev@gmail.com>
References: <20200529085038.26008-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

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
---
 commit-graph.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index c8ba17e457..33e70bdfea 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -793,7 +793,7 @@ struct write_commit_graph_context {
 	const struct split_commit_graph_opts *split_opts;
 };
 
-static void write_graph_chunk_fanout(struct hashfile *f,
+static int write_graph_chunk_fanout(struct hashfile *f,
 				     struct write_commit_graph_context *ctx)
 {
 	int i, count = 0;
@@ -815,17 +815,19 @@ static void write_graph_chunk_fanout(struct hashfile *f,
 
 		hashwrite_be32(f, count);
 	}
+	return 0;
 }
 
-static void write_graph_chunk_oids(struct hashfile *f, int hash_len,
+static int write_graph_chunk_oids(struct hashfile *f,
 				   struct write_commit_graph_context *ctx)
 {
 	struct commit **list = ctx->commits.list;
 	int count;
 	for (count = 0; count < ctx->commits.nr; count++, list++) {
 		display_progress(ctx->progress, ++ctx->progress_cnt);
-		hashwrite(f, (*list)->object.oid.hash, (int)hash_len);
+		hashwrite(f, (*list)->object.oid.hash, the_hash_algo->rawsz);
 	}
+	return 0;
 }
 
 static const unsigned char *commit_to_sha1(size_t index, void *table)
@@ -834,7 +836,7 @@ static const unsigned char *commit_to_sha1(size_t index, void *table)
 	return commits[index]->object.oid.hash;
 }
 
-static void write_graph_chunk_data(struct hashfile *f, int hash_len,
+static int write_graph_chunk_data(struct hashfile *f,
 				   struct write_commit_graph_context *ctx)
 {
 	struct commit **list = ctx->commits.list;
@@ -852,7 +854,7 @@ static void write_graph_chunk_data(struct hashfile *f, int hash_len,
 			die(_("unable to parse commit %s"),
 				oid_to_hex(&(*list)->object.oid));
 		tree = get_commit_tree_oid(*list);
-		hashwrite(f, tree->hash, hash_len);
+		hashwrite(f, tree->hash, the_hash_algo->rawsz);
 
 		parent = (*list)->parents;
 
@@ -932,9 +934,10 @@ static void write_graph_chunk_data(struct hashfile *f, int hash_len,
 
 		list++;
 	}
+	return 0;
 }
 
-static void write_graph_chunk_extra_edges(struct hashfile *f,
+static int write_graph_chunk_extra_edges(struct hashfile *f,
 					  struct write_commit_graph_context *ctx)
 {
 	struct commit **list = ctx->commits.list;
@@ -984,6 +987,7 @@ static void write_graph_chunk_extra_edges(struct hashfile *f,
 
 		list++;
 	}
+	return 0;
 }
 
 static int oid_compare(const void *_a, const void *_b)
@@ -1462,8 +1466,8 @@ static int write_commit_graph_file(struct write_commit_graph_context *ctx)
 			chunks_nr * ctx->commits.nr);
 	}
 	write_graph_chunk_fanout(f, ctx);
-	write_graph_chunk_oids(f, hashsz, ctx);
-	write_graph_chunk_data(f, hashsz, ctx);
+	write_graph_chunk_oids(f, ctx);
+	write_graph_chunk_data(f, ctx);
 	if (ctx->num_extra_edges)
 		write_graph_chunk_extra_edges(f, ctx);
 	if (ctx->num_commit_graphs_after > 1 &&
-- 
2.27.0.rc1.431.g5c813f95dc

