Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 759741BC4E
	for <git@vger.kernel.org>; Mon, 27 Oct 2025 00:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761525877; cv=none; b=jsASN6NijM5JzA6CS81YLYPmrEkF2Qpwm9+94o9HXr7SFMXIIoxhU2e6Jiki+IDsuZEEVhqFeKrgMMTD51Rd134E0c2QBwgcRyZ9C1eMsnlLVFZy38zOOK2sGBkTzEcCxlWzdOqvcG10pxTd5MIdFivb1MAIjUqBLF0aI9Y/PG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761525877; c=relaxed/simple;
	bh=OJbsvGMYQBll+kWSVjk+z6l3eNUlQzTiuf3XjkudnJc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ahxu/qgtXQtgrNpwCitfwRAC93+Rqv5ocSDT0u2g4nY3Z2OOcmSyBy3MgfK2IANE7NJSbkr9rivUFw6h0Spct2GmJyKFUaa0s9AF2rezUbqGvt0Dq6f2egF91e2j9wmrBUpldZ85tk1W85kn1LDDQLFaLWM+gEEeGf6kdzFsABo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=paB0BuCv; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="paB0BuCv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1761525867;
	bh=OJbsvGMYQBll+kWSVjk+z6l3eNUlQzTiuf3XjkudnJc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
	 Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	 In-Reply-To:References:Content-Type:Content-Disposition;
	b=paB0BuCvwoGQzn/ZBXCUOhMLTQkN7KSwTMswf0dF19ZUCSDsh/3Nb/t+u/LW36QEC
	 3dgFSBc8gJtnyz5jyn311fQHTH5ytDXbDH01paXUkg1i1HVGVjOKPtiOqzmQJOhU6K
	 3YN05k5+0voytOqZ7TKMunwREjyre9f3gJbkIsFWjFWbdLAKIpwG3wbx53cicGeqAb
	 1H2boXhFrz+1XjJyl8/9KP1Bff+pfR9tTOCg1t7W6LGF6JF35nsphrmwBp1k4cw4QW
	 VFKF2tIjjSYXsS2ifuv7X832evw/8vcz3u+mWyGJTlUcod+/KO4c3T2BSNZaOa0Cfx
	 lFsR8GvdyI8HlwqFdrqHFAXS8vkERfuAT/nahGRl6qHPma8hpi1DfOeFjbxKk8c3/1
	 OrHzCV3acZTxQeQfpLyuOFGuWwIvXQoRKV8aAWTmEV64kiVgpT3NCSJbjCBWOblkmn
	 MvugzxEqB31h4oTr/1dhnYJ50lRZ99TIJvuLqHR6qBMU1zX7+0H
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:5675:b769:afe:3fa2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id D9CA4231FE;
	Mon, 27 Oct 2025 00:44:27 +0000 (UTC)
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Ezekiel Newren <ezekielnewren@gmail.com>
Subject: [PATCH 11/14] rust: add functionality to hash an object
Date: Mon, 27 Oct 2025 00:44:01 +0000
Message-ID: <20251027004404.2152927-12-sandals@crustytoothpaste.net>
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

In a future commit, we'll want to hash some data when dealing with a
loose object map.  Let's make this easy by creating a structure to hash
objects and calling into the C functions as necessary to perform the
hashing.  For now, we only implement safe hashing, but in the future we
could add unsafe hashing if we want.  Implement Clone and Drop to
appropriately manage our memory.  Additionally implement Write to make
it easy to use with other formats that implement this trait.

While we're at it, add some tests for the various cases in this file.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 src/hash.rs | 157 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 157 insertions(+)

diff --git a/src/hash.rs b/src/hash.rs
index a5b9493bd8..8798a50aef 100644
--- a/src/hash.rs
+++ b/src/hash.rs
@@ -10,6 +10,7 @@
 // You should have received a copy of the GNU General Public License along
 // with this program; if not, see <https://www.gnu.org/licenses/>.
 
+use std::io::{self, Write};
 use std::os::raw::c_void;
 
 pub const GIT_MAX_RAWSZ: usize = 32;
@@ -39,6 +40,81 @@ impl ObjectID {
     }
 }
 
