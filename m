Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 754193254AB
	for <git@vger.kernel.org>; Mon, 17 Nov 2025 22:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763417792; cv=none; b=P0Hw+3DylbndV2dlTuuBQ2chTvdGGUmHP62gkm25KolzCWvJV+u7hXVHhK+/HuWO6THrgUMxvz7zxFAbwk55ZM7JWWO9LnKs5lXsV+uroqxMdNFCAMfTHaCBaUwpFtuOsJphaaMnmWTbzbXJ/J4s+uCcbcW3v7iFcxN/4FD9d0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763417792; c=relaxed/simple;
	bh=sOuFYs9pn5OTqrFh3NgZcxC4HzeCIKpiHWOn9CEJJOU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mq67ESpmO/W4wJMiAKhoyP1SJq9rQVZP0VYIsc93pCL8dkXe32xZV+eyz66v7hreZBbq+LP/W86JmiJh1dR1se1hoIxbpwKhgeU2Vsxo7bhERD/qmVAhKZAAg/0Y0qesAMghUzXaJ7hMem1/qaiPRjXSZYiRM7aFGqdpP5ma7Zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=OFiwlh2A; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="OFiwlh2A"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1763417786;
	bh=sOuFYs9pn5OTqrFh3NgZcxC4HzeCIKpiHWOn9CEJJOU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
	 Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	 In-Reply-To:References:Content-Type:Content-Disposition;
	b=OFiwlh2ACntDdEvO84hQDunrAQDbI2f6yFF5jnmdZxejuc6nXke+0/LsCjA8peafa
	 KSmwxUQ6gXLiUIe66AY8nKnv4GB8QTgjonKEg7WV6iK3XED6vXfsgC5gzW9HVeKQpZ
	 3Vfv7gGuZdmH6C6lex2WidERfZKYJfuDipsLo3PA7nMx4b6pwwhooGsg2gR9M3Uvat
	 +Mui+eufdtqC4UFH6B+tnSco8HF+yfHf9aPypEx/EpoVz6v11WS0QlNLuWrpsyLOm4
	 OM0Xk/XD+EdtiAuFkfPYrVhYOkcUQbuQfpVRYrR2/HMUoq76N97YWS0CK5IXMa9Ivn
	 I+HOE4Q8qK+8WCtSXrMafUE7jbgQu98PTOXHhpQ5OR7+EP8JRTfDpGky2pAAlhmsqP
	 UgFYlnvlQ2gk5gSkXd5UlSrTCTxA3ME6XAI1PNbNmkUmHHpf+IRIFUdYp4pBDwt1hp
	 k9qFCnyylIC6o2prWjBMr7Bkfw7qF7lRV4izJiojsc+zTePC0C7
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:b6c6:bf88:c872:dae4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 4EF1925545;
	Mon, 17 Nov 2025 22:16:26 +0000 (UTC)
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Ezekiel Newren <ezekielnewren@gmail.com>
Subject: [PATCH v2 12/15] rust: add functionality to hash an object
Date: Mon, 17 Nov 2025 22:16:18 +0000
Message-ID: <20251117221621.2863243-13-sandals@crustytoothpaste.net>
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

In a future commit, we'll want to hash some data when dealing with an
object map.  Let's make this easy by creating a structure to hash
objects and calling into the C functions as necessary to perform the
hashing.  For now, we only implement safe hashing, but in the future we
could add unsafe hashing if we want.  Implement Clone and Drop to
appropriately manage our memory.  Additionally implement Write to make
it easy to use with other formats that implement this trait.

While we're at it, add some tests for the various hashing cases.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 src/hash.rs | 143 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 142 insertions(+), 1 deletion(-)

diff --git a/src/hash.rs b/src/hash.rs
index e1fa568661..dea2998de4 100644
--- a/src/hash.rs
+++ b/src/hash.rs
@@ -12,6 +12,7 @@
 
 use std::error::Error;
 use std::fmt::{self, Debug, Display};
+use std::io::{self, Write};
 use std::os::raw::c_void;
 
 pub const GIT_MAX_RAWSZ: usize = 32;
@@ -111,6 +112,100 @@ impl Debug for ObjectID {
     }
 }
 
