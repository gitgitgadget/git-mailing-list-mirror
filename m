Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0C98C433EF
	for <git@archiver.kernel.org>; Fri, 28 Jan 2022 11:11:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244321AbiA1LLO (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Jan 2022 06:11:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241051AbiA1LLO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Jan 2022 06:11:14 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5D7EC061714
        for <git@vger.kernel.org>; Fri, 28 Jan 2022 03:11:13 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id o30-20020a05600c511e00b0034f4c3186f4so7920716wms.3
        for <git@vger.kernel.org>; Fri, 28 Jan 2022 03:11:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VmyBrciWgP52Jy0d38YsZ01f19b1vB5+JD+UQjkLrfs=;
        b=jcz9GwB6GLRiFraJiYyS+AiA3Iaekb9mgwj/sJwmzh9TaCMm9rjs3gIGKZKZ9xciIN
         flPx4BDj3SZvjZb63D5e8RextLYGtiFqOylFYBH+abVJgt364zokrHHP84goB2pRDafE
         3GisYYwOP4PZDfubB89rg7Grf61LH4eibOoX331Q+UBMNmoCz1qPY+NiSvGfd4Hr/WYJ
         z/bUw6uqD0vwTNfJTCy7vv3GYonfrX5poKd+KU6sbMT40n7fZeL9ljyLBcTi6ReAaYfG
         4whDQE+Kv2WleBl8iGIOPXNt4XWMTrY0MO/Cr1UQhvzg8OEVJ3eUicSMY+Hdxm/1DZv3
         Xlgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VmyBrciWgP52Jy0d38YsZ01f19b1vB5+JD+UQjkLrfs=;
        b=QQjN300bds8KEk8MGHy7z13Q4Y9PWixBiv1WGbo9H3j3nRqQZLUWccWQZJIsyL5KCX
         8aF0gxpqw+6GCFQOQQ1UhEzE+VuZPpIavcTfMJ7QvhfP5YieLYjmxoNo42WjFp4WIeNg
         wqptxrGJZDBTeleM4bzWQasz6tt0nw0buSMUa+UTg/3M0jJIemZp/Z8HkZB2QEOYsymz
         1VtAlUY+RLUFQzFBMgYiWZz3Bj2CZ6++d2g4mRe9aB7/P8jjRdM7Hq4ns7gSaJCRd+bj
         v3moIfV9Bi0V2WKkD24JMykJvp2aN8RsJ5c25R5bv5J+VN17VWUdU0L7bWFw+b+tkA/t
         WJ/Q==
X-Gm-Message-State: AOAM531LaA261GP8CRCkilQ9mH9DfNEANmAtJSLIld0aWLUZJp9uNk60
        JmdIeOMhvxAgiMHG5DyeOPsa2sut26FKWw==
X-Google-Smtp-Source: ABdhPJzFJLP4gLPHz9kPbxq8KQsIACMPVx7RodmpdADSJObCyo436hDcctgNSgjVv/7AR8DVj0S9JA==
X-Received: by 2002:a05:600c:2149:: with SMTP id v9mr15763312wml.85.1643368271688;
        Fri, 28 Jan 2022 03:11:11 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id j15sm1988521wmq.19.2022.01.28.03.11.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jan 2022 03:11:11 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 0/2] C99: remove hardcoded-out !HAVE_VARIADIC_MACROS code
Date:   Fri, 28 Jan 2022 12:11:07 +0100
Message-Id: <cover-v2-0.2-00000000000-20220128T110330Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.0.912.ga4a35ddedc3
In-Reply-To: <cover-0.2-00000000000-20210412T105422Z-avarab@gmail.com>
References: <cover-0.2-00000000000-20210412T105422Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This v2 of $subject is being submitted on the one-year anniversary of
the patch to hardcode away the !HAVE_VARIADIC_MACROS code.

This is another small step on the way towards changing the usage.[ch]
API so that we can log the actual file/line number of
usage()/warning()/error()/die() in trace2 events. See a greater RFC
series to do that at:
https://lore.kernel.org/git/RFC-cover-00.21-00000000000-20211115T220831Z-avarab@gmail.com/

This should address all feedback raised on v1, including Junio
thinking it was a no-go since the submission in April 2021 was was
relatively recently after we'd hardcoded away
!HAVE_VARIADIC_MACROS. We've now had several releases with that code,
and other recent C99 test balloons since then.

The since of the range-diff is mainly because in v1 I didn't notice
that I needed to move the relevant API docs around, which this v2
does.

