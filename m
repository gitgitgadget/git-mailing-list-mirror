Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.61.206.94
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795359093;
	b=abbeFhXI4FHvqG9YqMiiu5Kha6YigyPgPw5BaTzx9vkUIoPvvIf0tudt+4LdzZeLmKGA
	 bGOmzDcZ7Dw7hnrhRoOwsQ1yVXSmvCceJ5Yct7F5VgEfoAQ4nGnq/inqGs1lGNk8fSW9W
	 QuzH1r0qnXTBm6PBwQ3jmyRW8lMAgLlv7w9T4G+geC5vEJS0+HnPIjlxaEKVBhlxbuNwE
	 pX5rQ8FLX6gxZu0tRxOyz1REGkQtZEfoHxw8FYR5L3Jp35yuDSFIsxFuP0rKP1cvNPKes
	 bQUP6jkCi9X9ogl6e32cIR0oir36HYJmU7ZtwD0hFj4pHWNjSTA22YAdoGkE39QXW3w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795359093;
	h=DMARC-Filter:Received:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=WMqzsdIwsZhUomZmuOjzA8no198rrQsBWSiGCpAeqs8=;
	b=CYPbFhPVgiuRijdL/b2fg1OmJjg7VB0Z4v2K22F1MkSrtziRSrrv4zxaVgJM/PjlTuIM
	 /Y9UdkTL9uPbjmrbpH+uoj9OkTJ87Owd9uLpw5wHQc/XdYJ8IUw2KA34eCVcRQuXfi8VG
	 TMjxnkjlLB6bhipkZ9CJnnJjBYBTcG8hadL8743PsiX8wKN8mMxH0DwP9qi1Zdu0O8GLx
	 UMspeUvoaG75Rii/XCyGywGFhwGGCOWHkR88SMW6CfW6YVcG41FRuch/RXUtodxcs5fj5
	 C7WEwxj8IRtd/KUur/seJHH4Asok1dJjdFD/xCUSo9wWxkJfA5406qJcCdtiYHtJiTw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gouders.net;
	spf=pass smtp.mailfrom=gouders.net;
	dkim=pass header.d=gouders.net header.i=@gouders.net header.a=rsa-sha256 header.s=gnet header.b=tguPBHRv;
	arc=none smtp.remote-ip=202.61.206.94
