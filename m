Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79358C64E7B
	for <git@archiver.kernel.org>; Thu, 26 Nov 2020 19:42:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 34178221F9
	for <git@archiver.kernel.org>; Thu, 26 Nov 2020 19:42:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TFvZXXzy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404707AbgKZTmn (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Nov 2020 14:42:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404660AbgKZTmm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Nov 2020 14:42:42 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0AD3C0617A7
        for <git@vger.kernel.org>; Thu, 26 Nov 2020 11:42:40 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id u12so3359004wrt.0
        for <git@vger.kernel.org>; Thu, 26 Nov 2020 11:42:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Mvbacpm6O4pfAzXQ0LeQJUXKdHKeXLI4VuesudyJaFc=;
        b=TFvZXXzyV53E9jHjYK6/FjHh8kxnCWPVJj/1oUqf1+SKz7TEKCevY5N0kC+g3VNSQ9
         iytS8o+prGtN6XEYNyCTOH4+C+X6mdeXMYE6tJCGibFMORQ6PYBv5+nKtxHVFWRFsyFf
         04tXphrRQ15xsoj5aP9hZyF614RIkfaDEQd+qnK3n/NcP9sXjP0YN1ROD5dnwwBXz54E
         uZBegevjnbWZurCvZWHBlgFT9CXPadk6ZH+RzDnnij04VxjAmYimUItJwqY0ybDT0rBy
         2x2hP5JJEEXlhCUeYndBCOy/vHpUV2MJ8N73zpBHMSG56tjkzIYZP1efrwoG0gUCT8N3
         n/yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Mvbacpm6O4pfAzXQ0LeQJUXKdHKeXLI4VuesudyJaFc=;
        b=rHOqAgZgunDomTS9KB97eq/0ILez8Qkb2YFZ8WypuNB+E6t8uUbUWtRzX7AujHbnMp
         7J+F/CAhOXcfacKwV/hvtr58Ex2NhxFTbmJ10ZUdXSmYj6K5MQHbySQf1LirHTIQge50
         PHQxxnruRYthsVjzhM5XfTbfBB6gv4EKsLGefYyFT3hNZvNEZXkfNSOUNlThNbgDjxfo
         JCZxWvug4lywMFGOS6gamkLgr5OXqutSLFKGxah1QPVs6cYbcHUjNYDgB0PAnYhUpJY3
         wRk08r5L+R7S0OOQYWkr/0KmCfDaqBmmGdOi2Lzqo2KJceK+2As9rD4O6T4w0z7a7n7u
         w9AA==
X-Gm-Message-State: AOAM531Hb0rE/aWPxOes8A1quW7Q9I3A/MdcIgl43w/PAZSlDEqfPPjy
        1ixr11NZyR1AkSESKB2I1Yj1CuvsjAI=
X-Google-Smtp-Source: ABdhPJxNB/gnBkQaHwH3cgvqdiZPgGniGcA2cx46kQJNr/qq/euiRGohBaQ/WiS/Vv/U74eemegSFg==
X-Received: by 2002:a5d:4052:: with SMTP id w18mr6009336wrp.63.1606419758879;
        Thu, 26 Nov 2020 11:42:38 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q17sm12499387wro.36.2020.11.26.11.42.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2020 11:42:38 -0800 (PST)
Message-Id: <987d1d186fd68d604268f9a66118b7f276094daf.1606419752.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.847.v3.git.git.1606419752.gitgitgadget@gmail.com>
References: <pull.847.v2.git.git.1601568663.gitgitgadget@gmail.com>
        <pull.847.v3.git.git.1606419752.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 26 Nov 2020 19:42:20 +0000
Subject: [PATCH v3 05/16] reftable: utility functions
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
        <avarab@gmail.com>, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

This commit provides basic utility classes for the reftable library.

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 Makefile                     |  24 +++++-
 reftable/basics.c            | 144 +++++++++++++++++++++++++++++++++++
 reftable/basics.h            |  56 ++++++++++++++
 reftable/basics_test.c       |  56 ++++++++++++++
 reftable/compat.h            |  48 ++++++++++++
 reftable/publicbasics.c      |  58 ++++++++++++++
 reftable/reftable-malloc.h   |  20 +++++
 reftable/reftable-tests.h    |  22 ++++++
 reftable/system.h            |  32 ++++++++
 reftable/test_framework.c    |  23 ++++++
 reftable/test_framework.h    |  48 ++++++++++++
 t/helper/test-reftable.c     |   9 +++
 t/helper/test-tool.c         |   3 +-
 t/helper/test-tool.h         |   1 +
 t/t0032-reftable-unittest.sh |  14 ++++
 15 files changed, 554 insertions(+), 4 deletions(-)
 create mode 100644 reftable/basics.c
 create mode 100644 reftable/basics.h
 create mode 100644 reftable/basics_test.c
 create mode 100644 reftable/compat.h
 create mode 100644 reftable/publicbasics.c
 create mode 100644 reftable/reftable-malloc.h
 create mode 100644 reftable/reftable-tests.h
 create mode 100644 reftable/system.h
 create mode 100644 reftable/test_framework.c
 create mode 100644 reftable/test_framework.h
 create mode 100644 t/helper/test-reftable.c
 create mode 100755 t/t0032-reftable-unittest.sh

diff --git a/Makefile b/Makefile
index dd1cf41e00..5ce78772fd 100644
--- a/Makefile
+++ b/Makefile
@@ -732,6 +732,7 @@ TEST_BUILTINS_OBJS += test-read-cache.o
 TEST_BUILTINS_OBJS += test-read-graph.o
 TEST_BUILTINS_OBJS += test-read-midx.o
 TEST_BUILTINS_OBJS += test-ref-store.o
+TEST_BUILTINS_OBJS += test-reftable.o
 TEST_BUILTINS_OBJS += test-regex.o
 TEST_BUILTINS_OBJS += test-repository.o
 TEST_BUILTINS_OBJS += test-revision-walking.o
@@ -821,6 +822,8 @@ TEST_SHELL_PATH = $(SHELL_PATH)
 
 LIB_FILE = libgit.a
 XDIFF_LIB = xdiff/lib.a
+REFTABLE_LIB = reftable/libreftable.a
+REFTABLE_TEST_LIB = reftable/libreftable_test.a
 
 GENERATED_H += command-list.h
 GENERATED_H += config-list.h
@@ -1185,7 +1188,7 @@ THIRD_PARTY_SOURCES += compat/regex/%
 THIRD_PARTY_SOURCES += sha1collisiondetection/%
 THIRD_PARTY_SOURCES += sha1dc/%
 
-GITLIBS = common-main.o $(LIB_FILE) $(XDIFF_LIB)
+GITLIBS = common-main.o $(LIB_FILE) $(XDIFF_LIB) $(REFTABLE_LIB)
 EXTLIBS =
 
 GIT_USER_AGENT = git/$(GIT_VERSION)
@@ -2386,10 +2389,19 @@ XDIFF_OBJS += xdiff/xpatience.o
 XDIFF_OBJS += xdiff/xprepare.o
 XDIFF_OBJS += xdiff/xutils.o
 
+REFTABLE_OBJS += reftable/basics.o
+REFTABLE_OBJS += reftable/error.o
+REFTABLE_OBJS += reftable/publicbasics.o
+
+REFTABLE_TEST_OBJS += reftable/test_framework.o
+REFTABLE_TEST_OBJS += reftable/basics_test.o
+
 TEST_OBJS := $(patsubst %$X,%.o,$(TEST_PROGRAMS)) $(patsubst %,t/helper/%,$(TEST_BUILTINS_OBJS))
 OBJECTS := $(LIB_OBJS) $(BUILTIN_OBJS) $(PROGRAM_OBJS) $(TEST_OBJS) \
 	$(XDIFF_OBJS) \
 	$(FUZZ_OBJS) \
+	$(REFTABLE_OBJS) \
+	$(REFTABLE_TEST_OBJS) \
 	common-main.o \
 	git.o
 ifndef NO_CURL
@@ -2541,6 +2553,12 @@ $(LIB_FILE): $(LIB_OBJS)
 $(XDIFF_LIB): $(XDIFF_OBJS)
 	$(QUIET_AR)$(RM) $@ && $(AR) $(ARFLAGS) $@ $^
 
+$(REFTABLE_LIB): $(REFTABLE_OBJS)
+	$(QUIET_AR)$(RM) $@ && $(AR) $(ARFLAGS) $@ $^
+
+$(REFTABLE_TEST_LIB): $(REFTABLE_TEST_OBJS)
+	$(QUIET_AR)$(RM) $@ && $(AR) $(ARFLAGS) $@ $^
+
 export DEFAULT_EDITOR DEFAULT_PAGER
 
 Documentation/GIT-EXCLUDED-PROGRAMS: FORCE
@@ -2822,7 +2840,7 @@ perf: all
 
 t/helper/test-tool$X: $(patsubst %,t/helper/%,$(TEST_BUILTINS_OBJS))
 
-t/helper/test-%$X: t/helper/test-%.o GIT-LDFLAGS $(GITLIBS)
+t/helper/test-%$X: t/helper/test-%.o GIT-LDFLAGS $(GITLIBS) $(REFTABLE_TEST_LIB)
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) $(filter %.a,$^) $(LIBS)
 
 check-sha1:: t/helper/test-tool$X
