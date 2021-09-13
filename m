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
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAF80C433FE
	for <git@archiver.kernel.org>; Mon, 13 Sep 2021 15:37:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B389B6103B
	for <git@archiver.kernel.org>; Mon, 13 Sep 2021 15:37:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241092AbhIMPiS (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Sep 2021 11:38:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241239AbhIMPiE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Sep 2021 11:38:04 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67289C020E7E
        for <git@vger.kernel.org>; Mon, 13 Sep 2021 07:51:44 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id u16so15148608wrn.5
        for <git@vger.kernel.org>; Mon, 13 Sep 2021 07:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NxvopZ6QZexJAttXmIm1JFZXyz1dCpjeWh6jD+v17F8=;
        b=Vs5Y6mL+KMteo5N5OiCstzN4C3LaL6wIPeUrI3qS9WWvBHDIi90Oc6hkoyzWXs+L0B
         C1N1aHztvp4lYL9V6P2GtlXcye98ZvmSVhN+laV2dHiMIvU6vBwhms5dW30qPuPZA/aw
         eFXGJXuC2bgvAB+7juXFInVcq1mWIJmgjRH1cfqujX5uQAjZ2mqnVDFIlPlMmFd/t0Qh
         nu0dkK0coQV82KTz+Bi0WLOorzB8LCGMXqQBuPU/ibG7Hd+lt4n6cgDb/GJZ0iJoinNK
         RmijsRIJ9FoQCz0Zph4K+TStP0AveUiziXaabtfjK0Fw3hWSdyH+GEfBym6Z3tZPUj+W
         F4cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NxvopZ6QZexJAttXmIm1JFZXyz1dCpjeWh6jD+v17F8=;
        b=iPD5b2vI+1vCopR/sKQ04Gs2EB6S/IjF0twwGRtSh5FdFnVJKQ1FzGflK7RUIaJ4kP
         wO6qN/XA8jbZ6/z7EX4DNjdkPttNKBPa5A6Y1DP53kaLnyvJDPb2LXURpQ1dlZThRcNw
         IF/cNEMxAJgiiwTTq/CBl6c+zq7m16iCXRbcGj0cB25RFuiJM+Ud3xtCx6LR+6XNWFRh
         24cAk77J65E8Fnewf5xwY/TlJ2ciL2CXZN+xxeadKVyYCStnT+hPPuiVUV779UNa4wAp
         cwFVIVyg+Rv/7E67ae6lrZAbBuSHrReOvoYU2CeIDLceWU6nvWiUw7WcgAC9N3on5yrt
         rlPw==
X-Gm-Message-State: AOAM531/ytYHpUqG2cbONHDpYbqtfqN/AiKSyBO2uQPjylieUuBvQxLB
        7kTjWzwIruFGy39ya0s0DTf5lDStGoomcg==
X-Google-Smtp-Source: ABdhPJxSuKfGztdLtOQnvMOu6Kd5A1ZhhwHl7/n0nWiPyQmoXRs6kb2QSP2fPRoyUPxpZ8M8yS5CZA==
X-Received: by 2002:a5d:5003:: with SMTP id e3mr13265840wrt.118.1631544702541;
        Mon, 13 Sep 2021 07:51:42 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o24sm3638854wmm.11.2021.09.13.07.51.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Sep 2021 07:51:41 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Daniel Stenberg <daniel@haxx.se>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 8/9] http: centralize the accounting of libcurl dependencies
Date:   Mon, 13 Sep 2021 16:51:28 +0200
Message-Id: <patch-v4-8.9-9890e4b662a-20210913T144846Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1013.ge8323766266
In-Reply-To: <cover-v4-0.9-00000000000-20210913T144846Z-avarab@gmail.com>
References: <cover-v3-0.9-00000000000-20210911T092751Z-avarab@gmail.com> <cover-v4-0.9-00000000000-20210913T144846Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As discussed in 644de29e220 (http: drop support for curl < 7.19.4,
2021-07-30) checking against LIBCURL_VERSION_NUM isn't as reliable as
checking specific symbols present in curl, as some distros have been
known to backport features.

However, while some of the curl_easy_setopt() arguments we rely on are
macros, others are enum, and we can't assume that those that are
macros won't change into enums in the future.

So we're still going to have to check LIBCURL_VERSION_NUM, but by
doing that in one central place and using a macro definition of our
own, anyone who's backporting features can define it themselves, and
thus have access to more modern curl features that they backported,
even if they didn't bump the LIBCURL_VERSION_NUM.

More importantly, as shown in a preceding commit doing these version
checks makes for hard to read and possibly buggy code, as shown by the
bug fixed there where we were conflating base 10 for base 16 when
comparing the version.

By doing them all in one place we'll hopefully reduce the chances of
such future mistakes, furthermore it now becomes easier to see at a
glance what the oldest supported version is, which makes it easier to
reason about any future deprecation similar to the recent
e48a623dea0 (Merge branch 'ab/http-drop-old-curl', 2021-08-24).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 git-curl-compat.h | 117 ++++++++++++++++++++++++++++++++++++++++++++++
 http.c            |  29 ++++++------
 imap-send.c       |   2 +-
 3 files changed, 133 insertions(+), 15 deletions(-)
 create mode 100644 git-curl-compat.h

