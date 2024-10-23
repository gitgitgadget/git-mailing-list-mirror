Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF6F41BDCF
	for <git@vger.kernel.org>; Wed, 23 Oct 2024 00:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729644369; cv=none; b=G+kCV7n8fHFimdToAf4hEy5FxHPPKmYEI9t5aj3CuZ+23WQ3doZlT0s4O3rh76z0AYoOhNSksmmLBEoK6/9VdYZISzmHkmld9J+n3sp26hnX3HqbLJar1gUCiJ2PUbP4+IV4Ic560lZ2wyLbVW1EGTRdrSuYtIzxKkgUbeoC/wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729644369; c=relaxed/simple;
	bh=/eZ0oHRZKK+QdeosQHMaDtMJ5DTkT1eLqH/CW8IIE3I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jmZuK4ABmYG/SDaDtvy5//RNFzT9JADDpZv031y3wJtKMXbIg9fZ99J9M3LHfIzunR8qxqGJR7u3q5Fb8ceUFduSoDX3mSAyx58+NPh4VZt71cGmwUv2Zhv+QO4xXVTsDeO4/ibwcxux60M2yJCP0DvSaF73o19FvH7V5aHJ7CY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=yPM/oPk3; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="yPM/oPk3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1729644364;
	bh=/eZ0oHRZKK+QdeosQHMaDtMJ5DTkT1eLqH/CW8IIE3I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
	 Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	 In-Reply-To:References:Content-Type:Content-Disposition;
	b=yPM/oPk3zoH1V1AUwfBjAW/+4YU8qZgzfAp5UfLboquzuVSwFIZQv9vecAdD8ScRa
	 9DVUo1KZucS5ZYeIpSoiQ/yMcA0KD73K101776CsV61lOPvBX9toH/1uw/Wfgxlq/l
	 68iYIr0aZ1f6dnUoelXxHf5vq5ImONskmDF6luFKsIV+wrfPQ6M5jXxhkVUp/ffahU
	 jnvb0UR+QuWRvmg0vusP2+I0I07hmMooAMF6eZ3umNoaeLt+Q7f+5My31D8L6XJi3m
	 fXB9wT8QmZHo9H77tI0JbBfUpsThy6DM5uviVRmwrB5remIVucSjl26IVfjLdH5q73
	 hQ0dRCm3rgfMynfW1+x8DyZSkZomY+kwRts8jZ4wmsIITFXwpFbCL31Q/BZPvEmFvy
	 VKMCva0bk96rTzf5nrDwNkELNsPHYb/PjJuoMzaRSamUiFn+jiRaHpz8hXGEIuenWU
	 3tWuuR9jqh7wjfaRpTBUZnOaHF7VGdqzwP50tMBbNMavl4/w7nG
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 510EE200BF;
	Wed, 23 Oct 2024 00:46:04 +0000 (UTC)
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Taylor Blau <me@ttaylorr.com>
Subject: [PATCH v2 05/12] git-curl-compat: remove check for curl 7.43.0
Date: Wed, 23 Oct 2024 00:45:53 +0000
Message-ID: <20241023004600.1645313-6-sandals@crustytoothpaste.net>
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

libcurl 7.43.0 was released in June 2015, which is over nine years
ago, and no major operating system vendor is still providing security
support for it.  Debian 9 and Ubuntu 16.04, both of which are out of
mainstream security support, have supported a newer version, and RHEL 8,
which is still in support, also has a newer version.

Remove the check for this version and use this functionality
unconditionally.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 git-curl-compat.h | 11 -----------
 http.c            |  5 -----
 2 files changed, 16 deletions(-)

diff --git a/git-curl-compat.h b/git-curl-compat.h
index b301ef154c..cd970e34d6 100644
--- a/git-curl-compat.h
+++ b/git-curl-compat.h
@@ -28,17 +28,6 @@
  * introduced, oldest first, in the official version of cURL library.
  */
 
-/**
- * CURL_HTTP_VERSION_2 was added in 7.43.0, released in June 2015.
- *
- * The CURL_HTTP_VERSION_2 alias (but not CURL_HTTP_VERSION_2_0) has
- * always been a macro, not an enum field (checked on curl version
- * 7.78.0)
- */
-#if LIBCURL_VERSION_NUM >= 0x072b00
-#define GIT_CURL_HAVE_CURL_HTTP_VERSION_2 1
-#endif
-
 /**
  * CURLSSLOPT_NO_REVOKE was added in 7.44.0, released in August 2015.
  *
diff --git a/http.c b/http.c
index cdef059090..945df9a628 100644
--- a/http.c
+++ b/http.c
@@ -980,7 +980,6 @@ static long get_curl_allowed_protocols(int from_user, struct strbuf *list)
 	return bits;
 }
 
-#ifdef GIT_CURL_HAVE_CURL_HTTP_VERSION_2
 static int get_curl_http_version_opt(const char *version_string, long *opt)
 {
 	int i;
@@ -1003,8 +1002,6 @@ static int get_curl_http_version_opt(const char *version_string, long *opt)
 	return -1; /* not found */
 }
 
-#endif
-
 static CURL *get_curl_handle(void)
 {
 	CURL *result = curl_easy_init();
@@ -1022,7 +1019,6 @@ static CURL *get_curl_handle(void)
 		curl_easy_setopt(result, CURLOPT_SSL_VERIFYHOST, 2);
 	}
 
-#ifdef GIT_CURL_HAVE_CURL_HTTP_VERSION_2
     if (curl_http_version) {
 		long opt;
 		if (!get_curl_http_version_opt(curl_http_version, &opt)) {
@@ -1030,7 +1026,6 @@ static CURL *get_curl_handle(void)
 			curl_easy_setopt(result, CURLOPT_HTTP_VERSION, opt);
 		}
     }
-#endif
 
 	curl_easy_setopt(result, CURLOPT_NETRC, CURL_NETRC_OPTIONAL);
 	curl_easy_setopt(result, CURLOPT_HTTPAUTH, CURLAUTH_ANY);
