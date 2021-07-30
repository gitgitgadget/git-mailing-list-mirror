Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25244C4338F
	for <git@archiver.kernel.org>; Fri, 30 Jul 2021 17:59:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE4126023B
	for <git@archiver.kernel.org>; Fri, 30 Jul 2021 17:59:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230274AbhG3SAB (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Jul 2021 14:00:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229773AbhG3R75 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Jul 2021 13:59:57 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 410C4C06175F
        for <git@vger.kernel.org>; Fri, 30 Jul 2021 10:59:51 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id l34-20020a05600c1d22b02902573c214807so4275474wms.2
        for <git@vger.kernel.org>; Fri, 30 Jul 2021 10:59:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PEsjnB1GT9ayRTOBN8LHAYIQRI2N4O+CQrEGQ6r7rLY=;
        b=eALNldznkaaofA1/6jxf6w3DCqDHEcfnKw9SQBt64GGMLPq6eveIADkQLmQrwf1qCw
         owDEgTsxtflf7zQ1Ff6UmXuYlNYKFUo4t+gIyJmf+NlKYJWxR4a5OblfgA8oc2D40KFe
         71DMLg3dSTP0W8haQ2L/HjtTVraeqXm/XZFvU6DITpz8htg8sWm7PMombkyTy3Mqkxbt
         KbyMVXWo3txdHQRnfvneyS10KWOPf57J+u0p3P8OKktTqZjJ1BAE/5ohlAOvJZ7Z7tga
         yrHEOyuZRjHzFw69SgKOmyJ/RyCdYR6MvgDlQ17kyaVpTIMobJDsPKcfUOj8BE7Tqu1e
         qDKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PEsjnB1GT9ayRTOBN8LHAYIQRI2N4O+CQrEGQ6r7rLY=;
        b=k4kdqom4XOJ2cP6ZkC/uZlzH42npv/WYXv/JkMRr9Obg0qAGgU6ET4XSzUmKaAGydV
         Rr/gqDTuEIWuzzKM74QqVncQI5294Es4K1N5I3JX2ngM5k+Xj7c1CdC7VpC81DK65zxR
         AsAWU80W/+HA1Uy9XoRmJGzHfRnkuP5cc8qhlYP650I+ZUaWNeLIZ7+JzoeGOR5lBm4e
         YItEvt2cN75kJGmYDB11rMZ31yMMY2n8gsCita/3v1lr66zo9VQk4ELLH7KLZkk8Rqy0
         Q1CpXQcrjLNSAOpFbkPX6HH+IE0mA5P0qCZpp1q+AUrCrMOOOBNqyr4P0/r9Sm4wSIOw
         7TSg==
X-Gm-Message-State: AOAM530ao7PKKoz/QJGZriN81bDdW6o54ppuyeRkaIvG18y8CTxluUZU
        Am4QsJ54GCSsiRTQWzf8gewSGEF/rYzARw==
X-Google-Smtp-Source: ABdhPJy+WfyODWrw8Fdo9qJOjXlaU32E/vEwzz4CKfj+flsMEMltu3ge8bX0cM+C9IMvkiE7ikx8AA==
X-Received: by 2002:a1c:7c10:: with SMTP id x16mr4130594wmc.41.1627667989576;
        Fri, 30 Jul 2021 10:59:49 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i186sm2540311wmi.43.2021.07.30.10.59.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jul 2021 10:59:49 -0700 (PDT)
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
Subject: [PATCH v4 1/5] http: drop support for curl < 7.11.1
Date:   Fri, 30 Jul 2021 19:59:42 +0200
Message-Id: <patch-v4-1.5-6bd41764a54-20210730T175650Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.1071.g36f34456314
In-Reply-To: <cover-v4-0.5-00000000000-20210730T175650Z-avarab@gmail.com>
References: <cover-v3-0.7-00000000000-20210730T092843Z-avarab@gmail.com> <cover-v4-0.5-00000000000-20210730T175650Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff King <peff@peff.net>

Drop support for this ancient version of curl and simplify the code by
allowing us get rid of some "#ifdef"'s.

Git will not build with vanilla curl older than 7.11.1 due our use of
CURLOPT_POSTFIELDSIZE in 37ee680d9b
(http.postbuffer: allow full range of ssize_t values,
2017-04-11). This field was introduced in curl 7.11.1.

We could solve these compilation problems with more #ifdefs,
but it's not worth the trouble. Version 7.11.1 came out in
March of 2004, over 17 years ago. Let's declare that too old
and drop any existing ifdefs that go further back. One
obvious benefit is that we'll have fewer conditional bits
cluttering the code.

This patch drops all #ifdefs that reference older versions
(note that curl's preprocessor macros are in hex, so we're
looking for 070b01, not 071101).

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 http.c        | 53 ---------------------------------------------------
 http.h        | 12 +-----------
 remote-curl.c |  3 ---
 3 files changed, 1 insertion(+), 67 deletions(-)

diff --git a/http.c b/http.c
index 8119247149a..56182a89e25 100644
--- a/http.c
+++ b/http.c
@@ -19,19 +19,11 @@
 static struct trace_key trace_curl = TRACE_KEY_INIT(CURL);
 static int trace_curl_data = 1;
 static int trace_curl_redact = 1;
-#if LIBCURL_VERSION_NUM >= 0x070a08
 long int git_curl_ipresolve = CURL_IPRESOLVE_WHATEVER;
-#else
-long int git_curl_ipresolve;
-#endif
 int active_requests;
 int http_is_verbose;
 ssize_t http_post_buffer = 16 * LARGE_PACKET_MAX;
 
-#if LIBCURL_VERSION_NUM >= 0x070a06
-#define LIBCURL_CAN_HANDLE_AUTH_ANY
-#endif
-
 static int min_curl_sessions = 1;
 static int curl_session_count;
 #ifdef USE_CURL_MULTI
@@ -68,15 +60,9 @@ static struct {
 	{ "tlsv1.3", CURL_SSLVERSION_TLSv1_3 },
 #endif
 };
-#if LIBCURL_VERSION_NUM >= 0x070903
 static const char *ssl_key;
-#endif
-#if LIBCURL_VERSION_NUM >= 0x070908
 static const char *ssl_capath;
-#endif
-#if LIBCURL_VERSION_NUM >= 0x071304
 static const char *curl_no_proxy;
-#endif
 #if LIBCURL_VERSION_NUM >= 0x072c00
 static const char *ssl_pinnedkey;
 #endif
@@ -101,9 +87,7 @@ static struct {
 	{ "digest", CURLAUTH_DIGEST },
 	{ "negotiate", CURLAUTH_GSSNEGOTIATE },
 	{ "ntlm", CURLAUTH_NTLM },
-#ifdef LIBCURL_CAN_HANDLE_AUTH_ANY
 	{ "anyauth", CURLAUTH_ANY },
-#endif
 	/*
 	 * CURLAUTH_DIGEST_IE has no corresponding command-line option in
 	 * curl(1) and is not included in CURLAUTH_ANY, so we leave it out
@@ -143,7 +127,6 @@ enum http_follow_config http_follow_config = HTTP_FOLLOW_INITIAL;
 
 static struct credential cert_auth = CREDENTIAL_INIT;
 static int ssl_cert_password_required;
-#ifdef LIBCURL_CAN_HANDLE_AUTH_ANY
 static unsigned long http_auth_methods = CURLAUTH_ANY;
 static int http_auth_methods_restricted;
 /* Modes for which empty_auth cannot actually help us. */
@@ -153,7 +136,6 @@ static unsigned long empty_auth_useless =
 	| CURLAUTH_DIGEST_IE
 #endif
 	| CURLAUTH_DIGEST;
-#endif
 
 static struct curl_slist *pragma_header;
 static struct curl_slist *no_pragma_header;
@@ -237,12 +219,8 @@ static void finish_active_slot(struct active_request_slot *slot)
 	if (slot->results != NULL) {
 		slot->results->curl_result = slot->curl_result;
 		slot->results->http_code = slot->http_code;
-#if LIBCURL_VERSION_NUM >= 0x070a08
 		curl_easy_getinfo(slot->curl, CURLINFO_HTTPAUTH_AVAIL,
 				  &slot->results->auth_avail);
-#else
-		slot->results->auth_avail = 0;
-#endif
 
 		curl_easy_getinfo(slot->curl, CURLINFO_HTTP_CONNECTCODE,
 			&slot->results->http_connectcode);
@@ -305,14 +283,10 @@ static int http_options(const char *var, const char *value, void *cb)
 		return git_config_string(&ssl_version, var, value);
 	if (!strcmp("http.sslcert", var))
 		return git_config_pathname(&ssl_cert, var, value);
-#if LIBCURL_VERSION_NUM >= 0x070903
 	if (!strcmp("http.sslkey", var))
 		return git_config_pathname(&ssl_key, var, value);
-#endif
-#if LIBCURL_VERSION_NUM >= 0x070908
 	if (!strcmp("http.sslcapath", var))
 		return git_config_pathname(&ssl_capath, var, value);
-#endif
 	if (!strcmp("http.sslcainfo", var))
 		return git_config_pathname(&ssl_cainfo, var, value);
 	if (!strcmp("http.sslcertpasswordprotected", var)) {
@@ -461,12 +435,6 @@ static int curl_empty_auth_enabled(void)
 	if (curl_empty_auth >= 0)
 		return curl_empty_auth;
 
-#ifndef LIBCURL_CAN_HANDLE_AUTH_ANY
-	/*
-	 * Our libcurl is too old to do AUTH_ANY in the first place;
-	 * just default to turning the feature off.
-	 */
-#else
 	/*
 	 * In the automatic case, kick in the empty-auth
 	 * hack as long as we would potentially try some
@@ -479,7 +447,6 @@ static int curl_empty_auth_enabled(void)
 	if (http_auth_methods_restricted &&
 	    (http_auth_methods & ~empty_auth_useless))
 		return 1;
-#endif
 	return 0;
 }
 
@@ -552,7 +519,6 @@ static void init_curl_proxy_auth(CURL *result)
 
 	var_override(&http_proxy_authmethod, getenv("GIT_HTTP_PROXY_AUTHMETHOD"));
 
-#if LIBCURL_VERSION_NUM >= 0x070a07 /* CURLOPT_PROXYAUTH and CURLAUTH_ANY */
 	if (http_proxy_authmethod) {
 		int i;
 		for (i = 0; i < ARRAY_SIZE(proxy_authmethods); i++) {
@@ -570,7 +536,6 @@ static void init_curl_proxy_auth(CURL *result)
 	}
 	else
 		curl_easy_setopt(result, CURLOPT_PROXYAUTH, CURLAUTH_ANY);
-#endif
 }
 
 static int has_cert_password(void)
@@ -879,12 +844,8 @@ static CURL *get_curl_handle(void)
     }
 #endif
 
-#if LIBCURL_VERSION_NUM >= 0x070907
 	curl_easy_setopt(result, CURLOPT_NETRC, CURL_NETRC_OPTIONAL);
-#endif
-#ifdef LIBCURL_CAN_HANDLE_AUTH_ANY
 	curl_easy_setopt(result, CURLOPT_HTTPAUTH, CURLAUTH_ANY);
-#endif
 
 #ifdef CURLGSSAPI_DELEGATION_FLAG
 	if (curl_deleg) {
@@ -940,14 +901,10 @@ static CURL *get_curl_handle(void)
 		curl_easy_setopt(result, CURLOPT_SSLCERT, ssl_cert);
 	if (has_cert_password())
 		curl_easy_setopt(result, CURLOPT_KEYPASSWD, cert_auth.password);
-#if LIBCURL_VERSION_NUM >= 0x070903
 	if (ssl_key != NULL)
 		curl_easy_setopt(result, CURLOPT_SSLKEY, ssl_key);
-#endif
-#if LIBCURL_VERSION_NUM >= 0x070908
 	if (ssl_capath != NULL)
 		curl_easy_setopt(result, CURLOPT_CAPATH, ssl_capath);
-#endif
 #if LIBCURL_VERSION_NUM >= 0x072c00
 	if (ssl_pinnedkey != NULL)
 		curl_easy_setopt(result, CURLOPT_PINNEDPUBLICKEY, ssl_pinnedkey);
@@ -1180,12 +1137,8 @@ void http_init(struct remote *remote, const char *url, int proactive_auth)
 		curl_ssl_verify = 0;
 
 	set_from_env(&ssl_cert, "GIT_SSL_CERT");
-#if LIBCURL_VERSION_NUM >= 0x070903
 	set_from_env(&ssl_key, "GIT_SSL_KEY");
-#endif
-#if LIBCURL_VERSION_NUM >= 0x070908
 	set_from_env(&ssl_capath, "GIT_SSL_CAPATH");
-#endif
 	set_from_env(&ssl_cainfo, "GIT_SSL_CAINFO");
 
 	set_from_env(&user_agent, "GIT_HTTP_USER_AGENT");
@@ -1367,12 +1320,8 @@ struct active_request_slot *get_active_slot(void)
 	else
 		curl_easy_setopt(slot->curl, CURLOPT_FOLLOWLOCATION, 0);
 
-#if LIBCURL_VERSION_NUM >= 0x070a08
 	curl_easy_setopt(slot->curl, CURLOPT_IPRESOLVE, git_curl_ipresolve);
-#endif
-#ifdef LIBCURL_CAN_HANDLE_AUTH_ANY
 	curl_easy_setopt(slot->curl, CURLOPT_HTTPAUTH, http_auth_methods);
-#endif
 	if (http_auth.password || curl_empty_auth_enabled())
 		init_curl_http_auth(slot->curl);
 
@@ -1654,13 +1603,11 @@ static int handle_curl_result(struct slot_results *results)
 			credential_reject(&http_auth);
 			return HTTP_NOAUTH;
 		} else {
-#ifdef LIBCURL_CAN_HANDLE_AUTH_ANY
 			http_auth_methods &= ~CURLAUTH_GSSNEGOTIATE;
 			if (results->auth_avail) {
 				http_auth_methods &= results->auth_avail;
 				http_auth_methods_restricted = 1;
 			}
-#endif
 			return HTTP_REAUTH;
 		}
 	} else {
diff --git a/http.h b/http.h
index bf3d1270ad8..d2f8cc56617 100644
--- a/http.h
+++ b/http.h
@@ -22,13 +22,7 @@
 #define DEFAULT_MAX_REQUESTS 5
 #endif
 
-#if LIBCURL_VERSION_NUM < 0x070704
-#define curl_global_cleanup() do { /* nothing */ } while (0)
-#endif
-
-#if LIBCURL_VERSION_NUM < 0x070800
-#define curl_global_init(a) do { /* nothing */ } while (0)
-#elif LIBCURL_VERSION_NUM >= 0x070c00
+#if LIBCURL_VERSION_NUM >= 0x070c00
 #define curl_global_init(a) curl_global_init_mem(a, xmalloc, free, \
 						xrealloc, xstrdup, xcalloc)
 #endif
@@ -37,10 +31,6 @@
 #define NO_CURL_EASY_DUPHANDLE
 #endif
 
-#if LIBCURL_VERSION_NUM < 0x070a03
-#define CURLE_HTTP_RETURNED_ERROR CURLE_HTTP_NOT_FOUND
-#endif
-
 #if LIBCURL_VERSION_NUM < 0x070c03
 #define NO_CURL_IOCTL
 #endif
diff --git a/remote-curl.c b/remote-curl.c
index 6c320d57045..e738ae2c48a 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -185,8 +185,6 @@ static int set_option(const char *name, const char *value)
 						 strbuf_detach(&unquoted, NULL));
 		}
 		return 0;
-
-#if LIBCURL_VERSION_NUM >= 0x070a08
 	} else if (!strcmp(name, "family")) {
 		if (!strcmp(value, "ipv4"))
 			git_curl_ipresolve = CURL_IPRESOLVE_V4;
@@ -197,7 +195,6 @@ static int set_option(const char *name, const char *value)
 		else
 			return -1;
 		return 0;
-#endif /* LIBCURL_VERSION_NUM >= 0x070a08 */
 	} else if (!strcmp(name, "from-promisor")) {
 		options.from_promisor = 1;
 		return 0;
-- 
2.32.0.1071.g36f34456314

