Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4A3DA20A40
	for <e@80x24.org>; Sun, 26 Nov 2017 20:11:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751797AbdKZULh (ORCPT <rfc822;e@80x24.org>);
        Sun, 26 Nov 2017 15:11:37 -0500
Received: from mail-wr0-f195.google.com ([209.85.128.195]:35505 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751771AbdKZULg (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Nov 2017 15:11:36 -0500
Received: by mail-wr0-f195.google.com with SMTP id w95so24568782wrc.2
        for <git@vger.kernel.org>; Sun, 26 Nov 2017 12:11:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YGDY9Idjt05Clrb0L7L6xgrHW2d62g7WhEUXCkLCMEo=;
        b=r5c5pHvdRCZHEF+DsxpZoZHu9lE4RPLFNO9ysN7NLIgLe7sMJ3xiDJu1xwNY3LNpEs
         n2ncqyPrE5XSBrE2P6bcNEOqVgBgGLx1imRKiWCfM+bWmuzTksRHSfRpb8GPS8uGaWr6
         fdlFmLM6BrDbNkn59bzqTXlc8Vz72/g/DPo0mDCZ2m51YEVg03HP+wGXqkGjPqwHf0Ul
         ZhURG7IQ+rURS1f74ew4bVszHNahY2iSOqxDnqEvSHM+4lBmCZLN/AG2sp+pIsvZpmbe
         VCU6uZBXvDuzF9TuxCNdSDtHGYW66GGBswL/xVj+qx9SX2WmuOjNbUKLSlrSsE5zxZ4V
         qlWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=YGDY9Idjt05Clrb0L7L6xgrHW2d62g7WhEUXCkLCMEo=;
        b=SDDSBO6LwFCgk8gmSHxl3E3WY7Vnn95nxjX2Eji1TUfIl27/qpGPzV2mK1AFnPxrba
         E0Ym4fh4ov7i1/QfEYYUTONDn8O55HTxki5FQiot+RHGO282NT2RRw2lzW0EBT7uu/ld
         Q4GtJPFuudUT1L4jo1IkTX20lNTRyyyy9VxqiUAQvgGI97AT0UfxwsEtKHORnIyaQVM5
         8GJCO+M0uAAytxRFPaGnXv9DFKjzOvjV/v0WsCuyWhbSOwUe/R5Ctk7dSCT9o22QdHvM
         0vYNcmfMR4nWX8HH+SBw3esI+km62WeTXKltHwgj37Z0038VJWDoUiAzE1V2gN9SnNwf
         GG5A==
X-Gm-Message-State: AJaThX5Q8Qfbe1scTWCCrCmjQJZ2G7KqEqWGCFnLb0g9KG1CfhLC1JZq
        PcmdpzbUXS7uzF/3UGNCKD4COw==
X-Google-Smtp-Source: AGs4zMag0zVrgC8upDzSrEBlXlGV8kSooDZTktSxjV3Gd+q9rtXqnrdP8XbQQ8FELVBAPu+Pd8x+tA==
X-Received: by 10.223.196.189 with SMTP id m58mr32734748wrf.7.1511727094607;
        Sun, 26 Nov 2017 12:11:34 -0800 (PST)
Received: from p50-debian.bsdmn (cpc93788-hari17-2-0-cust762.20-2.cable.virginm.net. [82.39.98.251])
        by smtp.gmail.com with ESMTPSA id v195sm7495558wmf.25.2017.11.26.12.11.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 26 Nov 2017 12:11:34 -0800 (PST)
From:   gennady.kupava@gmail.com
To:     git@vger.kernel.org
Cc:     Gennady Kupava <gkupava@bloomberg.net>
Subject: [PATCH 2/2] trace: improve performance while category is disabled
Date:   Sun, 26 Nov 2017 20:11:19 +0000
Message-Id: <20171126201119.24313-2-gennady.kupava@gmail.com>
X-Mailer: git-send-email 2.15.0.319.gd8415edcf
In-Reply-To: <20171126201119.24313-1-gennady.kupava@gmail.com>
References: <xmqqvai5lf4a.fsf@gitster.mtv.corp.google.com>
 <20171126201119.24313-1-gennady.kupava@gmail.com>
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
index 24b32f8f4..db10f2afe 100644
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
+#define trace_printf(...) trace_printf_key(&trace_default_key, __VA_ARGS__)
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
+		if (trace_pass_fl(&trace_perf_key))			    \
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

