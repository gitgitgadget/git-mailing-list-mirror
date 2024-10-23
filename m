Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34374208A5
	for <git@vger.kernel.org>; Wed, 23 Oct 2024 00:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729644369; cv=none; b=qYLEENYJv/gttIzDKub1E9lADyJeV6M0dQAIE3+z7MY9/gNkMevoSozl19hME9TkcUgcWLAq8Qk4B3SYjY9O/u3PjFCO7ulg8CU6qoWvj6xW0IF4Z8CYiSSLKG4DFoVqQxh1W6k6NB5qcHwvEcDAb+oC7yokLaxGvTccMcrgEA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729644369; c=relaxed/simple;
	bh=Yyx1/9ezc1jQ37JvF0zD81szsoSHY4VK/1sVGZmQ6ew=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u30yZX/a6VI/t0k8w4nYznh9lh+bdZb67/y5KCYQEERJIuL3CyWFp943QaGs8pLFEwQICqj7NtARngHT1saI3QPaF3cLDcATllwLLWionOJqXbkLOvq09Axbg4v6DQvN774WuC/V0mRd20YJizHC4c/bsF+IeOktPS9oh+T7Hks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=FCqxu+vs; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="FCqxu+vs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1729644364;
	bh=Yyx1/9ezc1jQ37JvF0zD81szsoSHY4VK/1sVGZmQ6ew=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
	 Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	 In-Reply-To:References:Content-Type:Content-Disposition;
	b=FCqxu+vsRoFvpGZg1SAB89670WC+hO7v1D4uGdUJAJ6riKz+i3u8boM0B42vQ+XDX
	 40jkKUlzKOf9uzrfx1VlpGXmN1zsFu6SYRFScLTym3zX5piB35vnhsO1ERgv7bUwLt
	 0Zm/TwwWsvRiCIZXexUaDMBB9AhNlpi7e+roX9mI//C9eWVd2pkKo+PG//VWztKoSs
	 1FahZ7ZMz7nSZ3ZH0q+TW/Wc3rksbHXFKwK/fs0hpKmXBT9GjqdsbYWTvrP/abtWo8
	 3ypYZVEUC0jHJL/X1lor+eeJ3OAmB6lIvLvpKh4PeCoYgK1BIlCN6gy1pnrf0KAtgi
	 3pAJvLm3sm0EGHKlwkDJiQ2Ug8IhshSpKzS6eUbysm20M4hYkG4z25vZYCYZSQoVdo
	 +r3pMmS6z7vrete+S157sGRCspemOLOcyaYifUyw7DzzO4SWY4x/2eNPkihcvxLEER
	 //kjnC4T93ikPaoTnTTrI98yC/oJb+pCMD3eIgCBhfPtyfthxlC
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 708BA200C2;
	Wed, 23 Oct 2024 00:46:04 +0000 (UTC)
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Taylor Blau <me@ttaylorr.com>
Subject: [PATCH v2 08/12] git-curl-compat: remove check for curl 7.53.0
Date: Wed, 23 Oct 2024 00:45:56 +0000
Message-ID: <20241023004600.1645313-9-sandals@crustytoothpaste.net>
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

libcurl 7.53.0 was released in February 2017, which is over seven years
ago, and no major operating system vendor is still providing security
support for it.  Debian 10 and Ubuntu 18.04, both of which are out of
mainstream security support, have supported a newer version, and RHEL 8,
which is still in support, also has a newer version.

Remove the check for this version and use this functionality
unconditionally.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 git-curl-compat.h | 8 --------
 http.c            | 2 --
 2 files changed, 10 deletions(-)

diff --git a/git-curl-compat.h b/git-curl-compat.h
index edee8f2ba0..65ba1ee0f8 100644
--- a/git-curl-compat.h
+++ b/git-curl-compat.h
@@ -28,14 +28,6 @@
  * introduced, oldest first, in the official version of cURL library.
  */
 
-/**
- * CURL_SSLVERSION_TLSv1_3 was added in 7.53.0, released in February
- * 2017.
- */
-#if LIBCURL_VERSION_NUM >= 0x073400
-#define GIT_CURL_HAVE_CURL_SSLVERSION_TLSv1_3 1
-#endif
-
 /**
  * CURLSSLSET_{NO_BACKENDS,OK,TOO_LATE,UNKNOWN_BACKEND} were added in
  * 7.56.0, released in September 2017.
diff --git a/http.c b/http.c
index 24764f1272..c5fdf1cd4c 100644
--- a/http.c
+++ b/http.c
@@ -55,9 +55,7 @@ static struct {
 	{ "tlsv1.0", CURL_SSLVERSION_TLSv1_0 },
 	{ "tlsv1.1", CURL_SSLVERSION_TLSv1_1 },
 	{ "tlsv1.2", CURL_SSLVERSION_TLSv1_2 },
-#ifdef GIT_CURL_HAVE_CURL_SSLVERSION_TLSv1_3
 	{ "tlsv1.3", CURL_SSLVERSION_TLSv1_3 },
-#endif
 };
 static char *ssl_key;
 static char *ssl_key_type;
