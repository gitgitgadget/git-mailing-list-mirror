Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35D88C433FE
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 15:32:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0FC1D610E9
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 15:32:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352143AbhIHPdi (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Sep 2021 11:33:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350684AbhIHPdO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Sep 2021 11:33:14 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C787C061757
        for <git@vger.kernel.org>; Wed,  8 Sep 2021 08:32:06 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id y132so2083354wmc.1
        for <git@vger.kernel.org>; Wed, 08 Sep 2021 08:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FAd5ckzY9krZmSYkRFxCbpY31OIlz77VP7GsMUu5860=;
        b=X7yCv72138ZzM3pHhCdIVPqaZwyK8HGClMyUgF8iVZNlbJHjvrnZ5Q1UUMJIGs+NTE
         FC4NZx/NiihTAngteqN9d6Hu/ZW4ruMer9xGw5AZyxXAe/Yo1wfTxV9VWJhdkQSig3Sa
         VwxbQLe9IJbGPSGxPgiRzFk8Nc6EwAdujuWOKiDUHgDgTsX8VGe0c9YkS1ouTadl34BA
         90T8V15wYSfvm9tQp8RtK6IiUEUMVuBp/CzrsOcU61cTMGWB5YdtFCuh4URe1l7w1/F7
         KcfBymWiGbGxZTBstqT/YYpDFwNYW0w6/0dE6CaU5mDNDoA8AhA/kAmkcWZzliONJcER
         v42A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FAd5ckzY9krZmSYkRFxCbpY31OIlz77VP7GsMUu5860=;
        b=6GrlVWrtzZOF14cPEi1CZNE2ANmCKKfg1oSkl0QYw7xFj/S5rmB5bcOT2nQQAYBVLB
         FhEvcw73dr1s2AtInQxFOCBshegWDEe/JxByrhjIQlp0fOJSE1oWn2N/NQVxh4MxCjZ5
         J81aldL2FUyZYK28r6eXDZYP5WPg1LURLqhJJHtGsWsg/1kBS4vZOjAxWalle2CpHOzN
         PrU5IkpXl2ql8knM8PJB1t2kWe79lHNVOCY3ya8zz+EOqTWuY8rkDatkSqiT9RcfKsjK
         JgW3Rn+4JvNI43W201Cx6RvfmBkWrNUFGS2gN2xEmfm6fEtpboebiq5y1QtkSeXIYogQ
         W26A==
X-Gm-Message-State: AOAM5331n5MjjSZ47/pTNmoK1APidyqBnk3No/aQn888qpG8gDF0smgG
        WkyeWLcNhyBCMmQQyA3ayNtc7XIboSSerw==
X-Google-Smtp-Source: ABdhPJxreuUDgr+cC2C6RdcQQ9VotyY73sPeqqndhWc7S2eLN+ayekTkPpNZpBqDyxdqhZGKh7oRQg==
X-Received: by 2002:a05:600c:4848:: with SMTP id j8mr4323883wmo.13.1631115124605;
        Wed, 08 Sep 2021 08:32:04 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id j17sm2385580wrh.67.2021.09.08.08.32.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Sep 2021 08:32:04 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 4/5] http: centralize the accounting of libcurl dependencies
Date:   Wed,  8 Sep 2021 17:31:55 +0200
Message-Id: <patch-4.5-47b513a261b-20210908T152807Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.825.g2bf60429931
In-Reply-To: <cover-0.5-00000000000-20210908T152807Z-avarab@gmail.com>
References: <cover-v4-0.5-00000000000-20210730T175650Z-avarab@gmail.com> <cover-0.5-00000000000-20210908T152807Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As discussed in 644de29e220 (http: drop support for curl < 7.19.4,
2021-07-30) checking against LIBCURL_VERSION_NUM isn't as reliable as
checking specific defines in curl, as some distros have been known to
backport features. Furthermore as shown in the preceding commit doing
these version checks makes for hard to read and possibly buggy code,
as shown by the bug fixed there where we were conflating base 10 for
base 16 when comparing the version.

Let's instead add a new git-curl-compat.h header that'll keep track of
these dependencies. Following this pattern will also make it much
easier to track when we should deprecate curl versions in the future,
as we just did post-v2.33 e48a623dea0 (Merge branch
'ab/http-drop-old-curl', 2021-08-24).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 git-curl-compat.h | 112 ++++++++++++++++++++++++++++++++++++++++++++++
 http.c            |  31 +++++++------
 imap-send.c       |   2 +-
 3 files changed, 128 insertions(+), 17 deletions(-)
 create mode 100644 git-curl-compat.h

diff --git a/git-curl-compat.h b/git-curl-compat.h
new file mode 100644
index 00000000000..2bba7adefa6
--- /dev/null
+++ b/git-curl-compat.h
@@ -0,0 +1,112 @@
+#ifndef GIT_CURL_COMPAT_H
+#define GIT_CURL_COMPAT_H
+
+/**
+ * This header centralizes the declaration of our libcurl dependencies
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
+ * declare our own GIT_CURL_HAVE_X, or if it's for both X and Y
+ * GIT_CURL_HAVE_X_and_Y, where the "Y" in "X_and_Y" is only the part
+ * of the symbol name that "X" and "Y" don't have in common.
+ *
+ * We avoid comparisons against LIBCURL_VERSION_NUM, enterprise
+ * distros have been known to backport symbols to their older curl
+ * versions.
+ *
+ * Keep any symbols in date order of when their support was
+ * introduced, oldest first, in the official version of cURL library.
+ */
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
index b19d0a697d8..e38fcc34d64 100644
--- a/http.c
+++ b/http.c
@@ -1,4 +1,5 @@
 #include "git-compat-util.h"
