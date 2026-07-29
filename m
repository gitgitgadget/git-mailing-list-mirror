Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB1263FA5D4
	for <git@vger.kernel.org>; Wed, 29 Jul 2026 23:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785367943; cv=none; b=aLq6GL22d2roGk1zwoBXldujznsfAp2xjIB7f5OS+KvwTaquNl2+KYQA0SgeTPnoIdFmnAKdXhAKT4JBhLiR+hRyLJyDoP7jvfbV4/cCb7cO1FeqEdhh1N/HiTy1wpUMuDUKVUGPrGHorLX3VPTgJvmr85/qtuEq2HYp0ZcD4t0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785367943; c=relaxed/simple;
	bh=LXT5s/+ru+6bJcTCBB+/dP7caKQtAIws39JzgMAGxsI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e9/3S4P4EDFNtb5u3EwZXJAAI5+iR2zOyDKK/gXRDUJSJLKgwJ/yZS9sXPPtnx57gDZbHge3UoQEPqrumfwBtOupmMMbSWRjXub8LfucOfWwtsssciTtNXrrwpV4L/I72hEmH2Bdi70yLAWzzkGzz7/pHhacjoxcdxz6dlo5/JU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=SZCdp1gI; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="SZCdp1gI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1785367938;
	bh=LXT5s/+ru+6bJcTCBB+/dP7caKQtAIws39JzgMAGxsI=;
	h=From:To:Subject:Date:In-Reply-To:References:From:Reply-To:Subject:
	 Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:
	 References:Content-Type:Content-Disposition;
	b=SZCdp1gISgO36rNFA3VGQnsz/z5hTL+dmpSBNEf5ncwT5lDyO9cr5SXBJylWE+0zk
	 D7Zt3CiwMMBHOPraPPFdjbAwGnREK0XZ2gNNNFeA+nVpixmUN1dOVSRahqpcm5JX5S
	 TAQ1BzdDl/3mlovkX48ApMmbNkcjGaGD9cwyhj2pK4OIxZLwdh/EtuSueogeO1ybA0
	 qgD0jego4GVbEzx9ztDn74ImDgYuM+j/rnfozoxYpZ4b46J4msmcTVLNtgrJ39peUS
	 ljKouxfiiCcBkA1sRnS+RxFp9DkTrsju+3xjNba3CkiAub6W+uBs5BbCZecQOG7HGs
	 2srFpg83QK/hqOU5fKGjraDMyRWnlcVVn+sa3a+lq4vX8olcUX90olcYp8JvHkeGEf
	 TA6vOmgtxZv0FaZ1K7ZTaxT+8y4lpk4mkE0mitfGiq4WrjEUOMsES+QKjN82DWe9Tf
	 nlWN7nKBWJo6F8XpQ939bdHqN5/JYlZSX8HixpuPE+vPdeIinj5
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:c292:4852:9051:fdce])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id AED12201E4
	for <git@vger.kernel.org>; Wed, 29 Jul 2026 23:32:18 +0000 (UTC)
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
Subject: [RFC PATCH 5/6] object-name: use hexval
Date: Wed, 29 Jul 2026 23:32:14 +0000
Message-ID: <20260729233215.398654-6-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.53.0.697.g625c4fb2daa
In-Reply-To: <20260729233215.398654-1-sandals@crustytoothpaste.net>
References: <20260729233215.398654-1-sandals@crustytoothpaste.net>
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

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 object-name.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/object-name.c b/object-name.c
index 83efba0ba6..d2d81b3511 100644
--- a/object-name.c
+++ b/object-name.c
@@ -236,17 +236,10 @@ static int parse_oid_prefix(const char *name, int len,
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
+		if (val < 0)
 			return -1;
-		}
 
 		if (hex_out)
 			hex_out[i] = c;
