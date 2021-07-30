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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E341C4338F
	for <git@archiver.kernel.org>; Fri, 30 Jul 2021 09:35:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 003F560EFD
	for <git@archiver.kernel.org>; Fri, 30 Jul 2021 09:35:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238413AbhG3JfQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Jul 2021 05:35:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238260AbhG3JfK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Jul 2021 05:35:10 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FBBFC0613C1
        for <git@vger.kernel.org>; Fri, 30 Jul 2021 02:35:05 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id j2so10452333wrx.9
        for <git@vger.kernel.org>; Fri, 30 Jul 2021 02:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pNdC/WwBBc1/PI2H4e+vgdiS2UAH7L7vhzHRVL7rSxE=;
        b=CAPFoC97m1pClb81nqMy8N/OuTa667aEvgYrT9Ft2fpqFvlR0FhylDnEqsW1O5w97n
         I6jOH1FJ36tu+B1DhxxrwFsshPbmU2ifHB9rL317Oo7eBBIYvEZxF7RpSsup5Ulz/LOV
         aJwrWUSqu+JeI6XWF4IyYg+fRtkYQ9oNTJ1aTOTJc9/lHRFGv9fGlFTXGZy1bY3XlUaw
         XhLuT2P6khz6ObhgStwBxWlp3+FSU2Sn98S97wvlvhvLeG6SLOfB0z+UrTYkjYZTTNaz
         lZZ0KeV+dvYVqA/3tWBsBNzp++grQ/jSYbSdugp4mluQ1rhDGDweV/QuDnspvUyBDm4b
         ePgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pNdC/WwBBc1/PI2H4e+vgdiS2UAH7L7vhzHRVL7rSxE=;
        b=Ts4slGM9YmJWBdnxMK7iNtL3kP6o7ySgxEJtvKeJyPjbw2PytD72uDq3bd+hEjor6K
         gDjDswIOLgeREc2BX1GW1pIW09V/CWs0t+Jk1NEx+tjBziyr+AG9sakOLmMwpHCrtRqt
         wzEbd8XZoJ7rYAvL+L0ALNcDj8nFAd3F7u1vMxhq6+0Q30oj+QFLXCrxE2O1r1EbIPUr
         2N0GbohmIAshAH26obbZWsFY5eJoxVFTsLOGOEj2ZeOutyy6760ge0iwWlekwTHGq3dB
         I7a7eW61+ZGpFuo5Q5jL1IUBNklo+WTedvWIk7GWLyRqRg0xC1C04lIzqF+Vi200Iy1k
         JJHQ==
X-Gm-Message-State: AOAM530u/Sh3YjHKbWomR2Mlc7IKay+gao7m4pA1Yhz85FYYdBadGEUK
        T3/3KAn2oeS0PuTU3IfEuvwuNTkWXFUZig==
X-Google-Smtp-Source: ABdhPJxb42dzCGaehvXgdl9wEnTg6yCZu8rEDjEGSMIb5sevDftsLHxX2d9nG7VvTJzTyylZBKMckQ==
X-Received: by 2002:adf:ed50:: with SMTP id u16mr2014956wro.174.1627637703764;
        Fri, 30 Jul 2021 02:35:03 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id t17sm1089903wru.94.2021.07.30.02.35.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jul 2021 02:35:03 -0700 (PDT)
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
Subject: [PATCH v3 3/7] http: drop support for curl < 7.19.4
Date:   Fri, 30 Jul 2021 11:31:55 +0200
Message-Id: <patch-v3-3.7-9fcd3a3e486-20210730T092843Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.1069.g516d52f3d85
In-Reply-To: <cover-v3-0.7-00000000000-20210730T092843Z-avarab@gmail.com>
References: <cover-0.5-00000000000-20210721T220402Z-avarab@gmail.com> <cover-v3-0.7-00000000000-20210730T092843Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff King <peff@peff.net>

In the last commit we dropped support for curl < 7.16.0, let's
continue that and drop support for versions older than 7.19.4. This
allows us to simplify the code by getting rid of some "#ifdef"'s.

Git was broken with vanilla curl < 7.19.4 from v2.12.0 until
v2.15.0. Compiling with it was broken by using CURLPROTO_* outside any
"#ifdef" in aeae4db174 (http: create function to get curl allowed
protocols, 2016-12-14), and fixed in v2.15.0 in f18777ba6ef (http: fix
handling of missing CURLPROTO_*, 2017-08-11).

It's unclear how much anyone was impacted by that in practice, since
as noted in [1] RHEL versions using curl older than that still
compiled, because RedHat backported some features. Perhaps other
vendors did the same.

Still, it's one datapoint indicating that it wasn't in active use at
the time. That (the v2.12.0 release) was in Feb 24, 2017, with v2.15.0
on Oct 30, 2017, it's now mid-2021.

1. http://lore.kernel.org/git/c8a2716d-76ac-735c-57f9-175ca3acbcb0@jupiterrise.com;
   followed-up by f18777ba6ef (http: fix handling of missing CURLPROTO_*,
   2017-08-11)

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 http.c | 50 --------------------------------------------------
 http.h |  4 ----
 2 files changed, 54 deletions(-)

diff --git a/http.c b/http.c
index ef00e930232..1f0d7664d35 100644
--- a/http.c
+++ b/http.c
@@ -28,9 +28,7 @@ static int min_curl_sessions = 1;
 static int curl_session_count;
 static int max_requests = -1;
 static CURLM *curlm;
-#ifndef NO_CURL_EASY_DUPHANDLE
 static CURL *curl_default;
-#endif
 
 #define PREV_BUF_SIZE 4096
 
@@ -440,24 +438,8 @@ static void init_curl_http_auth(CURL *result)
 
 	credential_fill(&http_auth);
 