+#include "git-curl-compat.h"
 #include "http.h"
 #include "config.h"
 #include "pack.h"
@@ -47,12 +48,12 @@ static struct {
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
@@ -371,12 +372,10 @@ static int http_options(const char *var, const char *value, void *cb)
 	}
 
 	if (!strcmp("http.pinnedpubkey", var)) {
-#if LIBCURL_VERSION_NUM >= 0x072700
-		return git_config_pathname(&ssl_pinnedkey, var, value);
-#else
+#ifndef GIT_CURL_HAVE_CURLOPT_PINNEDPUBLICKEY
 		warning(_("Public key pinning not supported with cURL < 7.39.0"));
-		return 0;
 #endif
+		return git_config_pathname(&ssl_pinnedkey, var, value);
 	}
 
 	if (!strcmp("http.extraheader", var)) {
@@ -498,7 +497,7 @@ static int has_cert_password(void)
 	return 1;
 }
 
-#if LIBCURL_VERSION_NUM >= 0x073400
+#ifdef GIT_CURL_HAVE_CURLOPT_PROXY_KEYPASSWD_and_SSLCERT_and_SSLKEY
 static int has_proxy_cert_password(void)
 {
 	if (http_proxy_ssl_cert == NULL || proxy_ssl_cert_password_required != 1)
@@ -514,7 +513,7 @@ static int has_proxy_cert_password(void)
 }
 #endif
 
-#if LIBCURL_VERSION_NUM >= 0x071900
+#ifdef GITCURL_HAVE_CURLOPT_TCP_KEEPALIVE
 static void set_curl_keepalive(CURL *c)
 {
 	curl_easy_setopt(c, CURLOPT_TCP_KEEPALIVE, 1);
@@ -730,7 +729,7 @@ static long get_curl_allowed_protocols(int from_user)
 	return allowed_protocols;
 }
 
-#if LIBCURL_VERSION_NUM >=0x072b00
+#ifdef GIT_CURL_HAVE_CURL_HTTP_VERSION_2
 static int get_curl_http_version_opt(const char *version_string, long *opt)
 {
 	int i;
@@ -772,7 +771,7 @@ static CURL *get_curl_handle(void)
 		curl_easy_setopt(result, CURLOPT_SSL_VERIFYHOST, 2);
 	}
 
-#if LIBCURL_VERSION_NUM >= 0x072b00
+#ifdef GIT_CURL_HAVE_CURL_HTTP_VERSION_2
     if (curl_http_version) {
 		long opt;
 		if (!get_curl_http_version_opt(curl_http_version, &opt)) {
@@ -803,7 +802,7 @@ static CURL *get_curl_handle(void)
 
 	if (http_ssl_backend && !strcmp("schannel", http_ssl_backend) &&
 	    !http_schannel_check_revoke) {
-#if LIBCURL_VERSION_NUM >= 0x072c00
+#ifdef GIT_CURL_HAVE_CURLSSLOPT_NO_REVOKE
 		curl_easy_setopt(result, CURLOPT_SSL_OPTIONS, CURLSSLOPT_NO_REVOKE);
 #else
 		warning(_("CURLSSLOPT_NO_REVOKE not supported with cURL < 7.44.0"));
@@ -843,20 +842,20 @@ static CURL *get_curl_handle(void)
 		curl_easy_setopt(result, CURLOPT_SSLKEY, ssl_key);
 	if (ssl_capath != NULL)
 		curl_easy_setopt(result, CURLOPT_CAPATH, ssl_capath);
-#if LIBCURL_VERSION_NUM >= 0x072700
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
@@ -937,7 +936,7 @@ static CURL *get_curl_handle(void)
 		else if (starts_with(curl_http_proxy, "socks"))
 			curl_easy_setopt(result,
 				CURLOPT_PROXYTYPE, CURLPROXY_SOCKS4);
-#if LIBCURL_VERSION_NUM >= 0x073400
+#ifdef GIT_CURL_HAVE_CURLOPT_PROXY_KEYPASSWD_and_SSLCERT_and_SSLKEY
 		else if (starts_with(curl_http_proxy, "https")) {
 			curl_easy_setopt(result, CURLOPT_PROXYTYPE, CURLPROXY_HTTPS);
 
@@ -1002,7 +1001,7 @@ void http_init(struct remote *remote, const char *url, int proactive_auth)
 	free(normalized_url);
 	string_list_clear(&config.vars, 1);
 
-#if LIBCURL_VERSION_NUM >= 0x073800
+#ifdef GIT_CURL_HAVE_CURLSSLSET_NO_BACKENDS_and_OK_and_TOO_LATE_and_UNKNOWN_BACKEND
 	if (http_ssl_backend) {
 		const curl_ssl_backend **backends;
 		struct strbuf buf = STRBUF_INIT;
diff --git a/imap-send.c b/imap-send.c
index 49a5f8aa597..e6090a0346a 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -1441,7 +1441,7 @@ static CURL *setup_curl(struct imap_server_conf *srvc, struct credential *cred)
 	curl_easy_setopt(curl, CURLOPT_PORT, server.port);
 
 	if (server.auth_method) {
-#if LIBCURL_VERSION_NUM < 0x072200
+#ifndef GIT_CURL_HAVE_CURLOPT_LOGIN_OPTIONS
 		warning("No LOGIN_OPTIONS support in this cURL version");
 #else
 		struct strbuf auth = STRBUF_INIT;
-- 
2.33.0.825.g2bf60429931