Received: from mx10.gouders.net (mx10.gouders.net [202.61.206.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50F6C606A32A
	for <git@vger.kernel.org>; Sun, 22 Nov 2026 14:51:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 50F6C606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gouders.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gouders.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gouders.net header.i=@gouders.net header.a=rsa-sha256 header.s=gnet header.b=tguPBHRv
Received: from lena.gouders.net (ip-109-41-49-183.web.vodafone.de [109.41.49.183])
	(authenticated bits=0)
	by mx10.gouders.net (8.18.2/8.17.1.9) with ESMTPSA id 6AMEpQ7u2232929
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Sun, 22 Nov 2026 15:51:29 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gouders.net; s=gnet;
	t=1795359089; bh=WMqzsdIwsZhUomZmuOjzA8no198rrQsBWSiGCpAeqs8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=tguPBHRvJAUJ3TsiThPILRmXyZrodFOQAQ++C9dy5Z7ok/ZVR79JQw1n2ij1hDiJt
	 RvvkfgFPHtl+S+lPYTsGCvBsFW4LFGK1ywBxdm4LAIuNO6yk28cyAq0z/qJbDZgJfU
	 6lkHZPzOeOSngcndbYwex+CdHuBJKHTFKr75toYw=
From: Dirk Gouders <dirk@gouders.net>
Date: Sun, 22 Nov 2026 15:51:27 +0100
Subject: [PATCH v5 4/4] utf8: respect boundaries in utf8_strnwidth()
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
Content-Transfer-Encoding: 8bit
Message-Id: <20261122-master-v5-4-313bd1bb3c45@gouders.net>
References: <20261122-master-v5-0-313bd1bb3c45@gouders.net>
In-Reply-To: <20261122-master-v5-0-313bd1bb3c45@gouders.net>
To: git@vger.kernel.org
Cc: "Junio C Hamano <gitster@pobox.com>, Andy Koppe" <andy.koppe@gmail.com>,
        Dirk Gouders <dirk@gouders.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1897; i=dirk@gouders.net;
 h=from:subject:message-id; bh=SgAvKNn3Nzl07pJNyveKBFFByx55Xv9cy4b9I9s9+jI=;
 b=owGbwMvMwMW4JPzVNXNTrzmMp9WSGLKZGfOVdkz/bRr0Vpq/+YBbt4fvnVfvxKP7pZK1n6gEa
 Xh9EJjfyTiBhYGRi6FKTJFl6aQiuzSVFS/KvqlmwgxiZQKZIi3SwAAELAx8uYl5pUY6Rnqm2oZ6
 hkCGjpEDRI6fQSO9IN0hPb80JbWoWC8vtcTR1NLI3MjY1czMyMTRwtXC3MzNzMjUzNLRxNTc1dH
 FzNjc2NTE0dKZgYtTAGbdvDns/9QXtWuue/+ZTyvrUzvvgjfvji5dd+TC5qP+QSp7Ml0P+/c0S0
 zoN5LWqzDjyXx6253p2Or696z6+fXv3newlLLx/rx+RbjGTOXR21D5y1tvJm//+3+y99TMKVOZb
 rmcXn6zU77v9kYNrq9rnS6+Ku1bEb74mwuf/cq3KqI3zn75G+cRo8rj4TRH/dYZ4U0OBZLH/JY/
 e+jt8b47dcfDn3qLD5b+fzqlY1HAq8qo7yo+v151VvnO2Rz6ctuDX8XGN+U/nv6xbGaK8zE5oVr
 uuddUHJnOdXC2R+/x+ZLlJc1wp9345q64b8EHtv3LZVl7RF7V039qYA/br5qUydFbXCrtp12ccr
 vDMbnRTUP4WC8A
X-Developer-Key: i=dirk@gouders.net; a=openpgp;
 fpr=943B4FA3CAB8EBC55754E5EA0DA2395F431875F6

utf8_strnwidth() can be called with boundaries that effectively cause
incomplete multibyte sequences and we should return "len" in such
cases.

But, utf8_width is used without its optional boundary argument and
will thus work beyond the given boundary.

Fix this by using the boundary argument for utf8_width.
Add some tests that cover such situations.

Signed-off-by: Dirk Gouders <dirk@gouders.net>
---
 t/unit-tests/u-utf8-width.c | 9 +++++++++
 utf8.c                      | 5 ++++-
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/t/unit-tests/u-utf8-width.c b/t/unit-tests/u-utf8-width.c
index 5e2b636db9..c4df4dd6a6 100644
--- a/t/unit-tests/u-utf8-width.c
+++ b/t/unit-tests/u-utf8-width.c
@@ -2,6 +2,15 @@
 #include "utf8.h"
 #include "strbuf.h"
 
+/*
+ * Test utf8_strnwidth for cjk characters invalidated by len argument.
+ */
+void test_utf8_width__strnwidth_cjk_chopped(void)
+{
+	cl_assert_equal_i(1, utf8_strnwidth("三bytes long, 二columns wide", 1, 1));
+	cl_assert_equal_i(2, utf8_strnwidth("三bytes long, 二columns wide", 3, 1));
+}
+
 /*
  * Test utf8_strnwidth for strings with SGR sequences and corner case length
  * arguments.
diff --git a/utf8.c b/utf8.c
index dfc5261619..f7fb419545 100644
--- a/utf8.c
+++ b/utf8.c
@@ -229,6 +229,7 @@ int utf8_strnwidth(const char *string, size_t len, int skip_ansi)
 	while (string && string < orig + len) {
 		int glyph_width;
 		size_t skip;
+		size_t remainder;
 
 		if (skip_ansi) {
 			while ((skip = display_mode_esc_sequence_len_counted(string,
@@ -239,7 +240,9 @@ int utf8_strnwidth(const char *string, size_t len, int skip_ansi)
 				break;
 		}
 
-		glyph_width = utf8_width(&string, NULL);
+		remainder = orig + len - string;
+
+		glyph_width = utf8_width(&string, &remainder);
 		if (glyph_width > 0)
 			width += glyph_width;
 	}

-- 
2.55.0

