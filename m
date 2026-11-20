Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.61.206.94
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795185883;
	b=Ht4dT1E+jls0uPNwUb7Kq4LDq8y4y5KN/gRTowvN1KENpKHYtxLessXFvAKbfIRskrWE
	 V6y5xBSZr7Q0aWxoscjPK+3BIynbSW3uTAhFgsb4968Jfspp7wPdZivk00Lfl4JbReQBk
	 WDvC8IP05GjUKituoGRGVTP3CqqZ/qs9rlHNfSROpsFvbwIUHqC2UC4BrNDf9O0aaLcjs
	 OGn6kK5My92srN1eVtXJMJXworTGuw8UAWXUN+dzXBDjPrHob9b9dW9IbhvagtF0xr4wb
	 Jx+uPofSHSTOZIADHYbWjhlt5nb3OwK8D0dyOs5f61KKCGobqT17RPs7npVLh607hYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795185883;
	h=DMARC-Filter:Received:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=nY7anjAx8SyDaqIj9NZ5u4LJC7gLqiFGN4OM2HTDCgE=;
	b=VvRZrZJxPGvr8yBGXoCYuoqFPCMxTpdSZqIy2W3fhUFiaBRcp084mTPVVyAYmpU5vsyq
	 e9M38zwQcLAJ2j01WDyMxJZkkjFExxaAx7vK//9MJPpKSY/J3njIAzHTm4cZAv2Jqosho
	 yjLxv98kzJzWZ2o6wo3ExB2K2INM8Sar1UJOHuJmOuJvOocdgkpTJvs229KeVX7xBaYud
	 tQe6L/lNaul16BKr+4Q1O7II0hwViZ8ACH68sGf2GYMWCQ9cAAESG4KrXphHa6vEAMa0x
	 EFRzFNjga6UQdKuwYazhBNbfM+AEkv1ZwQenSVpThMGrZ1/XF5M7thzcXz8VxuDmo5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gouders.net;
	spf=pass smtp.mailfrom=gouders.net;
	dkim=pass header.d=gouders.net header.i=@gouders.net header.a=rsa-sha256 header.s=gnet header.b=EZgWiIzk;
	arc=none smtp.remote-ip=202.61.206.94
Received: from mx10.gouders.net (mx10.gouders.net [202.61.206.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C5A3606A330
	for <git@vger.kernel.org>; Fri, 20 Nov 2026 14:44:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2C5A3606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gouders.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gouders.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gouders.net header.i=@gouders.net header.a=rsa-sha256 header.s=gnet header.b=EZgWiIzk
Received: from lena.gouders.net (ip-109-41-49-183.web.vodafone.de [109.41.49.183])
	(authenticated bits=0)
	by mx10.gouders.net (8.18.2/8.17.1.9) with ESMTPSA id 6AKEiRt92079849
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Fri, 20 Nov 2026 15:44:30 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gouders.net; s=gnet;
	t=1795185871; bh=nY7anjAx8SyDaqIj9NZ5u4LJC7gLqiFGN4OM2HTDCgE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=EZgWiIzknAZ1Jh3Co93+D89jjIVkbE9HxK3oqcKkJ+KIly+HIZ+ZGNh5vFSiI5XU8
	 e7uSldX5RbGUyEJTxSj7iWEKHthg+IHruoTFpWTte0g7m/zB5OCH5Y4MniSrh43pwX
	 P0u5OvB+e3taI2diq1/QGuhJ0DXh/HipSNMkB1Gw=
From: Dirk Gouders <dirk@gouders.net>
Date: Fri, 20 Nov 2026 15:44:26 +0100
Subject: [PATCH v3 3/4] utf8: respect string boundaries after skipping ANSI
 escape sequences
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
Message-Id: <20261120-master-v3-3-d28e8c75d26d@gouders.net>
References: <20261120-master-v3-0-d28e8c75d26d@gouders.net>
In-Reply-To: <20261120-master-v3-0-d28e8c75d26d@gouders.net>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Dirk Gouders <dirk@gouders.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1753; i=dirk@gouders.net;
 h=from:subject:message-id; bh=rcbLmFBbzY7t9heEJp/bSB0I5CZFlmgiYX5Qf8A7nCk=;
 b=owGbwMvMwMW4JPzVNXNTrzmMp9WSGLIZYs606h2xZrm9qGTpmcrkkzdvhM9y/73ik3Xb91S2D
 b51r24pdDJOYGFg5GKoElNkWTqpyC5NZcWLsm+qmTCDWJlApkiLNDAAAQsDX25iXqmRjpGeqbah
 niGQoWPkAJHjZ9BIL0h3SM8vTUktKtbLSy1xNLU0MjcydjUzMzJxtHC1MDdzMzMyNbN0NDE1d3V
 0MTM2NzY1cbR0ZuDiFIBZ53CMg2GdyhTfyfcXr9Rh7H7pfCHwYPvcY5cXrdU5wPeUjZdh65SNvR
 kSjPO1WLWlghoTW/qLL9n+axBqfLnXLUjXoWihf1Ysb5Pmc7kdm9ravS7k8/7eFmbY18b2uf/vx
 ud3n0qJJD6PqX60Stb8q2L1w0uyqS/7jCaxPTSQY6g3aK8/3RvJ5+ihp+lsphSY5HPuTcaMd4fP
 KOjefXw1/+zbhyka/3seGny5+kH5gsGsv01GPBKM9VWr1vkVnlw1NX6vmeQWFn1HK09xAeYJq2d
 vvfrO/RXjmesbI64f406YFh62ILlj+r8826zSFy27lqvzfTtj+bptqyvXbw2Fdh5Dh4VBz377Sm
 3L/CMdcfdQHQA=
X-Developer-Key: i=dirk@gouders.net; a=openpgp;
 fpr=943B4FA3CAB8EBC55754E5EA0DA2395F431875F6

utf8_strnwidth() can skip ANSI escape sequences and it is possible
that such sequences end the string within the given boundary.

Check for such situations before proceeding and calling utf8_width().

Add tests that test such corner cases.

Signed-off-by: Dirk Gouders <dirk@gouders.net>
---
 t/unit-tests/u-utf8-width.c | 11 +++++++++++
 utf8.c                      | 10 +++++++---
 2 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/t/unit-tests/u-utf8-width.c b/t/unit-tests/u-utf8-width.c
index 86e09c3574..5e2b636db9 100644
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
+	cl_assert_equal_i(3, utf8_strnwidth("\033[31mhello", 4, 1));
+	cl_assert_equal_i(0, utf8_strnwidth("\033[31mhello", 5, 1));
+	cl_assert_equal_i(1, utf8_strnwidth("\033[31mhello", 6, 1));
+}
+
 /*
  * Test utf8_strnwidth with various Chinese strings
  * Chinese characters typically have a width of 2 columns when displayed
diff --git a/utf8.c b/utf8.c
index 35b2bb8290..493f723e3b 100644
--- a/utf8.c
+++ b/utf8.c
@@ -226,9 +226,13 @@ int utf8_strnwidth(const char *string, size_t len, int skip_ansi)
 		int glyph_width;
 		size_t skip;
 
-		while (skip_ansi &&
-		       (skip = display_mode_esc_sequence_len(string, end)))
-			string += skip;
+		if (skip_ansi) {
+			while ((skip = display_mode_esc_sequence_len(string, end)))
+				string += skip;
+
+			if (string >= end)
+				break;
+		}
 
 		glyph_width = utf8_width(&string, NULL);
 		if (glyph_width > 0)

-- 
2.55.0

