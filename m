Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B3A9D2036D
	for <e@80x24.org>; Sun, 19 Nov 2017 00:43:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1764974AbdKSAnc (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 Nov 2017 19:43:32 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36074 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1764971AbdKSAna (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Nov 2017 19:43:30 -0500
Received: by mail-wm0-f66.google.com with SMTP id r68so12612158wmr.1
        for <git@vger.kernel.org>; Sat, 18 Nov 2017 16:43:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Of+Sl3pj52BiGhsWtqQCg/3onS4pTM8M6RZUALi+j5M=;
        b=k7W+knjdnUHfdaiKMT8blwYnCMPZC+vo5Hby/ZA9p8QGuX4H/tPSvWOUjgE112wXSA
         lJU3gDZywt0oS8XUKVI8VkzpZJA4ICxUAfrcWWUDHvESF0BIpp2RR2ft25pHZi/LqkGQ
         N5qmH30GJHBN5BRAqaLWQPNec46An6lSE4RdGaYeOInXMBrWV3HHnw9+IPD5HfG25/Ah
         YkUXZjq2i1gggbAW05TSrfj5TfmWVMDQKW/cnZOlPNBE5RsE2Dz2OPzcRmlLJW/68YL6
         LgSJUvL4vONryBHGc1SkxKlHa+ogvxSp9Hu6IFLj8bCAGqHsi/jrbSW83zLFmYtJ/w1i
         xuWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Of+Sl3pj52BiGhsWtqQCg/3onS4pTM8M6RZUALi+j5M=;
        b=pry5Shkcfdcl5B+B686jiHbZzNU5kX7EeVmzaiFOHrMpHfs/Rqo5yrqfkjgRerIqtY
         CLR6Nr5b7e5z7/TE0AKr0xGKFYE1nE8LPmQyAIpPE+u0FmtDJ+zXP3ILzoaf3XRqjDEU
         5r0HPtrWMG2X7n0ZQ/B08CUSkFDg5SRRbTyue0+6LTh2FzRKkQ2QcJHu+dgHPuKVLwqa
         W0jynnyaDPNTvhiTrWFVu49/tnwBzOd8uLKqFH513uL9mP4b1jDuisETWG4nL66W1vDi
         Eo3xtWekBAFWVEvZsUwb8l7kVf7vRvBnbHAOTtJLCL4O7rE/5I6MrY73CivVOIeJQdzE
         MdYA==
X-Gm-Message-State: AJaThX6SsQdQGC4Pz2EjKKOpAc7UeLr1TG3AnsJWkIlO+HwtvoI5YwPR
        YU9RYeFJMzZ63Nf8J5g+3sHCqw==
X-Google-Smtp-Source: AGs4zMagT03yuc0o8jP3oO65LBgXaHhVnt2bTklIDmJiG+OgjJ+Awb8mxcbA93HyJ+YZesVTVan47Q==
X-Received: by 10.28.35.214 with SMTP id j205mr6997389wmj.72.1511052209430;
        Sat, 18 Nov 2017 16:43:29 -0800 (PST)
Received: from p50-debian.bsdmn (cpc93788-hari17-2-0-cust762.20-2.cable.virginm.net. [82.39.98.251])
        by smtp.gmail.com with ESMTPSA id f10sm6982988wrg.20.2017.11.18.16.43.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 18 Nov 2017 16:43:28 -0800 (PST)
From:   gennady.kupava@gmail.com
To:     git <git@vger.kernel.org>
Cc:     Gennady Kupava <gkupava@bloomberg.net>
Subject: [PATCH 2/2] Reduce performance cost of the trace if trace category is disabled
Date:   Sun, 19 Nov 2017 00:42:47 +0000
Message-Id: <20171119004247.22792-2-gennady.kupava@gmail.com>
X-Mailer: git-send-email 2.15.0.278.gca7b6c74c.dirty
In-Reply-To: <20171119004247.22792-1-gennady.kupava@gmail.com>
References: <20171117221631.x2xqeeqmf5xob3yv@sigill.intra.peff.net>
 <20171119004247.22792-1-gennady.kupava@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Gennady Kupava <gkupava@bloomberg.net>

- Do the check if the trace key is enabled sooner in call chain.
- Move just enough code from trace.c into trace.h header so all code
  necessary to determine that trace is disabled could be inlined to
  calling functions.

Signed-off-by: Gennady Kupava <gkupava@bloomberg.net>
---
 trace.c |  3 +--
 trace.h | 58 ++++++++++++++++++++++++++++++++++++++++------------------
 2 files changed, 41 insertions(+), 20 deletions(-)

diff --git a/trace.c b/trace.c
index d47ea28e8..b7530b51a 100644
--- a/trace.c
+++ b/trace.c
@@ -25,6 +25,7 @@
 #include "quote.h"
 
 struct trace_key trace_default_key = { "GIT_TRACE", 0, 0, 0 };
+struct trace_key trace_perf_key = TRACE_KEY_INIT(PERFORMANCE);
 
 /* Get a trace file descriptor from "key" env variable. */
 static int get_trace_fd(struct trace_key *key)
@@ -172,8 +173,6 @@ void trace_strbuf_fl(const char *file, int line, struct trace_key *key,
 	print_trace_line(key, &buf);
 }
 
-static struct trace_key trace_perf_key = TRACE_KEY_INIT(PERFORMANCE);
-
 static void trace_performance_vprintf_fl(const char *file, int line,
 					 uint64_t nanos, const char *format,
 					 va_list ap)
diff --git a/trace.h b/trace.h
index 24b32f8f4..cd9e280ba 100644
--- a/trace.h
+++ b/trace.h
@@ -14,6 +14,7 @@ struct trace_key {
 extern struct trace_key trace_default_key;
 
 #define TRACE_KEY_INIT(name) { "GIT_TRACE_" #name, 0, 0, 0 }
+extern struct trace_key trace_perf_key;
 
 extern void trace_repo_setup(const char *prefix);
 extern int trace_want(struct trace_key *key);
@@ -79,24 +80,42 @@ extern void trace_performance_since(uint64_t start, const char *format, ...);
  * comma, but this is non-standard.
  */
 
-#define trace_printf(...) \
-	trace_printf_key_fl(TRACE_CONTEXT, __LINE__, &trace_default_key, __VA_ARGS__)
-
-#define trace_printf_key(key, ...) \
-	trace_printf_key_fl(TRACE_CONTEXT, __LINE__, key, __VA_ARGS__)
-
-#define trace_argv_printf(argv, ...) \
-	trace_argv_printf_fl(TRACE_CONTEXT, __LINE__, argv, __VA_ARGS__)
-
-#define trace_strbuf(key, data) \
-	trace_strbuf_fl(TRACE_CONTEXT, __LINE__, key, data)
-
-#define trace_performance(nanos, ...) \
-	trace_performance_fl(TRACE_CONTEXT, __LINE__, nanos, __VA_ARGS__)
-
-#define trace_performance_since(start, ...) \
-	trace_performance_fl(TRACE_CONTEXT, __LINE__, getnanotime() - (start), \
-			     __VA_ARGS__)
+#define trace_printf_key(key, ...)					    \
+	do {								    \
+		if (trace_pass_fl(key))					    \
+			trace_printf_key_fl(TRACE_CONTEXT, __LINE__, key,   \
+					    __VA_ARGS__);		    \
+	} while(0)
+
+#define trace_printf(...) trace_printf_key(&trace_default_key, __VA_ARGS__);
+
+#define trace_argv_printf(argv, ...)					    \
+	do {								    \
+		if (trace_pass_fl(&trace_default_key))			    \
+		       trace_argv_printf_fl(TRACE_CONTEXT, __LINE__,	    \
+					    argv, __VA_ARGS__);		    \
+	} while(0)
+
+#define trace_strbuf(key, data)						    \
+	do {								    \
+		if (trace_pass_fl(key))					    \
+			trace_strbuf_fl(TRACE_CONTEXT, __LINE__, key, data);\
+	} while(0)
+
+#define trace_performance(nanos, ...)					    \
+	do {								    \
+		if (trace_pass_fl(key))					    \
+			trace_performance_fl(TRACE_CONTEXT, __LINE__, nanos,\
+					     __VA_ARGS__);  		    \
+	} while(0)
+
+#define trace_performance_since(start, ...)				    \
+	do {								    \
+		if (trace_pass_fl(&trace_perf_key))			    \
+			trace_performance_fl(TRACE_CONTEXT, __LINE__,       \
+					     getnanotime() - (start),	    \
+					     __VA_ARGS__);		    \
+	} while(0)
 
 /* backend functions, use non-*fl macros instead */
 __attribute__((format (printf, 4, 5)))
@@ -110,6 +129,9 @@ extern void trace_strbuf_fl(const char *file, int line, struct trace_key *key,
 __attribute__((format (printf, 4, 5)))
 extern void trace_performance_fl(const char *file, int line,
 				 uint64_t nanos, const char *fmt, ...);
+inline int trace_pass_fl(struct trace_key *key) {
+	return key->fd || !key->initialized;
+}
 
 #endif /* HAVE_VARIADIC_MACROS */
 
-- 
2.14.1

