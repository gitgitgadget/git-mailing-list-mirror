Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42D46C433F5
	for <git@archiver.kernel.org>; Fri, 20 May 2022 23:18:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354035AbiETXR5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 May 2022 19:17:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354045AbiETXRw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 May 2022 19:17:52 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C7B51A15F8
        for <git@vger.kernel.org>; Fri, 20 May 2022 16:17:43 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id y15so4592034qtx.4
        for <git@vger.kernel.org>; Fri, 20 May 2022 16:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hbjZya/lcmOcKNQZnKnTdQ7PP9mvuviLGWXtq/9S3xc=;
        b=uSqBhBuH7JCBkN6L4sSNHIAHExllcITXwU1oFmOm3qglfoec2weHLG9w96Z+RYBgzO
         pip+UPhntj160V6ePlXp90ohb1ZqEDU8WeSnWU5FT55B9RNAZ4Oai3MNFWoHuUKePr/A
         N+piSEV/ZEx56AVwgHrjujVNa44OvTZoymf+M8NP5SLw7DjoCrVVFrTFGEY6ima7UPK+
         9Ro/T0XfzGOiAquKH2dn1agz02BqnKuYZFGMB19DHzvtPN1RI1iGLKTZroSkJRgibISd
         on96JcEqWQu4MeTOhiVBcHKaVw32o0ft9rNiSz80WESidvl2uymTE1jVpxylm4x5qFqU
         x5oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hbjZya/lcmOcKNQZnKnTdQ7PP9mvuviLGWXtq/9S3xc=;
        b=m0NpooJw2BCP+Q5oO5ElZhJ262sf98QQuDXC5hY/v6TY0wToPP2OePzXI9y4t59Irk
         lpObqx5F06q+ZYAu9RkjkvvD2HXv4NJsB1AkU56rwFI7k/sg2MU7jBIY+4ovXMn55NIC
         RYftkMeZg/DUoAEXYKsBz5BUnFPH6R7dZQScleMpk707P3A0PVuNwFUnnDnlUz0a/HHb
         l9T/iqDBSUkk68KpyLz1xWh1+1jQmyxHXKR5M1i6fb00EwZWzjuoibKuAf2KZJBe+/Rw
         Fa1cXinGM0HfJMDp9I+TKo8vy2DZyzbdxQNCPBxnseEX8aKImIouj8cgsBxdgg2aRntI
         cDwQ==
X-Gm-Message-State: AOAM532qRD9ZbQuFcZHBJQqmFydw54Y3waWskyz0z4mfwQfNhqW73kor
        Rggu6JPS/zKQUYcgmB7/t/PQF2zFkAkicc7p
X-Google-Smtp-Source: ABdhPJzknmRkgxoSy5RJQQf4OOYQDnu7KAiT2Fb5db3I4NENKwjKYKwMIJPwtBtud4B5CypVbfjd1w==
X-Received: by 2002:a05:622a:1489:b0:2f3:e404:f707 with SMTP id t9-20020a05622a148900b002f3e404f707mr9395922qtx.414.1653088662391;
        Fri, 20 May 2022 16:17:42 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 10-20020ac84e8a000000b002f39b99f69asm555626qtp.52.2022.05.20.16.17.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 16:17:42 -0700 (PDT)
Date:   Fri, 20 May 2022 19:17:41 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, derrickstolee@github.com, gitster@pobox.com,
        jrnieder@gmail.com, larsxschneider@gmail.com, tytso@mit.edu
Subject: [PATCH v5 04/17] chunk-format.h: extract oid_version()
Message-ID: <fc8650688193d5cf519281bf4ad4528f86e4abe1.1653088640.git.me@ttaylorr.com>
References: <cover.1638224692.git.me@ttaylorr.com>
 <cover.1653088640.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1653088640.git.me@ttaylorr.com>
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
index 06107beedc..066d82ed6a 100644
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
 
@@ -1924,7 +1912,7 @@ static int write_commit_graph_file(struct write_commit_graph_context *ctx)
 	hashwrite_be32(f, GRAPH_SIGNATURE);
 
 	hashwrite_u8(f, GRAPH_VERSION);
-	hashwrite_u8(f, oid_version());
+	hashwrite_u8(f, oid_version(the_hash_algo));
 	hashwrite_u8(f, get_num_chunks(cf));
 	hashwrite_u8(f, ctx->num_commit_graphs_after - 1);
 
diff --git a/midx.c b/midx.c
index 3db0e47735..c617c51cd0 100644
--- a/midx.c
+++ b/midx.c
@@ -41,18 +41,6 @@
 
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
@@ -134,9 +122,9 @@ struct multi_pack_index *load_multi_pack_index(const char *object_dir, int local
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
@@ -420,7 +408,7 @@ static size_t write_midx_header(struct hashfile *f,
 {
 	hashwrite_be32(f, MIDX_SIGNATURE);
 	hashwrite_u8(f, MIDX_VERSION);
-	hashwrite_u8(f, oid_version());
+	hashwrite_u8(f, oid_version(the_hash_algo));
 	hashwrite_u8(f, num_chunks);
 	hashwrite_u8(f, 0); /* unused */
 	hashwrite_be32(f, num_packs);
diff --git a/pack-write.c b/pack-write.c
index a2adc565f4..27b171e440 100644
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
2.36.1.94.gb0d54bedca

