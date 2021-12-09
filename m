Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1AC6C433EF
	for <git@archiver.kernel.org>; Thu,  9 Dec 2021 19:20:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbhLITXc (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Dec 2021 14:23:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbhLITX0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Dec 2021 14:23:26 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A70DDC061D7E
        for <git@vger.kernel.org>; Thu,  9 Dec 2021 11:19:42 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id v11so11419316wrw.10
        for <git@vger.kernel.org>; Thu, 09 Dec 2021 11:19:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=E8LZFy9BAEG7B+wU2Cd0C8B6SDuYC255mc8f5be8AkI=;
        b=pPUN/vHSaVbM/T4B8hgQE0aCcdKWJhkoPAQbdBg3TZ2YAZABknbCig/oEsqOJYockR
         Cb7ZoqABMcy6qxaX/cvIaGOZivyXOQ8jFkHx+FT0bejPBLj01gdj1/fwZZWlViB/vJo6
         btnlzVdYyV61n2FZMzW/hvSey1hjvHl7jGk6O9Arml+H2aaujx+/WekKFAVYrDv4Befg
         ewP/fD3MBguJ8gElZIXuO2u7XkZzI0CgQtosa1EWIqUm+BvCAEBY6AIUo7m+CEXYq6uZ
         CmHymCRZ64V5jYrxCswK25334Uagre7xOII3/0U0GWUSdxNijiLbQYXWcxQ3HusbSiwa
         m1kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=E8LZFy9BAEG7B+wU2Cd0C8B6SDuYC255mc8f5be8AkI=;
        b=P6CUdUiL6mJY1eN00lgbnTqPR9IVNnbsZZtsKhvFJjwGffoQCRnfYE+wktCXLs5fiT
         c7W9D7XWQEevV94mfmHx1GWycubclhSf1zj6sJEYPeiNso7wwoPVLZiGvpEOLDq4XqGd
         80EiZvhZYNk0xQ18fey+mjoFN3XQFHKf2szYGOMqDwMsXQB6CuhxFykitIdw/rQ5jm7M
         Zpe7793juEDhLqbkvRLyY0guDKDDL0eGBA7bn5uP3h7DoWX9/9FAtufmzXb/rTOfAu9Q
         rNAxXfZNTPvYHvXXMY1bAAOK47zg4oCqY2jpmFgDFStKbtTZrONMFGOPSBwIPWL+ocz1
         4TIw==
X-Gm-Message-State: AOAM531lxjUD92Ppd6SaD04ouO8m4AC4Eh71Fwl/OFTSbsaoC0hrRUHV
        1m7MM6f5XKoTSuGnwZc24tKR8po2eCwqXg==
X-Google-Smtp-Source: ABdhPJwhMywgtbdYWtaCSKWtF4vpewEuqRXu60C65HcZcmu6C1AbGrk9WeoEjmDXvQoKYqf54wZOZA==
X-Received: by 2002:a5d:6508:: with SMTP id x8mr8383443wru.388.1639077580364;
        Thu, 09 Dec 2021 11:19:40 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id x13sm562180wrr.47.2021.12.09.11.19.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Dec 2021 11:19:39 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Erik Faye-Lund <kusmabite@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC PATCH 09/10] linear-assignment.c: add and use intprops.h from Gnulib
Date:   Thu,  9 Dec 2021 20:19:26 +0100
Message-Id: <RFC-patch-09.10-2026b4bff90-20211209T191653Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.930.g0f9292b224d
In-Reply-To: <RFC-cover-00.10-00000000000-20211209T191653Z-avarab@gmail.com>
References: <RFC-cover-00.10-00000000000-20211209T191653Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the preceding commit we started optimistically using
__builtin_{add,mul}_overflow under GCC and Clang, but as reading
through the intprops.h being added here from gnulib reveals, using
just those functions is a rabbit hole of version-specific GCC and
Clang bugs, compiler detection etc.

