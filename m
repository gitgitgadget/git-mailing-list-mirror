Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.61.206.94
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794855441;
	b=2Nke7FL62XAU4B9xfXGXdeMnyYTRrAtrB6IrUej/LWhJC5zANiMfz2+5airtkcTG/M6+
	 6gq4Nhx9xmDXaVImn8VkYU/9MBnar0E/9YVrLmfo7swplwL3c327UcmhWNdb+IkbRhTjp
	 HUo0h5KkPXDlyF2C4kKzaaTUDL5foOUbOqk1oUmQbfh6Q52/azCVy83T6JWeyMOQKi0ln
	 eV+ASSP/hzDDALCStxpoa5jv86khZWZIc/bqoMGCANg5HmPYBeAeSguG5LxNwNiTN5uTy
	 3I39gvsUFvQf8HxDO78+iAngkT88PtdstIFaj+fiZQ9iqT5hobCA8nyR0/WFo21rgOA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794855441;
	h=DMARC-Filter:Received:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=jQ7edrPUjOd9uswF5674I4MMMbffnlhWtKI900KrC7U=;
	b=EZyY9d7QahcmA/2gjNCSJx+kHem8ENJAnLU1OZHq1o5QRj2g2iyFU8vhZgFDWm35oc9K
	 3IJB8aDXDOlZqUNddRjqXtHGQ7O/212aD4KlnWkTj3J8SKAwYGMiIMaz1A5Ynf6t2sg0e
	 Ql01sgtzg0HRUCoy1xE3fTeb21hwn5Hbz/Zgu2xi8ElJmflOfGtVQV+G/TGl0qWqlHUAf
	 LyzbcKL5+/RgRbjq+HdSb1znYL0ozTyHseox6fo3WzdPRvEsnHiH+fIcO0laZY7hn3obY
	 xNVh6guBXt3k1AfyGvE2ZoOXYiAbNJC8V41JdePumf23KHwvuAvEAk/spncHKXq5hbA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gouders.net;
	spf=pass smtp.mailfrom=gouders.net;
	dkim=pass header.d=gouders.net header.i=@gouders.net header.a=rsa-sha256 header.s=gnet header.b=t3XRig16;
	arc=none smtp.remote-ip=202.61.206.94
