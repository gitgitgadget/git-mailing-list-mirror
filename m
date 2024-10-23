Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42DC412B71
	for <git@vger.kernel.org>; Wed, 23 Oct 2024 00:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729644367; cv=none; b=a1JmQJY+ZE+HI8/nqqCtZEIw/QIFLGvDcs37/Mu3Xqv+IZhKlabEMIHxhacV+PInKIXci1tuAB3MlsGRFEiwxvhtq2w6883gEXxxqZgmkMyCQYdotQHow9CTOxSUKLArOcIWKS20AiRn+Sje8Oc2P0xaQkFZ1gneBX6MK1PrD9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729644367; c=relaxed/simple;
	bh=rm5bBDWTTSSWTi4eZzplkX+H7XnajPSwm+siZAe9Kns=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sY6CMIgUmRsfNK6t3oPNeoJ1vF1GRs11EA8uGArcSGsUbS2v34tTcvXVb0mQNP2ftErYG23bn96SsuvdvJ+UJ37YFDZZ5Avkg5157nVNl35QXf7vZDrit+iu4r7pC85xVOf9dR5oikiqtRdCpVWJgrzTCUNaFVKuJKFECb6HDbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=mU4jCKPN; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="mU4jCKPN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1729644364;
	bh=rm5bBDWTTSSWTi4eZzplkX+H7XnajPSwm+siZAe9Kns=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
	 Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	 In-Reply-To:References:Content-Type:Content-Disposition;
	b=mU4jCKPNqmS+1zXr7DYlKcXtq01ALT2TVGebx4Rl1nLA1jG60A5ifObWRSSHHMZjX
	 AcjyHOghF3YRGqVECGjgwxYIPGGuOcqMp3Bbj41moJdRT7ksz8jGEupT0EQlh6ZZWr
	 jyrtCxOp4NBT3PosVZXDv3zmRAtgaN7b6DNMnIylLGwlTPMfX944iKUL1jfKr5CQlj
	 Bo2bgGmelZq0l8JyGXHQ+LNGWrdvbOwbcndbxXuExZZTnG0eniDTYgWwtSibiUo64O
	 GcbHw0zUyorcEV2r+tco5l9OMEN98nQI19l+gJBdHuBnIplO8QuVEqzsDur7L1Wol+
	 nOFgKcZmvdhxGzmx95SpJ3UpKTpR8JhdZh84EulXkXQ2VOV+inG49nTcz0Yk0wJM/Q
	 ooYVR45aHpWg2rVp8llF0HKsa2K4OMaEkGs/Os5Kq4C9OKeMayB8GXfkvEJzGTGuO1
	 CpGWqfA5pHli1pcLR0KK9dYvO9M+D5OB6/iFd2AbvHlyFaLgYTL
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 28A73200BB;
	Wed, 23 Oct 2024 00:46:04 +0000 (UTC)
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Taylor Blau <me@ttaylorr.com>
Subject: [PATCH v2 01/12] git-curl-compat: remove check for curl 7.21.5
Date: Wed, 23 Oct 2024 00:45:49 +0000
Message-ID: <20241023004600.1645313-2-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.45.2.753.g447d99e1c3b
In-Reply-To: <20241023004600.1645313-1-sandals@crustytoothpaste.net>
References: <20241010235621.738239-1-sandals@crustytoothpaste.net>
 <20241023004600.1645313-1-sandals@crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

libcurl 7.21.5 was released in April 2011, which is well over ten years
ago, and no major operating system vendor is still providing security
support for it.  Debian 7, RHEL 7, and Ubuntu 12.04, all of which are
out of mainstream security support, have all supported a newer version.

Remove the check for this version and use this functionality
unconditionally.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 git-curl-compat.h | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/git-curl-compat.h b/git-curl-compat.h
index e1d0bdd273..c24ed686c1 100644
--- a/git-curl-compat.h
+++ b/git-curl-compat.h
@@ -28,13 +28,6 @@
  * introduced, oldest first, in the official version of cURL library.
  */
 
-/**
- * CURL_SOCKOPT_OK was added in 7.21.5, released in April 2011.
- */
-#if LIBCURL_VERSION_NUM < 0x071505
-#define CURL_SOCKOPT_OK 0
-#endif
-
 /**
  * CURLOPT_TCP_KEEPALIVE was added in 7.25.0, released in March 2012.
  */
