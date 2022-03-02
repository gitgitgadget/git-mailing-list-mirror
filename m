Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24F7AC433F5
	for <git@archiver.kernel.org>; Wed,  2 Mar 2022 00:58:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238836AbiCBA64 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Mar 2022 19:58:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238818AbiCBA6w (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Mar 2022 19:58:52 -0500
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B55A53E0D7
        for <git@vger.kernel.org>; Tue,  1 Mar 2022 16:58:09 -0800 (PST)
Received: by mail-il1-x12f.google.com with SMTP id w4so244493ilj.5
        for <git@vger.kernel.org>; Tue, 01 Mar 2022 16:58:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LtC0Ec4kYzTlFC8i2zTuZ0qokyxmwms48N+ucsIWL1Y=;
        b=bTF7WV3DJN4P+O/rYqUUM0YM4ZsE8aofSJLMYcCTH9IMS/e1/JyY3m6UN/lRVwS1rG
         DA0N5TM2D0n27c1Qcfu+qygBADYE8tGq4CxANXkBXPktpZ2fd6XCR/7IdYNBDlx4T/YD
         CiU+eREgAcAjPMV3lm8oB+nmCB7gTiAoKboP28hFItOjRUMehdxUF0f8AacmOnrKl0ho
         AGQp03ZwnffL1CjbTx36ctkMwCkZAQfWYO5splYqwy5NWeDGVInu5ffuup189Ib1PULt
         /C1bSkJ15M0OSH3EPZRTT8fw1QJtxN0BKYWdt8vkoBGuY5UJv1tssbwzIx3Tl4EDx9sW
         noDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LtC0Ec4kYzTlFC8i2zTuZ0qokyxmwms48N+ucsIWL1Y=;
        b=1DAWiB7FiaBbtuOuvlYjHGSPV7lY4qFaKcq2taKXihy5jzGf9HcmNRfk4fvIJVhiM2
         EcZIQ4SjIS8ycSRaXSnKd9Ry5uWDJjr1ykpBXg8YMBLKmKKM4dT6xmmMpEeFG30yNPpe
         ra3tqtjIQPEQBkeG1gNq9ekzDJ10vVhAdId1WExP2sfaZDyxgm9TV3kyg4LDBBe+u0uR
         FhJ6UV0TUyApiZu1NmlZvkSp2I/HCp0m4yGW2VkpmMsWRRDl/Zg6St9CVtLobo+wQBmJ
         UFCRIs0CeDDFh0rH73ptQQaaRHGCnD+p6fYlBdyxfEC9ASlXQUUhNqHB1uGPmBBRiUZA
         GKug==
X-Gm-Message-State: AOAM533AQVKJNzurE8etks6YhpLqX6XTmM8LJ0cefdINdkBofX2lnWgo
        zxMEgmVKrwAcydAQeRlNUWO84ltUk3QLJM/V
X-Google-Smtp-Source: ABdhPJzB2WICyGznhSJ5j11175jJaUcTgSPBicajsfyoBj/TJZtHyA1UJU7SHx3Du3xdIZS/WAXR1A==
X-Received: by 2002:a05:6e02:170f:b0:2c2:c247:b586 with SMTP id u15-20020a056e02170f00b002c2c247b586mr17387250ill.155.1646182688719;
        Tue, 01 Mar 2022 16:58:08 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id q5-20020a056e0220e500b002c5ba03f8eesm97252ilv.9.2022.03.01.16.58.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Mar 2022 16:58:08 -0800 (PST)
Date:   Tue, 1 Mar 2022 19:58:07 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     tytso@mit.edu, derrickstolee@github.com, gitster@pobox.com,
        larsxschneider@gmail.com
Subject: [PATCH v2 04/17] chunk-format.h: extract oid_version()
Message-ID: <1e0ed363ae93099444b6626ff0a2043e8d88771d.1646182671.git.me@ttaylorr.com>
References: <cover.1638224692.git.me@ttaylorr.com>
 <cover.1646182671.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1646182671.git.me@ttaylorr.com>
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

