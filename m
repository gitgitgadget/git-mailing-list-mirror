Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1CB3C433EF
	for <git@archiver.kernel.org>; Thu,  3 Mar 2022 00:21:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230223AbiCCAVn (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Mar 2022 19:21:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230225AbiCCAVj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Mar 2022 19:21:39 -0500
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82816F1E84
        for <git@vger.kernel.org>; Wed,  2 Mar 2022 16:20:54 -0800 (PST)
Received: by mail-qk1-x731.google.com with SMTP id v5so2765193qkj.4
        for <git@vger.kernel.org>; Wed, 02 Mar 2022 16:20:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LtC0Ec4kYzTlFC8i2zTuZ0qokyxmwms48N+ucsIWL1Y=;
        b=VBEU3mxpuUI1JYm2cYENHc2BLnaOFRWs5lf0r/+WEALlfyb+p2n6pm4r+w3gHDU2Jw
         fthkPCFbxeAxb0sBa5T4RrqhaLNVCldP+66nt6ZqllqOlldhQ69YNhKQ+0UAPaaN0w60
         FJ2tmBxg5WfZc3dt0F/zdWLzFXojob39HbbJDbk9TBjJCMwbdfpIX+Ep8y3Bb8nLd1QU
         TiSkVA4eJmU8qvBkCWdu28Q7FQy6iJiBhyGdEeM7W/zGZbmjwjLgSlziPEMHwv/hmlPA
         Ck6s1ADNoMcjtVNRytV/oZumo10uTSoVHfhinSGIUqfbcVBa0g0ZzkzTOpPLwjecQ2Ci
         2xAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LtC0Ec4kYzTlFC8i2zTuZ0qokyxmwms48N+ucsIWL1Y=;
        b=WFsfQx533SyEsqrf3ygwfYXlNmR0+IwkzVuDffRw0W3lyXt5ziGjoIQYoEP5yAojRK
         Vk+/JHrgDzn1UNpgPJVqsd9uJ10YGLz3IZWn8QSqf5jX96T73ihDig6fDTMTNFbDN96+
         7F3PUrfVxjq06vcVIHAcUgOpRKp4hQRwUvC8zB91s4TzQU72Zwfrg9FbMDeqf7gaME79
         Q42cG0Ht1z3ViWQ/PNOfmHpAMVobUA7xkOq8aN4GvCT+kNaPZn7/LluB9wbPjR6Z1s2h
         NvA/WQlNBdit9AhrOt9HmPg1XX+Pfvplgw1zuV/Ei8k+YlZUt2myF2OenssnRTHvPxWI
         ntNQ==
X-Gm-Message-State: AOAM53089hHSMNMlLm3RudkHDfAA49GRYHfyrt3IlFqHQhBphzA/r6wb
        ldwC089AEr5l0QIAL9RuroM2mfst5C+DKAVc
X-Google-Smtp-Source: ABdhPJzeNP4KVm+oe8zaf3GIMz2xVqgHT8e9+V2y8YUwkwkX2qOtJyD7zGvCdNZDPGCCvZazbFW8mA==
X-Received: by 2002:a37:bcf:0:b0:60d:ed93:67a1 with SMTP id 198-20020a370bcf000000b0060ded9367a1mr17886167qkl.548.1646266853411;
        Wed, 02 Mar 2022 16:20:53 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id a8-20020a05622a064800b002dd4f1eccc3sm387407qtb.35.2022.03.02.16.20.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 16:20:53 -0800 (PST)
Date:   Wed, 2 Mar 2022 19:20:52 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     tytso@mit.edu, derrickstolee@github.com, gitster@pobox.com,
        larsxschneider@gmail.com
Subject: [PATCH v3 04/17] chunk-format.h: extract oid_version()
Message-ID: <135a07276b0a40b04f2c28d4f48c26b1af76c12c.1646266835.git.me@ttaylorr.com>
References: <cover.1638224692.git.me@ttaylorr.com>
 <cover.1646266835.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1646266835.git.me@ttaylorr.com>
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
index 265c010122..f678d2c4a1 100644
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
 
@@ -1911,7 +1899,7 @@ static int write_commit_graph_file(struct write_commit_graph_context *ctx)
 	hashwrite_be32(f, GRAPH_SIGNATURE);
 
 	hashwrite_u8(f, GRAPH_VERSION);
-	hashwrite_u8(f, oid_version());
+	hashwrite_u8(f, oid_version(the_hash_algo));
 	hashwrite_u8(f, get_num_chunks(cf));
 	hashwrite_u8(f, ctx->num_commit_graphs_after - 1);
 
diff --git a/midx.c b/midx.c
index 865170bad0..65e670c5e2 100644
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
2.35.1.73.gccc5557600

