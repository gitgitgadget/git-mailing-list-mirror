Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.61.206.94
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795036146;
	b=KmgKNLqavulaC/ajzwGrIOLtcCdljjVtLKWdaFuQy2OiUB9vN0AI9c1lPOWOnBLxNaW3
	 comXgjNGZsyFE7EDmmHpJRJqpac1Lq7mTfuTppuaZy66KFlZDAWRY7qxuLoXlLbV1P9Ug
	 QoVuZ7YGazK9l+ugLQFGoYYLuWm5xXfw3ULhR4Nz9EErmqUS4njPwXuAZsi3/ImH02NRu
	 nAmpLalhCdZUG5EHudT+Oacj9cHrU0HO+A68I1smrBCqUm/tFHyu7FqVhefNDbjgZbiKq
	 i5qh4cahMzcLsajbppJyxvAQE4Lq+CyQXhtcelvcrE13BLLKfqkGeEXja8iDKJvLXNA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795036146;
	h=DMARC-Filter:Received:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=vN9+h0Mo9oeAFltixXBfWamedwRkBQ4Y16krlgV99Tk=;
	b=b0xF2IpkQzJYt4EVI/HsbWwCZXoaYTNjxcPGgIkHv+8eLuMofDzRJxOdwHucaHVCeYMf
	 pkOl5UMWQGLqEWQKl9dGnctIb8/A5vRA2Q6Uqlc3QLF8DgsYq7fwfcahPXQqWIZ+TNoCk
	 2nJDj6P88hyDG+KLq6WkN3dl+x3qBvU2u25JvNlzFJ5w9/8dddSLQbhond0meNSyfmPKC
	 bRb/J+SgRmLkVzf6DFYIIoMcKTGQLD8IlzTdTeMJxtxq5SA9OVcBxzIciiNRidzu7hNln
	 /UBXIttZXgOnGvddtR3qSiB2VSsj1spY5yVKU7T5SJ0jWqukdCiMXqXyk3xD8mawz6A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gouders.net;
	spf=pass smtp.mailfrom=gouders.net;
	dkim=pass header.d=gouders.net header.i=@gouders.net header.a=rsa-sha256 header.s=gnet header.b=NLyRrggP;
	arc=none smtp.remote-ip=202.61.206.94
Received: from mx10.gouders.net (mx10.gouders.net [202.61.206.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72FF7606A325
	for <git@vger.kernel.org>; Wed, 18 Nov 2026 21:09:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 72FF7606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gouders.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gouders.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gouders.net header.i=@gouders.net header.a=rsa-sha256 header.s=gnet header.b=NLyRrggP
Received: from lena.gouders.net (ip-109-41-49-52.web.vodafone.de [109.41.49.52])
	(authenticated bits=0)
	by mx10.gouders.net (8.18.2/8.17.1.9) with ESMTPSA id 6AIL8tdP1931210
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Wed, 18 Nov 2026 22:09:03 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gouders.net; s=gnet;
	t=1795036143; bh=vN9+h0Mo9oeAFltixXBfWamedwRkBQ4Y16krlgV99Tk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=NLyRrggPMHVpYvgjkiReDeVZYk5nCXjZhwKzMtKH7V9BYEe/Z0pN4qkoHQmj08ge/
	 tuD3BXXyuj1Cf+kcy6hQWfJfvVm9R3Ab1RPTh/IsMM9/refHhRy+dI9XtITdqWNYn6
	 xMebxrzrHC0IM838Qyv8dGsudc5gMtb6tWR0Jp5w=
From: Dirk Gouders <dirk@gouders.net>
Date: Wed, 18 Nov 2026 22:08:52 +0100
Subject: [PATCH v2 3/4] utf8: respect string boundaries after skipping ANSI
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
Message-Id: <20261118-master-v2-3-3f2aaec15d31@gouders.net>
References: <20261118-master-v2-0-3f2aaec15d31@gouders.net>
In-Reply-To: <20261118-master-v2-0-3f2aaec15d31@gouders.net>
To: git@vger.kernel.org
Cc: Dirk Gouders <dirk@gouders.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1847; i=dirk@gouders.net;
 h=from:subject:message-id; bh=v/rNSLmpcQ/pdK88YKCsYdMymsO+3sV5BKbKFIyhSLU=;
 b=owGbwMvMwMW4JPzVNXNTrzmMp9WSGLL+Cb8t2ZuT0nz2c3GD3OPp8k+8Nm3yM9Taf3u/AO8/p
 ofebdzZnYwTWBgYuRiqxBRZlk4qsktTWfGi7JtqJswgViaQKdIiDQxAwMLAl5uYV2qkY6Rnqm2o
 Zwhk6Bg5QOT4GTTSC9Id0vNLU1KLivXyUkscTS2NzI2MXc3MjEwcLVwtzM3czIxMzSwdTUzNXR1
 dzIzNjU1NHC2dGbg4BWDW5Sxi/1/pfv7L+rhn8WKByRXrim5YqxkzHDll03bCvff6j7Yq75U13V
 JnGTdfTK7a5Mg/M9ZA5/OLGWypqg3Fz46kNhc79q39wLmG4V/spIx9j+0WbYpneG7dGWal/EZh1
 4EHPO0+T1/y/rWNtyjflX/k7aKL9hdXPq789uVRUlPo2yn3rl70mHuw7iYX6x7fWdsfOxce7Z/g
 le5yalP7lAs5Xz86u9w6JsIz6cj2HpWjZ1e+/M6js3vmQZEfdi8SY79t1bm0+0HlfMu7f1eoS2w
 1SKzjXP/VOoLlcev1s95f3l4MlxKcf+zc/Fe7o9v+xmzzmJHzcxqDSU2ldYrYdWXWb6dyv1xPz2
 m5XLns7oUNy88ZAQA=
X-Developer-Key: i=dirk@gouders.net; a=openpgp;
 fpr=943B4FA3CAB8EBC55754E5EA0DA2395F431875F6

utf8_strnwidth() can skip ANSI escape sequences and it is possible
that such sequences end the string within the given boundary.

Check for such situations before proceeding and calling utf8_width().

Add tests that test such corner cases.

Signed-off-by: Dirk Gouders <dirk@gouders.net>
---
 t/unit-tests/u-utf8-width.c | 11 +++++++++++
 utf8.c                      | 12 ++++++++----
 2 files changed, 19 insertions(+), 4 deletions(-)

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
index b43f84a03d..1b88324ea3 100644
--- a/utf8.c
+++ b/utf8.c
@@ -230,10 +230,14 @@ int utf8_strnwidth(const char *string, size_t len, int skip_ansi)
 		int glyph_width;
 		size_t skip;
 
-		while (skip_ansi &&
-		       (skip = display_mode_esc_sequence_len_counted(string,
-							orig + len - string)) != 0)
-			string += skip;
+		if (skip_ansi ) {
+			while ((skip = display_mode_esc_sequence_len_counted(string,
+									     orig + len - string)) != 0)
+				string += skip;
+
+			if (string >= orig + len)
+				break;
+		}
 
 		glyph_width = utf8_width(&string, NULL);
 		if (glyph_width > 0)

-- 
2.55.0

