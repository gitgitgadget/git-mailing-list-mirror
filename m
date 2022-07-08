Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5766C43334
	for <git@archiver.kernel.org>; Fri,  8 Jul 2022 14:20:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237920AbiGHOUk (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Jul 2022 10:20:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237747AbiGHOUh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Jul 2022 10:20:37 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2C6124F2F
        for <git@vger.kernel.org>; Fri,  8 Jul 2022 07:20:35 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id v16so19318075wrd.13
        for <git@vger.kernel.org>; Fri, 08 Jul 2022 07:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7zodhEbtxRjp+ESmro+zWyrYWci5gq5YFp1u+0UDssk=;
        b=DxP7dKELcw30qDT6E5lVM+opvgPJ+ZOWeSVkQkdhO63BMnnwVb21aP7frHbe/nHqP5
         Ma69ogKXTITJF+94+Jm492g8DLd3r8x86nFb22NktMnPCblx31myNMUnEoa/dIuOGw0U
         N1W04BBfSaSs9gqR9h5BSC7O0eFUS4s1OC81WotSCFhrFsFnq7c2ZC8OAvYK3L7Ndv+I
         dDJ2xx1XwcBFPiEf+TPLlTaDkNX2PIiS0aPZwIYw5bL9679mCUrswQzuBmKCXL0QKaW1
         CsfpeDvwPFwQAFfjkcry6CXIKNei6lAoF1vySaIRx/O2ALQFGm27QeVY0kMVnBQdx2rc
         mccA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7zodhEbtxRjp+ESmro+zWyrYWci5gq5YFp1u+0UDssk=;
        b=hJFMcMySFQ4vx9Q7vZrkW+1zSwAng3+D7hDhBQubJG/30XG3QsiC44G4SqkfYoPdTm
         0hYT64lwZnXURwSJ4VqdCSPwC1J9ftg+zvx7826C0wwQ0UiYWS40ySv9BJ31Of+8bT2i
         J9IDLVgbq8T0UmGifDEoLChv8D10zIBTDR4dG8BgBTIAZsRCzi5QyDO2bjYLw2KjXwxa
         BN7A9EETSuGmBDjeWyj0vI6fJNZd6zkjUxGommpHq7Z16Jm4EEqJlgM17ipSTURjwuO9
         j/0doIurXYsDqeSwa9QQAn7zh3Vli0r9ADvOx53fMZzLE7ZIOvH+0F9y34pKvXyxjy/K
         adsQ==
X-Gm-Message-State: AJIora9tTBi37BmWIXBDD/xxGG4lhtrSPVsWiXJrW7EUa8ZnhUgolCfH
        v4SyB9HdRtZtPQmmUJqZLiYT8JEquGx8UA==
X-Google-Smtp-Source: AGRyM1t/UliQbUVOInxtx/QH0PQ4EVVTeBGxWFl8YM/DuK2Z35c0waqHiXEc4SujIGGNGlQ9bD7ESA==
X-Received: by 2002:a5d:584c:0:b0:21c:1395:f0c4 with SMTP id i12-20020a5d584c000000b0021c1395f0c4mr3606226wrf.24.1657290033939;
        Fri, 08 Jul 2022 07:20:33 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id q5-20020adff945000000b0021b9585276dsm40393924wrr.101.2022.07.08.07.20.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jul 2022 07:20:33 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 2/7] git-shared-util.h: move "shared" allocation utilities here
Date:   Fri,  8 Jul 2022 16:20:14 +0200
Message-Id: <patch-2.7-87f4760bc05-20220708T140354Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.0.913.g189dca38629
In-Reply-To: <cover-0.7-00000000000-20220708T140354Z-avarab@gmail.com>
References: <b34dcb93-df73-f5de-3c7c-7ab6c3250afe@gmail.com> <cover-0.7-00000000000-20220708T140354Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Move the most common allocation utilities from cache.h and
git-compat-util.h to a new git-shared-util.h. The idea is that xdiff/
and other in-tree code can share this, and that external projects
could then copy this header and include it.

They will need to include some things that git-compat-util.h does
before that, e.g. we need a "size_t" here, and if they'll end up using
any of the x*() functions they'll need to declare those. But doing so
should be fairly obvious, and we can always extend this to define some
fallback wrappers here if e.g. GIT_COMPAT_UTIL_H isn't defined.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 cache.h           |  75 ---------------------------------
 git-compat-util.h |  28 ++-----------
 git-shared-util.h | 104 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 108 insertions(+), 99 deletions(-)
 create mode 100644 git-shared-util.h

diff --git a/cache.h b/cache.h
index ac5ab4ef9d3..f29dbbadf77 100644
--- a/cache.h
+++ b/cache.h
@@ -677,81 +677,6 @@ void initialize_repository_version(int hash_algo, int reinit);
 void sanitize_stdfds(void);
 int daemonize(void);
 
