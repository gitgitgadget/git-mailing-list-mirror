Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30737C433EF
	for <git@archiver.kernel.org>; Thu, 20 Jan 2022 01:16:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241537AbiATBQM (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Jan 2022 20:16:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231224AbiATBQM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Jan 2022 20:16:12 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A1B2C061574
        for <git@vger.kernel.org>; Wed, 19 Jan 2022 17:16:11 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id ay14-20020a05600c1e0e00b0034d7bef1b5dso11622906wmb.3
        for <git@vger.kernel.org>; Wed, 19 Jan 2022 17:16:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=clRVa1OFyxbMGAJSs8rJ9xW0oLbnAM5qdUPl6z5+Y1k=;
        b=NK+LzohiV0i8FXn80Wo0yyguvGxxLMR19dn0Wv+3x2a4Oy3+GxVrNHZaSdYCRMu+uy
         QaEuOKTWwauiANWSAcQUo83yuWrYid2HZXS5LpIn+v7XbQxMTQ9bSJyTyDIFA2/+66vU
         XRD6KSh+faCdjQRu/kB0zeGzmKXJlj1SB3rjvxiOYMYSzGhf8Ic1cpsvUB8d5RngV7eh
         NTGhPUcKHqPinqwDtB1RnRbcKqdOz2l7A9zaNo1VqLd4fVP/89fdFZ2ZZcq8eqhKKX/I
         qYWae2lKLxDUA91Er9M204GCH2uBPcfANmXL9iKcSxOWB+qTQSjTH8dSZqwG6IMvJ0XY
         BsEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=clRVa1OFyxbMGAJSs8rJ9xW0oLbnAM5qdUPl6z5+Y1k=;
        b=QpTqjZGn+HeAg2b2sdXRhJUCx8e0rc5FVQ+3X7BMyB/SSqDUkPnDAYtrkh4GuEeSFd
         HYL7S6jZ3qES5tmSqrKaGZHvX7dmqy0erGFqptmUSc4xBKfpTGleSV+DJHwOYPQLIbAc
         jr+g33RrK6kBuvvz1Hcw3GRIx7fL4LD66f36TQafLWR5sBvcO+RqtP5iJRUoXBjT/2K2
         1HVza9MK5lONgfFMLSyVkgmc0zJqjWgz7PZJydv8XlidpAcOVEZLbl9j7L/Er7bT1yoU
         j17s25+nYgED+lOdhhEKCKL0CLH+5U4IVOmgjr2x+Y/yBvoL3HmvpWNMUhIqEIw/sV11
         Ph5A==
X-Gm-Message-State: AOAM532TKokpkDDRpqhCt/0ozHXTjA2Co+ScCSYfPPG3WsvlkUQigx4y
        snbvOO5+xmQUD6adbohg0zFXxgv6APlFdQ==
X-Google-Smtp-Source: ABdhPJzqeV/Ana33ShsUOUtbW4qy2yihCbVi4jA2iK1P2xatx4/GJEb83BXMEV7/ScZmc1FPON/0Fw==
X-Received: by 2002:a05:600c:5125:: with SMTP id o37mr6343849wms.161.1642641369523;
        Wed, 19 Jan 2022 17:16:09 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i8sm1161637wmq.23.2022.01.19.17.16.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jan 2022 17:16:08 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        David Aguilar <davvid@gmail.com>,
        "Randall S . Becker" <randall.becker@nexbridge.ca>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3] cache.h: auto-detect if zlib has uncompress2()
