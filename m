Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D888234D4D3
	for <git@vger.kernel.org>; Mon, 17 Nov 2025 22:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763417792; cv=none; b=hvloNCowt23ViKxt4zHrxaM8et978ENwPEg+HyOg2NUf7BIjDFJkEtLcFd1xEYZ+7lgjxSMGdGN7yrqE3KLnEAa+y0lHn7dxttFrenShlXAcsTCpqVKNWTwXbdzTm0T0Db5xNq8zbHm9ZKZGu0RHp7ZvsoBcUPxyMhBroeojz4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763417792; c=relaxed/simple;
	bh=BoVHsOEpMhz2oujucIoXGPS78UYW47nLkiVdhQ8NsdE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sYtrLptmm/FcJRuNjSRhvY0kyS4l5nnUVh6CssbxD3bqRFvXh2VRbon5pm0XYRE0nHzs5aDT4Fzj4KyzJVq3S2auqGkI09aTKXmSdxHmq5DTAjsZXU9ufgzfGWaEK0sV2YXSj8MS3Q5pbtn+UteONz3oyvJCKBw+UWLmcJdoIrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=uFZMOYZT; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="uFZMOYZT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1763417786;
	bh=BoVHsOEpMhz2oujucIoXGPS78UYW47nLkiVdhQ8NsdE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
	 Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	 In-Reply-To:References:Content-Type:Content-Disposition;
	b=uFZMOYZToplU1tSDrKTflY9CQhUbwjH4orEs51RBKdXLoUXX2y9mwOLvRq6oOG1UW
	 vlBX2omSjDH73MonQbVsIKyJK9X2UiDPplUgvM27rUiHJuRilKUDp4fvOIIPIj1m//
	 CVvHLhIG1zqCCcDFcRZuvJKIRnTUk58YBKMQAG3BBqz0y7d0hRdIPypHAdnzQn+m7i
	 Yr8fnIm5YqPEWL/DB1oBI6nEH3YQeB35PBbAFhqkGW3IBKHj3k/i45Y/O4grsleVK2
	 DDa9v+7qq68CT0pGWk3id0uWZy7bQ1bB5Q4cTIC+hvULNOaOyC/uILBgO/nsKIizAs
	 wON41Wwk8SFK20HHh8Sv4bqbJEkI3+geU7A6ZF6AyS+1xu9wMdWoBT06vOiQgrvWz/
	 +xNDDUrl/yplfxaPLDG5PQG3+Q6uWqQtE+LYBrIpM2JxqT+kc9JeWWeAXWHb8UV3/6
	 k2xfLYmAlCm7a4zZMdDo0GO9g0u10h2IcJUgd3+MGT2kGflIb+E
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:b6c6:bf88:c872:dae4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 305AD25531;
	Mon, 17 Nov 2025 22:16:26 +0000 (UTC)
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Ezekiel Newren <ezekielnewren@gmail.com>
Subject: [PATCH v2 07/15] rust: add additional helpers for ObjectID
Date: Mon, 17 Nov 2025 22:16:13 +0000
Message-ID: <20251117221621.2863243-8-sandals@crustytoothpaste.net>
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

Right now, users can internally access the contents of the ObjectID
struct, which can lead to data that is not valid, such as invalid
algorithms or non-zero-padded hash values.  These can cause problems
down the line as we use them more.

Add a constructor for ObjectID that allows us to set these values and
also provide an accessor for the algorithm so that we can access it.  In
addition, provide useful Display and Debug implementations that can
format our data in a useful way.

Now that we have the ability to work with these various components in a
nice way, add some tests as well to make sure that ObjectID and
HashAlgorithm work together as expected.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 src/hash.rs | 133 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 132 insertions(+), 1 deletion(-)

diff --git a/src/hash.rs b/src/hash.rs
index 70bb8095e8..e1fa568661 100644
--- a/src/hash.rs
+++ b/src/hash.rs
@@ -32,7 +32,7 @@ impl Error for InvalidHashAlgorithm {}
 
 /// A binary object ID.
 #[repr(C)]
