Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58FBAC433FE
	for <git@archiver.kernel.org>; Wed, 19 Jan 2022 09:45:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352938AbiASJpt (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Jan 2022 04:45:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352946AbiASJps (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Jan 2022 04:45:48 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70798C061574
        for <git@vger.kernel.org>; Wed, 19 Jan 2022 01:45:48 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id h206-20020a1c21d7000000b0034d95625e1fso5018850wmh.4
        for <git@vger.kernel.org>; Wed, 19 Jan 2022 01:45:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=g7oIHPvly7cZxUwMjLSnYxKUHSxMMjukkmFsUFzYXr4=;
        b=B64K+VDE2OaqrKi6z/I96Sj20txqDZM0qFxBq8hWZZy7ANNg5d497kQu3RX9uF3MVi
         WDt0wEfeR7stfzS3J/7Uv9Kr19bYBZpsg2QkQQHxnXZYKUT7H6UjluMCdpT0qCGB823H
         OTWeeQon5g26MzQgJadDnEmGDQUam550hocOEIy6b9cL+oqeUtpku/qI2/xfdq3U7AjF
         hqt+9pWXPTE3WpMFINh8wtneT075Ai41Q4v6JF0BVgZ9dIpaIyYZJHEgcyCCwZmDxAQK
         YR7jmraOYzjEl+r6k9JTXzcCsobRMfWJg2zOv/0CnwyaBR6mnpjUs0UmWbrlyDB7AiOK
         Tecw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=g7oIHPvly7cZxUwMjLSnYxKUHSxMMjukkmFsUFzYXr4=;
        b=fLVOsYvUx/6N5m8ytKKGqFfrpH3jT3uu7M3iklw7BWDGU33KDN/jQ6loVRZzuqqIqI
         GWle8a3VAy+q+pPGWvq5ooeZkTz5INBkeCE0t6bPKceSGrHqw7aOdwOfjunGlNFegfiu
         kFFISG19Wpnq9k2LJewfuriIZfaZfEvzXtnd8owE8pOPhE3MxRBSpfC8cy3tZNsVgvNW
         TeRUBxMb5oZYK8EHBS4Xiqzt0MswORyMsj3SLZ07oiR+TduTOejs2YClbj8oO2FdLWpo
         9ke1slOACbQVp0HwgnG8qeRrnIiMPygzb1nesOV6mhKK7Ah1pjTzDRkfZN1ZwBJGBix4
         Ze7w==
X-Gm-Message-State: AOAM533VfsaV1CtOkEg3JW5+/CVGmwa4mlYO8kb8DCGeiU6b91hsxP6Y
        pnvnH9DF/QYFDl7hQ8bTyE96mI2XvXCmeg==
X-Google-Smtp-Source: ABdhPJzS/se37n6JzLVOtMRlsIwnIW+6aeNbkcsIO05Rwod3eGyZm01oivHKnaX0V7lTeVEbD9uBcg==
X-Received: by 2002:adf:e191:: with SMTP id az17mr28769346wrb.324.1642585546575;
        Wed, 19 Jan 2022 01:45:46 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id e17sm18574698wrr.34.2022.01.19.01.45.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jan 2022 01:45:46 -0800 (PST)
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
Subject: [PATCH v2] cache.h: auto-detect if zlib has uncompress2()
Date:   Wed, 19 Jan 2022 10:45:35 +0100
Message-Id: <patch-v2-1.1-444eacf30be-20220119T094428Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.0.rc1.864.g57621b115b6
In-Reply-To: <patch-1.1-9cea01a1395-20220117T170457Z-avarab@gmail.com>
References: <patch-1.1-9cea01a1395-20220117T170457Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the NO_UNCOMPRESS2=Y setting to auto-detect those older zlib
versions that don't have uncompress2().

This makes the compilation of git less annoying on older systems.
Since the inclusion of a322920d0bb (Provide zlib's uncompress2 from
compat/zlib-compat.c, 2021-10-07) in v2.35.0-rc0 our default
dependency on a zlib 1.2.9 or newer, unless NO_UNCOMPRESS2=Y is
specified. This results in new errors when git is compiled on older
systems, requiring the packager to define NO_UNCOMPRESS2=Y.

To get around those errors we've needed to bundle config.mak.uname
changes such as 68d1da41c4e (build: NonStop ships with an older zlib,
2022-01-10), and ffb9f298090 (build: centos/RHEL 7 ships with an older
gcc and zlib, 2022-01-15).

Let's instead rely on ZLIB_VERNUM, as we in zlib.c already for
NO_DEFLATE_BOUND. See 9da3acfb194 ([PATCH] compat: support pre-1.2
zlib, 2005-04-30) and 609a2289d76 (Improve accuracy of check for
presence of deflateBound., 2007-11-07) for that prior art.

With this change it should be safe to remove the NO_UNCOMPRESS2=Y
lines from config.mak.uname, but let's leave them in place for now.

Ideally we'd add compat/zlib-uncompress2.o to COMPAT_OBJS, but it's
being added to our zlib.c instead. This is because we need to look at
ZLIB_VERNUM to know if we need it. Hoisting that logic over to the
Makefile would be inconvenient (we'd need shell out to "cc -E" or
equivalent just to get the macro value). The zlib.c file already has
the similar deflateBound() compatibility macro added in 9da3acfb194.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---

Per https://lore.kernel.org/git/xmqqwniwo738.fsf@gitster.g/ this
re-roll is probably too late for rc2 & the release, but here's a v2
just in case (or for after the release).

I think this addresses all the points Junio and René brought up on the
v1. I've also omitted any changes to config.mak.uname, they're
redundant now, but we can keep them out of an abundance of
caution. The removal of the already-redundant "z_const" definition. is
also gone here

The wrapper also lives in git-compat-util.h now, instead of cache.h.

Range-diff against v1:
1:  9cea01a1395 ! 1:  444eacf30be cache.h: auto-detect if zlib has uncompress2()
    @@ Commit message
         Change the NO_UNCOMPRESS2=Y setting to auto-detect those older zlib
         versions that don't have uncompress2().
     
    -    This makes the compilation of git less annoying on older systems,
    -    since the inclusion of a322920d0bb (Provide zlib's uncompress2 from
    +    This makes the compilation of git less annoying on older systems.
    +    Since the inclusion of a322920d0bb (Provide zlib's uncompress2 from
         compat/zlib-compat.c, 2021-10-07) in v2.35.0-rc0 our default
    -    dependency on a zlib 1.2.9 or newer unless NO_UNCOMPRESS2=Y is
    -    specified has resulted in errors when git is compiled.
    +    dependency on a zlib 1.2.9 or newer, unless NO_UNCOMPRESS2=Y is
    +    specified. This results in new errors when git is compiled on older
    +    systems, requiring the packager to define NO_UNCOMPRESS2=Y.
     
         To get around those errors we've needed to bundle config.mak.uname
    -    changes such as such as 68d1da41c4e (build: NonStop ships with an
    -    older zlib, 2022-01-10) and the in-flight
    -    https://lore.kernel.org/git/20220116020520.26895-1-davvid@gmail.com/.
    +    changes such as 68d1da41c4e (build: NonStop ships with an older zlib,
    +    2022-01-10), and ffb9f298090 (build: centos/RHEL 7 ships with an older
    +    gcc and zlib, 2022-01-15).
     
    -    Let's instead rely on ZLIB_VERNUM. Now only those systems where zlib
    -    is so broken that it can't be rely on (such a system probably doesn't
    -    exist) need to provide a NO_UNCOMPRESS2=Y.
    +    Let's instead rely on ZLIB_VERNUM, as we in zlib.c already for
    +    NO_DEFLATE_BOUND. See 9da3acfb194 ([PATCH] compat: support pre-1.2
    +    zlib, 2005-04-30) and 609a2289d76 (Improve accuracy of check for
    +    presence of deflateBound., 2007-11-07) for that prior art.
     
    -    See 9da3acfb194 ([PATCH] compat: support pre-1.2 zlib, 2005-04-30) and
    -    609a2289d76 (Improve accuracy of check for presence of deflateBound.,
    -    2007-11-07) for in-tree prior art using ZLIB_VERNUM.
    +    With this change it should be safe to remove the NO_UNCOMPRESS2=Y
    +    lines from config.mak.uname, but let's leave them in place for now.
    +
    +    Ideally we'd add compat/zlib-uncompress2.o to COMPAT_OBJS, but it's
    +    being added to our zlib.c instead. This is because we need to look at
    +    ZLIB_VERNUM to know if we need it. Hoisting that logic over to the
    +    Makefile would be inconvenient (we'd need shell out to "cc -E" or
    +    equivalent just to get the macro value). The zlib.c file already has
    +    the similar deflateBound() compatibility macro added in 9da3acfb194.
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Makefile ##
     @@ Makefile: all::
    - #
      # Define NO_DEFLATE_BOUND if your zlib does not have deflateBound.
      #
    --# Define NO_UNCOMPRESS2 if your zlib does not have uncompress2.
    -+# Define NO_UNCOMPRESS2 if your zlib is older than v1.2.9 and does not
    -+# have uncompress2. You should not need to define this unless your
    -+# zlib's ZLIB_VERNUM is broken. We'll auto-detect this on the basis of
    -+# that macro.
    + # Define NO_UNCOMPRESS2 if your zlib does not have uncompress2.
    ++# You should not need to define this, it will be auto-detected using
    ++# the ZLIB_VERNUM macro.
      #
      # Define NO_NORETURN if using buggy versions of gcc 4.6+ and profile feedback,
      # as the compiler can crash (http://gcc.gnu.org/bugzilla/show_bug.cgi?id=49299)
    @@ Makefile: endif
      
      ifdef NO_POSIX_GOODIES
     
    - ## cache.h ##
    -@@ cache.h: typedef struct git_zstream {
    - 	unsigned char *next_out;
    - } git_zstream;
    - 
    -+#if defined(NO_UNCOMPRESS2) || ZLIB_VERNUM < 0x1290
    -+#define GIT_NO_UNCOMPRESS2 1
    -+int uncompress2(Bytef *dest, uLongf *destLen, const Bytef *source,
    -+		uLong *sourceLen);
    -+#endif
    - void git_inflate_init(git_zstream *);
    - void git_inflate_init_gzip_only(git_zstream *);
    - void git_inflate_end(git_zstream *);
    -
      ## compat/zlib-uncompress2.c ##
     @@
      
      */
      
     -#include "../reftable/system.h"
    --#define z_const
    --
    - /*
    -  * Copyright (C) 1995-2003, 2010, 2014, 2016 Jean-loup Gailly, Mark Adler
    -  * For conditions of distribution and use, see copyright notice in zlib.h
    -  */
    + #define z_const
      
    --#include <zlib.h>
    -+/* No "#include <zlib.h>", done in cache.h */
    - 
    - /* clang-format off */
    - 
    -
    - ## config.mak.uname ##
    -@@ config.mak.uname: ifeq ($(uname_S),FreeBSD)
    - 	FILENO_IS_A_MACRO = UnfortunatelyYes
    - endif
    - ifeq ($(uname_S),OpenBSD)
    --	# Versions < 7.0 need compatibility layer
    --	ifeq ($(shell expr "$(uname_R)" : "[1-6]\."),2)
    --		NO_UNCOMPRESS2 = UnfortunatelyYes
    --	endif
    - 	NO_STRCASESTR = YesPlease
    - 	NO_MEMMEM = YesPlease
    - 	USE_ST_TIMESPEC = YesPlease
    -@@ config.mak.uname: ifeq ($(uname_S),Interix)
    - 	endif
    - endif
    - ifeq ($(uname_S),Minix)
    --	NO_UNCOMPRESS2 = YesPlease
    - 	NO_IPV6 = YesPlease
    - 	NO_ST_BLOCKS_IN_STRUCT_STAT = YesPlease
    - 	NO_NSEC = YesPlease
    -@@ config.mak.uname: ifeq ($(uname_S),NONSTOP_KERNEL)
    - 	NO_SETENV = YesPlease
    - 	NO_UNSETENV = YesPlease
    - 	NO_MKDTEMP = YesPlease
    --	NO_UNCOMPRESS2 = YesPlease
    - 	# Currently libiconv-1.9.1.
    - 	OLD_ICONV = UnfortunatelyYes
    - 	NO_REGEX = NeedsStartEnd
    + /*
     
    - ## reftable/block.c ##
    -@@ reftable/block.c: license that can be found in the LICENSE file or at
    - #include "record.h"
    - #include "reftable-error.h"
    - #include "system.h"
    --#include <zlib.h>
    -+#include "zlib.h"
    + ## git-compat-util.h ##
    +@@ git-compat-util.h: void unleak_memory(const void *ptr, size_t len);
    + #define UNLEAK(var) do {} while (0)
    + #endif
      
    - int header_size(int version)
    - {
    ++#if defined(NO_UNCOMPRESS2) || ZLIB_VERNUM < 0x1290
    ++#include <zlib.h>
    ++#define GIT_NO_UNCOMPRESS2 1
    ++int uncompress2(Bytef *dest, uLongf *destLen, const Bytef *source,
    ++		uLong *sourceLen);
    ++#endif
    ++
    + /*
    +  * This include must come after system headers, since it introduces macros that
    +  * replace system names.
     
      ## reftable/system.h ##
     @@ reftable/system.h: license that can be found in the LICENSE file or at
    - #include "strbuf.h"
    - #include "hash.h" /* hash ID, sizes.*/
    - #include "dir.h" /* remove_dir_recursively, for tests.*/
    --
    --#include <zlib.h>
    --
    + 
    + #include <zlib.h>
    + 
     -#ifdef NO_UNCOMPRESS2
     -/*
     - * This is uncompress2, which is only available in zlib >= 1.2.9
    @@ reftable/system.h: license that can be found in the LICENSE file or at
     -int uncompress2(Bytef *dest, uLongf *destLen, const Bytef *source,
     -		uLong *sourceLen);
     -#endif
    -+#include "zlib.h"
    - 
    +-
      int hash_size(uint32_t id);
      
    + #endif
     
      ## zlib.c ##
     @@

 Makefile                  | 3 ++-
 compat/zlib-uncompress2.c | 1 -
 git-compat-util.h         | 7 +++++++
 reftable/system.h         | 9 ---------
 zlib.c                    | 3 +++
 5 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/Makefile b/Makefile
index 5580859afdb..616f6527f07 100644
--- a/Makefile
+++ b/Makefile
@@ -257,6 +257,8 @@ all::
 # Define NO_DEFLATE_BOUND if your zlib does not have deflateBound.
 #
 # Define NO_UNCOMPRESS2 if your zlib does not have uncompress2.
+# You should not need to define this, it will be auto-detected using
+# the ZLIB_VERNUM macro.
 #
 # Define NO_NORETURN if using buggy versions of gcc 4.6+ and profile feedback,
 # as the compiler can crash (http://gcc.gnu.org/bugzilla/show_bug.cgi?id=49299)
@@ -1728,7 +1730,6 @@ endif
 
 ifdef NO_UNCOMPRESS2
 	BASIC_CFLAGS += -DNO_UNCOMPRESS2
-	REFTABLE_OBJS += compat/zlib-uncompress2.o
 endif
 
 ifdef NO_POSIX_GOODIES
diff --git a/compat/zlib-uncompress2.c b/compat/zlib-uncompress2.c
index 722610b9718..8592dc3dab5 100644
--- a/compat/zlib-uncompress2.c
+++ b/compat/zlib-uncompress2.c
@@ -8,7 +8,6 @@
 
 */
 
-#include "../reftable/system.h"
 #define z_const
 
 /*
diff --git a/git-compat-util.h b/git-compat-util.h
index 1229c8296b9..0c5e373e917 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -1386,6 +1386,13 @@ void unleak_memory(const void *ptr, size_t len);
 #define UNLEAK(var) do {} while (0)
 #endif
 
+#if defined(NO_UNCOMPRESS2) || ZLIB_VERNUM < 0x1290
+#include <zlib.h>
+#define GIT_NO_UNCOMPRESS2 1
+int uncompress2(Bytef *dest, uLongf *destLen, const Bytef *source,
+		uLong *sourceLen);
+#endif
+
 /*
  * This include must come after system headers, since it introduces macros that
  * replace system names.
diff --git a/reftable/system.h b/reftable/system.h
index 4907306c0c5..c69caaabeba 100644
--- a/reftable/system.h
+++ b/reftable/system.h
@@ -18,15 +18,6 @@ license that can be found in the LICENSE file or at
 
 #include <zlib.h>
 
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
diff --git a/zlib.c b/zlib.c
index d594cba3fc9..d9440dfb784 100644
--- a/zlib.c
+++ b/zlib.c
@@ -3,6 +3,9 @@
  * at init time.
  */
 #include "cache.h"
+#ifdef GIT_NO_UNCOMPRESS2
+#include "compat/zlib-uncompress2.c"
+#endif
 
 static const char *zerr_to_string(int status)
 {
-- 
2.35.0.rc1.864.g57621b115b6