-#define alloc_nr(x) (((x)+16)*3/2)
-
-/**
- * Dynamically growing an array using realloc() is error prone and boring.
- *
- * Define your array with:
- *
- * - a pointer (`item`) that points at the array, initialized to `NULL`
- *   (although please name the variable based on its contents, not on its
- *   type);
- *
- * - an integer variable (`alloc`) that keeps track of how big the current
- *   allocation is, initialized to `0`;
- *
- * - another integer variable (`nr`) to keep track of how many elements the
- *   array currently has, initialized to `0`.
- *
- * Then before adding `n`th element to the item, call `ALLOC_GROW(item, n,
- * alloc)`.  This ensures that the array can hold at least `n` elements by
- * calling `realloc(3)` and adjusting `alloc` variable.
- *
- * ------------
- * sometype *item;
- * size_t nr;
- * size_t alloc
- *
- * for (i = 0; i < nr; i++)
- * 	if (we like item[i] already)
- * 		return;
- *
- * // we did not like any existing one, so add one
- * ALLOC_GROW(item, nr + 1, alloc);
- * item[nr++] = value you like;
- * ------------
- *
- * You are responsible for updating the `nr` variable.
- *
- * If you need to specify the number of elements to allocate explicitly
- * then use the macro `REALLOC_ARRAY(item, alloc)` instead of `ALLOC_GROW`.
- *
- * Consider using ALLOC_GROW_BY instead of ALLOC_GROW as it has some
- * added niceties.
- *
- * DO NOT USE any expression with side-effect for 'x', 'nr', or 'alloc'.
- */
-#define ALLOC_GROW(x, nr, alloc) \
-	do { \
-		if ((nr) > alloc) { \
-			if (alloc_nr(alloc) < (nr)) \
-				alloc = (nr); \
-			else \
-				alloc = alloc_nr(alloc); \
-			REALLOC_ARRAY(x, alloc); \
-		} \
-	} while (0)
-
-/*
- * Similar to ALLOC_GROW but handles updating of the nr value and
- * zeroing the bytes of the newly-grown array elements.
- *
- * DO NOT USE any expression with side-effect for any of the
- * arguments.
- */
-#define ALLOC_GROW_BY(x, nr, increase, alloc) \
-	do { \
-		if (increase) { \
-			size_t new_nr = nr + (increase); \
-			if (new_nr < nr) \
-				BUG("negative growth in ALLOC_GROW_BY"); \
-			ALLOC_GROW(x, new_nr, alloc); \
-			memset((x) + nr, 0, sizeof(*(x)) * (increase)); \
-			nr = new_nr; \
-		} \
-	} while (0)
-
 /* Initialize and use the cache information */
 struct lock_file;
 void preload_index(struct index_state *index,
diff --git a/git-compat-util.h b/git-compat-util.h
index 58d7708296b..eb4b27f4846 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -1034,31 +1034,11 @@ FILE *fopen_or_warn(const char *path, const char *mode);
  */
 int xstrncmpz(const char *s, const char *t, size_t len);
 
-/*
- * FREE_AND_NULL(ptr) is like free(ptr) followed by ptr = NULL. Note
- * that ptr is used twice, so don't pass e.g. ptr++.
+/**
+ * Common allocation utils, including ones xdiff uses, and thus are
+ * split into this file for sharing with external projects.
  */
-#define FREE_AND_NULL(p) do { free(p); (p) = NULL; } while (0)
-
-#define ALLOC_ARRAY(x, alloc) (x) = xmalloc(st_mult(sizeof(*(x)), (alloc)))
-#define CALLOC_ARRAY(x, alloc) (x) = xcalloc((alloc), sizeof(*(x)))
-#define REALLOC_ARRAY(x, alloc) (x) = xrealloc((x), st_mult(sizeof(*(x)), (alloc)))
-
-#define COPY_ARRAY(dst, src, n) copy_array((dst), (src), (n), sizeof(*(dst)) + \
-	BUILD_ASSERT_OR_ZERO(sizeof(*(dst)) == sizeof(*(src))))
-static inline void copy_array(void *dst, const void *src, size_t n, size_t size)
-{
-	if (n)
-		memcpy(dst, src, st_mult(size, n));
-}
-
-#define MOVE_ARRAY(dst, src, n) move_array((dst), (src), (n), sizeof(*(dst)) + \
-	BUILD_ASSERT_OR_ZERO(sizeof(*(dst)) == sizeof(*(src))))
-static inline void move_array(void *dst, const void *src, size_t n, size_t size)
-{
-	if (n)
-		memmove(dst, src, st_mult(size, n));
-}
+#include "git-shared-util.h"
 
 /*
  * These functions help you allocate structs with flex arrays, and copy
diff --git a/git-shared-util.h b/git-shared-util.h
new file mode 100644
index 00000000000..7b4479a0f72
--- /dev/null
+++ b/git-shared-util.h
@@ -0,0 +1,104 @@
+#ifndef GIT_SHARED_UTIL_H
+#define GIT_SHARED_UTIL_H
+
+/*
+ * FREE_AND_NULL(ptr) is like free(ptr) followed by ptr = NULL. Note
+ * that ptr is used twice, so don't pass e.g. ptr++.
+ */
+#define FREE_AND_NULL(p) do { free(p); (p) = NULL; } while (0)
+
+#define ALLOC_ARRAY(x, alloc) (x) = xmalloc(st_mult(sizeof(*(x)), (alloc)))
+#define CALLOC_ARRAY(x, alloc) (x) = xcalloc((alloc), sizeof(*(x)))
+#define REALLOC_ARRAY(x, alloc) (x) = xrealloc((x), st_mult(sizeof(*(x)), (alloc)))
+
+#define COPY_ARRAY(dst, src, n) copy_array((dst), (src), (n), sizeof(*(dst)) + \
+	BUILD_ASSERT_OR_ZERO(sizeof(*(dst)) == sizeof(*(src))))
+static inline void copy_array(void *dst, const void *src, size_t n, size_t size)
+{
+	if (n)
+		memcpy(dst, src, st_mult(size, n));
+}
+
+#define MOVE_ARRAY(dst, src, n) move_array((dst), (src), (n), sizeof(*(dst)) + \
+	BUILD_ASSERT_OR_ZERO(sizeof(*(dst)) == sizeof(*(src))))
+static inline void move_array(void *dst, const void *src, size_t n, size_t size)
+{
+	if (n)
+		memmove(dst, src, st_mult(size, n));
+}
+
+#define alloc_nr(x) (((x)+16)*3/2)
+
+/**
+ * Dynamically growing an array using realloc() is error prone and boring.
+ *
+ * Define your array with:
+ *
+ * - a pointer (`item`) that points at the array, initialized to `NULL`
+ *   (although please name the variable based on its contents, not on its
+ *   type);
+ *
+ * - an integer variable (`alloc`) that keeps track of how big the current
+ *   allocation is, initialized to `0`;
+ *
+ * - another integer variable (`nr`) to keep track of how many elements the
+ *   array currently has, initialized to `0`.
+ *
+ * Then before adding `n`th element to the item, call `ALLOC_GROW(item, n,
+ * alloc)`.  This ensures that the array can hold at least `n` elements by
+ * calling `realloc(3)` and adjusting `alloc` variable.
+ *
+ * ------------
+ * sometype *item;
+ * size_t nr;
+ * size_t alloc
+ *
+ * for (i = 0; i < nr; i++)
+ * 	if (we like item[i] already)
+ * 		return;
+ *
+ * // we did not like any existing one, so add one
+ * ALLOC_GROW(item, nr + 1, alloc);
+ * item[nr++] = value you like;
+ * ------------
+ *
+ * You are responsible for updating the `nr` variable.
+ *
+ * If you need to specify the number of elements to allocate explicitly
+ * then use the macro `REALLOC_ARRAY(item, alloc)` instead of `ALLOC_GROW`.
+ *
+ * Consider using ALLOC_GROW_BY instead of ALLOC_GROW as it has some
+ * added niceties.
+ *
+ * DO NOT USE any expression with side-effect for 'x', 'nr', or 'alloc'.
+ */
+#define ALLOC_GROW(x, nr, alloc) \
+	do { \
+		if ((nr) > alloc) { \
+			if (alloc_nr(alloc) < (nr)) \
+				alloc = (nr); \
+			else \
+				alloc = alloc_nr(alloc); \
+			REALLOC_ARRAY(x, alloc); \
+		} \
+	} while (0)
+
+/*
+ * Similar to ALLOC_GROW but handles updating of the nr value and
+ * zeroing the bytes of the newly-grown array elements.
+ *
+ * DO NOT USE any expression with side-effect for any of the
+ * arguments.
+ */
+#define ALLOC_GROW_BY(x, nr, increase, alloc) \
+	do { \
+		if (increase) { \
+			size_t new_nr = nr + (increase); \
+			if (new_nr < nr) \
+				BUG("negative growth in ALLOC_GROW_BY"); \
+			ALLOC_GROW(x, new_nr, alloc); \
+			memset((x) + nr, 0, sizeof(*(x)) * (increase)); \
+			nr = new_nr; \
+		} \
+	} while (0)
+#endif
-- 
2.37.0.913.g189dca38629

