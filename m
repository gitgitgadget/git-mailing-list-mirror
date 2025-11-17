Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7422134D3BB
	for <git@vger.kernel.org>; Mon, 17 Nov 2025 22:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763417791; cv=none; b=nQIIHh1J6mJ2bLwOPtMMmTGRMJa1yprcqu2g5MKMsMdVyvqR/KTkpEXMP7nJTuhfhqpry6vIcqNrChyu4n9GE1yKVYLaH/BSPeX4eLIdpx/jb3jlYrAD5237MKivnwrbs6vtjPD42QG4/ZygEwDbNtK4IwpL9zn39PNF+sMfWbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763417791; c=relaxed/simple;
	bh=0K/KtYkggrj3nC/p+zNmBJJsTMctGstVIhYAqhIVZ+U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KS4yyI2d4sitly8Uyymcr0vpliKNnYEEEC0BdI1UfbUEMC+fl5OLLo15ZbmJgZmP6CJ7eTDfODs6j6v+VGdRRC/3jPz+4o+JVUBmhAiDf7BfM8j+spcWwKeU0qkSdFgCyFxcLW8CKJihsgC6Dv/wUqIPoLG1Gm4qHYrYVaZcPoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=BzHpXNWl; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="BzHpXNWl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1763417786;
	bh=0K/KtYkggrj3nC/p+zNmBJJsTMctGstVIhYAqhIVZ+U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
	 Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	 In-Reply-To:References:Content-Type:Content-Disposition;
	b=BzHpXNWlpFs1+hTcRgk8FrDVurndyUNh7+FLgIMxlZnRPZf7p9LS7pNvY6JVAI49q
	 dNjZBVUybfNxp69VPUyfXJTABUor8zKgKpeG9W/lqGx/BZXzRDeXKwz5nASpl6Dxkn
	 pgiP+8vgykyaYm7lQxLBdhWfmJhQNxSpsTTPTYoeRJfa+Z2lEfDiJcseMU5BIozKcb
	 OTlD42EtN0ZDYTJQbV5qtSByL1hfuHwsbbx7+yOXnDPAUmcWnNt0SUyDmHbNlE4xtZ
	 zlnzACWGgwhROOd7JGAomb2VPHwg56bXq+BuR1Qrho6xHe0CaGU5DdT8Dn4MS6fm21
	 2TlTZJWUN6Nh2Op9OCN8Sgbf63/6TN+JUqF+epSnaTR7rZYgx0PQvSGV5OePL+VS2E
	 njvZ0+0vALtzVRspivD4/dvFHtHGgr5id1bEgvF5qi6ewHKw6MJ26gh03AplQb8AIT
	 x/KKd6dBTInYkjsZkSC+yZumvF+OaNWm3OJy3fjMzVFMw29X1kw
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:b6c6:bf88:c872:dae4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 282EE2552D;
	Mon, 17 Nov 2025 22:16:26 +0000 (UTC)
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Ezekiel Newren <ezekielnewren@gmail.com>
Subject: [PATCH v2 06/15] hash: add a function to look up hash algo structs
Date: Mon, 17 Nov 2025 22:16:12 +0000
Message-ID: <20251117221621.2863243-7-sandals@crustytoothpaste.net>
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

In C, it's easy for us to look up a hash algorithm structure by its
offset by simply indexing the hash_algos array.  However, in Rust, we
sometimes need a pointer to pass to a C function, but we have our own
hash algorithm abstraction.

To get one from the other, let's provide a simple function that looks up
the C structure from the offset and expose it in Rust.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 hash.c      |  7 +++++++
 hash.h      |  1 +
 src/hash.rs | 14 ++++++++++++++
 3 files changed, 22 insertions(+)

diff --git a/hash.c b/hash.c
index 81b4f87027..97fd473607 100644
--- a/hash.c
+++ b/hash.c
@@ -241,6 +241,13 @@ const char *empty_tree_oid_hex(const struct git_hash_algo *algop)
 	return oid_to_hex_r(buf, algop->empty_tree);
 }
 
+const struct git_hash_algo *hash_algo_ptr_by_number(uint32_t algo)
+{
+	if (algo >= GIT_HASH_NALGOS)
+		return NULL;
+	return &hash_algos[algo];
+}
+
 uint32_t hash_algo_by_name(const char *name)
 {
 	if (!name)
diff --git a/hash.h b/hash.h
index 99c9c2a0a8..709d7585a5 100644
--- a/hash.h
+++ b/hash.h
@@ -340,6 +340,7 @@ static inline void git_hash_final_oid(struct object_id *oid, struct git_hash_ctx
 	ctx->algop->final_oid_fn(oid, ctx);
 }
 
+const struct git_hash_algo *hash_algo_ptr_by_number(uint32_t algo);
 /*
  * Return a GIT_HASH_* constant based on the name.  Returns GIT_HASH_UNKNOWN if
  * the name doesn't match a known algorithm.
diff --git a/src/hash.rs b/src/hash.rs
index 0ec0ab0490..70bb8095e8 100644
--- a/src/hash.rs
+++ b/src/hash.rs
@@ -12,6 +12,7 @@
 
 use std::error::Error;
 use std::fmt::{self, Debug, Display};
+use std::os::raw::c_void;
 
 pub const GIT_MAX_RAWSZ: usize = 32;
 
@@ -177,4 +178,17 @@ impl HashAlgorithm {
             HashAlgorithm::SHA256 => &Self::SHA256_NULL_OID,
         }
     }
+
+    /// A pointer to the C `struct git_hash_algo` for interoperability with C.
+    pub fn hash_algo_ptr(self) -> *const c_void {
+        unsafe { c::hash_algo_ptr_by_number(self as u32) }
+    }
+}
+
+pub mod c {
+    use std::os::raw::c_void;
+
+    extern "C" {
+        pub fn hash_algo_ptr_by_number(n: u32) -> *const c_void;
+    }
 }
