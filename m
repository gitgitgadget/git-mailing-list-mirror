Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.61.206.94
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795187500;
	b=DsCzNR+HOqJQHeBXHvMTwZIfT3GnKqFnMROT35fECIQmsBbySnX/QBnfVQgZfVqmMzCE
	 6zENdgM1tSrrJoJwIo3d912JgbhtTaOPXTgRBdlnEZeo4Twbc5wMFzc/BuDgLm/vophe8
	 1iTfa6Ibx3laHX/pyGkOjFJsi4ksmxg3FFbfQAlBpRxhHioUrWIlyy7tcJp2xluzLgtb2
	 atk6YqZ30WopI+QRXvZ034kX+OJNW3ow5fF4m75J3WOnYJMfzimEphpuL98EwPVq4SVvE
	 mN3Aay03kwpvdsXbWUxhVfJT++MpjY7D891fULgOatba/dOl6Uroxakx7K1iJQs5QJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795187500;
	h=DMARC-Filter:Received:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=vKzSjcakLSZLpK7SdiZCfHFpNI2870JVRByPkZJH7bA=;
	b=HW0Oc+HbGgnB2Rm5vzoQpsW7AElkpuLopr1o2q9FjizNy/keGkiIIvJcea93f0hjNSoZ
	 RZMfGamyFHZHclBE7TIWsXGqSkVwHfdQDsFUvG6nOQrPs2mQMP82Tt7Lpt5nBgL9j5QFi
	 kehHKtMA/Ox23iuHBpNGs7Eji94KVhhnphOfDK7KqVIo0bDS/fbDAGTWsTyTJ/PEDsxUr
	 oNku+PAmXqNThXS6FO7z1/UBG1ZRaMmKMTYMm8IMvGx7EvW9fkvIVLw4E7cvqNP4mMrBF
	 ZIK9l3rvn87Jn4F196AI22wegXQq64TNhvmiScCFW0bueao5wqMVoguEd2br8v2yqjQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gouders.net;
	spf=pass smtp.mailfrom=gouders.net;
	dkim=pass header.d=gouders.net header.i=@gouders.net header.a=rsa-sha256 header.s=gnet header.b=doc5jP4e;
	arc=none smtp.remote-ip=202.61.206.94
Received: from mx10.gouders.net (mx10.gouders.net [202.61.206.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28DDC606A33E
	for <git@vger.kernel.org>; Fri, 20 Nov 2026 15:11:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 28DDC606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gouders.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gouders.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gouders.net header.i=@gouders.net header.a=rsa-sha256 header.s=gnet header.b=doc5jP4e
Received: from lena.gouders.net (ip-109-41-49-183.web.vodafone.de [109.41.49.183])
	(authenticated bits=0)
	by mx10.gouders.net (8.18.2/8.17.1.9) with ESMTPSA id 6AKFBTTh2082197
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Fri, 20 Nov 2026 16:11:35 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gouders.net; s=gnet;
	t=1795187496; bh=vKzSjcakLSZLpK7SdiZCfHFpNI2870JVRByPkZJH7bA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=doc5jP4eatszqhf+2q68PAmX+NRquGTpddOilX5d/gue3cYWCAJ+BytX3+dHKRciS
	 c4fLuBq1vs6Bo2UTGzCyvADk6viZbo3YFXJJla0VEYzP5M3D6vqwX+Xgz+Ki6fjBLE
	 MalwJ6XQrXvIbZbtIim0WM2oAwNJms/rC55U6gjI=
From: Dirk Gouders <dirk@gouders.net>
Date: Fri, 20 Nov 2026 16:11:27 +0100
Subject: [PATCH v4 4/5] utf8: respect boundaries in utf8_strnwidth()
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
Message-Id: <20261120-master-v4-4-5ff523db7285@gouders.net>
References: <20261120-master-v4-0-5ff523db7285@gouders.net>
In-Reply-To: <20261120-master-v4-0-5ff523db7285@gouders.net>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Dirk Gouders <dirk@gouders.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1887; i=dirk@gouders.net;
 h=from:subject:message-id; bh=dAz+eW91u0MenkpjnGFthrx1ccTW0kZi2+wkh8WiliU=;
 b=owGbwMvMwMW4JPzVNXNTrzmMp9WSGLIZkpVq+Rw4Iw4sWv9Go6dM8dH/ox+sdk1lufJbmn3OG
 +8CtWVenYwTWBgYuRiqxBRZlk4qsktTWfGi7JtqJswgViaQKdIiDQxAwMLAl5uYV2qkY6Rnqm2o
 Zwhk6Bg5QOT4GTTSC9Id0vNLU1KLivXyUkscTS2NzI2MXc3MjEwcLVwtzM3czIxMzSwdTUzNXR1
 dzIzNjU1NHC2dGbg4BWDWLdZk/x+s/Elk26Wn+4s+6zZeaJshofrstlrjjS+NMRV/d6p7nvdUSW
 39NP9zCcvSlAshHC0TFufU3f9y9XLVkiYObwaJ2TZqH94cPblDMGbPSuONEmGWS1oeLOvrDcibt
 ZzpknnLff983/sCEXo6S/Uk9y+ILGRTL7ypwdj9OmjxGuag5pOxl+MnObda+i77kVKXsjHnWTiz
 NF+LfWaIuOv/pkvX2GIPd53Ltzt2Tdw+cd738xsu5jaz7A8ozundfLiQ7/YTU8MLr9n71J7OXnG
 496z1ummavRGLDnU7Kv+9q9nRNMuYfYHNBXfj6C11qef6lTYuzl9i0Zqbn5h8rrXr9xM1rynd7x
 W3SRyq/9DXBgA=
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
 utf8.c                      | 6 ++++--
 2 files changed, 13 insertions(+), 2 deletions(-)

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
index 493f723e3b..291f34db7e 100644
--- a/utf8.c
+++ b/utf8.c
@@ -224,7 +224,7 @@ int utf8_strnwidth(const char *string, size_t len, int skip_ansi)
 
 	while (string && string < end) {
 		int glyph_width;
-		size_t skip;
+		size_t remainder;
 
 		if (skip_ansi) {
 			while ((skip = display_mode_esc_sequence_len(string, end)))
@@ -234,7 +234,9 @@ int utf8_strnwidth(const char *string, size_t len, int skip_ansi)
 				break;
 		}
 
-		glyph_width = utf8_width(&string, NULL);
+		remainder = end - string;
+
+		glyph_width = utf8_width(&string, &remainder);
 		if (glyph_width > 0)
 			width += glyph_width;
 	}

-- 
2.55.0

