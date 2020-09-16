Return-Path: <SRS0=vH5l=CZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0E25C433E2
	for <git@archiver.kernel.org>; Wed, 16 Sep 2020 19:11:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 42BFB20732
	for <git@archiver.kernel.org>; Wed, 16 Sep 2020 19:11:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BVbvBV3e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728263AbgIPTLi (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Sep 2020 15:11:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727780AbgIPTK2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Sep 2020 15:10:28 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 349BCC06178C
        for <git@vger.kernel.org>; Wed, 16 Sep 2020 12:10:24 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id e17so3809792wme.0
        for <git@vger.kernel.org>; Wed, 16 Sep 2020 12:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=PnFdecDRDF5BtwGNeRNlWgU+PNef5/mNXrjPWl5Px6s=;
        b=BVbvBV3e+6KGPs47okllvYm4JJft7kmzbGthf5IKSvQLdwnAyB37Nw+l6yUvIrtbIr
         rfsXH59sgTOXr/mGZaZZ2PyWzyipJZGDyi1JhuG8gCi09adgC3uXe0d1VTgPYxBQm2NK
         c85z+2EcNvUNbVd3lvr0JkCE0CoOpICjmy8eUCeI5or4n+OFjFW5eSZ0AAzwMqZnPOzE
         ZiKEu2gLGmCDuFO3ys2FDPBJG8JP/Z4B0pqkZuItCvio6Us7SK9STO+adjYQLpmRoFje
         2tw9QlevHWplwDHMuXvPucIIAp2Pb86g9IAqsXyf340gjqleECjLAPgPvowCj3sfwvC5
         F7TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=PnFdecDRDF5BtwGNeRNlWgU+PNef5/mNXrjPWl5Px6s=;
        b=fvB/Dg6mHPzCL5XIBLlib6160/vdg8KJQq40+9VPWsJuNcouVrx2XUPwSiZlGFSawL
         J4C7jmh8gLUVznIh4oeo6n5bsghpZLl5FmhAIUG17Okz8h8TaV1i3AIpnxD5KhdHHS6y
         ktJqTs7eUHWIvt1QL3txXdY/ECZHFyWJpyHwrTbxlpwQFdtbGW1rmE3Jc7kRIwJFYlo9
         hf54jyZULAvyuckYkEPvOsBqJ9YiU28qAwga6vgj3j5JGspIbidsnMHJb/dWUGIj96vf
         7JVe2v4al0nvZuOW0Lyp0nAq3txnYS2TlwujwtgHfbY2CV2OOOTjtSJRv1pZeY3tBWcL
         zE+Q==
X-Gm-Message-State: AOAM531Y0pbp+Mi/wV2AOa7oVhivpBe+ru4gpdoKR1NRhubRVut6VSri
        r69wybPBrjfATel8VI3zvT4RYb0A8Ko=
X-Google-Smtp-Source: ABdhPJwBSgFFsSetDGXTOB042WueeVhkoJUZg/uYZNT9OjAKAp61d6SQL2jfRxQ1swwnAVulKSzv9Q==
X-Received: by 2002:a1c:4b13:: with SMTP id y19mr6096129wma.75.1600283421412;
        Wed, 16 Sep 2020 12:10:21 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q18sm33569930wre.78.2020.09.16.12.10.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2020 12:10:20 -0700 (PDT)
Message-Id: <570a8c4bcac54295865ee0fc4514073b59725511.1600283416.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.847.git.git.1600283416.gitgitgadget@gmail.com>
References: <pull.847.git.git.1600283416.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 16 Sep 2020 19:10:08 +0000
Subject: [PATCH 05/13] reftable: utility functions
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

This commit provides basic utility classes for the reftable library.

Since the reftable library must compile standalone, there may be some overlap
with git-core utility functions.

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 Makefile                  |  26 ++++++-
 reftable/basics.c         | 131 +++++++++++++++++++++++++++++++++
 reftable/basics.h         |  48 +++++++++++++
 reftable/blocksource.c    | 148 ++++++++++++++++++++++++++++++++++++++
 reftable/blocksource.h    |  22 ++++++
 reftable/compat.c         | 110 ++++++++++++++++++++++++++++
 reftable/compat.h         |  48 +++++++++++++
 reftable/publicbasics.c   | 100 ++++++++++++++++++++++++++
 reftable/reftable-tests.h |  22 ++++++
 reftable/strbuf.c         | 142 ++++++++++++++++++++++++++++++++++++
 reftable/strbuf.h         |  80 +++++++++++++++++++++
 reftable/strbuf_test.c    |  37 ++++++++++
 reftable/system.h         |  51 +++++++++++++
 t/helper/test-reftable.c  |   8 +++
 t/helper/test-tool.c      |   1 +
 t/helper/test-tool.h      |   1 +
 16 files changed, 972 insertions(+), 3 deletions(-)
 create mode 100644 reftable/basics.c
 create mode 100644 reftable/basics.h
 create mode 100644 reftable/blocksource.c
 create mode 100644 reftable/blocksource.h
 create mode 100644 reftable/compat.c
 create mode 100644 reftable/compat.h
 create mode 100644 reftable/publicbasics.c
 create mode 100644 reftable/reftable-tests.h
 create mode 100644 reftable/strbuf.c
 create mode 100644 reftable/strbuf.h
 create mode 100644 reftable/strbuf_test.c
 create mode 100644 reftable/system.h
 create mode 100644 t/helper/test-reftable.c

diff --git a/Makefile b/Makefile
index 86e5411f39..66158525a9 100644
--- a/Makefile
+++ b/Makefile
@@ -720,6 +720,7 @@ TEST_BUILTINS_OBJS += test-read-cache.o
 TEST_BUILTINS_OBJS += test-read-graph.o
 TEST_BUILTINS_OBJS += test-read-midx.o
 TEST_BUILTINS_OBJS += test-ref-store.o
+TEST_BUILTINS_OBJS += test-reftable.o
 TEST_BUILTINS_OBJS += test-regex.o
 TEST_BUILTINS_OBJS += test-repository.o
 TEST_BUILTINS_OBJS += test-revision-walking.o
@@ -799,6 +800,8 @@ TEST_SHELL_PATH = $(SHELL_PATH)
 
 LIB_FILE = libgit.a
 XDIFF_LIB = xdiff/lib.a
+REFTABLE_LIB = reftable/libreftable.a
+REFTABLE_TEST_LIB = reftable/libreftable_test.a
 
 GENERATED_H += config-list.h
 GENERATED_H += command-list.h
@@ -1160,7 +1163,7 @@ THIRD_PARTY_SOURCES += compat/regex/%
 THIRD_PARTY_SOURCES += sha1collisiondetection/%
 THIRD_PARTY_SOURCES += sha1dc/%
 
-GITLIBS = common-main.o $(LIB_FILE) $(XDIFF_LIB)
+GITLIBS = common-main.o $(LIB_FILE) $(XDIFF_LIB) $(REFTABLE_LIB)
 EXTLIBS =
 
 GIT_USER_AGENT = git/$(GIT_VERSION)
@@ -2341,10 +2344,21 @@ XDIFF_OBJS += xdiff/xpatience.o
 XDIFF_OBJS += xdiff/xprepare.o
 XDIFF_OBJS += xdiff/xutils.o
 
+REFTABLE_OBJS += reftable/basics.o
+REFTABLE_OBJS += reftable/blocksource.o
+REFTABLE_OBJS += reftable/publicbasics.o
+REFTABLE_OBJS += reftable/compat.o
+REFTABLE_OBJS += reftable/strbuf.o
+
+REFTABLE_TEST_OBJS += reftable/strbuf_test.o
+REFTABLE_TEST_OBJS += reftable/test_framework.o
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
@@ -2474,6 +2488,12 @@ $(LIB_FILE): $(LIB_OBJS)
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
@@ -2752,7 +2772,7 @@ perf: all
 
 t/helper/test-tool$X: $(patsubst %,t/helper/%,$(TEST_BUILTINS_OBJS))
 
-t/helper/test-%$X: t/helper/test-%.o GIT-LDFLAGS $(GITLIBS)
+t/helper/test-%$X: t/helper/test-%.o GIT-LDFLAGS $(GITLIBS) $(REFTABLE_TEST_LIB)
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) $(filter %.a,$^) $(LIBS)
 
 check-sha1:: t/helper/test-tool$X