+pub struct Hasher {
+    algo: HashAlgorithm,
+    safe: bool,
+    ctx: *mut c_void,
+}
+
+impl Hasher {
+    /// Create a new safe hasher.
+    pub fn new(algo: HashAlgorithm) -> Hasher {
+        let ctx = unsafe { c::git_hash_alloc() };
+        unsafe { c::git_hash_init(ctx, algo.hash_algo_ptr()) };
+        Hasher {
+            algo,
+            safe: true,
+            ctx,
+        }
+    }
+
+    /// Return whether this is a safe hasher.
+    pub fn is_safe(&self) -> bool {
+        self.safe
+    }
+
+    /// Update the hasher with the specified data.
+    pub fn update(&mut self, data: &[u8]) {
+        unsafe { c::git_hash_update(self.ctx, data.as_ptr() as *const c_void, data.len()) };
+    }
+
+    /// Return an object ID, consuming the hasher.
+    pub fn into_oid(self) -> ObjectID {
+        let mut oid = ObjectID {
+            hash: [0u8; 32],
+            algo: self.algo as u32,
+        };
+        unsafe { c::git_hash_final_oid(&mut oid as *mut ObjectID as *mut c_void, self.ctx) };
+        oid
+    }
+
+    /// Return a hash as a `Vec`, consuming the hasher.
+    pub fn into_vec(self) -> Vec<u8> {
+        let mut v = vec![0u8; self.algo.raw_len()];
+        unsafe { c::git_hash_final(v.as_mut_ptr(), self.ctx) };
+        v
+    }
+}
+
+impl Write for Hasher {
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
+impl Clone for Hasher {
+    fn clone(&self) -> Hasher {
+        let ctx = unsafe { c::git_hash_alloc() };
+        unsafe { c::git_hash_clone(ctx, self.ctx) };
+        Hasher {
+            algo: self.algo,
+            safe: self.safe,
+            ctx,
+        }
+    }
+}
+
+impl Drop for Hasher {
+    fn drop(&mut self) {
+        unsafe { c::git_hash_free(self.ctx) };
+    }
+}
+
 /// A hash algorithm,
 #[repr(C)]
 #[derive(Debug, Copy, Clone, Ord, PartialOrd, Eq, PartialEq)]
@@ -167,6 +243,11 @@ impl HashAlgorithm {
     pub fn hash_algo_ptr(self) -> *const c_void {
         unsafe { c::hash_algo_ptr_by_offset(self as u32) }
     }
+
+    /// Create a hasher for this algorithm.
+    pub fn hasher(self) -> Hasher {
+        Hasher::new(self)
+    }
 }
 
 pub mod c {
@@ -174,5 +255,81 @@ pub mod c {
 
     extern "C" {
         pub fn hash_algo_ptr_by_offset(n: u32) -> *const c_void;
+        pub fn unsafe_hash_algo(algop: *const c_void) -> *const c_void;
+        pub fn git_hash_alloc() -> *mut c_void;
+        pub fn git_hash_free(ctx: *mut c_void);
+        pub fn git_hash_init(dst: *mut c_void, algop: *const c_void);
+        pub fn git_hash_clone(dst: *mut c_void, src: *const c_void);
+        pub fn git_hash_update(ctx: *mut c_void, inp: *const c_void, len: usize);
+        pub fn git_hash_final(hash: *mut u8, ctx: *mut c_void);
+        pub fn git_hash_final_oid(hash: *mut c_void, ctx: *mut c_void);
+    }
+}
+
+#[cfg(test)]
+mod tests {
+    use super::{HashAlgorithm, ObjectID};
+    use std::io::Write;
+
+    fn all_algos() -> &'static [HashAlgorithm] {
+        &[HashAlgorithm::SHA1, HashAlgorithm::SHA256]
+    }
+
+    #[test]
+    fn format_id_round_trips() {
+        for algo in all_algos() {
+            assert_eq!(
+                *algo,
+                HashAlgorithm::from_format_id(algo.format_id()).unwrap()
+            );
+        }
+    }
+
+    #[test]
+    fn offset_round_trips() {
+        for algo in all_algos() {
+            assert_eq!(*algo, HashAlgorithm::from_u32(*algo as u32).unwrap());
+        }
+    }
+
+    #[test]
+    fn slices_have_correct_length() {
+        for algo in all_algos() {
+            for oid in [algo.null_oid(), algo.empty_blob(), algo.empty_tree()] {
+                assert_eq!(oid.as_slice().len(), algo.raw_len());
+            }
+        }
+    }
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
+                assert_eq!(h.is_safe(), true);
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
+                assert_eq!((*oid).as_slice(), &v);
+
+                let mut h = algo.hasher();
+                h.write_all(&data[0..2]).unwrap();
+                h.write_all(&data[2..]).unwrap();
+
+                let actual_oid = h.into_oid();
+                assert_eq!(**oid, actual_oid);
+            }
+        }
     }
 }
