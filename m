Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98E4230E85D
	for <git@vger.kernel.org>; Mon, 27 Oct 2025 00:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761525877; cv=none; b=Brmi3uAFpaP8t+S+fUY9DY6jCui7/7m7wqjnaMwP5yPE9JEd3FiHwe2xdUsyvmSdBZe38c6mygc4nz6u7soy8X2pLeiLJGxz7pqDoC4mLPtY4OSoNSZfnCygNNG0PcThxvSvEA8K9tAt8+kF1NzY+0hWw26t1LMGZfZl5PO/RGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761525877; c=relaxed/simple;
	bh=0jwQFvIpqu5hyFCjFAjnYKfsaOvS3EdnwwRPmFDFQCY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RN00DN/ZNdy787ik832NfLeGF3d+BHvBer3wU22zPp8EOVc+Z2F7fNOcASb6uZ7sF03o+hq/DrKdEN153j6N7Lba2dKskEAr92vzwrXbsXsuwS8kjJ7BjZP3uxZ7oJmYpzLm5WVR3YtxhaHOGcLiarrP4Pgvwv62CdboVQa9dkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=u3oWD/Ru; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="u3oWD/Ru"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1761525867;
	bh=0jwQFvIpqu5hyFCjFAjnYKfsaOvS3EdnwwRPmFDFQCY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
	 Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	 In-Reply-To:References:Content-Type:Content-Disposition;
	b=u3oWD/RuNKJj9yun2vaPVUERasmZarXzpGb8G/udqyjg1KIw29QmOv9eFs/MUpY5j
	 7cNzGvXxwJOh41eZtNvMJi1Bx2vbMm6By6i9T8IWxxHiIvxLpu8w+CzMUqNJI4DOT+
	 UpMnXzKpgrUqLPv6l0XRqA2jWza41Roy4qEZIepEP6IVUgNAjj5mAS4X79/l+4aTtR
	 4VaI28iINsePQ0gCeF6Lsz4XpAuA0sAXW3YzPht6DKAYIG/959rvTGlczOpuJPwDuT
	 lUUvDb39e2AsFPyRKlXx+kWkLEFIn5jIUiKq0JtmLBq423kwUBgijtXqzHXAUXAkaz
	 Y6LkBhLc4bjzPn+I27NWGnerqGIMDIKPJWDaJv9UAfg+p7VoA091cRNVrBrpulwL47
	 JYTmwyID/nvlgZyhmubl5sW5sLhdlUhthTsdeWSv+vwaQAUaLFx8Upc3q6oYgviboG
	 kIBF8/zUumqWQS+x0p1DbmzKfseiP8egW7dSwn1T3q5t64TxEVL
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:5675:b769:afe:3fa2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id BCC10201A1;
	Mon, 27 Oct 2025 00:44:27 +0000 (UTC)
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Ezekiel Newren <ezekielnewren@gmail.com>
Subject: [PATCH 07/14] csum-file: define hashwrite's count as a uint32_t
Date: Mon, 27 Oct 2025 00:43:57 +0000
Message-ID: <20251027004404.2152927-8-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.51.0.338.gd7d06c2dae8
In-Reply-To: <20251027004404.2152927-1-sandals@crustytoothpaste.net>
References: <20251027004404.2152927-1-sandals@crustytoothpaste.net>
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
