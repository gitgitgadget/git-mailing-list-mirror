Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 665AC33B95C
	for <git@vger.kernel.org>; Sat,  7 Feb 2026 20:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770494706; cv=none; b=R45ZFH5ILfVrXFcxN0picCws/I5zAz9nrIbB3/bBJmlTt8+LocTaJHZC2OHRFH9pu2SCUiebz1XLPgeB3Ejmj5JOZbJKcrN57I48KNXRJ9a2RtU4UC0TEK6gDvCEKpOLVv2odlHYa2SVidQVa7fAeA09j3gurU+i7DqD2ckLkhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770494706; c=relaxed/simple;
	bh=0jwQFvIpqu5hyFCjFAjnYKfsaOvS3EdnwwRPmFDFQCY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ONbQgTw/RwYxST78VCjK/sLiULcPoaK490OgsmuAewybZKvW40tkiDjce35pnGKy5ah0TJf63XaOo50GZWacBPFvV1/3neHWGxU5wEISFMDYo9V8vl1UYKW56/5Dy/DzHO0xLXTqNRoh4a6JUM6TpZiu7MNKuFrQaC+YaN1HmxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=gpE4eavo; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="gpE4eavo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1770494697;
	bh=0jwQFvIpqu5hyFCjFAjnYKfsaOvS3EdnwwRPmFDFQCY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
	 Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	 In-Reply-To:References:Content-Type:Content-Disposition;
	b=gpE4eavowvbf3QctdVob35M7vZSQIWhDT3UtCHOctiXQMt682CRf+bOm/QKcPhqFk
	 xS+2QybLijm7KZtMlYzXfmKDz05ru2GQD2+b4MWsTyO9WuyLxqqcMj5d2aX52AQWVP
	 91cyimS8lYKXMeCrVsWidL1/ZjpnFXHnkFB2xWFwoWRLqrULzoQi6owP002ncTXaIT
	 Q0RBE7Q9BGUyQmlrqvGhGvUSg/dhdgcP4BaQKQwMfyoRhq3ZSxsBZEnqp/Gl1L2GYW
	 pUMN31/M87zePX4cMVMiYvh1xQUHn1I1sbYE8jPTlVtrtjFfEnBcXa0XNHj2p7ef19
	 lrPh5Ms/UqqyktgpRJMOBs5+L3obsg/OQSAUGacKSNY4Jzd30S02i6Wasolo0QomNu
	 K7zAwWAHfuUkJgjjmplb67gg8YsOWPEN+htzig1N3lSRnnbe8bTWfX3Vurz+S3XLJ2
	 uWNBN21qnGwCTABKBHPsQVLww/0Dy+//hD1jwBnAYWDT6f/Jf0D
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:9a58:ad83:8db9:6f4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id AC607243C8;
	Sat,  7 Feb 2026 20:04:57 +0000 (UTC)
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Ezekiel Newren <ezekielnewren@gmail.com>,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v3 08/16] csum-file: define hashwrite's count as a uint32_t
Date: Sat,  7 Feb 2026 20:04:38 +0000
Message-ID: <20260207200446.2837699-9-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.51.0.338.gd7d06c2dae8
In-Reply-To: <20260207200446.2837699-1-sandals@crustytoothpaste.net>
References: <20251117221621.2863243-1-sandals@crustytoothpaste.net>
 <20260207200446.2837699-1-sandals@crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We want to call this code from Rust and ensure that the types are the
same for compatibility, which is easiest to do if the type is a fixed
size.  Since unsigned int is 32 bits on all the platforms we care about,
define it as a uint32_t instead.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 csum-file.c | 2 +-
 csum-file.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/csum-file.c b/csum-file.c
index 6e21e3cac8..3d3047c776 100644
--- a/csum-file.c
+++ b/csum-file.c
@@ -110,7 +110,7 @@ void discard_hashfile(struct hashfile *f)
 	free_hashfile(f);
 }
 
-void hashwrite(struct hashfile *f, const void *buf, unsigned int count)
+void hashwrite(struct hashfile *f, const void *buf, uint32_t count)
 {
 	while (count) {
 		unsigned left = f->buffer_len - f->offset;
diff --git a/csum-file.h b/csum-file.h
index 07ae11024a..ecce9d27b0 100644
--- a/csum-file.h
+++ b/csum-file.h
@@ -63,7 +63,7 @@ void free_hashfile(struct hashfile *f);
  */
 int finalize_hashfile(struct hashfile *, unsigned char *, enum fsync_component, unsigned int);
 void discard_hashfile(struct hashfile *);
-void hashwrite(struct hashfile *, const void *, unsigned int);
+void hashwrite(struct hashfile *, const void *, uint32_t);
 void hashflush(struct hashfile *f);
 void crc32_begin(struct hashfile *);
 uint32_t crc32_end(struct hashfile *);
