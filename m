Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B793B1C701F
	for <git@vger.kernel.org>; Sun, 19 Jul 2026 01:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784423337; cv=none; b=rwio7kFnX+bPwnZPsYHdEntTDp0duuLJI1lS7vjwG5qt352CeAMBduk037wLYbJhABl4fySyK10rnPExLmGlZ+ilGUprVdJTw3fPXvJvBvacL7gNpxDsKCAJ4YCDQ3BvIqSvAgbUlDt5+daEWKzVXCuzasDMsj89GK2dZfk+RnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784423337; c=relaxed/simple;
	bh=vbUvMPWFnYm2/XL/089YkULDyI7O54Zv+T779Qk0IOo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MOe/t4mdfqfxrhAun6QsC91NJqoZ0RYAm8LRwUQvn+wU92fH/axMPhzwQ7FgWWmOPGNmEzuB791P/V4A7CibQljgZ6SzKH+y4E2H3QdYu6rn71tO4Ostgowd1a41i3pQEBqCFbIjqMOJJyEGsC48+pliWdZkv/Q/YDxxrTkIouk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=OObkCO76; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="OObkCO76"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1784423328;
	bh=vbUvMPWFnYm2/XL/089YkULDyI7O54Zv+T779Qk0IOo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
	 Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	 In-Reply-To:References:Content-Type:Content-Disposition;
	b=OObkCO76IoMiy08dbk+IQXJ8Sm6iHoXQgWYQ7V4ERPKcT1rBpBxmB8xBtfXJlNXmx
	 TZeEJGuavPHCKwKup0riaaZGHIrOuKyWAf/7X2SevV1z4jkYH8uLkkRUOpeTE6H4BM
	 uOWT0o3+UVdinN0ZOh6RU6+dTI5h2juBYlLM01konr4BYZ0AVmZdUniwyYB0WtHt5z
	 S8QdefcFJsZDrePYf8dxi2FXaZmp9uEOETRNkt6ZJN9FAX4Vk4516As5gFbQx7P5WS
	 WKT8eY1hbg7Yd0dapLmZl4gMfYH7fSBiFHgkov6XBtgL2aF7IbUKEsN9YKgSCvhENU
	 DHl7nH2CXeyeL0ReSKZf3Ho9QrGfqBSSVwFIAHaYgAKJCrtF13UdCI3NLm0mnFzCQH
	 7SuOq0NwOuH8tftROjzojbJFX4xcoYnqWn2EU0229Dh/+wuU49hZteeK0DFR07/twn
	 QtmkxpLlVTQwS2iOplZVJqsonMONFzj+PNznJUQ7deZrf1AYXau
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:e344:7908:59b:a90a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 1425B2010D;
	Sun, 19 Jul 2026 01:08:48 +0000 (UTC)
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 1/2] hash: initialize context before cloning
Date: Sun, 19 Jul 2026 01:08:41 +0000
Message-ID: <20260719010842.17991-2-sandals@crustytoothpaste.net>
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

Our C-based clone helper requires that the context be initialized, but
we neglect to do that in our Clone implementation for CryptoHasher.
This does not matter when using our default block SHA-256
implementation, but it does cause a crash when using OpenSSL as the
backend.  Fix this by properly initializing the context before cloning
into it.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 src/hash.rs | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/src/hash.rs b/src/hash.rs
index dea2998de4..4d14e4b4fa 100644
--- a/src/hash.rs
+++ b/src/hash.rs
@@ -181,7 +181,10 @@ impl CryptoDigest for CryptoHasher {
 impl Clone for CryptoHasher {
     fn clone(&self) -> Self {
         let ctx = unsafe { c::git_hash_alloc() };
-        unsafe { c::git_hash_clone(ctx, self.ctx) };
+        unsafe {
+            c::git_hash_init(ctx, self.algo.hash_algo_ptr());
+            c::git_hash_clone(ctx, self.ctx)
+        };
         Self {
             algo: self.algo,
             ctx,