+/// A trait to implement hashing with a cryptographic algorithm.
+pub trait CryptoDigest {
+    /// Return true if this digest is safe for use with untrusted data, false otherwise.
+    fn is_safe(&self) -> bool;
+
+    /// Update the digest with the specified data.
+    fn update(&mut self, data: &[u8]);
+
+    /// Return an object ID, consuming the hasher.
+    fn into_oid(self) -> ObjectID;
+
+    /// Return a hash as a `Vec`, consuming the hasher.
+    fn into_vec(self) -> Vec<u8>;
+}
+
+/// A structure to hash data with a cryptographic hash algorithm.
+///
+/// Instances of this class are safe for use with untrusted data, provided Git has been compiled
+/// with a collision-detecting implementation of SHA-1.
+pub struct CryptoHasher {
+    algo: HashAlgorithm,
+    ctx: *mut c_void,
+}
+
+impl CryptoHasher {
+    /// Create a new hasher with the algorithm specified with `algo`.
+    ///
+    /// This hasher is safe to use on untrusted data.  If SHA-1 is selected and Git was compiled
+    /// with a collision-detecting implementation of SHA-1, then this function will use that
+    /// implementation and detect any attempts at a collision.
+    pub fn new(algo: HashAlgorithm) -> Self {
+        let ctx = unsafe { c::git_hash_alloc() };
+        unsafe { c::git_hash_init(ctx, algo.hash_algo_ptr()) };
+        Self { algo, ctx }
+    }
+}
+
+impl CryptoDigest for CryptoHasher {
+    /// Return true if this digest is safe for use with untrusted data, false otherwise.
+    fn is_safe(&self) -> bool {
+        true
+    }
+
+    /// Update the hasher with the specified data.
+    fn update(&mut self, data: &[u8]) {
+        unsafe { c::git_hash_update(self.ctx, data.as_ptr() as *const c_void, data.len()) };
+    }
+
+    /// Return an object ID, consuming the hasher.
+    fn into_oid(self) -> ObjectID {
+        let mut oid = ObjectID {
+            hash: [0u8; 32],
+            algo: self.algo as u32,
+        };
+        unsafe { c::git_hash_final_oid(&mut oid as *mut ObjectID as *mut c_void, self.ctx) };
+        oid
+    }
+
+    /// Return a hash as a `Vec`, consuming the hasher.
+    fn into_vec(self) -> Vec<u8> {
+        let mut v = vec![0u8; self.algo.raw_len()];
+        unsafe { c::git_hash_final(v.as_mut_ptr(), self.ctx) };
+        v
+    }
+}
+
+impl Clone for CryptoHasher {
+    fn clone(&self) -> Self {
+        let ctx = unsafe { c::git_hash_alloc() };
+        unsafe { c::git_hash_clone(ctx, self.ctx) };
+        Self {
+            algo: self.algo,
+            ctx,
+        }
+    }
+}
+
+impl Drop for CryptoHasher {
+    fn drop(&mut self) {
+        unsafe { c::git_hash_free(self.ctx) };
+    }
+}
+
+impl Write for CryptoHasher {
+    fn write(&mut self, data: &[u8]) -> io::Result<usize> {
+        self.update(data);
+        Ok(data.len())
+    }
+
+    fn flush(&mut self) -> io::Result<()> {
+        Ok(())
+    }
+}
+
 /// A hash algorithm,
 #[repr(C)]
 #[derive(Debug, Copy, Clone, Ord, PartialOrd, Eq, PartialEq)]
@@ -239,6 +334,11 @@ impl HashAlgorithm {
     pub fn hash_algo_ptr(self) -> *const c_void {
         unsafe { c::hash_algo_ptr_by_number(self as u32) }
     }
+
+    /// Create a hasher for this algorithm.
+    pub fn hasher(self) -> CryptoHasher {
+        CryptoHasher::new(self)
+    }
 }
 
 pub mod c {
@@ -246,12 +346,21 @@ pub mod c {
 
     extern "C" {
         pub fn hash_algo_ptr_by_number(n: u32) -> *const c_void;
+        pub fn unsafe_hash_algo(algop: *const c_void) -> *const c_void;
+        pub fn git_hash_alloc() -> *mut c_void;
+        pub fn git_hash_free(ctx: *mut c_void);
+        pub fn git_hash_init(dst: *mut c_void, algop: *const c_void);
+        pub fn git_hash_clone(dst: *mut c_void, src: *const c_void);
+        pub fn git_hash_update(ctx: *mut c_void, inp: *const c_void, len: usize);
+        pub fn git_hash_final(hash: *mut u8, ctx: *mut c_void);
+        pub fn git_hash_final_oid(hash: *mut c_void, ctx: *mut c_void);
     }
 }
 
 #[cfg(test)]
 mod tests {
-    use super::HashAlgorithm;
+    use super::{CryptoDigest, HashAlgorithm, ObjectID};
+    use std::io::Write;
 
     fn all_algos() -> &'static [HashAlgorithm] {
         &[HashAlgorithm::SHA1, HashAlgorithm::SHA256]
@@ -322,4 +431,36 @@ mod tests {
             assert_eq!(format!("{:?}", oid), *debug);
         }
     }
+
+    #[test]
+    fn hasher_works_correctly() {
+        for algo in all_algos() {
+            let tests: &[(&[u8], &ObjectID)] = &[
+                (b"blob 0\0", algo.empty_blob()),
+                (b"tree 0\0", algo.empty_tree()),
+            ];
+            for (data, oid) in tests {
+                let mut h = algo.hasher();
+                assert!(h.is_safe());
+                // Test that this works incrementally.
+                h.update(&data[0..2]);
+                h.update(&data[2..]);
+
+                let h2 = h.clone();
+
+                let actual_oid = h.into_oid();
+                assert_eq!(**oid, actual_oid);
+
+                let v = h2.into_vec();
+                assert_eq!((*oid).as_slice().unwrap(), &v);
+
+                let mut h = algo.hasher();
+                h.write_all(&data[0..2]).unwrap();
+                h.write_all(&data[2..]).unwrap();
+
+                let actual_oid = h.into_oid();
+                assert_eq!(**oid, actual_oid);
+            }
+        }
+    }
 }
