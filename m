Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75A2A2F1FDD
	for <git@vger.kernel.org>; Mon, 27 Oct 2025 00:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761525878; cv=none; b=DVGIKkPF9pZu/DkuOspBGyKjhLAH/oiPbTWiS3UzXh6g9ta3yoopiX9TYmd0jeaZCMbm4CJbmD1+MCKyd2CmU1HVQDpRpu7yI7mJMPReOpA4cA2IZdZUHos6YF51bpjqkfv1PNg3kodGAgSd+EoLOw7pBzoW8kwMZkl3A+csYGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761525878; c=relaxed/simple;
	bh=Lb2CmAIgvZCOMKwJgoYvmc/DUQs5YwXtb9D0gTc3R90=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B4yRA0QDr+29Glm46drBbiwbD4E4Ce5WDse9NiTKQOO9sqFpFoz8OJ1J+ix3mZVIq3luKMT9dUR1+oSsZTLu0KhvHDKeh19FKXlQE3DZoV5xxOQNsgJW3jSJAXd/vvCFDn8+GUEEBcq5x2XobHu3Arjih2ye8nBQZzqkGLbqJF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=kO/Z9Yw9; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="kO/Z9Yw9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1761525867;
	bh=Lb2CmAIgvZCOMKwJgoYvmc/DUQs5YwXtb9D0gTc3R90=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
	 Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	 In-Reply-To:References:Content-Type:Content-Disposition;
	b=kO/Z9Yw9YR9pI7aVYji5RFaPTIfQ/96o/pJoqOqhxqtxspldAxc/TFtzQhZ63YP1G
	 eNtzPeE6nJ7ebXg3GY6ATjR1e8F4JHBOqz6YhgDTkH/uEg7XAUmYXbpDBmJuw+hPmw
	 iTkqzNgBhlvgG8a6aLIxMhgb5rLN0oJqhrZ25c2uTgAe4UTZ/bWD0fCrs7ee6/eIxi
	 lQp4mUckffdBP8Lfe98TY++tkm4GEE155R8Dt5UHPBh/mJKLi3T/K6gMvTrqG9j/mc
	 ycY97wdLRGOwbq3VveOQ0Cts6WN6k8ZG9zLMQ38fnTiMtGLea6bvkS3069zvbeHX2A
	 BsO4kmsNjaS9Xvu915n6Fmh0kFVF5aKgWTocEY4sP/s0aPG+CxQ9JuTcTLMsmMALME
	 Dwunio5VlbKjcj2+JCMHV0/feN/rTeWl4n8mmnSDQlWR6LXUQNvzkt4Cy5RQ/KrrP3
	 ez5SWpi8dgvOX8QW6LQnHFKJ4plgAM6rZ1zfAil6ZXxi7tbH6Dx
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:5675:b769:afe:3fa2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id B48242019F;
	Mon, 27 Oct 2025 00:44:27 +0000 (UTC)
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Ezekiel Newren <ezekielnewren@gmail.com>
Subject: [PATCH 06/14] hash: add a function to look up hash algo structs
Date: Mon, 27 Oct 2025 00:43:56 +0000
Message-ID: <20251027004404.2152927-7-sandals@crustytoothpaste.net>
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

In C, it's easy for us to look up a hash algorithm structure by its
offset by simply indexing the hash_algos array.  However, in Rust, we
sometimes need a pointer to pass to a C function, but we have our own
hash algorithm abstraction.

To get one from the other, let's provide a simple function that looks up
the C structure from the offset and expose it in Rust.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 hash.c      |  5 +++++
 hash.h      |  1 +
 src/hash.rs | 15 +++++++++++++++
 3 files changed, 21 insertions(+)

diff --git a/hash.c b/hash.c
index 81b4f87027..2f4e88e501 100644
--- a/hash.c
+++ b/hash.c
@@ -241,6 +241,11 @@ const char *empty_tree_oid_hex(const struct git_hash_algo *algop)
 	return oid_to_hex_r(buf, algop->empty_tree);
 }
 
+const struct git_hash_algo *hash_algo_ptr_by_offset(uint32_t algo)
+{
+	return &hash_algos[algo];
+}
+
 uint32_t hash_algo_by_name(const char *name)
 {
 	if (!name)
diff --git a/hash.h b/hash.h
index 99c9c2a0a8..c47ac81989 100644
--- a/hash.h
+++ b/hash.h
@@ -340,6 +340,7 @@ static inline void git_hash_final_oid(struct object_id *oid, struct git_hash_ctx
 	ctx->algop->final_oid_fn(oid, ctx);
 }
 
+const struct git_hash_algo *hash_algo_ptr_by_offset(uint32_t algo);
 /*
  * Return a GIT_HASH_* constant based on the name.  Returns GIT_HASH_UNKNOWN if
  * the name doesn't match a known algorithm.
diff --git a/src/hash.rs b/src/hash.rs
index 1b9f07489e..a5b9493bd8 100644
--- a/src/hash.rs
+++ b/src/hash.rs
@@ -10,6 +10,8 @@
 // You should have received a copy of the GNU General Public License along
 // with this program; if not, see <https://www.gnu.org/licenses/>.
 
+use std::os::raw::c_void;
+
 pub const GIT_MAX_RAWSZ: usize = 32;
 
 /// A binary object ID.
@@ -160,4 +162,17 @@ impl HashAlgorithm {
             HashAlgorithm::SHA256 => &Self::SHA256_NULL_OID,
         }
     }
+
+    /// A pointer to the C `struct git_hash_algo` for interoperability with C.
+    pub fn hash_algo_ptr(self) -> *const c_void {
+        unsafe { c::hash_algo_ptr_by_offset(self as u32) }
+    }
+}
+
+pub mod c {
+    use std::os::raw::c_void;
+
+    extern "C" {
+        pub fn hash_algo_ptr_by_offset(n: u32) -> *const c_void;
+    }
 }
