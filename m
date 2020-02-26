Return-Path: <SRS0=QAHC=4O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1551C4BA33
	for <git@archiver.kernel.org>; Wed, 26 Feb 2020 23:24:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75EE220658
	for <git@archiver.kernel.org>; Wed, 26 Feb 2020 23:24:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NhDXVg8z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727967AbgBZXYD (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Feb 2020 18:24:03 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:50349 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727910AbgBZXYC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Feb 2020 18:24:02 -0500
Received: by mail-wm1-f68.google.com with SMTP id a5so1355339wmb.0
        for <git@vger.kernel.org>; Wed, 26 Feb 2020 15:24:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=sAmz7qAinefOOXHe6/n7EuBX2sF20HFUKVukE0qF324=;
        b=NhDXVg8zzmEt829fSxN8QLAZsiZazHZVc5E2Jn+FymDHrObzVzSOWD31XDKHsNZJDt
         RPnBrZXEjSQdH4wISPg0T4nYGG+nyHle0zcGcF2KvNfJcVfasyNs5m5jWQoO+htRhw2n
         vFWyCe4x84pXHRqV/ijhFh+38rGKswcttiKltiV/s+F/595SlnkbgUiDtD/Xe40xb6Ym
         3+6SHp/nxUFxv0/vc7v8PFgaFKqogVGK2MnDhlA7iqko2S5NUdHg16A/IzVjFfd5t7aQ
         TmL/+t+eqFgK8JAjF9H2rn/OrQi3uMxEH6b9ED8oaqwaf04Z0OuksYjdXGE4Wy8Qr3Y2
         S0kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=sAmz7qAinefOOXHe6/n7EuBX2sF20HFUKVukE0qF324=;
        b=QPqJLL+4vtoDEbyYn4xFhWFpoQ3TtAPQcj23R36eolsy+INarFmY1XE4YrFc8quQQi
         HPVr05Eo9vsHJxlhjF6iW+dabR/G2+rbGCAZBX9quc09jXBP58cHpEepT6hlyQzqP2u1
         GmSs0UlaxVLgBP0HiYYU+14ysabeY39XfLuTOacV7cTQE74GX45K2s/H3XrHDp0kwl5O
         9zsZKXJ4xuHj17Oo3w4Q3Kt3qxajcjJUq04K58e+HgCWCJxKjymRDJGMeZyc3e7vULaD
         mJNB4j7Q2RUjKZsQh+zti1UBgLbME/rHn6aGoKB1SPrZpdMp5mI8o2TZa8Ob6c3ouNzw
         eOgA==
X-Gm-Message-State: APjAAAXmc6mRO69EALMFYl/DMfngVPgXkaPToaU0A5rTlg0ocA/L8QJM
        76Ru7O6GCQBb3oyYK7mV1GxMhYDK
X-Google-Smtp-Source: APXvYqxL9Tgw+i92EUFvAV1vUgNYiCXRpdsXjdAQvZBQ71iyLRMju70aZ3TxnC5M120Z6cMEZ6VzOw==
X-Received: by 2002:a05:600c:224a:: with SMTP id a10mr1223283wmm.143.1582759440314;
        Wed, 26 Feb 2020 15:24:00 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g10sm5400280wrr.13.2020.02.26.15.23.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2020 15:23:59 -0800 (PST)
Message-Id: <a5d980e7501b1e0ab6f20a97136cd3a58427a139.1582759438.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.559.v2.git.1582759438.gitgitgadget@gmail.com>
References: <pull.559.git.1582321003.gitgitgadget@gmail.com>
        <pull.559.v2.git.1582759438.gitgitgadget@gmail.com>
From:   "Jorge Lopez Silva via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 26 Feb 2020 23:23:57 +0000
Subject: [PATCH v2 1/2] http: add client cert for HTTPS proxies.
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jorge <JALopezSilva@gmail.com>,
        Jorge Lopez Silva <jalopezsilva@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jorge Lopez Silva <jalopezsilva@gmail.com>

Git currently supports performing connections to HTTPS proxies but we
don't support doing mutual authentication with them (through TLS). This
commit adds the necessary options to be able to send a client
certificate to the HTTPS proxy.

A client certificate can provide an alternative way of authentication
instead of using 'ProxyAuthorization' or other more common methods of
authentication.

Libcurl supports this functionality already. The feature is guarded by
the first available libcurl version that supports these options.

Signed-off-by: Jorge Lopez Silva <jalopezsilva@gmail.com>
---
 http.c | 48 +++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 43 insertions(+), 5 deletions(-)

diff --git a/http.c b/http.c
index 00a0e507633..88782d39f15 100644
--- a/http.c
+++ b/http.c
@@ -86,6 +86,14 @@ static long curl_low_speed_time = -1;
 static int curl_ftp_no_epsv;
 static const char *curl_http_proxy;
 static const char *http_proxy_authmethod;
+
+#if LIBCURL_VERSION_NUM >= 0x073400
+static const char *http_proxy_ssl_cert;
+static const char *http_proxy_ssl_key;
+static const char *http_proxy_ssl_keypasswd;
+#endif
+static const char *http_proxy_ssl_ca_info;
+
 static struct {
 	const char *name;
 	long curlauth_param;
@@ -365,6 +373,20 @@ static int http_options(const char *var, const char *value, void *cb)
 	if (!strcmp("http.proxyauthmethod", var))
 		return git_config_string(&http_proxy_authmethod, var, value);
 
+#if LIBCURL_VERSION_NUM >= 0x073400
+	if (!strcmp("http.proxycert", var))
+		return git_config_string(&http_proxy_ssl_cert, var, value);
+
+	if (!strcmp("http.proxykey", var))
+		return git_config_string(&http_proxy_ssl_key, var, value);
+
+	if (!strcmp("http.proxykeypass", var))
+		return git_config_string(&http_proxy_ssl_keypasswd, var, value);
+
+	if (!strcmp("http.proxycainfo", var))
+		return git_config_string(&http_proxy_ssl_ca_info, var, value);
+#endif
+
 	if (!strcmp("http.cookiefile", var))
 		return git_config_pathname(&curl_cookie_file, var, value);
 	if (!strcmp("http.savecookies", var)) {
@@ -924,8 +946,14 @@ static CURL *get_curl_handle(void)
 #if LIBCURL_VERSION_NUM >= 0x073400
 		curl_easy_setopt(result, CURLOPT_PROXY_CAINFO, NULL);
 #endif
-	} else if (ssl_cainfo != NULL)
-		curl_easy_setopt(result, CURLOPT_CAINFO, ssl_cainfo);
+	} else if (ssl_cainfo != NULL || http_proxy_ssl_ca_info != NULL) {
+		if (ssl_cainfo != NULL)
+			curl_easy_setopt(result, CURLOPT_CAINFO, ssl_cainfo);
+#if LIBCURL_VERSION_NUM >= 0x073400
+		if (http_proxy_ssl_ca_info != NULL)
+			curl_easy_setopt(result, CURLOPT_PROXY_CAINFO, http_proxy_ssl_ca_info);
+#endif
+	}
 
 	if (curl_low_speed_limit > 0 && curl_low_speed_time > 0) {
 		curl_easy_setopt(result, CURLOPT_LOW_SPEED_LIMIT,
@@ -1018,9 +1046,19 @@ static CURL *get_curl_handle(void)
 				CURLOPT_PROXYTYPE, CURLPROXY_SOCKS4);
 #endif
 #if LIBCURL_VERSION_NUM >= 0x073400
-		else if (starts_with(curl_http_proxy, "https"))
-			curl_easy_setopt(result,
-				CURLOPT_PROXYTYPE, CURLPROXY_HTTPS);
+		else if (starts_with(curl_http_proxy, "https")) {
+			curl_easy_setopt(result, CURLOPT_PROXYTYPE, CURLPROXY_HTTPS);
+
+			if (http_proxy_ssl_cert != NULL)
+				curl_easy_setopt(result, CURLOPT_PROXY_SSLCERT, http_proxy_ssl_cert);
+
+			if (http_proxy_ssl_key != NULL)
+				curl_easy_setopt(result, CURLOPT_PROXY_SSLKEY, http_proxy_ssl_key);
+
+			if (http_proxy_ssl_keypasswd != NULL)
+				curl_easy_setopt(result, CURLOPT_PROXY_KEYPASSWD, http_proxy_ssl_keypasswd);
+
+		}
 #endif
 		if (strstr(curl_http_proxy, "://"))
 			credential_from_url(&proxy_auth, curl_http_proxy);
-- 
gitgitgadget

