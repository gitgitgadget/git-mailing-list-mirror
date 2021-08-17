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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07106C4320A
	for <git@archiver.kernel.org>; Tue, 17 Aug 2021 13:41:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E19D060FA0
	for <git@archiver.kernel.org>; Tue, 17 Aug 2021 13:41:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240068AbhHQNmZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Aug 2021 09:42:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239948AbhHQNmJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Aug 2021 09:42:09 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7742C0612E7
        for <git@vger.kernel.org>; Tue, 17 Aug 2021 06:40:28 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id r6so28729163wrt.4
        for <git@vger.kernel.org>; Tue, 17 Aug 2021 06:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=kAQkGJPmsD3r8uxwgy6O8ZePoaoWAwakPT67XBNKQ2I=;
        b=hBDDkSmHI43V6GAFWTzGSenlV9dkuVtU2GM4hL5czG4Lpx26ZKmIml3ylH20I0R10k
         eRZ9TDyP9Thk0ed2IaF7zDcyyBbOrO1K4i5mYiu0wSgA6qzHIq71eVUh+u14qgY86BSz
         Oiv3M0mNykFmTPeHx9ekDvtzCpNKH4cLYWux1DkO5AXJMOsjihz8OM+4/VgVWsVbArmV
         AHp+F5J2wCeSsQVyGX3UHFVi6b4s9hJ/qFCeEaKKWNoTbmfpXqdBrekp5zfHS5ZhYqBM
         LNMxMV4KSSj0jOnWb+m0l/T0EneaHKFwiOAUZBCgeHzy3ZSIkrq8iucQp5wZmbxEFSj3
         L9Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=kAQkGJPmsD3r8uxwgy6O8ZePoaoWAwakPT67XBNKQ2I=;
        b=X2wHJMDfwLBsG/R6Ffkopu+J+KcR18aCrd+n/FHMqVNzo7oa8OJjnJUwVtQWJMrdBg
         YEpvNDc0nHgP8twD6d8j+j6NFHZrcbl5vHUKDIyfOcuQis2k9cJ/dpDG3aGILCgJ3Pm6
         bE68aX0PUAPvZ6CttT4TXZwAsoLHEJqleqVtBh1NkvIXHKq3CWfd0Ex9dD0EGxP1X+Bi
         DZUlE89VP5t0ca9mQqlcFySrN8o5nwSlNY1NyTKiuYInxL+Op4o6yy9vzLsDdmx3Nc/u
         A6onIL/4hOuhPp4KoPbCdvdPNl6U7T210CinN2/Sdj8b3zmbcs+1rNshKAch/0azHN/e
         70tQ==
X-Gm-Message-State: AOAM533wq65k+BFrw7Fldk8xBdPq5ReFDtfo2g63wEK/1WDC/rCVKEFl
        ndgZhvUcdQSSLlcC+L2mVsyhJxH5T70=
X-Google-Smtp-Source: ABdhPJzD8hGWDHz6xWtz/BrbLStT85CXkeHRUiZkCrCKXMoO8DwgGRq8EiWObmvaANrMrPCSTj9vxQ==
X-Received: by 2002:a5d:64ce:: with SMTP id f14mr4223667wri.17.1629207627238;
        Tue, 17 Aug 2021 06:40:27 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f2sm2530971wru.31.2021.08.17.06.40.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 06:40:26 -0700 (PDT)
Message-Id: <d92338467d66fcfedd57f209c97a798e9920d1e5.1629207607.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1054.v3.git.git.1629207607.gitgitgadget@gmail.com>
References: <pull.1054.v2.git.git.1629145036.gitgitgadget@gmail.com>
        <pull.1054.v3.git.git.1629207607.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 17 Aug 2021 13:39:50 +0000
Subject: [PATCH v3 08/25] Provide zlib's uncompress2 from compat/zlib-compat.c
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Carlo Marcelo Arenas =?UTF-8?Q?Bel=C3=B3n?= <carenas@gmail.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

This will be needed for reading reflog blocks in reftable.

Helped-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 Makefile                  |  7 +++
 ci/lib.sh                 |  1 +
 compat/.gitattributes     |  1 +
 compat/zlib-uncompress2.c | 92 +++++++++++++++++++++++++++++++++++++++
 config.mak.uname          |  1 +
 configure.ac              | 13 ++++++
 6 files changed, 115 insertions(+)
 create mode 100644 compat/.gitattributes
 create mode 100644 compat/zlib-uncompress2.c

diff --git a/Makefile b/Makefile
index e98d8ed17cf..16c883978d4 100644
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
@@ -1738,6 +1740,11 @@ ifdef NO_DEFLATE_BOUND
 	BASIC_CFLAGS += -DNO_DEFLATE_BOUND
 endif
 
+ifdef NO_UNCOMPRESS2
+	BASIC_CFLAGS += -DNO_UNCOMPRESS2
+	REFTABLE_OBJS += compat/zlib-uncompress2.o
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
diff --git a/config.mak.uname b/config.mak.uname
index 69413fb3dc0..61e11550b1f 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -256,6 +256,7 @@ ifeq ($(uname_S),FreeBSD)
 	FILENO_IS_A_MACRO = UnfortunatelyYes
 endif
 ifeq ($(uname_S),OpenBSD)
+	NO_UNCOMPRESS2 = YesPlease
 	NO_STRCASESTR = YesPlease
 	NO_MEMMEM = YesPlease
 	USE_ST_TIMESPEC = YesPlease
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

