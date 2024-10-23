Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 548C7224FD
	for <git@vger.kernel.org>; Wed, 23 Oct 2024 00:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729644371; cv=none; b=ihJBKoVKdjttPSfBVE77AsfWQhHgB16ae11hywsMQnORXxc7OI9blgkl+KbGHDQcNLi8db+QkCUgCqWqQFYqZIwLlnc0LUy3BQJClGauZkNj17qsNe30RL5TR6PzSIXbjW8kICTTOj/EPDOftsYzrdbzn/VYq+wN/iTP+JSbNUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729644371; c=relaxed/simple;
	bh=dtfw2xRbiDHcM4T1nUorlbwVxN0N9b9G/mFEo9WO2M4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pbWFdJaFHdcXojeZ+ZZrBsREjKnAM0XreFLpIlTgZSCBGcPpMkDCVgrW0u4AvYaFbHp8034Ei6i/OS21os/bDy1WJftewq4VH+C33brILpKHFg7/Iccd5EvgnWzwXDd2S0ozIcc7hTeLYzkbueMSRQjVXKjvELV3JX7s/7DwzIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=YZIDRwnl; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="YZIDRwnl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1729644364;
	bh=dtfw2xRbiDHcM4T1nUorlbwVxN0N9b9G/mFEo9WO2M4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
	 Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	 In-Reply-To:References:Content-Type:Content-Disposition;
	b=YZIDRwnlO5283UFxBIBOxnU6Mzf9uChBovLl3ZRXyMi1Noe2mM2QbsxYT0QnDHyMd
	 NzgyPOCr7PG3BlTO0IVHE77GkMp7L1p7/PMVnMCzb8N9p3B0IAbmvMhp1cfjnV9OM1
	 ZFYV8RNejS4wzs+IAlrlNv3uQ7iQVPiYhCqHp0Qu3OvYI1RheGL2DU8/mXu8ICLlfU
	 uB4oPE4JB5xTAl5MvP3wFjc3Z1MS9oXTKkRhBViI+4NwcG5psi/5qaq//+Sxp595GL
	 j+hnxAA55VuEh5WOclCnedXS7JiRYLv6PprBQ6S/uYdF+QkHmRIRT46yAWOOfTrc0z
	 +SJlMWy4c8VQSsdsGz2pkiIncq8WHcRztPiNYAZTiVUZ5y5jYz5fcBJ2U1OccAFe15
	 lGLteqSwSJRsSxgF7rjncwRdEj0azyG+l7X0n78ZKk1K06iopUPNOgunDoZFNoyirt
	 6zpcJiWEtiQKVolYlTc/UJkLI+YIrXSxvSGprVe8QtuUCmSLo8W
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 5C83C200C0;
	Wed, 23 Oct 2024 00:46:04 +0000 (UTC)
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Taylor Blau <me@ttaylorr.com>
Subject: [PATCH v2 06/12] git-curl-compat: remove check for curl 7.44.0
Date: Wed, 23 Oct 2024 00:45:54 +0000
Message-ID: <20241023004600.1645313-7-sandals@crustytoothpaste.net>
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

libcurl 7.44.0 was released in August 2015, which is over nine years
ago, and no major operating system vendor is still providing security
support for it.  Debian 9 and Ubuntu 16.04, both of which are out of
mainstream security support, have supported a newer version, and RHEL 8,
which is still in support, also has a newer version.

Remove the check for this version and use this functionality
unconditionally.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 git-curl-compat.h | 10 ----------
 http.c            |  4 ----
 2 files changed, 14 deletions(-)

diff --git a/git-curl-compat.h b/git-curl-compat.h
index cd970e34d6..6b05d70d42 100644
--- a/git-curl-compat.h
+++ b/git-curl-compat.h
@@ -28,16 +28,6 @@
  * introduced, oldest first, in the official version of cURL library.
  */
 
-/**
- * CURLSSLOPT_NO_REVOKE was added in 7.44.0, released in August 2015.
- *
- * The CURLSSLOPT_NO_REVOKE is, has always been a macro, not an enum
- * field (checked on curl version 7.78.0)
- */
-#if LIBCURL_VERSION_NUM >= 0x072c00
-#define GIT_CURL_HAVE_CURLSSLOPT_NO_REVOKE 1
-#endif
-
 /**
  * CURLOPT_PROXY_CAINFO was added in 7.52.0, released in August 2017.
  */
diff --git a/http.c b/http.c
index 945df9a628..bdf8bf7b59 100644
--- a/http.c
+++ b/http.c
@@ -1048,11 +1048,7 @@ static CURL *get_curl_handle(void)
 
 	if (http_ssl_backend && !strcmp("schannel", http_ssl_backend) &&
 	    !http_schannel_check_revoke) {
-#ifdef GIT_CURL_HAVE_CURLSSLOPT_NO_REVOKE
 		curl_easy_setopt(result, CURLOPT_SSL_OPTIONS, CURLSSLOPT_NO_REVOKE);
-#else
-		warning(_("CURLSSLOPT_NO_REVOKE not supported with cURL < 7.44.0"));
-#endif
 	}
 
 	if (http_proactive_auth != PROACTIVE_AUTH_NONE)
