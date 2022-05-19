Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FB82C433EF
	for <git@archiver.kernel.org>; Thu, 19 May 2022 11:42:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237511AbiESLmt (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 May 2022 07:42:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237488AbiESLmm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 May 2022 07:42:42 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F45FB227D
        for <git@vger.kernel.org>; Thu, 19 May 2022 04:42:41 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id o12-20020a1c4d0c000000b00393fbe2973dso4854736wmh.2
        for <git@vger.kernel.org>; Thu, 19 May 2022 04:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=o7UHd5YtUC95FIM39KieJXSgRJTptN/Ai290YGNG1zw=;
        b=MvXT+hmQtt8g4Pxtv9pZXmfU3FKHUD2eVs4s1n9el/Gyvg/f8jHateXcPW2kBmn3Zo
         tGw0V7Y3B7PnTDl12KcgzX1owYl2mwRgUZ2G7p5hAZi+6FxD0vi/bmDbmAbF4hxe9CFk
         9VkvXPydoyds+zRnF7mosDTU9mVGN3gM68os9r5vDRd2WZUYwQdtbMwdRmzlySL8PoYY
         9riHh4hpsm627Nn8KRuu2QtVgWWXr9rvr+ujOG2pcdGwF4BgmU0y4VUbr+XBpteiFALf
         POmpDsCmAJpeauA2qH31WAP/gIGDGavQhn5U9odeLNMAi/e0x/cFljN6P4oQQeKoU2Ef
         zO/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=o7UHd5YtUC95FIM39KieJXSgRJTptN/Ai290YGNG1zw=;
        b=MwA02Ba7wqzvNMWYNOTi3u7XQS+BLCAPzBenUMHK6o+V82Nuisv+x4o/4LQNM9VYAe
         YvSiKkVysZOpwU5VIkKQaEn5+b1uygGgu+3McDpI0K9EpMaVtiw0YoXnWUdg15MOh9F3
         HMhglEy2D8KKT3TsO2z1MdUh5/8Q6drD4LJqpfexepvs93KEBoXDKxP+tOHbyUFD8bsc
         FWM03Gmwp1mBQoI5mRR+hNH98O77cKhggAAEUC3XXB79hCryreJzRphLGgJ1Dx8qYJbA
         BLLGgxrkzIHw+Oau+RHE2tX+qOjt7BGA3VzLKvxFkUcgieyZFvxwO2Q608dLAS3SSw3B
         ol3g==
X-Gm-Message-State: AOAM533XE4CXqB7Wv5bx2ITlTZskdtuTMpV8+d11+80g+eXkLrrKqNj8
        bqU3bdZg+iTc4hC7QUSiAnNqzMlpLH6uJg==
X-Google-Smtp-Source: ABdhPJwa5eZmTLXSbuVYrDseqsf9PVBqcs+xzkpw/Pilb/2tUWfVvZJMCKwN9RpXItbq/z7jmYz30Q==
X-Received: by 2002:a1c:3587:0:b0:381:50ff:cbd with SMTP id c129-20020a1c3587000000b0038150ff0cbdmr3954071wma.140.1652960559299;
        Thu, 19 May 2022 04:42:39 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id f25-20020a1c6a19000000b003942a244f45sm6561984wmc.30.2022.05.19.04.42.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 04:42:38 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
        derrickstolee@github.com, jrnieder@gmail.com,
        larsxschneider@gmail.com, tytso@mit.edu,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC PATCH 2/2] hash API: add and use a hash_short_id_by_algo() function
Date:   Thu, 19 May 2022 13:42:28 +0200
Message-Id: <RFC-patch-2.2-051f0612ab9-20220519T113538Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.1.952.g6652f7f0e6b
In-Reply-To: <RFC-cover-0.2-00000000000-20220519T113538Z-avarab@gmail.com>
References: <cover.1652915424.git.me@ttaylorr.com> <RFC-cover-0.2-00000000000-20220519T113538Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add and use a hash_short_id_by_algo() function. As noted in the
comment being modified here (added in [1]) the intention wasn't to
have these end up in on-disk formats, but since [2], [3] and [3]
that's been the case, and there's an outstanding patch to add another
format that uses these[5].

So let's expose this functionality as a documented utility function,
instead of copy/pasting this code in various places.

Replacing the die() in the existing functions with a BUG() might be
overzelous, it's correct for the case of
e.g. write_commit_graph_file() and write_midx_header(), but we also
use this for parsing on-disk files, e.g. in parse_commit_graph().

We could add a "gently" version of this, but for now I think that
worrying about the distinction would be worrying too much. If we ever
end up parsing such files that'll almost certainly be a bug in our own
writing code, so the distinction would be rather academic, even though
such files could theoretically occur without a bug of ours.

