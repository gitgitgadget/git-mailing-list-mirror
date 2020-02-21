Return-Path: <SRS0=3Brp=4J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BDE1C35666
	for <git@archiver.kernel.org>; Fri, 21 Feb 2020 21:36:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12A4F24676
	for <git@archiver.kernel.org>; Fri, 21 Feb 2020 21:36:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cZmyQbsj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727346AbgBUVgt (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Feb 2020 16:36:49 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39742 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726707AbgBUVgs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Feb 2020 16:36:48 -0500
Received: by mail-wm1-f67.google.com with SMTP id c84so3385050wme.4
        for <git@vger.kernel.org>; Fri, 21 Feb 2020 13:36:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=mbr+ymt8ufKrwsSgIopXYyJ4BpS6oWSc7SRMI1H0yJo=;
        b=cZmyQbsjWtqeVn+8btiezkIzpQOylpv1HB4q+SsBRb77yuY/KPsiVQMEK9JaJLzwSD
         xmmdmRVTrbPJ2S2BQbLPAP0UvxA7ondFYyARc806LmT5dAim/n9Bj9FJcodCG1rxm5Rp
         7oLtkR7nt+I+e0dsl7lNipwvwgId3LItFx7v454J3aFSzA/RXBxeUHjRAZsfFaUgzaye
         d5Bh0A/VdrEV1qsCyCoKw+yiKPdqT5ymQwjyRPGhEnvd/YPyY0qmYwdwUDKkz6/ndgL+
         uZBMmdkliq3FMpX0xeqrWK20WlNiZfIW4a0+cZJmUzIq1X1wAsJWAMu/UKAm0h3oAUhK
         qT8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=mbr+ymt8ufKrwsSgIopXYyJ4BpS6oWSc7SRMI1H0yJo=;
        b=rvFGR6CaIulwAQNj626HY66hVRoH6hN0dcuUzRgxqWM8HfsezOMK6RKNh4ebLqRIcf
         61yI1S4AkKplhbDsgiSYFg6XlfGzh4aCB7bN+SY9rbeLvXQk9dDGOlv8LngPHj0IjxKx
         FyTkAUaoDKCKZINCqtxKc2GRgIPbcPbCSadMPMD52IUTjdqtRt+mwYFshlhfZOExW64I
         lGawtWJir3vJ4xWWqE63P9ZBzACO7aGdyclIZ1X5ZBrd4T35rpsGAzco/lBOKZ0CyYKE
         0MbHpeTnkSDHXcUBal+VZw3oIGUgosIFIbyQ4cJm2A6F6EEgSg+KQTOcOh892emsInki
         Y8jw==
X-Gm-Message-State: APjAAAVFvcRd0AJofUZKc7CbTThk1pk34B4dWicFQzGh0jKjdgPFUCe3
        bpLX7CWCodFOlMAFu3yK0pLrFjgH
X-Google-Smtp-Source: APXvYqyZZtsF++fUrcFUb7cuh33IADJ2ujKw/sV07h3T3dAE778WlJeT/FbVMk+V4sEk3q8BMoHPlQ==
X-Received: by 2002:a7b:c753:: with SMTP id w19mr5943214wmk.34.1582321005329;
        Fri, 21 Feb 2020 13:36:45 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a184sm5544897wmf.29.2020.02.21.13.36.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2020 13:36:44 -0800 (PST)
Message-Id: <3cf866d0384a0743e6625dd4e5124f00a5db5e7d.1582321003.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.559.git.1582321003.gitgitgadget@gmail.com>
References: <pull.559.git.1582321003.gitgitgadget@gmail.com>
From:   "Jorge Lopez Silva via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 21 Feb 2020 21:36:42 +0000
Subject: [PATCH 1/2] http: add client cert for HTTPS proxies.
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
 http.c | 48 +++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 45 insertions(+), 3 deletions(-)

diff --git a/http.c b/http.c
index 00a0e507633..141cf8f80cd 100644
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
+static const char *http_proxy_ssl_key_passwd;
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
+		return git_config_string(&http_proxy_ssl_key_passwd, var, value);
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
@@ -1018,9 +1046,23 @@ static CURL *get_curl_handle(void)
 				CURLOPT_PROXYTYPE, CURLPROXY_SOCKS4);
 #endif
 #if LIBCURL_VERSION_NUM >= 0x073400
-		else if (starts_with(curl_http_proxy, "https"))
+		else if (starts_with(curl_http_proxy, "https")) {
 			curl_easy_setopt(result,
 				CURLOPT_PROXYTYPE, CURLPROXY_HTTPS);
+
+			if (http_proxy_ssl_cert != NULL) {
+				curl_easy_setopt(result,
+					CURLOPT_PROXY_SSLCERT, http_proxy_ssl_cert);
+				}
+			if (http_proxy_ssl_key != NULL) {
+				curl_easy_setopt(result,
+					CURLOPT_PROXY_SSLKEY, http_proxy_ssl_key);
+				}
+			if (http_proxy_ssl_key_passwd != NULL) {
+				curl_easy_setopt(result,
+					CURLOPT_PROXY_KEYPASSWD, http_proxy_ssl_key_passwd);
+				}
+			}
 #endif
 		if (strstr(curl_http_proxy, "://"))
 			credential_from_url(&proxy_auth, curl_http_proxy);
-- 
gitgitgadget