-#[derive(Debug, Clone, Ord, PartialOrd, Eq, PartialEq)]
+#[derive(Clone, Ord, PartialOrd, Eq, PartialEq)]
 pub struct ObjectID {
     pub hash: [u8; GIT_MAX_RAWSZ],
     pub algo: u32,
@@ -40,6 +40,27 @@ pub struct ObjectID {
 
 #[allow(dead_code)]
 impl ObjectID {
+    /// Return a new object ID with the given algorithm and hash.
+    ///
+    /// `hash` must be exactly the proper length for `algo` and this function panics if it is not.
+    /// The extra internal storage of `hash`, if any, is zero filled.
+    pub fn new(algo: HashAlgorithm, hash: &[u8]) -> Self {
+        let mut data = [0u8; GIT_MAX_RAWSZ];
+        // This verifies that the length of `hash` is correct.
+        data[0..algo.raw_len()].copy_from_slice(hash);
+        Self {
+            hash: data,
+            algo: algo as u32,
+        }
+    }
+
+    /// Return the algorithm for this object ID.
+    ///
+    /// If the algorithm set internally is not valid, this function panics.
+    pub fn algo(&self) -> Result<HashAlgorithm, InvalidHashAlgorithm> {
+        HashAlgorithm::from_u32(self.algo).ok_or(InvalidHashAlgorithm(self.algo))
+    }
+
     pub fn as_slice(&self) -> Result<&[u8], InvalidHashAlgorithm> {
         match HashAlgorithm::from_u32(self.algo) {
             Some(algo) => Ok(&self.hash[0..algo.raw_len()]),
@@ -55,6 +76,41 @@ impl ObjectID {
     }
 }
 
+impl Display for ObjectID {
+    /// Format this object ID as a hex object ID.
+    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
+        let hash = self.as_slice().unwrap();
+        for x in hash {
+            write!(f, "{:02x}", x)?;
+        }
+        Ok(())
+    }
+}
+
+impl Debug for ObjectID {
+    /// Format this object ID as a hex object ID with a colon and name appended to it.
+    ///
+    /// ```
+    /// assert_eq!(
+    ///     format!("{:?}", HashAlgorithm::SHA256.null_oid()),
+    ///     "0000000000000000000000000000000000000000000000000000000000000000:sha256"
+    /// );
+    /// ```
+    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
+        let hash = match self.as_slice() {
+            Ok(hash) => hash,
+            Err(_) => &self.hash,
+        };
+        for x in hash {
+            write!(f, "{:02x}", x)?;
+        }
+        match self.algo() {
+            Ok(algo) => write!(f, ":{}", algo.name()),
+            Err(e) => write!(f, ":invalid-hash-algo-{}", e.0),
+        }
+    }
+}
+
 /// A hash algorithm,
 #[repr(C)]
 #[derive(Debug, Copy, Clone, Ord, PartialOrd, Eq, PartialEq)]
@@ -192,3 +248,78 @@ pub mod c {
         pub fn hash_algo_ptr_by_number(n: u32) -> *const c_void;
     }
 }
+
+#[cfg(test)]
+mod tests {
+    use super::HashAlgorithm;
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
+                assert_eq!(oid.as_slice().unwrap().len(), algo.raw_len());
+            }
+        }
+    }
+
+    #[test]
+    fn object_ids_format_correctly() {
+        let entries = &[
+            (
+                HashAlgorithm::SHA1.null_oid(),
+                "0000000000000000000000000000000000000000",
+                "0000000000000000000000000000000000000000:sha1",
+            ),
+            (
+                HashAlgorithm::SHA1.empty_blob(),
+                "e69de29bb2d1d6434b8b29ae775ad8c2e48c5391",
+                "e69de29bb2d1d6434b8b29ae775ad8c2e48c5391:sha1",
+            ),
+            (
+                HashAlgorithm::SHA1.empty_tree(),
+                "4b825dc642cb6eb9a060e54bf8d69288fbee4904",
+                "4b825dc642cb6eb9a060e54bf8d69288fbee4904:sha1",
+            ),
+            (
+                HashAlgorithm::SHA256.null_oid(),
+                "0000000000000000000000000000000000000000000000000000000000000000",
+                "0000000000000000000000000000000000000000000000000000000000000000:sha256",
+            ),
+            (
+                HashAlgorithm::SHA256.empty_blob(),
+                "473a0f4c3be8a93681a267e3b1e9a7dcda1185436fe141f7749120a303721813",
+                "473a0f4c3be8a93681a267e3b1e9a7dcda1185436fe141f7749120a303721813:sha256",
+            ),
+            (
+                HashAlgorithm::SHA256.empty_tree(),
+                "6ef19b41225c5369f1c104d45d8d85efa9b057b53b14b4b9b939dd74decc5321",
+                "6ef19b41225c5369f1c104d45d8d85efa9b057b53b14b4b9b939dd74decc5321:sha256",
+            ),
+        ];
+        for (oid, display, debug) in entries {
+            assert_eq!(format!("{}", oid), *display);
+            assert_eq!(format!("{:?}", oid), *debug);
+        }
+    }
+}