Let's outsource all that detection to the macro-only intprops.h from
Gnulib. This header is licensed under the LGPL 2.1, the same license
that xdiff/* and compat/regex/* are under. So there's no license
reason for why we can't import this.

This is the latest version from
gnulib.git (https://git.savannah.gnu.org/git/gnulib.git), last
modified with 5d88f13109 (regex: sync with glibc, 2021-09-21). The
once change to it is the removal of:

    #include <limits.h>

Which we'll get from git-compat-util.h.

Now we'll still die the same way on overflow, i.e:

    git -P range-diff --creation-factor=50 origin/master...git-for-windows/main
    fatal: integer overflow in cost[47395 + ((47396 * 45309) = -2147454537)] addition

But this time we don't need compiler-specific checks in our main
sources to do so, this even works on e.g. Intel ICC.

Note that this file has various "git diff --check" issues, hence the
"compat/gnulib/.gitattributes" being added here. These are external
sources, we should import them as close to as-is as we can, to make it
easier to upgrade them in the future.

We could go a step further here and replace the various
unsigned_*_overflows() in "git-compat-util.h" with macros from this
intprops.h header. See [1][2][3][4][5] for our home-grown
implementation of overflow checking. That could be done as simply
replacing them with:

    #include "compat/gnulib/intprops.h"
    #define signed_add_overflows(a, b) INT_ADD_OVERFLOW(a, b)
    #define unsigned_add_overflows(a, b) INT_ADD_OVERFLOW(a, b)
    #define unsigned_mult_overflows(a, b) INT_MULTIPLY_OVERFLOW(a, b)
    #define unsigned_left_shift_overflows(a, shift) INT_LEFT_SHIFT_OVERFLOW(a, shift)

The benefit of doing so is that we'd end up with implementations that
would be more robust, as they'd detect both signed and unsigned
overflows (we should then also rename our own macros).

The disadvantage is that it's a bit slower. I forward-ported the
benchmark program [6] written in 2016. Using the above macro
definitions the slowdown measured with git-hyperfine[7] is the
following:

    $ git hyperfine -L rev HEAD~1,HEAD~0 -s 'make CFLAGS=-O3 git-strbuf-grow' './git-strbuf-grow'
    Benchmark 1: ./git-strbuf-grow' in 'HEAD~1
      Time (mean ± σ):      2.661 s ±  0.025 s    [User: 2.657 s, System: 0.004 s]
      Range (min … max):    2.626 s …  2.713 s    10 runs

    Benchmark 2: ./git-strbuf-grow' in 'HEAD~0
      Time (mean ± σ):      2.875 s ±  0.031 s    [User: 2.871 s, System: 0.004 s]
      Range (min … max):    2.832 s …  2.948 s    10 runs

    Summary
      './git-strbuf-grow' in 'HEAD~1' ran
        1.08 ± 0.02 times faster than './git-strbuf-grow' in 'HEAD~0'

The slowdown is not overhead in Gnulib's intprops.h, but happens under
both GCC and Clang if we use __builtin_add_overflow() itself, so the
difference is in the infinite precision addition the compilers need to
do. We should probably not care and use them anyway, but let's just
narrowly fix the signed overflow issue for now.

1. c03c83152d6 (do not depend on signed integer overflow, 2010-10-05)
2. 1368f65002b (compat: helper for detecting unsigned overflow, 2010-10-10)
3. 320d0b493a2 (add helpers for detecting size_t overflow, 2016-02-19)
4. 935de81289c (add helpers for detecting size_t overflow, 2016-02-19)
5. e2ffeae3f67 (git-compat-util: introduce more size_t helpers, 2021-11-02)
6. https://lore.kernel.org/git/20160601210713.GA18118@sigill.intra.peff.net/
7. https://github.com/avar/git-hyperfine/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 compat/gnulib/.gitattributes |   1 +
 compat/gnulib/intprops.h     | 637 +++++++++++++++++++++++++++++++++++
 linear-assignment.c          |  11 +-
 3 files changed, 642 insertions(+), 7 deletions(-)
 create mode 100644 compat/gnulib/.gitattributes
 create mode 100644 compat/gnulib/intprops.h

diff --git a/compat/gnulib/.gitattributes b/compat/gnulib/.gitattributes
new file mode 100644
index 00000000000..4ea1db2cd88
--- /dev/null
+++ b/compat/gnulib/.gitattributes
@@ -0,0 +1 @@
+intprops.h whitespace=-indent-with-non-tab
diff --git a/compat/gnulib/intprops.h b/compat/gnulib/intprops.h
new file mode 100644
index 00000000000..20aa90ad2a5
--- /dev/null
+++ b/compat/gnulib/intprops.h
@@ -0,0 +1,637 @@
+/* intprops.h -- properties of integer types
+
+   Copyright (C) 2001-2021 Free Software Foundation, Inc.
+
+   This program is free software: you can redistribute it and/or modify it
+   under the terms of the GNU Lesser General Public License as published
+   by the Free Software Foundation; either version 2.1 of the License, or
+   (at your option) any later version.
+
+   This program is distributed in the hope that it will be useful,
+   but WITHOUT ANY WARRANTY; without even the implied warranty of
+   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+   GNU Lesser General Public License for more details.
+
+   You should have received a copy of the GNU Lesser General Public License
+   along with this program.  If not, see <https://www.gnu.org/licenses/>.  */
+
+
+#ifndef _GL_INTPROPS_H
+#define _GL_INTPROPS_H
+
+/* Return a value with the common real type of E and V and the value of V.
+   Do not evaluate E.  */
+#define _GL_INT_CONVERT(e, v) ((1 ? 0 : (e)) + (v))
+
+/* Act like _GL_INT_CONVERT (E, -V) but work around a bug in IRIX 6.5 cc; see
+   <https://lists.gnu.org/r/bug-gnulib/2011-05/msg00406.html>.  */
+#define _GL_INT_NEGATE_CONVERT(e, v) ((1 ? 0 : (e)) - (v))
+
+/* The extra casts in the following macros work around compiler bugs,
+   e.g., in Cray C 5.0.3.0.  */
+
+/* True if the arithmetic type T is an integer type.  bool counts as
+   an integer.  */
+#define TYPE_IS_INTEGER(t) ((t) 1.5 == 1)
+
+/* True if the real type T is signed.  */
+#define TYPE_SIGNED(t) (! ((t) 0 < (t) -1))
+
+/* Return 1 if the real expression E, after promotion, has a
+   signed or floating type.  Do not evaluate E.  */
+#define EXPR_SIGNED(e) (_GL_INT_NEGATE_CONVERT (e, 1) < 0)
+
+
+/* Minimum and maximum values for integer types and expressions.  */
+
+/* The width in bits of the integer type or expression T.
+   Do not evaluate T.  T must not be a bit-field expression.
+   Padding bits are not supported; this is checked at compile-time below.  */
+#define TYPE_WIDTH(t) (sizeof (t) * CHAR_BIT)
+
+/* The maximum and minimum values for the integer type T.  */
+#define TYPE_MINIMUM(t) ((t) ~ TYPE_MAXIMUM (t))
+#define TYPE_MAXIMUM(t)                                                 \
+  ((t) (! TYPE_SIGNED (t)                                               \
+        ? (t) -1                                                        \
+        : ((((t) 1 << (TYPE_WIDTH (t) - 2)) - 1) * 2 + 1)))
+
+/* The maximum and minimum values for the type of the expression E,
+   after integer promotion.  E is not evaluated.  */
+#define _GL_INT_MINIMUM(e)                                              \
+  (EXPR_SIGNED (e)                                                      \
+   ? ~ _GL_SIGNED_INT_MAXIMUM (e)                                       \
+   : _GL_INT_CONVERT (e, 0))
+#define _GL_INT_MAXIMUM(e)                                              \
+  (EXPR_SIGNED (e)                                                      \
+   ? _GL_SIGNED_INT_MAXIMUM (e)                                         \
+   : _GL_INT_NEGATE_CONVERT (e, 1))
+#define _GL_SIGNED_INT_MAXIMUM(e)                                       \
+  (((_GL_INT_CONVERT (e, 1) << (TYPE_WIDTH (+ (e)) - 2)) - 1) * 2 + 1)
+
+/* Work around OpenVMS incompatibility with C99.  */
+#if !defined LLONG_MAX && defined __INT64_MAX
+# define LLONG_MAX __INT64_MAX
+# define LLONG_MIN __INT64_MIN
+#endif
+
+/* This include file assumes that signed types are two's complement without
+   padding bits; the above macros have undefined behavior otherwise.
+   If this is a problem for you, please let us know how to fix it for your host.
+   This assumption is tested by the intprops-tests module.  */
+
+/* Does the __typeof__ keyword work?  This could be done by
+   'configure', but for now it's easier to do it by hand.  */
+#if (2 <= __GNUC__ \
+     || (4 <= __clang_major__) \
+     || (1210 <= __IBMC__ && defined __IBM__TYPEOF__) \
+     || (0x5110 <= __SUNPRO_C && !__STDC__))
+# define _GL_HAVE___TYPEOF__ 1
+#else
+# define _GL_HAVE___TYPEOF__ 0
+#endif
+
+/* Return 1 if the integer type or expression T might be signed.  Return 0
+   if it is definitely unsigned.  T must not be a bit-field expression.
+   This macro does not evaluate its argument, and expands to an
+   integer constant expression.  */
+#if _GL_HAVE___TYPEOF__
+# define _GL_SIGNED_TYPE_OR_EXPR(t) TYPE_SIGNED (__typeof__ (t))
+#else
+# define _GL_SIGNED_TYPE_OR_EXPR(t) 1
+#endif
+
+/* Bound on length of the string representing an unsigned integer
+   value representable in B bits.  log10 (2.0) < 146/485.  The
+   smallest value of B where this bound is not tight is 2621.  */
+#define INT_BITS_STRLEN_BOUND(b) (((b) * 146 + 484) / 485)
+
+/* Bound on length of the string representing an integer type or expression T.
+   T must not be a bit-field expression.
+
+   Subtract 1 for the sign bit if T is signed, and then add 1 more for
+   a minus sign if needed.
+
+   Because _GL_SIGNED_TYPE_OR_EXPR sometimes returns 1 when its argument is
+   unsigned, this macro may overestimate the true bound by one byte when
+   applied to unsigned types of size 2, 4, 16, ... bytes.  */
+#define INT_STRLEN_BOUND(t)                                     \
+  (INT_BITS_STRLEN_BOUND (TYPE_WIDTH (t) - _GL_SIGNED_TYPE_OR_EXPR (t)) \
+   + _GL_SIGNED_TYPE_OR_EXPR (t))
+
+/* Bound on buffer size needed to represent an integer type or expression T,
+   including the terminating null.  T must not be a bit-field expression.  */
+#define INT_BUFSIZE_BOUND(t) (INT_STRLEN_BOUND (t) + 1)
+
+
+/* Range overflow checks.
+
+   The INT_<op>_RANGE_OVERFLOW macros return 1 if the corresponding C
+   operators might not yield numerically correct answers due to
+   arithmetic overflow.  They do not rely on undefined or
+   implementation-defined behavior.  Their implementations are simple
+   and straightforward, but they are harder to use and may be less
+   efficient than the INT_<op>_WRAPV, INT_<op>_OK, and
+   INT_<op>_OVERFLOW macros described below.
+
+   Example usage:
+
+     long int i = ...;
+     long int j = ...;
+     if (INT_MULTIPLY_RANGE_OVERFLOW (i, j, LONG_MIN, LONG_MAX))
+       printf ("multiply would overflow");
+     else
+       printf ("product is %ld", i * j);
+
+   Restrictions on *_RANGE_OVERFLOW macros:
+
+   These macros do not check for all possible numerical problems or
+   undefined or unspecified behavior: they do not check for division
+   by zero, for bad shift counts, or for shifting negative numbers.
+
+   These macros may evaluate their arguments zero or multiple times,
+   so the arguments should not have side effects.  The arithmetic
+   arguments (including the MIN and MAX arguments) must be of the same
+   integer type after the usual arithmetic conversions, and the type
+   must have minimum value MIN and maximum MAX.  Unsigned types should
+   use a zero MIN of the proper type.
+
+   Because all arguments are subject to integer promotions, these
+   macros typically do not work on types narrower than 'int'.
+
+   These macros are tuned for constant MIN and MAX.  For commutative
+   operations such as A + B, they are also tuned for constant B.  */
+
+/* Return 1 if A + B would overflow in [MIN,MAX] arithmetic.
+   See above for restrictions.  */
+#define INT_ADD_RANGE_OVERFLOW(a, b, min, max)          \
+  ((b) < 0                                              \
+   ? (a) < (min) - (b)                                  \
+   : (max) - (b) < (a))
+
+/* Return 1 if A - B would overflow in [MIN,MAX] arithmetic.
+   See above for restrictions.  */
+#define INT_SUBTRACT_RANGE_OVERFLOW(a, b, min, max)     \
+  ((b) < 0                                              \
+   ? (max) + (b) < (a)                                  \
+   : (a) < (min) + (b))
+
+/* Return 1 if - A would overflow in [MIN,MAX] arithmetic.
+   See above for restrictions.  */
+#define INT_NEGATE_RANGE_OVERFLOW(a, min, max)          \
+  ((min) < 0                                            \
+   ? (a) < - (max)                                      \
+   : 0 < (a))
+
+/* Return 1 if A * B would overflow in [MIN,MAX] arithmetic.
+   See above for restrictions.  Avoid && and || as they tickle
+   bugs in Sun C 5.11 2010/08/13 and other compilers; see
+   <https://lists.gnu.org/r/bug-gnulib/2011-05/msg00401.html>.  */
+#define INT_MULTIPLY_RANGE_OVERFLOW(a, b, min, max)     \
+  ((b) < 0                                              \
+   ? ((a) < 0                                           \
+      ? (a) < (max) / (b)                               \
+      : (b) == -1                                       \
+      ? 0                                               \
+      : (min) / (b) < (a))                              \
+   : (b) == 0                                           \
+   ? 0                                                  \
+   : ((a) < 0                                           \
+      ? (a) < (min) / (b)                               \
+      : (max) / (b) < (a)))
+
+/* Return 1 if A / B would overflow in [MIN,MAX] arithmetic.
+   See above for restrictions.  Do not check for division by zero.  */
+#define INT_DIVIDE_RANGE_OVERFLOW(a, b, min, max)       \
+  ((min) < 0 && (b) == -1 && (a) < - (max))
+
+/* Return 1 if A % B would overflow in [MIN,MAX] arithmetic.
+   See above for restrictions.  Do not check for division by zero.
+   Mathematically, % should never overflow, but on x86-like hosts
+   INT_MIN % -1 traps, and the C standard permits this, so treat this
+   as an overflow too.  */
+#define INT_REMAINDER_RANGE_OVERFLOW(a, b, min, max)    \
+  INT_DIVIDE_RANGE_OVERFLOW (a, b, min, max)
+
+/* Return 1 if A << B would overflow in [MIN,MAX] arithmetic.
+   See above for restrictions.  Here, MIN and MAX are for A only, and B need
+   not be of the same type as the other arguments.  The C standard says that
+   behavior is undefined for shifts unless 0 <= B < wordwidth, and that when
+   A is negative then A << B has undefined behavior and A >> B has
+   implementation-defined behavior, but do not check these other
+   restrictions.  */
+#define INT_LEFT_SHIFT_RANGE_OVERFLOW(a, b, min, max)   \
+  ((a) < 0                                              \
+   ? (a) < (min) >> (b)                                 \
+   : (max) >> (b) < (a))
+
+/* True if __builtin_add_overflow (A, B, P) and __builtin_sub_overflow
+   (A, B, P) work when P is non-null.  */
+/* __builtin_{add,sub}_overflow exists but is not reliable in GCC 5.x and 6.x,
+   see <https://gcc.gnu.org/bugzilla/show_bug.cgi?id=98269>.  */
+#if 7 <= __GNUC__ && !defined __ICC
+# define _GL_HAS_BUILTIN_ADD_OVERFLOW 1
+#elif defined __has_builtin
+# define _GL_HAS_BUILTIN_ADD_OVERFLOW __has_builtin (__builtin_add_overflow)
+#else
+# define _GL_HAS_BUILTIN_ADD_OVERFLOW 0
+#endif
+
+/* True if __builtin_mul_overflow (A, B, P) works when P is non-null.  */
+#ifdef __clang__
+/* Work around Clang bug <https://bugs.llvm.org/show_bug.cgi?id=16404>.  */
+# define _GL_HAS_BUILTIN_MUL_OVERFLOW 0
+#else
+# define _GL_HAS_BUILTIN_MUL_OVERFLOW _GL_HAS_BUILTIN_ADD_OVERFLOW
+#endif
+
+/* True if __builtin_add_overflow_p (A, B, C) works, and similarly for
+   __builtin_sub_overflow_p and __builtin_mul_overflow_p.  */
+#if defined __clang__ || defined __ICC
+/* Clang 11 lacks __builtin_mul_overflow_p, and even if it did it
+   would presumably run afoul of Clang bug 16404.  ICC 2021.1's
+   __builtin_add_overflow_p etc. are not treated as integral constant
+   expressions even when all arguments are.  */
+# define _GL_HAS_BUILTIN_OVERFLOW_P 0
+#elif defined __has_builtin
+# define _GL_HAS_BUILTIN_OVERFLOW_P __has_builtin (__builtin_mul_overflow_p)
+#else
+# define _GL_HAS_BUILTIN_OVERFLOW_P (7 <= __GNUC__)
+#endif
+
+/* The _GL*_OVERFLOW macros have the same restrictions as the
+   *_RANGE_OVERFLOW macros, except that they do not assume that operands
+   (e.g., A and B) have the same type as MIN and MAX.  Instead, they assume
+   that the result (e.g., A + B) has that type.  */
+#if _GL_HAS_BUILTIN_OVERFLOW_P
+# define _GL_ADD_OVERFLOW(a, b, min, max)                               \
+   __builtin_add_overflow_p (a, b, (__typeof__ ((a) + (b))) 0)
+# define _GL_SUBTRACT_OVERFLOW(a, b, min, max)                          \
+   __builtin_sub_overflow_p (a, b, (__typeof__ ((a) - (b))) 0)
+# define _GL_MULTIPLY_OVERFLOW(a, b, min, max)                          \
+   __builtin_mul_overflow_p (a, b, (__typeof__ ((a) * (b))) 0)
+#else
+# define _GL_ADD_OVERFLOW(a, b, min, max)                                \
+   ((min) < 0 ? INT_ADD_RANGE_OVERFLOW (a, b, min, max)                  \
+    : (a) < 0 ? (b) <= (a) + (b)                                         \
+    : (b) < 0 ? (a) <= (a) + (b)                                         \
+    : (a) + (b) < (b))
+# define _GL_SUBTRACT_OVERFLOW(a, b, min, max)                           \
+   ((min) < 0 ? INT_SUBTRACT_RANGE_OVERFLOW (a, b, min, max)             \
+    : (a) < 0 ? 1                                                        \
+    : (b) < 0 ? (a) - (b) <= (a)                                         \
+    : (a) < (b))
+# define _GL_MULTIPLY_OVERFLOW(a, b, min, max)                           \
+   (((min) == 0 && (((a) < 0 && 0 < (b)) || ((b) < 0 && 0 < (a))))       \
+    || INT_MULTIPLY_RANGE_OVERFLOW (a, b, min, max))
+#endif
+#define _GL_DIVIDE_OVERFLOW(a, b, min, max)                             \
+  ((min) < 0 ? (b) == _GL_INT_NEGATE_CONVERT (min, 1) && (a) < - (max)  \
+   : (a) < 0 ? (b) <= (a) + (b) - 1                                     \
+   : (b) < 0 && (a) + (b) <= (a))
+#define _GL_REMAINDER_OVERFLOW(a, b, min, max)                          \
+  ((min) < 0 ? (b) == _GL_INT_NEGATE_CONVERT (min, 1) && (a) < - (max)  \
+   : (a) < 0 ? (a) % (b) != ((max) - (b) + 1) % (b)                     \
+   : (b) < 0 && ! _GL_UNSIGNED_NEG_MULTIPLE (a, b, max))
+
+/* Return a nonzero value if A is a mathematical multiple of B, where
+   A is unsigned, B is negative, and MAX is the maximum value of A's
+   type.  A's type must be the same as (A % B)'s type.  Normally (A %
+   -B == 0) suffices, but things get tricky if -B would overflow.  */
+#define _GL_UNSIGNED_NEG_MULTIPLE(a, b, max)                            \
+  (((b) < -_GL_SIGNED_INT_MAXIMUM (b)                                   \
+    ? (_GL_SIGNED_INT_MAXIMUM (b) == (max)                              \
+       ? (a)                                                            \
+       : (a) % (_GL_INT_CONVERT (a, _GL_SIGNED_INT_MAXIMUM (b)) + 1))   \
+    : (a) % - (b))                                                      \
+   == 0)
+
+/* Check for integer overflow, and report low order bits of answer.
+
+   The INT_<op>_OVERFLOW macros return 1 if the corresponding C operators
+   might not yield numerically correct answers due to arithmetic overflow.
+   The INT_<op>_WRAPV macros compute the low-order bits of the sum,
+   difference, and product of two C integers, and return 1 if these
+   low-order bits are not numerically correct.
+   These macros work correctly on all known practical hosts, and do not rely
+   on undefined behavior due to signed arithmetic overflow.
+
+   Example usage, assuming A and B are long int:
+
+     if (INT_MULTIPLY_OVERFLOW (a, b))
+       printf ("result would overflow\n");
+     else
+       printf ("result is %ld (no overflow)\n", a * b);
+
+   Example usage with WRAPV flavor:
+
+     long int result;
+     bool overflow = INT_MULTIPLY_WRAPV (a, b, &result);
+     printf ("result is %ld (%s)\n", result,
+             overflow ? "after overflow" : "no overflow");
+
+   Restrictions on these macros:
+
+   These macros do not check for all possible numerical problems or
+   undefined or unspecified behavior: they do not check for division
+   by zero, for bad shift counts, or for shifting negative numbers.
+
+   These macros may evaluate their arguments zero or multiple times, so the
+   arguments should not have side effects.
+
+   The WRAPV macros are not constant expressions.  They support only
+   +, binary -, and *.
+
+   Because the WRAPV macros convert the result, they report overflow
+   in different circumstances than the OVERFLOW macros do.  For
+   example, in the typical case with 16-bit 'short' and 32-bit 'int',
+   if A, B and R are all of type 'short' then INT_ADD_OVERFLOW (A, B)
+   returns false because the addition cannot overflow after A and B
+   are converted to 'int', whereas INT_ADD_WRAPV (A, B, &R) returns
+   true or false depending on whether the sum fits into 'short'.
+
+   These macros are tuned for their last input argument being a constant.
+
+   Return 1 if the integer expressions A * B, A - B, -A, A * B, A / B,
+   A % B, and A << B would overflow, respectively.  */
+
+#define INT_ADD_OVERFLOW(a, b) \
+  _GL_BINARY_OP_OVERFLOW (a, b, _GL_ADD_OVERFLOW)
+#define INT_SUBTRACT_OVERFLOW(a, b) \
+  _GL_BINARY_OP_OVERFLOW (a, b, _GL_SUBTRACT_OVERFLOW)
+#if _GL_HAS_BUILTIN_OVERFLOW_P
+# define INT_NEGATE_OVERFLOW(a) INT_SUBTRACT_OVERFLOW (0, a)
+#else
+# define INT_NEGATE_OVERFLOW(a) \
+   INT_NEGATE_RANGE_OVERFLOW (a, _GL_INT_MINIMUM (a), _GL_INT_MAXIMUM (a))
+#endif
+#define INT_MULTIPLY_OVERFLOW(a, b) \
+  _GL_BINARY_OP_OVERFLOW (a, b, _GL_MULTIPLY_OVERFLOW)
+#define INT_DIVIDE_OVERFLOW(a, b) \
+  _GL_BINARY_OP_OVERFLOW (a, b, _GL_DIVIDE_OVERFLOW)
+#define INT_REMAINDER_OVERFLOW(a, b) \
+  _GL_BINARY_OP_OVERFLOW (a, b, _GL_REMAINDER_OVERFLOW)
+#define INT_LEFT_SHIFT_OVERFLOW(a, b) \
+  INT_LEFT_SHIFT_RANGE_OVERFLOW (a, b, \
+                                 _GL_INT_MINIMUM (a), _GL_INT_MAXIMUM (a))
+
+/* Return 1 if the expression A <op> B would overflow,
+   where OP_RESULT_OVERFLOW (A, B, MIN, MAX) does the actual test,
+   assuming MIN and MAX are the minimum and maximum for the result type.
+   Arguments should be free of side effects.  */
+#define _GL_BINARY_OP_OVERFLOW(a, b, op_result_overflow)        \
+  op_result_overflow (a, b,                                     \
+                      _GL_INT_MINIMUM (_GL_INT_CONVERT (a, b)), \
+                      _GL_INT_MAXIMUM (_GL_INT_CONVERT (a, b)))
+
+/* Store the low-order bits of A + B, A - B, A * B, respectively, into *R.
+   Return 1 if the result overflows.  See above for restrictions.  */
+#if _GL_HAS_BUILTIN_ADD_OVERFLOW
+# define INT_ADD_WRAPV(a, b, r) __builtin_add_overflow (a, b, r)
+# define INT_SUBTRACT_WRAPV(a, b, r) __builtin_sub_overflow (a, b, r)
+#else
+# define INT_ADD_WRAPV(a, b, r) \
+   _GL_INT_OP_WRAPV (a, b, r, +, _GL_INT_ADD_RANGE_OVERFLOW)
+# define INT_SUBTRACT_WRAPV(a, b, r) \
+   _GL_INT_OP_WRAPV (a, b, r, -, _GL_INT_SUBTRACT_RANGE_OVERFLOW)
+#endif
+#if _GL_HAS_BUILTIN_MUL_OVERFLOW
+# if ((9 < __GNUC__ + (3 <= __GNUC_MINOR__) \
+       || (__GNUC__ == 8 && 4 <= __GNUC_MINOR__)) \
+      && !defined __ICC)
+#  define INT_MULTIPLY_WRAPV(a, b, r) __builtin_mul_overflow (a, b, r)
+# else
+   /* Work around GCC bug 91450.  */
+#  define INT_MULTIPLY_WRAPV(a, b, r) \
+    ((!_GL_SIGNED_TYPE_OR_EXPR (*(r)) && EXPR_SIGNED (a) && EXPR_SIGNED (b) \
+      && _GL_INT_MULTIPLY_RANGE_OVERFLOW (a, b, 0, (__typeof__ (*(r))) -1)) \
+     ? ((void) __builtin_mul_overflow (a, b, r), 1) \
+     : __builtin_mul_overflow (a, b, r))
+# endif
+#else
+# define INT_MULTIPLY_WRAPV(a, b, r) \
+   _GL_INT_OP_WRAPV (a, b, r, *, _GL_INT_MULTIPLY_RANGE_OVERFLOW)
+#endif
+
+/* Nonzero if this compiler has GCC bug 68193 or Clang bug 25390.  See:
+   https://gcc.gnu.org/bugzilla/show_bug.cgi?id=68193
+   https://llvm.org/bugs/show_bug.cgi?id=25390
+   For now, assume all versions of GCC-like compilers generate bogus
+   warnings for _Generic.  This matters only for compilers that
+   lack relevant builtins.  */
+#if __GNUC__ || defined __clang__
+# define _GL__GENERIC_BOGUS 1
+#else
+# define _GL__GENERIC_BOGUS 0
+#endif
+
+/* Store the low-order bits of A <op> B into *R, where OP specifies
+   the operation and OVERFLOW the overflow predicate.  Return 1 if the
+   result overflows.  See above for restrictions.  */
+#if 201112 <= __STDC_VERSION__ && !_GL__GENERIC_BOGUS
+# define _GL_INT_OP_WRAPV(a, b, r, op, overflow) \
+   (_Generic \
+    (*(r), \
+     signed char: \
+       _GL_INT_OP_CALC (a, b, r, op, overflow, unsigned int, \
+                        signed char, SCHAR_MIN, SCHAR_MAX), \
+     unsigned char: \
+       _GL_INT_OP_CALC (a, b, r, op, overflow, unsigned int, \
+                        unsigned char, 0, UCHAR_MAX), \
+     short int: \
+       _GL_INT_OP_CALC (a, b, r, op, overflow, unsigned int, \
+                        short int, SHRT_MIN, SHRT_MAX), \
+     unsigned short int: \
+       _GL_INT_OP_CALC (a, b, r, op, overflow, unsigned int, \
+                        unsigned short int, 0, USHRT_MAX), \
+     int: \
+       _GL_INT_OP_CALC (a, b, r, op, overflow, unsigned int, \
+                        int, INT_MIN, INT_MAX), \
+     unsigned int: \
+       _GL_INT_OP_CALC (a, b, r, op, overflow, unsigned int, \
+                        unsigned int, 0, UINT_MAX), \
+     long int: \
+       _GL_INT_OP_CALC (a, b, r, op, overflow, unsigned long int, \
+                        long int, LONG_MIN, LONG_MAX), \
+     unsigned long int: \
+       _GL_INT_OP_CALC (a, b, r, op, overflow, unsigned long int, \
+                        unsigned long int, 0, ULONG_MAX), \
+     long long int: \
+       _GL_INT_OP_CALC (a, b, r, op, overflow, unsigned long long int, \
+                        long long int, LLONG_MIN, LLONG_MAX), \
+     unsigned long long int: \
+       _GL_INT_OP_CALC (a, b, r, op, overflow, unsigned long long int, \
+                        unsigned long long int, 0, ULLONG_MAX)))
+#else
+/* Store the low-order bits of A <op> B into *R, where OP specifies
+   the operation and OVERFLOW the overflow predicate.  If *R is
+   signed, its type is ST with bounds SMIN..SMAX; otherwise its type
+   is UT with bounds U..UMAX.  ST and UT are narrower than int.
+   Return 1 if the result overflows.  See above for restrictions.  */
+# if _GL_HAVE___TYPEOF__
+#  define _GL_INT_OP_WRAPV_SMALLISH(a,b,r,op,overflow,st,smin,smax,ut,umax) \
+    (TYPE_SIGNED (__typeof__ (*(r))) \
+     ? _GL_INT_OP_CALC (a, b, r, op, overflow, unsigned int, st, smin, smax) \
+     : _GL_INT_OP_CALC (a, b, r, op, overflow, unsigned int, ut, 0, umax))
+# else
+#  define _GL_INT_OP_WRAPV_SMALLISH(a,b,r,op,overflow,st,smin,smax,ut,umax) \
+    (overflow (a, b, smin, smax) \
+     ? (overflow (a, b, 0, umax) \
+        ? (*(r) = _GL_INT_OP_WRAPV_VIA_UNSIGNED (a,b,op,unsigned,st), 1) \
+        : (*(r) = _GL_INT_OP_WRAPV_VIA_UNSIGNED (a,b,op,unsigned,st)) < 0) \
+     : (overflow (a, b, 0, umax) \
+        ? (*(r) = _GL_INT_OP_WRAPV_VIA_UNSIGNED (a,b,op,unsigned,st)) >= 0 \
+        : (*(r) = _GL_INT_OP_WRAPV_VIA_UNSIGNED (a,b,op,unsigned,st), 0)))
+# endif
+
+# define _GL_INT_OP_WRAPV(a, b, r, op, overflow) \
+   (sizeof *(r) == sizeof (signed char) \
+    ? _GL_INT_OP_WRAPV_SMALLISH (a, b, r, op, overflow, \
+                                 signed char, SCHAR_MIN, SCHAR_MAX, \
+                                 unsigned char, UCHAR_MAX) \
+    : sizeof *(r) == sizeof (short int) \
+    ? _GL_INT_OP_WRAPV_SMALLISH (a, b, r, op, overflow, \
+                                 short int, SHRT_MIN, SHRT_MAX, \
+                                 unsigned short int, USHRT_MAX) \
+    : sizeof *(r) == sizeof (int) \
+    ? (EXPR_SIGNED (*(r)) \
+       ? _GL_INT_OP_CALC (a, b, r, op, overflow, unsigned int, \
+                          int, INT_MIN, INT_MAX) \
+       : _GL_INT_OP_CALC (a, b, r, op, overflow, unsigned int, \
+                          unsigned int, 0, UINT_MAX)) \
+    : _GL_INT_OP_WRAPV_LONGISH(a, b, r, op, overflow))
+# ifdef LLONG_MAX
+#  define _GL_INT_OP_WRAPV_LONGISH(a, b, r, op, overflow) \
+    (sizeof *(r) == sizeof (long int) \
+     ? (EXPR_SIGNED (*(r)) \
+        ? _GL_INT_OP_CALC (a, b, r, op, overflow, unsigned long int, \
+                           long int, LONG_MIN, LONG_MAX) \
+        : _GL_INT_OP_CALC (a, b, r, op, overflow, unsigned long int, \
+                           unsigned long int, 0, ULONG_MAX)) \
+     : (EXPR_SIGNED (*(r)) \
+        ? _GL_INT_OP_CALC (a, b, r, op, overflow, unsigned long long int, \
+                           long long int, LLONG_MIN, LLONG_MAX) \
+        : _GL_INT_OP_CALC (a, b, r, op, overflow, unsigned long long int, \
+                           unsigned long long int, 0, ULLONG_MAX)))
+# else
+#  define _GL_INT_OP_WRAPV_LONGISH(a, b, r, op, overflow) \
+    (EXPR_SIGNED (*(r)) \
+     ? _GL_INT_OP_CALC (a, b, r, op, overflow, unsigned long int, \
+                        long int, LONG_MIN, LONG_MAX) \
+     : _GL_INT_OP_CALC (a, b, r, op, overflow, unsigned long int, \
+                        unsigned long int, 0, ULONG_MAX))
+# endif
+#endif
+
+/* Store the low-order bits of A <op> B into *R, where the operation
+   is given by OP.  Use the unsigned type UT for calculation to avoid
+   overflow problems.  *R's type is T, with extrema TMIN and TMAX.
+   T must be a signed integer type.  Return 1 if the result overflows.  */
+#define _GL_INT_OP_CALC(a, b, r, op, overflow, ut, t, tmin, tmax) \
+  (overflow (a, b, tmin, tmax) \
+   ? (*(r) = _GL_INT_OP_WRAPV_VIA_UNSIGNED (a, b, op, ut, t), 1) \
+   : (*(r) = _GL_INT_OP_WRAPV_VIA_UNSIGNED (a, b, op, ut, t), 0))
+
+/* Return the low-order bits of A <op> B, where the operation is given
+   by OP.  Use the unsigned type UT for calculation to avoid undefined
+   behavior on signed integer overflow, and convert the result to type T.
+   UT is at least as wide as T and is no narrower than unsigned int,
+   T is two's complement, and there is no padding or trap representations.
+   Assume that converting UT to T yields the low-order bits, as is
+   done in all known two's-complement C compilers.  E.g., see:
+   https://gcc.gnu.org/onlinedocs/gcc/Integers-implementation.html
+
+   According to the C standard, converting UT to T yields an
+   implementation-defined result or signal for values outside T's
+   range.  However, code that works around this theoretical problem
+   runs afoul of a compiler bug in Oracle Studio 12.3 x86.  See:
+   https://lists.gnu.org/r/bug-gnulib/2017-04/msg00049.html
+   As the compiler bug is real, don't try to work around the
+   theoretical problem.  */
+
+#define _GL_INT_OP_WRAPV_VIA_UNSIGNED(a, b, op, ut, t) \
+  ((t) ((ut) (a) op (ut) (b)))
+
+/* Return true if the numeric values A + B, A - B, A * B fall outside
+   the range TMIN..TMAX.  Arguments should be integer expressions
+   without side effects.  TMIN should be signed and nonpositive.
+   TMAX should be positive, and should be signed unless TMIN is zero.  */
+#define _GL_INT_ADD_RANGE_OVERFLOW(a, b, tmin, tmax) \
+  ((b) < 0 \
+   ? (((tmin) \
+       ? ((EXPR_SIGNED (_GL_INT_CONVERT (a, (tmin) - (b))) || (b) < (tmin)) \
+          && (a) < (tmin) - (b)) \
+       : (a) <= -1 - (b)) \
+      || ((EXPR_SIGNED (a) ? 0 <= (a) : (tmax) < (a)) && (tmax) < (a) + (b))) \
+   : (a) < 0 \
+   ? (((tmin) \
+       ? ((EXPR_SIGNED (_GL_INT_CONVERT (b, (tmin) - (a))) || (a) < (tmin)) \
+          && (b) < (tmin) - (a)) \
+       : (b) <= -1 - (a)) \
+      || ((EXPR_SIGNED (_GL_INT_CONVERT (a, b)) || (tmax) < (b)) \
+          && (tmax) < (a) + (b))) \
+   : (tmax) < (b) || (tmax) - (b) < (a))
+#define _GL_INT_SUBTRACT_RANGE_OVERFLOW(a, b, tmin, tmax) \
+  (((a) < 0) == ((b) < 0) \
+   ? ((a) < (b) \
+      ? !(tmin) || -1 - (tmin) < (b) - (a) - 1 \
+      : (tmax) < (a) - (b)) \
+   : (a) < 0 \
+   ? ((!EXPR_SIGNED (_GL_INT_CONVERT ((a) - (tmin), b)) && (a) - (tmin) < 0) \
+      || (a) - (tmin) < (b)) \
+   : ((! (EXPR_SIGNED (_GL_INT_CONVERT (tmax, b)) \
+          && EXPR_SIGNED (_GL_INT_CONVERT ((tmax) + (b), a))) \
+       && (tmax) <= -1 - (b)) \
+      || (tmax) + (b) < (a)))
+#define _GL_INT_MULTIPLY_RANGE_OVERFLOW(a, b, tmin, tmax) \
+  ((b) < 0 \
+   ? ((a) < 0 \
+      ? (EXPR_SIGNED (_GL_INT_CONVERT (tmax, b)) \
+         ? (a) < (tmax) / (b) \
+         : ((INT_NEGATE_OVERFLOW (b) \
+             ? _GL_INT_CONVERT (b, tmax) >> (TYPE_WIDTH (+ (b)) - 1) \
+             : (tmax) / -(b)) \
+            <= -1 - (a))) \
+      : INT_NEGATE_OVERFLOW (_GL_INT_CONVERT (b, tmin)) && (b) == -1 \
+      ? (EXPR_SIGNED (a) \
+         ? 0 < (a) + (tmin) \
+         : 0 < (a) && -1 - (tmin) < (a) - 1) \
+      : (tmin) / (b) < (a)) \
+   : (b) == 0 \
+   ? 0 \
+   : ((a) < 0 \
+      ? (INT_NEGATE_OVERFLOW (_GL_INT_CONVERT (a, tmin)) && (a) == -1 \
+         ? (EXPR_SIGNED (b) ? 0 < (b) + (tmin) : -1 - (tmin) < (b) - 1) \
+         : (tmin) / (a) < (b)) \
+      : (tmax) / (b) < (a)))
+
+/* The following macros compute A + B, A - B, and A * B, respectively.
+   If no overflow occurs, they set *R to the result and return 1;
+   otherwise, they return 0 and may modify *R.
+
+   Example usage:
+
+     long int result;
+     if (INT_ADD_OK (a, b, &result))
+       printf ("result is %ld\n", result);
+     else
+       printf ("overflow\n");
+
+   A, B, and *R should be integers; they need not be the same type,
+   and they need not be all signed or all unsigned.
+
+   These macros work correctly on all known practical hosts, and do not rely
+   on undefined behavior due to signed arithmetic overflow.
+
+   These macros are not constant expressions.
+
+   These macros may evaluate their arguments zero or multiple times, so the
+   arguments should not have side effects.
+
+   These macros are tuned for B being a constant.  */
+
+#define INT_ADD_OK(a, b, r) ! INT_ADD_WRAPV (a, b, r)
+#define INT_SUBTRACT_OK(a, b, r) ! INT_SUBTRACT_WRAPV (a, b, r)
+#define INT_MULTIPLY_OK(a, b, r) ! INT_MULTIPLY_WRAPV (a, b, r)
+
+#endif /* _GL_INTPROPS_H */
diff --git a/linear-assignment.c b/linear-assignment.c
index b6597b622c8..e45099d651a 100644
--- a/linear-assignment.c
+++ b/linear-assignment.c
@@ -5,19 +5,16 @@
  */
 #include "cache.h"
 #include "linear-assignment.h"
+#include "compat/gnulib/intprops.h"
 
 static inline int cost_index(int *cost, int a, int b, int c)
 {
 	int r;
 
-#if defined(__GNUC__) || defined(__clang__)
-	if (__builtin_mul_overflow(a, c, &r))
-		die(_("integer overflow in cost[%d + %d * %c] multiplication"), b, a, c);
-	if (__builtin_add_overflow(b, r, &r))
+	if (INT_MULTIPLY_WRAPV(a, c, &r))
+		die(_("integer overflow in cost[%d + %d * %d] multiplication"), b, a, c);
+	if (INT_ADD_WRAPV(b, r, &r))
 		die(_("integer overflow in cost[%d + ((%d * %d) = %d)] addition"), b, a, c, r);
-#else
-	r = b + a * c;
-#endif
 
 	return r;
 }
-- 
2.34.1.930.g0f9292b224d