@@ -3080,7 +3100,7 @@ cocciclean:
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
index 0000000000..c429055d15
--- /dev/null
+++ b/reftable/basics.c
@@ -0,0 +1,131 @@
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
diff --git a/reftable/basics.h b/reftable/basics.h
new file mode 100644
index 0000000000..90639865a7
--- /dev/null
+++ b/reftable/basics.h
@@ -0,0 +1,48 @@
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
+#endif
diff --git a/reftable/blocksource.c b/reftable/blocksource.c
new file mode 100644
index 0000000000..f12cea2472
--- /dev/null
+++ b/reftable/blocksource.c
@@ -0,0 +1,148 @@
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
+#include "blocksource.h"
+#include "strbuf.h"
+#include "reftable.h"
+
+static void strbuf_return_block(void *b, struct reftable_block *dest)
+{
+	memset(dest->data, 0xff, dest->len);
+	reftable_free(dest->data);
+}
+
+static void strbuf_close(void *b)
+{
+}
+
+static int strbuf_read_block(void *v, struct reftable_block *dest, uint64_t off,
+			     uint32_t size)
+{
+	struct strbuf *b = (struct strbuf *)v;
+	assert(off + size <= b->len);
+	dest->data = reftable_calloc(size);
+	memcpy(dest->data, b->buf + off, size);
+	dest->len = size;
+	return size;
+}
+
+static uint64_t strbuf_size(void *b)
+{
+	return ((struct strbuf *)b)->len;
+}
+
+struct reftable_block_source_vtable strbuf_vtable = {
+	.size = &strbuf_size,
+	.read_block = &strbuf_read_block,
+	.return_block = &strbuf_return_block,
+	.close = &strbuf_close,
+};
+
+void block_source_from_strbuf(struct reftable_block_source *bs,
+			      struct strbuf *buf)
+{
+	assert(bs->ops == NULL);
+	bs->ops = &strbuf_vtable;
+	bs->arg = buf;
+}
+
+static void malloc_return_block(void *b, struct reftable_block *dest)
+{
+	memset(dest->data, 0xff, dest->len);
+	reftable_free(dest->data);
+}
+
+struct reftable_block_source_vtable malloc_vtable = {
+	.return_block = &malloc_return_block,
+};
+
+struct reftable_block_source malloc_block_source_instance = {
+	.ops = &malloc_vtable,
+};
+
+struct reftable_block_source malloc_block_source(void)
+{
+	return malloc_block_source_instance;
+}
+
+struct file_block_source {
+	int fd;
+	uint64_t size;
+};
+
+static uint64_t file_size(void *b)
+{
+	return ((struct file_block_source *)b)->size;
+}
+
+static void file_return_block(void *b, struct reftable_block *dest)
+{
+	memset(dest->data, 0xff, dest->len);
+	reftable_free(dest->data);
+}
+
+static void file_close(void *b)
+{
+	int fd = ((struct file_block_source *)b)->fd;
+	if (fd > 0) {
+		close(fd);
+		((struct file_block_source *)b)->fd = 0;
+	}
+
+	reftable_free(b);
+}
+
+static int file_read_block(void *v, struct reftable_block *dest, uint64_t off,
+			   uint32_t size)
+{
+	struct file_block_source *b = (struct file_block_source *)v;
+	assert(off + size <= b->size);
+	dest->data = reftable_malloc(size);
+	if (pread(b->fd, dest->data, size, off) != size)
+		return -1;
+	dest->len = size;
+	return size;
+}
+
+struct reftable_block_source_vtable file_vtable = {
+	.size = &file_size,
+	.read_block = &file_read_block,
+	.return_block = &file_return_block,
+	.close = &file_close,
+};
+
+int reftable_block_source_from_file(struct reftable_block_source *bs,
+				    const char *name)
+{
+	struct stat st = { 0 };
+	int err = 0;
+	int fd = open(name, O_RDONLY);
+	struct file_block_source *p = NULL;
+	if (fd < 0) {
+		if (errno == ENOENT) {
+			return REFTABLE_NOT_EXIST_ERROR;
+		}
+		return -1;
+	}
+
+	err = fstat(fd, &st);
+	if (err < 0)
+		return -1;
+
+	p = reftable_calloc(sizeof(struct file_block_source));
+	p->size = st.st_size;
+	p->fd = fd;
+
+	assert(bs->ops == NULL);
+	bs->ops = &file_vtable;
+	bs->arg = p;
+	return 0;
+}
diff --git a/reftable/blocksource.h b/reftable/blocksource.h
new file mode 100644
index 0000000000..3faf83fa9d
--- /dev/null
+++ b/reftable/blocksource.h
@@ -0,0 +1,22 @@
+/*
+Copyright 2020 Google LLC
+
+Use of this source code is governed by a BSD-style
+license that can be found in the LICENSE file or at
+https://developers.google.com/open-source/licenses/bsd
+*/
+
+#ifndef BLOCKSOURCE_H
+#define BLOCKSOURCE_H
+
+#include "strbuf.h"
+
+struct reftable_block_source;
+
+/* Create an in-memory block source for reading reftables */
+void block_source_from_strbuf(struct reftable_block_source *bs,
+			      struct strbuf *buf);
+
+struct reftable_block_source malloc_block_source(void);
+
+#endif
diff --git a/reftable/compat.c b/reftable/compat.c
new file mode 100644
index 0000000000..a48c5aa5e3
--- /dev/null
+++ b/reftable/compat.c
@@ -0,0 +1,110 @@
+/*
+Copyright 2020 Google LLC
+
+Use of this source code is governed by a BSD-style
+license that can be found in the LICENSE file or at
+https://developers.google.com/open-source/licenses/bsd
+
+*/
+
+/* compat.c - compatibility functions for standalone compilation */
+
+#include "system.h"
+#include "basics.h"
+
+#ifdef REFTABLE_STANDALONE
+
+#include <dirent.h>
+
+void put_be32(void *p, uint32_t i)
+{
+	uint8_t *out = (uint8_t *)p;
+
+	out[0] = (uint8_t)((i >> 24) & 0xff);
+	out[1] = (uint8_t)((i >> 16) & 0xff);
+	out[2] = (uint8_t)((i >> 8) & 0xff);
+	out[3] = (uint8_t)((i)&0xff);
+}
+
+uint32_t get_be32(uint8_t *in)
+{
+	return (uint32_t)(in[0]) << 24 | (uint32_t)(in[1]) << 16 |
+	       (uint32_t)(in[2]) << 8 | (uint32_t)(in[3]);
+}
+
+void put_be64(void *p, uint64_t v)
+{
+	uint8_t *out = (uint8_t *)p;
+	int i = sizeof(uint64_t);
+	while (i--) {
+		out[i] = (uint8_t)(v & 0xff);
+		v >>= 8;
+	}
+}
+
+uint64_t get_be64(void *out)
+{
+	uint8_t *bytes = (uint8_t *)out;
+	uint64_t v = 0;
+	int i = 0;
+	for (i = 0; i < sizeof(uint64_t); i++) {
+		v = (v << 8) | (uint8_t)(bytes[i] & 0xff);
+	}
+	return v;
+}
+
+uint16_t get_be16(uint8_t *in)
+{
+	return (uint32_t)(in[0]) << 8 | (uint32_t)(in[1]);
+}
+
+char *xstrdup(const char *s)
+{
+	int l = strlen(s);
+	char *dest = (char *)reftable_malloc(l + 1);
+	strncpy(dest, s, l + 1);
+	return dest;
+}
+
+void sleep_millisec(int millisecs)
+{
+	usleep(millisecs * 1000);
+}
+
+void reftable_clear_dir(const char *dirname)
+{
+	DIR *dir = opendir(dirname);
+	struct dirent *ent = NULL;
+	assert(dir);
+	while ((ent = readdir(dir)) != NULL) {
+		unlinkat(dirfd(dir), ent->d_name, 0);
+	}
+	closedir(dir);
+	rmdir(dirname);
+}
+
+#else
+
+#include "../dir.h"
+
+void reftable_clear_dir(const char *dirname)
+{
+	struct strbuf path = STRBUF_INIT;
+	strbuf_addstr(&path, dirname);
+	remove_dir_recursively(&path, 0);
+	strbuf_release(&path);
+}
+
+#endif
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
index 0000000000..a31463ff9a
--- /dev/null
+++ b/reftable/publicbasics.c
@@ -0,0 +1,100 @@
+/*
+Copyright 2020 Google LLC
+
+Use of this source code is governed by a BSD-style
+license that can be found in the LICENSE file or at
+https://developers.google.com/open-source/licenses/bsd
+*/
+
+#include "reftable.h"
+
+#include "basics.h"
+#include "system.h"
+
+const char *reftable_error_str(int err)
+{
+	static char buf[250];
+	switch (err) {
+	case REFTABLE_IO_ERROR:
+		return "I/O error";
+	case REFTABLE_FORMAT_ERROR:
+		return "corrupt reftable file";
+	case REFTABLE_NOT_EXIST_ERROR:
+		return "file does not exist";
+	case REFTABLE_LOCK_ERROR:
+		return "data is outdated";
+	case REFTABLE_API_ERROR:
+		return "misuse of the reftable API";
+	case REFTABLE_ZLIB_ERROR:
+		return "zlib failure";
+	case REFTABLE_NAME_CONFLICT:
+		return "file/directory conflict";
+	case REFTABLE_REFNAME_ERROR:
+		return "invalid refname";
+	case -1:
+		return "general error";
+	default:
+		snprintf(buf, sizeof(buf), "unknown error code %d", err);
+		return buf;
+	}
+}
+
+int reftable_error_to_errno(int err)
+{
+	switch (err) {
+	case REFTABLE_IO_ERROR:
+		return EIO;
+	case REFTABLE_FORMAT_ERROR:
+		return EFAULT;
+	case REFTABLE_NOT_EXIST_ERROR:
+		return ENOENT;
+	case REFTABLE_LOCK_ERROR:
+		return EBUSY;
+	case REFTABLE_API_ERROR:
+		return EINVAL;
+	case REFTABLE_ZLIB_ERROR:
+		return EDOM;
+	default:
+		return ERANGE;
+	}
+}
+
+void *(*reftable_malloc_ptr)(size_t sz) = &malloc;
+void *(*reftable_realloc_ptr)(void *, size_t) = &realloc;
+void (*reftable_free_ptr)(void *) = &free;
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
+int reftable_fd_write(void *arg, const void *data, size_t sz)
+{
+	int *fdp = (int *)arg;
+	return write(*fdp, data, sz);
+}
diff --git a/reftable/reftable-tests.h b/reftable/reftable-tests.h
new file mode 100644
index 0000000000..e38471888f
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
+int block_test_main(int argc, const char **argv);
+int merged_test_main(int argc, const char **argv);
+int record_test_main(int argc, const char **argv);
+int refname_test_main(int argc, const char **argv);
+int reftable_test_main(int argc, const char **argv);
+int strbuf_test_main(int argc, const char **argv);
+int stack_test_main(int argc, const char **argv);
+int tree_test_main(int argc, const char **argv);
+int reftable_dump_main(int argc, char *const *argv);
+
+#endif
diff --git a/reftable/strbuf.c b/reftable/strbuf.c
new file mode 100644
index 0000000000..136bf65591
--- /dev/null
+++ b/reftable/strbuf.c
@@ -0,0 +1,142 @@
+/*
+Copyright 2020 Google LLC
+
+Use of this source code is governed by a BSD-style
+license that can be found in the LICENSE file or at
+https://developers.google.com/open-source/licenses/bsd
+*/
+
+#include "strbuf.h"
+
+#ifdef REFTABLE_STANDALONE
+
+void strbuf_init(struct strbuf *s, size_t alloc)
+{
+	struct strbuf empty = STRBUF_INIT;
+	*s = empty;
+}
+
+void strbuf_grow(struct strbuf *s, size_t extra)
+{
+	size_t newcap = s->len + extra + 1;
+	if (newcap > s->cap) {
+		s->buf = reftable_realloc(s->buf, newcap);
+		s->cap = newcap;
+	}
+}
+
+static void strbuf_resize(struct strbuf *s, int l)
+{
+	int zl = l + 1; /* one uint8_t for 0 termination. */
+	assert(s->canary == STRBUF_CANARY);
+	if (s->cap < zl) {
+		int c = s->cap * 2;
+		if (c < zl) {
+			c = zl;
+		}
+		s->cap = c;
+		s->buf = reftable_realloc(s->buf, s->cap);
+	}
+	s->len = l;
+	s->buf[l] = 0;
+}
+
+void strbuf_setlen(struct strbuf *s, size_t l)
+{
+	assert(s->cap >= l + 1);
+	s->len = l;
+	s->buf[l] = 0;
+}
+
+void strbuf_reset(struct strbuf *s)
+{
+	strbuf_resize(s, 0);
+}
+
+void strbuf_addstr(struct strbuf *d, const char *s)
+{
+	int l1 = d->len;
+	int l2 = strlen(s);
+	assert(d->canary == STRBUF_CANARY);
+
+	strbuf_resize(d, l2 + l1);
+	memcpy(d->buf + l1, s, l2);
+}
+
+void strbuf_addbuf(struct strbuf *s, struct strbuf *a)
+{
+	int end = s->len;
+	assert(s->canary == STRBUF_CANARY);
+	strbuf_resize(s, s->len + a->len);
+	memcpy(s->buf + end, a->buf, a->len);
+}
+
+char *strbuf_detach(struct strbuf *s, size_t *sz)
+{
+	char *p = NULL;
+	p = (char *)s->buf;
+	if (sz)
+		*sz = s->len;
+	s->buf = NULL;
+	s->cap = 0;
+	s->len = 0;
+	return p;
+}
+
+void strbuf_release(struct strbuf *s)
+{
+	assert(s->canary == STRBUF_CANARY);
+	s->cap = 0;
+	s->len = 0;
+	reftable_free(s->buf);
+	s->buf = NULL;
+}
+
+int strbuf_cmp(const struct strbuf *a, const struct strbuf *b)
+{
+	int min = a->len < b->len ? a->len : b->len;
+	int res = memcmp(a->buf, b->buf, min);
+	assert(a->canary == STRBUF_CANARY);
+	assert(b->canary == STRBUF_CANARY);
+	if (res != 0)
+		return res;
+	if (a->len < b->len)
+		return -1;
+	else if (a->len > b->len)
+		return 1;
+	else
+		return 0;
+}
+
+int strbuf_add(struct strbuf *b, const void *data, size_t sz)
+{
+	assert(b->canary == STRBUF_CANARY);
+	strbuf_grow(b, sz);
+	memcpy(b->buf + b->len, data, sz);
+	b->len += sz;
+	b->buf[b->len] = 0;
+	return sz;
+}
+
+#endif
+
+int strbuf_add_void(void *b, const void *data, size_t sz)
+{
+	strbuf_add((struct strbuf *)b, data, sz);
+	return sz;
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
+
+struct strbuf reftable_empty_strbuf = STRBUF_INIT;
diff --git a/reftable/strbuf.h b/reftable/strbuf.h
new file mode 100644
index 0000000000..c2d7aca8dd
--- /dev/null
+++ b/reftable/strbuf.h
@@ -0,0 +1,80 @@
+/*
+Copyright 2020 Google LLC
+
+Use of this source code is governed by a BSD-style
+license that can be found in the LICENSE file or at
+https://developers.google.com/open-source/licenses/bsd
+*/
+
+#ifndef SLICE_H
+#define SLICE_H
+
+#ifdef REFTABLE_STANDALONE
+
+#include "basics.h"
+
+/*
+  Provides a bounds-checked, growable byte ranges. To use, initialize as "strbuf
+  x = STRBUF_INIT;"
+ */
+struct strbuf {
+	size_t len;
+	size_t cap;
+	char *buf;
+
+	/* Used to enforce initialization with STRBUF_INIT */
+	uint8_t canary;
+};
+
+#define STRBUF_CANARY 0x42
+#define STRBUF_INIT                       \
+	{                                 \
+		0, 0, NULL, STRBUF_CANARY \
+	}
+
+void strbuf_addstr(struct strbuf *dest, const char *src);
+
+/* Deallocate and clear strbuf */
+void strbuf_release(struct strbuf *strbuf);
+
+/* Set strbuf to 0 length, but retain buffer. */
+void strbuf_reset(struct strbuf *strbuf);
+
+/* Initializes a strbuf. Accepts a strbuf with random garbage. */
+void strbuf_init(struct strbuf *strbuf, size_t alloc);
+
+/* Return `buf`, clearing out `s`. Optionally return len (not cap) in `sz`.  */
+char *strbuf_detach(struct strbuf *s, size_t *sz);
+
+/* Set length of the slace to `l`, but don't reallocated. */
+void strbuf_setlen(struct strbuf *s, size_t l);
+
+/* Ensure `l` bytes beyond current length are available */
+void strbuf_grow(struct strbuf *s, size_t l);
+
+/* Signed comparison */
+int strbuf_cmp(const struct strbuf *a, const struct strbuf *b);
+
+/* Append `data` to the `dest` strbuf.  */
+int strbuf_add(struct strbuf *dest, const void *data, size_t sz);
+
+/* Append `add` to `dest. */
+void strbuf_addbuf(struct strbuf *dest, struct strbuf *add);
+
+#else
+
+#include "../git-compat-util.h"
+#include "../strbuf.h"
+
+#endif
+
+extern struct strbuf reftable_empty_strbuf;
+
+/* Like strbuf_add, but suitable for passing to reftable_new_writer
+ */
+int strbuf_add_void(void *b, const void *data, size_t sz);
+
+/* Find the longest shared prefix size of `a` and `b` */
+int common_prefix_size(struct strbuf *a, struct strbuf *b);
+
+#endif
diff --git a/reftable/strbuf_test.c b/reftable/strbuf_test.c
new file mode 100644
index 0000000000..39f561c81a
--- /dev/null
+++ b/reftable/strbuf_test.c
@@ -0,0 +1,37 @@
+/*
+Copyright 2020 Google LLC
+
+Use of this source code is governed by a BSD-style
+license that can be found in the LICENSE file or at
+https://developers.google.com/open-source/licenses/bsd
+*/
+
+#include "strbuf.h"
+
+#include "system.h"
+
+#include "basics.h"
+#include "test_framework.h"
+#include "reftable-tests.h"
+
+static void test_strbuf(void)
+{
+	struct strbuf s = STRBUF_INIT;
+	struct strbuf t = STRBUF_INIT;
+
+	strbuf_addstr(&s, "abc");
+	assert(0 == strcmp("abc", s.buf));
+
+	strbuf_addstr(&t, "pqr");
+	strbuf_addbuf(&s, &t);
+	assert(0 == strcmp("abcpqr", s.buf));
+
+	strbuf_release(&s);
+	strbuf_release(&t);
+}
+
+int strbuf_test_main(int argc, const char *argv[])
+{
+	add_test_case("test_strbuf", &test_strbuf);
+	return test_main(argc, argv);
+}
diff --git a/reftable/system.h b/reftable/system.h
new file mode 100644
index 0000000000..567eb8a87d
--- /dev/null
+++ b/reftable/system.h
@@ -0,0 +1,51 @@
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
+#ifndef REFTABLE_STANDALONE
+
+#include "git-compat-util.h"
+#include "cache.h"
+#include <zlib.h>
+
+#else
+
+#include <assert.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <inttypes.h>
+#include <stdint.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/stat.h>
+#include <sys/time.h>
+#include <sys/types.h>
+#include <unistd.h>
+#include <zlib.h>
+
+#include "compat.h"
+
+#endif /* REFTABLE_STANDALONE */
+
+void reftable_clear_dir(const char *dirname);
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
diff --git a/t/helper/test-reftable.c b/t/helper/test-reftable.c
new file mode 100644
index 0000000000..7d50aa6bcc
--- /dev/null
+++ b/t/helper/test-reftable.c
@@ -0,0 +1,8 @@
+#include "reftable/reftable-tests.h"
+#include "test-tool.h"
+
+int cmd__reftable(int argc, const char **argv)
+{
+	strbuf_test_main(argc, argv);
+	return 0;
+}
diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
index 590b2efca7..10366b7b76 100644
--- a/t/helper/test-tool.c
+++ b/t/helper/test-tool.c
@@ -52,6 +52,7 @@ static struct test_cmd cmds[] = {
 	{ "read-graph", cmd__read_graph },
 	{ "read-midx", cmd__read_midx },
 	{ "ref-store", cmd__ref_store },
+	{ "reftable", cmd__reftable },
 	{ "regex", cmd__regex },
 	{ "repository", cmd__repository },
 	{ "revision-walking", cmd__revision_walking },
diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
index ddc8e990e9..d52ba2f5e5 100644
--- a/t/helper/test-tool.h
+++ b/t/helper/test-tool.h
@@ -41,6 +41,7 @@ int cmd__read_cache(int argc, const char **argv);
 int cmd__read_graph(int argc, const char **argv);
 int cmd__read_midx(int argc, const char **argv);
 int cmd__ref_store(int argc, const char **argv);
+int cmd__reftable(int argc, const char **argv);
 int cmd__regex(int argc, const char **argv);
 int cmd__repository(int argc, const char **argv);
 int cmd__revision_walking(int argc, const char **argv);
-- 
gitgitgadget