diff --git a/git-curl-compat.h b/git-curl-compat.h
new file mode 100644
index 00000000000..7ad87e89ed5
--- /dev/null
+++ b/git-curl-compat.h
@@ -0,0 +1,117 @@
+#ifndef GIT_CURL_COMPAT_H
+#define GIT_CURL_COMPAT_H
+#include <curl/curl.h>
+
+/**
+ * This header centralizes the declaration of our libcurl dependencies
+ * to make it easy to discover the oldest versions we support, and to
+ * inform decisions about removing support for older libcurl in the
+ * future.
+ *
+ * The oldest supported version of curl is documented in the "INSTALL"
+ * document.
+ *
+ * The source of truth for what versions have which symbols is
+ * https://github.com/curl/curl/blob/master/docs/libcurl/symbols-in-versions;
+ * the release dates are taken from curl.git (at
+ * https://github.com/curl/curl/).
+ *
+ * For each X symbol we need from curl we define our own
+ * GIT_CURL_HAVE_X. If multiple similar symbols with the same prefix
+ * were defined in the same version we pick one and check for that name.
+ *
+ * Keep any symbols in date order of when their support was
+ * introduced, oldest first, in the official version of cURL library.
+ */
+
+/**
+ * CURLOPT_TCP_KEEPALIVE was added in 7.25.0, released in March 2012.
+ */
+#if LIBCURL_VERSION_NUM >= 0x071900
+#define GITCURL_HAVE_CURLOPT_TCP_KEEPALIVE 1
+#endif
+
+
+/**
+ * CURLOPT_LOGIN_OPTIONS was added in 7.34.0, released in December
+ * 2013.
+ *
+ * If we start requiring 7.34.0 we might also be able to remove the
+ * code conditional on USE_CURL_FOR_IMAP_SEND in imap-send.c, see
+ * 1e16b255b95 (git-imap-send: use libcurl for implementation,
+ * 2014-11-09) and the check it added for "072200" in the Makefile.
+
+ */
+#if LIBCURL_VERSION_NUM >= 0x072200
+#define GIT_CURL_HAVE_CURLOPT_LOGIN_OPTIONS 1
+#endif
+
+/**
+ * CURL_SSLVERSION_TLSv1_[012] was added in 7.34.0, released in
+ * December 2013.
+ */
+#if LIBCURL_VERSION_NUM >= 0x072200
+#define GIT_CURL_HAVE_CURL_SSLVERSION_TLSv1_0
+#endif
+
+/**
+ * CURLOPT_PINNEDPUBLICKEY was added in 7.39.0, released in November
+ * 2014.
+ */
+#if LIBCURL_VERSION_NUM >= 0x072c00
+#define GIT_CURL_HAVE_CURLOPT_PINNEDPUBLICKEY 1
+#endif
+
+/**
+ * CURL_HTTP_VERSION_2 was added in 7.43.0, released in June 2015.
+ *
+ * The CURL_HTTP_VERSION_2 alias (but not CURL_HTTP_VERSION_2_0) has
+ * always been a macro, not an enum field (checked on curl version
+ * 7.78.0)
+ */
+#if LIBCURL_VERSION_NUM >= 0x072b00
+#define GIT_CURL_HAVE_CURL_HTTP_VERSION_2 1
+#endif
+
+/**
+ * CURLSSLOPT_NO_REVOKE was added in 7.44.0, released in August 2015.
+ *
+ * The CURLSSLOPT_NO_REVOKE is, has always been a macro, not an enum
+ * field (checked on curl version 7.78.0)
+ */
+#if LIBCURL_VERSION_NUM >= 0x072c00
+#define GIT_CURL_HAVE_CURLSSLOPT_NO_REVOKE 1
+#endif
+
+/**
+ * CURLOPT_PROXY_CAINFO was added in 7.52.0, released in August 2017.
+ */
+#if LIBCURL_VERSION_NUM >= 0x073400
+#define GIT_CURL_HAVE_CURLOPT_PROXY_CAINFO 1
+#endif
+
+/**
+ * CURLOPT_PROXY_{KEYPASSWD,SSLCERT,SSLKEY} was added in 7.52.0,
+ * released in August 2017.
+ */
+#if LIBCURL_VERSION_NUM >= 0x073400
+#define GIT_CURL_HAVE_CURLOPT_PROXY_KEYPASSWD 1
+#endif
+
+/**
+ * CURL_SSLVERSION_TLSv1_3 was added in 7.53.0, released in February
+ * 2017.
+ */
+#if LIBCURL_VERSION_NUM >= 0x073400
+#define GIT_CURL_HAVE_CURL_SSLVERSION_TLSv1_3 1
+#endif
+
+/**
+ * CURLSSLSET_{NO_BACKENDS,OK,TOO_LATE,UNKNOWN_BACKEND} were added in
+ * 7.56.0, released in September 2017.
+ */
+#if LIBCURL_VERSION_NUM >= 0x073800
+#define GIT_CURL_HAVE_CURLSSLSET_NO_BACKENDS
+#endif
+
+#endif
diff --git a/http.c b/http.c
index 543faad9879..94eefe97089 100644
--- a/http.c
+++ b/http.c
@@ -1,4 +1,5 @@
 #include "git-compat-util.h"
