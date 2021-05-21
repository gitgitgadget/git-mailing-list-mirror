Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B1CBC433B4
	for <git@archiver.kernel.org>; Fri, 21 May 2021 02:50:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61AEA6121E
	for <git@archiver.kernel.org>; Fri, 21 May 2021 02:50:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233608AbhEUCv6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 May 2021 22:51:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231584AbhEUCv6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 May 2021 22:51:58 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0997EC061574
        for <git@vger.kernel.org>; Thu, 20 May 2021 19:50:35 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id f22so12234271pgb.9
        for <git@vger.kernel.org>; Thu, 20 May 2021 19:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=W2C7yHkknS8DcGlwahJsICujPp8SkI83SXt8yOaszSw=;
        b=pgDe8zQAr3qydQjAP+KyHMwrL5njAE4KLhO+n0YPSxIl9g7S3GrrIOaZX8EGJi4pyN
         B8XHeBQLRTLwVzaeG26xh27q/lBUEya+2LmeBgxoCOuvJIAc0ETN8kEEtD740ISa4+h0
         ZeiCFuAhGkgwQCCLNIF68XYe2OaQ2OEv8Dl46X7D59xbRTc6eORj5qF9JUkR9iRlWi4S
         AEwKzGXE5PtfvCYh4pRx6goq2PIGGRYl8Tp0mC0nwOXo1g200NTX6/xs4qNnXKZ6WO45
         jSbCRUA2Iv2WyG3yhoxHG1pA3uwJrn1ZweNRnDx7xsl/EOSBxvRZO+mfYfxQt3/6LFZM
         XFCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=W2C7yHkknS8DcGlwahJsICujPp8SkI83SXt8yOaszSw=;
        b=jte768p/Bo5qoAWlqM8dZtBahwuF4fVWLdAIRruPRn1leD4d7guN3l4Q998qS/V4oX
         3OeESf1dS6UMEtVEyXm6605diQdjfrKp9C34GoVXC64l/bOOtpWRQBWZR/UBCckM0kFV
         x+vUlWH8RVXF6jlwms3mXuquP0hTlGJikaeMmUs81znsvzHjzUcjdLVhOzCue6XxKHzB
         aihp0dsUI57Pg59KBBfuOvIHI8Ry3xppSgcL1C4/43CzvmKSFNyNu9XrKax0g8kBObPF
         IC6GyDU412hmk7WJYN300KT4AfcSJk33h/b3WhkpRCRi1GCmKHYg1RY+D0f40T529SeS
         fYdA==
X-Gm-Message-State: AOAM5329EESG5CwHtcqvG5cSWhiIZD0zP0IipccO0fTyS6HpN331EcE8
        lXoOeF8caukgYlQFdYfgQLZ8Y32NFUY=
X-Google-Smtp-Source: ABdhPJz9wgzjfAIct+c3wtBOcyVMcmQn1Wr0QohhV17FvtpPbkn/bn2nVu8DVrDKE5Wu4IrmzxJEBw==
X-Received: by 2002:a62:2987:0:b029:2de:b564:648d with SMTP id p129-20020a6229870000b02902deb564648dmr8071226pfp.48.1621565434041;
        Thu, 20 May 2021 19:50:34 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:8774:366c:ae84:8f12])
        by smtp.gmail.com with ESMTPSA id mv15sm2957039pjb.25.2021.05.20.19.50.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 19:50:33 -0700 (PDT)
Date:   Thu, 20 May 2021 19:50:31 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] C99 support: remove non-HAVE_VARIADIC_MACROS code
Message-ID: <YKcf95uQ1W7COSsf@google.com>
References: <YHOLo36MfuTj6YeD@camp.crustytoothpaste.net>
 <cover-0.2-00000000000-20210412T105422Z-avarab@gmail.com>
 <patch-2.2-f12e3cad57d-20210412T105422Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-2.2-f12e3cad57d-20210412T105422Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Ævar Arnfjörð Bjarmason wrote:

> Remove code that depend on HAVE_VARIADIC_MACROS not being set. Since
> 765dc168882 (git-compat-util: always enable variadic macros,
> 2021-01-28) we've unconditionally defined it to be true, and that
> change went out with v2.31.0. This should have given packagers enough
> time to discover whether variadic macros were an issue.
>
> It seems that they weren't, so let's update the coding guidelines and
> remove all the fallback code for the non-HAVE_VARIADIC_MACROS case.

As discussed in the rest of this thread, that's a pretty short time,
so while I would love to be able to use variadic macros
unconditionally, I think we'd need a different rationale.

That said, I want us to be ready the moment external conditions allow.
Ideally we want it to be as simple as

	git grep --name-only -e HAVE_VARIADIC_MACROS |
	xargs unifdef -m -DHAVE_VARIADIC_MACROS=1

plus removing the #define; is there anything we need to do in advance
to make that work well?  Let's see.

