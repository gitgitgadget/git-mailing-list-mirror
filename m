Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9845B34D4CA
	for <git@vger.kernel.org>; Mon, 17 Nov 2025 22:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763417791; cv=none; b=C2NPTKh2VVuE9Ptxgg3PXGN/5N63Xu0cXTs5paU+bFgxegyfgNnm/fiYgO8OL4FB3Hrl0W8kJRCXR7STMHUe4Raymt0oKMjwov/0KQEdYfDIhP7ggTknsIKzqDBwM0b62tIAdNHj4VotQmCt9xlndcqKSMFiCcZBl6qS64XLjpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763417791; c=relaxed/simple;
	bh=0jwQFvIpqu5hyFCjFAjnYKfsaOvS3EdnwwRPmFDFQCY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lj47kHSm3rgP5UfvicdMpHkxuaDye0MNeR0VsglzkV+tn42DdHWMam+uJSagoNcRW7Op0QfUS/L+tn6m0hz75QsoVDuP+XGIzjT+ZYMSRpbQdNCSPHRBgXHOPYkbAnNXzHLLBBa/QP1bwzxezFmYxuPv1ats6p655ZBzxKCAf+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=AbCbJhQH; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="AbCbJhQH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1763417786;
	bh=0jwQFvIpqu5hyFCjFAjnYKfsaOvS3EdnwwRPmFDFQCY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
	 Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	 In-Reply-To:References:Content-Type:Content-Disposition;
	b=AbCbJhQHsPXPIEV/wC/tZp52rFpM/jsORsfZA/aZXcFiRbTtNH4iJZWQLNcLHQJh+
	 9bH2Wsv+Rrf4/LzcCj4tPdReGSD35a5xmxZPVt5NWwyZISbTIwl2ga5tDSu2auGCQ8
	 FuNo2YfqqVEeuqNkABDvmxVzWOKKuADN2ScjFe5P/lCnMrBqeqBCjT96yHZDPMUGNw
	 t9g+lvK+yiqNB6j6iM97TKky9TZx7YImp1FusN18vKmkDrPiF9oh0RX9LPEUd1GC7j
	 9posS90jmeX2kCxWVgnruQNCXaa9m0Mbu2luRoR26j21LsZCRX7jHHenMgdKSNTCqX
	 NyAClMXhWQUwNHvgFWOthaainK5B/vDNThjkdBVYvf7O1lHUU5Ra+IiQ8QzrlTJpT4
	 GwSaCfrZDWaTT/nc7xEAXVpdwMTMPIVvs476CDVi3/KOtK4Xk2ciWiTdhOuBrR0DHZ
	 uGY+cePj36z3+xJ226x6k8ZgXpVbKuKRduNMmMo3D5A7Zjn7DQM
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:b6c6:bf88:c872:dae4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 3798225535;
	Mon, 17 Nov 2025 22:16:26 +0000 (UTC)
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Ezekiel Newren <ezekielnewren@gmail.com>
Subject: [PATCH v2 08/15] csum-file: define hashwrite's count as a uint32_t
Date: Mon, 17 Nov 2025 22:16:14 +0000
Message-ID: <20251117221621.2863243-9-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.51.0.338.gd7d06c2dae8
In-Reply-To: <20251117221621.2863243-1-sandals@crustytoothpaste.net>
References: <20251027004404.2152927-1-sandals@crustytoothpaste.net>
 <20251117221621.2863243-1-sandals@crustytoothpaste.net>
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