-#if LIBCURL_VERSION_NUM >= 0x071301
 	curl_easy_setopt(result, CURLOPT_USERNAME, http_auth.username);
 	curl_easy_setopt(result, CURLOPT_PASSWORD, http_auth.password);
-#else
-	{
-		static struct strbuf up = STRBUF_INIT;
-		/*
-		 * Note that we assume we only ever have a single set of
-		 * credentials in a given program run, so we do not have
-		 * to worry about updating this buffer, only setting its
-		 * initial value.
-		 */
-		if (!up.len)
-			strbuf_addf(&up, "%s:%s",
-				http_auth.username, http_auth.password);
-		curl_easy_setopt(result, CURLOPT_USERPWD, up.buf);
-	}
-#endif
 }
 
 /* *var must be free-able */
@@ -471,22 +453,10 @@ static void var_override(const char **var, char *value)
 
 static void set_proxyauth_name_password(CURL *result)
 {
-#if LIBCURL_VERSION_NUM >= 0x071301
 		curl_easy_setopt(result, CURLOPT_PROXYUSERNAME,
 			proxy_auth.username);
 		curl_easy_setopt(result, CURLOPT_PROXYPASSWORD,
 			proxy_auth.password);
-#else
-		struct strbuf s = STRBUF_INIT;
-
-		strbuf_addstr_urlencode(&s, proxy_auth.username,
-					is_rfc3986_unreserved);
-		strbuf_addch(&s, ':');
-		strbuf_addstr_urlencode(&s, proxy_auth.password,
-					is_rfc3986_unreserved);
-		curl_proxyuserpwd = strbuf_detach(&s, NULL);
-		curl_easy_setopt(result, CURLOPT_PROXYUSERPWD, curl_proxyuserpwd);
-#endif
 }
 
 static void init_curl_proxy_auth(CURL *result)
@@ -748,7 +718,6 @@ void setup_curl_trace(CURL *handle)
 	curl_easy_setopt(handle, CURLOPT_DEBUGDATA, NULL);
 }
 
-#ifdef CURLPROTO_HTTP
 static long get_curl_allowed_protocols(int from_user)
 {
 	long allowed_protocols = 0;
@@ -764,7 +733,6 @@ static long get_curl_allowed_protocols(int from_user)
 
 	return allowed_protocols;
 }
-#endif
 
 #if LIBCURL_VERSION_NUM >=0x072f00
 static int get_curl_http_version_opt(const char *version_string, long *opt)
@@ -906,19 +874,11 @@ static CURL *get_curl_handle(void)
 	}
 
 	curl_easy_setopt(result, CURLOPT_MAXREDIRS, 20);
-#if LIBCURL_VERSION_NUM >= 0x071301
 	curl_easy_setopt(result, CURLOPT_POSTREDIR, CURL_REDIR_POST_ALL);
-#elif LIBCURL_VERSION_NUM >= 0x071101
-	curl_easy_setopt(result, CURLOPT_POST301, 1);
-#endif
-#ifdef CURLPROTO_HTTP
 	curl_easy_setopt(result, CURLOPT_REDIR_PROTOCOLS,
 			 get_curl_allowed_protocols(0));
 	curl_easy_setopt(result, CURLOPT_PROTOCOLS,
 			 get_curl_allowed_protocols(-1));
-#else
-	warning(_("Protocol restrictions not supported with cURL < 7.19.4"));
-#endif
 	if (getenv("GIT_CURL_VERBOSE"))
 		http_trace_curl_no_data();
 	setup_curl_trace(result);
@@ -1012,11 +972,9 @@ static CURL *get_curl_handle(void)
 			die("Invalid proxy URL '%s'", curl_http_proxy);
 
 		curl_easy_setopt(result, CURLOPT_PROXY, proxy_auth.host);
-#if LIBCURL_VERSION_NUM >= 0x071304
 		var_override(&curl_no_proxy, getenv("NO_PROXY"));
 		var_override(&curl_no_proxy, getenv("no_proxy"));
 		curl_easy_setopt(result, CURLOPT_NOPROXY, curl_no_proxy);
-#endif
 	}
 	init_curl_proxy_auth(result);
 
@@ -1147,9 +1105,7 @@ void http_init(struct remote *remote, const char *url, int proactive_auth)
 			ssl_cert_password_required = 1;
 	}
 
-#ifndef NO_CURL_EASY_DUPHANDLE
 	curl_default = get_curl_handle();
-#endif
 }
 
 void http_cleanup(void)
@@ -1167,9 +1123,7 @@ void http_cleanup(void)
 	}
 	active_queue_head = NULL;
 
-#ifndef NO_CURL_EASY_DUPHANDLE
 	curl_easy_cleanup(curl_default);
-#endif
 
 	curl_multi_cleanup(curlm);
 	curl_global_cleanup();
@@ -1248,11 +1202,7 @@ struct active_request_slot *get_active_slot(void)
 	}
 
 	if (slot->curl == NULL) {
-#ifdef NO_CURL_EASY_DUPHANDLE
-		slot->curl = get_curl_handle();
-#else
 		slot->curl = curl_easy_duphandle(curl_default);
-#endif
 		curl_session_count++;
 	}
 
diff --git a/http.h b/http.h
index cb092622a73..19f19dbe74c 100644
--- a/http.h
+++ b/http.h
@@ -12,10 +12,6 @@
 
 #define DEFAULT_MAX_REQUESTS 5
 
-#if LIBCURL_VERSION_NUM == 0x071000
-#define NO_CURL_EASY_DUPHANDLE
-#endif
-
 /*
  * CURLOPT_USE_SSL was known as CURLOPT_FTP_SSL up to 7.16.4,
  * and the constants were known as CURLFTPSSL_*
-- 
2.32.0.1069.g516d52f3d85

