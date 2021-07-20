Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6832FC07E95
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 17:06:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50898610D2
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 17:06:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231562AbhGTQZk (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Jul 2021 12:25:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232187AbhGTQYS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jul 2021 12:24:18 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8B23C0613DD
        for <git@vger.kernel.org>; Tue, 20 Jul 2021 10:04:54 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id l17-20020a05600c1d11b029021f84fcaf75so1918128wms.1
        for <git@vger.kernel.org>; Tue, 20 Jul 2021 10:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=KhfP5Pi6SX1nvOeb1sKm3lJWDkHx7oyAGRasn4OX32A=;
        b=B7EPnf6i2QBB0PRyfkU3pzgOOE/0SVbKnkWrFvBJ3YCH/ISed2/AD23ib20IjUBATc
         BOcezOtTsraf/pDTxhSWn5gfcp7H2CN8dNn7N8RuMwJP8hgkfpwyyOoycbw9rOD/4jze
         au+CHay20/Y1Pku5x8/o9yGS142GnE/gke30PxShfC96AjR/H5fqlw4JRP1cKstkidkU
         aaxMyshE8HMVnTWTTyNbcas9TCBHruEGccERBypLY8aL4CHRAP3SDkvF4/1W5imZ3tqO
         bDLjkicDmgbe/iRLJnzyfL6+R1byg4kwW2tevbCdtUlyuerffdEwcIzrZW016+do03Mv
         N1VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=KhfP5Pi6SX1nvOeb1sKm3lJWDkHx7oyAGRasn4OX32A=;
        b=q0+baWmfkIXpX2GKQ72ADGUbl+mpSUwUTL1ocHfEs0EsU697lAvzYBS8qTL+jo5MWM
         PLxAnto0/UVyaimKfcDObZ9MDwOK/5inqD0xRagR5JYl8dfJSaxibwdzFD3ywbDIsCE+
         4HWB3BFXS3fZITjNoSLcjhf335w/7cGx65jNnoBDbKkajmhioU4a548TUj0jdzmW5Q3g
         daiYix4MnNEhH0rgmJZ6tXo4uXqAQp1AqwfKMRo9NNUAB/zFujFk/5VW1YTUOtWoWOyw
         9zXj+y7EkKY7+q/1NxjVoubj4hddfFyTOuJDbTPn8uuCs9vy2oRyBgPbQ0JQHV6/9ihv
         NY6Q==
X-Gm-Message-State: AOAM533cDyItT6T6x4SN6kOuBMUvZpvIqRFWBssZD7MrKFECttyw88vf
        hOGQzknmQhXJjIfT9J91nqO2wfARuz0=
X-Google-Smtp-Source: ABdhPJzGey6+fQ2vurDMYYG0MsnG+qCjv5yOu+t/+KTADmAuRreEBcHFdhncilqUd9nkNLSlPdKcng==
X-Received: by 2002:a1c:35c2:: with SMTP id c185mr32318162wma.126.1626800693327;
        Tue, 20 Jul 2021 10:04:53 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d29sm29695319wrb.63.2021.07.20.10.04.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jul 2021 10:04:52 -0700 (PDT)
Message-Id: <27abd15965875115f641ed9e0cb1a8732369eddb.1626800686.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1054.git.git.1626800686.gitgitgadget@gmail.com>
References: <pull.1054.git.git.1626800686.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 20 Jul 2021 17:04:28 +0000
Subject: [PATCH 08/26] Provide zlib's uncompress2 from compat/zlib-compat.c
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

This will be needed for reading reflog blocks in reftable.

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 Makefile                  |  7 +++
 ci/lib.sh                 |  1 +
 compat/.gitattributes     |  1 +
 compat/zlib-uncompress2.c | 92 +++++++++++++++++++++++++++++++++++++++
 configure.ac              | 13 ++++++
 5 files changed, 114 insertions(+)
 create mode 100644 compat/.gitattributes
 create mode 100644 compat/zlib-uncompress2.c

diff --git a/Makefile b/Makefile
index 15321edbd2c..640a332b481 100644
--- a/Makefile
+++ b/Makefile
@@ -256,6 +256,8 @@ all::
 #
 # Define NO_DEFLATE_BOUND if your zlib does not have deflateBound.
 #
+# Define NO_UNCOMPRESS2 if your zlib does not have uncompress2.
+#
 # Define NO_NORETURN if using buggy versions of gcc 4.6+ and profile feedback,
 # as the compiler can crash (http://gcc.gnu.org/bugzilla/show_bug.cgi?id=49299)
 #
@@ -1734,6 +1736,11 @@ ifdef NO_DEFLATE_BOUND
 	BASIC_CFLAGS += -DNO_DEFLATE_BOUND
 endif
 
+ifdef NO_UNCOMPRESS2
+	BASIC_CFLAGS += -DNO_UNCOMPRESS2
+	LIB_OBJS += compat/zlib-uncompress2.o
+endif
+
 ifdef NO_POSIX_GOODIES
 	BASIC_CFLAGS += -DNO_POSIX_GOODIES
 endif
diff --git a/ci/lib.sh b/ci/lib.sh
index 476c3f369f5..5711c63979d 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -224,6 +224,7 @@ linux-gcc-default)
 	;;
 Linux32)
 	CC=gcc
+	MAKEFLAGS="$MAKEFLAGS NO_UNCOMPRESS2=1"
 	;;
 linux-musl)
 	CC=gcc
