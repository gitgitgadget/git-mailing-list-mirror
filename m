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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22F39C433EF
	for <git@archiver.kernel.org>; Sat, 11 Sep 2021 09:34:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0CB2760F9D
	for <git@archiver.kernel.org>; Sat, 11 Sep 2021 09:34:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235640AbhIKJfv (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 11 Sep 2021 05:35:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235627AbhIKJfq (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Sep 2021 05:35:46 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2FDBC061574
        for <git@vger.kernel.org>; Sat, 11 Sep 2021 02:34:33 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id t18so6325753wrb.0
        for <git@vger.kernel.org>; Sat, 11 Sep 2021 02:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=f8i3RQq9ThlGST9+kEgj0g1Yf8YWIqAxy8Z/CZQ2ZM4=;
        b=MulgL4DqxXNYhm/gI0oj1LqUb3Y1s/I5GHUpxwEZQQpwIvHnPAVITjKMn7h7BnItoo
         Wm9rVPkpeKxI45yPD3JKLL2CcI9Tm4wX6BmRz9UXR8KDbwQ/gLrhIKj4XPkFivSrtWXH
         Vz2IxubhUDP7NyE59l8CFJHUV8AkziWbkJHi75DnM+awmIQvcR//kr4nJpAF7gGBeWId
         QxEOChAaVrpEpgpEpWM1ERnpZ3YBpyvx/UWCjCsWZYdvY1CBY9KpFXACcVCAdp0Ml9/U
         t9fSi/Fz37zCldObZDRCBKlnrnTTM0zNQ0HEtEcs/cVJAv85ZAhXCEz/81L7Wk50LXva
         iqwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=f8i3RQq9ThlGST9+kEgj0g1Yf8YWIqAxy8Z/CZQ2ZM4=;
        b=pSPi3fJ+j074tjhFuTEH//KJIPxG3zbn+aOt1nNTjrk/mRkzsYbRy9m4NtLtA7R5tV
         QhHaSQqOZWPWcaQlmo/IpcrUjEjETOXGUWSzM2HTilNIc4xQ4OzbhnVfRANXpeoLb9Ma
         vtbuxKcwww+ILGW/n75AoFCmBPqn94bcysb70oRmMaVgoYiLzf1bfB99KuPUoCRA2trR
         BngKHbAsUf8iaPkwZTfq/gY5UfzqPrevnsr+bQ8I6HCf4HReCxXaPuE/spvSyEJMMqkw
         1mub+YTeAu1f8smMVOFHl/+9Wbzt7MolKFeDzeFYZ6zTBOGXTWhzmPkEtGrgPv5zh3l+
         lNfQ==
X-Gm-Message-State: AOAM530aWfkPMoEOAcVGJK8T1vtNlZDyAPcu7Y8Xgr7V2XWc0DUquxhs
        nW+fvCDFbe8urQspXw0Uqp+Rj9up0OShHg==
X-Google-Smtp-Source: ABdhPJzpa/AtGKgjjdQpf0Mq60leeeyfnH6UNboRnhkIRfWcsSywHg23pcSTopx9eDtdAyigNOg0BQ==
X-Received: by 2002:a5d:4285:: with SMTP id k5mr2299989wrq.131.1631352872126;
        Sat, 11 Sep 2021 02:34:32 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id s10sm1161753wrg.42.2021.09.11.02.34.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Sep 2021 02:34:31 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Daniel Stenberg <daniel@haxx.se>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 8/9] http: centralize the accounting of libcurl dependencies
Date:   Sat, 11 Sep 2021 11:34:22 +0200
Message-Id: <patch-v3-8.9-e2e53cbfba1-20210911T092751Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.984.gea2c3555113
In-Reply-To: <cover-v3-0.9-00000000000-20210911T092751Z-avarab@gmail.com>
References: <cover-v2-0.8-00000000000-20210910T105523Z-avarab@gmail.com> <cover-v3-0.9-00000000000-20210911T092751Z-avarab@gmail.com>
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
2.33.0.984.gea2c3555113