Date:   Thu, 20 Jan 2022 02:16:03 +0100
Message-Id: <patch-v3-1.1-e9cb8763fd4-20220120T011414Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.0.rc1.864.g57621b115b6
In-Reply-To: <patch-v2-1.1-444eacf30be-20220119T094428Z-avarab@gmail.com>
References: <patch-v2-1.1-444eacf30be-20220119T094428Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove the NO_UNCOMPRESS2=Y setting added in a322920d0bb (Provide
zlib's uncompress2 from compat/zlib-compat.c, 2021-10-07) and its
configure probe in favor of auto-detecting if we need to provide a
fallback uncompress2().

This makes the compilation of git less annoying on older systems.
Since that a322920d0bb in included in v2.35.0-rc0 we've started
requiring a zlib version 1.2.9 or later. Those compiling on older
versions needed to specify NO_UNCOMPRESS2=Y. That resulted in new
errors when git was compiled on older systems, requiring the packager
to define NO_UNCOMPRESS2=Y.

Let's instead add a compat/zlib-uncompress.o object which'll define
uncompress2() if the ZLIB_VERNUM indicates that libz doesn't have
it. The approach taken here requires some juggling of *.o lists in the
Makefile. It would be simpler to e.g. include this code
unconditionally in our own zlib.c, but per [1] this approach preserves
the compat/* object divide.

Because the code in reftable/* needs this, and we compile an
intermediate reftable.a we'll need a new $(ZLIB_COMPAT_OBJS) list. We
add it to $(LIB_OBJS) (currently redundant, but means using
uncompress2() elsewhere will work), as well as compiling the
$(REFTABLE_LIB) with $(ZLIB_COMPAT_OBJS).

We can then remove the NO_UNCOMPRESS2 setting, and the NO_UNCOMPRESS2
settings in config.mak.uname added in a322920d0bb, and then
subsequently in 68d1da41c4e (build: NonStop ships with an older zlib,
2022-01-10) and ffb9f298090 (build: centos/RHEL 7 ships with an older
gcc and zlib, 2022-01-15).

Since the prototype of uncompress2() lives in git-compat-util.h we'll
need to include zlib.h there. We can then remove the inclusion of
zlib.h from cache,h, since it includes git-compat-util.h. The
inclusion of zlib.h in cache.h dates back to e83c5163316 (Initial
revision of "git", the information manager from hell, 2005-04-07).

1. https://lore.kernel.org/git/xmqq1r13o7rf.fsf@gitster.g/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---

A v3 addressing the points Junio raised in
https://lore.kernel.org/git/xmqq1r13o7rf.fsf@gitster.g/.

As noted in the updated commit message this approach of having an
object just for this fallback function comes at the cost of some
complexity, but now the compat object lives neatly in its own object.

I didn't run into the "We probably need to include a throw-away global
symbol[...]" issue Junio noted when testing this.

Range-diff against v2:
1:  444eacf30be ! 1:  e9cb8763fd4 cache.h: auto-detect if zlib has uncompress2()
    @@ Metadata
      ## Commit message ##
         cache.h: auto-detect if zlib has uncompress2()
     
    -    Change the NO_UNCOMPRESS2=Y setting to auto-detect those older zlib
    -    versions that don't have uncompress2().
    +    Remove the NO_UNCOMPRESS2=Y setting added in a322920d0bb (Provide
    +    zlib's uncompress2 from compat/zlib-compat.c, 2021-10-07) and its
    +    configure probe in favor of auto-detecting if we need to provide a
    +    fallback uncompress2().
     
         This makes the compilation of git less annoying on older systems.
    -    Since the inclusion of a322920d0bb (Provide zlib's uncompress2 from
    -    compat/zlib-compat.c, 2021-10-07) in v2.35.0-rc0 our default
    -    dependency on a zlib 1.2.9 or newer, unless NO_UNCOMPRESS2=Y is
    -    specified. This results in new errors when git is compiled on older
    -    systems, requiring the packager to define NO_UNCOMPRESS2=Y.
    -
    -    To get around those errors we've needed to bundle config.mak.uname
    -    changes such as 68d1da41c4e (build: NonStop ships with an older zlib,
    -    2022-01-10), and ffb9f298090 (build: centos/RHEL 7 ships with an older
    -    gcc and zlib, 2022-01-15).
    +    Since that a322920d0bb in included in v2.35.0-rc0 we've started
    +    requiring a zlib version 1.2.9 or later. Those compiling on older
    +    versions needed to specify NO_UNCOMPRESS2=Y. That resulted in new
    +    errors when git was compiled on older systems, requiring the packager
    +    to define NO_UNCOMPRESS2=Y.
    +
    +    Let's instead add a compat/zlib-uncompress.o object which'll define
    +    uncompress2() if the ZLIB_VERNUM indicates that libz doesn't have
    +    it. The approach taken here requires some juggling of *.o lists in the
    +    Makefile. It would be simpler to e.g. include this code
    +    unconditionally in our own zlib.c, but per [1] this approach preserves
    +    the compat/* object divide.
    +
    +    Because the code in reftable/* needs this, and we compile an
    +    intermediate reftable.a we'll need a new $(ZLIB_COMPAT_OBJS) list. We
    +    add it to $(LIB_OBJS) (currently redundant, but means using
    +    uncompress2() elsewhere will work), as well as compiling the
    +    $(REFTABLE_LIB) with $(ZLIB_COMPAT_OBJS).
     
    -    Let's instead rely on ZLIB_VERNUM, as we in zlib.c already for
    -    NO_DEFLATE_BOUND. See 9da3acfb194 ([PATCH] compat: support pre-1.2
    -    zlib, 2005-04-30) and 609a2289d76 (Improve accuracy of check for
    -    presence of deflateBound., 2007-11-07) for that prior art.
    +    We can then remove the NO_UNCOMPRESS2 setting, and the NO_UNCOMPRESS2
    +    settings in config.mak.uname added in a322920d0bb, and then
    +    subsequently in 68d1da41c4e (build: NonStop ships with an older zlib,
    +    2022-01-10) and ffb9f298090 (build: centos/RHEL 7 ships with an older
    +    gcc and zlib, 2022-01-15).
     
    -    With this change it should be safe to remove the NO_UNCOMPRESS2=Y
    -    lines from config.mak.uname, but let's leave them in place for now.
    +    Since the prototype of uncompress2() lives in git-compat-util.h we'll
    +    need to include zlib.h there. We can then remove the inclusion of
    +    zlib.h from cache,h, since it includes git-compat-util.h. The
    +    inclusion of zlib.h in cache.h dates back to e83c5163316 (Initial
    +    revision of "git", the information manager from hell, 2005-04-07).
     
    -    Ideally we'd add compat/zlib-uncompress2.o to COMPAT_OBJS, but it's
    -    being added to our zlib.c instead. This is because we need to look at
    -    ZLIB_VERNUM to know if we need it. Hoisting that logic over to the
    -    Makefile would be inconvenient (we'd need shell out to "cc -E" or
    -    equivalent just to get the macro value). The zlib.c file already has
    -    the similar deflateBound() compatibility macro added in 9da3acfb194.
    +    1. https://lore.kernel.org/git/xmqq1r13o7rf.fsf@gitster.g/
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Makefile ##
     @@ Makefile: all::
    - # Define NO_DEFLATE_BOUND if your zlib does not have deflateBound.
      #
    - # Define NO_UNCOMPRESS2 if your zlib does not have uncompress2.
    -+# You should not need to define this, it will be auto-detected using
    -+# the ZLIB_VERNUM macro.
    + # Define NO_DEFLATE_BOUND if your zlib does not have deflateBound.
      #
    +-# Define NO_UNCOMPRESS2 if your zlib does not have uncompress2.
    +-#
      # Define NO_NORETURN if using buggy versions of gcc 4.6+ and profile feedback,
      # as the compiler can crash (http://gcc.gnu.org/bugzilla/show_bug.cgi?id=49299)
    -@@ Makefile: endif
    + #
    +@@ Makefile: TEST_BUILTINS_OBJS =
    + TEST_OBJS =
    + TEST_PROGRAMS_NEED_X =
    + THIRD_PARTY_SOURCES =
    ++ZLIB_COMPAT_OBJS =
      
    - ifdef NO_UNCOMPRESS2
    - 	BASIC_CFLAGS += -DNO_UNCOMPRESS2
    --	REFTABLE_OBJS += compat/zlib-uncompress2.o
    + # Having this variable in your environment would break pipelines because
    + # you cause "cd" to echo its destination to stdout.  It can also take
    +@@ Makefile: ifdef NO_DEFLATE_BOUND
    + 	BASIC_CFLAGS += -DNO_DEFLATE_BOUND
      endif
      
    +-ifdef NO_UNCOMPRESS2
    +-	BASIC_CFLAGS += -DNO_UNCOMPRESS2
    +-	REFTABLE_OBJS += compat/zlib-uncompress2.o
    +-endif
    ++# Detected using the ZLIB_VERNUM macro
    ++ZLIB_COMPAT_OBJS += compat/zlib-uncompress2.o
    + 
      ifdef NO_POSIX_GOODIES
    + 	BASIC_CFLAGS += -DNO_POSIX_GOODIES
    +@@ Makefile: LIBS = $(filter-out %.o, $(GITLIBS)) $(EXTLIBS)
    + 
    + BASIC_CFLAGS += $(COMPAT_CFLAGS)
    + LIB_OBJS += $(COMPAT_OBJS)
    ++LIB_OBJS += $(ZLIB_COMPAT_OBJS)
    + 
    + # Quote for C
    + 
    +@@ Makefile: $(LIB_FILE): $(LIB_OBJS)
    + $(XDIFF_LIB): $(XDIFF_OBJS)
    + 	$(QUIET_AR)$(RM) $@ && $(AR) $(ARFLAGS) $@ $^
    + 
    +-$(REFTABLE_LIB): $(REFTABLE_OBJS)
    ++$(REFTABLE_LIB): $(REFTABLE_OBJS) $(ZLIB_COMPAT_OBJS)
    + 	$(QUIET_AR)$(RM) $@ && $(AR) $(ARFLAGS) $@ $^
    + 
    + $(REFTABLE_TEST_LIB): $(REFTABLE_TEST_OBJS)
    +
    + ## cache.h ##
    +@@
    + #include "repository.h"
    + #include "mem-pool.h"
    + 
    +-#include <zlib.h>
    + typedef struct git_zstream {
    + 	z_stream z;
    + 	unsigned long avail_in;
    +
    + ## ci/lib.sh ##
    +@@ ci/lib.sh: esac
    + case "$jobname" in
    + linux32)
    + 	CC=gcc
    +-	MAKEFLAGS="$MAKEFLAGS NO_UNCOMPRESS2=1"
    + 	;;
    + linux-musl)
    + 	CC=gcc
     
      ## compat/zlib-uncompress2.c ##
     @@
    ++#include "git-compat-util.h"
    ++
    ++#if ZLIB_VERNUM < 0x1290
    + /* taken from zlib's uncompr.c
    + 
    +    commit cacf7f1d4e3d44d871b605da3b647f07d718623f
    +@@
      
      */
      
    @@ compat/zlib-uncompress2.c
      #define z_const
      
      /*
    +@@
    +  * For conditions of distribution and use, see copyright notice in zlib.h
    +  */
    + 
    +-#include <zlib.h>
    +-
    + /* clang-format off */
    + 
    + /* ===========================================================================
    +@@ compat/zlib-uncompress2.c: int ZEXPORT uncompress2 (
    + 	   err == Z_BUF_ERROR && left + stream.avail_out ? Z_DATA_ERROR :
    + 	   err;
    + }
    ++#endif
    +
    + ## config.mak.uname ##
    +@@ config.mak.uname: ifeq ($(uname_S),Linux)
    + 	# centos7/rhel7 provides gcc 4.8.5 and zlib 1.2.7.
    + 	ifneq ($(findstring .el7.,$(uname_R)),)
    + 		BASIC_CFLAGS += -std=c99
    +-		NO_UNCOMPRESS2 = YesPlease
    + 	endif
    + endif
    + ifeq ($(uname_S),GNU/kFreeBSD)
    +@@ config.mak.uname: ifeq ($(uname_S),FreeBSD)
    + 	FILENO_IS_A_MACRO = UnfortunatelyYes
    + endif
    + ifeq ($(uname_S),OpenBSD)
    +-	# Versions < 7.0 need compatibility layer
    +-	ifeq ($(shell expr "$(uname_R)" : "[1-6]\."),2)
    +-		NO_UNCOMPRESS2 = UnfortunatelyYes
    +-	endif
    + 	NO_STRCASESTR = YesPlease
    + 	NO_MEMMEM = YesPlease
    + 	USE_ST_TIMESPEC = YesPlease
    +@@ config.mak.uname: ifeq ($(uname_S),Interix)
    + 	endif
    + endif
    + ifeq ($(uname_S),Minix)
    +-	NO_UNCOMPRESS2 = YesPlease
    + 	NO_IPV6 = YesPlease
    + 	NO_ST_BLOCKS_IN_STRUCT_STAT = YesPlease
    + 	NO_NSEC = YesPlease
    +@@ config.mak.uname: ifeq ($(uname_S),NONSTOP_KERNEL)
    + 	NO_SETENV = YesPlease
    + 	NO_UNSETENV = YesPlease
    + 	NO_MKDTEMP = YesPlease
    +-	NO_UNCOMPRESS2 = YesPlease
    + 	# Currently libiconv-1.9.1.
    + 	OLD_ICONV = UnfortunatelyYes
    + 	NO_REGEX = NeedsStartEnd
    +
    + ## configure.ac ##
    +@@ configure.ac: AC_LINK_IFELSE([ZLIBTEST_SRC],
    + 	NO_DEFLATE_BOUND=yes])
    + LIBS="$old_LIBS"
    + 
    +-AC_DEFUN([ZLIBTEST_UNCOMPRESS2_SRC], [
    +-AC_LANG_PROGRAM([#include <zlib.h>],
    +- [uncompress2(NULL,NULL,NULL,NULL);])])
    +-AC_MSG_CHECKING([for uncompress2 in -lz])
    +-old_LIBS="$LIBS"
    +-LIBS="$LIBS -lz"
    +-AC_LINK_IFELSE([ZLIBTEST_UNCOMPRESS2_SRC],
    +-	[AC_MSG_RESULT([yes])],
    +-	[AC_MSG_RESULT([no])
    +-	NO_UNCOMPRESS2=yes])
    +-LIBS="$old_LIBS"
    +-
    + GIT_UNSTASH_FLAGS($ZLIB_PATH)
    + 
    + GIT_CONF_SUBST([NO_DEFLATE_BOUND])
    +-GIT_CONF_SUBST([NO_UNCOMPRESS2])
    + 
    + #
    + # Define NEEDS_SOCKET if linking with libc is not enough (SunOS,
     
      ## git-compat-util.h ##
     @@ git-compat-util.h: void unleak_memory(const void *ptr, size_t len);
      #define UNLEAK(var) do {} while (0)
      #endif
      
    -+#if defined(NO_UNCOMPRESS2) || ZLIB_VERNUM < 0x1290
     +#include <zlib.h>
    -+#define GIT_NO_UNCOMPRESS2 1
    ++
    ++#if ZLIB_VERNUM < 0x1290
    ++/*
    ++ * This is uncompress2, which is only available in zlib >= 1.2.9
    ++ * (released as of early 2017). See compat/zlib-uncompress2.c.
    ++ */
     +int uncompress2(Bytef *dest, uLongf *destLen, const Bytef *source,
     +		uLong *sourceLen);
     +#endif
    @@ git-compat-util.h: void unleak_memory(const void *ptr, size_t len);
     
      ## reftable/system.h ##
     @@ reftable/system.h: license that can be found in the LICENSE file or at
    + #include "hash.h" /* hash ID, sizes.*/
    + #include "dir.h" /* remove_dir_recursively, for tests.*/
      
    - #include <zlib.h>
    - 
    +-#include <zlib.h>
    +-
     -#ifdef NO_UNCOMPRESS2
     -/*
     - * This is uncompress2, which is only available in zlib >= 1.2.9
    @@ reftable/system.h: license that can be found in the LICENSE file or at
      int hash_size(uint32_t id);
      
      #endif
    -
    - ## zlib.c ##
    -@@
    -  * at init time.
    -  */
    - #include "cache.h"
    -+#ifdef GIT_NO_UNCOMPRESS2
    -+#include "compat/zlib-uncompress2.c"
    -+#endif
    - 
    - static const char *zerr_to_string(int status)
    - {

 Makefile                  | 12 +++++-------
 cache.h                   |  1 -
 ci/lib.sh                 |  1 -
 compat/zlib-uncompress2.c |  7 ++++---
 config.mak.uname          |  7 -------
 configure.ac              | 13 -------------
 git-compat-util.h         | 11 +++++++++++
 reftable/system.h         | 11 -----------
 8 files changed, 20 insertions(+), 43 deletions(-)

diff --git a/Makefile b/Makefile
index 5580859afdb..416498bbe69 100644
--- a/Makefile
+++ b/Makefile
@@ -256,8 +256,6 @@ all::
 #
 # Define NO_DEFLATE_BOUND if your zlib does not have deflateBound.
 #
-# Define NO_UNCOMPRESS2 if your zlib does not have uncompress2.
-#
 # Define NO_NORETURN if using buggy versions of gcc 4.6+ and profile feedback,
 # as the compiler can crash (http://gcc.gnu.org/bugzilla/show_bug.cgi?id=49299)
 #
@@ -588,6 +586,7 @@ TEST_BUILTINS_OBJS =
 TEST_OBJS =
 TEST_PROGRAMS_NEED_X =
 THIRD_PARTY_SOURCES =
+ZLIB_COMPAT_OBJS =
 
 # Having this variable in your environment would break pipelines because
 # you cause "cd" to echo its destination to stdout.  It can also take
@@ -1726,10 +1725,8 @@ ifdef NO_DEFLATE_BOUND
 	BASIC_CFLAGS += -DNO_DEFLATE_BOUND
 endif
 
-ifdef NO_UNCOMPRESS2
-	BASIC_CFLAGS += -DNO_UNCOMPRESS2
-	REFTABLE_OBJS += compat/zlib-uncompress2.o
-endif
+# Detected using the ZLIB_VERNUM macro
+ZLIB_COMPAT_OBJS += compat/zlib-uncompress2.o
 
 ifdef NO_POSIX_GOODIES
 	BASIC_CFLAGS += -DNO_POSIX_GOODIES
@@ -2076,6 +2073,7 @@ LIBS = $(filter-out %.o, $(GITLIBS)) $(EXTLIBS)
 
 BASIC_CFLAGS += $(COMPAT_CFLAGS)
 LIB_OBJS += $(COMPAT_OBJS)
+LIB_OBJS += $(ZLIB_COMPAT_OBJS)
 
 # Quote for C
 
@@ -2641,7 +2639,7 @@ $(LIB_FILE): $(LIB_OBJS)
 $(XDIFF_LIB): $(XDIFF_OBJS)
 	$(QUIET_AR)$(RM) $@ && $(AR) $(ARFLAGS) $@ $^
 
-$(REFTABLE_LIB): $(REFTABLE_OBJS)
+$(REFTABLE_LIB): $(REFTABLE_OBJS) $(ZLIB_COMPAT_OBJS)
 	$(QUIET_AR)$(RM) $@ && $(AR) $(ARFLAGS) $@ $^
 
 $(REFTABLE_TEST_LIB): $(REFTABLE_TEST_OBJS)
diff --git a/cache.h b/cache.h
index 281f00ab1b1..3a0142aa56f 100644
--- a/cache.h
+++ b/cache.h
@@ -18,7 +18,6 @@
 #include "repository.h"
 #include "mem-pool.h"
 
-#include <zlib.h>
 typedef struct git_zstream {
 	z_stream z;
 	unsigned long avail_in;
diff --git a/ci/lib.sh b/ci/lib.sh
index 9d28ab50fb4..cbc2f8f1caa 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -197,7 +197,6 @@ esac
 case "$jobname" in
 linux32)
 	CC=gcc
-	MAKEFLAGS="$MAKEFLAGS NO_UNCOMPRESS2=1"
 	;;
 linux-musl)
 	CC=gcc
diff --git a/compat/zlib-uncompress2.c b/compat/zlib-uncompress2.c
index 722610b9718..6836a1d37d8 100644
--- a/compat/zlib-uncompress2.c
+++ b/compat/zlib-uncompress2.c
@@ -1,3 +1,6 @@
+#include "git-compat-util.h"
+
+#if ZLIB_VERNUM < 0x1290
 /* taken from zlib's uncompr.c
 
    commit cacf7f1d4e3d44d871b605da3b647f07d718623f
@@ -8,7 +11,6 @@
 
 */
 
-#include "../reftable/system.h"
 #define z_const
 
 /*
@@ -16,8 +18,6 @@
  * For conditions of distribution and use, see copyright notice in zlib.h
  */
 
-#include <zlib.h>
-
 /* clang-format off */
 
 /* ===========================================================================
@@ -93,3 +93,4 @@ int ZEXPORT uncompress2 (
 	   err == Z_BUF_ERROR && left + stream.avail_out ? Z_DATA_ERROR :
 	   err;
 }
+#endif
diff --git a/config.mak.uname b/config.mak.uname
index c48db45106c..92ea00c219d 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -66,7 +66,6 @@ ifeq ($(uname_S),Linux)
 	# centos7/rhel7 provides gcc 4.8.5 and zlib 1.2.7.
 	ifneq ($(findstring .el7.,$(uname_R)),)
 		BASIC_CFLAGS += -std=c99
-		NO_UNCOMPRESS2 = YesPlease
 	endif
 endif
 ifeq ($(uname_S),GNU/kFreeBSD)
@@ -266,10 +265,6 @@ ifeq ($(uname_S),FreeBSD)
 	FILENO_IS_A_MACRO = UnfortunatelyYes
 endif
 ifeq ($(uname_S),OpenBSD)
-	# Versions < 7.0 need compatibility layer
-	ifeq ($(shell expr "$(uname_R)" : "[1-6]\."),2)
-		NO_UNCOMPRESS2 = UnfortunatelyYes
-	endif
 	NO_STRCASESTR = YesPlease
 	NO_MEMMEM = YesPlease
 	USE_ST_TIMESPEC = YesPlease
@@ -525,7 +520,6 @@ ifeq ($(uname_S),Interix)
 	endif
 endif
 ifeq ($(uname_S),Minix)
-	NO_UNCOMPRESS2 = YesPlease
 	NO_IPV6 = YesPlease
 	NO_ST_BLOCKS_IN_STRUCT_STAT = YesPlease
 	NO_NSEC = YesPlease
@@ -581,7 +575,6 @@ ifeq ($(uname_S),NONSTOP_KERNEL)
 	NO_SETENV = YesPlease
 	NO_UNSETENV = YesPlease
 	NO_MKDTEMP = YesPlease
-	NO_UNCOMPRESS2 = YesPlease
 	# Currently libiconv-1.9.1.
 	OLD_ICONV = UnfortunatelyYes
 	NO_REGEX = NeedsStartEnd
diff --git a/configure.ac b/configure.ac
index d60d494ee4c..5ee25ec95c8 100644
--- a/configure.ac
+++ b/configure.ac
@@ -664,22 +664,9 @@ AC_LINK_IFELSE([ZLIBTEST_SRC],
 	NO_DEFLATE_BOUND=yes])
 LIBS="$old_LIBS"
 
-AC_DEFUN([ZLIBTEST_UNCOMPRESS2_SRC], [
-AC_LANG_PROGRAM([#include <zlib.h>],
- [uncompress2(NULL,NULL,NULL,NULL);])])
-AC_MSG_CHECKING([for uncompress2 in -lz])
-old_LIBS="$LIBS"
-LIBS="$LIBS -lz"
-AC_LINK_IFELSE([ZLIBTEST_UNCOMPRESS2_SRC],
-	[AC_MSG_RESULT([yes])],
-	[AC_MSG_RESULT([no])
-	NO_UNCOMPRESS2=yes])
-LIBS="$old_LIBS"
-
 GIT_UNSTASH_FLAGS($ZLIB_PATH)
 
 GIT_CONF_SUBST([NO_DEFLATE_BOUND])
-GIT_CONF_SUBST([NO_UNCOMPRESS2])
 
 #
 # Define NEEDS_SOCKET if linking with libc is not enough (SunOS,
diff --git a/git-compat-util.h b/git-compat-util.h
index 1229c8296b9..96ee35f9e06 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -1386,6 +1386,17 @@ void unleak_memory(const void *ptr, size_t len);
 #define UNLEAK(var) do {} while (0)
 #endif
 
+#include <zlib.h>
+
+#if ZLIB_VERNUM < 0x1290
+/*
+ * This is uncompress2, which is only available in zlib >= 1.2.9
+ * (released as of early 2017). See compat/zlib-uncompress2.c.
+ */
+int uncompress2(Bytef *dest, uLongf *destLen, const Bytef *source,
+		uLong *sourceLen);
+#endif
+
 /*
  * This include must come after system headers, since it introduces macros that
  * replace system names.
diff --git a/reftable/system.h b/reftable/system.h
index 4907306c0c5..18f9207dfee 100644
--- a/reftable/system.h
+++ b/reftable/system.h
@@ -16,17 +16,6 @@ license that can be found in the LICENSE file or at
 #include "hash.h" /* hash ID, sizes.*/
 #include "dir.h" /* remove_dir_recursively, for tests.*/
 
-#include <zlib.h>
-
-#ifdef NO_UNCOMPRESS2
-/*
- * This is uncompress2, which is only available in zlib >= 1.2.9
- * (released as of early 2017)
- */
-int uncompress2(Bytef *dest, uLongf *destLen, const Bytef *source,
-		uLong *sourceLen);
-#endif
-
 int hash_size(uint32_t id);
 
 #endif
-- 
2.35.0.rc1.864.g57621b115b6