Ævar Arnfjörð Bjarmason (2):
  git-compat-util.h: clarify GCC v.s. C99-specific in comment
  C99: remove hardcoded-out !HAVE_VARIADIC_MACROS code

 Documentation/CodingGuidelines |   3 +
 banned.h                       |   5 --
 git-compat-util.h              |  16 +---
 trace.c                        |  80 +-------------------
 trace.h                        | 133 +++++++++++++--------------------
 trace2.c                       |  39 ----------
 trace2.h                       |  25 -------
 usage.c                        |  15 +---
 8 files changed, 59 insertions(+), 257 deletions(-)

Range-diff against v1:
1:  a8cc05cf56f ! 1:  31079a71ecb git-compat-util.h: clarify comment on GCC-specific code
    @@ Metadata
     Author: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Commit message ##
    -    git-compat-util.h: clarify comment on GCC-specific code
    +    git-compat-util.h: clarify GCC v.s. C99-specific in comment
     
         Change a comment added in e208f9cc757 (make error()'s constant return
    -    value more visible, 2012-12-15) to note that the code doesn't only
    -    depend on variadic macros, which have been a hard dependency since
    -    765dc168882 (git-compat-util: always enable variadic macros,
    -    2021-01-28), but also on GCC's handling of __VA_ARGS__. The commit
    -    message for e208f9cc757 made this clear, but the comment it added did
    -    not.
    +    value more visible, 2012-12-15). It's not correct that this is GCC-ism
    +    anymore, it's code that uses standard C99 features.
    +
    +    The comment being changed here pre-dates the HAVE_VARIADIC_MACROS
    +    define, which we got in e05bed960d3 (trace: add 'file:line' to all
    +    trace output, 2014-07-12).
    +
    +    The original implementation of an error() macro) in e208f9cc757 used a
    +    GCC-ism with the paste operator (see the commit message for mention of
    +    it), but that was dropped later by 9798f7e5f9 (Use __VA_ARGS__ for all
    +    of error's arguments, 2013-02-08), giving us the C99-portable version
    +    we have now.
    +
    +    While we could remove the __GNUC__ define here, it might cause issues
    +    for other compilers or static analysis systems, so let's not. See
    +    87fe5df365 (inline constant return from error() function, 2014-05-06)
    +    for one such issue.
     
         See also e05bed960d3 (trace: add 'file:line' to all trace output,
         2014-07-12) for another comment about GNUC's handling of __VA_ARGS__.
    @@ Commit message
     
      ## git-compat-util.h ##
     @@ git-compat-util.h: void warning_errno(const char *err, ...) __attribute__((format (printf, 1, 2)));
    - 
      /*
       * Let callers be aware of the constant return value; this can help
    -- * gcc with -Wuninitialized analysis. We restrict this trick to gcc, though,
    +  * gcc with -Wuninitialized analysis. We restrict this trick to gcc, though,
     - * because some compilers may not support variadic macros. Since we're only
     - * trying to help gcc, anyway, it's OK; other compilers will fall back to
     - * using the function as usual.
    -+ * gcc with -Wuninitialized analysis.
    -+ *
    -+ * We restrict this trick to gcc, though, because while we rely on the
    -+ * presence of C99 variadic macros, this code also relies on the
    -+ * non-standard behavior of GCC's __VA_ARGS__, allowing error() to
    -+ * work even if no format specifiers are passed to error().
    -+ *
    -+ * Since we're only trying to help gcc, anyway, it's OK; other
    -+ * compilers will fall back to using the function as usual.
    ++ * because other compilers may be confused by this.
       */
      #if defined(__GNUC__)
      static inline int const_error(void)
2:  f12e3cad57d ! 2:  966d96505cb C99 support: remove non-HAVE_VARIADIC_MACROS code
    @@ Metadata
     Author: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Commit message ##
    -    C99 support: remove non-HAVE_VARIADIC_MACROS code
    +    C99: remove hardcoded-out !HAVE_VARIADIC_MACROS code
     
    -    Remove code that depend on HAVE_VARIADIC_MACROS not being set. Since
    -    765dc168882 (git-compat-util: always enable variadic macros,
    -    2021-01-28) we've unconditionally defined it to be true, and that
    -    change went out with v2.31.0. This should have given packagers enough
    -    time to discover whether variadic macros were an issue.
    +    Remove the "else" branches of the HAVE_VARIADIC_MACROS macro, which
    +    has been unconditionally omitted since 765dc168882 (git-compat-util:
    +    always enable variadic macros, 2021-01-28).
     
    -    It seems that they weren't, so let's update the coding guidelines and
    -    remove all the fallback code for the non-HAVE_VARIADIC_MACROS case.
    +    Since they were hardcoded out anyone trying to compile a version of
    +    git v2.31.0 or later would have had a compilation error. 10 months
    +    across a few releases since then should have been enough time for
    +    anyone who cared to run into that and report the issue.
    +
    +    In addition to that, for anyone unsetting HAVE_VARIADIC_MACROS we've
    +    been emitting extremely verbose warnings since at least
    +    ee4512ed481 (trace2: create new combined trace facility,
    +    2019-02-22). That's because there is no such thing as a
    +    "region_enter_printf" or "region_leave_printf" format, so at least
    +    under GCC and Clang everything that includes trace.h (almost every
    +    file) emits a couple of warnings about that.
    +
    +    There's a large benefit to being able to have a hard dependency rely
    +    on variadic macros, the code surrounding usage.c is hard to maintain
    +    if we need to write two implementations of everything, and by relying
    +    on "__FILE__" and "__LINE__" along with "__VA_ARGS__" we can in the
    +    future make error(), die() etc. log where they were called from. We've
    +    also recently merged d67fc4bf0ba (Merge branch 'bc/require-c99',
    +    2021-12-10) which further cements our hard dependency on C99.
    +
    +    So let's delete the fallback code, and update our CodingGuidelines to
    +    note that we depend on this. The added bullet-point starts with
    +    lower-case for consistency with other bullet-points in that section.
    +
    +    The diff in "trace.h" is relatively hard to read, since we need to
    +    retain the existing API docs, which were comments on the code used if
    +    HAVE_VARIADIC_MACROS was not defined.
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
    @@ git-compat-util.h: static inline int regexec_buf(const regex_t *preg, const char
     
      ## trace.c ##
     @@ trace.c: static int prepare_trace_line(const char *file, int line,
    - 	strbuf_addf(buf, "%02d:%02d:%02d.%06ld ", tm.tm_hour, tm.tm_min,
    - 		    tm.tm_sec, (long) tv.tv_usec);
    - 
    + 	gettimeofday(&tv, NULL);
    + 	secs = tv.tv_sec;
    + 	localtime_r(&secs, &tm);
    +-	strbuf_addf(buf, "%02d:%02d:%02d.%06ld ", tm.tm_hour, tm.tm_min,
    +-		    tm.tm_sec, (long) tv.tv_usec);
    +-
     -#ifdef HAVE_VARIADIC_MACROS
    - 	/* print file:line */
    - 	strbuf_addf(buf, "%s:%d ", file, line);
    +-	/* print file:line */
    +-	strbuf_addf(buf, "%s:%d ", file, line);
    ++	strbuf_addf(buf, "%02d:%02d:%02d.%06ld %s:%d", tm.tm_hour, tm.tm_min,
    ++		    tm.tm_sec, (long) tv.tv_usec, file, line);
      	/* align trace output (column 40 catches most files names in git) */
      	while (buf->len < 40)
      		strbuf_addch(buf, ' ');
    @@ trace.h: void trace_command_performance(const char **argv);
     - */
     -void trace_strbuf(struct trace_key *key, const struct strbuf *data);
     -
    --/**
    + /**
     - * Prints elapsed time (in nanoseconds) if GIT_TRACE_PERFORMANCE is enabled.
    -- *
    ++ * Macros to add the file:line of the calling code, instead of that of
    ++ * the trace function itself.
    +  *
     - * Example:
     - * ------------
     - * uint64_t t = 0;
    @@ trace.h: void trace_command_performance(const char **argv);
     -
     -#else
     -
    - /*
    -  * Macros to add file:line - see above for C-style declarations of how these
    -  * should be used.
    +-/*
    +- * Macros to add file:line - see above for C-style declarations of how these
    +- * should be used.
    +- */
    +-
    +-/*
    +- * TRACE_CONTEXT may be set to __FUNCTION__ if the compiler supports it. The
    +- * default is __FILE__, as it is consistent with assert(), and static function
    +- * names are not necessarily unique.
    +- *
    +- * __FILE__ ":" __FUNCTION__ doesn't work with GNUC, as __FILE__ is supplied
    +- * by the preprocessor as a string literal, and __FUNCTION__ is filled in by
    +- * the compiler as a string constant.
    +- */
    +-#ifndef TRACE_CONTEXT
    +-# define TRACE_CONTEXT __FILE__
    +-#endif
    +-
    +-/*
    +  * Note: with C99 variadic macros, __VA_ARGS__ must include the last fixed
    +  * parameter ('format' in this case). Otherwise, a call without variable
    +  * arguments will have a surplus ','. E.g.:
    +@@ trace.h: void trace_performance_leave(const char *format, ...);
    +  *
    +  * which is invalid (note the ',)'). With GNUC, '##__VA_ARGS__' drops the
    +  * comma, but this is non-standard.
    ++ *
    ++ * TRACE_CONTEXT may be set to __FUNCTION__ if the compiler supports it. The
    ++ * default is __FILE__, as it is consistent with assert(), and static function
    ++ * names are not necessarily unique.
    ++ *
    ++ * __FILE__ ":" __FUNCTION__ doesn't work with GNUC, as __FILE__ is supplied
    ++ * by the preprocessor as a string literal, and __FUNCTION__ is filled in by
    ++ * the compiler as a string constant.
    ++ */
    ++#ifndef TRACE_CONTEXT
    ++# define TRACE_CONTEXT __FILE__
    ++#endif
    ++
    ++/**
    ++ * Prints a formatted message, similar to printf.
    +  */
    ++#define trace_printf(...) trace_printf_key(&trace_default_key, __VA_ARGS__)
    + 
    + #define trace_printf_key(key, ...)					    \
    + 	do {								    \
    +@@ trace.h: void trace_performance_leave(const char *format, ...);
    + 					    __VA_ARGS__);		    \
    + 	} while (0)
    + 
    +-#define trace_printf(...) trace_printf_key(&trace_default_key, __VA_ARGS__)
    +-
    ++/**
    ++ * Prints a formatted message, followed by a quoted list of arguments.
    ++ */
    + #define trace_argv_printf(argv, ...)					    \
    + 	do {								    \
    + 		if (trace_pass_fl(&trace_default_key))			    \
    +@@ trace.h: void trace_performance_leave(const char *format, ...);
    + 					    argv, __VA_ARGS__);		    \
    + 	} while (0)
    + 
    ++/**
    ++ * Prints the strbuf, without additional formatting (i.e. doesn't
    ++ * choke on `%` or even `\0`).
    ++ */
    + #define trace_strbuf(key, data)						    \
    + 	do {								    \
    + 		if (trace_pass_fl(key))					    \
    + 			trace_strbuf_fl(TRACE_CONTEXT, __LINE__, key, data);\
    + 	} while (0)
    + 
    ++/**
    ++ * Prints elapsed time (in nanoseconds) if GIT_TRACE_PERFORMANCE is enabled.
    ++ *
    ++ * Example:
    ++ * ------------
    ++ * uint64_t t = 0;
    ++ * for (;;) {
    ++ * 	// ignore
    ++ * t -= getnanotime();
    ++ * // code section to measure
    ++ * t += getnanotime();
    ++ * // ignore
    ++ * }
    ++ * trace_performance(t, "frotz");
    ++ * ------------
    ++ */
    + #define trace_performance(nanos, ...)					    \
    + 	do {								    \
    + 		if (trace_pass_fl(&trace_perf_key))			    \
    +@@ trace.h: void trace_performance_leave(const char *format, ...);
    + 					     __VA_ARGS__);		    \
    + 	} while (0)
    + 
    ++/**
    ++ * Prints elapsed time since 'start' if GIT_TRACE_PERFORMANCE is enabled.
    ++ *
    ++ * Example:
    ++ * ------------
    ++ * uint64_t start = getnanotime();
    ++ * // code section to measure
    ++ * trace_performance_since(start, "foobar");
    ++ * ------------
    ++ */
    + #define trace_performance_since(start, ...)				    \
    + 	do {								    \
    + 		if (trace_pass_fl(&trace_perf_key))			    \
    +@@ trace.h: void trace_performance_leave(const char *format, ...);
    + 						   __VA_ARGS__);	    \
    + 	} while (0)
    + 
    ++
    + /* backend functions, use non-*fl macros instead */
    + __attribute__((format (printf, 4, 5)))
    + void trace_printf_key_fl(const char *file, int line, struct trace_key *key,
     @@ trace.h: static inline int trace_pass_fl(struct trace_key *key)
      	return key->fd || !key->initialized;
      }
    @@ trace2.h: void trace2_printf_va_fl(const char *file, int line, const char *fmt,
       * Optional platform-specific code to dump information about the
     
      ## usage.c ##
    +@@ usage.c: static NORETURN void BUG_vfl(const char *file, int line, const char *fmt, va_lis
    + 	va_copy(params_copy, params);
    + 
    + 	/* truncation via snprintf is OK here */
    +-	if (file)
    +-		snprintf(prefix, sizeof(prefix), "BUG: %s:%d: ", file, line);
    +-	else
    +-		snprintf(prefix, sizeof(prefix), "BUG: ");
    ++	snprintf(prefix, sizeof(prefix), "BUG: %s:%d: ", file, line);
    + 
    + 	vreportf(prefix, fmt, params);
    + 
     @@ usage.c: static NORETURN void BUG_vfl(const char *file, int line, const char *fmt, va_lis
      	abort();
      }
-- 
2.35.0.912.ga4a35ddedc3

