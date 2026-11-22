Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.61.206.94
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795359092;
	b=wQLJKSDSp5ovUoQFUaLwH5QksR20q3C9OYTEiEcX1CIPtlJzb54jJXNdkyEgicvjwZt0
	 IgAeehKWoU4aKVtlfphP1KxK6EUiAXu2fScBuWNQfRNVbOrB8YmY6z1jlg+/xH1XG7oKI
	 VJg5xm2EzudiYxgHF/XlXSzeP6kV4stPLKdrwkitXywZGxBVlG9aLfrb9yCVhvGi+YjF7
	 GM0gFtq8m/8T3Cytv5vKC7aFrfuG6Ta2bGZxWpdOyeIviG1WWn+FtMCLr4Y5tQw5FXxjj
	 LQd/RmWvVq7J+4ZO0wyf5H9s9zrzzVqpkuKMtoZB2rEbQGOH2s63Q3Rj61ynJEj065A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795359092;
	h=DMARC-Filter:Received:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=R2PUKJ8S+wkAVz6Xbe/k+bNEE35Ac4NsF/W1DrNnIb8=;
	b=l8tV0jeqVvcKTvbAcnblivSYN/6vH8EVpLi41Za8VQNYVKCRmQ6RAc2cgpBTbqo7Ti/O
	 M+MMB46NJTd5i3xgm80h+riC4BwHyqyivxbx9zc5amsM0T0RJMVe6svBjTWgmQC+jVApy
	 yKx9SmrHcf30x7u/iqrvXGNZt0xqu6S2nvIKL8yUqjn31OHXZUgH1BB85ml1r3rr2xP9C
	 ZuQr3vc9dad+M8EQmpsz8f/sjFvPbkd+caI21fs4Xwxxl+ba2Svanmw5aw5vHUKSIgXyU
	 F2Z/gjVT207RQyHfYBZjTfuhnPyWzbs/2HTmbB822Q4x2Zk8gpY0slvlbaOeNaJZMJA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gouders.net;
	spf=pass smtp.mailfrom=gouders.net;
	dkim=pass header.d=gouders.net header.i=@gouders.net header.a=rsa-sha256 header.s=gnet header.b=um7Zfsw1;
	arc=none smtp.remote-ip=202.61.206.94
Received: from mx10.gouders.net (mx10.gouders.net [202.61.206.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBAB3606A320
	for <git@vger.kernel.org>; Sun, 22 Nov 2026 14:51:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BBAB3606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gouders.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gouders.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gouders.net header.i=@gouders.net header.a=rsa-sha256 header.s=gnet header.b=um7Zfsw1
Received: from lena.gouders.net (ip-109-41-49-183.web.vodafone.de [109.41.49.183])
	(authenticated bits=0)
	by mx10.gouders.net (8.18.2/8.17.1.9) with ESMTPSA id 6AMEpQ7t2232929
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Sun, 22 Nov 2026 15:51:29 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gouders.net; s=gnet;
	t=1795359089; bh=R2PUKJ8S+wkAVz6Xbe/k+bNEE35Ac4NsF/W1DrNnIb8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=um7Zfsw1bUKcF62/yC4ExkdGzrukw5rpycmXwhZLPN8wlO8WNdbMNh8zsEhz4slDi
	 8IBC1RAK1MYiW5I5lYyLpNlpmHMPWCxt5M/0IqXmtZGRO+bWSmS1yi+dStxefp7xPl
	 gShEDvDyQtqbXKbKX2VkDBVCNCraj9FFZLVbN9Eo=
From: Dirk Gouders <dirk@gouders.net>
Date: Sun, 22 Nov 2026 15:51:26 +0100
Subject: [PATCH v5 3/4] utf8: respect string boundaries after skipping ANSI
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
Message-Id: <20261122-master-v5-3-313bd1bb3c45@gouders.net>
References: <20261122-master-v5-0-313bd1bb3c45@gouders.net>
In-Reply-To: <20261122-master-v5-0-313bd1bb3c45@gouders.net>
To: git@vger.kernel.org
Cc: "Junio C Hamano <gitster@pobox.com>, Andy Koppe" <andy.koppe@gmail.com>,
        Dirk Gouders <dirk@gouders.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1841; i=dirk@gouders.net;
 h=from:subject:message-id; bh=LAxD8VbRJAqhbpg6t/Krb73LwVFOWYI/ZpE42v0mEco=;
 b=owGbwMvMwMW4JPzVNXNTrzmMp9WSGLKZGfM3cbxedVJdldv0pHpb9sGFgkIfbr1p9/RT+hCRX
 rUn4ZNSJ+MEFgZGLoYqMUWWpZOK7NJUVrwo+6aaCTOIlQlkirRIAwMQsDDw5SbmlRrpGOmZahvq
 GQIZOkYOEDl+Bo30gnSH9PzSlNSiYr281BJHU0sjcyNjVzMzIxNHC1cLczM3MyNTM0tHE1NzV0c
 XM2NzY1MTR0tnBi5OAZh1F23Y/+ltkzdkfBZ7zbP/iZGN7rRvYbKZDn7dpR4ezNO1D+YGl7f9ri
 3vWcH3t583Pmbd9x/1hk4zeaqZGGeW55k/SFX/ZvxhmsTOXXIsEjF992WnidUabo8yeHfEtPCBR
 VVk+eHd+401ry9//yLJ6vNTk1vLtz/efkn8ffCVfYcu/538TP1DeNUzXU1Gi3qnrHclP2UXTa3n
 aPG4+EWsOnL+ns+2Yc0ZZydOmPfCLbN94TvRew5/L8QoxBuqvf/6PnNZnAvDtnnbn7H5WnS/W/p
 efqPp9u7fBz5LKcdZmdYvyfwvceRR697F27hbwlRCHufNexrOKMR0zsctwH51FV+zokBK785V29
 0dZp+Q7Wr7AwA=
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
index 009e8fee39..dfc5261619 100644
--- a/utf8.c
+++ b/utf8.c
@@ -230,10 +230,14 @@ int utf8_strnwidth(const char *string, size_t len, int skip_ansi)
 		int glyph_width;
 		size_t skip;
 
-		while (skip_ansi &&
-		       (skip = display_mode_esc_sequence_len_counted(string,
-							orig + len - string)) != 0)
-			string += skip;
+		if (skip_ansi) {
+			while ((skip = display_mode_esc_sequence_len_counted(string,
+									     orig + len - string)))
+				string += skip;
+
+			if (string >= orig + len)
+				break;
+		}
 
 		glyph_width = utf8_width(&string, NULL);
 		if (glyph_width > 0)

-- 
2.55.0