+#include "git-curl-compat.h"
 #include "http.h"
 #include "config.h"
 #include "pack.h"
@@ -47,19 +48,19 @@ static struct {
 	{ "sslv2", CURL_SSLVERSION_SSLv2 },
 	{ "sslv3", CURL_SSLVERSION_SSLv3 },
 	{ "tlsv1", CURL_SSLVERSION_TLSv1 },
-#if LIBCURL_VERSION_NUM >= 0x072200
+#ifdef GIT_CURL_HAVE_CURL_SSLVERSION_TLSv1_0
 	{ "tlsv1.0", CURL_SSLVERSION_TLSv1_0 },
 	{ "tlsv1.1", CURL_SSLVERSION_TLSv1_1 },
 	{ "tlsv1.2", CURL_SSLVERSION_TLSv1_2 },
 #endif
-#if LIBCURL_VERSION_NUM >= 0x073400
+#ifdef GIT_CURL_HAVE_CURL_SSLVERSION_TLSv1_3
 	{ "tlsv1.3", CURL_SSLVERSION_TLSv1_3 },
 #endif
 };
 static const char *ssl_key;
 static const char *ssl_capath;
 static const char *curl_no_proxy;
-#if LIBCURL_VERSION_NUM >= 0x072700
+#ifdef GIT_CURL_HAVE_CURLOPT_PINNEDPUBLICKEY
 static const char *ssl_pinnedkey;
 #endif
 static const char *ssl_cainfo;
@@ -373,7 +374,7 @@ static int http_options(const char *var, const char *value, void *cb)
 	}
 
 	if (!strcmp("http.pinnedpubkey", var)) {
-#if LIBCURL_VERSION_NUM >= 0x072700
+#ifdef GIT_CURL_HAVE_CURLOPT_PINNEDPUBLICKEY
 		return git_config_pathname(&ssl_pinnedkey, var, value);
 #else
 		warning(_("Public key pinning not supported with cURL < 7.39.0"));
@@ -500,7 +501,7 @@ static int has_cert_password(void)
 	return 1;
 }
 
-#if LIBCURL_VERSION_NUM >= 0x073400
+#ifdef GIT_CURL_HAVE_CURLOPT_PROXY_KEYPASSWD
 static int has_proxy_cert_password(void)
 {
 	if (http_proxy_ssl_cert == NULL || proxy_ssl_cert_password_required != 1)
@@ -516,7 +517,7 @@ static int has_proxy_cert_password(void)
 }
 #endif
 
-#if LIBCURL_VERSION_NUM >= 0x071900
+#ifdef GITCURL_HAVE_CURLOPT_TCP_KEEPALIVE
 static void set_curl_keepalive(CURL *c)
 {
 	curl_easy_setopt(c, CURLOPT_TCP_KEEPALIVE, 1);
@@ -732,7 +733,7 @@ static long get_curl_allowed_protocols(int from_user)
 	return allowed_protocols;
 }
 
-#if LIBCURL_VERSION_NUM >=0x072b00
+#ifdef GIT_CURL_HAVE_CURL_HTTP_VERSION_2
 static int get_curl_http_version_opt(const char *version_string, long *opt)
 {
 	int i;
@@ -774,7 +775,7 @@ static CURL *get_curl_handle(void)
 		curl_easy_setopt(result, CURLOPT_SSL_VERIFYHOST, 2);
 	}
 
-#if LIBCURL_VERSION_NUM >= 0x072b00
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
@@ -939,7 +940,7 @@ static CURL *get_curl_handle(void)
 		else if (starts_with(curl_http_proxy, "socks"))
 			curl_easy_setopt(result,
 				CURLOPT_PROXYTYPE, CURLPROXY_SOCKS4);
-#if LIBCURL_VERSION_NUM >= 0x073400
+#ifdef GIT_CURL_HAVE_CURLOPT_PROXY_KEYPASSWD
 		else if (starts_with(curl_http_proxy, "https")) {
 			curl_easy_setopt(result, CURLOPT_PROXYTYPE, CURLPROXY_HTTPS);
 
@@ -1004,7 +1005,7 @@ void http_init(struct remote *remote, const char *url, int proactive_auth)
 	free(normalized_url);
 	string_list_clear(&config.vars, 1);
 
-#if LIBCURL_VERSION_NUM >= 0x073800
+#ifdef GIT_CURL_HAVE_CURLSSLSET_NO_BACKENDS
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
2.33.0.1013.ge8323766266