@@ -3151,7 +3169,7 @@ cocciclean:
 clean: profile-clean coverage-clean cocciclean
 	$(RM) *.res
 	$(RM) $(OBJECTS)
-	$(RM) $(LIB_FILE) $(XDIFF_LIB)
+	$(RM) $(LIB_FILE) $(XDIFF_LIB) $(REFTABLE_LIB) $(REFTABLE_TEST_LIB)
 	$(RM) $(ALL_PROGRAMS) $(SCRIPT_LIB) $(BUILT_INS) git$X
 	$(RM) $(TEST_PROGRAMS)
 	$(RM) $(FUZZ_PROGRAMS)
diff --git a/reftable/basics.c b/reftable/basics.c
new file mode 100644
index 0000000000..915c55e0ee
--- /dev/null
+++ b/reftable/basics.c
@@ -0,0 +1,144 @@
+/*
+Copyright 2020 Google LLC
+
+Use of this source code is governed by a BSD-style
+license that can be found in the LICENSE file or at
+https://developers.google.com/open-source/licenses/bsd
+*/
+
+#include "basics.h"
+
+void put_be24(uint8_t *out, uint32_t i)
+{
+	out[0] = (uint8_t)((i >> 16) & 0xff);
+	out[1] = (uint8_t)((i >> 8) & 0xff);
+	out[2] = (uint8_t)(i & 0xff);
+}
+
+uint32_t get_be24(uint8_t *in)
+{
+	return (uint32_t)(in[0]) << 16 | (uint32_t)(in[1]) << 8 |
+	       (uint32_t)(in[2]);
+}
+
+void put_be16(uint8_t *out, uint16_t i)
+{
+	out[0] = (uint8_t)((i >> 8) & 0xff);
+	out[1] = (uint8_t)(i & 0xff);
+}
+
+int binsearch(size_t sz, int (*f)(size_t k, void *args), void *args)
+{
+	size_t lo = 0;
+	size_t hi = sz;
+
+	/* invariant: (hi == sz) || f(hi) == true
+	   (lo == 0 && f(0) == true) || fi(lo) == false
+	 */
+	while (hi - lo > 1) {
+		size_t mid = lo + (hi - lo) / 2;
+
+		int val = f(mid, args);
+		if (val) {
+			hi = mid;
+		} else {
+			lo = mid;
+		}
+	}
+
+	if (lo == 0) {
+		if (f(0, args)) {
+			return 0;
+		} else {
+			return 1;
+		}
+	}
+
+	return hi;
+}
+
+void free_names(char **a)
+{
+	char **p = a;
+	if (p == NULL) {
+		return;
+	}
+	while (*p) {
+		reftable_free(*p);
+		p++;
+	}
+	reftable_free(a);
+}
+
+int names_length(char **names)
+{
+	int len = 0;
+	char **p = names;
+	while (*p) {
+		p++;
+		len++;
+	}
+	return len;
+}
+
+void parse_names(char *buf, int size, char ***namesp)
+{
+	char **names = NULL;
+	size_t names_cap = 0;
+	size_t names_len = 0;
+
+	char *p = buf;
+	char *end = buf + size;
+	while (p < end) {
+		char *next = strchr(p, '\n');
+		if (next != NULL) {
+			*next = 0;
+		} else {
+			next = end;
+		}
+		if (p < next) {
+			if (names_len == names_cap) {
+				names_cap = 2 * names_cap + 1;
+				names = reftable_realloc(
+					names, names_cap * sizeof(char *));
+			}
+			names[names_len++] = xstrdup(p);
+		}
+		p = next + 1;
+	}
+
+	if (names_len == names_cap) {
+		names_cap = 2 * names_cap + 1;
+		names = reftable_realloc(names, names_cap * sizeof(char *));
+	}
+
+	names[names_len] = NULL;
+	*namesp = names;
+}
+
+int names_equal(char **a, char **b)
+{
+	while (*a && *b) {
+		if (strcmp(*a, *b)) {
+			return 0;
+		}
+
+		a++;
+		b++;
+	}
+
+	return *a == *b;
+}
+
+int common_prefix_size(struct strbuf *a, struct strbuf *b)
+{
+	int p = 0;
+	while (p < a->len && p < b->len) {
+		if (a->buf[p] != b->buf[p]) {
+			break;
+		}
+		p++;
+	}
+
+	return p;
+}
diff --git a/reftable/basics.h b/reftable/basics.h
new file mode 100644
index 0000000000..0948926637
--- /dev/null
+++ b/reftable/basics.h
@@ -0,0 +1,56 @@
+/*
+Copyright 2020 Google LLC
+
+Use of this source code is governed by a BSD-style
+license that can be found in the LICENSE file or at
+https://developers.google.com/open-source/licenses/bsd
+*/
+
+#ifndef BASICS_H
+#define BASICS_H
+
+/*
+ * miscellaneous utilities that are not provided by Git.
+ */
+
+#include "system.h"
+
+/* Bigendian en/decoding of integers */
+
+void put_be24(uint8_t *out, uint32_t i);
+uint32_t get_be24(uint8_t *in);
+void put_be16(uint8_t *out, uint16_t i);
+
+/*
+  find smallest index i in [0, sz) at which f(i) is true, assuming
+  that f is ascending. Return sz if f(i) is false for all indices.
+*/
+int binsearch(size_t sz, int (*f)(size_t k, void *args), void *args);
+
+/*
+  Frees a NULL terminated array of malloced strings. The array itself is also
+  freed.
+ */
+void free_names(char **a);
+
+/* parse a newline separated list of names. Empty names are discarded. */
+void parse_names(char *buf, int size, char ***namesp);
+
+/* compares two NULL-terminated arrays of strings. */
+int names_equal(char **a, char **b);
+
+/* returns the array size of a NULL-terminated array of strings. */
+int names_length(char **names);
+
+/* Allocation routines; they invoke the functions set through
+ * reftable_set_alloc() */
+void *reftable_malloc(size_t sz);
+void *reftable_realloc(void *p, size_t sz);
+void reftable_free(void *p);
+void *reftable_calloc(size_t sz);
+
+/* Find the longest shared prefix size of `a` and `b` */
+struct strbuf;
+int common_prefix_size(struct strbuf *a, struct strbuf *b);
+
+#endif
diff --git a/reftable/basics_test.c b/reftable/basics_test.c
new file mode 100644
index 0000000000..593d3e608a
--- /dev/null
+++ b/reftable/basics_test.c
@@ -0,0 +1,56 @@
+/*
+Copyright 2020 Google LLC
+
+Use of this source code is governed by a BSD-style
+license that can be found in the LICENSE file or at
+https://developers.google.com/open-source/licenses/bsd
+*/
+
+#include "system.h"
+
+#include "basics.h"
+#include "test_framework.h"
+#include "reftable-tests.h"
+
+struct binsearch_args {
+	int key;
+	int *arr;
+};
+
+static int binsearch_func(size_t i, void *void_args)
+{
+	struct binsearch_args *args = (struct binsearch_args *)void_args;
+
+	return args->key < args->arr[i];
+}
+
+static void test_binsearch(void)
+{
+	int arr[] = { 2, 4, 6, 8, 10 };
+	size_t sz = ARRAY_SIZE(arr);
+	struct binsearch_args args = {
+		.arr = arr,
+	};
+
+	int i = 0;
+	for (i = 1; i < 11; i++) {
+		int res;
+		args.key = i;
+		res = binsearch(sz, &binsearch_func, &args);
+
+		if (res < sz) {
+			EXPECT(args.key < arr[res]);
+			if (res > 0) {
+				EXPECT(args.key >= arr[res - 1]);
+			}
+		} else {
+			EXPECT(args.key == 10 || args.key == 11);
+		}
+	}
+}
+
+int basics_test_main(int argc, const char *argv[])
+{
+	test_binsearch();
+	return 0;
+}
diff --git a/reftable/compat.h b/reftable/compat.h
new file mode 100644
index 0000000000..a765c57e96
--- /dev/null
+++ b/reftable/compat.h
@@ -0,0 +1,48 @@
+/*
+Copyright 2020 Google LLC
+
+Use of this source code is governed by a BSD-style
+license that can be found in the LICENSE file or at
+https://developers.google.com/open-source/licenses/bsd
+*/
+
+#ifndef COMPAT_H
+#define COMPAT_H
+
+#include "system.h"
+
+#ifdef REFTABLE_STANDALONE
+
+/* functions that git-core provides, for standalone compilation */
+#include <stdint.h>
+
+uint64_t get_be64(void *in);
+void put_be64(void *out, uint64_t i);
+
+void put_be32(void *out, uint32_t i);
+uint32_t get_be32(uint8_t *in);
+
+uint16_t get_be16(uint8_t *in);
+
+#define ARRAY_SIZE(a) sizeof((a)) / sizeof((a)[0])
+#define FREE_AND_NULL(x)          \
+	do {                      \
+		reftable_free(x); \
+		(x) = NULL;       \
+	} while (0)
+#define QSORT(arr, n, cmp) qsort(arr, n, sizeof(arr[0]), cmp)
+#define SWAP(a, b)                              \
+	{                                       \
+		char tmp[sizeof(a)];            \
+		assert(sizeof(a) == sizeof(b)); \
+		memcpy(&tmp[0], &a, sizeof(a)); \
+		memcpy(&a, &b, sizeof(a));      \
+		memcpy(&b, &tmp[0], sizeof(a)); \
+	}
+
+char *xstrdup(const char *s);
+
+void sleep_millisec(int millisecs);
+
+#endif
+#endif
diff --git a/reftable/publicbasics.c b/reftable/publicbasics.c
new file mode 100644
index 0000000000..25639f61af
--- /dev/null
+++ b/reftable/publicbasics.c
@@ -0,0 +1,58 @@
+/*
+Copyright 2020 Google LLC
+
+Use of this source code is governed by a BSD-style
+license that can be found in the LICENSE file or at
+https://developers.google.com/open-source/licenses/bsd
+*/
+
+#include "reftable-malloc.h"
+
+#include "basics.h"
+#include "system.h"
+
+static void *(*reftable_malloc_ptr)(size_t sz) = &malloc;
+static void *(*reftable_realloc_ptr)(void *, size_t) = &realloc;
+static void (*reftable_free_ptr)(void *) = &free;
+
+void *reftable_malloc(size_t sz)
+{
+	return (*reftable_malloc_ptr)(sz);
+}
+
+void *reftable_realloc(void *p, size_t sz)
+{
+	return (*reftable_realloc_ptr)(p, sz);
+}
+
+void reftable_free(void *p)
+{
+	reftable_free_ptr(p);
+}
+
+void *reftable_calloc(size_t sz)
+{
+	void *p = reftable_malloc(sz);
+	memset(p, 0, sz);
+	return p;
+}
+
+void reftable_set_alloc(void *(*malloc)(size_t),
+			void *(*realloc)(void *, size_t), void (*free)(void *))
+{
+	reftable_malloc_ptr = malloc;
+	reftable_realloc_ptr = realloc;
+	reftable_free_ptr = free;
+}
+
+int hash_size(uint32_t id)
+{
+	switch (id) {
+	case 0:
+	case SHA1_ID:
+		return SHA1_SIZE;
+	case SHA256_ID:
+		return SHA256_SIZE;
+	}
+	abort();
+}
diff --git a/reftable/reftable-malloc.h b/reftable/reftable-malloc.h
new file mode 100644
index 0000000000..f3571b5f4f
--- /dev/null
+++ b/reftable/reftable-malloc.h
@@ -0,0 +1,20 @@
+/*
+Copyright 2020 Google LLC
+
+Use of this source code is governed by a BSD-style
+license that can be found in the LICENSE file or at
+https://developers.google.com/open-source/licenses/bsd
+*/
+
+#ifndef REFTABLE_H
+#define REFTABLE_H
+
+#include <stddef.h>
+
+/*
+  Overrides the functions to use for memory management.
+ */
+void reftable_set_alloc(void *(*malloc)(size_t),
+			void *(*realloc)(void *, size_t), void (*free)(void *));
+
+#endif
diff --git a/reftable/reftable-tests.h b/reftable/reftable-tests.h
new file mode 100644
index 0000000000..5e7698ae65
--- /dev/null
+++ b/reftable/reftable-tests.h
@@ -0,0 +1,22 @@
+/*
+Copyright 2020 Google LLC
+
+Use of this source code is governed by a BSD-style
+license that can be found in the LICENSE file or at
+https://developers.google.com/open-source/licenses/bsd
+*/
+
+#ifndef REFTABLE_TESTS_H
+#define REFTABLE_TESTS_H
+
+int basics_test_main(int argc, const char **argv);
+int block_test_main(int argc, const char **argv);
+int merged_test_main(int argc, const char **argv);
+int record_test_main(int argc, const char **argv);
+int refname_test_main(int argc, const char **argv);
+int reftable_test_main(int argc, const char **argv);
+int stack_test_main(int argc, const char **argv);
+int tree_test_main(int argc, const char **argv);
+int reftable_dump_main(int argc, char *const *argv);
+
+#endif
diff --git a/reftable/system.h b/reftable/system.h
new file mode 100644
index 0000000000..07277ca062
--- /dev/null
+++ b/reftable/system.h
@@ -0,0 +1,32 @@
+/*
+Copyright 2020 Google LLC
+
+Use of this source code is governed by a BSD-style
+license that can be found in the LICENSE file or at
+https://developers.google.com/open-source/licenses/bsd
+*/
+
+#ifndef SYSTEM_H
+#define SYSTEM_H
+
+#include "git-compat-util.h"
+#include "strbuf.h"
+
+#include <zlib.h>
+
+struct strbuf;
+/* In git, this is declared in dir.h */
+int remove_dir_recursively(struct strbuf *path, int flags);
+
+#define SHA1_ID 0x73686131
+#define SHA256_ID 0x73323536
+#define SHA1_SIZE 20
+#define SHA256_SIZE 32
+
+/* This is uncompress2, which is only available in zlib as of 2017.
+ */
+int uncompress_return_consumed(Bytef *dest, uLongf *destLen,
+			       const Bytef *source, uLong *sourceLen);
+int hash_size(uint32_t id);
+
+#endif
diff --git a/reftable/test_framework.c b/reftable/test_framework.c
new file mode 100644
index 0000000000..a5ff4e2a2d
--- /dev/null
+++ b/reftable/test_framework.c
@@ -0,0 +1,23 @@
+/*
+Copyright 2020 Google LLC
+
+Use of this source code is governed by a BSD-style
+license that can be found in the LICENSE file or at
+https://developers.google.com/open-source/licenses/bsd
+*/
+
+#include "system.h"
+#include "test_framework.h"
+
+#include "basics.h"
+
+void set_test_hash(uint8_t *p, int i)
+{
+	memset(p, (uint8_t)i, hash_size(SHA1_ID));
+}
+
+int strbuf_add_void(void *b, const void *data, size_t sz)
+{
+	strbuf_add((struct strbuf *)b, data, sz);
+	return sz;
+}
diff --git a/reftable/test_framework.h b/reftable/test_framework.h
new file mode 100644
index 0000000000..18eec29aba
--- /dev/null
+++ b/reftable/test_framework.h
@@ -0,0 +1,48 @@
+/*
+Copyright 2020 Google LLC
+
+Use of this source code is governed by a BSD-style
+license that can be found in the LICENSE file or at
+https://developers.google.com/open-source/licenses/bsd
+*/
+
+#ifndef TEST_FRAMEWORK_H
+#define TEST_FRAMEWORK_H
+
+#include "system.h"
+#include "reftable-error.h"
+
+#define EXPECT_ERR(c)                                                  \
+	if (c != 0) {                                                  \
+		fflush(stderr);                                        \
+		fflush(stdout);                                        \
+		fprintf(stderr, "%s: %d: error == %d (%s), want 0\n",  \
+			__FILE__, __LINE__, c, reftable_error_str(c)); \
+		abort();                                               \
+	}
+
+#define EXPECT_STREQ(a, b)                                               \
+	if (strcmp(a, b)) {                                              \
+		fflush(stderr);                                          \
+		fflush(stdout);                                          \
+		fprintf(stderr, "%s:%d: %s (%s) != %s (%s)\n", __FILE__, \
+			__LINE__, #a, a, #b, b);                         \
+		abort();                                                 \
+	}
+
+#define EXPECT(c)                                                          \
+	if (!(c)) {                                                        \
+		fflush(stderr);                                            \
+		fflush(stdout);                                            \
+		fprintf(stderr, "%s: %d: failed assertion %s\n", __FILE__, \
+			__LINE__, #c);                                     \
+		abort();                                                   \
+	}
+
+void set_test_hash(uint8_t *p, int i);
+
+/* Like strbuf_add, but suitable for passing to reftable_new_writer
+ */
+int strbuf_add_void(void *b, const void *data, size_t sz);
+
+#endif
diff --git a/t/helper/test-reftable.c b/t/helper/test-reftable.c
new file mode 100644
index 0000000000..3b58e423e7
--- /dev/null
+++ b/t/helper/test-reftable.c
@@ -0,0 +1,9 @@
+#include "reftable/reftable-tests.h"
+#include "test-tool.h"
+
+int cmd__reftable(int argc, const char **argv)
+{
+	basics_test_main(argc, argv);
+
+	return 0;
+}
diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
index 9d6d14d929..0208a0a41c 100644
--- a/t/helper/test-tool.c
+++ b/t/helper/test-tool.c
@@ -48,13 +48,14 @@ static struct test_cmd cmds[] = {
 	{ "path-utils", cmd__path_utils },
 	{ "pkt-line", cmd__pkt_line },
 	{ "prio-queue", cmd__prio_queue },
-	{ "proc-receive", cmd__proc_receive},
+	{ "proc-receive", cmd__proc_receive },
 	{ "progress", cmd__progress },
 	{ "reach", cmd__reach },
 	{ "read-cache", cmd__read_cache },
 	{ "read-graph", cmd__read_graph },
 	{ "read-midx", cmd__read_midx },
 	{ "ref-store", cmd__ref_store },
+	{ "reftable", cmd__reftable },
 	{ "regex", cmd__regex },
 	{ "repository", cmd__repository },
 	{ "revision-walking", cmd__revision_walking },
diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
index a6470ff62c..1de39ce5b5 100644
--- a/t/helper/test-tool.h
+++ b/t/helper/test-tool.h
@@ -44,6 +44,7 @@ int cmd__read_cache(int argc, const char **argv);
 int cmd__read_graph(int argc, const char **argv);
 int cmd__read_midx(int argc, const char **argv);
 int cmd__ref_store(int argc, const char **argv);
+int cmd__reftable(int argc, const char **argv);
 int cmd__regex(int argc, const char **argv);
 int cmd__repository(int argc, const char **argv);
 int cmd__revision_walking(int argc, const char **argv);
diff --git a/t/t0032-reftable-unittest.sh b/t/t0032-reftable-unittest.sh
new file mode 100755
index 0000000000..10e21a0590
--- /dev/null
+++ b/t/t0032-reftable-unittest.sh
@@ -0,0 +1,14 @@
+#!/bin/sh
+#
+# Copyright (c) 2020 Google LLC
+#
+
+test_description='reftable unittests'
+
+. ./test-lib.sh
+
+test_expect_success 'unittests' '
+       test-tool reftable
+'
+
+test_done
-- 
gitgitgadget

