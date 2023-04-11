Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0575C76196
	for <git@archiver.kernel.org>; Tue, 11 Apr 2023 07:42:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230091AbjDKHma (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Apr 2023 03:42:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230089AbjDKHm0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Apr 2023 03:42:26 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BC5B19AB
        for <git@vger.kernel.org>; Tue, 11 Apr 2023 00:42:18 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id 60-20020a17090a09c200b0023fcc8ce113so9983064pjo.4
        for <git@vger.kernel.org>; Tue, 11 Apr 2023 00:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681198937; x=1683790937;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wCF31ERDmPVP8bKcpefR4prfpe31mqMpRVgy7L58LDw=;
        b=dzJEer+Ph3MEkaYhE3LaHhtge9DuR3OgO3wla7L8iZG4/WSZaNSn57TLbTGbct2gV9
         1ThVeTBHrZgjDk+NKwKP48PFD9ppBXwzKim0s3DNtdVpDwO1ZHES3tpPXTZyAMw/Akkq
         MD4rqIRjPXDaJwLndNy06EB+KEkSsQ5+lj8ZJQ1/VmQCkTckSYPrBHhHKHLvHB2R5hhm
         7NMynpJpAwzjXl/II7+MSkeG5DcpNhEkNI+xWbteSerW+QWA5TIaCDLZW2ohLTQ3JxM+
         fBEapjMjaGrKozsU13FRvDYVkfsUtJdcy1Yc9ViyCHnppUI/HtlQlLUjxaSdxEU6Vu6e
         9sYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681198937; x=1683790937;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wCF31ERDmPVP8bKcpefR4prfpe31mqMpRVgy7L58LDw=;
        b=0dSqoWk6ep+T/MH9quvnVm/hxP/cfAnoLlDUBBqoHRJM1xrmg6xsxo6s9YX2DF5aVD
         aBHkxCOH2pWWZBU3s7z8zfuituk0Ip00K6lQVAfFitRhBup4yPonrvIMcOl2wjXqRG/e
         3YIcwaGJYJE+o3Qi6phxviT02jEjKhs7XjYZNryL6VYnU41mHJuzIkYKhKdHT0znHvyl
         g624+IQago+Lzc1/sfMoljqs4u/10RZ5tyGjUzqEnYTsqEX74pOIQzK9jwg1pNoqM0ig
         Pu3EDsJ9upvpde20v/GlnlAfmMEOZyRUyghN50x11lE2IYxDP9xl6Uq32uLT4BztGj0n
         D58g==
X-Gm-Message-State: AAQBX9eHqRXKeYcIWBbJageefB+sLOh9Q5hLNfKFQc1myRwcJGGXJdfk
        xhSVA/qFYvsaQ2MK2+Hp8y0uvr9z5dk=
X-Google-Smtp-Source: AKy350aUIKS9OgjZ3v3PWjjrBjHcHtcfvBitpv0Er6AysZsIvHBYrktMZ3NPltuwtbJ5RB9SXNxJxw==
X-Received: by 2002:a17:90b:4b44:b0:246:dcdb:8fed with SMTP id mi4-20020a17090b4b4400b00246dcdb8fedmr2269533pjb.36.1681198936863;
        Tue, 11 Apr 2023 00:42:16 -0700 (PDT)
Received: from iron-rod.hsd1.ca.comcast.net ([2601:646:9e80:a0b0::f6a9])
        by smtp.gmail.com with ESMTPSA id az4-20020a170902a58400b001a1deff606fsm8992820plb.125.2023.04.11.00.42.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Apr 2023 00:42:15 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Calvin Wan <calvinwan@google.com>
Subject: [PATCH v3 10/23] git-zlib: move declarations for git-zlib functions from cache.h
Date:   Tue, 11 Apr 2023 00:41:51 -0700
Message-Id: <20230411074204.3024420-5-newren@gmail.com>
X-Mailer: git-send-email 2.40.0.172.g72fe1174621
In-Reply-To: <20230411074204.3024420-1-newren@gmail.com>
References: <pull.1509.v3.git.1681182060.gitgitgadget@gmail.com>
 <20230411074204.3024420-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Move functions from cache.h for zlib.c into a new header file.  Since
adding a "zlib.h" would cause issues with the real zlib, rename zlib.c
to git-zlib.c while we are at it.

Signed-off-by: Elijah Newren <newren@gmail.com>
Acked-by: Calvin Wan <calvinwan@google.com>
---
 Makefile                 |  2 +-
 archive-tar.c            |  1 +
 archive-zip.c            |  1 +
 builtin/unpack-objects.c |  1 +
 cache.h                  | 25 +------------------------
 zlib.c => git-zlib.c     |  3 ++-
 git-zlib.h               | 28 ++++++++++++++++++++++++++++
 http-backend.c           |  1 +
 http.h                   |  3 +++
 9 files changed, 39 insertions(+), 26 deletions(-)
 rename zlib.c => git-zlib.c (99%)
 create mode 100644 git-zlib.h

diff --git a/Makefile b/Makefile
index 50ee51fde32..0c367881bff 100644
--- a/Makefile
+++ b/Makefile
@@ -1036,6 +1036,7 @@ LIB_OBJS += fsmonitor.o
 LIB_OBJS += fsmonitor-ipc.o
 LIB_OBJS += fsmonitor-settings.o
 LIB_OBJS += gettext.o
+LIB_OBJS += git-zlib.o
 LIB_OBJS += gpg-interface.o
 LIB_OBJS += graph.o
 LIB_OBJS += grep.o
@@ -1196,7 +1197,6 @@ LIB_OBJS += write-or-die.o
 LIB_OBJS += ws.o
 LIB_OBJS += wt-status.o
 LIB_OBJS += xdiff-interface.o
-LIB_OBJS += zlib.o
 
 BUILTIN_OBJS += builtin/add.o
 BUILTIN_OBJS += builtin/am.o
diff --git a/archive-tar.c b/archive-tar.c
index 497dad0b3af..4cd81d8161e 100644
--- a/archive-tar.c
+++ b/archive-tar.c
@@ -5,6 +5,7 @@
 #include "alloc.h"
 #include "config.h"
 #include "gettext.h"
+#include "git-zlib.h"
 #include "hex.h"
 #include "tar.h"
 #include "archive.h"
diff --git a/archive-zip.c b/archive-zip.c
index e6f5c10a14f..ef538a90df4 100644
--- a/archive-zip.c
+++ b/archive-zip.c
@@ -5,6 +5,7 @@
 #include "config.h"
 #include "archive.h"
 #include "gettext.h"
+#include "git-zlib.h"
 #include "hex.h"
 #include "streaming.h"
 #include "utf8.h"
diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
index f2c1323e661..ddbdb3dd226 100644
--- a/builtin/unpack-objects.c
+++ b/builtin/unpack-objects.c
@@ -4,6 +4,7 @@
 #include "config.h"
 #include "environment.h"
 #include "gettext.h"
+#include "git-zlib.h"
 #include "hex.h"
 #include "object-store.h"
 #include "object.h"
diff --git a/cache.h b/cache.h
index 21db5da39a5..c06778b69cd 100644
--- a/cache.h
+++ b/cache.h
@@ -3,6 +3,7 @@
 
 #include "git-compat-util.h"
 #include "strbuf.h"
+#include "git-zlib.h"
 #include "hashmap.h"
 #include "list.h"
 #include "gettext.h"
@@ -14,30 +15,6 @@
 #include "repository.h"
 #include "statinfo.h"
 
-typedef struct git_zstream {
-	z_stream z;
-	unsigned long avail_in;
-	unsigned long avail_out;
-	unsigned long total_in;
-	unsigned long total_out;
-	unsigned char *next_in;
-	unsigned char *next_out;
-} git_zstream;
-
-void git_inflate_init(git_zstream *);
-void git_inflate_init_gzip_only(git_zstream *);
-void git_inflate_end(git_zstream *);
-int git_inflate(git_zstream *, int flush);
-
-void git_deflate_init(git_zstream *, int level);
-void git_deflate_init_gzip(git_zstream *, int level);
-void git_deflate_init_raw(git_zstream *, int level);
-void git_deflate_end(git_zstream *);
-int git_deflate_abort(git_zstream *);
-int git_deflate_end_gently(git_zstream *);
-int git_deflate(git_zstream *, int flush);
-unsigned long git_deflate_bound(git_zstream *, unsigned long);
-
 #if defined(DT_UNKNOWN) && !defined(NO_D_TYPE_IN_DIRENT)
 #define DTYPE(de)	((de)->d_type)
 #else
diff --git a/zlib.c b/git-zlib.c
similarity index 99%
rename from zlib.c
rename to git-zlib.c
index d594cba3fc9..d43bbeb6daa 100644
--- a/zlib.c
+++ b/git-zlib.c
@@ -2,7 +2,8 @@
  * zlib wrappers to make sure we don't silently miss errors
  * at init time.
  */
-#include "cache.h"
+#include "git-compat-util.h"
+#include "git-zlib.h"
 
 static const char *zerr_to_string(int status)
 {
diff --git a/git-zlib.h b/git-zlib.h
new file mode 100644
index 00000000000..d8a670aff9f
--- /dev/null
+++ b/git-zlib.h
@@ -0,0 +1,28 @@
+#ifndef GIT_ZLIB_H
+#define GIT_ZLIB_H
+
+typedef struct git_zstream {
+	z_stream z;
+	unsigned long avail_in;
+	unsigned long avail_out;
+	unsigned long total_in;
+	unsigned long total_out;
+	unsigned char *next_in;
+	unsigned char *next_out;
+} git_zstream;
+
+void git_inflate_init(git_zstream *);
+void git_inflate_init_gzip_only(git_zstream *);
+void git_inflate_end(git_zstream *);
+int git_inflate(git_zstream *, int flush);
+
+void git_deflate_init(git_zstream *, int level);
+void git_deflate_init_gzip(git_zstream *, int level);
+void git_deflate_init_raw(git_zstream *, int level);
+void git_deflate_end(git_zstream *);
+int git_deflate_abort(git_zstream *);
+int git_deflate_end_gently(git_zstream *);
+int git_deflate(git_zstream *, int flush);
+unsigned long git_deflate_bound(git_zstream *, unsigned long);
+
+#endif /* GIT_ZLIB_H */
diff --git a/http-backend.c b/http-backend.c
index 89aad1b42c7..d41b3b9e1e7 100644
--- a/http-backend.c
+++ b/http-backend.c
@@ -2,6 +2,7 @@
 #include "alloc.h"
 #include "config.h"
 #include "environment.h"
+#include "git-zlib.h"
 #include "hex.h"
 #include "repository.h"
 #include "refs.h"
diff --git a/http.h b/http.h
index 77c042706c6..783b2b09b8b 100644
--- a/http.h
+++ b/http.h
@@ -1,7 +1,10 @@
 #ifndef HTTP_H
 #define HTTP_H
 
+struct packed_git;
+
 #include "cache.h"
+#include "git-zlib.h"
 
 #include <curl/curl.h>
 #include <curl/easy.h>
-- 
2.40.0.172.g72fe1174621

