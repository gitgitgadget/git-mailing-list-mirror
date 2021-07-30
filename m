Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4205FC4338F
	for <git@archiver.kernel.org>; Fri, 30 Jul 2021 09:35:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2804A603E9
	for <git@archiver.kernel.org>; Fri, 30 Jul 2021 09:35:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238350AbhG3Jfc (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Jul 2021 05:35:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238260AbhG3JfR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Jul 2021 05:35:17 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07307C061798
        for <git@vger.kernel.org>; Fri, 30 Jul 2021 02:35:09 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id p5so10473498wro.7
        for <git@vger.kernel.org>; Fri, 30 Jul 2021 02:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3ILv9UhtlUCYHUNNELduf5g2fPWJrl6CXDzT+n8a1U8=;
        b=H9n+WEZ3BRByGh0BVI3WWvf2P3j+3MX93X5umVGXXv8q7+56BOsLHRE97MkEftdxqz
         /+UAGPLWCuyWl9/0i0Q59isERk8MgSQNgGQplTFSg7Gh2YpPqLch1bE+DOLd/u2HzIxy
         KWEp9cc1BTgQ+9EnMBFBdEfZLiI0geB128ewHHqFefzFdSdayx27b2oJVDKBKgdiS1j0
         TG14zRnSewitiBP02PQUqShfBLzXc5LmlJARAHc47ymXmK5P06sU+qUeyQAFb/DQjowY
         qt+boqJQmxjJ2/FN9bGWAqzpe4jYAph52CWd/XLhplthIGBZQfyzxqAZ2DJXdVMutbdB
         m1Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3ILv9UhtlUCYHUNNELduf5g2fPWJrl6CXDzT+n8a1U8=;
        b=ehkqJoza6gqiNc+wm6le+cyvFypGsJgmVJnZQyYMf8XcBr94+l6okm9FrgWzb6wRyF
         LKwFojMy74v8VmdJroQGFL1eUofJpR8y9kVhLM8HwrJ53LHS7JQ+laIIik68FzmzwrEJ
         Dal6semK9WjHza8LZ5kHel0ym/YOPXCyV140EZzsVYwxLjArADgMREtJMmlNUfoj0Gxz
         sDXouy0MwHkColhRPRXFaNMDn67J3A5yFVuVf/pT10SUahNs1MifLnfDbi5J5IlXYVp/
         00nX4K9hI/8tGcMgLGK3+eaJcnZlVOKDWjL7nWmliaR7l3PrLRtSQOkU6jhu8U277ysT
         NTVQ==
X-Gm-Message-State: AOAM532TO9mhRW7NMImKqonareLFpFGh1+IwF7a5yvTPaL7F3MsTr0XF
        xdeXymz2YNRcai92P395OquipxQdcI/DSQ==
X-Google-Smtp-Source: ABdhPJzVpUSrY6VZ2YYxT/Km5MkHPDNI0FFFx2De9GVdyhw56r7VKbQGfQbAmJ58UJMUUKtGYTAU4A==
X-Received: by 2002:adf:e6cf:: with SMTP id y15mr1968555wrm.217.1627637707333;
        Fri, 30 Jul 2021 02:35:07 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id t17sm1089903wru.94.2021.07.30.02.35.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jul 2021 02:35:06 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Nicolas Morey-Chaisemartin <NMoreyChaisemartin@suse.de>,
        "Tom G . Christensen" <tgc@jupiterrise.com>,
        Mischa POSLAWSKY <git@shiar.nl>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 7/7] http: centralize the accounting of libcurl dependencies
Date:   Fri, 30 Jul 2021 11:31:59 +0200
Message-Id: <patch-v3-7.7-93a2775d0ee-20210730T092843Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.1069.g516d52f3d85
In-Reply-To: <cover-v3-0.7-00000000000-20210730T092843Z-avarab@gmail.com>
References: <cover-0.5-00000000000-20210721T220402Z-avarab@gmail.com> <cover-v3-0.7-00000000000-20210730T092843Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As noted in preceding commits checking against LIBCURL_VERSION_NUM
isn't as reliable as checking specific defines in curl, as some
distros have been known to backport features. Furthermore we had at
least one case of someone confusing base 10 for base 16 in comparing
the version.

