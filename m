Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E52BD1BE251
	for <git@vger.kernel.org>; Thu, 10 Oct 2024 23:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728604596; cv=none; b=Sk1XZaF6A2Rw5rfbXpANtR9pKvI0X9zrtF4XSiLckihilMXB0maHGmCk8uoAxhIXG6HzAHK8Ou25Qx1p6i7/8fq9FNWiCymgIQ5F8mVSKT1ZWlKYSVWJLkkSZQdCGcmoVH8caW6g05/a0iQzWqHIRzj99/VEwngRhPaB5SHn4Xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728604596; c=relaxed/simple;
	bh=rm5bBDWTTSSWTi4eZzplkX+H7XnajPSwm+siZAe9Kns=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cxl5BIHhXMSnL5TIWW+cw/JGkkD3/pWXs9IaY1/7mVF/yT+72d/r5BfjmsRVRwow2Yj9epa8NoVk7hsPHvPPiGb5oOybynXG+7degOPYnoxUK0Hs1CdaTerZhBLS0WQxFAiqzCBdYfLgPVTA/B1tBG+2r6XSkPxCgrKXVjlyEgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=RlOHPbhT; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="RlOHPbhT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1728604593;
	bh=rm5bBDWTTSSWTi4eZzplkX+H7XnajPSwm+siZAe9Kns=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
	 Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	 In-Reply-To:References:Content-Type:Content-Disposition;
	b=RlOHPbhToZ9fJIWUDnTntMhMsWHWdW+hUVAzoYaJP24RD7R0IlpW5bSIuqg82bQYI
	 6Br+WTbuZBLfU+Jx7f0mgMrZOsY65X3zLp7XoFKKPetBMZcE5HIsv6gwW5B/HxysGh
	 5hNckrsFjdeq3HchKasbZSCJORhgTFnShO8379QN1Vy5M65TKxKYbbE9WIa+xNIY76
	 0yWzHILycXHM9ozdsr1QcHCpWbrXIIuKVv2f4VPkCybdGIrN9SkYk6+eSnsYE8ULUn
	 vrfhfMc479oHDmOjD/olRw80GmJ28NVYSp7pBqLW6EuczqMeU55SZ3gRhjo/9FNbjT
	 0pKyVap3n0rnOmKaYhLNuQgIsHcegoK1Vro1utrqXwfpMTpQqBKM8dzohWQ676BUpW
	 tczD95GEirdST8sazbyaVLIwcmi/EnqcyxkkOoLzjwASKfP+Ba+E7VnkBlOi4UimEz
	 /pFowMn7I+estB7C+6nznIg1WxkaXUZaRYctlNhAyZGA6uVLabT
Received: from tapette.. (ipagstaticip-2d4b363b-56b8-9979-23b8-fd468af1db4c.sdsl.bell.ca [142.112.6.242])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id EB121200B4;
	Thu, 10 Oct 2024 23:56:33 +0000 (UTC)
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
Subject: [PATCH 01/13] git-curl-compat: remove check for curl 7.21.5
Date: Thu, 10 Oct 2024 23:56:09 +0000
Message-ID: <20241010235621.738239-2-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.45.2.753.g447d99e1c3b
In-Reply-To: <20241010235621.738239-1-sandals@crustytoothpaste.net>
References: <20241010235621.738239-1-sandals@crustytoothpaste.net>
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
