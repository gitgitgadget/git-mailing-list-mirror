Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5E4E71FADF
	for <e@80x24.org>; Fri, 19 Jan 2018 00:28:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755257AbeASA2a (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Jan 2018 19:28:30 -0500
Received: from mail-pf0-f196.google.com ([209.85.192.196]:38418 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755127AbeASA2N (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Jan 2018 19:28:13 -0500
Received: by mail-pf0-f196.google.com with SMTP id k19so36042pfj.5
        for <git@vger.kernel.org>; Thu, 18 Jan 2018 16:28:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=IysRiwaFy1Qh88j7E6BP3RGu1O0BjT217HZZSogBhd4=;
        b=HhglooM2OEDHLCOz/vZz6d+5GPxREyRU+j3TED6R4vZ+0EVFU8igUlcgVnqOaKeNn3
         mUh3rze4/DcepkQT2bTzMm9uerco6OwB2qSuGmw7S4EhT97psSCSLt89TXNB7n5aVhAa
         atrGlBwIar1xrD78hXdZ37dYtwYiPwkFTtDJ/tYMDj4PiPg9UVEbURLDURZZefckl986
         ByLqU2cRYJRtgQIWp3iLGwgduAMgPjAxibUfpK6zflnQ0EUcrfMxjD1DqijbzumgHPre
         gaZnFQSnjd9ECym6UFekZ8btQjtLUD2JVpFJ8JPO6d9wo8+8xNcnIlcLkEKCQMmDeEp7
         YeAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=IysRiwaFy1Qh88j7E6BP3RGu1O0BjT217HZZSogBhd4=;
        b=hQz38KPcbfiGnR//OHfWwuRLjzdwNcMqJ4Rtv0YrSXjRDC9fr5j3Yqc4ufsWcnFn/i
         VYEz9jNHkPToiH7QW+cxgokH6lG8Gq47ClEBTUNZAsBBgiTxharOaxjfRPbCIiyyrgBa
         WAK1jHLFBKGDJwGf7lCuizZS+TiFDPki75Cd36aQtJRpLXWXs8az6uCZbeslbjGiZjns
         PBaZHaiaBjsEgVUBfr7phgloSJGGZI9tEkf3Tgixi5aXwHVFvhes9a6/OkibZ0boPlaQ
         07x+BV+74Ce3rnlKX0THIDzRBAX85Hi5CfYKLl9MjRY2OSh5HsFohPi+XBmY8d4asVvN
         HlTQ==
X-Gm-Message-State: AKwxyteVWPkgCG7kGROk/Tp0fHJVcQ8BXP0G1fM3XmOPkuzMSfHpfyT7
        oZo07yMZaLJTkcUjr7AG6xkMfwWf/lk=
X-Google-Smtp-Source: ACJfBou7QRSrsgGwCnErz+zyb+TZMWM04+F6K6aR2LKe8JbnEsMAFJ/BfVmLGV+idFUxLhonkGjx1A==
X-Received: by 10.98.147.154 with SMTP id r26mr16230100pfk.207.1516321692337;
        Thu, 18 Jan 2018 16:28:12 -0800 (PST)
Received: from twelve3.svl.corp.google.com ([2620:0:100e:422:ffac:c1d4:4bf7:bb93])
        by smtp.gmail.com with ESMTPSA id t1sm13571469pgs.73.2018.01.18.16.28.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Jan 2018 16:28:11 -0800 (PST)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, sunshine@sunshineco.com
Subject: [PATCH v2 1/2] http: support cookie redaction when tracing
Date:   Thu, 18 Jan 2018 16:28:01 -0800
Message-Id: <701e28d97f8450ef75a7e78b6c7ecfc7a825031a.1516321355.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.16.0.rc2.37.ge0d575025.dirty
In-Reply-To: <cover.1516321355.git.jonathantanmy@google.com>
References: <cover.1516321355.git.jonathantanmy@google.com>
In-Reply-To: <cover.1516321355.git.jonathantanmy@google.com>
References: <cover.1516235197.git.jonathantanmy@google.com> <cover.1516321355.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When using GIT_TRACE_CURL, Git already redacts the "Authorization:" and
"Proxy-Authorization:" HTTP headers. Extend this redaction to a
user-specified list of cookies, specified through the
"GIT_REDACT_COOKIES" environment variable.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 Documentation/git.txt       |  6 +++++
 http.c                      | 55 +++++++++++++++++++++++++++++++++++++++++++++
 t/t5551-http-fetch-smart.sh | 21 +++++++++++++++++
 3 files changed, 82 insertions(+)

diff --git a/Documentation/git.txt b/Documentation/git.txt
index 3f4161a79..5446d2143 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -646,6 +646,12 @@ of clones and fetches.
 	variable.
 	See `GIT_TRACE` for available trace output options.
 
+`GIT_REDACT_COOKIES`::
+	This can be set to a comma-separated list of strings. When a curl trace
+	is enabled (see `GIT_TRACE_CURL` above), whenever a "Cookies:" header
+	sent by the client is dumped, values of cookies whose key is in that
+	list (case-sensitive) are redacted.
+
 `GIT_LITERAL_PATHSPECS`::
 	Setting this variable to `1` will cause Git to treat all
 	pathspecs literally, rather than as glob patterns. For example,
diff --git a/http.c b/http.c
index 597771271..088cf70bf 100644
--- a/http.c
+++ b/http.c
@@ -13,8 +13,10 @@
 #include "transport.h"
 #include "packfile.h"
 #include "protocol.h"
+#include "string-list.h"
 
 static struct trace_key trace_curl = TRACE_KEY_INIT(CURL);
+static struct string_list cookies_to_redact = STRING_LIST_INIT_DUP;
 #if LIBCURL_VERSION_NUM >= 0x070a08
 long int git_curl_ipresolve = CURL_IPRESOLVE_WHATEVER;
 #else
@@ -575,6 +577,54 @@ static void redact_sensitive_header(struct strbuf *header)
 		/* Everything else is opaque and possibly sensitive */
 		strbuf_setlen(header,  sensitive_header - header->buf);
 		strbuf_addstr(header, " <redacted>");
+	} else if (cookies_to_redact.nr &&
+		   skip_prefix(header->buf, "Cookie:", &sensitive_header)) {
+		struct strbuf redacted_header = STRBUF_INIT;
+		char *cookie;
+
+		while (isspace(*sensitive_header))
+			sensitive_header++;
+
+		/*
+		 * The contents of header starting from sensitive_header will
+		 * subsequently be overridden, so it is fine to mutate this
+		 * string (hence the assignment to "char *").
+		 */
+		cookie = (char *) sensitive_header;
+
+		while (cookie) {
+			char *equals;
+			char *semicolon = strstr(cookie, "; ");
+			if (semicolon)
+				*semicolon = 0;
+			equals = strchrnul(cookie, '=');
+			if (!equals) {
+				/* invalid cookie, just append and continue */
+				strbuf_addstr(&redacted_header, cookie);
+				continue;
+			}
+			*equals = 0; /* temporarily set to NUL for lookup */
+			if (string_list_lookup(&cookies_to_redact, cookie)) {
+				strbuf_addstr(&redacted_header, cookie);
+				strbuf_addstr(&redacted_header, "=<redacted>");
+			} else {
+				*equals = '=';
+				strbuf_addstr(&redacted_header, cookie);
+			}
+			if (semicolon) {
+				/*
+				 * There are more cookies. (Or, for some
+				 * reason, the input string ends in "; ".)
+				 */
+				strbuf_addstr(&redacted_header, "; ");
+				cookie = semicolon + strlen("; ");
+			} else {
+				cookie = NULL;
+			}
+		}
+
+		strbuf_setlen(header, sensitive_header - header->buf);
+		strbuf_addbuf(header, &redacted_header);
 	}
 }
 
@@ -807,6 +857,11 @@ static CURL *get_curl_handle(void)
 	if (getenv("GIT_CURL_VERBOSE"))
 		curl_easy_setopt(result, CURLOPT_VERBOSE, 1L);
 	setup_curl_trace(result);
+	if (getenv("GIT_REDACT_COOKIES")) {
+		string_list_split(&cookies_to_redact,
+				  getenv("GIT_REDACT_COOKIES"), ',', -1);
+		string_list_sort(&cookies_to_redact);
+	}
 
 	curl_easy_setopt(result, CURLOPT_USERAGENT,
 		user_agent ? user_agent : git_user_agent());
diff --git a/t/t5551-http-fetch-smart.sh b/t/t5551-http-fetch-smart.sh
index a51b7e20d..21a5ce860 100755
--- a/t/t5551-http-fetch-smart.sh
+++ b/t/t5551-http-fetch-smart.sh
@@ -364,5 +364,26 @@ test_expect_success 'custom http headers' '
 		submodule update sub
 '
 
+test_expect_success 'GIT_REDACT_COOKIES redacts cookies' '
+	rm -rf clone &&
+	echo "Set-Cookie: Foo=1" >cookies &&
+	echo "Set-Cookie: Bar=2" >>cookies &&
+	GIT_TRACE_CURL=true GIT_REDACT_COOKIES=Bar,Baz \
+		git -c "http.cookieFile=$(pwd)/cookies" clone \
+		$HTTPD_URL/smart/repo.git clone 2>err &&
+	grep "Cookie:.*Foo=1" err &&
+	grep "Cookie:.*Bar=<redacted>" err &&
+	! grep "Cookie:.*Bar=2" err
+'
+
+test_expect_success 'GIT_REDACT_COOKIES handles empty values' '
+	rm -rf clone &&
+	echo "Set-Cookie: Foo=" >cookies &&
+	GIT_TRACE_CURL=true GIT_REDACT_COOKIES=Foo \
+		git -c "http.cookieFile=$(pwd)/cookies" clone \
+		$HTTPD_URL/smart/repo.git clone 2>err &&
+	grep "Cookie:.*Foo=<redacted>" err
+'
+
 stop_httpd
 test_done
-- 
2.16.0.rc2.37.ge0d575025.dirty

