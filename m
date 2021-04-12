Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC374C433ED
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 11:02:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81EB261074
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 11:02:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239932AbhDLLCs (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Apr 2021 07:02:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239859AbhDLLCm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Apr 2021 07:02:42 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86E96C061574
        for <git@vger.kernel.org>; Mon, 12 Apr 2021 04:02:24 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id f8so14526423edd.11
        for <git@vger.kernel.org>; Mon, 12 Apr 2021 04:02:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SBebF+ajuOUDGqPoYD2ZbUw6q6hFnU7yjWungYMulrU=;
        b=gwHT+i+4J5dwY8wEdDMXIZZw8DgTn4x+5/fUtYm8nr76Q3aDU7J+JC+7hP8zMVtv0l
         IdyrIuYm+eHV3epuB3uMiqMjZJn6qMKNcWjbIPzFCPEAlnqAkLaN/5BGVuqfgF90unBP
         B48jTLTYb5bBmA+FAPwyq0nnrsBEpMvHy5p4YVcM0Yp0LjnGA9gUyFteOOH902+OG89a
         /Iub23pdin+0pz85s9HbqCPC8zFJpb0Zfaz4VxN544NH9pipr3DCFIHigRFqD5j+xhXF
         lbFhwtP0WHq2ddAyzRWx16SU475fsXACpbyAR/nzBeG6pDxZ8SL0N0HSUjiNBF2pYrVe
         TYOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SBebF+ajuOUDGqPoYD2ZbUw6q6hFnU7yjWungYMulrU=;
        b=DQ6w96leLhNk6A0Vm+wTwFQUPEAFaxJds0uLUAHpjyKie1tKOmUfxYhLFNNfMFWpSW
         orZecgu7b3E4iJvQ9utoOf7bUbD7VquTTeuUfTuukF3w7Fc2atanPjO25T/A5w95X896
         p4/5ro6QAGlG4xqgp7a1atoldZflGR8rbUk2a+LnfjML6Wv8pwwpY2x4xKEY8ebfEER5
         QxxBwD9ffujMoaq6sJ3xM9bhVzQxsTr/Gm8kvHtWlj8aT0bd56+GViTbp2h7Q7Bn5bIZ
         3+sUyggwNYu05XEJml2cC+iJp25qkM+l7Phlfh36ejD5TeDJZEw3gZPUJTguplJwQJdr
         SOsQ==
X-Gm-Message-State: AOAM530ANgrOjjleShNvIj6RcZ80VLnVV7Jx8WxnnkGS7EgoFyq+pb/0
        4Gf6m5SFAZxvI8nNja51kHdl4Au/2Xz0YA==
X-Google-Smtp-Source: ABdhPJwQUys4ZlurBAj0v2qd5tHkGVeofs7svWLc3k+mWcvh8pS42bRUJxAYY8HyOTUkgBAE/VwOFQ==
X-Received: by 2002:aa7:cd6a:: with SMTP id ca10mr26970451edb.16.1618225342862;
        Mon, 12 Apr 2021 04:02:22 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id f16sm2691765ejk.102.2021.04.12.04.02.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Apr 2021 04:02:22 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 2/2] C99 support: remove non-HAVE_VARIADIC_MACROS code
Date:   Mon, 12 Apr 2021 13:02:18 +0200
Message-Id: <patch-2.2-f12e3cad57d-20210412T105422Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.634.gb41287a30b0
In-Reply-To: <cover-0.2-00000000000-20210412T105422Z-avarab@gmail.com>
References: <YHOLo36MfuTj6YeD@camp.crustytoothpaste.net> <cover-0.2-00000000000-20210412T105422Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove code that depend on HAVE_VARIADIC_MACROS not being set. Since
765dc168882 (git-compat-util: always enable variadic macros,
2021-01-28) we've unconditionally defined it to be true, and that
change went out with v2.31.0. This should have given packagers enough
time to discover whether variadic macros were an issue.

It seems that they weren't, so let's update the coding guidelines and
remove all the fallback code for the non-HAVE_VARIADIC_MACROS case.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/CodingGuidelines |  3 ++
 banned.h                       |  5 ---
 git-compat-util.h              | 12 ------
 trace.c                        | 73 ----------------------------------
 trace.h                        | 62 -----------------------------
 trace2.c                       | 39 ------------------
 trace2.h                       | 25 ------------
 usage.c                        | 10 -----
 8 files changed, 3 insertions(+), 226 deletions(-)

diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
index 45465bc0c98..7eafb1758e6 100644
--- a/Documentation/CodingGuidelines
+++ b/Documentation/CodingGuidelines
@@ -205,6 +205,9 @@ For C programs:
    . since mid 2017 with 512f41cf, we have been using designated
      initializers for array (e.g. "int array[10] = { [5] = 2 }").
 
+   . since early 2021 with 765dc168882, we have been using variadic
+     macros, mostly for printf-like trace and debug macros.
+
    These used to be forbidden, but we have not heard any breakage
    report, and they are assumed to be safe.
 
diff --git a/banned.h b/banned.h
index 7ab4f2e4921..6ccf46bc197 100644
--- a/banned.h
+++ b/banned.h
@@ -21,13 +21,8 @@
 
 #undef sprintf
 #undef vsprintf
-#ifdef HAVE_VARIADIC_MACROS
 #define sprintf(...) BANNED(sprintf)
 #define vsprintf(...) BANNED(vsprintf)
-#else
-#define sprintf(buf,fmt,arg) BANNED(sprintf)
-#define vsprintf(buf,fmt,arg) BANNED(vsprintf)
-#endif
 
 #undef gmtime
 #define gmtime(t) BANNED(gmtime)
diff --git a/git-compat-util.h b/git-compat-util.h
index 540aba22a4d..da7ab91335f 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -1192,24 +1192,12 @@ static inline int regexec_buf(const regex_t *preg, const char *buf, size_t size,
 #endif
 #endif
 
-/*
- * This is always defined as a first step towards making the use of variadic
- * macros unconditional. If it causes compilation problems on your platform,
- * please report it to the Git mailing list at git@vger.kernel.org.
- */
-#define HAVE_VARIADIC_MACROS 1
-
 /* usage.c: only to be used for testing BUG() implementation (see test-tool) */
 extern int BUG_exit_code;
 
-#ifdef HAVE_VARIADIC_MACROS
 __attribute__((format (printf, 3, 4))) NORETURN
 void BUG_fl(const char *file, int line, const char *fmt, ...);
 #define BUG(...) BUG_fl(__FILE__, __LINE__, __VA_ARGS__)
-#else
-__attribute__((format (printf, 1, 2))) NORETURN
-void BUG(const char *fmt, ...);
-#endif
 
 /*
  * Preserves errno, prints a message, but gives no warning for ENOENT.
diff --git a/trace.c b/trace.c
index f726686fd92..43173301f59 100644
--- a/trace.c
+++ b/trace.c
@@ -111,13 +111,11 @@ static int prepare_trace_line(const char *file, int line,
 	strbuf_addf(buf, "%02d:%02d:%02d.%06ld ", tm.tm_hour, tm.tm_min,
 		    tm.tm_sec, (long) tv.tv_usec);
 
-#ifdef HAVE_VARIADIC_MACROS
 	/* print file:line */
 	strbuf_addf(buf, "%s:%d ", file, line);
 	/* align trace output (column 40 catches most files names in git) */
 	while (buf->len < 40)
 		strbuf_addch(buf, ' ');
-#endif
 
 	return 1;
 }
@@ -229,74 +227,6 @@ static void trace_performance_vprintf_fl(const char *file, int line,
 	strbuf_release(&buf);
 }
 
