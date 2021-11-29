Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38FA7C433F5
	for <git@archiver.kernel.org>; Mon, 29 Nov 2021 22:26:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230508AbhK2W3S (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Nov 2021 17:29:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230479AbhK2W2e (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Nov 2021 17:28:34 -0500
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96CF5C096769
        for <git@vger.kernel.org>; Mon, 29 Nov 2021 14:25:14 -0800 (PST)
Received: by mail-il1-x132.google.com with SMTP id i6so19174742ila.0
        for <git@vger.kernel.org>; Mon, 29 Nov 2021 14:25:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=iPke5so28RSZVwUj2SAqnBiW5+x6vrjLApQSr7jsQo4=;
        b=LptWoeGl3FeLrLTBaVv3wt6+wAGch3a/kk5BoB1YZF2XhLUzRtU0j9nrx0lSOVDgwv
         pCvdO+WewpFwsgWlw9XY+eAmVqVFtV3IoJlVA9qgt4QNcZJ25MOndi9upL9oQNPWRhhh
         gxD7toFsNaPp776GvCNYk7hdm5nVY/CTVgOc4FLB9y8tK5Oh7tMvtzILlc/zyqmkt6eZ
         E0HVuXNo5XGfsy7Ec449GqxfzKT3APYmhnJX8TAY3EM4BuGOX8SwfZkAVPvTyvMC1Ldj
         kyCLjFz3etm+vbtVZcRguKSftoKdIFdtU6UG3ipLHKewOzS0TPhAuQqlIq4jOOO052NF
         yOAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iPke5so28RSZVwUj2SAqnBiW5+x6vrjLApQSr7jsQo4=;
        b=MlxuwLcP6hs3QBSkjuySwMVot5EPBgNj9wmZLyR0KDVP77Pkors4HgPInoBJp7OfkX
         HuhRysNF9hPNVmD4oYXXeENvbTyJS6oYwxO2MO2RnTEY6Yn2qCZEdQLuyDkhPL1NWjUi
         a3VnZxdKcafLBO1fyS678rZb2lZJBopLcKNbfYV8i0y+R+v86dRz1zuPYzG+KZ+STB2o
         WD8yx69Y3Ee4d7jqSNRvpUG3AbLxmEILC4oUHGy6PWMnqcHe+BPPagUvEwvKmtwKuPYp
         GNUar5N3qjpVYOIqT9RjoNb4ct/peiwBuLZW5xtu2P+wJzoBdZeChAEWUnLC1wWHqpSL
         ytIg==
X-Gm-Message-State: AOAM533vGqi1qrjfgJomdR8Y5YiKzHiC57KeJD74K5o1VYXcZvp8n2Ol
        3Lm1AP8K0bryxLu5jbWlS3ozWKZbTrB23s7H
X-Google-Smtp-Source: ABdhPJwGqz4ClCIhAN7QLVMUptCa6AxGC2w+akV3NQWzbKjYUXeLAm27Y95+JtDtmp2DlwUAnAEWQg==
X-Received: by 2002:a92:c261:: with SMTP id h1mr37306694ild.162.1638224713938;
        Mon, 29 Nov 2021 14:25:13 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id r12sm8803873iln.72.2021.11.29.14.25.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 14:25:13 -0800 (PST)
Date:   Mon, 29 Nov 2021 17:25:13 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, larsxschneider@gmail.com, peff@peff.net,
        tytso@mit.edu
Subject: [PATCH 04/17] chunk-format.h: extract oid_version()
Message-ID: <ea245b7216067093fdd3a5b2e3a9390f634c8af0.1638224692.git.me@ttaylorr.com>
References: <cover.1638224692.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1638224692.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There are three definitions of an identical function which converts
`the_hash_algo` into either 1 (for SHA-1) or 2 (for SHA-256). There is a
copy of this function for writing both the commit-graph and
multi-pack-index file, and another inline definition used to write the
.rev header.

Consolidate these into a single definition in chunk-format.h. It's not
clear that this is the best header to define this function in, but it
should do for now.

(Worth noting, the .rev caller expects a 4-byte unsigned, but the other
two callers work with a single unsigned byte. The consolidated version
uses the latter type, and lets the compiler widen it when required).

Another caller will be added in a subsequent patch.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 chunk-format.c | 12 ++++++++++++
 chunk-format.h |  3 +++
 commit-graph.c | 18 +++---------------
 midx.c         | 18 +++---------------
 pack-write.c   | 15 ++-------------
 5 files changed, 23 insertions(+), 43 deletions(-)

diff --git a/chunk-format.c b/chunk-format.c
index 1c3dca62e2..0275b74a89 100644
--- a/chunk-format.c
+++ b/chunk-format.c
@@ -181,3 +181,15 @@ int read_chunk(struct chunkfile *cf,
 
 	return CHUNK_NOT_FOUND;
 }
+
+uint8_t oid_version(const struct git_hash_algo *algop)
+{
+	switch (hash_algo_by_ptr(algop)) {
+	case GIT_HASH_SHA1:
+		return 1;
+	case GIT_HASH_SHA256:
+		return 2;
+	default:
+		die(_("invalid hash version"));
+	}
+}
diff --git a/chunk-format.h b/chunk-format.h
index 9ccbe00377..7885aa0848 100644
--- a/chunk-format.h
+++ b/chunk-format.h
@@ -2,6 +2,7 @@
 #define CHUNK_FORMAT_H
 
 #include "git-compat-util.h"
+#include "hash.h"
 
 struct hashfile;
 struct chunkfile;
@@ -65,4 +66,6 @@ int read_chunk(struct chunkfile *cf,
 	       chunk_read_fn fn,
 	       void *data);
 
+uint8_t oid_version(const struct git_hash_algo *algop);
+
 #endif
diff --git a/commit-graph.c b/commit-graph.c
index 2706683acf..1f08152a35 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -193,18 +193,6 @@ char *get_commit_graph_chain_filename(struct object_directory *odb)
 	return xstrfmt("%s/info/commit-graphs/commit-graph-chain", odb->path);
 }
 
-static uint8_t oid_version(void)
-{
-	switch (hash_algo_by_ptr(the_hash_algo)) {
-	case GIT_HASH_SHA1:
-		return 1;
-	case GIT_HASH_SHA256:
-		return 2;
-	default:
-		die(_("invalid hash version"));
-	}
-}
-
 static struct commit_graph *alloc_commit_graph(void)
 {
 	struct commit_graph *g = xcalloc(1, sizeof(*g));
@@ -365,9 +353,9 @@ struct commit_graph *parse_commit_graph(struct repository *r,
 	}
 
 	hash_version = *(unsigned char*)(data + 5);
-	if (hash_version != oid_version()) {
+	if (hash_version != oid_version(the_hash_algo)) {
 		error(_("commit-graph hash version %X does not match version %X"),
-		      hash_version, oid_version());
+		      hash_version, oid_version(the_hash_algo));
 		return NULL;
 	}
 
@@ -1908,7 +1896,7 @@ static int write_commit_graph_file(struct write_commit_graph_context *ctx)
 	hashwrite_be32(f, GRAPH_SIGNATURE);
 
 	hashwrite_u8(f, GRAPH_VERSION);
-	hashwrite_u8(f, oid_version());
+	hashwrite_u8(f, oid_version(the_hash_algo));
 	hashwrite_u8(f, get_num_chunks(cf));
 	hashwrite_u8(f, ctx->num_commit_graphs_after - 1);
 
diff --git a/midx.c b/midx.c
index 8433086ac1..756ae6a206 100644
--- a/midx.c
+++ b/midx.c
@@ -40,18 +40,6 @@
 
 #define PACK_EXPIRED UINT_MAX
 
-static uint8_t oid_version(void)
-{
-	switch (hash_algo_by_ptr(the_hash_algo)) {
-	case GIT_HASH_SHA1:
-		return 1;
-	case GIT_HASH_SHA256:
-		return 2;
-	default:
-		die(_("invalid hash version"));
-	}
-}
-
 const unsigned char *get_midx_checksum(struct multi_pack_index *m)
 {
 	return m->data + m->data_len - the_hash_algo->rawsz;
@@ -131,9 +119,9 @@ struct multi_pack_index *load_multi_pack_index(const char *object_dir, int local
 		      m->version);
 
 	hash_version = m->data[MIDX_BYTE_HASH_VERSION];
-	if (hash_version != oid_version()) {
+	if (hash_version != oid_version(the_hash_algo)) {
 		error(_("multi-pack-index hash version %u does not match version %u"),
-		      hash_version, oid_version());
+		      hash_version, oid_version(the_hash_algo));
 		goto cleanup_fail;
 	}
 	m->hash_len = the_hash_algo->rawsz;
@@ -413,7 +401,7 @@ static size_t write_midx_header(struct hashfile *f,
 {
 	hashwrite_be32(f, MIDX_SIGNATURE);
 	hashwrite_u8(f, MIDX_VERSION);
-	hashwrite_u8(f, oid_version());
+	hashwrite_u8(f, oid_version(the_hash_algo));
 	hashwrite_u8(f, num_chunks);
 	hashwrite_u8(f, 0); /* unused */
 	hashwrite_be32(f, num_packs);
diff --git a/pack-write.c b/pack-write.c
index d594e3008e..ff305b404c 100644
--- a/pack-write.c
+++ b/pack-write.c
@@ -2,6 +2,7 @@
 #include "pack.h"
 #include "csum-file.h"
 #include "remote.h"
+#include "chunk-format.h"
 
 void reset_pack_idx_option(struct pack_idx_option *opts)
 {
@@ -181,21 +182,9 @@ static int pack_order_cmp(const void *va, const void *vb, void *ctx)
 
 static void write_rev_header(struct hashfile *f)
 {
-	uint32_t oid_version;
-	switch (hash_algo_by_ptr(the_hash_algo)) {
-	case GIT_HASH_SHA1:
-		oid_version = 1;
-		break;
-	case GIT_HASH_SHA256:
-		oid_version = 2;
-		break;
-	default:
-		die("write_rev_header: unknown hash version");
-	}
-
 	hashwrite_be32(f, RIDX_SIGNATURE);
 	hashwrite_be32(f, RIDX_VERSION);
-	hashwrite_be32(f, oid_version);
+	hashwrite_be32(f, oid_version(the_hash_algo));
 }
 
 static void write_rev_index_positions(struct hashfile *f,
-- 
2.34.1.25.gb3157a20e6