[...]
> --- a/trace.h
> +++ b/trace.h
> @@ -126,66 +126,6 @@ void trace_command_performance(const char **argv);
>  void trace_verbatim(struct trace_key *key, const void *buf, unsigned len);
>  uint64_t trace_performance_enter(void);
>  
> -#ifndef HAVE_VARIADIC_MACROS
> -
> -/**
> - * Prints a formatted message, similar to printf.
> - */
> -__attribute__((format (printf, 1, 2)))
> -void trace_printf(const char *format, ...);

This removes the documentation for these functions and doesn't add it
back on the #else side.  So I think we'd want the following
preparatory patch.

Thanks,
Jonathan

-- >8 --
Subject: trace: move comments to variadic macro variant of trace functions

Nowadays compilers not having variadic macros are the exception.  Move
API documentation to the declarations used in the common case.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 trace.h | 79 +++++++++++++++++++++++++++------------------------------
 1 file changed, 38 insertions(+), 41 deletions(-)

diff --git a/trace.h b/trace.h
index 0dbbad0e41..fc7eb0bc72 100644
--- a/trace.h
+++ b/trace.h
@@ -128,56 +128,22 @@ uint64_t trace_performance_enter(void);
 
 #ifndef HAVE_VARIADIC_MACROS
 
-/**
- * Prints a formatted message, similar to printf.
- */
+/* Fallback implementation that does not add file:line. */
+
 __attribute__((format (printf, 1, 2)))
 void trace_printf(const char *format, ...);
 
 __attribute__((format (printf, 2, 3)))
 void trace_printf_key(struct trace_key *key, const char *format, ...);
 
-/**
- * Prints a formatted message, followed by a quoted list of arguments.
- */
 __attribute__((format (printf, 2, 3)))
 void trace_argv_printf(const char **argv, const char *format, ...);
 
-/**
- * Prints the strbuf, without additional formatting (i.e. doesn't
- * choke on `%` or even `\0`).
- */
 void trace_strbuf(struct trace_key *key, const struct strbuf *data);
 
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
 __attribute__((format (printf, 2, 3)))
 void trace_performance(uint64_t nanos, const char *format, ...);
 
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
 __attribute__((format (printf, 2, 3)))
 void trace_performance_since(uint64_t start, const char *format, ...);
 
@@ -186,11 +152,6 @@ void trace_performance_leave(const char *format, ...);
 
 #else
 
-/*
- * Macros to add file:line - see above for C-style declarations of how these
- * should be used.
- */
-
 /*
  * TRACE_CONTEXT may be set to __FUNCTION__ if the compiler supports it. The
  * default is __FILE__, as it is consistent with assert(), and static function
@@ -227,8 +188,14 @@ void trace_performance_leave(const char *format, ...);
 					    __VA_ARGS__);		    \
 	} while (0)
 
+/**
+ * Prints a formatted message, similar to printf.
+ */
 #define trace_printf(...) trace_printf_key(&trace_default_key, __VA_ARGS__)
 
+/**
+ * Prints a formatted message, followed by a quoted list of arguments.
+ */
 #define trace_argv_printf(argv, ...)					    \
 	do {								    \
 		if (trace_pass_fl(&trace_default_key))			    \
@@ -236,12 +203,32 @@ void trace_performance_leave(const char *format, ...);
 					    argv, __VA_ARGS__);		    \
 	} while (0)
 
+/**
+ * Prints the strbuf, without additional formatting (i.e. doesn't
+ * choke on `%` or even `\0`).
+ */
 #define trace_strbuf(key, data)						    \
 	do {								    \
 		if (trace_pass_fl(key))					    \
 			trace_strbuf_fl(TRACE_CONTEXT, __LINE__, key, data);\
 	} while (0)
 
+/**
+ * Prints elapsed time (in nanoseconds) if GIT_TRACE_PERFORMANCE is enabled.
+ *
+ * Example:
+ * ------------
+ * uint64_t t = 0;
+ * for (;;) {
+ * 	// ignore
+ * t -= getnanotime();
+ * // code section to measure
+ * t += getnanotime();
+ * // ignore
+ * }
+ * trace_performance(t, "frotz");
+ * ------------
+ */
 #define trace_performance(nanos, ...)					    \
 	do {								    \
 		if (trace_pass_fl(&trace_perf_key))			    \
@@ -249,6 +236,16 @@ void trace_performance_leave(const char *format, ...);
 					     __VA_ARGS__);		    \
 	} while (0)
 
+/**
+ * Prints elapsed time since 'start' if GIT_TRACE_PERFORMANCE is enabled.
+ *
+ * Example:
+ * ------------
+ * uint64_t start = getnanotime();
+ * // code section to measure
+ * trace_performance_since(start, "foobar");
+ * ------------
+ */
 #define trace_performance_since(start, ...)				    \
 	do {								    \
 		if (trace_pass_fl(&trace_perf_key))			    \
-- 
2.31.1.818.g46aad6cb9e

