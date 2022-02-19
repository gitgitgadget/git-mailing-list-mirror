Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92202C433F5
	for <git@archiver.kernel.org>; Sat, 19 Feb 2022 10:41:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241959AbiBSKmG (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 19 Feb 2022 05:42:06 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240893AbiBSKmF (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Feb 2022 05:42:05 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CDF536E09
        for <git@vger.kernel.org>; Sat, 19 Feb 2022 02:41:46 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id d27so18601429wrb.5
        for <git@vger.kernel.org>; Sat, 19 Feb 2022 02:41:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HfUmCH5zea+xhiTD4lmOCJxbb74mPNGl5gEvmxg7XFA=;
        b=Yft4dG4I7BRXYIGe69XHGCFZnBcnP9apfLtpnsyYjGAvw8KIgV6cvz7NaaBulpTALg
         uC6DyS3s27jVKTOKDp0+OtwPwv677cGh0Phk6LlN1TMCQVj0iW1o2HL9iu0G/WHHV7dp
         mcAYrRuM4gaozkxiu+x1U+qIUsZvM6hvhdqvfR/Pcfz5WFd1RNqn01eyfcQIhAYdiO0C
         nBMfW0qnWPb0XXO+WMg3kKeW+0ons9BMFQo//GgMJLa8HWPcKh5pYSpzeQH9ySC8wC+a
         VcwmJp72wq/HqRkkss3QKFp1MCdu9f3ZhGPcIFsKFlCZU7wLPxWqcLeWuyT+HVioDXcE
         Wnug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HfUmCH5zea+xhiTD4lmOCJxbb74mPNGl5gEvmxg7XFA=;
        b=raRB5sp2Xzs0IewXdAyw+oGfTJ0zIa5VD6IAi79W8XfGDFU0uJyIAFIxwqwnW8/S6x
         lCUCugz08lIay+YJrTHMlJqle9gPj3OPEbJTsjgOOdhC359cHwUyv5KPv1nQi97YCKwk
         E8o5rlDpyOIrHDWDlYG38CGNAj0xtzGt7sbF5+a0GMfSfHDip6ubr0d1mCkNLrEn8y8H
         Q6pZxPvN9bXTeebvSxPxUW5K0hK+SjcMIGkT5+5xdDmHDtUcZUhQquTTUbLS/bMlxRTz
         9kzPPthYRFpURsRP9V+yR4hRfzra3lf6c36Ts5VUI8VnucXwZmPrwJvy0bHLx4wWDUTJ
         8v3w==
X-Gm-Message-State: AOAM531oltMMr0X89DU1HRKCB0nm9owvRaU5Pwf+no/g45DOWJbBb0ld
        jrfHAo3rUczge7eH8cGcckW52hgFL7W/AA==
X-Google-Smtp-Source: ABdhPJyWBt4sG4kYA5mJnzIVScJ5aULJeYJa5zaT2z03nJhGmV+qGz9oU4rpuOki0Y7ARI6bB723KQ==
X-Received: by 2002:a05:6000:10cf:b0:1e6:ac26:ce6 with SMTP id b15-20020a05600010cf00b001e6ac260ce6mr9180717wrx.354.1645267304241;
        Sat, 19 Feb 2022 02:41:44 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id 1sm21623928wrz.75.2022.02.19.02.41.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Feb 2022 02:41:43 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 0/3] C99: remove dead !HAVE_VARIADIC_MACROS code
Date:   Sat, 19 Feb 2022 11:41:07 +0100
Message-Id: <cover-v3-0.3-00000000000-20220219T103752Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1129.g03fd99ecb8d
In-Reply-To: <cover-v2-0.2-00000000000-20220128T110330Z-avarab@gmail.com>
References: <cover-v2-0.2-00000000000-20220128T110330Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A too-late re-roll of the v2[1], sorry. But this should address all
issues raised the last time around.

Since v2 I've:

 * Improved the documentation of the now onnly-macros. I opted to just
   quote the argument list of the old C functions for explanation.

 * Some miscellanious commit message grammar fixes.

 * Whitespace fixes in 2/3.

 * There's a new 3/3 which removes an indirection used to define
   __FILE__, instead we now use __FILE__ directly.

1. https://lore.kernel.org/git/cover-v2-0.2-00000000000-20220128T110330Z-avarab@gmail.com/

Ævar Arnfjörð Bjarmason (3):
  git-compat-util.h: clarify GCC v.s. C99-specific in comment
  C99: remove hardcoded-out !HAVE_VARIADIC_MACROS code
  trace.h: remove never-used TRACE_CONTEXT

 Documentation/CodingGuidelines |   3 +
 banned.h                       |   5 --
 git-compat-util.h              |  16 +---
 trace.c                        |  80 +-----------------
 trace.h                        | 145 ++++++++++++++-------------------
 trace2.c                       |  39 ---------
 trace2.h                       |  25 ------
 usage.c                        |  15 +---
 8 files changed, 67 insertions(+), 261 deletions(-)

Range-diff against v2:
1:  31079a71ecb = 1:  1a15fe4fd74 git-compat-util.h: clarify GCC v.s. C99-specific in comment
2:  966d96505cb ! 2:  bd0f969be55 C99: remove hardcoded-out !HAVE_VARIADIC_MACROS code
    @@ Commit message
         C99: remove hardcoded-out !HAVE_VARIADIC_MACROS code
     
         Remove the "else" branches of the HAVE_VARIADIC_MACROS macro, which
    -    has been unconditionally omitted since 765dc168882 (git-compat-util:
    +    have been unconditionally omitted since 765dc168882 (git-compat-util:
         always enable variadic macros, 2021-01-28).
     
    -    Since they were hardcoded out anyone trying to compile a version of
    +    Since were always omitted, anyone trying to use a compiler without
    +    variadic macro support to compile a git since version
         git v2.31.0 or later would have had a compilation error. 10 months
         across a few releases since then should have been enough time for
         anyone who cared to run into that and report the issue.
    @@ trace.h: void trace_command_performance(const char **argv);
     - */
     -void trace_strbuf(struct trace_key *key, const struct strbuf *data);
     -
    - /**
    +-/**
     - * Prints elapsed time (in nanoseconds) if GIT_TRACE_PERFORMANCE is enabled.
    -+ * Macros to add the file:line of the calling code, instead of that of
    -+ * the trace function itself.
    -  *
    +- *
     - * Example:
     - * ------------
     - * uint64_t t = 0;
    @@ trace.h: void trace_command_performance(const char **argv);
     - * should be used.
     - */
     -
    + /*
    +  * TRACE_CONTEXT may be set to __FUNCTION__ if the compiler supports it. The
    +  * default is __FILE__, as it is consistent with assert(), and static function
    +@@ trace.h: void trace_performance_leave(const char *format, ...);
    + # define TRACE_CONTEXT __FILE__
    + #endif
    + 
     -/*
    -- * TRACE_CONTEXT may be set to __FUNCTION__ if the compiler supports it. The
    -- * default is __FILE__, as it is consistent with assert(), and static function
    -- * names are not necessarily unique.
    -- *
    -- * __FILE__ ":" __FUNCTION__ doesn't work with GNUC, as __FILE__ is supplied
    -- * by the preprocessor as a string literal, and __FUNCTION__ is filled in by
    -- * the compiler as a string constant.
    -- */
    --#ifndef TRACE_CONTEXT
    --# define TRACE_CONTEXT __FILE__
    --#endif
    --
    --/*
    ++/**
    ++ * Macros to add the file:line of the calling code, instead of that of
    ++ * the trace function itself.
    ++ *
       * Note: with C99 variadic macros, __VA_ARGS__ must include the last fixed
       * parameter ('format' in this case). Otherwise, a call without variable
       * arguments will have a surplus ','. E.g.:
     @@ trace.h: void trace_performance_leave(const char *format, ...);
    -  *
    -  * which is invalid (note the ',)'). With GNUC, '##__VA_ARGS__' drops the
       * comma, but this is non-standard.
    +  */
    + 
    ++/**
    ++ * trace_printf(), accepts "const char *format, ...".
     + *
    -+ * TRACE_CONTEXT may be set to __FUNCTION__ if the compiler supports it. The
    -+ * default is __FILE__, as it is consistent with assert(), and static function
    -+ * names are not necessarily unique.
    -+ *
    -+ * __FILE__ ":" __FUNCTION__ doesn't work with GNUC, as __FILE__ is supplied
    -+ * by the preprocessor as a string literal, and __FUNCTION__ is filled in by
    -+ * the compiler as a string constant.
    ++ * Prints a formatted message, similar to printf.
     + */
    -+#ifndef TRACE_CONTEXT
    -+# define TRACE_CONTEXT __FILE__
    -+#endif
    ++#define trace_printf(...) trace_printf_key(&trace_default_key, __VA_ARGS__)
     +
     +/**
    -+ * Prints a formatted message, similar to printf.
    -  */
    -+#define trace_printf(...) trace_printf_key(&trace_default_key, __VA_ARGS__)
    - 
    ++ * trace_printf_key(), accepts "struct trace_key *key, const char *format, ...".
    ++ */
      #define trace_printf_key(key, ...)					    \
      	do {								    \
    + 		if (trace_pass_fl(key))					    \
     @@ trace.h: void trace_performance_leave(const char *format, ...);
      					    __VA_ARGS__);		    \
      	} while (0)
    @@ trace.h: void trace_performance_leave(const char *format, ...);
     -#define trace_printf(...) trace_printf_key(&trace_default_key, __VA_ARGS__)
     -
     +/**
    ++ * trace_argv_printf(), accepts "struct trace_key *key, const char *format, ...)".
    ++ *
     + * Prints a formatted message, followed by a quoted list of arguments.
     + */
      #define trace_argv_printf(argv, ...)					    \
    @@ trace.h: void trace_performance_leave(const char *format, ...);
      	} while (0)
      
     +/**
    ++ * trace_strbuf(), accepts "struct trace_key *key, const struct strbuf *data".
    ++ *
     + * Prints the strbuf, without additional formatting (i.e. doesn't
     + * choke on `%` or even `\0`).
     + */
    @@ trace.h: void trace_performance_leave(const char *format, ...);
      	} while (0)
      
     +/**
    ++ * trace_performance(), accepts "uint64_t nanos, const char *format, ...".
    ++ *
     + * Prints elapsed time (in nanoseconds) if GIT_TRACE_PERFORMANCE is enabled.
     + *
     + * Example:
    @@ trace.h: void trace_performance_leave(const char *format, ...);
      	} while (0)
      
     +/**
    ++ * trace_performance_since(), accepts "uint64_t start, const char *format, ...".
    ++ *
     + * Prints elapsed time since 'start' if GIT_TRACE_PERFORMANCE is enabled.
     + *
     + * Example:
    @@ trace.h: void trace_performance_leave(const char *format, ...);
      	do {								    \
      		if (trace_pass_fl(&trace_perf_key))			    \
     @@ trace.h: void trace_performance_leave(const char *format, ...);
    - 						   __VA_ARGS__);	    \
    + 					     __VA_ARGS__);		    \
      	} while (0)
      
    -+
    - /* backend functions, use non-*fl macros instead */
    - __attribute__((format (printf, 4, 5)))
    - void trace_printf_key_fl(const char *file, int line, struct trace_key *key,
    ++/**
    ++ * trace_performance_leave(), accepts "const char *format, ...".
    ++ */
    + #define trace_performance_leave(...)					    \
    + 	do {								    \
    + 		if (trace_pass_fl(&trace_perf_key))			    \
     @@ trace.h: static inline int trace_pass_fl(struct trace_key *key)
      	return key->fd || !key->initialized;
      }
-:  ----------- > 3:  27ea260bbea trace.h: remove never-used TRACE_CONTEXT
-- 
2.35.1.1129.g03fd99ecb8d

