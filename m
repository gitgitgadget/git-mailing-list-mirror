Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64DE633B6DB
	for <git@vger.kernel.org>; Sat,  7 Feb 2026 20:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770494705; cv=none; b=LywvaDD0kKOJ/RKQ2vrr5TKsifGjNQ4f/JbigawhC0PFj9rzS7Hq0RWX+VpEZ1aWb1lNo2Up+3kgiQX/JB27I5jPYxzkLDxvqd8d7Os0kRiDnZ82CX0xzGIh0jisSZJ6e0tqs+eLnIZ6o72bMDgGIPlvG0pD8p0l0sQRsZQWq2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770494705; c=relaxed/simple;
	bh=dOX30Um9svRVu2OwJXSjfIb40uzACMbRJuF5wosb1p8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X8H7x0IgNsKFsyOaecPpPA/wC3fxDw6RbK21kYojASTFXHLE6yN4tcW7kVxAF4ZMwFV9uuFAZoWqccUlxCzCBPHyOCIpBIIod6zP9xxxENVkgF3hdCO2xxl3DnC+c/XM+/O975dzQqyFcTY+EVM1EcQuecc6qeW833WKJT3PjK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=PXdfm7PH; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="PXdfm7PH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1770494697;
	bh=dOX30Um9svRVu2OwJXSjfIb40uzACMbRJuF5wosb1p8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
	 Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	 In-Reply-To:References:Content-Type:Content-Disposition;
	b=PXdfm7PH34N7sZk3uDMMTJDwfFXbH6CcbcR9BUWiClEHxT0QWalkEnDCZJfQ0PRJi
	 VnIrZmC2967tX1iYGurIlJg0iQXj07qrNS3qMfdDP7Uvs83lMOgchwSCkipkjqZDA0
	 mXP5C1v1ON802/E80xgQDKqDsVPIFI2DTt3uhdWZngR1pzP/ND2DszXrHjDBBrtybN
	 ej6M4XWPrjGJ4q8HNv7iNpx0ORL+KRipQrq/aCAhp2c36lRHDmpZTfoqtMAj1OkANY
	 uSizyo+S0NGqwy96Z8jraKVCgseVwneBLZWodw1qYmfT5ncXbeL/Yuetn26EhAWoBt
	 9DOS1YYm+xrVrITYadUGVl+l8xmOyiNn0+y8jIlUwxcyD5o5XGqJ4syeqUAkoQ8iHW
	 s5GYrQUwyTZ8U0H50ft5CbzNrCg2AYlzo34hYhqclObd1nfzIlhzwCcngnweb4S3vW
	 TOvSy2f2IwNPAQTYmrf0iGO6+lnIAVSY9cUhR0G5i56ygW2w1XH
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:9a58:ad83:8db9:6f4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id BDD78243CA;
	Sat,  7 Feb 2026 20:04:57 +0000 (UTC)
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Ezekiel Newren <ezekielnewren@gmail.com>,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v3 10/16] hash: expose hash context functions to Rust
Date: Sat,  7 Feb 2026 20:04:40 +0000
Message-ID: <20260207200446.2837699-11-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.51.0.338.gd7d06c2dae8
In-Reply-To: <20260207200446.2837699-1-sandals@crustytoothpaste.net>
References: <20251117221621.2863243-1-sandals@crustytoothpaste.net>
 <20260207200446.2837699-1-sandals@crustytoothpaste.net>
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
