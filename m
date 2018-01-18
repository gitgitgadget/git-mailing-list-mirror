Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 518301F406
	for <e@80x24.org>; Thu, 18 Jan 2018 00:34:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754236AbeARAep (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Jan 2018 19:34:45 -0500
Received: from mail-pf0-f196.google.com ([209.85.192.196]:32803 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753433AbeARAel (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Jan 2018 19:34:41 -0500
Received: by mail-pf0-f196.google.com with SMTP id t5so6711152pfi.0
        for <git@vger.kernel.org>; Wed, 17 Jan 2018 16:34:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=JT5ChaXGufoD6Kvsfe2CXkaESgyA05qfb9tkpSYsLqM=;
        b=Qa+eYy3CftuKmfwK2uIBxgmeTB67LuKQFm1kHCAs3ywr/FOKX4yr8rd39xQdwLA6w7
         nU8D1VYYSTijSYuOFLak786E/sqvJlkFNtoXFKdj4jeMzriisw/utHhll+KlO1GbDFeQ
         8f7zx+Erq5qu3caOUS099RymfbYlihzsaaaVv8HdlH6mgmCIXwLJKckenbTWkClcAaFp
         SNLwXVZ7lwYIK1AExEKfwRNRnBhaJU4OP6nNx0eR9AAYuh41gGx0z84qnOvA+E4Z/sM5
         PWo3FKMX7A3Lefq2PrZgFkr0FL5jAl8qaoQFcdf0QX/AC2CwxdllUqwOnylPxX80+Sx+
         F2Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=JT5ChaXGufoD6Kvsfe2CXkaESgyA05qfb9tkpSYsLqM=;
        b=cw4fZmvtpbSYHBiVHEClxZAlNSj7P+DFqhDlBDpr22m7XhP95DYXWZYTl/cnAGorOD
         +fJHzzDscA5GcLIfGOooJZo1fmaujo5kgJG2ZjrtrQKD2eFCXLU2nMElZDUUmoBypM7d
         mr4yPM2oQ2w9DXrksDELURzdZW0QTcFjRpCxq2M6Tv/p9cgInaoqh841uFrLJEphj+Vw
         tN0Y4rLbU4EVkNFOGXjLRDfbmMg5TUMS8E/hHGCYk5KyBOXjHAe7kbdDxgZjAUyWlkpd
         gLp7YURWw7aWkSpljFo0MXmoKnc4NY+pAbGv/YeNPDEX049PkSccQIHTl/1IXvp8zOXN
         7wpQ==
X-Gm-Message-State: AKwxytcv81RphXm6rXlPaPa/R/1pa6ca91Jd+uvWrRg+PQ+tImHJ5rDH
        zvmPLlenaYXHpXbALC34Y9uKWSxNEyM=
X-Google-Smtp-Source: ACJfBovl+OGOdvUl/DLIZ8dGEUVe+Bvo0FwmGu4pBWi7S0bUNLklNlxVrdqRYH+Ie59Ieq+IyhiAcA==
X-Received: by 10.159.211.67 with SMTP id g3mr783303plp.319.1516235680735;
        Wed, 17 Jan 2018 16:34:40 -0800 (PST)
Received: from twelve3.mtv.corp.google.com ([100.96.218.44])
        by smtp.gmail.com with ESMTPSA id d5sm11233484pfk.2.2018.01.17.16.34.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 17 Jan 2018 16:34:40 -0800 (PST)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Subject: [RFC PATCH 1/2] http: support cookie redaction when tracing
Date:   Wed, 17 Jan 2018 16:34:30 -0800
Message-Id: <b0d7c8cbdd1c6e32f05f95ebde4612eb8bd16fdf.1516235197.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.16.0.rc2.38.g114ad43e1.dirty
In-Reply-To: <cover.1516235197.git.jonathantanmy@google.com>
References: <cover.1516235197.git.jonathantanmy@google.com>
In-Reply-To: <cover.1516235197.git.jonathantanmy@google.com>
References: <cover.1516235197.git.jonathantanmy@google.com>
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
 http.c                      | 55 +++++++++++++++++++++++++++++++++++++++++++++
 t/t5551-http-fetch-smart.sh | 12 ++++++++++
 2 files changed, 67 insertions(+)

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
index a51b7e20d..88bd9c094 100755
--- a/t/t5551-http-fetch-smart.sh
+++ b/t/t5551-http-fetch-smart.sh
@@ -364,5 +364,17 @@ test_expect_success 'custom http headers' '
 		submodule update sub
 '
 
+test_expect_success 'GIT_REDACT_COOKIES redacts cookies' '
+	rm -rf clone &&
+	echo "Set-Cookie: NotSecret=Foo" >cookies &&
+	echo "Set-Cookie: Secret=Bar" >>cookies &&
+	GIT_TRACE_CURL=true GIT_REDACT_COOKIES=Secret,AnotherSecret \
+		git -c "http.cookieFile=$(pwd)/cookies" clone \
+		$HTTPD_URL/smart/repo.git clone 2>err &&
+	grep "Cookie:.*NotSecret=Foo" err &&
+	grep "Cookie:.*Secret=<redacted>" err &&
+	! grep "Cookie:.*Secret=Bar" err
+'
+
 stop_httpd
 test_done
-- 
2.16.0.rc1.238.g530d649a79-goog

