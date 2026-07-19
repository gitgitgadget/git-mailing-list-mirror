Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B79911E260C
	for <git@vger.kernel.org>; Sun, 19 Jul 2026 01:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784423336; cv=none; b=K4pGDpQeKNqX2oiz8Z2+Iq/2qe0ANyOc0e3NerkNxTNbPK1GMBABA5z1hEQnjdTX8oqlGYHGO6u2pRQCY37Hr2HnpOnH2kpDDy+GgTN1D2bGHM6Y6FCt0IjLk3/XtVPpCa/xzkhs9Q98lJIYptXBufvM47D6lOVd8DC5qdGARLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784423336; c=relaxed/simple;
	bh=H00YPR7UQsURO2dJQSP2z0Ceo95tTsYZXNtPexh2dl8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EBe+w0v67c017sjwxsm5XVUaN3YtMN03m7iUAXv1/S0/up+yLl2rncA711YXUaQP0CO+4oh72adZgArYabAs4XluMKbPFBu2g1Mqu0IcsmO/k0vYBeXBUSRQmGjRv39TEWjHPZRGJNXRrNgpHijkbFljC6sWhpUeXXbogS/UsLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=lU3I6nzn; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="lU3I6nzn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1784423328;
	bh=H00YPR7UQsURO2dJQSP2z0Ceo95tTsYZXNtPexh2dl8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
	 Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	 In-Reply-To:References:Content-Type:Content-Disposition;
	b=lU3I6nznY4WMDZ1fZ6i0pDDPOpx3iuC61DjE7gB2w8JQTdQtUk+Ak3zXTC5BEcPB5
	 SANwRX/drtLJkPKcupcsa72b16VH21ezVT1JAW1EfrnUe5Ggb8K73G1YScCZrWwN6u
	 w+FqwnmLI+q3cnp2IvuknBNBPzvudzdgveO0x2YeVcz6YGF5Bdn1ihna0Ee+iRoKGS
	 U6CvKObJp1ODRN1KIEcNXCAcmJKp0BrlFQ+0ODbU7Mp7US/BEiLNuYwExgHvCEoQss
	 lYD8wsgUg5FKRbwmUoAyA6xO1S8g4uWTW99YdBVdjdB+MYdfvchjvfMzBpZxOq5knc
	 JAcrCzs8Cu3ULEV3ijVMRZ1pM8acsT7lBy//pmPO81YIHotMDgg2Fkvx76DIiKxWOA
	 4aUK6gxDHWyZAO+1KxKTKHxkLBzcQy/0W/xdZgVJ9Lbr74uFD32TgGLVWKoVuPhPcJ
	 XKe6ktKoF1mX/cv+SX5XevCdHbU1txJNyWuEgitjNbzvVU9QJ+v
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:e344:7908:59b:a90a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 1D69720192;
	Sun, 19 Jul 2026 01:08:48 +0000 (UTC)
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 2/2] rust: discard hash context when finished
Date: Sun, 19 Jul 2026 01:08:42 +0000
Message-ID: <20260719010842.17991-3-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.53.0.697.g625c4fb2daa
In-Reply-To: <20260719010842.17991-1-sandals@crustytoothpaste.net>
References: <20260719010842.17991-1-sandals@crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When we allocate a context but then abandon it, we never discard it,
which means that the underlying crypto library context may leak.  This
doesn't happen with our default block code, but it may with OpenSSL.
Note that we do call git_hash_free, which frees the memory we called
from git_hash_alloc, but doesn't discard the underlying context itself.

This can be seen with the following command when compiling with OpenSSL
and running with nightly Rust:

    RUSTFLAGS='-Z sanitizer=leak' cargo test

Discard the context in our context handler.  Note that it is fine to do
so even after finalizing the context, so our final functions which take
self instead of &mut self will not mishandle memory.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 src/hash.rs | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/src/hash.rs b/src/hash.rs
index 4d14e4b4fa..e1f2d31fc3 100644
--- a/src/hash.rs
+++ b/src/hash.rs
@@ -194,7 +194,10 @@ impl Clone for CryptoHasher {
 
 impl Drop for CryptoHasher {
     fn drop(&mut self) {
-        unsafe { c::git_hash_free(self.ctx) };
+        unsafe {
+            c::git_hash_discard(self.ctx);
+            c::git_hash_free(self.ctx);
+        };
     }
 }
 
@@ -356,6 +359,7 @@ pub mod c {
         pub fn git_hash_clone(dst: *mut c_void, src: *const c_void);
         pub fn git_hash_update(ctx: *mut c_void, inp: *const c_void, len: usize);
         pub fn git_hash_final(hash: *mut u8, ctx: *mut c_void);
+        pub fn git_hash_discard(ctx: *mut c_void);
         pub fn git_hash_final_oid(hash: *mut c_void, ctx: *mut c_void);
     }
 }
@@ -450,6 +454,7 @@ mod tests {
                 h.update(&data[2..]);
 
                 let h2 = h.clone();
+                let h3 = h2.clone();
 
                 let actual_oid = h.into_oid();
                 assert_eq!(**oid, actual_oid);
@@ -463,6 +468,7 @@ mod tests {
 
                 let actual_oid = h.into_oid();
                 assert_eq!(**oid, actual_oid);
+                std::mem::drop(h3);
             }
         }
     }