diff --git a/compat/.gitattributes b/compat/.gitattributes
new file mode 100644
index 00000000000..40dbfb170da
--- /dev/null
+++ b/compat/.gitattributes
@@ -0,0 +1 @@
+/zlib-uncompress2.c	whitespace=-indent-with-non-tab,-trailing-space
diff --git a/compat/zlib-uncompress2.c b/compat/zlib-uncompress2.c
new file mode 100644
index 00000000000..6893bb469ce
--- /dev/null
+++ b/compat/zlib-uncompress2.c
@@ -0,0 +1,92 @@
+/* taken from zlib's uncompr.c
+
+   commit cacf7f1d4e3d44d871b605da3b647f07d718623f
+   Author: Mark Adler <madler@alumni.caltech.edu>
+   Date:   Sun Jan 15 09:18:46 2017 -0800
+
+       zlib 1.2.11
+
+*/
+
+/*
+ * Copyright (C) 1995-2003, 2010, 2014, 2016 Jean-loup Gailly, Mark Adler
+ * For conditions of distribution and use, see copyright notice in zlib.h
+ */
+
+#include <zlib.h>
+
+/* clang-format off */
+
+/* ===========================================================================
+     Decompresses the source buffer into the destination buffer.  *sourceLen is
+   the byte length of the source buffer. Upon entry, *destLen is the total size
+   of the destination buffer, which must be large enough to hold the entire
+   uncompressed data. (The size of the uncompressed data must have been saved
+   previously by the compressor and transmitted to the decompressor by some
+   mechanism outside the scope of this compression library.) Upon exit,
+   *destLen is the size of the decompressed data and *sourceLen is the number
+   of source bytes consumed. Upon return, source + *sourceLen points to the
+   first unused input byte.
+
+     uncompress returns Z_OK if success, Z_MEM_ERROR if there was not enough
+   memory, Z_BUF_ERROR if there was not enough room in the output buffer, or
+   Z_DATA_ERROR if the input data was corrupted, including if the input data is
+   an incomplete zlib stream.
+*/
+int ZEXPORT uncompress2 (
+    Bytef *dest,
+    uLongf *destLen,
+    const Bytef *source,
+    uLong *sourceLen) {
+    z_stream stream;
+    int err;
+    const uInt max = (uInt)-1;
+    uLong len, left;
+    Byte buf[1];    /* for detection of incomplete stream when *destLen == 0 */
+
+    len = *sourceLen;
+    if (*destLen) {
+        left = *destLen;
+        *destLen = 0;
+    }
+    else {
+        left = 1;
+        dest = buf;
+    }
+
+    stream.next_in = (z_const Bytef *)source;
+    stream.avail_in = 0;
+    stream.zalloc = (alloc_func)0;
+    stream.zfree = (free_func)0;
+    stream.opaque = (voidpf)0;
+
+    err = inflateInit(&stream);
+    if (err != Z_OK) return err;
+
+    stream.next_out = dest;
+    stream.avail_out = 0;
+
+    do {
+        if (stream.avail_out == 0) {
+            stream.avail_out = left > (uLong)max ? max : (uInt)left;
+            left -= stream.avail_out;
+        }
+        if (stream.avail_in == 0) {
+            stream.avail_in = len > (uLong)max ? max : (uInt)len;
+            len -= stream.avail_in;
+        }
+        err = inflate(&stream, Z_NO_FLUSH);
+    } while (err == Z_OK);
+
+    *sourceLen -= len + stream.avail_in;
+    if (dest != buf)
+        *destLen = stream.total_out;
+    else if (stream.total_out && err == Z_BUF_ERROR)
+        left = 1;
+
+    inflateEnd(&stream);
+    return err == Z_STREAM_END ? Z_OK :
+           err == Z_NEED_DICT ? Z_DATA_ERROR  :
+           err == Z_BUF_ERROR && left + stream.avail_out ? Z_DATA_ERROR :
+           err;
+}
diff --git a/configure.ac b/configure.ac
index 031e8d3fee8..c3a913103d0 100644
--- a/configure.ac
+++ b/configure.ac
@@ -672,9 +672,22 @@ AC_LINK_IFELSE([ZLIBTEST_SRC],
 	NO_DEFLATE_BOUND=yes])
 LIBS="$old_LIBS"
 
+AC_DEFUN([ZLIBTEST_UNCOMPRESS2_SRC], [
+AC_LANG_PROGRAM([#include <zlib.h>],
+ [uncompress2(NULL,NULL,NULL,NULL);])])
+AC_MSG_CHECKING([for uncompress2 in -lz])
+old_LIBS="$LIBS"
+LIBS="$LIBS -lz"
+AC_LINK_IFELSE([ZLIBTEST_UNCOMPRESS2_SRC],
+	[AC_MSG_RESULT([yes])],
+	[AC_MSG_RESULT([no])
+	NO_UNCOMPRESS2=yes])
+LIBS="$old_LIBS"
+
 GIT_UNSTASH_FLAGS($ZLIB_PATH)
 
 GIT_CONF_SUBST([NO_DEFLATE_BOUND])
+GIT_CONF_SUBST([NO_UNCOMPRESS2])
 
 #
 # Define NEEDS_SOCKET if linking with libc is not enough (SunOS,
-- 
gitgitgadget

