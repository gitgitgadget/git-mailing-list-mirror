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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26378C43462
	for <git@archiver.kernel.org>; Mon, 19 Apr 2021 11:38:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 042E061288
	for <git@archiver.kernel.org>; Mon, 19 Apr 2021 11:38:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238846AbhDSLjN (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Apr 2021 07:39:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238715AbhDSLii (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Apr 2021 07:38:38 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C1D4C06138D
        for <git@vger.kernel.org>; Mon, 19 Apr 2021 04:38:08 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id e5so4998565wrg.7
        for <git@vger.kernel.org>; Mon, 19 Apr 2021 04:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=68pLmCaint3lQjfMXOVfl+fz3vWfd4+/uPb6z55i5JM=;
        b=ngHEiHXJnHZEss82LOEApown0cFhpUN54X0PTzrcrDRjSnDks93SYlnXFCZm6L+pAY
         xJUM2yWkLK1W9/yozVr0EpMW9D+GZDqL6wxRssvykr1fu1dP5zetQRCSTmI9tt9YMc6u
         MNcc0KBx7JkXciZMkaxdH8UMULYBAipfkZ+JMC+XGbVXZ3DhUunpvrd/dcg4/jEp9rNY
         /9+pik68s6M+qqF2Rgqnele0w87lbqSU89zVztXFo7a600d+hg1hYhl9nZxGkwp7SkWC
         LZm+h1eiuZIA3qTh8x0MWEFMRAVO3/IEhs9b/0oRDg1UNRYOOWNOgQipATfrvTdFxdri
         1yWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=68pLmCaint3lQjfMXOVfl+fz3vWfd4+/uPb6z55i5JM=;
        b=lmnkMmnxYPHAAuHm1Y1Glnxv7sJLwBckyqvcvwiPR/BMxhVUZNgfG5W9zjZyR3VuYP
         YxLQ2W0cDqQX5LOd/dV4WHj9IEY2H0iZw3vBFXFH/J0TtG27hQRWpQv+I+WjbqOkIfD+
         +O7I8Wqi3DZQtX7PN62+RR3wothacdt7aAqxGH0fETuZKaZqMcdxYp0JAOfXR819TXI9
         T77wY6te00zCItntIltTWB2Qp7BYyCmTHaU64cA4BC7x1qgv0PSqzsIWUWOpR8CqYnIR
         rcI1jnvvkenK8qxsR0nD5SGpFaiDXmyPLjdvoGV4bCsCW0enKCktsP5LJs98yoR7W/Gn
         /Ikw==
X-Gm-Message-State: AOAM532zG92CWS1OQTlI4CFAElgItTtoPml7SggJ8SNkLTMG60RcjZoa
        XMOKrAX8cteKzSX2L0fp7qH71UsxNFM=
X-Google-Smtp-Source: ABdhPJy6cSWMp3Kn1iedHjWjw2pbJhNeaCK43wI9MkPjfXWGvAbBTntuzc8ytjbFVOAhhV/6VAzZ0w==
X-Received: by 2002:adf:fdcd:: with SMTP id i13mr13654323wrs.185.1618832286785;
        Mon, 19 Apr 2021 04:38:06 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n18sm16390883wrw.11.2021.04.19.04.38.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Apr 2021 04:38:06 -0700 (PDT)
Message-Id: <0c2604d7e7d453fb86a00c97a139fb593b54eef3.1618832277.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.847.v7.git.git.1618832276.gitgitgadget@gmail.com>
References: <pull.847.v6.git.git.1618255552.gitgitgadget@gmail.com>
        <pull.847.v7.git.git.1618832276.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 19 Apr 2021 11:37:39 +0000
Subject: [PATCH v7 11/28] Provide zlib's uncompress2 from compat/zlib-compat.c
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwen@google.com>, Jeff King <peff@peff.net>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>,
        Josh Steadmon <steadmon@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Patrick Steinhardt <ps@pks.im>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Felipe Contreras <felipe.contreras@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Han-Wen Nienhuys g <hanwen@google.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

This will be needed for reading reflog blocks in reftable.

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 Makefile                  |  7 +++
 compat/.gitattributes     |  1 +
 compat/zlib-uncompress2.c | 92 +++++++++++++++++++++++++++++++++++++++
 configure.ac              | 13 ++++++
 git-compat-util.h         |  4 ++
 5 files changed, 117 insertions(+)
 create mode 100644 compat/.gitattributes
 create mode 100644 compat/zlib-uncompress2.c

diff --git a/Makefile b/Makefile
index d6bc336c5565..e6df765d3361 100644
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
@@ -1706,6 +1708,11 @@ ifdef NO_DEFLATE_BOUND
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
diff --git a/compat/.gitattributes b/compat/.gitattributes
new file mode 100644
index 000000000000..40dbfb170dab
--- /dev/null
+++ b/compat/.gitattributes
@@ -0,0 +1 @@
+/zlib-uncompress2.c	whitespace=-indent-with-non-tab,-trailing-space
diff --git a/compat/zlib-uncompress2.c b/compat/zlib-uncompress2.c
new file mode 100644
index 000000000000..0adc5ee7eeb6
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
+#include "system.h"
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
index 031e8d3fee8f..c3a913103d00 100644
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
diff --git a/git-compat-util.h b/git-compat-util.h
index a508dbe5a351..d405d0bd7a79 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -1382,4 +1382,8 @@ static inline void *container_of_or_null_offset(void *ptr, size_t offset)
 
 void sleep_millisec(int millisec);
 
+#ifdef NO_UNCOMPRESS2
+
+#endif
+
 #endif
-- 
gitgitgadget

