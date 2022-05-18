Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76287C433F5
	for <git@archiver.kernel.org>; Wed, 18 May 2022 23:12:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231394AbiERXL6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 May 2022 19:11:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231156AbiERXLF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 May 2022 19:11:05 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24980E00D
        for <git@vger.kernel.org>; Wed, 18 May 2022 16:11:03 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id r27so4052192iot.1
        for <git@vger.kernel.org>; Wed, 18 May 2022 16:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hbjZya/lcmOcKNQZnKnTdQ7PP9mvuviLGWXtq/9S3xc=;
        b=3gzgmjVyZP5HLzIpuHwkdkjObH5qMil/SNNLmg6NWeuzDqJFpXWs8RFLG1yuVKbXzC
         vS828sT4mySeV7i9WcbEtAg5r+9lSmdEP44FNO2zPh8T9qZtU7LNLgV+ia6vAA9LH6Xq
         LNIR5Dnm0Jf8fiHwaarQEBD9syURKFQjK1LWHVuvSCjqiZf2oT2oq9RzECWMb/11FZ9t
         19fOWAaRuXfqQnljA7aTCuT+Okcx3hvxXwzP9VpxWHW1bhnw9oJbFBNkn1a+jcZMkis1
         4RFp6gf6uGkvT0mo07vz3zez/Z1+drZSwrynzx5DaYX8SspXeyxUrHXpFTJ6lqq6docL
         n22g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hbjZya/lcmOcKNQZnKnTdQ7PP9mvuviLGWXtq/9S3xc=;
        b=OfLPIpXMe5b9mQgW7hNcPGwZGQqQfCXqNKfhba+0coTJ5pVBuXKuMuX2WD3g4gEzIy
         DFUBolMF8G4/KeSJBgYVx6nFzJKZu6k0TuAz5iZ4ngALXIj+4tfq19UF7Xp2mrtBIKO3
         SfuC0atWMQr0SRhmkINlF9kh4+3ggvX6NMoot4tIheWOkm+SmgnPew1h1EAklvYjHOlY
         cgnzmrk9DBcddsnUClkzA+m/UZ0mp54YvJeb+t7DJGQuY1T/Gzmqpk22nz9B4yWgpHQP
         Iqp8ui6g7vsl32ar43ORqV707RB++DmcmV23a1M0Klc6pA0aoMuaxt8uEC+s9TrdzvLX
         h+9w==
X-Gm-Message-State: AOAM533fYnoo2Z/cnlU4ZD9AXRLPqY4Z5tU1KZz5r4FLV/iB4scEIoZp
        7GmOhIjCpC4GQkUnKMJ9EQfxUsopHnmUifZK
X-Google-Smtp-Source: ABdhPJwi8mxgj7WM579RnoRZNINqgYrCVNCK/14bzrnOg5w7R7hD00Ym5O2QeqLCajAmD32bxabEpA==
X-Received: by 2002:a05:6602:2d0e:b0:64f:d1ff:ac9c with SMTP id c14-20020a0566022d0e00b0064fd1ffac9cmr1015592iow.41.1652915462378;
        Wed, 18 May 2022 16:11:02 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id g22-20020a022716000000b0032b3a781797sm233415jaa.91.2022.05.18.16.11.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 May 2022 16:11:02 -0700 (PDT)
Date:   Wed, 18 May 2022 19:11:01 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, derrickstolee@github.com, gitster@pobox.com,
        jrnieder@gmail.com, larsxschneider@gmail.com, tytso@mit.edu
Subject: [PATCH v4 04/17] chunk-format.h: extract oid_version()
Message-ID: <1d775f9850f00b0c3d1e9133669a6365c8d7bbba.1652915424.git.me@ttaylorr.com>
References: <cover.1638224692.git.me@ttaylorr.com>
 <cover.1652915424.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1652915424.git.me@ttaylorr.com>
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

