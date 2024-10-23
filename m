Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42DF5168DA
	for <git@vger.kernel.org>; Wed, 23 Oct 2024 00:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729644367; cv=none; b=VTPI/KV5SJHXktt/plQCFAO0VzYej/ACYS56fIbzVhCLjb7HW0nFJ0UFCkYtN/ZU5GOCJ1Sdhpfe4uX/pWEAFFvPth0acWwDEzWfseLH7X+EIGOC2xjiKqR8+9+TuUZzKKoMxACXNUcUKeFzODJzVePOQexiXey/ddO9HVGHdjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729644367; c=relaxed/simple;
	bh=2yteCggdA6LXgbOa72SHjQ2rtzToPOp6SaBetTTikRA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BsmIaEfywtDD1jLSiCNF4KrgECiwlHfZ0ILqc7hpj6G+CUasiwvkmQSR83YB0YIhJu5t+4XiaQpppgAbxmBR3227C9bPzz1uqss/Bovvs3rnZQUnV/0f3DVY938Ycr9RL4Q86sTbKciV8EonvuzdUTrqU2CDKJordiix3g7AErg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=x0z3hxfN; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="x0z3hxfN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1729644364;
	bh=2yteCggdA6LXgbOa72SHjQ2rtzToPOp6SaBetTTikRA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
	 Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	 In-Reply-To:References:Content-Type:Content-Disposition;
	b=x0z3hxfNaZaQjGuIxTeoOebI3PHliG08zZv0eIvTD2q6DNUumCL2GNU6p+oZAf/AY
	 GDMYt7nDO9r2y6SqkSMCFdHZ3CN/0M3HcMYTMkZdM1oJ12kVuDOWa+kHR//wgEGEgw
	 Bogm8LKUjIQSXBC8NJrstNgs4Vo/1s18Fob8vM89aydQR8Bl/ciUQSEwfEdIBZ46LU
	 diLlCPsePXxUsloDSIFarfHjdroy9+cHvnSfgsjBpOQFig7thUhH/KYSqgS17r9Vcd
	 5iZRztQ47CUK1TqbXk4uXU6A+oJYNxk9SNcJ8O1Yo2IagzrS8dZ8OkVx9rFhcCuqr7
	 9YwcQ5Yz+Tl1VKNAV+Ul9pDwlt2z8xWpdyqoJhbjX7RUd8abJwm4IL2Q+5cHz8+fld
	 RWWBC6q41EpWWnI+FJuoPv1mcZD6GRxCVIWF4UXKf+R7TkQ8SI6WBzpzjso1LT2Wys
	 kEYf6/BEsiIhEeXnbx1n8+mgOgfF2G2TGQCIrmYUdjPyXeUj03Q
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 47277200BE;
	Wed, 23 Oct 2024 00:46:04 +0000 (UTC)
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Taylor Blau <me@ttaylorr.com>
Subject: [PATCH v2 04/12] git-curl-compat: remove check for curl 7.39.0
Date: Wed, 23 Oct 2024 00:45:52 +0000
Message-ID: <20241023004600.1645313-5-sandals@crustytoothpaste.net>
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

libcurl 7.39.0 was released in November 2014, which is almost ten years
ago, and no major operating system vendor is still providing security
support for it.  Debian 9 and Ubuntu 16.04, both of which are out of
mainstream security support, have supported a newer version, and RHEL 8,
which is still in support, also has a newer version.

Remove the check for this version and use this functionality
unconditionally.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 git-curl-compat.h |  9 ---------
 http.c            | 11 -----------
 2 files changed, 20 deletions(-)

diff --git a/git-curl-compat.h b/git-curl-compat.h
index 21306fa88f..b301ef154c 100644
--- a/git-curl-compat.h
+++ b/git-curl-compat.h
@@ -28,15 +28,6 @@
  * introduced, oldest first, in the official version of cURL library.
  */
 
-/**
- * CURLOPT_PINNEDPUBLICKEY was added in 7.39.0, released in November
- * 2014. CURLE_SSL_PINNEDPUBKEYNOTMATCH was added in that same version.
- */
-#if LIBCURL_VERSION_NUM >= 0x072c00
-#define GIT_CURL_HAVE_CURLOPT_PINNEDPUBLICKEY 1
-#define GIT_CURL_HAVE_CURLE_SSL_PINNEDPUBKEYNOTMATCH 1
-#endif
-
 /**
  * CURL_HTTP_VERSION_2 was added in 7.43.0, released in June 2015.
  *
diff --git a/http.c b/http.c
index ac4b98baa0..cdef059090 100644
--- a/http.c
+++ b/http.c
@@ -63,9 +63,7 @@ static char *ssl_key;
 static char *ssl_key_type;
 static char *ssl_capath;
 static char *curl_no_proxy;
-#ifdef GIT_CURL_HAVE_CURLOPT_PINNEDPUBLICKEY
 static char *ssl_pinnedkey;
-#endif
 static char *ssl_cainfo;
 static long curl_low_speed_limit = -1;
 static long curl_low_speed_time = -1;
@@ -509,12 +507,7 @@ static int http_options(const char *var, const char *value,
 	}
 
 	if (!strcmp("http.pinnedpubkey", var)) {
-#ifdef GIT_CURL_HAVE_CURLOPT_PINNEDPUBLICKEY
 		return git_config_pathname(&ssl_pinnedkey, var, value);
-#else
-		warning(_("Public key pinning not supported with cURL < 7.39.0"));
-		return 0;
-#endif
 	}
 
 	if (!strcmp("http.extraheader", var)) {
@@ -1104,10 +1097,8 @@ static CURL *get_curl_handle(void)
 		curl_easy_setopt(result, CURLOPT_SSLKEYTYPE, ssl_key_type);
 	if (ssl_capath)
 		curl_easy_setopt(result, CURLOPT_CAPATH, ssl_capath);
-#ifdef GIT_CURL_HAVE_CURLOPT_PINNEDPUBLICKEY
 	if (ssl_pinnedkey)
 		curl_easy_setopt(result, CURLOPT_PINNEDPUBLICKEY, ssl_pinnedkey);
-#endif
 	if (http_ssl_backend && !strcmp("schannel", http_ssl_backend) &&
 	    !http_schannel_use_ssl_cainfo) {
 		curl_easy_setopt(result, CURLOPT_CAINFO, NULL);
@@ -1825,10 +1816,8 @@ static int handle_curl_result(struct slot_results *results)
 		 */
 		credential_reject(&cert_auth);
 		return HTTP_NOAUTH;
-#ifdef GIT_CURL_HAVE_CURLE_SSL_PINNEDPUBKEYNOTMATCH
 	} else if (results->curl_result == CURLE_SSL_PINNEDPUBKEYNOTMATCH) {
 		return HTTP_NOMATCHPUBLICKEY;
-#endif
 	} else if (missing_target(results))
 		return HTTP_MISSING_TARGET;
 	else if (results->http_code == 401) {
