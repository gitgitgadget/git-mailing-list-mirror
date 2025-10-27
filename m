Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 861D530E820
	for <git@vger.kernel.org>; Mon, 27 Oct 2025 00:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761525877; cv=none; b=YyF7DDQfu0LElkH8jq2HKk3qte9sFwu3c0WVuy6SPW856wsAaE+2/P7tN8mNtAzQPtnYUn4GyzCi607O/scY6mFatVosOy+xlsQE8m/B1TXV0JV0xlME+0oc8EL0pc4D9QSm1RLvZLmFk9G+NU4HjmeKZxe9ceu/KYCUpaCUfXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761525877; c=relaxed/simple;
	bh=FfDPWmT6FBwcSJBmBMHS/V5cSvYl3Bqo1QvjgWWZHec=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U6g//IPnDsGEH9F3xZeST/UmgyaTwngAQVc33lEc7eXt2p+o0/HW19vNC46wEjpKHc1bpECn00BZrfCNXAl607jCuseeiIsF0QpLi3sZhx24AWGBVlubGNFgdsT7iDSdT70wXVjjKw1NLCbllSG/wxbKr3q72tvgiT8Ib1MVa3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=PGHFZPRa; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="PGHFZPRa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1761525867;
	bh=FfDPWmT6FBwcSJBmBMHS/V5cSvYl3Bqo1QvjgWWZHec=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
	 Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	 In-Reply-To:References:Content-Type:Content-Disposition;
	b=PGHFZPRadEsRX61ytenWbuD072UhvkEQNIqwKk6q8lq9m4ebxQ3aFEEBrJI/rPTK8
	 hu74KDjky+s8lLtuBKnY7Sj+uhJxLoDNgGFVe8DI9nkLi7eoyBUnRSIOwOR6yeqTlf
	 B8/aIaiuxf0pnpZ94F4dNNXqwOqKXgE0qLbD0kyrSXGdUEwwg/jY6uUPaTiO7L30by
	 L8KblrWKDdt/sMb4zo8kGUxCIGeXeS4npX0m8YuBIESQrLdW82gttTutnlLZBNRoBH
	 zX+qZ+g6IwJ0Zbpqgh4zLfaf0glgaQ81fenj9Vvk4s8uVUb3y+k/mub1UiZnyX6d2H
	 J1IOYMOcnKk0hzltnGVTwXmWl68enilr2nUl+NFpH9OgOy1vKrfcHyOBCCX1YSg4bs
	 U1s6ucNAyqaOvH1fl6fEybGOEIS4Na4sRXLrz6BB6azYia/xocjE6AtmAlivG85Iq8
	 40G2qUkbIxWfR2VCQBQOWcEH0T2wjOmpDqyoudjkqa5Y5mJQzSi
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:5675:b769:afe:3fa2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id CAEFE231FC;
	Mon, 27 Oct 2025 00:44:27 +0000 (UTC)
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Ezekiel Newren <ezekielnewren@gmail.com>
Subject: [PATCH 09/14] hash: expose hash context functions to Rust
Date: Mon, 27 Oct 2025 00:43:59 +0000
Message-ID: <20251027004404.2152927-10-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.51.0.338.gd7d06c2dae8
In-Reply-To: <20251027004404.2152927-1-sandals@crustytoothpaste.net>
References: <20251027004404.2152927-1-sandals@crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We'd like to be able to hash our data in Rust using the same contexts as
in C.  However, we need our helper functions to not be inline so they
can be linked into the binary appropriately.  In addition, to avoid
managing memory manually and since we don't know the size of the hash
context structure, we want to have simple alloc and free functions we
can use to make sure a context can be easily dynamically created.

Expose the helper functions and create alloc, free, and init functions
we can call.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 hash.c | 35 +++++++++++++++++++++++++++++++++++
 hash.h | 27 +++++++--------------------
 2 files changed, 42 insertions(+), 20 deletions(-)

diff --git a/hash.c b/hash.c
index 2f4e88e501..4977e13de6 100644
--- a/hash.c
+++ b/hash.c
@@ -246,6 +246,41 @@ const struct git_hash_algo *hash_algo_ptr_by_offset(uint32_t algo)
 	return &hash_algos[algo];
 }
 
+struct git_hash_ctx *git_hash_alloc(void)
+{
+	return malloc(sizeof(struct git_hash_ctx));
+}
+
+void git_hash_free(struct git_hash_ctx *ctx)
+{
+	free(ctx);
+}
+
+void git_hash_init(struct git_hash_ctx *ctx, const struct git_hash_algo *algop)
+{
+	algop->init_fn(ctx);
+}
+
+void git_hash_clone(struct git_hash_ctx *dst, const struct git_hash_ctx *src)
+{
+	src->algop->clone_fn(dst, src);
+}
+
+void git_hash_update(struct git_hash_ctx *ctx, const void *in, size_t len)
+{
+	ctx->algop->update_fn(ctx, in, len);
+}
+
+void git_hash_final(unsigned char *hash, struct git_hash_ctx *ctx)
+{
+	ctx->algop->final_fn(hash, ctx);
+}
+
+void git_hash_final_oid(struct object_id *oid, struct git_hash_ctx *ctx)
+{
+	ctx->algop->final_oid_fn(oid, ctx);
+}
+
 uint32_t hash_algo_by_name(const char *name)
 {
 	if (!name)
diff --git a/hash.h b/hash.h
index c47ac81989..a937b8aff0 100644
--- a/hash.h
+++ b/hash.h
@@ -320,27 +320,14 @@ struct git_hash_algo {
 };
 extern const struct git_hash_algo hash_algos[GIT_HASH_NALGOS];
 
-static inline void git_hash_clone(struct git_hash_ctx *dst, const struct git_hash_ctx *src)
-{
-	src->algop->clone_fn(dst, src);
-}
-
-static inline void git_hash_update(struct git_hash_ctx *ctx, const void *in, size_t len)
-{
-	ctx->algop->update_fn(ctx, in, len);
-}
-
-static inline void git_hash_final(unsigned char *hash, struct git_hash_ctx *ctx)
-{
-	ctx->algop->final_fn(hash, ctx);
-}
-
-static inline void git_hash_final_oid(struct object_id *oid, struct git_hash_ctx *ctx)
-{
-	ctx->algop->final_oid_fn(oid, ctx);
-}
-
+void git_hash_init(struct git_hash_ctx *ctx, const struct git_hash_algo *algop);
+void git_hash_clone(struct git_hash_ctx *dst, const struct git_hash_ctx *src);
+void git_hash_update(struct git_hash_ctx *ctx, const void *in, size_t len);
+void git_hash_final(unsigned char *hash, struct git_hash_ctx *ctx);
+void git_hash_final_oid(struct object_id *oid, struct git_hash_ctx *ctx);
 const struct git_hash_algo *hash_algo_ptr_by_offset(uint32_t algo);
+struct git_hash_ctx *git_hash_alloc(void);
+void git_hash_free(struct git_hash_ctx *ctx);
 /*
  * Return a GIT_HASH_* constant based on the name.  Returns GIT_HASH_UNKNOWN if
  * the name doesn't match a known algorithm.