Let's add a git-curl-compat.h header that'll keep track of these
dependencies, and make the next round of deprecations easier. This
patch is mostly obvious, with the following exceptions:

 - In aeff8a61216 (http: implement public key pinning, 2016-02-15) a
   dependency and warning() was added if curl older than 7.44.0 was
   used, but the relevant code depended on CURLOPT_PINNEDPUBLICKEY,
   introduced in 7.39.0.

 - We did not use CURL_SOCKOPT_OK and instead hardcoded its value in
   a15d069a198 (http: enable keepalive on TCP sockets, 2013-10-12),
   let's use it and guard its use by a new GITCURL_HAVE_* check.

 - We guarded the support for http.version with a check for curl
   7.47.0, looking at the history of how that happen reveals that an
   earlier on-list version of d73019feb44 (http: add support selecting
   http version, 2018-11-08) depended on CURL_HTTP_VERSION_2TLS (which
   was added in 7.47.0).

   But the version this code depended on was in fact 7.43.0, since
   that's when CURL_HTTP_VERSION_2_0 was added.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 git-curl-compat.h | 119 ++++++++++++++++++++++++++++++++++++++++++++++
 http.c            |  41 ++++++++--------
 imap-send.c       |   6 +--
 3 files changed, 143 insertions(+), 23 deletions(-)
 create mode 100644 git-curl-compat.h