1. f50e766b7b3 (Add structure representing hash algorithm, 2017-11-12)
2. 665d70ad033 (commit-graph: use the "hash version" byte, 2020-08-17)
3. d96075428a9 (multi-pack-index: use hash version byte, 2020-08-17)
4. 8ef50d9958f (pack-write.c: prepare to write 'pack-*.rev' files, 2021-01-25)
5. https://lore.kernel.org/git/1d775f9850f00b0c3d1e9133669a6365c8d7bbba.1652915424.git.me@ttaylorr.com/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 commit-graph.c | 18 +++---------------
 hash.h         | 26 ++++++++++++++++++++++++--
 midx.c         | 18 +++---------------
 pack-write.c   | 12 +-----------
 4 files changed, 31 insertions(+), 43 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index 06107beedcb..157de4dd717 100644
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
+	if (hash_version != hash_short_id_by_algo()) {
 		error(_("commit-graph hash version %X does not match version %X"),
-		      hash_version, oid_version());
+		      hash_version, hash_short_id_by_algo());
 		return NULL;
 	}
 
@@ -1924,7 +1912,7 @@ static int write_commit_graph_file(struct write_commit_graph_context *ctx)
 	hashwrite_be32(f, GRAPH_SIGNATURE);
 
 	hashwrite_u8(f, GRAPH_VERSION);
-	hashwrite_u8(f, oid_version());
+	hashwrite_u8(f, hash_short_id_by_algo());
 	hashwrite_u8(f, get_num_chunks(cf));
 	hashwrite_u8(f, ctx->num_commit_graphs_after - 1);
 
diff --git a/hash.h b/hash.h
index 5d40368f18a..31293401809 100644
--- a/hash.h
+++ b/hash.h
@@ -80,8 +80,7 @@ static inline void git_SHA256_Clone(git_SHA256_CTX *dst, const git_SHA256_CTX *s
 
 /*
  * Note that these constants are suitable for indexing the hash_algos array and
- * comparing against each other, but are otherwise arbitrary, so they should not
- * be exposed to the user or serialized to disk.  To know whether a
+ * comparing against each other, but are otherwise arbitrary. To know whether a
  * git_hash_algo struct points to some usable hash function, test the format_id
  * field for being non-zero.  Use the name field for user-visible situations and
  * the format_id field for fixed-length fields on disk.
@@ -337,4 +336,27 @@ static inline void oid_set_algo(struct object_id *oid, const struct git_hash_alg
 const char *empty_tree_oid_hex(void);
 const char *empty_blob_oid_hex(void);
 
+/**
+ * Convert GIT_HASH_SHA1 to 1, GIT_HASH_SHA256 to 2 etc.
+ *
+ * It's preferable to use GIT_{SHA1,SHA256}_FORMAT_ID instead for file
+ * formats. The original intention was not to make these short
+ * constants part of any file format.
+ * 
+ * But since that ship has sailed for various on-disk formats this
+ * utility function allows us to do that consistently in one place.
+ */
+static inline int hash_short_id_by_algo(void)
+{
+	int hash_algo = hash_algo_by_ptr(the_hash_algo);
+
+	switch (hash_algo) {
+	case GIT_HASH_SHA1:
+	case GIT_HASH_SHA256:
+		return hash_algo;
+	default:
+		BUG("invalid hash version");
+	}
+}
+
 #endif
diff --git a/midx.c b/midx.c
index 3db0e47735f..2e42afa5f00 100644
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
+	if (hash_version != hash_short_id_by_algo()) {
 		error(_("multi-pack-index hash version %u does not match version %u"),
-		      hash_version, oid_version());
+		      hash_version, hash_short_id_by_algo());
 		goto cleanup_fail;
 	}
 	m->hash_len = the_hash_algo->rawsz;
@@ -420,7 +408,7 @@ static size_t write_midx_header(struct hashfile *f,
 {
 	hashwrite_be32(f, MIDX_SIGNATURE);
 	hashwrite_u8(f, MIDX_VERSION);
-	hashwrite_u8(f, oid_version());
+	hashwrite_u8(f, hash_short_id_by_algo());
 	hashwrite_u8(f, num_chunks);
 	hashwrite_u8(f, 0); /* unused */
 	hashwrite_be32(f, num_packs);
diff --git a/pack-write.c b/pack-write.c
index 51812cb1299..c1ce8f6df8f 100644
--- a/pack-write.c
+++ b/pack-write.c
@@ -181,17 +181,7 @@ static int pack_order_cmp(const void *va, const void *vb, void *ctx)
 
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
+	uint32_t oid_version = hash_short_id_by_algo();
 
 	hashwrite_be32(f, RIDX_SIGNATURE);
 	hashwrite_be32(f, RIDX_VERSION);
-- 
2.36.1.952.g6652f7f0e6b

