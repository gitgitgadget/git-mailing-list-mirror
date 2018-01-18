Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD,UNWANTED_LANGUAGE_BODY shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BAC521F406
	for <e@80x24.org>; Thu, 18 Jan 2018 00:34:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754041AbeARAen (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Jan 2018 19:34:43 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:41663 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753023AbeARAem (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Jan 2018 19:34:42 -0500
Received: by mail-pg0-f66.google.com with SMTP id 136so11939617pgd.8
        for <git@vger.kernel.org>; Wed, 17 Jan 2018 16:34:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=qfLJoS+velhQcBx/g6yf36mFCGUfDMOslHIk1c6opyU=;
        b=e0V9tHFeH4G3msrThGjJ9hPicfONtDvWxxYGPe1KidjDxYKuRqLlZqphK4KgAoul55
         rOIA2iJ+PhPCg7SrGdKQlTLOhJXbPBBYvAHW6zuckPPkhqJKtbBRE/lGPVb3wdd9axK2
         5+Z/8vV+VNbJ88hDFsLRQfwxTUgbZ3YXRda5zC9kN+RXZykfLvTffmMogOqZuyX7rA4H
         REeTRfA2Xo5eARNZFU2uqL7AGlDitMM/LoH8guc78rs+33daMIDAxwF6jfi6Qpl+SBjt
         EPavTq/5RzBSZQK9+XE00DhdW7KJaS6U3XpGspwTOtIHfX12HfJvoe1/zxMiw7qWcgu+
         JnZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=qfLJoS+velhQcBx/g6yf36mFCGUfDMOslHIk1c6opyU=;
        b=M39dF3DGY2tH9WxosmX6OocPCJqrxa34IV220AmkXkMw1oidFtZJukcP0lbVce22p0
         yRg51R36vP0hZ6/+GcD9n+e+mZU9ZbLUTVlxKBQl0Q3mPQZ7dx0tGiJnhuDnfvTS66is
         jmo/kLjmPLrrOk6tbgf4YAijz2GSzzwsjX3xdPkoOjs1Fq0fZdMIBXC2uQuy07iDcrSZ
         rJgUrMxcSoVyIYUHcmnxZNF0SBb2SktRR9l3qMg2VQAatrbfcULVBMif6t5YKjpe98O7
         C9RReTVTs59iKznEo30XQ7TYLxvn462QyN5SMBdpaqJ95/c2agiBTg7bB8mA26Uw76Pp
         N9jA==
X-Gm-Message-State: AKwxytdhRo8mJ4js5+hRPr2vmgBdDBubzazTpr1yALyrC05OAKdZ6xs9
        K5qKnpnryBip236Y6yRrDML55JoZvYA=
X-Google-Smtp-Source: ACJfBou+CDZk8cjFenmBFttvKnZoJsWyRuoLMoBpdiWg1xRSrKDuUqALlpyyPC3rWJ8CO/KHKgE7vA==
X-Received: by 10.84.237.9 with SMTP id s9mr27719077plk.176.1516235681487;
        Wed, 17 Jan 2018 16:34:41 -0800 (PST)
Received: from twelve3.mtv.corp.google.com ([100.96.218.44])
        by smtp.gmail.com with ESMTPSA id d5sm11233484pfk.2.2018.01.17.16.34.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 17 Jan 2018 16:34:41 -0800 (PST)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Subject: [RFC PATCH 2/2] http: support omitting data from traces
Date:   Wed, 17 Jan 2018 16:34:31 -0800
Message-Id: <970dbd7a52de6ab084df8e9ce083bb76ec1889c0.1516235197.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.16.0.rc2.38.g114ad43e1.dirty
In-Reply-To: <cover.1516235197.git.jonathantanmy@google.com>
References: <cover.1516235197.git.jonathantanmy@google.com>
In-Reply-To: <cover.1516235197.git.jonathantanmy@google.com>
References: <cover.1516235197.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

GIT_TRACE_CURL provides a way to debug what is being sent and received
over HTTP, with automatic redaction of sensitive information. But it
also logs data transmissions, which significantly increases the log file
size, sometimes unnecessarily. Add an option "GIT_TRACE_CURL_NO_DATA" to
allow the user to omit such data transmissions.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 http.c                      | 27 +++++++++++++++++++--------
 t/t5551-http-fetch-smart.sh | 12 ++++++++++++
 2 files changed, 31 insertions(+), 8 deletions(-)

diff --git a/http.c b/http.c
index 088cf70bf..32a823895 100644
--- a/http.c
+++ b/http.c
@@ -16,6 +16,7 @@
 #include "string-list.h"
 
 static struct trace_key trace_curl = TRACE_KEY_INIT(CURL);
+static int trace_curl_data = 1;
 static struct string_list cookies_to_redact = STRING_LIST_INIT_DUP;
 #if LIBCURL_VERSION_NUM >= 0x070a08
 long int git_curl_ipresolve = CURL_IPRESOLVE_WHATEVER;
@@ -695,24 +696,32 @@ static int curl_trace(CURL *handle, curl_infotype type, char *data, size_t size,
 		curl_dump_header(text, (unsigned char *)data, size, DO_FILTER);
 		break;
 	case CURLINFO_DATA_OUT:
-		text = "=> Send data";
-		curl_dump_data(text, (unsigned char *)data, size);
+		if (trace_curl_data) {
+			text = "=> Send data";
+			curl_dump_data(text, (unsigned char *)data, size);
+		}
 		break;
 	case CURLINFO_SSL_DATA_OUT:
-		text = "=> Send SSL data";
-		curl_dump_data(text, (unsigned char *)data, size);
+		if (trace_curl_data) {
+			text = "=> Send SSL data";
+			curl_dump_data(text, (unsigned char *)data, size);
+		}
 		break;
 	case CURLINFO_HEADER_IN:
 		text = "<= Recv header";
 		curl_dump_header(text, (unsigned char *)data, size, NO_FILTER);
 		break;
 	case CURLINFO_DATA_IN:
-		text = "<= Recv data";
-		curl_dump_data(text, (unsigned char *)data, size);
+		if (trace_curl_data) {
+			text = "<= Recv data";
+			curl_dump_data(text, (unsigned char *)data, size);
+		}
 		break;
 	case CURLINFO_SSL_DATA_IN:
-		text = "<= Recv SSL data";
-		curl_dump_data(text, (unsigned char *)data, size);
+		if (trace_curl_data) {
+			text = "<= Recv SSL data";
+			curl_dump_data(text, (unsigned char *)data, size);
+		}
 		break;
 
 	default:		/* we ignore unknown types by default */
@@ -857,6 +866,8 @@ static CURL *get_curl_handle(void)
 	if (getenv("GIT_CURL_VERBOSE"))
 		curl_easy_setopt(result, CURLOPT_VERBOSE, 1L);
 	setup_curl_trace(result);
+	if (getenv("GIT_TRACE_CURL_NO_DATA"))
+		trace_curl_data = 0;
 	if (getenv("GIT_REDACT_COOKIES")) {
 		string_list_split(&cookies_to_redact,
 				  getenv("GIT_REDACT_COOKIES"), ',', -1);
diff --git a/t/t5551-http-fetch-smart.sh b/t/t5551-http-fetch-smart.sh
index 88bd9c094..0c62d00af 100755
--- a/t/t5551-http-fetch-smart.sh
+++ b/t/t5551-http-fetch-smart.sh
@@ -376,5 +376,17 @@ test_expect_success 'GIT_REDACT_COOKIES redacts cookies' '
 	! grep "Cookie:.*Secret=Bar" err
 '
 
+test_expect_success 'GIT_TRACE_CURL_NO_DATA prevents data from being traced' '
+	rm -rf clone &&
+	GIT_TRACE_CURL=true \
+		git clone $HTTPD_URL/smart/repo.git clone 2>err &&
+	grep "=> Send data" err &&
+
+	rm -rf clone &&
+	GIT_TRACE_CURL=true GIT_TRACE_CURL_NO_DATA=1 \
+		git clone $HTTPD_URL/smart/repo.git clone 2>err &&
+	! grep "=> Send data" err
+'
+
 stop_httpd
 test_done
-- 
2.16.0.rc1.238.g530d649a79-goog