diff --git a/git-curl-compat.h b/git-curl-compat.h
new file mode 100644
index 00000000000..554f244034e
--- /dev/null
+++ b/git-curl-compat.h
@@ -0,0 +1,119 @@
+#ifndef GIT_CURL_COMPAT_H
+#define GIT_CURL_COMPAT_H
+
+/**
+ * This header centralized the declaration of our libcurl dependencies
+ * to make it easy to discover the oldest versions we support, and to
+ * inform decisions about removing support for older libcurl in the
+ * future.
+ *
+ * The source of truth for what versions have which symbols is
+ * https://github.com/curl/curl/blob/master/docs/libcurl/symbols-in-versions;
+ * the release dates are taken from curl.git (at
+ * https://github.com/curl/curl/).
+ *
+ * For each X symbol we need from curl we check if it exists and
+ * declare our own GIT_CURl_HAVE_X, or if it's for both X and Y
+ * GIT_CURl_HAVE_X_and_Y, where the "Y" in "X_and_Y" is only the part
+ * of the symbol name that "X" and "Y" don't have in common.
+ *
+ * We avoid comparisons against LIBCURL_VERSION_NUM, enterprise
+ * distros have been known to backport symbols to their older curl
+ * versions.
+ *
+ * Keep any symbols in date order of when their support was
+ * introduced, oldest first.
+ */
+
+/**
+ * CURL_SOCKOPT_OK was added in 7.21.5, released in April 2011.
+ */
+#ifdef CURL_SOCKOPT_OK
+#define GITCURL_HAVE_CURL_SOCKOPT_OK 1
+#endif
+
+/**
+ * CURLOPT_TCP_KEEPALIVE was added in 7.25.0, released in March 2012.
+ */
+#ifdef CURLOPT_TCP_KEEPALIVE
+#define GITCURL_HAVE_CURLOPT_TCP_KEEPALIVE 1
+#endif
+
+
+/**
+ * CURLOPT_LOGIN_OPTIONS was added in 7.34.0, released in December
+ * 2013.
+ */
+#ifdef CURLOPT_LOGIN_OPTIONS
+#define GIT_CURL_HAVE_CURLOPT_LOGIN_OPTIONS 1
+#endif
+
+/**
+ * CURL_SSLVERSION_TLSv1_[012] was added in 7.34.0, released in
+ * December 2013.
+ */
+#if defined(CURL_SSLVERSION_TLSv1_0) && \
+    defined(CURL_SSLVERSION_TLSv1_1) && \
+    defined(CURL_SSLVERSION_TLSv1_2)
+#define GIT_CURL_HAVE_CURL_SSLVERSION_TLSv1_0_and_1_and_2
+#endif
+
+/**
+ * CURLOPT_PINNEDPUBLICKEY was added in 7.39.0, released in November
+ * 2014.
+ */
+#ifdef CURLOPT_PINNEDPUBLICKEY
+#define GIT_CURL_HAVE_CURLOPT_PINNEDPUBLICKEY 1
+#endif
+
+/**
+ * CURL_HTTP_VERSION_2 was added in 7.43.0, released in June 2015.
+ */
+#ifdef CURL_HTTP_VERSION_2
+#define GIT_CURL_HAVE_CURL_HTTP_VERSION_2 1
+#endif
+
+/**
+ * CURLSSLOPT_NO_REVOKE was added in 7.44.0, released in August 2015.
+ */
+#ifdef CURLSSLOPT_NO_REVOKE
+#define GIT_CURL_HAVE_CURLSSLOPT_NO_REVOKE 1
+#endif
+
+/**
+ * CURLOPT_PROXY_CAINFO was added in 7.52.0, released in August 2017.
+ */
+#ifdef CURLOPT_PROXY_CAINFO
+#define GIT_CURL_HAVE_CURLOPT_PROXY_CAINFO 1
+#endif
+
+/**
+ * CURLOPT_PROXY_{KEYPASSWD,SSLCERT,SSLKEY} was added in 7.52.0,
+ * released in August 2017.
+ */
+#if defined(CURLOPT_PROXY_KEYPASSWD) && \
+    defined(CURLOPT_PROXY_SSLCERT) && \
+    defined(CURLOPT_PROXY_SSLKEY)
+#define GIT_CURL_HAVE_CURLOPT_PROXY_KEYPASSWD_and_SSLCERT_and_SSLKEY 1
+#endif
+
+/**
+ * CURL_SSLVERSION_TLSv1_3 was added in 7.53.0, released in February
+ * 2017.
+ */
+#ifdef CURL_SSLVERSION_TLSv1_3
+#define GIT_CURL_HAVE_CURL_SSLVERSION_TLSv1_3 1
+#endif
+
+/**
+ * CURLSSLSET_{NO_BACKENDS,OK,TOO_LATE,UNKNOWN_BACKEND} were added in
+ * 7.56.0, released in September 2017.
+ */
+#if defined(CURLSSLSET_NO_BACKENDS) && \
+    defined(CURLSSLSET_OK) && \
+    defined(CURLSSLSET_TOO_LATE) && \
+    defined(CURLSSLSET_UNKNOWN_BACKEND)
+#define GIT_CURL_HAVE_CURLSSLSET_NO_BACKENDS_and_OK_and_TOO_LATE_and_UNKNOWN_BACKEND 1
+#endif
+
+#endif
diff --git a/http.c b/http.c
index 56856178bfe..e8939a1ccf6 100644
--- a/http.c
+++ b/http.c
@@ -1,4 +1,5 @@
 #include "git-compat-util.h"
+#include "git-curl-compat.h"
 #include "http.h"
 #include "config.h"
 #include "pack.h"
@@ -47,21 +48,19 @@ static struct {
 	{ "sslv2", CURL_SSLVERSION_SSLv2 },
 	{ "sslv3", CURL_SSLVERSION_SSLv3 },
 	{ "tlsv1", CURL_SSLVERSION_TLSv1 },
-#if LIBCURL_VERSION_NUM >= 0x072200
+#if GIT_CURL_HAVE_CURL_SSLVERSION_TLSv1_0_AND_1_AND_2
 	{ "tlsv1.0", CURL_SSLVERSION_TLSv1_0 },
 	{ "tlsv1.1", CURL_SSLVERSION_TLSv1_1 },
 	{ "tlsv1.2", CURL_SSLVERSION_TLSv1_2 },
 #endif
-#if LIBCURL_VERSION_NUM >= 0x073400
+#if GIT_CURL_HAVE_CURL_SSLVERSION_TLSv1_3
 	{ "tlsv1.3", CURL_SSLVERSION_TLSv1_3 },
 #endif
 };
 static const char *ssl_key;
 static const char *ssl_capath;
 static const char *curl_no_proxy;
