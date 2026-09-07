Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 871BF525A8F
	for <git@vger.kernel.org>; Mon,  7 Sep 2026 20:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788811203; cv=none; b=BsLDMrpfyTxEc/482OPDWYGNpn3m9O1F86gSaTJmJBY49+XwU4qgm03w3yvkkmVTGDxy+f9BmTrOpTeTiRsNcoCGnZI/HBhOoB3tdaBDsTHPE7Bi9Lit3SUrn5+vbBEPbmnhl/p46ijrtQMC+6bn3NqHMz/bEB50adqL1QbIppQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788811203; c=relaxed/simple;
	bh=DYO8HhQrni6XNrRkqdXBV0/F1Ge/UuvxFn/G2t0HrUI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AiC9OjTJ0zIsMV7IyjcRH3fmH169Yo+aU5R0De98PUwYLJW0F+44cJYtTAVz4xOvGXG6t7G6RmM9b0Ijumup+mWf8wzz6dQ8SsT67fgDVnH6bhi3L47fRQQ28J/4GNSJ9UMCs5T7XA4meznQ/ScupsLrbbRHld5WLhf9VnY3sYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=Yf+JNELL; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="Yf+JNELL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1788811198;
	bh=DYO8HhQrni6XNrRkqdXBV0/F1Ge/UuvxFn/G2t0HrUI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
	 Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	 In-Reply-To:References:Content-Type:Content-Disposition;
	b=Yf+JNELLaBx/cC648A4Ehs+a/5//KEQCrpME1VNPzNkL9kOL+NtuHYxSpLUybc2Z+
	 7oDg4yDJYENA8BeQqa4lhyF+fwFMNclFvICcRcrOm2h67zgtZW9dXKG8hThxlTWq1c
	 tBHJ3T8pyjKrFJUDlvue9cpZ3luj9V/EZyN5pR2NHA4HU5gAVt++8ho2yFHBrTbTcK
	 MYvheY4+TNjYoym3z6RkKzCOyALYHg435Xa1dqgH1EwNs5viP3Dm3sR6XVhuDFla5V
	 VLgZrIyQvqaLB9cBbXo+fNVWjmXXeFkqWKBglF4waKaHIVK7mVagkLS1TcgHMmy453
	 cJQ6uXNRYBLo5BOblD0cz/2hx7eyNYwBWcrEcqkCGmhcn0/fgstJt1xycuE+fPgUXZ
	 KyLzp4wbyHlcRZhbW/hDm83owcyxy7TI/FgwIsOyCMVF/C8KPVrDxoDhWe3d4f4Z65
	 AvyDMpv/g40IME1QTigjp5gtK0w2TPdHBGvieUH6xF+ozz3jE4B
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:7b23:2dc:c9d2:f0e4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 3E71C201ED;
	Mon,  7 Sep 2026 19:59:58 +0000 (UTC)
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>,
	Jeff King <peff@peff.net>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v2 5/7] object-name: use hexval
Date: Mon,  7 Sep 2026 19:59:38 +0000
Message-ID: <20260907195941.1024289-6-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.53.0.697.g625c4fb2daa
In-Reply-To: <20260907195941.1024289-1-sandals@crustytoothpaste.net>
References: <20260729233215.398654-1-sandals@crustytoothpaste.net>
 <20260907195941.1024289-1-sandals@crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We've open-coded a different implementation of parsing hex values here
when we already have a perfectly good one in hexval.  This
implementation will almost certainly be slower because it isn't
table-driven, unlike the other one, and since it's not constant time it
has no other advantages either.  To tidy things up and prepare for
future work, switch to hexval in this case.

Because hexval returns an unsigned int, check to see if the value is
invalid by looking for any bits beyond a single unsigned character.  In
addition, be sure to continue to force the hexadecimal value to
lowercase.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 object-name.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/object-name.c b/object-name.c
index 4eda8c8eac..8f2da51547 100644
--- a/object-name.c
+++ b/object-name.c
@@ -236,20 +236,13 @@ static int parse_oid_prefix(const char *name, int len,
 {
 	for (int i = 0; i < len; i++) {
 		unsigned char c = name[i];
-		unsigned char val;
-		if (c >= '0' && c <= '9') {
-			val = c - '0';
-		} else if (c >= 'a' && c <= 'f') {
-			val = c - 'a' + 10;
-		} else if (c >= 'A' && c <='F') {
-			val = c - 'A' + 10;
-			c -= 'A' - 'a';
-		} else {
+		int val = hexval(c, HEX_KIND_OID);
+
+		if (val & ~0xff)
 			return -1;
-		}
 
 		if (hex_out)
-			hex_out[i] = c;
+			hex_out[i] = tolower(c);
 		if (oid_out) {
 			if (!(i & 1))
 				val <<= 4;