-#ifndef HAVE_VARIADIC_MACROS
-
-void trace_printf(const char *format, ...)
-{
-	va_list ap;
-	va_start(ap, format);
-	trace_vprintf_fl(NULL, 0, &trace_default_key, format, ap);
-	va_end(ap);
-}
-
-void trace_printf_key(struct trace_key *key, const char *format, ...)
-{
-	va_list ap;
-	va_start(ap, format);
-	trace_vprintf_fl(NULL, 0, key, format, ap);
-	va_end(ap);
-}
-
-void trace_argv_printf(const char **argv, const char *format, ...)
-{
-	va_list ap;
-	va_start(ap, format);
-	trace_argv_vprintf_fl(NULL, 0, argv, format, ap);
-	va_end(ap);
-}
-
-void trace_strbuf(struct trace_key *key, const struct strbuf *data)
-{
-	trace_strbuf_fl(NULL, 0, key, data);
-}
-
-void trace_performance(uint64_t nanos, const char *format, ...)
-{
-	va_list ap;
-	va_start(ap, format);
-	trace_performance_vprintf_fl(NULL, 0, nanos, format, ap);
-	va_end(ap);
-}
-
-void trace_performance_since(uint64_t start, const char *format, ...)
-{
-	va_list ap;
-	va_start(ap, format);
-	trace_performance_vprintf_fl(NULL, 0, getnanotime() - start,
-				     format, ap);
-	va_end(ap);
-}
-
-void trace_performance_leave(const char *format, ...)
-{
-	va_list ap;
-	uint64_t since;
-
-	if (perf_indent)
-		perf_indent--;
-
-	if (!format) /* Allow callers to leave without tracing anything */
-		return;
-
-	since = perf_start_times[perf_indent];
-	va_start(ap, format);
-	trace_performance_vprintf_fl(NULL, 0, getnanotime() - since,
-				     format, ap);
-	va_end(ap);
-}
-
-#else
-
 void trace_printf_key_fl(const char *file, int line, struct trace_key *key,
 			 const char *format, ...)
 {
@@ -342,9 +272,6 @@ void trace_performance_leave_fl(const char *file, int line,
 	va_end(ap);
 }
 
-#endif /* HAVE_VARIADIC_MACROS */
-
-
 static const char *quote_crnl(const char *path)
 {
 	static struct strbuf new_path = STRBUF_INIT;
diff --git a/trace.h b/trace.h
index 0dbbad0e41c..c6b3f6ce889 100644
--- a/trace.h
+++ b/trace.h
@@ -126,66 +126,6 @@ void trace_command_performance(const char **argv);
 void trace_verbatim(struct trace_key *key, const void *buf, unsigned len);
 uint64_t trace_performance_enter(void);
 
-#ifndef HAVE_VARIADIC_MACROS
-
-/**
- * Prints a formatted message, similar to printf.
- */
-__attribute__((format (printf, 1, 2)))
-void trace_printf(const char *format, ...);
-
-__attribute__((format (printf, 2, 3)))
-void trace_printf_key(struct trace_key *key, const char *format, ...);
-
-/**
- * Prints a formatted message, followed by a quoted list of arguments.
- */
-__attribute__((format (printf, 2, 3)))
-void trace_argv_printf(const char **argv, const char *format, ...);
-
-/**
- * Prints the strbuf, without additional formatting (i.e. doesn't
- * choke on `%` or even `\0`).
- */
-void trace_strbuf(struct trace_key *key, const struct strbuf *data);
-
-/**
- * Prints elapsed time (in nanoseconds) if GIT_TRACE_PERFORMANCE is enabled.
- *
- * Example:
- * ------------
- * uint64_t t = 0;
- * for (;;) {
- * 	// ignore
- * t -= getnanotime();
- * // code section to measure
- * t += getnanotime();
- * // ignore
- * }
- * trace_performance(t, "frotz");
- * ------------
- */
-__attribute__((format (printf, 2, 3)))
-void trace_performance(uint64_t nanos, const char *format, ...);
-
-/**
- * Prints elapsed time since 'start' if GIT_TRACE_PERFORMANCE is enabled.
- *
- * Example:
- * ------------
- * uint64_t start = getnanotime();
- * // code section to measure
- * trace_performance_since(start, "foobar");
- * ------------
- */
-__attribute__((format (printf, 2, 3)))
-void trace_performance_since(uint64_t start, const char *format, ...);
-
-__attribute__((format (printf, 1, 2)))
-void trace_performance_leave(const char *format, ...);
-
-#else
-
 /*
  * Macros to add file:line - see above for C-style declarations of how these
  * should be used.
@@ -285,6 +225,4 @@ static inline int trace_pass_fl(struct trace_key *key)
 	return key->fd || !key->initialized;
 }
 
-#endif /* HAVE_VARIADIC_MACROS */
-
 #endif /* TRACE_H */
diff --git a/trace2.c b/trace2.c
index 256120c7fd5..51d0e6cbd5e 100644
--- a/trace2.c
+++ b/trace2.c
@@ -597,20 +597,6 @@ void trace2_region_enter_printf_fl(const char *file, int line,
 	va_end(ap);
 }
 
-#ifndef HAVE_VARIADIC_MACROS
-void trace2_region_enter_printf(const char *category, const char *label,
-				const struct repository *repo, const char *fmt,
-				...)
-{
-	va_list ap;
-
-	va_start(ap, fmt);
-	trace2_region_enter_printf_va_fl(NULL, 0, category, label, repo, fmt,
-					 ap);
-	va_end(ap);
-}
-#endif
-
 void trace2_region_leave_printf_va_fl(const char *file, int line,
 				      const char *category, const char *label,
 				      const struct repository *repo,
@@ -673,20 +659,6 @@ void trace2_region_leave_printf_fl(const char *file, int line,
 	va_end(ap);
 }
 
-#ifndef HAVE_VARIADIC_MACROS
-void trace2_region_leave_printf(const char *category, const char *label,
-				const struct repository *repo, const char *fmt,
-				...)
-{
-	va_list ap;
-
-	va_start(ap, fmt);
-	trace2_region_leave_printf_va_fl(NULL, 0, category, label, repo, fmt,
-					 ap);
-	va_end(ap);
-}
-#endif
-
 void trace2_data_string_fl(const char *file, int line, const char *category,
 			   const struct repository *repo, const char *key,
 			   const char *value)
@@ -782,17 +754,6 @@ void trace2_printf_fl(const char *file, int line, const char *fmt, ...)
 	va_end(ap);
 }
 
-#ifndef HAVE_VARIADIC_MACROS
-void trace2_printf(const char *fmt, ...)
-{
-	va_list ap;
-
-	va_start(ap, fmt);
-	trace2_printf_va_fl(NULL, 0, fmt, ap);
-	va_end(ap);
-}
-#endif
-
 const char *trace2_session_id(void)
 {
 	return tr2_sid_get();
diff --git a/trace2.h b/trace2.h
index ede18c2e063..5d85826f23d 100644
--- a/trace2.h
+++ b/trace2.h
@@ -362,18 +362,9 @@ void trace2_region_enter_printf_fl(const char *file, int line,
 				   const struct repository *repo,
 				   const char *fmt, ...);
 
-#ifdef HAVE_VARIADIC_MACROS
 #define trace2_region_enter_printf(category, label, repo, ...)                 \
 	trace2_region_enter_printf_fl(__FILE__, __LINE__, (category), (label), \
 				      (repo), __VA_ARGS__)
-#else
-/* clang-format off */
-__attribute__((format (region_enter_printf, 4, 5)))
-void trace2_region_enter_printf(const char *category, const char *label,
-				const struct repository *repo, const char *fmt,
-				...);
-/* clang-format on */
-#endif
 
 /**
  * Emit a 'region_leave' event for <category>.<label> with optional
@@ -407,18 +398,9 @@ void trace2_region_leave_printf_fl(const char *file, int line,
 				   const struct repository *repo,
 				   const char *fmt, ...);
 
-#ifdef HAVE_VARIADIC_MACROS
 #define trace2_region_leave_printf(category, label, repo, ...)                 \
 	trace2_region_leave_printf_fl(__FILE__, __LINE__, (category), (label), \
 				      (repo), __VA_ARGS__)
-#else
-/* clang-format off */
-__attribute__((format (region_leave_printf, 4, 5)))
-void trace2_region_leave_printf(const char *category, const char *label,
-				const struct repository *repo, const char *fmt,
-				...);
-/* clang-format on */
-#endif
 
 /**
  * Emit a key-value pair 'data' event of the form <category>.<key> = <value>.
@@ -471,14 +453,7 @@ void trace2_printf_va_fl(const char *file, int line, const char *fmt,
 
 void trace2_printf_fl(const char *file, int line, const char *fmt, ...);
 
-#ifdef HAVE_VARIADIC_MACROS
 #define trace2_printf(...) trace2_printf_fl(__FILE__, __LINE__, __VA_ARGS__)
-#else
-/* clang-format off */
-__attribute__((format (printf, 1, 2)))
-void trace2_printf(const char *fmt, ...);
-/* clang-format on */
-#endif
 
 /*
  * Optional platform-specific code to dump information about the
diff --git a/usage.c b/usage.c
index 1b206de36d6..c8022c517e2 100644
--- a/usage.c
+++ b/usage.c
@@ -290,7 +290,6 @@ static NORETURN void BUG_vfl(const char *file, int line, const char *fmt, va_lis
 	abort();
 }
 
-#ifdef HAVE_VARIADIC_MACROS
 NORETURN void BUG_fl(const char *file, int line, const char *fmt, ...)
 {
 	va_list ap;
@@ -298,15 +297,6 @@ NORETURN void BUG_fl(const char *file, int line, const char *fmt, ...)
 	BUG_vfl(file, line, fmt, ap);
 	va_end(ap);
 }
-#else
-NORETURN void BUG(const char *fmt, ...)
-{
-	va_list ap;
-	va_start(ap, fmt);
-	BUG_vfl(NULL, 0, fmt, ap);
-	va_end(ap);
-}
-#endif
 
 #ifdef SUPPRESS_ANNOTATED_LEAKS
 void unleak_memory(const void *ptr, size_t len)
-- 
2.31.1.631.gb80e078001e