-#if LIBCURL_VERSION_NUM >= 0x072c00
 static const char *ssl_pinnedkey;
-#endif
 static const char *ssl_cainfo;
 static long curl_low_speed_limit = -1;
 static long curl_low_speed_time = -1;
@@ -373,12 +372,10 @@ static int http_options(const char *var, const char *value, void *cb)
 	}
 
 	if (!strcmp("http.pinnedpubkey", var)) {
-#if LIBCURL_VERSION_NUM >= 0x072c00
-		return git_config_pathname(&ssl_pinnedkey, var, value);
-#else
-		warning(_("Public key pinning not supported with cURL < 7.44.0"));
-		return 0;
+#ifndef GIT_CURL_HAVE_CURLOPT_PINNEDPUBLICKEY
+		warning(_("Public key pinning not supported with cURL < 7.39.0"));
 #endif
+		return git_config_pathname(&ssl_pinnedkey, var, value);
 	}
 
 	if (!strcmp("http.extraheader", var)) {
@@ -500,7 +497,7 @@ static int has_cert_password(void)
 	return 1;
 }
 
-#if LIBCURL_VERSION_NUM >= 0x073400
+#ifdef GIT_CURL_HAVE_CURLOPT_PROXY_KEYPASSWD_and_SSLCERT_and_SSLKEY
 static int has_proxy_cert_password(void)
 {
 	if (http_proxy_ssl_cert == NULL || proxy_ssl_cert_password_required != 1)
@@ -516,7 +513,7 @@ static int has_proxy_cert_password(void)
 }
 #endif
 
-#if LIBCURL_VERSION_NUM >= 0x071900
+#ifdef GITCURL_HAVE_CURLOPT_TCP_KEEPALIVE
 static void set_curl_keepalive(CURL *c)
 {
 	curl_easy_setopt(c, CURLOPT_TCP_KEEPALIVE, 1);
@@ -536,7 +533,11 @@ static int sockopt_callback(void *client, curl_socket_t fd, curlsocktype type)
 	if (rc < 0)
 		warning_errno("unable to set SO_KEEPALIVE on socket");
 
-	return 0; /* CURL_SOCKOPT_OK only exists since curl 7.21.5 */
+#ifdef GITCURL_HAVE_CURL_SOCKOPT_OK
+	return CURL_SOCKOPT_OK;
+#else
+	return 0;
+#endif
 }
 
 static void set_curl_keepalive(CURL *c)
@@ -732,7 +733,7 @@ static long get_curl_allowed_protocols(int from_user)
 	return allowed_protocols;
 }
 
-#if LIBCURL_VERSION_NUM >=0x072f00
+#ifdef GIT_CURL_HAVE_CURL_HTTP_VERSION_2
 static int get_curl_http_version_opt(const char *version_string, long *opt)
 {
 	int i;
@@ -774,7 +775,7 @@ static CURL *get_curl_handle(void)
 		curl_easy_setopt(result, CURLOPT_SSL_VERIFYHOST, 2);
 	}
 
