Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.61.206.94
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795187500;
	b=uykPWmqju6NIMV10Rh3xtBqGGj9Zy65/NFwurFMuAVf9Sx9c9bXJ6HTdpq4ZilAUgt/P
	 VEnv1udp5oIFrMgjYPvqReVpQCL2/OjrDdpv6nzsxU7Yy3cQAefiepNSiOIsk9jicMg0R
	 Po1KQbbA97EBZ7C7zC4Q0lS9RrzVwUcvxIsze6Ppr3IvH5b9sj3NMRpcdlVMqr3NGhvQ8
	 E0LITy0mqpmoz76yrA1WSitkKYqNGzasvKeiYzH/y1yi7V52faSHuCh4xy+U/hJ6Mt7NG
	 1g/Xs8zPaoMPdweNn+k8RGdTxwKNu/Vmoby+2UT3eI8s/TrwxnNX+4kXbf/JLc+yJUg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795187500;
	h=DMARC-Filter:Received:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=nY7anjAx8SyDaqIj9NZ5u4LJC7gLqiFGN4OM2HTDCgE=;
	b=W7QQ3FkgdrQF9+mNQbbEv+Gik2NZxEynOk9BSeT8ZRZMfBwJvp9JbhNh4bh1KG4DLUUV
	 vUaQrKDdZKj2Fi5tqWzhJfe5mK6qsZqYHvW6PIOcPPgu2lCLOeB0jKkkut/VHP4pF32QF
	 3Yg1hoiag4OSi6roBl81JDbdNPArMcFNeccEOCk3x2eG8RjoPVkbc51aZbXQuh4mKXB8B
	 lln7rOlzhLhmWtXhrmKbk5V+m/5ga1HrK8puKbzvt6VQCNOm9OnIK2rI7abZIdcvN6+N0
	 wIIv1HcBZgBph9/6FNg0VF7yxeBdn15wwlaxxRaP7qtQ3AK+rTYIu/MZWC1/8Wm2uiA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gouders.net;
	spf=pass smtp.mailfrom=gouders.net;
	dkim=pass header.d=gouders.net header.i=@gouders.net header.a=rsa-sha256 header.s=gnet header.b=gyuhbgwm;
	arc=none smtp.remote-ip=202.61.206.94
Received: from mx10.gouders.net (mx10.gouders.net [202.61.206.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64CC3606A33B
	for <git@vger.kernel.org>; Fri, 20 Nov 2026 15:11:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 64CC3606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gouders.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gouders.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gouders.net header.i=@gouders.net header.a=rsa-sha256 header.s=gnet header.b=gyuhbgwm
Received: from lena.gouders.net (ip-109-41-49-183.web.vodafone.de [109.41.49.183])
	(authenticated bits=0)
	by mx10.gouders.net (8.18.2/8.17.1.9) with ESMTPSA id 6AKFBTTg2082197
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Fri, 20 Nov 2026 16:11:34 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gouders.net; s=gnet;
	t=1795187495; bh=nY7anjAx8SyDaqIj9NZ5u4LJC7gLqiFGN4OM2HTDCgE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=gyuhbgwmPveptaFjOjKvxWk9i/A0lkfqp7CDF3ynnJcnOVP54zH4QqQYYhBonVczZ
	 jNVc2w+GohSnlpUpATyQUiP7aAwb6O5QiOLNqb34VH6VsJRR4PiIzeAwXPhZVCYG4K
	 yqtzItwjkZBEXAHQcmqyAupRq2dHp7xUSAfwvjkA=
From: Dirk Gouders <dirk@gouders.net>
Date: Fri, 20 Nov 2026 16:11:26 +0100
Subject: [PATCH v4 3/5] utf8: respect string boundaries after skipping ANSI
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
Message-Id: <20261120-master-v4-3-5ff523db7285@gouders.net>
References: <20261120-master-v4-0-5ff523db7285@gouders.net>
In-Reply-To: <20261120-master-v4-0-5ff523db7285@gouders.net>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Dirk Gouders <dirk@gouders.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1753; i=dirk@gouders.net;
 h=from:subject:message-id; bh=rcbLmFBbzY7t9heEJp/bSB0I5CZFlmgiYX5Qf8A7nCk=;
 b=owGbwMvMwMW4JPzVNXNTrzmMp9WSGLIZkhU9jgqVVqlPZN4v+ShgjmRFT4nGaZmG3dlvX3CkB
 09bNS24k3ECCwMjF0OVmCLL0klFdmkqK16UfVPNhBnEygQyRVqkgQEIWBj4chPzSo10jPRMtQ31
 DIEMHSMHiBw/g0Z6QbpDen5pSmpRsV5eaomjqaWRuZGxq5mZkYmjhauFuZmbmZGpmaWjiam5q6O
 LmbG5samJo6UzAxenAMy62wHsf0Xj724PlNlzX9mjncHbpJFj8cwvqTMS1qxWa2DNfjUn6M4Lpt
 ZTCV/a3LxX/V05e0qBl8KeUotXW0wDZ1eaxqxSC67cffl7jJnuwv81+utypsduuB54Zn/AwmWNN
 n8+/Q+Q4nol77O6VVMnjF3+yVUJlWeF3uE+7+b/quOX5k4+NmMaf9s169bJr9e6MemzX5D83i7O
 eGLd5PwXU96W5yhFuR9P2DBTxCmu6RHfhr71JlbOVrO3fV6vJbPbvISbLeggd7/Md+3Xf3sK/28
 u/eJ85XG08yfDu7J/DnxnPfPhrNHc5e+b797s7VigrsL7euvJ5QX2n18KZfsfPVT7W4jx5+cW7f
 2VRzq595XxFAEA
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