Received: from mx10.gouders.net (mx10.gouders.net [202.61.206.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5D69606A333
	for <git@vger.kernel.org>; Mon, 16 Nov 2026 18:57:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E5D69606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gouders.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gouders.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gouders.net header.i=@gouders.net header.a=rsa-sha256 header.s=gnet header.b=t3XRig16
Received: from lena.gouders.net (ip-109-41-49-131.web.vodafone.de [109.41.49.131])
	(authenticated bits=0)
	by mx10.gouders.net (8.18.2/8.17.1.9) with ESMTPSA id 6AGIv93M1753958
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Mon, 16 Nov 2026 19:57:11 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gouders.net; s=gnet;
	t=1794855431; bh=jQ7edrPUjOd9uswF5674I4MMMbffnlhWtKI900KrC7U=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=t3XRig16QxdrksCLdxbzW/hkItMncsnPTgNr/72brtqKsIKu6ib1Yoea68WldBgfg
	 fwclcMf8/bpeVyhM2NA3wSE/vLrgA/xEZOFswmCHTIdTDodWkHmpkxjB1537fEXYOF
	 wYg4hFkZNN4lEvS1KCaMPPEex7njWMwoW8bEyrKg=
From: Dirk Gouders <dirk@gouders.net>
Date: Mon, 16 Nov 2026 19:57:00 +0100
Subject: [PATCH 1/2] utf8: respect bounds in utf8_strnwidth()
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261116-master-v1-1-dc2a50ce0aa0@gouders.net>
References: <20261116-master-v1-0-dc2a50ce0aa0@gouders.net>
In-Reply-To: <20261116-master-v1-0-dc2a50ce0aa0@gouders.net>
To: git@vger.kernel.org
Cc: Dirk Gouders <dirk@gouders.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2576; i=dirk@gouders.net;
 h=from:subject:message-id; bh=caIg5ax6I2fuTZ7QxQWKk9UUgc4zJCLJN5M+XueKshM=;
 b=owGbwMvMwMW4JPzVNXNTrzmMp9WSGLJ+B7GdP+i58LZdvOe/k6Yeu0wsIoxe+0a1xNR8k5Tq/
 8deLjCtk3ECCwMjF0OVmCLL0klFdmkqK16UfVPNhBnEygQyRVqkgQEIWBj4chPzSo10jPRMtQ31
 DIEMHSMHiBw/g0Z6QbpDen5pSmpRsV5eaomjqaWRuZGxq5mZkYmjhauFuZmbmZGpmaWjiam5q6O
 LmbG5samJo6UzAxenAMw6bW72/4VvzDurPZsCXtaYXPLRaC5p0XilpHCtx2v6t03mW3oCN5Yr1B
 881744+GErn+vnqL1p9o73bBhM5BbMKVfaXf0vzbSiYs3N6uc6QbJuPtOnBnFNn6vEyOz1aYWBx
 P6Lk8+21LjkrTCIW2C/bMFqwX9BrC+n/pp2dPLZLF+RqBKTX5umvtSL6PDs7WTcsnKSnWC1znuN
 zh1rbFXseNSevq64EaHzvtXi+zTxT7NE7XRfGcju8OA7zlip2W/9m3/15AcMu/fIlN5rVz59d/f
 yaQ8V6m0vrOxbaTXv0Edu6zmH3xzv32d59veB73YWzo4Xlvcwxb14kpmVbhof+VYwbqGxnfDbJr
 s1hU9K2tmUAA==
X-Developer-Key: i=dirk@gouders.net; a=openpgp;
 fpr=943B4FA3CAB8EBC55754E5EA0DA2395F431875F6

utf8_strnwidth() takes a len argument, but because
display_mode_esc_sequence_len() works without an explicit boundary,
there are cases when utf8_strnwidth() operates beyond the given len
boundary.

Fix this by adding a boundary-check after looping with
display_mode_esc_sequence_len() to ensure we operate strictly within
the given len.

Further, add three corner case tests of which two will fail without
the fix:
------------------------------------------------------------------------
not ok 257 - utf8_width::strnwidth_ansi
    ---
    reason: |
      Expected comparison to hold: 0 == utf8_strnwidth("\033[31mhello", 4, 1)
      0 != 1
    at:
      file: 't/unit-tests/u-utf8-width.c'
      line: 11
      function: 'test_utf8_width__strnwidth_ansi'
    ...
------------------------------------------------------------------------

With the fix:
------------------------------------------------------------------------
ok 257 - utf8_width::strnwidth_ansi
------------------------------------------------------------------------

Signed-off-by: Dirk Gouders <dirk@gouders.net>
---
 t/unit-tests/u-utf8-width.c | 11 +++++++++++
 utf8.c                      | 10 +++++++---
 2 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/t/unit-tests/u-utf8-width.c b/t/unit-tests/u-utf8-width.c
index 86e09c3574..60538fc26f 100644
--- a/t/unit-tests/u-utf8-width.c
+++ b/t/unit-tests/u-utf8-width.c
@@ -2,6 +2,17 @@
 #include "utf8.h"
 #include "strbuf.h"
 
+/*
+ * Test utf8_strnwidth for strings with SGR sequences and corner case length
+ * arguments.
+ */
+void test_utf8_width__strnwidth_ansi(void)
+{
+	cl_assert_equal_i(0, utf8_strnwidth("\033[31mhello", 4, 1));
+	cl_assert_equal_i(0, utf8_strnwidth("\033[31mhello", 5, 1));
+	cl_assert_equal_i(1, utf8_strnwidth("\033[31mhello", 6, 1));
+}
+
 /*
  * Test utf8_strnwidth with various Chinese strings
  * Chinese characters typically have a width of 2 columns when displayed
diff --git a/utf8.c b/utf8.c
index 96460cc414..7e050bb2c4 100644
--- a/utf8.c
+++ b/utf8.c
@@ -217,9 +217,13 @@ int utf8_strnwidth(const char *string, size_t len, int skip_ansi)
 		int glyph_width;
 		size_t skip;
 
-		while (skip_ansi &&
-		       (skip = display_mode_esc_sequence_len(string)) != 0)
-			string += skip;
+		if (skip_ansi) {
+			while ((skip = display_mode_esc_sequence_len(string)) != 0)
+				string += skip;
+
+			if (string >= orig + len)
+				break;
+		}
 
 		glyph_width = utf8_width(&string, NULL);
 		if (glyph_width > 0)

-- 
2.55.0