-#if LIBCURL_VERSION_NUM >= 0x072f00 // 7.47.0
+#ifdef GIT_CURL_HAVE_CURL_HTTP_VERSION_2
     if (curl_http_version) {
 		long opt;
 		if (!get_curl_http_version_opt(curl_http_version, &opt)) {
@@ -805,7 +806,7 @@ static CURL *get_curl_handle(void)
 
 	if (http_ssl_backend && !strcmp("schannel", http_ssl_backend) &&
 	    !http_schannel_check_revoke) {
-#if LIBCURL_VERSION_NUM >= 0x072c00
+#ifdef GIT_CURL_HAVE_CURLSSLOPT_NO_REVOKE
 		curl_easy_setopt(result, CURLOPT_SSL_OPTIONS, CURLSSLOPT_NO_REVOKE);
 #else
 		warning(_("CURLSSLOPT_NO_REVOKE not supported with cURL < 7.44.0"));
@@ -845,20 +846,20 @@ static CURL *get_curl_handle(void)
 		curl_easy_setopt(result, CURLOPT_SSLKEY, ssl_key);
 	if (ssl_capath != NULL)
 		curl_easy_setopt(result, CURLOPT_CAPATH, ssl_capath);
-#if LIBCURL_VERSION_NUM >= 0x072c00
+#ifdef GIT_CURL_HAVE_CURLOPT_PINNEDPUBLICKEY
 	if (ssl_pinnedkey != NULL)
 		curl_easy_setopt(result, CURLOPT_PINNEDPUBLICKEY, ssl_pinnedkey);
 #endif
 	if (http_ssl_backend && !strcmp("schannel", http_ssl_backend) &&
 	    !http_schannel_use_ssl_cainfo) {
 		curl_easy_setopt(result, CURLOPT_CAINFO, NULL);
-#if LIBCURL_VERSION_NUM >= 0x073400
+#ifdef GIT_CURL_HAVE_CURLOPT_PROXY_CAINFO
 		curl_easy_setopt(result, CURLOPT_PROXY_CAINFO, NULL);
 #endif
 	} else if (ssl_cainfo != NULL || http_proxy_ssl_ca_info != NULL) {
 		if (ssl_cainfo != NULL)
 			curl_easy_setopt(result, CURLOPT_CAINFO, ssl_cainfo);
-#if LIBCURL_VERSION_NUM >= 0x073400
+#ifdef GIT_CURL_HAVE_CURLOPT_PROXY_CAINFO
 		if (http_proxy_ssl_ca_info != NULL)
 			curl_easy_setopt(result, CURLOPT_PROXY_CAINFO, http_proxy_ssl_ca_info);
 #endif
@@ -939,7 +940,7 @@ static CURL *get_curl_handle(void)
 		else if (starts_with(curl_http_proxy, "socks"))
 			curl_easy_setopt(result,
 				CURLOPT_PROXYTYPE, CURLPROXY_SOCKS4);
-#if LIBCURL_VERSION_NUM >= 0x073400
+#ifdef GIT_CURL_HAVE_CURLOPT_PROXY_KEYPASSWD_and_SSLCERT_and_SSLKEY
 		else if (starts_with(curl_http_proxy, "https")) {
 			curl_easy_setopt(result, CURLOPT_PROXYTYPE, CURLPROXY_HTTPS);
 
@@ -1004,7 +1005,7 @@ void http_init(struct remote *remote, const char *url, int proactive_auth)
 	free(normalized_url);
 	string_list_clear(&config.vars, 1);
 
-#if LIBCURL_VERSION_NUM >= 0x073800
+#ifdef GIT_CURL_HAVE_CURLSSLSET_NO_BACKENDS_and_OK_and_TOO_LATE_and_UNKNOWN_BACKEND
 	if (http_ssl_backend) {
 		const curl_ssl_backend **backends;
 		struct strbuf buf = STRBUF_INIT;
diff --git a/imap-send.c b/imap-send.c
index 49a5f8aa597..2da96a9532f 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -1441,14 +1441,14 @@ static CURL *setup_curl(struct imap_server_conf *srvc, struct credential *cred)
 	curl_easy_setopt(curl, CURLOPT_PORT, server.port);
 
 	if (server.auth_method) {
-#if LIBCURL_VERSION_NUM < 0x072200
-		warning("No LOGIN_OPTIONS support in this cURL version");
-#else
+#ifdef GIT_CURL_HAVE_CURLOPT_LOGIN_OPTIONS
 		struct strbuf auth = STRBUF_INIT;
 		strbuf_addstr(&auth, "AUTH=");
 		strbuf_addstr(&auth, server.auth_method);
 		curl_easy_setopt(curl, CURLOPT_LOGIN_OPTIONS, auth.buf);
 		strbuf_release(&auth);
+#else
+		warning("No LOGIN_OPTIONS support in this cURL version");
 #endif
 	}
 
-- 
2.32.0.1069.g516d52f3d85

