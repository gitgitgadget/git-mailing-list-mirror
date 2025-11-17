Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC973324B37
	for <git@vger.kernel.org>; Mon, 17 Nov 2025 22:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763417791; cv=none; b=ksU8PxSNGOUv785pXArV2jFU6EhNNq88rOyNT7EwX+XCsy4WFKd0jtd/BJTHCJy+5HZdqcK+psl0m/GIHnDGE0gGjbJEVVwEtqqoJUjnLcCCXKB8pRgMPawbKld+NseWipSBCf/69KxSE8+ukTtFKl2b1EYa2tqUHjCFttrnzU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763417791; c=relaxed/simple;
	bh=dOX30Um9svRVu2OwJXSjfIb40uzACMbRJuF5wosb1p8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JvFxKMlO4YWr4BjUPcDn4HYl2CUJ09/G2gf0DyDQMKsgXFSpQphdDatEtdnPdr+zr6xKpYJ5MPY8rKem2Npob3lpGtvux0yTgZholBBeCGUa3ZjuXBrEgJ08PmvFj6Sr1dJLN9q9kBKemUTtFciqNlwz5mPB8vWbGe/EUpD5GGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=aZENhGQK; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="aZENhGQK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1763417786;
	bh=dOX30Um9svRVu2OwJXSjfIb40uzACMbRJuF5wosb1p8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
	 Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	 In-Reply-To:References:Content-Type:Content-Disposition;
	b=aZENhGQK+IODTo/UVQSL51SzZfnjCPh6rPSNaxj8NzMjwucZ4VKp2pwA3+DBRMtcX
	 kIwdbYLvrdKSqO1U3Cur2z/k7MxG7XRea7zTHsf9HsVzF04aB8lh3CRvpqohz8fkSR
	 7Zr6zvh6WAlV4U1NmpQjmwKOP0xkFwWeY7hGR7mt+bRWi5J1feGXxOM8gKCZYxFAiG
	 7NULh4OPSufgNxzUoxEO+V9kzz9TzPGuekYRkZacCMc+Cnq4xSGs9t3coUDzQ5Ua22
	 PFN/wLaBlb4z5YV4FCTGbZbC7g08azNs/P3g8dEhvIBqXVqZ0373bZhGkG0o3YpORO
	 4aSOmmfOOX4PQzkP2KzoYxoBmQinxQbWcdTTHsmTbR8IoqG1gChv+PvINA800ryMgk
	 cSZzjqdJ9sd1qIOy9b71Tw1FYwOA5l9WTOyY94AWiD1v73liWH8i/xM27qHThOaW5/
	 oQFB0Ov6UjNNQXCNCOuaMFR+3xB5DrRXgCfhuRsTXpr9Ofq1dzt
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:b6c6:bf88:c872:dae4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 430EF2553D;
	Mon, 17 Nov 2025 22:16:26 +0000 (UTC)
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Ezekiel Newren <ezekielnewren@gmail.com>
Subject: [PATCH v2 10/15] hash: expose hash context functions to Rust
Date: Mon, 17 Nov 2025 22:16:16 +0000
Message-ID: <20251117221621.2863243-11-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.51.0.338.gd7d06c2dae8
In-Reply-To: <20251117221621.2863243-1-sandals@crustytoothpaste.net>
References: <20251027004404.2152927-1-sandals@crustytoothpaste.net>
 <20251117221621.2863243-1-sandals@crustytoothpaste.net>
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
index 97fd473607..553f2008ea 100644
--- a/hash.c
+++ b/hash.c
@@ -248,6 +248,41 @@ const struct git_hash_algo *hash_algo_ptr_by_number(uint32_t algo)
 	return &hash_algos[algo];
 }
 
+struct git_hash_ctx *git_hash_alloc(void)
+{
+	return xmalloc(sizeof(struct git_hash_ctx));
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
index 709d7585a5..d51efce1d3 100644
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
 const struct git_hash_algo *hash_algo_ptr_by_number(uint32_t algo);
+struct git_hash_ctx *git_hash_alloc(void);
+void git_hash_free(struct git_hash_ctx *ctx);
 /*
  * Return a GIT_HASH_* constant based on the name.  Returns GIT_HASH_UNKNOWN if
  * the name doesn't match a known algorithm.
