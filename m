Return-Path: <SRS0=KQVw=7S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38705C433E0
	for <git@archiver.kernel.org>; Fri,  5 Jun 2020 18:03:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95F5C206FA
	for <git@archiver.kernel.org>; Fri,  5 Jun 2020 18:03:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GJT5Qawp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728163AbgFESDq (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Jun 2020 14:03:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728129AbgFESDl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Jun 2020 14:03:41 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62F28C08C5C5
        for <git@vger.kernel.org>; Fri,  5 Jun 2020 11:03:39 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id d128so9957561wmc.1
        for <git@vger.kernel.org>; Fri, 05 Jun 2020 11:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Dp3XvSIh5hClZMzBNnK+p60T+GULOCFRIqoEBjSvD4Y=;
        b=GJT5QawpjAULUCfsCUf5usMUeRvx/P580AH/xpry77ZQsjjEVqFHhWUy3F9CwHGxOY
         ic3dG92s96352yRgaqisFMiaAh5tl5SdfdkH72HZ5IpW/cLDdDfHYxJUNgyMZoRXFg73
         zSlvEWAnKFP2/6kd4Eg8WTbJVhjthWLwBtsfwaRJrYLTZ6wGIaeOLjtaA//0VqHANyk6
         XIIBIZe1jXlX8mSTJr3jr8SKIHrxYvEJz6F/c8R8+qVYXJZ9QGfxX8yQ4QLyVVu2Qt38
         dROCNhbRbWjKRs3AHfoDCxtOJvqCWwOOy6oowzfzc2gZ/qrjK2WG6zN1Lx4qMg4bd4Hs
         RkZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Dp3XvSIh5hClZMzBNnK+p60T+GULOCFRIqoEBjSvD4Y=;
        b=Bp7Fh6xa75DMFA962pst6q1Pz7UvQOgRHHOOUqhMRibb3d6xW/UoGlDlqMbWcBJcEw
         xUy2hVjTFfG0Jw5Hi8HV3LwP8keBu72f91ePOmrU6GqnmV5cXUYqyPbbxJmTxMyuRlFB
         UjDdWoqOHIeCKbxXUPratmGypw+ANuoUBDbTlpoz8km2Rk4XO5Az1sUxTIo2aeYdxXat
         ekOzhtStw4vU35G054Xl3Ospmra2acie92/SzUPfzgFkndHbDsPpL02mZ0viZ9t3IF2h
         NBlQJQod/pUKUSa3IsZtTAzJSNBk4/qoP4+qDR9+WexCTSylAvaIqK/FnMnIofR0yxCu
         j2ZA==
X-Gm-Message-State: AOAM533K2487qgFSU6OiexRyWtvWaJLkJXLjj4SmQAXjuHCNdCBmsC0U
        TtEnbuCl2hgln5iS3iu46EdhHsn6
X-Google-Smtp-Source: ABdhPJw5cwivwTwDmqFFSAd2nAg4vtMGMJ7yhctvLmBJhA8GuhI4/OOwdkScotjhUQ9LCLA98Qnojw==
X-Received: by 2002:a7b:c18a:: with SMTP id y10mr4080672wmi.73.1591380211256;
        Fri, 05 Jun 2020 11:03:31 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k21sm13481656wrd.24.2020.06.05.11.03.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2020 11:03:30 -0700 (PDT)
Message-Id: <0bc28ac610fb6f5965e39f9e0d4caf88ca9ead06.1591380199.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.539.v16.git.1591380199.gitgitgadget@gmail.com>
References: <pull.539.v15.git.1590695209.gitgitgadget@gmail.com>
        <pull.539.v16.git.1591380199.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 05 Jun 2020 18:03:13 +0000
Subject: [PATCH v16 09/14] Add reftable library
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

Reftable is a format for storing the ref database. Its rationale and
specification is in the preceding commit.

This imports the upstream library as one big commit. For understanding
the code, it is suggested to read the code in the following order:

* The specification under Documentation/technical/reftable.txt

* reftable.h - the public API

* record.{c,h} - reading and writing records

* block.{c,h} - reading and writing blocks.

* writer.{c,h} - writing a complete reftable file.

* merged.{c,h} and pq.{c,h} - reading a stack of reftables

* stack.{c,h} - writing and compacting stacks of reftable on the
filesystem.

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 reftable/LICENSE          |   31 +
 reftable/README.md        |   11 +
 reftable/VERSION          |    1 +
 reftable/basics.c         |  215 +++++++
 reftable/basics.h         |   53 ++
 reftable/block.c          |  433 +++++++++++++
 reftable/block.h          |  129 ++++
 reftable/block_test.c     |  156 +++++
 reftable/constants.h      |   21 +
 reftable/file.c           |   95 +++
 reftable/iter.c           |  243 ++++++++
 reftable/iter.h           |   72 +++
 reftable/merged.c         |  320 ++++++++++
 reftable/merged.h         |   39 ++
 reftable/merged_test.c    |  273 +++++++++
 reftable/pq.c             |  113 ++++
 reftable/pq.h             |   34 ++
 reftable/reader.c         |  742 +++++++++++++++++++++++
 reftable/reader.h         |   65 ++
 reftable/record.c         | 1113 ++++++++++++++++++++++++++++++++++
 reftable/record.h         |  128 ++++
 reftable/record_test.c    |  400 ++++++++++++
 reftable/refname.c        |  209 +++++++
 reftable/refname.h        |   38 ++
 reftable/refname_test.c   |   99 +++
 reftable/reftable-tests.h |   13 +
 reftable/reftable.c       |   90 +++
 reftable/reftable.h       |  564 +++++++++++++++++
 reftable/reftable_test.c  |  631 +++++++++++++++++++
 reftable/slice.c          |  243 ++++++++
 reftable/slice.h          |   87 +++
 reftable/slice_test.c     |   40 ++
 reftable/stack.c          | 1207 +++++++++++++++++++++++++++++++++++++
 reftable/stack.h          |   48 ++
 reftable/stack_test.c     |  743 +++++++++++++++++++++++
 reftable/system.h         |   54 ++
 reftable/test_framework.c |   69 +++
 reftable/test_framework.h |   64 ++
 reftable/tree.c           |   63 ++
 reftable/tree.h           |   34 ++
 reftable/tree_test.c      |   62 ++
 reftable/update.sh        |   25 +
 reftable/writer.c         |  644 ++++++++++++++++++++
 reftable/writer.h         |   60 ++
 reftable/zlib-compat.c    |   92 +++
 45 files changed, 9866 insertions(+)
 create mode 100644 reftable/LICENSE
 create mode 100644 reftable/README.md
 create mode 100644 reftable/VERSION
 create mode 100644 reftable/basics.c
 create mode 100644 reftable/basics.h
 create mode 100644 reftable/block.c
 create mode 100644 reftable/block.h
 create mode 100644 reftable/block_test.c
 create mode 100644 reftable/constants.h
 create mode 100644 reftable/file.c
 create mode 100644 reftable/iter.c
 create mode 100644 reftable/iter.h
 create mode 100644 reftable/merged.c
 create mode 100644 reftable/merged.h
 create mode 100644 reftable/merged_test.c
 create mode 100644 reftable/pq.c
 create mode 100644 reftable/pq.h
 create mode 100644 reftable/reader.c
 create mode 100644 reftable/reader.h
 create mode 100644 reftable/record.c
 create mode 100644 reftable/record.h
 create mode 100644 reftable/record_test.c
 create mode 100644 reftable/refname.c
 create mode 100644 reftable/refname.h
 create mode 100644 reftable/refname_test.c
 create mode 100644 reftable/reftable-tests.h
 create mode 100644 reftable/reftable.c
 create mode 100644 reftable/reftable.h
 create mode 100644 reftable/reftable_test.c
 create mode 100644 reftable/slice.c
 create mode 100644 reftable/slice.h
 create mode 100644 reftable/slice_test.c
 create mode 100644 reftable/stack.c
 create mode 100644 reftable/stack.h
 create mode 100644 reftable/stack_test.c
 create mode 100644 reftable/system.h
 create mode 100644 reftable/test_framework.c
 create mode 100644 reftable/test_framework.h
 create mode 100644 reftable/tree.c
 create mode 100644 reftable/tree.h
 create mode 100644 reftable/tree_test.c
 create mode 100755 reftable/update.sh
 create mode 100644 reftable/writer.c
 create mode 100644 reftable/writer.h
 create mode 100644 reftable/zlib-compat.c

diff --git a/reftable/LICENSE b/reftable/LICENSE
new file mode 100644
index 00000000000..402e0f9356b
--- /dev/null
+++ b/reftable/LICENSE
@@ -0,0 +1,31 @@
+BSD License
+
+Copyright (c) 2020, Google LLC
+All rights reserved.
+
+Redistribution and use in source and binary forms, with or without
+modification, are permitted provided that the following conditions are
+met:
+
+* Redistributions of source code must retain the above copyright notice,
+this list of conditions and the following disclaimer.
+
+* Redistributions in binary form must reproduce the above copyright
+notice, this list of conditions and the following disclaimer in the
+documentation and/or other materials provided with the distribution.
+
+* Neither the name of Google LLC nor the names of its contributors may
+be used to endorse or promote products derived from this software
+without specific prior written permission.
+
+THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
+"AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
+LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
+A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
+OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
+SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
+LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
+DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
+THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
+(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
+OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
diff --git a/reftable/README.md b/reftable/README.md
new file mode 100644
index 00000000000..21500563fd4
--- /dev/null
+++ b/reftable/README.md
@@ -0,0 +1,11 @@
+
+The source code in this directory comes from https://github.com/google/reftable.
+
+The VERSION file keeps track of the current version of the reftable library.
+
+To update the library, do:
+
+   sh reftable/update.sh
+
+Bugfixes should be accompanied by a test and applied to upstream project at
+https://github.com/google/reftable.
diff --git a/reftable/VERSION b/reftable/VERSION
new file mode 100644
index 00000000000..c8bb0952506
--- /dev/null
+++ b/reftable/VERSION
@@ -0,0 +1 @@
+0c164275ea8f8aa7d099f7425ddcef1affe137e9 C: compile framework with Git options
diff --git a/reftable/basics.c b/reftable/basics.c
new file mode 100644
index 00000000000..14c4dfaf5a6
--- /dev/null
+++ b/reftable/basics.c
@@ -0,0 +1,215 @@
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
+#include "system.h"
+
+void put_be24(byte *out, uint32_t i)
+{
+	out[0] = (byte)((i >> 16) & 0xff);
+	out[1] = (byte)((i >> 8) & 0xff);
+	out[2] = (byte)(i & 0xff);
+}
+
+uint32_t get_be24(byte *in)
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
+	int names_cap = 0;
+	int names_len = 0;
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
diff --git a/reftable/basics.h b/reftable/basics.h
new file mode 100644
index 00000000000..1b003485c9c
--- /dev/null
+++ b/reftable/basics.h
@@ -0,0 +1,53 @@
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
+#include "reftable.h"
+
+#define true 1
+#define false 0
+
+/* Bigendian en/decoding of integers */
+
+void put_be24(byte *out, uint32_t i);
+uint32_t get_be24(byte *in);
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
diff --git a/reftable/block.c b/reftable/block.c
new file mode 100644
index 00000000000..e3bf00d64c4
--- /dev/null
+++ b/reftable/block.c
@@ -0,0 +1,433 @@
+/*
+Copyright 2020 Google LLC
+
+Use of this source code is governed by a BSD-style
+license that can be found in the LICENSE file or at
+https://developers.google.com/open-source/licenses/bsd
+*/
+
+#include "block.h"
+
+#include "system.h"
+
+#include "constants.h"
+#include "record.h"
+#include "reftable.h"
+#include "zlib.h"
+
+int header_size(int version)
+{
+	switch (version) {
+	case 1:
+		return 24;
+	case 2:
+		return 28;
+	}
+	abort();
+}
+
+int footer_size(int version)
+{
+	switch (version) {
+	case 1:
+		return 68;
+	case 2:
+		return 72;
+	}
+	abort();
+}
+
+int block_writer_register_restart(struct block_writer *w, int n, bool restart,
+				  struct slice *key);
+
+void block_writer_init(struct block_writer *bw, byte typ, byte *buf,
+		       uint32_t block_size, uint32_t header_off, int hash_size)
+{
+	bw->buf = buf;
+	bw->hash_size = hash_size;
+	bw->block_size = block_size;
+	bw->header_off = header_off;
+	bw->buf[header_off] = typ;
+	bw->next = header_off + 4;
+	bw->restart_interval = 16;
+	bw->entries = 0;
+	bw->restart_len = 0;
+	bw->last_key.len = 0;
+	bw->last_key.canary = SLICE_CANARY;
+}
+
+byte block_writer_type(struct block_writer *bw)
+{
+	return bw->buf[bw->header_off];
+}
+
+/* adds the reftable_record to the block. Returns -1 if it does not fit, 0 on
+   success */
+int block_writer_add(struct block_writer *w, struct reftable_record *rec)
+{
+	struct slice empty = SLICE_INIT;
+	struct slice last = w->entries % w->restart_interval == 0 ? empty :
+								    w->last_key;
+	struct slice out = {
+		.buf = w->buf + w->next,
+		.len = w->block_size - w->next,
+		.canary = SLICE_CANARY,
+	};
+
+	struct slice start = out;
+
+	bool restart = false;
+	struct slice key = SLICE_INIT;
+	int n = 0;
+
+	reftable_record_key(rec, &key);
+	n = reftable_encode_key(&restart, out, last, key,
+				reftable_record_val_type(rec));
+	if (n < 0)
+		goto done;
+	slice_consume(&out, n);
+
+	n = reftable_record_encode(rec, out, w->hash_size);
+	if (n < 0)
+		goto done;
+	slice_consume(&out, n);
+
+	if (block_writer_register_restart(w, start.len - out.len, restart,
+					  &key) < 0)
+		goto done;
+
+	slice_release(&key);
+	return 0;
+
+done:
+	slice_release(&key);
+	return -1;
+}
+
+int block_writer_register_restart(struct block_writer *w, int n, bool restart,
+				  struct slice *key)
+{
+	int rlen = w->restart_len;
+	if (rlen >= MAX_RESTARTS) {
+		restart = false;
+	}
+
+	if (restart) {
+		rlen++;
+	}
+	if (2 + 3 * rlen + n > w->block_size - w->next)
+		return -1;
+	if (restart) {
+		if (w->restart_len == w->restart_cap) {
+			w->restart_cap = w->restart_cap * 2 + 1;
+			w->restarts = reftable_realloc(
+				w->restarts, sizeof(uint32_t) * w->restart_cap);
+		}
+
+		w->restarts[w->restart_len++] = w->next;
+	}
+
+	w->next += n;
+
+	slice_copy(&w->last_key, key);
+	w->entries++;
+	return 0;
+}
+
+int block_writer_finish(struct block_writer *w)
+{
+	int i = 0;
+	for (i = 0; i < w->restart_len; i++) {
+		put_be24(w->buf + w->next, w->restarts[i]);
+		w->next += 3;
+	}
+
+	put_be16(w->buf + w->next, w->restart_len);
+	w->next += 2;
+	put_be24(w->buf + 1 + w->header_off, w->next);
+
+	if (block_writer_type(w) == BLOCK_TYPE_LOG) {
+		int block_header_skip = 4 + w->header_off;
+		struct slice compressed = SLICE_INIT;
+		int zresult = 0;
+		uLongf src_len = w->next - block_header_skip;
+		slice_resize(&compressed, src_len);
+
+		while (1) {
+			uLongf dest_len = compressed.len;
+
+			zresult = compress2(compressed.buf, &dest_len,
+					    w->buf + block_header_skip, src_len,
+					    9);
+			if (zresult == Z_BUF_ERROR) {
+				slice_resize(&compressed, 2 * compressed.len);
+				continue;
+			}
+
+			if (Z_OK != zresult) {
+				slice_release(&compressed);
+				return REFTABLE_ZLIB_ERROR;
+			}
+
+			memcpy(w->buf + block_header_skip, compressed.buf,
+			       dest_len);
+			w->next = dest_len + block_header_skip;
+			slice_release(&compressed);
+			break;
+		}
+	}
+	return w->next;
+}
+
+byte block_reader_type(struct block_reader *r)
+{
+	return r->block.data[r->header_off];
+}
+
+int block_reader_init(struct block_reader *br, struct reftable_block *block,
+		      uint32_t header_off, uint32_t table_block_size,
+		      int hash_size)
+{
+	uint32_t full_block_size = table_block_size;
+	byte typ = block->data[header_off];
+	uint32_t sz = get_be24(block->data + header_off + 1);
+
+	uint16_t restart_count = 0;
+	uint32_t restart_start = 0;
+	byte *restart_bytes = NULL;
+
+	if (!reftable_is_block_type(typ))
+		return REFTABLE_FORMAT_ERROR;
+
+	if (typ == BLOCK_TYPE_LOG) {
+		struct slice uncompressed = SLICE_INIT;
+		int block_header_skip = 4 + header_off;
+		uLongf dst_len = sz - block_header_skip; /* total size of dest
+							    buffer. */
+		uLongf src_len = block->len - block_header_skip;
+
+		/* Log blocks specify the *uncompressed* size in their header.
+		 */
+		slice_resize(&uncompressed, sz);
+
+		/* Copy over the block header verbatim. It's not compressed. */
+		memcpy(uncompressed.buf, block->data, block_header_skip);
+
+		/* Uncompress */
+		if (Z_OK != uncompress_return_consumed(
+				    uncompressed.buf + block_header_skip,
+				    &dst_len, block->data + block_header_skip,
+				    &src_len)) {
+			slice_release(&uncompressed);
+			return REFTABLE_ZLIB_ERROR;
+		}
+
+		if (dst_len + block_header_skip != sz)
+			return REFTABLE_FORMAT_ERROR;
+
+		/* We're done with the input data. */
+		reftable_block_done(block);
+		block->data = uncompressed.buf;
+		block->len = sz;
+		block->source = malloc_block_source();
+		full_block_size = src_len + block_header_skip;
+	} else if (full_block_size == 0) {
+		full_block_size = sz;
+	} else if (sz < full_block_size && sz < block->len &&
+		   block->data[sz] != 0) {
+		/* If the block is smaller than the full block size, it is
+		   padded (data followed by '\0') or the next block is
+		   unaligned. */
+		full_block_size = sz;
+	}
+
+	restart_count = get_be16(block->data + sz - 2);
+	restart_start = sz - 2 - 3 * restart_count;
+	restart_bytes = block->data + restart_start;
+
+	/* transfer ownership. */
+	br->block = *block;
+	block->data = NULL;
+	block->len = 0;
+
+	br->hash_size = hash_size;
+	br->block_len = restart_start;
+	br->full_block_size = full_block_size;
+	br->header_off = header_off;
+	br->restart_count = restart_count;
+	br->restart_bytes = restart_bytes;
+
+	return 0;
+}
+
+static uint32_t block_reader_restart_offset(struct block_reader *br, int i)
+{
+	return get_be24(br->restart_bytes + 3 * i);
+}
+
+void block_reader_start(struct block_reader *br, struct block_iter *it)
+{
+	it->br = br;
+	slice_resize(&it->last_key, 0);
+	it->next_off = br->header_off + 4;
+}
+
+struct restart_find_args {
+	int error;
+	struct slice key;
+	struct block_reader *r;
+};
+
+static int restart_key_less(size_t idx, void *args)
+{
+	struct restart_find_args *a = (struct restart_find_args *)args;
+	uint32_t off = block_reader_restart_offset(a->r, idx);
+	struct slice in = {
+		.buf = a->r->block.data + off,
+		.len = a->r->block_len - off,
+		.canary = SLICE_CANARY,
+	};
+
+	/* the restart key is verbatim in the block, so this could avoid the
+	   alloc for decoding the key */
+	struct slice rkey = SLICE_INIT;
+	struct slice last_key = SLICE_INIT;
+	byte unused_extra;
+	int n = reftable_decode_key(&rkey, &unused_extra, last_key, in);
+	int result;
+	if (n < 0) {
+		a->error = 1;
+		return -1;
+	}
+
+	result = slice_cmp(&a->key, &rkey);
+	slice_release(&rkey);
+	return result;
+}
+
+void block_iter_copy_from(struct block_iter *dest, struct block_iter *src)
+{
+	dest->br = src->br;
+	dest->next_off = src->next_off;
+	slice_copy(&dest->last_key, &src->last_key);
+}
+
+int block_iter_next(struct block_iter *it, struct reftable_record *rec)
+{
+	struct slice in = {
+		.buf = it->br->block.data + it->next_off,
+		.len = it->br->block_len - it->next_off,
+		.canary = SLICE_CANARY,
+	};
+	struct slice start = in;
+	struct slice key = SLICE_INIT;
+	byte extra = 0;
+	int n = 0;
+
+	if (it->next_off >= it->br->block_len)
+		return 1;
+
+	n = reftable_decode_key(&key, &extra, it->last_key, in);
+	if (n < 0)
+		return -1;
+
+	slice_consume(&in, n);
+	n = reftable_record_decode(rec, key, extra, in, it->br->hash_size);
+	if (n < 0)
+		return -1;
+	slice_consume(&in, n);
+
+	slice_copy(&it->last_key, &key);
+	it->next_off += start.len - in.len;
+	slice_release(&key);
+	return 0;
+}
+
+int block_reader_first_key(struct block_reader *br, struct slice *key)
+{
+	struct slice empty = SLICE_INIT;
+	int off = br->header_off + 4;
+	struct slice in = {
+		.buf = br->block.data + off,
+		.len = br->block_len - off,
+		.canary = SLICE_CANARY,
+	};
+
+	byte extra = 0;
+	int n = reftable_decode_key(key, &extra, empty, in);
+	if (n < 0)
+		return n;
+
+	return 0;
+}
+
+int block_iter_seek(struct block_iter *it, struct slice *want)
+{
+	return block_reader_seek(it->br, it, want);
+}
+
+void block_iter_close(struct block_iter *it)
+{
+	slice_release(&it->last_key);
+}
+
+int block_reader_seek(struct block_reader *br, struct block_iter *it,
+		      struct slice *want)
+{
+	struct restart_find_args args = {
+		.key = *want,
+		.r = br,
+	};
+	struct reftable_record rec = reftable_new_record(block_reader_type(br));
+	struct slice key = SLICE_INIT;
+	int err = 0;
+	struct block_iter next = {
+		.last_key = SLICE_INIT,
+	};
+
+	int i = binsearch(br->restart_count, &restart_key_less, &args);
+	if (args.error) {
+		err = REFTABLE_FORMAT_ERROR;
+		goto done;
+	}
+
+	it->br = br;
+	if (i > 0) {
+		i--;
+		it->next_off = block_reader_restart_offset(br, i);
+	} else {
+		it->next_off = br->header_off + 4;
+	}
+
+	/* We're looking for the last entry less/equal than the wanted key, so
+	   we have to go one entry too far and then back up.
+	*/
+	while (true) {
+		block_iter_copy_from(&next, it);
+		err = block_iter_next(&next, &rec);
+		if (err < 0)
+			goto done;
+
+		reftable_record_key(&rec, &key);
+		if (err > 0 || slice_cmp(&key, want) >= 0) {
+			err = 0;
+			goto done;
+		}
+
+		block_iter_copy_from(it, &next);
+	}
+
+done:
+	slice_release(&key);
+	slice_release(&next.last_key);
+	reftable_record_destroy(&rec);
+
+	return err;
+}
+
+void block_writer_clear(struct block_writer *bw)
+{
+	FREE_AND_NULL(bw->restarts);
+	slice_release(&bw->last_key);
+	/* the block is not owned. */
+}
diff --git a/reftable/block.h b/reftable/block.h
new file mode 100644
index 00000000000..c55f746c5c1
--- /dev/null
+++ b/reftable/block.h
@@ -0,0 +1,129 @@
+/*
+Copyright 2020 Google LLC
+
+Use of this source code is governed by a BSD-style
+license that can be found in the LICENSE file or at
+https://developers.google.com/open-source/licenses/bsd
+*/
+
+#ifndef BLOCK_H
+#define BLOCK_H
+
+#include "basics.h"
+#include "record.h"
+#include "reftable.h"
+
+/*
+  Writes reftable blocks. The block_writer is reused across blocks to minimize
+  allocation overhead.
+*/
+struct block_writer {
+	byte *buf;
+	uint32_t block_size;
+
+	/* Offset ofof the global header. Nonzero in the first block only. */
+	uint32_t header_off;
+
+	/* How often to restart keys. */
+	int restart_interval;
+	int hash_size;
+
+	/* Offset of next byte to write. */
+	uint32_t next;
+	uint32_t *restarts;
+	uint32_t restart_len;
+	uint32_t restart_cap;
+
+	struct slice last_key;
+	int entries;
+};
+
+/*
+  initializes the blockwriter to write `typ` entries, using `buf` as temporary
+  storage. `buf` is not owned by the block_writer. */
+void block_writer_init(struct block_writer *bw, byte typ, byte *buf,
+		       uint32_t block_size, uint32_t header_off, int hash_size);
+
+/*
+  returns the block type (eg. 'r' for ref records.
+*/
+byte block_writer_type(struct block_writer *bw);
+
+/* appends the record, or -1 if it doesn't fit. */
+int block_writer_add(struct block_writer *w, struct reftable_record *rec);
+
+/* appends the key restarts, and compress the block if necessary. */
+int block_writer_finish(struct block_writer *w);
+
+/* clears out internally allocated block_writer members. */
+void block_writer_clear(struct block_writer *bw);
+
+/* Read a block. */
+struct block_reader {
+	/* offset of the block header; nonzero for the first block in a
+	 * reftable. */
+	uint32_t header_off;
+
+	/* the memory block */
+	struct reftable_block block;
+	int hash_size;
+
+	/* size of the data, excluding restart data. */
+	uint32_t block_len;
+	byte *restart_bytes;
+	uint16_t restart_count;
+
+	/* size of the data in the file. For log blocks, this is the compressed
+	 * size. */
+	uint32_t full_block_size;
+};
+
+/* Iterate over entries in a block */
+struct block_iter {
+	/* offset within the block of the next entry to read. */
+	uint32_t next_off;
+	struct block_reader *br;
+
+	/* key for last entry we read. */
+	struct slice last_key;
+};
+
+/* initializes a block reader. */
+int block_reader_init(struct block_reader *br, struct reftable_block *bl,
+		      uint32_t header_off, uint32_t table_block_size,
+		      int hash_size);
+
+/* Position `it` at start of the block */
+void block_reader_start(struct block_reader *br, struct block_iter *it);
+
+/* Position `it` to the `want` key in the block */
+int block_reader_seek(struct block_reader *br, struct block_iter *it,
+		      struct slice *want);
+
+/* Returns the block type (eg. 'r' for refs) */
+byte block_reader_type(struct block_reader *r);
+
+/* Decodes the first key in the block */
+int block_reader_first_key(struct block_reader *br, struct slice *key);
+
+void block_iter_copy_from(struct block_iter *dest, struct block_iter *src);
+
+/* return < 0 for error, 0 for OK, > 0 for EOF. */
+int block_iter_next(struct block_iter *it, struct reftable_record *rec);
+
+/* Seek to `want` with in the block pointed to by `it` */
+int block_iter_seek(struct block_iter *it, struct slice *want);
+
+/* deallocate memory for `it`. The block reader and its block is left intact. */
+void block_iter_close(struct block_iter *it);
+
+/* size of file header, depending on format version */
+int header_size(int version);
+
+/* size of file footer, depending on format version */
+int footer_size(int version);
+
+/* returns a block to its source. */
+void reftable_block_done(struct reftable_block *ret);
+
+#endif
diff --git a/reftable/block_test.c b/reftable/block_test.c
new file mode 100644
index 00000000000..c1147caa521
--- /dev/null
+++ b/reftable/block_test.c
@@ -0,0 +1,156 @@
+/*
+Copyright 2020 Google LLC
+
+Use of this source code is governed by a BSD-style
+license that can be found in the LICENSE file or at
+https://developers.google.com/open-source/licenses/bsd
+*/
+
+#include "block.h"
+
+#include "system.h"
+
+#include "basics.h"
+#include "constants.h"
+#include "record.h"
+#include "reftable.h"
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
+			assert(args.key < arr[res]);
+			if (res > 0) {
+				assert(args.key >= arr[res - 1]);
+			}
+		} else {
+			assert(args.key == 10 || args.key == 11);
+		}
+	}
+}
+
+static void test_block_read_write(void)
+{
+	const int header_off = 21; /* random */
+	char *names[30];
+	const int N = ARRAY_SIZE(names);
+	const int block_size = 1024;
+	struct reftable_block block = { 0 };
+	struct block_writer bw = {
+		.last_key = SLICE_INIT,
+	};
+	struct reftable_ref_record ref = { 0 };
+	struct reftable_record rec = { 0 };
+	int i = 0;
+	int n;
+	struct block_reader br = { 0 };
+	struct block_iter it = { .last_key = SLICE_INIT };
+	int j = 0;
+	struct slice want = SLICE_INIT;
+
+	block.data = reftable_calloc(block_size);
+	block.len = block_size;
+	block.source = malloc_block_source();
+	block_writer_init(&bw, BLOCK_TYPE_REF, block.data, block_size,
+			  header_off, hash_size(SHA1_ID));
+	reftable_record_from_ref(&rec, &ref);
+
+	for (i = 0; i < N; i++) {
+		char name[100];
+		byte hash[SHA1_SIZE];
+		snprintf(name, sizeof(name), "branch%02d", i);
+		memset(hash, i, sizeof(hash));
+
+		ref.ref_name = name;
+		ref.value = hash;
+		names[i] = xstrdup(name);
+		n = block_writer_add(&bw, &rec);
+		ref.ref_name = NULL;
+		ref.value = NULL;
+		assert(n == 0);
+	}
+
+	n = block_writer_finish(&bw);
+	assert(n > 0);
+
+	block_writer_clear(&bw);
+
+	block_reader_init(&br, &block, header_off, block_size, SHA1_SIZE);
+
+	block_reader_start(&br, &it);
+
+	while (true) {
+		int r = block_iter_next(&it, &rec);
+		assert(r >= 0);
+		if (r > 0) {
+			break;
+		}
+		assert_streq(names[j], ref.ref_name);
+		j++;
+	}
+
+	reftable_record_clear(&rec);
+	block_iter_close(&it);
+
+	for (i = 0; i < N; i++) {
+		struct block_iter it = { .last_key = SLICE_INIT };
+		slice_set_string(&want, names[i]);
+
+		n = block_reader_seek(&br, &it, &want);
+		assert(n == 0);
+
+		n = block_iter_next(&it, &rec);
+		assert(n == 0);
+
+		assert_streq(names[i], ref.ref_name);
+
+		want.len--;
+		n = block_reader_seek(&br, &it, &want);
+		assert(n == 0);
+
+		n = block_iter_next(&it, &rec);
+		assert(n == 0);
+		assert_streq(names[10 * (i / 10)], ref.ref_name);
+
+		block_iter_close(&it);
+	}
+
+	reftable_record_clear(&rec);
+	reftable_block_done(&br.block);
+	slice_release(&want);
+	for (i = 0; i < N; i++) {
+		reftable_free(names[i]);
+	}
+}
+
+int block_test_main(int argc, const char *argv[])
+{
+	add_test_case("binsearch", &test_binsearch);
+	add_test_case("block_read_write", &test_block_read_write);
+	return test_main(argc, argv);
+}
diff --git a/reftable/constants.h b/reftable/constants.h
new file mode 100644
index 00000000000..5eee72c4c11
--- /dev/null
+++ b/reftable/constants.h
@@ -0,0 +1,21 @@
+/*
+Copyright 2020 Google LLC
+
+Use of this source code is governed by a BSD-style
+license that can be found in the LICENSE file or at
+https://developers.google.com/open-source/licenses/bsd
+*/
+
+#ifndef CONSTANTS_H
+#define CONSTANTS_H
+
+#define BLOCK_TYPE_LOG 'g'
+#define BLOCK_TYPE_INDEX 'i'
+#define BLOCK_TYPE_REF 'r'
+#define BLOCK_TYPE_OBJ 'o'
+#define BLOCK_TYPE_ANY 0
+
+#define MAX_RESTARTS ((1 << 16) - 1)
+#define DEFAULT_BLOCK_SIZE 4096
+
+#endif
diff --git a/reftable/file.c b/reftable/file.c
new file mode 100644
index 00000000000..63843a640b0
--- /dev/null
+++ b/reftable/file.c
@@ -0,0 +1,95 @@
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
+#include "block.h"
+#include "iter.h"
+#include "record.h"
+#include "reftable.h"
+#include "tree.h"
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
+
+int reftable_fd_write(void *arg, byte *data, size_t sz)
+{
+	int *fdp = (int *)arg;
+	return write(*fdp, data, sz);
+}
diff --git a/reftable/iter.c b/reftable/iter.c
new file mode 100644
index 00000000000..df7bcdc2160
--- /dev/null
+++ b/reftable/iter.c
@@ -0,0 +1,243 @@
+/*
+Copyright 2020 Google LLC
+
+Use of this source code is governed by a BSD-style
+license that can be found in the LICENSE file or at
+https://developers.google.com/open-source/licenses/bsd
+*/
+
+#include "iter.h"
+
+#include "system.h"
+
+#include "block.h"
+#include "constants.h"
+#include "reader.h"
+#include "reftable.h"
+
+bool iterator_is_null(struct reftable_iterator *it)
+{
+	return it->ops == NULL;
+}
+
+static int empty_iterator_next(void *arg, struct reftable_record *rec)
+{
+	return 1;
+}
+
+static void empty_iterator_close(void *arg)
+{
+}
+
+struct reftable_iterator_vtable empty_vtable = {
+	.next = &empty_iterator_next,
+	.close = &empty_iterator_close,
+};
+
+void iterator_set_empty(struct reftable_iterator *it)
+{
+	assert(it->ops == NULL);
+	it->iter_arg = NULL;
+	it->ops = &empty_vtable;
+}
+
+int iterator_next(struct reftable_iterator *it, struct reftable_record *rec)
+{
+	return it->ops->next(it->iter_arg, rec);
+}
+
+void reftable_iterator_destroy(struct reftable_iterator *it)
+{
+	if (it->ops == NULL) {
+		return;
+	}
+	it->ops->close(it->iter_arg);
+	it->ops = NULL;
+	FREE_AND_NULL(it->iter_arg);
+}
+
+int reftable_iterator_next_ref(struct reftable_iterator *it,
+			       struct reftable_ref_record *ref)
+{
+	struct reftable_record rec = { 0 };
+	reftable_record_from_ref(&rec, ref);
+	return iterator_next(it, &rec);
+}
+
+int reftable_iterator_next_log(struct reftable_iterator *it,
+			       struct reftable_log_record *log)
+{
+	struct reftable_record rec = { 0 };
+	reftable_record_from_log(&rec, log);
+	return iterator_next(it, &rec);
+}
+
+static void filtering_ref_iterator_close(void *iter_arg)
+{
+	struct filtering_ref_iterator *fri =
+		(struct filtering_ref_iterator *)iter_arg;
+	slice_release(&fri->oid);
+	reftable_iterator_destroy(&fri->it);
+}
+
+static int filtering_ref_iterator_next(void *iter_arg,
+				       struct reftable_record *rec)
+{
+	struct filtering_ref_iterator *fri =
+		(struct filtering_ref_iterator *)iter_arg;
+	struct reftable_ref_record *ref =
+		(struct reftable_ref_record *)rec->data;
+	int err = 0;
+	while (true) {
+		err = reftable_iterator_next_ref(&fri->it, ref);
+		if (err != 0) {
+			break;
+		}
+
+		if (fri->double_check) {
+			struct reftable_iterator it = { 0 };
+
+			err = reftable_table_seek_ref(&fri->tab, &it,
+						      ref->ref_name);
+			if (err == 0) {
+				err = reftable_iterator_next_ref(&it, ref);
+			}
+
+			reftable_iterator_destroy(&it);
+
+			if (err < 0) {
+				break;
+			}
+
+			if (err > 0) {
+				continue;
+			}
+		}
+
+		if ((ref->target_value != NULL &&
+		     !memcmp(fri->oid.buf, ref->target_value, fri->oid.len)) ||
+		    (ref->value != NULL &&
+		     !memcmp(fri->oid.buf, ref->value, fri->oid.len))) {
+			return 0;
+		}
+	}
+
+	reftable_ref_record_clear(ref);
+	return err;
+}
+
+struct reftable_iterator_vtable filtering_ref_iterator_vtable = {
+	.next = &filtering_ref_iterator_next,
+	.close = &filtering_ref_iterator_close,
+};
+
+void iterator_from_filtering_ref_iterator(struct reftable_iterator *it,
+					  struct filtering_ref_iterator *fri)
+{
+	assert(it->ops == NULL);
+	it->iter_arg = fri;
+	it->ops = &filtering_ref_iterator_vtable;
+}
+
+static void indexed_table_ref_iter_close(void *p)
+{
+	struct indexed_table_ref_iter *it = (struct indexed_table_ref_iter *)p;
+	block_iter_close(&it->cur);
+	reftable_block_done(&it->block_reader.block);
+	slice_release(&it->oid);
+}
+
+static int indexed_table_ref_iter_next_block(struct indexed_table_ref_iter *it)
+{
+	uint64_t off;
+	int err = 0;
+	if (it->offset_idx == it->offset_len) {
+		it->finished = true;
+		return 1;
+	}
+
+	reftable_block_done(&it->block_reader.block);
+
+	off = it->offsets[it->offset_idx++];
+	err = reader_init_block_reader(it->r, &it->block_reader, off,
+				       BLOCK_TYPE_REF);
+	if (err < 0) {
+		return err;
+	}
+	if (err > 0) {
+		/* indexed block does not exist. */
+		return REFTABLE_FORMAT_ERROR;
+	}
+	block_reader_start(&it->block_reader, &it->cur);
+	return 0;
+}
+
+static int indexed_table_ref_iter_next(void *p, struct reftable_record *rec)
+{
+	struct indexed_table_ref_iter *it = (struct indexed_table_ref_iter *)p;
+	struct reftable_ref_record *ref =
+		(struct reftable_ref_record *)rec->data;
+
+	while (true) {
+		int err = block_iter_next(&it->cur, rec);
+		if (err < 0) {
+			return err;
+		}
+
+		if (err > 0) {
+			err = indexed_table_ref_iter_next_block(it);
+			if (err < 0) {
+				return err;
+			}
+
+			if (it->finished) {
+				return 1;
+			}
+			continue;
+		}
+
+		if (!memcmp(it->oid.buf, ref->target_value, it->oid.len) ||
+		    !memcmp(it->oid.buf, ref->value, it->oid.len)) {
+			return 0;
+		}
+	}
+}
+
+int new_indexed_table_ref_iter(struct indexed_table_ref_iter **dest,
+			       struct reftable_reader *r, byte *oid,
+			       int oid_len, uint64_t *offsets, int offset_len)
+{
+	struct indexed_table_ref_iter empty = INDEXED_TABLE_REF_ITER_INIT;
+	struct indexed_table_ref_iter *itr =
+		reftable_calloc(sizeof(struct indexed_table_ref_iter));
+	int err = 0;
+
+	*itr = empty;
+	itr->r = r;
+	slice_resize(&itr->oid, oid_len);
+	memcpy(itr->oid.buf, oid, oid_len);
+
+	itr->offsets = offsets;
+	itr->offset_len = offset_len;
+
+	err = indexed_table_ref_iter_next_block(itr);
+	if (err < 0) {
+		reftable_free(itr);
+	} else {
+		*dest = itr;
+	}
+	return err;
+}
+
+struct reftable_iterator_vtable indexed_table_ref_iter_vtable = {
+	.next = &indexed_table_ref_iter_next,
+	.close = &indexed_table_ref_iter_close,
+};
+
+void iterator_from_indexed_table_ref_iter(struct reftable_iterator *it,
+					  struct indexed_table_ref_iter *itr)
+{
+	assert(it->ops == NULL);
+	it->iter_arg = itr;
+	it->ops = &indexed_table_ref_iter_vtable;
+}
diff --git a/reftable/iter.h b/reftable/iter.h
new file mode 100644
index 00000000000..b6294cf3206
--- /dev/null
+++ b/reftable/iter.h
@@ -0,0 +1,72 @@
+/*
+Copyright 2020 Google LLC
+
+Use of this source code is governed by a BSD-style
+license that can be found in the LICENSE file or at
+https://developers.google.com/open-source/licenses/bsd
+*/
+
+#ifndef ITER_H
+#define ITER_H
+
+#include "block.h"
+#include "record.h"
+#include "slice.h"
+
+struct reftable_iterator_vtable {
+	int (*next)(void *iter_arg, struct reftable_record *rec);
+	void (*close)(void *iter_arg);
+};
+
+void iterator_set_empty(struct reftable_iterator *it);
+int iterator_next(struct reftable_iterator *it, struct reftable_record *rec);
+
+/* Returns true for a zeroed out iterator, such as the one returned from
+   iterator_destroy. */
+bool iterator_is_null(struct reftable_iterator *it);
+
+/* iterator that produces only ref records that point to `oid` */
+struct filtering_ref_iterator {
+	bool double_check;
+	struct reftable_table tab;
+	struct slice oid;
+	struct reftable_iterator it;
+};
+#define FILTERING_REF_ITERATOR_INIT \
+	{                           \
+		.oid = SLICE_INIT   \
+	}
+
+void iterator_from_filtering_ref_iterator(struct reftable_iterator *,
+					  struct filtering_ref_iterator *);
+
+/* iterator that produces only ref records that point to `oid`,
+   but using the object index.
+ */
+struct indexed_table_ref_iter {
+	struct reftable_reader *r;
+	struct slice oid;
+
+	/* mutable */
+	uint64_t *offsets;
+
+	/* Points to the next offset to read. */
+	int offset_idx;
+	int offset_len;
+	struct block_reader block_reader;
+	struct block_iter cur;
+	bool finished;
+};
+
+#define INDEXED_TABLE_REF_ITER_INIT                                   \
+	{                                                             \
+		.cur = { .last_key = SLICE_INIT }, .oid = SLICE_INIT, \
+	}
+
+void iterator_from_indexed_table_ref_iter(struct reftable_iterator *it,
+					  struct indexed_table_ref_iter *itr);
+int new_indexed_table_ref_iter(struct indexed_table_ref_iter **dest,
+			       struct reftable_reader *r, byte *oid,
+			       int oid_len, uint64_t *offsets, int offset_len);
+
+#endif
diff --git a/reftable/merged.c b/reftable/merged.c
new file mode 100644
index 00000000000..5670a52a80d
--- /dev/null
+++ b/reftable/merged.c
@@ -0,0 +1,320 @@
+/*
+Copyright 2020 Google LLC
+
+Use of this source code is governed by a BSD-style
+license that can be found in the LICENSE file or at
+https://developers.google.com/open-source/licenses/bsd
+*/
+
+#include "merged.h"
+
+#include "system.h"
+
+#include "constants.h"
+#include "iter.h"
+#include "pq.h"
+#include "reader.h"
+
+static int merged_iter_init(struct merged_iter *mi)
+{
+	int i = 0;
+	for (i = 0; i < mi->stack_len; i++) {
+		struct reftable_record rec = reftable_new_record(mi->typ);
+		int err = iterator_next(&mi->stack[i], &rec);
+		if (err < 0) {
+			return err;
+		}
+
+		if (err > 0) {
+			reftable_iterator_destroy(&mi->stack[i]);
+			reftable_record_destroy(&rec);
+		} else {
+			struct pq_entry e = {
+				.rec = rec,
+				.index = i,
+			};
+			merged_iter_pqueue_add(&mi->pq, e);
+		}
+	}
+
+	return 0;
+}
+
+static void merged_iter_close(void *p)
+{
+	struct merged_iter *mi = (struct merged_iter *)p;
+	int i = 0;
+	merged_iter_pqueue_clear(&mi->pq);
+	for (i = 0; i < mi->stack_len; i++) {
+		reftable_iterator_destroy(&mi->stack[i]);
+	}
+	reftable_free(mi->stack);
+}
+
+static int merged_iter_advance_nonnull_subiter(struct merged_iter *mi,
+					       size_t idx)
+{
+	struct reftable_record rec = reftable_new_record(mi->typ);
+	struct pq_entry e = {
+		.rec = rec,
+		.index = idx,
+	};
+	int err = iterator_next(&mi->stack[idx], &rec);
+	if (err < 0)
+		return err;
+
+	if (err > 0) {
+		reftable_iterator_destroy(&mi->stack[idx]);
+		reftable_record_destroy(&rec);
+		return 0;
+	}
+
+	merged_iter_pqueue_add(&mi->pq, e);
+	return 0;
+}
+
+static int merged_iter_advance_subiter(struct merged_iter *mi, size_t idx)
+{
+	if (iterator_is_null(&mi->stack[idx]))
+		return 0;
+	return merged_iter_advance_nonnull_subiter(mi, idx);
+}
+
+static int merged_iter_next_entry(struct merged_iter *mi,
+				  struct reftable_record *rec)
+{
+	struct slice entry_key = SLICE_INIT;
+	struct pq_entry entry = { 0 };
+	int err = 0;
+
+	if (merged_iter_pqueue_is_empty(mi->pq))
+		return 1;
+
+	entry = merged_iter_pqueue_remove(&mi->pq);
+	err = merged_iter_advance_subiter(mi, entry.index);
+	if (err < 0)
+		return err;
+
+	/*
+	  One can also use reftable as datacenter-local storage, where the ref
+	  database is maintained in globally consistent database (eg.
+	  CockroachDB or Spanner). In this scenario, replication delays together
+	  with compaction may cause newer tables to contain older entries. In
+	  such a deployment, the loop below must be changed to collect all
+	  entries for the same key, and return new the newest one.
+	*/
+	reftable_record_key(&entry.rec, &entry_key);
+	while (!merged_iter_pqueue_is_empty(mi->pq)) {
+		struct pq_entry top = merged_iter_pqueue_top(mi->pq);
+		struct slice k = SLICE_INIT;
+		int err = 0, cmp = 0;
+
+		reftable_record_key(&top.rec, &k);
+
+		cmp = slice_cmp(&k, &entry_key);
+		slice_release(&k);
+
+		if (cmp > 0) {
+			break;
+		}
+
+		merged_iter_pqueue_remove(&mi->pq);
+		err = merged_iter_advance_subiter(mi, top.index);
+		if (err < 0) {
+			return err;
+		}
+		reftable_record_destroy(&top.rec);
+	}
+
+	reftable_record_copy_from(rec, &entry.rec, hash_size(mi->hash_id));
+	reftable_record_destroy(&entry.rec);
+	slice_release(&entry_key);
+	return 0;
+}
+
+static int merged_iter_next(struct merged_iter *mi, struct reftable_record *rec)
+{
+	while (true) {
+		int err = merged_iter_next_entry(mi, rec);
+		if (err == 0 && mi->suppress_deletions &&
+		    reftable_record_is_deletion(rec)) {
+			continue;
+		}
+
+		return err;
+	}
+}
+
+static int merged_iter_next_void(void *p, struct reftable_record *rec)
+{
+	struct merged_iter *mi = (struct merged_iter *)p;
+	if (merged_iter_pqueue_is_empty(mi->pq))
+		return 1;
+
+	return merged_iter_next(mi, rec);
+}
+
+struct reftable_iterator_vtable merged_iter_vtable = {
+	.next = &merged_iter_next_void,
+	.close = &merged_iter_close,
+};
+
+static void iterator_from_merged_iter(struct reftable_iterator *it,
+				      struct merged_iter *mi)
+{
+	assert(it->ops == NULL);
+	it->iter_arg = mi;
+	it->ops = &merged_iter_vtable;
+}
+
+int reftable_new_merged_table(struct reftable_merged_table **dest,
+			      struct reftable_reader **stack, int n,
+			      uint32_t hash_id)
+{
+	struct reftable_merged_table *m = NULL;
+	uint64_t last_max = 0;
+	uint64_t first_min = 0;
+	int i = 0;
+	for (i = 0; i < n; i++) {
+		struct reftable_reader *r = stack[i];
+		if (r->hash_id != hash_id) {
+			return REFTABLE_FORMAT_ERROR;
+		}
+		if (i > 0 && last_max >= reftable_reader_min_update_index(r)) {
+			return REFTABLE_FORMAT_ERROR;
+		}
+		if (i == 0) {
+			first_min = reftable_reader_min_update_index(r);
+		}
+
+		last_max = reftable_reader_max_update_index(r);
+	}
+
+	m = (struct reftable_merged_table *)reftable_calloc(
+		sizeof(struct reftable_merged_table));
+	m->stack = stack;
+	m->stack_len = n;
+	m->min = first_min;
+	m->max = last_max;
+	m->hash_id = hash_id;
+	*dest = m;
+	return 0;
+}
+
+void reftable_merged_table_close(struct reftable_merged_table *mt)
+{
+	int i = 0;
+	for (i = 0; i < mt->stack_len; i++) {
+		reftable_reader_free(mt->stack[i]);
+	}
+	FREE_AND_NULL(mt->stack);
+	mt->stack_len = 0;
+}
+
+/* clears the list of subtable, without affecting the readers themselves. */
+void merged_table_clear(struct reftable_merged_table *mt)
+{
+	FREE_AND_NULL(mt->stack);
+	mt->stack_len = 0;
+}
+
+void reftable_merged_table_free(struct reftable_merged_table *mt)
+{
+	if (mt == NULL) {
+		return;
+	}
+	merged_table_clear(mt);
+	reftable_free(mt);
+}
+
+uint64_t
+reftable_merged_table_max_update_index(struct reftable_merged_table *mt)
+{
+	return mt->max;
+}
+
+uint64_t
+reftable_merged_table_min_update_index(struct reftable_merged_table *mt)
+{
+	return mt->min;
+}
+
+int merged_table_seek_record(struct reftable_merged_table *mt,
+			     struct reftable_iterator *it,
+			     struct reftable_record *rec)
+{
+	struct reftable_iterator *iters = reftable_calloc(
+		sizeof(struct reftable_iterator) * mt->stack_len);
+	struct merged_iter merged = {
+		.stack = iters,
+		.typ = reftable_record_type(rec),
+		.hash_id = mt->hash_id,
+		.suppress_deletions = mt->suppress_deletions,
+	};
+	int n = 0;
+	int err = 0;
+	int i = 0;
+	for (i = 0; i < mt->stack_len && err == 0; i++) {
+		int e = reader_seek(mt->stack[i], &iters[n], rec);
+		if (e < 0) {
+			err = e;
+		}
+		if (e == 0) {
+			n++;
+		}
+	}
+	if (err < 0) {
+		int i = 0;
+		for (i = 0; i < n; i++) {
+			reftable_iterator_destroy(&iters[i]);
+		}
+		reftable_free(iters);
+		return err;
+	}
+
+	merged.stack_len = n;
+	err = merged_iter_init(&merged);
+	if (err < 0) {
+		merged_iter_close(&merged);
+		return err;
+	} else {
+		struct merged_iter *p =
+			reftable_malloc(sizeof(struct merged_iter));
+		*p = merged;
+		iterator_from_merged_iter(it, p);
+	}
+	return 0;
+}
+
+int reftable_merged_table_seek_ref(struct reftable_merged_table *mt,
+				   struct reftable_iterator *it,
+				   const char *name)
+{
+	struct reftable_ref_record ref = {
+		.ref_name = (char *)name,
+	};
+	struct reftable_record rec = { 0 };
+	reftable_record_from_ref(&rec, &ref);
+	return merged_table_seek_record(mt, it, &rec);
+}
+
+int reftable_merged_table_seek_log_at(struct reftable_merged_table *mt,
+				      struct reftable_iterator *it,
+				      const char *name, uint64_t update_index)
+{
+	struct reftable_log_record log = {
+		.ref_name = (char *)name,
+		.update_index = update_index,
+	};
+	struct reftable_record rec = { 0 };
+	reftable_record_from_log(&rec, &log);
+	return merged_table_seek_record(mt, it, &rec);
+}
+
+int reftable_merged_table_seek_log(struct reftable_merged_table *mt,
+				   struct reftable_iterator *it,
+				   const char *name)
+{
+	uint64_t max = ~((uint64_t)0);
+	return reftable_merged_table_seek_log_at(mt, it, name, max);
+}
diff --git a/reftable/merged.h b/reftable/merged.h
new file mode 100644
index 00000000000..4e03642bdbe
--- /dev/null
+++ b/reftable/merged.h
@@ -0,0 +1,39 @@
+/*
+Copyright 2020 Google LLC
+
+Use of this source code is governed by a BSD-style
+license that can be found in the LICENSE file or at
+https://developers.google.com/open-source/licenses/bsd
+*/
+
+#ifndef MERGED_H
+#define MERGED_H
+
+#include "pq.h"
+#include "reftable.h"
+
+struct reftable_merged_table {
+	struct reftable_reader **stack;
+	int stack_len;
+	uint32_t hash_id;
+	bool suppress_deletions;
+
+	uint64_t min;
+	uint64_t max;
+};
+
+struct merged_iter {
+	struct reftable_iterator *stack;
+	uint32_t hash_id;
+	int stack_len;
+	byte typ;
+	bool suppress_deletions;
+	struct merged_iter_pqueue pq;
+};
+
+void merged_table_clear(struct reftable_merged_table *mt);
+int merged_table_seek_record(struct reftable_merged_table *mt,
+			     struct reftable_iterator *it,
+			     struct reftable_record *rec);
+
+#endif
diff --git a/reftable/merged_test.c b/reftable/merged_test.c
new file mode 100644
index 00000000000..180ebcb1158
--- /dev/null
+++ b/reftable/merged_test.c
@@ -0,0 +1,273 @@
+/*
+Copyright 2020 Google LLC
+
+Use of this source code is governed by a BSD-style
+license that can be found in the LICENSE file or at
+https://developers.google.com/open-source/licenses/bsd
+*/
+
+#include "merged.h"
+
+#include "system.h"
+
+#include "basics.h"
+#include "block.h"
+#include "constants.h"
+#include "pq.h"
+#include "reader.h"
+#include "record.h"
+#include "reftable.h"
+#include "test_framework.h"
+#include "reftable-tests.h"
+
+static void test_pq(void)
+{
+	char *names[54] = { 0 };
+	int N = ARRAY_SIZE(names) - 1;
+
+	struct merged_iter_pqueue pq = { 0 };
+	const char *last = NULL;
+
+	int i = 0;
+	for (i = 0; i < N; i++) {
+		char name[100];
+		snprintf(name, sizeof(name), "%02d", i);
+		names[i] = xstrdup(name);
+	}
+
+	i = 1;
+	do {
+		struct reftable_record rec =
+			reftable_new_record(BLOCK_TYPE_REF);
+		struct pq_entry e = { 0 };
+
+		reftable_record_as_ref(&rec)->ref_name = names[i];
+		e.rec = rec;
+		merged_iter_pqueue_add(&pq, e);
+		merged_iter_pqueue_check(pq);
+		i = (i * 7) % N;
+	} while (i != 1);
+
+	while (!merged_iter_pqueue_is_empty(pq)) {
+		struct pq_entry e = merged_iter_pqueue_remove(&pq);
+		struct reftable_ref_record *ref =
+			reftable_record_as_ref(&e.rec);
+
+		merged_iter_pqueue_check(pq);
+
+		if (last != NULL) {
+			assert(strcmp(last, ref->ref_name) < 0);
+		}
+		last = ref->ref_name;
+		ref->ref_name = NULL;
+		reftable_free(ref);
+	}
+
+	for (i = 0; i < N; i++) {
+		reftable_free(names[i]);
+	}
+
+	merged_iter_pqueue_clear(&pq);
+}
+
+static void write_test_table(struct slice *buf,
+			     struct reftable_ref_record refs[], int n)
+{
+	int min = 0xffffffff;
+	int max = 0;
+	int i = 0;
+	int err;
+
+	struct reftable_write_options opts = {
+		.block_size = 256,
+	};
+	struct reftable_writer *w = NULL;
+	for (i = 0; i < n; i++) {
+		uint64_t ui = refs[i].update_index;
+		if (ui > max) {
+			max = ui;
+		}
+		if (ui < min) {
+			min = ui;
+		}
+	}
+
+	w = reftable_new_writer(&slice_add_void, buf, &opts);
+	reftable_writer_set_limits(w, min, max);
+
+	for (i = 0; i < n; i++) {
+		uint64_t before = refs[i].update_index;
+		int n = reftable_writer_add_ref(w, &refs[i]);
+		assert(n == 0);
+		assert(before == refs[i].update_index);
+	}
+
+	err = reftable_writer_close(w);
+	assert_err(err);
+
+	reftable_writer_free(w);
+}
+
+static struct reftable_merged_table *
+merged_table_from_records(struct reftable_ref_record **refs,
+			  struct reftable_block_source **source, int *sizes,
+			  struct slice *buf, int n)
+{
+	struct reftable_reader **rd = reftable_calloc(n * sizeof(*rd));
+	int i = 0;
+	struct reftable_merged_table *mt = NULL;
+	int err;
+	*source = reftable_calloc(n * sizeof(**source));
+	for (i = 0; i < n; i++) {
+		write_test_table(&buf[i], refs[i], sizes[i]);
+		block_source_from_slice(&(*source)[i], &buf[i]);
+
+		err = reftable_new_reader(&rd[i], &(*source)[i], "name");
+		assert_err(err);
+	}
+
+	err = reftable_new_merged_table(&mt, rd, n, SHA1_ID);
+	assert_err(err);
+	return mt;
+}
+
+static void test_merged_between(void)
+{
+	byte hash1[SHA1_SIZE] = { 1, 2, 3, 0 };
+
+	struct reftable_ref_record r1[] = { {
+		.ref_name = "b",
+		.update_index = 1,
+		.value = hash1,
+	} };
+	struct reftable_ref_record r2[] = { {
+		.ref_name = "a",
+		.update_index = 2,
+	} };
+
+	struct reftable_ref_record *refs[] = { r1, r2 };
+	int sizes[] = { 1, 1 };
+	struct slice bufs[2] = { SLICE_INIT, SLICE_INIT };
+	struct reftable_block_source *bs = NULL;
+	struct reftable_merged_table *mt =
+		merged_table_from_records(refs, &bs, sizes, bufs, 2);
+	int i;
+	struct reftable_ref_record ref = { 0 };
+	struct reftable_iterator it = { 0 };
+	int err = reftable_merged_table_seek_ref(mt, &it, "a");
+	assert_err(err);
+
+	err = reftable_iterator_next_ref(&it, &ref);
+	assert_err(err);
+	assert(ref.update_index == 2);
+	reftable_ref_record_clear(&ref);
+
+	reftable_iterator_destroy(&it);
+	reftable_merged_table_close(mt);
+	reftable_merged_table_free(mt);
+	for (i = 0; i < ARRAY_SIZE(bufs); i++) {
+		slice_release(&bufs[i]);
+	}
+	reftable_free(bs);
+}
+
+static void test_merged(void)
+{
+	byte hash1[SHA1_SIZE] = { 1 };
+	byte hash2[SHA1_SIZE] = { 2 };
+	struct reftable_ref_record r1[] = { {
+						    .ref_name = "a",
+						    .update_index = 1,
+						    .value = hash1,
+					    },
+					    {
+						    .ref_name = "b",
+						    .update_index = 1,
+						    .value = hash1,
+					    },
+					    {
+						    .ref_name = "c",
+						    .update_index = 1,
+						    .value = hash1,
+					    } };
+	struct reftable_ref_record r2[] = { {
+		.ref_name = "a",
+		.update_index = 2,
+	} };
+	struct reftable_ref_record r3[] = {
+		{
+			.ref_name = "c",
+			.update_index = 3,
+			.value = hash2,
+		},
+		{
+			.ref_name = "d",
+			.update_index = 3,
+			.value = hash1,
+		},
+	};
+
+	struct reftable_ref_record want[] = {
+		r2[0],
+		r1[1],
+		r3[0],
+		r3[1],
+	};
+
+	struct reftable_ref_record *refs[] = { r1, r2, r3 };
+	int sizes[3] = { 3, 1, 2 };
+	struct slice bufs[3] = { SLICE_INIT, SLICE_INIT, SLICE_INIT };
+	struct reftable_block_source *bs = NULL;
+
+	struct reftable_merged_table *mt =
+		merged_table_from_records(refs, &bs, sizes, bufs, 3);
+
+	struct reftable_iterator it = { 0 };
+	int err = reftable_merged_table_seek_ref(mt, &it, "a");
+	struct reftable_ref_record *out = NULL;
+	int len = 0;
+	int cap = 0;
+	int i = 0;
+
+	assert_err(err);
+	while (len < 100) { /* cap loops/recursion. */
+		struct reftable_ref_record ref = { 0 };
+		int err = reftable_iterator_next_ref(&it, &ref);
+		if (err > 0) {
+			break;
+		}
+		if (len == cap) {
+			cap = 2 * cap + 1;
+			out = reftable_realloc(
+				out, sizeof(struct reftable_ref_record) * cap);
+		}
+		out[len++] = ref;
+	}
+	reftable_iterator_destroy(&it);
+
+	assert(ARRAY_SIZE(want) == len);
+	for (i = 0; i < len; i++) {
+		assert(reftable_ref_record_equal(&want[i], &out[i], SHA1_SIZE));
+	}
+	for (i = 0; i < len; i++) {
+		reftable_ref_record_clear(&out[i]);
+	}
+	reftable_free(out);
+
+	for (i = 0; i < 3; i++) {
+		slice_release(&bufs[i]);
+	}
+	reftable_merged_table_close(mt);
+	reftable_merged_table_free(mt);
+	reftable_free(bs);
+}
+
+/* XXX test refs_for(oid) */
+
+int merged_test_main(int argc, const char *argv[])
+{
+	add_test_case("test_merged_between", &test_merged_between);
+	add_test_case("test_pq", &test_pq);
+	add_test_case("test_merged", &test_merged);
+	return test_main(argc, argv);
+}
diff --git a/reftable/pq.c b/reftable/pq.c
new file mode 100644
index 00000000000..3910d497113
--- /dev/null
+++ b/reftable/pq.c
@@ -0,0 +1,113 @@
+/*
+Copyright 2020 Google LLC
+
+Use of this source code is governed by a BSD-style
+license that can be found in the LICENSE file or at
+https://developers.google.com/open-source/licenses/bsd
+*/
+
+#include "pq.h"
+
+#include "system.h"
+
+int pq_less(struct pq_entry a, struct pq_entry b)
+{
+	struct slice ak = SLICE_INIT;
+	struct slice bk = SLICE_INIT;
+	int cmp = 0;
+	reftable_record_key(&a.rec, &ak);
+	reftable_record_key(&b.rec, &bk);
+
+	cmp = slice_cmp(&ak, &bk);
+
+	slice_release(&ak);
+	slice_release(&bk);
+
+	if (cmp == 0)
+		return a.index > b.index;
+
+	return cmp < 0;
+}
+
+struct pq_entry merged_iter_pqueue_top(struct merged_iter_pqueue pq)
+{
+	return pq.heap[0];
+}
+
+bool merged_iter_pqueue_is_empty(struct merged_iter_pqueue pq)
+{
+	return pq.len == 0;
+}
+
+void merged_iter_pqueue_check(struct merged_iter_pqueue pq)
+{
+	int i = 0;
+	for (i = 1; i < pq.len; i++) {
+		int parent = (i - 1) / 2;
+
+		assert(pq_less(pq.heap[parent], pq.heap[i]));
+	}
+}
+
+struct pq_entry merged_iter_pqueue_remove(struct merged_iter_pqueue *pq)
+{
+	int i = 0;
+	struct pq_entry e = pq->heap[0];
+	pq->heap[0] = pq->heap[pq->len - 1];
+	pq->len--;
+
+	i = 0;
+	while (i < pq->len) {
+		int min = i;
+		int j = 2 * i + 1;
+		int k = 2 * i + 2;
+		if (j < pq->len && pq_less(pq->heap[j], pq->heap[i])) {
+			min = j;
+		}
+		if (k < pq->len && pq_less(pq->heap[k], pq->heap[min])) {
+			min = k;
+		}
+
+		if (min == i) {
+			break;
+		}
+
+		SWAP(pq->heap[i], pq->heap[min]);
+		i = min;
+	}
+
+	return e;
+}
+
+void merged_iter_pqueue_add(struct merged_iter_pqueue *pq, struct pq_entry e)
+{
+	int i = 0;
+	if (pq->len == pq->cap) {
+		pq->cap = 2 * pq->cap + 1;
+		pq->heap = reftable_realloc(pq->heap,
+					    pq->cap * sizeof(struct pq_entry));
+	}
+
+	pq->heap[pq->len++] = e;
+	i = pq->len - 1;
+	while (i > 0) {
+		int j = (i - 1) / 2;
+		if (pq_less(pq->heap[j], pq->heap[i])) {
+			break;
+		}
+
+		SWAP(pq->heap[j], pq->heap[i]);
+
+		i = j;
+	}
+}
+
+void merged_iter_pqueue_clear(struct merged_iter_pqueue *pq)
+{
+	int i = 0;
+	for (i = 0; i < pq->len; i++) {
+		reftable_record_destroy(&pq->heap[i].rec);
+	}
+	FREE_AND_NULL(pq->heap);
+	pq->len = pq->cap = 0;
+}
diff --git a/reftable/pq.h b/reftable/pq.h
new file mode 100644
index 00000000000..43c0974f162
--- /dev/null
+++ b/reftable/pq.h
@@ -0,0 +1,34 @@
+/*
+Copyright 2020 Google LLC
+
+Use of this source code is governed by a BSD-style
+license that can be found in the LICENSE file or at
+https://developers.google.com/open-source/licenses/bsd
+*/
+
+#ifndef PQ_H
+#define PQ_H
+
+#include "record.h"
+
+struct pq_entry {
+	int index;
+	struct reftable_record rec;
+};
+
+int pq_less(struct pq_entry a, struct pq_entry b);
+
+struct merged_iter_pqueue {
+	struct pq_entry *heap;
+	int len;
+	int cap;
+};
+
+struct pq_entry merged_iter_pqueue_top(struct merged_iter_pqueue pq);
+bool merged_iter_pqueue_is_empty(struct merged_iter_pqueue pq);
+void merged_iter_pqueue_check(struct merged_iter_pqueue pq);
+struct pq_entry merged_iter_pqueue_remove(struct merged_iter_pqueue *pq);
+void merged_iter_pqueue_add(struct merged_iter_pqueue *pq, struct pq_entry e);
+void merged_iter_pqueue_clear(struct merged_iter_pqueue *pq);
+
+#endif
diff --git a/reftable/reader.c b/reftable/reader.c
new file mode 100644
index 00000000000..4e3c27cbc2e
--- /dev/null
+++ b/reftable/reader.c
@@ -0,0 +1,742 @@
+/*
+Copyright 2020 Google LLC
+
+Use of this source code is governed by a BSD-style
+license that can be found in the LICENSE file or at
+https://developers.google.com/open-source/licenses/bsd
+*/
+
+#include "reader.h"
+
+#include "system.h"
+#include "block.h"
+#include "constants.h"
+#include "iter.h"
+#include "record.h"
+#include "reftable.h"
+#include "tree.h"
+
+uint64_t block_source_size(struct reftable_block_source *source)
+{
+	return source->ops->size(source->arg);
+}
+
+int block_source_read_block(struct reftable_block_source *source,
+			    struct reftable_block *dest, uint64_t off,
+			    uint32_t size)
+{
+	int result = source->ops->read_block(source->arg, dest, off, size);
+	dest->source = *source;
+	return result;
+}
+
+void reftable_block_done(struct reftable_block *blockp)
+{
+	struct reftable_block_source source = blockp->source;
+	if (blockp != NULL && source.ops != NULL)
+		source.ops->return_block(source.arg, blockp);
+	blockp->data = NULL;
+	blockp->len = 0;
+	blockp->source.ops = NULL;
+	blockp->source.arg = NULL;
+}
+
+void block_source_close(struct reftable_block_source *source)
+{
+	if (source->ops == NULL) {
+		return;
+	}
+
+	source->ops->close(source->arg);
+	source->ops = NULL;
+}
+
+static struct reftable_reader_offsets *
+reader_offsets_for(struct reftable_reader *r, byte typ)
+{
+	switch (typ) {
+	case BLOCK_TYPE_REF:
+		return &r->ref_offsets;
+	case BLOCK_TYPE_LOG:
+		return &r->log_offsets;
+	case BLOCK_TYPE_OBJ:
+		return &r->obj_offsets;
+	}
+	abort();
+}
+
+static int reader_get_block(struct reftable_reader *r,
+			    struct reftable_block *dest, uint64_t off,
+			    uint32_t sz)
+{
+	if (off >= r->size)
+		return 0;
+
+	if (off + sz > r->size) {
+		sz = r->size - off;
+	}
+
+	return block_source_read_block(&r->source, dest, off, sz);
+}
+
+uint32_t reftable_reader_hash_id(struct reftable_reader *r)
+{
+	return r->hash_id;
+}
+
+const char *reader_name(struct reftable_reader *r)
+{
+	return r->name;
+}
+
+static int parse_footer(struct reftable_reader *r, byte *footer, byte *header)
+{
+	byte *f = footer;
+	byte first_block_typ;
+	int err = 0;
+	uint32_t computed_crc;
+	uint32_t file_crc;
+
+	if (memcmp(f, "REFT", 4)) {
+		err = REFTABLE_FORMAT_ERROR;
+		goto done;
+	}
+	f += 4;
+
+	if (memcmp(footer, header, header_size(r->version))) {
+		err = REFTABLE_FORMAT_ERROR;
+		goto done;
+	}
+
+	f++;
+	r->block_size = get_be24(f);
+
+	f += 3;
+	r->min_update_index = get_be64(f);
+	f += 8;
+	r->max_update_index = get_be64(f);
+	f += 8;
+
+	if (r->version == 1) {
+		r->hash_id = SHA1_ID;
+	} else {
+		r->hash_id = get_be32(f);
+		switch (r->hash_id) {
+		case SHA1_ID:
+			break;
+		case SHA256_ID:
+			break;
+		default:
+			err = REFTABLE_FORMAT_ERROR;
+			goto done;
+		}
+		f += 4;
+	}
+
+	r->ref_offsets.index_offset = get_be64(f);
+	f += 8;
+
+	r->obj_offsets.offset = get_be64(f);
+	f += 8;
+
+	r->object_id_len = r->obj_offsets.offset & ((1 << 5) - 1);
+	r->obj_offsets.offset >>= 5;
+
+	r->obj_offsets.index_offset = get_be64(f);
+	f += 8;
+	r->log_offsets.offset = get_be64(f);
+	f += 8;
+	r->log_offsets.index_offset = get_be64(f);
+	f += 8;
+
+	computed_crc = crc32(0, footer, f - footer);
+	file_crc = get_be32(f);
+	f += 4;
+	if (computed_crc != file_crc) {
+		err = REFTABLE_FORMAT_ERROR;
+		goto done;
+	}
+
+	first_block_typ = header[header_size(r->version)];
+	r->ref_offsets.present = (first_block_typ == BLOCK_TYPE_REF);
+	r->ref_offsets.offset = 0;
+	r->log_offsets.present = (first_block_typ == BLOCK_TYPE_LOG ||
+				  r->log_offsets.offset > 0);
+	r->obj_offsets.present = r->obj_offsets.offset > 0;
+	err = 0;
+done:
+	return err;
+}
+
+int init_reader(struct reftable_reader *r, struct reftable_block_source *source,
+		const char *name)
+{
+	struct reftable_block footer = { 0 };
+	struct reftable_block header = { 0 };
+	int err = 0;
+
+	memset(r, 0, sizeof(struct reftable_reader));
+
+	/* Need +1 to read type of first block. */
+	err = block_source_read_block(source, &header, 0, header_size(2) + 1);
+	if (err != header_size(2) + 1) {
+		err = REFTABLE_IO_ERROR;
+		goto done;
+	}
+
+	if (memcmp(header.data, "REFT", 4)) {
+		err = REFTABLE_FORMAT_ERROR;
+		goto done;
+	}
+	r->version = header.data[4];
+	if (r->version != 1 && r->version != 2) {
+		err = REFTABLE_FORMAT_ERROR;
+		goto done;
+	}
+
+	r->size = block_source_size(source) - footer_size(r->version);
+	r->source = *source;
+	r->name = xstrdup(name);
+	r->hash_id = 0;
+
+	err = block_source_read_block(source, &footer, r->size,
+				      footer_size(r->version));
+	if (err != footer_size(r->version)) {
+		err = REFTABLE_IO_ERROR;
+		goto done;
+	}
+
+	err = parse_footer(r, footer.data, header.data);
+done:
+	reftable_block_done(&footer);
+	reftable_block_done(&header);
+	return err;
+}
+
+struct table_iter {
+	struct reftable_reader *r;
+	byte typ;
+	uint64_t block_off;
+	struct block_iter bi;
+	bool finished;
+};
+#define TABLE_ITER_INIT                         \
+	{                                       \
+		.bi = {.last_key = SLICE_INIT } \
+	}
+
+static void table_iter_copy_from(struct table_iter *dest,
+				 struct table_iter *src)
+{
+	dest->r = src->r;
+	dest->typ = src->typ;
+	dest->block_off = src->block_off;
+	dest->finished = src->finished;
+	block_iter_copy_from(&dest->bi, &src->bi);
+}
+
+static int table_iter_next_in_block(struct table_iter *ti,
+				    struct reftable_record *rec)
+{
+	int res = block_iter_next(&ti->bi, rec);
+	if (res == 0 && reftable_record_type(rec) == BLOCK_TYPE_REF) {
+		((struct reftable_ref_record *)rec->data)->update_index +=
+			ti->r->min_update_index;
+	}
+
+	return res;
+}
+
+static void table_iter_block_done(struct table_iter *ti)
+{
+	if (ti->bi.br == NULL) {
+		return;
+	}
+	reftable_block_done(&ti->bi.br->block);
+	FREE_AND_NULL(ti->bi.br);
+
+	ti->bi.last_key.len = 0;
+	ti->bi.next_off = 0;
+}
+
+static int32_t extract_block_size(byte *data, byte *typ, uint64_t off,
+				  int version)
+{
+	int32_t result = 0;
+
+	if (off == 0) {
+		data += header_size(version);
+	}
+
+	*typ = data[0];
+	if (reftable_is_block_type(*typ)) {
+		result = get_be24(data + 1);
+	}
+	return result;
+}
+
+int reader_init_block_reader(struct reftable_reader *r, struct block_reader *br,
+			     uint64_t next_off, byte want_typ)
+{
+	int32_t guess_block_size = r->block_size ? r->block_size :
+						   DEFAULT_BLOCK_SIZE;
+	struct reftable_block block = { 0 };
+	byte block_typ = 0;
+	int err = 0;
+	uint32_t header_off = next_off ? 0 : header_size(r->version);
+	int32_t block_size = 0;
+
+	if (next_off >= r->size)
+		return 1;
+
+	err = reader_get_block(r, &block, next_off, guess_block_size);
+	if (err < 0)
+		return err;
+
+	block_size = extract_block_size(block.data, &block_typ, next_off,
+					r->version);
+	if (block_size < 0)
+		return block_size;
+
+	if (want_typ != BLOCK_TYPE_ANY && block_typ != want_typ) {
+		reftable_block_done(&block);
+		return 1;
+	}
+
+	if (block_size > guess_block_size) {
+		reftable_block_done(&block);
+		err = reader_get_block(r, &block, next_off, block_size);
+		if (err < 0) {
+			return err;
+		}
+	}
+
+	return block_reader_init(br, &block, header_off, r->block_size,
+				 hash_size(r->hash_id));
+}
+
+static int table_iter_next_block(struct table_iter *dest,
+				 struct table_iter *src)
+{
+	uint64_t next_block_off = src->block_off + src->bi.br->full_block_size;
+	struct block_reader br = { 0 };
+	int err = 0;
+
+	dest->r = src->r;
+	dest->typ = src->typ;
+	dest->block_off = next_block_off;
+
+	err = reader_init_block_reader(src->r, &br, next_block_off, src->typ);
+	if (err > 0) {
+		dest->finished = true;
+		return 1;
+	}
+	if (err != 0)
+		return err;
+	else {
+		struct block_reader *brp =
+			reftable_malloc(sizeof(struct block_reader));
+		*brp = br;
+
+		dest->finished = false;
+		block_reader_start(brp, &dest->bi);
+	}
+	return 0;
+}
+
+static int table_iter_next(struct table_iter *ti, struct reftable_record *rec)
+{
+	if (reftable_record_type(rec) != ti->typ)
+		return REFTABLE_API_ERROR;
+
+	while (true) {
+		struct table_iter next = TABLE_ITER_INIT;
+		int err = 0;
+		if (ti->finished) {
+			return 1;
+		}
+
+		err = table_iter_next_in_block(ti, rec);
+		if (err <= 0) {
+			return err;
+		}
+
+		err = table_iter_next_block(&next, ti);
+		if (err != 0) {
+			ti->finished = true;
+		}
+		table_iter_block_done(ti);
+		if (err != 0) {
+			return err;
+		}
+		table_iter_copy_from(ti, &next);
+		block_iter_close(&next.bi);
+	}
+}
+
+static int table_iter_next_void(void *ti, struct reftable_record *rec)
+{
+	return table_iter_next((struct table_iter *)ti, rec);
+}
+
+static void table_iter_close(void *p)
+{
+	struct table_iter *ti = (struct table_iter *)p;
+	table_iter_block_done(ti);
+	block_iter_close(&ti->bi);
+}
+
+struct reftable_iterator_vtable table_iter_vtable = {
+	.next = &table_iter_next_void,
+	.close = &table_iter_close,
+};
+
+static void iterator_from_table_iter(struct reftable_iterator *it,
+				     struct table_iter *ti)
+{
+	assert(it->ops == NULL);
+	it->iter_arg = ti;
+	it->ops = &table_iter_vtable;
+}
+
+static int reader_table_iter_at(struct reftable_reader *r,
+				struct table_iter *ti, uint64_t off, byte typ)
+{
+	struct block_reader br = { 0 };
+	struct block_reader *brp = NULL;
+
+	int err = reader_init_block_reader(r, &br, off, typ);
+	if (err != 0)
+		return err;
+
+	brp = reftable_malloc(sizeof(struct block_reader));
+	*brp = br;
+	ti->r = r;
+	ti->typ = block_reader_type(brp);
+	ti->block_off = off;
+	block_reader_start(brp, &ti->bi);
+	return 0;
+}
+
+static int reader_start(struct reftable_reader *r, struct table_iter *ti,
+			byte typ, bool index)
+{
+	struct reftable_reader_offsets *offs = reader_offsets_for(r, typ);
+	uint64_t off = offs->offset;
+	if (index) {
+		off = offs->index_offset;
+		if (off == 0) {
+			return 1;
+		}
+		typ = BLOCK_TYPE_INDEX;
+	}
+
+	return reader_table_iter_at(r, ti, off, typ);
+}
+
+static int reader_seek_linear(struct reftable_reader *r, struct table_iter *ti,
+			      struct reftable_record *want)
+{
+	struct reftable_record rec =
+		reftable_new_record(reftable_record_type(want));
+	struct slice want_key = SLICE_INIT;
+	struct slice got_key = SLICE_INIT;
+	struct table_iter next = TABLE_ITER_INIT;
+	int err = -1;
+
+	reftable_record_key(want, &want_key);
+
+	while (true) {
+		err = table_iter_next_block(&next, ti);
+		if (err < 0)
+			goto done;
+
+		if (err > 0) {
+			break;
+		}
+
+		err = block_reader_first_key(next.bi.br, &got_key);
+		if (err < 0)
+			goto done;
+
+		if (slice_cmp(&got_key, &want_key) > 0) {
+			table_iter_block_done(&next);
+			break;
+		}
+
+		table_iter_block_done(ti);
+		table_iter_copy_from(ti, &next);
+	}
+
+	err = block_iter_seek(&ti->bi, &want_key);
+	if (err < 0)
+		goto done;
+	err = 0;
+
+done:
+	block_iter_close(&next.bi);
+	reftable_record_destroy(&rec);
+	slice_release(&want_key);
+	slice_release(&got_key);
+	return err;
+}
+
+static int reader_seek_indexed(struct reftable_reader *r,
+			       struct reftable_iterator *it,
+			       struct reftable_record *rec)
+{
+	struct reftable_index_record want_index = { .last_key = SLICE_INIT };
+	struct reftable_record want_index_rec = { 0 };
+	struct reftable_index_record index_result = { .last_key = SLICE_INIT };
+	struct reftable_record index_result_rec = { 0 };
+	struct table_iter index_iter = TABLE_ITER_INIT;
+	struct table_iter next = TABLE_ITER_INIT;
+	int err = 0;
+
+	reftable_record_key(rec, &want_index.last_key);
+	reftable_record_from_index(&want_index_rec, &want_index);
+	reftable_record_from_index(&index_result_rec, &index_result);
+
+	err = reader_start(r, &index_iter, reftable_record_type(rec), true);
+	if (err < 0)
+		goto done;
+
+	err = reader_seek_linear(r, &index_iter, &want_index_rec);
+	while (true) {
+		err = table_iter_next(&index_iter, &index_result_rec);
+		table_iter_block_done(&index_iter);
+		if (err != 0)
+			goto done;
+
+		err = reader_table_iter_at(r, &next, index_result.offset, 0);
+		if (err != 0)
+			goto done;
+
+		err = block_iter_seek(&next.bi, &want_index.last_key);
+		if (err < 0)
+			goto done;
+
+		if (next.typ == reftable_record_type(rec)) {
+			err = 0;
+			break;
+		}
+
+		if (next.typ != BLOCK_TYPE_INDEX) {
+			err = REFTABLE_FORMAT_ERROR;
+			break;
+		}
+
+		table_iter_copy_from(&index_iter, &next);
+	}
+
+	if (err == 0) {
+		struct table_iter empty = TABLE_ITER_INIT;
+		struct table_iter *malloced =
+			reftable_calloc(sizeof(struct table_iter));
+		*malloced = empty;
+		table_iter_copy_from(malloced, &next);
+		iterator_from_table_iter(it, malloced);
+	}
+done:
+	block_iter_close(&next.bi);
+	table_iter_close(&index_iter);
+	reftable_record_clear(&want_index_rec);
+	reftable_record_clear(&index_result_rec);
+	return err;
+}
+
+static int reader_seek_internal(struct reftable_reader *r,
+				struct reftable_iterator *it,
+				struct reftable_record *rec)
+{
+	struct reftable_reader_offsets *offs =
+		reader_offsets_for(r, reftable_record_type(rec));
+	uint64_t idx = offs->index_offset;
+	struct table_iter ti = TABLE_ITER_INIT;
+	int err = 0;
+	if (idx > 0)
+		return reader_seek_indexed(r, it, rec);
+
+	err = reader_start(r, &ti, reftable_record_type(rec), false);
+	if (err < 0)
+		return err;
+	err = reader_seek_linear(r, &ti, rec);
+	if (err < 0)
+		return err;
+	else {
+		struct table_iter *p =
+			reftable_malloc(sizeof(struct table_iter));
+		*p = ti;
+		iterator_from_table_iter(it, p);
+	}
+
+	return 0;
+}
+
+int reader_seek(struct reftable_reader *r, struct reftable_iterator *it,
+		struct reftable_record *rec)
+{
+	byte typ = reftable_record_type(rec);
+
+	struct reftable_reader_offsets *offs = reader_offsets_for(r, typ);
+	if (!offs->present) {
+		iterator_set_empty(it);
+		return 0;
+	}
+
+	return reader_seek_internal(r, it, rec);
+}
+
+int reftable_reader_seek_ref(struct reftable_reader *r,
+			     struct reftable_iterator *it, const char *name)
+{
+	struct reftable_ref_record ref = {
+		.ref_name = (char *)name,
+	};
+	struct reftable_record rec = { 0 };
+	reftable_record_from_ref(&rec, &ref);
+	return reader_seek(r, it, &rec);
+}
+
+int reftable_reader_seek_log_at(struct reftable_reader *r,
+				struct reftable_iterator *it, const char *name,
+				uint64_t update_index)
+{
+	struct reftable_log_record log = {
+		.ref_name = (char *)name,
+		.update_index = update_index,
+	};
+	struct reftable_record rec = { 0 };
+	reftable_record_from_log(&rec, &log);
+	return reader_seek(r, it, &rec);
+}
+
+int reftable_reader_seek_log(struct reftable_reader *r,
+			     struct reftable_iterator *it, const char *name)
+{
+	uint64_t max = ~((uint64_t)0);
+	return reftable_reader_seek_log_at(r, it, name, max);
+}
+
+void reader_close(struct reftable_reader *r)
+{
+	block_source_close(&r->source);
+	FREE_AND_NULL(r->name);
+}
+
+int reftable_new_reader(struct reftable_reader **p,
+			struct reftable_block_source *src, char const *name)
+{
+	struct reftable_reader *rd =
+		reftable_calloc(sizeof(struct reftable_reader));
+	int err = init_reader(rd, src, name);
+	if (err == 0) {
+		*p = rd;
+	} else {
+		block_source_close(src);
+		reftable_free(rd);
+	}
+	return err;
+}
+
+void reftable_reader_free(struct reftable_reader *r)
+{
+	reader_close(r);
+	reftable_free(r);
+}
+
+static int reftable_reader_refs_for_indexed(struct reftable_reader *r,
+					    struct reftable_iterator *it,
+					    byte *oid)
+{
+	struct reftable_obj_record want = {
+		.hash_prefix = oid,
+		.hash_prefix_len = r->object_id_len,
+	};
+	struct reftable_record want_rec = { 0 };
+	struct reftable_iterator oit = { 0 };
+	struct reftable_obj_record got = { 0 };
+	struct reftable_record got_rec = { 0 };
+	int err = 0;
+	struct indexed_table_ref_iter *itr = NULL;
+
+	/* Look through the reverse index. */
+	reftable_record_from_obj(&want_rec, &want);
+	err = reader_seek(r, &oit, &want_rec);
+	if (err != 0)
+		goto done;
+
+	/* read out the reftable_obj_record */
+	reftable_record_from_obj(&got_rec, &got);
+	err = iterator_next(&oit, &got_rec);
+	if (err < 0)
+		goto done;
+
+	if (err > 0 ||
+	    memcmp(want.hash_prefix, got.hash_prefix, r->object_id_len)) {
+		/* didn't find it; return empty iterator */
+		iterator_set_empty(it);
+		err = 0;
+		goto done;
+	}
+
+	err = new_indexed_table_ref_iter(&itr, r, oid, hash_size(r->hash_id),
+					 got.offsets, got.offset_len);
+	if (err < 0)
+		goto done;
+	got.offsets = NULL;
+	iterator_from_indexed_table_ref_iter(it, itr);
+
+done:
+	reftable_iterator_destroy(&oit);
+	reftable_record_clear(&got_rec);
+	return err;
+}
+
+static int reftable_reader_refs_for_unindexed(struct reftable_reader *r,
+					      struct reftable_iterator *it,
+					      byte *oid)
+{
+	struct table_iter ti_empty = TABLE_ITER_INIT;
+	struct table_iter *ti = reftable_calloc(sizeof(struct table_iter));
+	struct filtering_ref_iterator *filter = NULL;
+	struct filtering_ref_iterator empty = FILTERING_REF_ITERATOR_INIT;
+	int oid_len = hash_size(r->hash_id);
+	int err;
+
+	*ti = ti_empty;
+	err = reader_start(r, ti, BLOCK_TYPE_REF, false);
+	if (err < 0) {
+		reftable_free(ti);
+		return err;
+	}
+
+	filter = reftable_malloc(sizeof(struct filtering_ref_iterator));
+	*filter = empty;
+	slice_resize(&filter->oid, oid_len);
+	memcpy(filter->oid.buf, oid, oid_len);
+	reftable_table_from_reader(&filter->tab, r);
+	filter->double_check = false;
+	iterator_from_table_iter(&filter->it, ti);
+
+	iterator_from_filtering_ref_iterator(it, filter);
+	return 0;
+}
+
+int reftable_reader_refs_for(struct reftable_reader *r,
+			     struct reftable_iterator *it, byte *oid)
+{
+	if (r->obj_offsets.present)
+		return reftable_reader_refs_for_indexed(r, it, oid);
+	return reftable_reader_refs_for_unindexed(r, it, oid);
+}
+
+uint64_t reftable_reader_max_update_index(struct reftable_reader *r)
+{
+	return r->max_update_index;
+}
+
+uint64_t reftable_reader_min_update_index(struct reftable_reader *r)
+{
+	return r->min_update_index;
+}
diff --git a/reftable/reader.h b/reftable/reader.h
new file mode 100644
index 00000000000..cc87aa49ea5
--- /dev/null
+++ b/reftable/reader.h
@@ -0,0 +1,65 @@
+/*
+Copyright 2020 Google LLC
+
+Use of this source code is governed by a BSD-style
+license that can be found in the LICENSE file or at
+https://developers.google.com/open-source/licenses/bsd
+*/
+
+#ifndef READER_H
+#define READER_H
+
+#include "block.h"
+#include "record.h"
+#include "reftable.h"
+
+uint64_t block_source_size(struct reftable_block_source *source);
+
+int block_source_read_block(struct reftable_block_source *source,
+			    struct reftable_block *dest, uint64_t off,
+			    uint32_t size);
+void block_source_close(struct reftable_block_source *source);
+
+/* metadata for a block type */
+struct reftable_reader_offsets {
+	bool present;
+	uint64_t offset;
+	uint64_t index_offset;
+};
+
+/* The state for reading a reftable file. */
+struct reftable_reader {
+	/* for convience, associate a name with the instance. */
+	char *name;
+	struct reftable_block_source source;
+
+	/* Size of the file, excluding the footer. */
+	uint64_t size;
+
+	/* 'sha1' for SHA1, 's256' for SHA-256 */
+	uint32_t hash_id;
+
+	uint32_t block_size;
+	uint64_t min_update_index;
+	uint64_t max_update_index;
+	/* Length of the OID keys in the 'o' section */
+	int object_id_len;
+	int version;
+
+	struct reftable_reader_offsets ref_offsets;
+	struct reftable_reader_offsets obj_offsets;
+	struct reftable_reader_offsets log_offsets;
+};
+
+int init_reader(struct reftable_reader *r, struct reftable_block_source *source,
+		const char *name);
+int reader_seek(struct reftable_reader *r, struct reftable_iterator *it,
+		struct reftable_record *rec);
+void reader_close(struct reftable_reader *r);
+const char *reader_name(struct reftable_reader *r);
+
+/* initialize a block reader to read from `r` */
+int reader_init_block_reader(struct reftable_reader *r, struct block_reader *br,
+			     uint64_t next_off, byte want_typ);
+
+#endif
diff --git a/reftable/record.c b/reftable/record.c
new file mode 100644
index 00000000000..38b690b6772
--- /dev/null
+++ b/reftable/record.c
@@ -0,0 +1,1113 @@
+/*
+Copyright 2020 Google LLC
+
+Use of this source code is governed by a BSD-style
+license that can be found in the LICENSE file or at
+https://developers.google.com/open-source/licenses/bsd
+*/
+
+/* record.c - methods for different types of records. */
+
+#include "record.h"
+
+#include "system.h"
+
+#include "constants.h"
+#include "reftable.h"
+
+int get_var_int(uint64_t *dest, struct slice *in)
+{
+	int ptr = 0;
+	uint64_t val;
+
+	if (in->len == 0)
+		return -1;
+	val = in->buf[ptr] & 0x7f;
+
+	while (in->buf[ptr] & 0x80) {
+		ptr++;
+		if (ptr > in->len) {
+			return -1;
+		}
+		val = (val + 1) << 7 | (uint64_t)(in->buf[ptr] & 0x7f);
+	}
+
+	*dest = val;
+	return ptr + 1;
+}
+
+int put_var_int(struct slice *dest, uint64_t val)
+{
+	byte buf[10] = { 0 };
+	int i = 9;
+	int n = 0;
+	buf[i] = (byte)(val & 0x7f);
+	i--;
+	while (true) {
+		val >>= 7;
+		if (!val) {
+			break;
+		}
+		val--;
+		buf[i] = 0x80 | (byte)(val & 0x7f);
+		i--;
+	}
+
+	n = sizeof(buf) - i - 1;
+	if (dest->len < n)
+		return -1;
+	memcpy(dest->buf, &buf[i + 1], n);
+	return n;
+}
+
+int reftable_is_block_type(byte typ)
+{
+	switch (typ) {
+	case BLOCK_TYPE_REF:
+	case BLOCK_TYPE_LOG:
+	case BLOCK_TYPE_OBJ:
+	case BLOCK_TYPE_INDEX:
+		return true;
+	}
+	return false;
+}
+
+static int decode_string(struct slice *dest, struct slice in)
+{
+	int start_len = in.len;
+	uint64_t tsize = 0;
+	int n = get_var_int(&tsize, &in);
+	if (n <= 0)
+		return -1;
+	slice_consume(&in, n);
+	if (in.len < tsize)
+		return -1;
+
+	slice_resize(dest, tsize + 1);
+	dest->buf[tsize] = 0;
+	memcpy(dest->buf, in.buf, tsize);
+	slice_consume(&in, tsize);
+
+	return start_len - in.len;
+}
+
+static int encode_string(char *str, struct slice s)
+{
+	struct slice start = s;
+	int l = strlen(str);
+	int n = put_var_int(&s, l);
+	if (n < 0)
+		return -1;
+	slice_consume(&s, n);
+	if (s.len < l)
+		return -1;
+	memcpy(s.buf, str, l);
+	slice_consume(&s, l);
+
+	return start.len - s.len;
+}
+
+int reftable_encode_key(bool *restart, struct slice dest, struct slice prev_key,
+			struct slice key, byte extra)
+{
+	struct slice start = dest;
+	int prefix_len = common_prefix_size(&prev_key, &key);
+	uint64_t suffix_len = key.len - prefix_len;
+	int n = put_var_int(&dest, (uint64_t)prefix_len);
+	if (n < 0)
+		return -1;
+	slice_consume(&dest, n);
+
+	*restart = (prefix_len == 0);
+
+	n = put_var_int(&dest, suffix_len << 3 | (uint64_t)extra);
+	if (n < 0)
+		return -1;
+	slice_consume(&dest, n);
+
+	if (dest.len < suffix_len)
+		return -1;
+	memcpy(dest.buf, key.buf + prefix_len, suffix_len);
+	slice_consume(&dest, suffix_len);
+
+	return start.len - dest.len;
+}
+
+int reftable_decode_key(struct slice *key, byte *extra, struct slice last_key,
+			struct slice in)
+{
+	int start_len = in.len;
+	uint64_t prefix_len = 0;
+	uint64_t suffix_len = 0;
+	int n = get_var_int(&prefix_len, &in);
+	if (n < 0)
+		return -1;
+	slice_consume(&in, n);
+
+	if (prefix_len > last_key.len)
+		return -1;
+
+	n = get_var_int(&suffix_len, &in);
+	if (n <= 0)
+		return -1;
+	slice_consume(&in, n);
+
+	*extra = (byte)(suffix_len & 0x7);
+	suffix_len >>= 3;
+
+	if (in.len < suffix_len)
+		return -1;
+
+	slice_resize(key, suffix_len + prefix_len);
+	memcpy(key->buf, last_key.buf, prefix_len);
+
+	memcpy(key->buf + prefix_len, in.buf, suffix_len);
+	slice_consume(&in, suffix_len);
+
+	return start_len - in.len;
+}
+
+static void reftable_ref_record_key(const void *r, struct slice *dest)
+{
+	const struct reftable_ref_record *rec =
+		(const struct reftable_ref_record *)r;
+	slice_set_string(dest, rec->ref_name);
+}
+
+static void reftable_ref_record_copy_from(void *rec, const void *src_rec,
+					  int hash_size)
+{
+	struct reftable_ref_record *ref = (struct reftable_ref_record *)rec;
+	struct reftable_ref_record *src = (struct reftable_ref_record *)src_rec;
+	assert(hash_size > 0);
+
+	/* This is simple and correct, but we could probably reuse the hash
+	   fields. */
+	reftable_ref_record_clear(ref);
+	if (src->ref_name != NULL) {
+		ref->ref_name = xstrdup(src->ref_name);
+	}
+
+	if (src->target != NULL) {
+		ref->target = xstrdup(src->target);
+	}
+
+	if (src->target_value != NULL) {
+		ref->target_value = reftable_malloc(hash_size);
+		memcpy(ref->target_value, src->target_value, hash_size);
+	}
+
+	if (src->value != NULL) {
+		ref->value = reftable_malloc(hash_size);
+		memcpy(ref->value, src->value, hash_size);
+	}
+	ref->update_index = src->update_index;
+}
+
+static char hexdigit(int c)
+{
+	if (c <= 9)
+		return '0' + c;
+	return 'a' + (c - 10);
+}
+
+static void hex_format(char *dest, byte *src, int hash_size)
+{
+	assert(hash_size > 0);
+	if (src != NULL) {
+		int i = 0;
+		for (i = 0; i < hash_size; i++) {
+			dest[2 * i] = hexdigit(src[i] >> 4);
+			dest[2 * i + 1] = hexdigit(src[i] & 0xf);
+		}
+		dest[2 * hash_size] = 0;
+	}
+}
+
+void reftable_ref_record_print(struct reftable_ref_record *ref,
+			       uint32_t hash_id)
+{
+	char hex[SHA256_SIZE + 1] = { 0 };
+	printf("ref{%s(%" PRIu64 ") ", ref->ref_name, ref->update_index);
+	if (ref->value != NULL) {
+		hex_format(hex, ref->value, hash_size(hash_id));
+		printf("%s", hex);
+	}
+	if (ref->target_value != NULL) {
+		hex_format(hex, ref->target_value, hash_size(hash_id));
+		printf(" (T %s)", hex);
+	}
+	if (ref->target != NULL) {
+		printf("=> %s", ref->target);
+	}
+	printf("}\n");
+}
+
+static void reftable_ref_record_clear_void(void *rec)
+{
+	reftable_ref_record_clear((struct reftable_ref_record *)rec);
+}
+
+void reftable_ref_record_clear(struct reftable_ref_record *ref)
+{
+	reftable_free(ref->ref_name);
+	reftable_free(ref->target);
+	reftable_free(ref->target_value);
+	reftable_free(ref->value);
+	memset(ref, 0, sizeof(struct reftable_ref_record));
+}
+
+static byte reftable_ref_record_val_type(const void *rec)
+{
+	const struct reftable_ref_record *r =
+		(const struct reftable_ref_record *)rec;
+	if (r->value != NULL) {
+		if (r->target_value != NULL) {
+			return 2;
+		} else {
+			return 1;
+		}
+	} else if (r->target != NULL)
+		return 3;
+	return 0;
+}
+
+static int reftable_ref_record_encode(const void *rec, struct slice s,
+				      int hash_size)
+{
+	const struct reftable_ref_record *r =
+		(const struct reftable_ref_record *)rec;
+	struct slice start = s;
+	int n = put_var_int(&s, r->update_index);
+	assert(hash_size > 0);
+	if (n < 0)
+		return -1;
+	slice_consume(&s, n);
+
+	if (r->value != NULL) {
+		if (s.len < hash_size) {
+			return -1;
+		}
+		memcpy(s.buf, r->value, hash_size);
+		slice_consume(&s, hash_size);
+	}
+
+	if (r->target_value != NULL) {
+		if (s.len < hash_size) {
+			return -1;
+		}
+		memcpy(s.buf, r->target_value, hash_size);
+		slice_consume(&s, hash_size);
+	}
+
+	if (r->target != NULL) {
+		int n = encode_string(r->target, s);
+		if (n < 0) {
+			return -1;
+		}
+		slice_consume(&s, n);
+	}
+
+	return start.len - s.len;
+}
+
+static int reftable_ref_record_decode(void *rec, struct slice key,
+				      byte val_type, struct slice in,
+				      int hash_size)
+{
+	struct reftable_ref_record *r = (struct reftable_ref_record *)rec;
+	struct slice start = in;
+	bool seen_value = false;
+	bool seen_target_value = false;
+	bool seen_target = false;
+
+	int n = get_var_int(&r->update_index, &in);
+	if (n < 0)
+		return n;
+	assert(hash_size > 0);
+
+	slice_consume(&in, n);
+
+	r->ref_name = reftable_realloc(r->ref_name, key.len + 1);
+	memcpy(r->ref_name, key.buf, key.len);
+	r->ref_name[key.len] = 0;
+
+	switch (val_type) {
+	case 1:
+	case 2:
+		if (in.len < hash_size) {
+			return -1;
+		}
+
+		if (r->value == NULL) {
+			r->value = reftable_malloc(hash_size);
+		}
+		seen_value = true;
+		memcpy(r->value, in.buf, hash_size);
+		slice_consume(&in, hash_size);
+		if (val_type == 1) {
+			break;
+		}
+		if (r->target_value == NULL) {
+			r->target_value = reftable_malloc(hash_size);
+		}
+		seen_target_value = true;
+		memcpy(r->target_value, in.buf, hash_size);
+		slice_consume(&in, hash_size);
+		break;
+	case 3: {
+		struct slice dest = SLICE_INIT;
+		int n = decode_string(&dest, in);
+		if (n < 0) {
+			return -1;
+		}
+		slice_consume(&in, n);
+		seen_target = true;
+		if (r->target != NULL) {
+			reftable_free(r->target);
+		}
+		r->target = (char *)slice_as_string(&dest);
+	} break;
+
+	case 0:
+		break;
+	default:
+		abort();
+		break;
+	}
+
+	if (!seen_target && r->target != NULL) {
+		FREE_AND_NULL(r->target);
+	}
+	if (!seen_target_value && r->target_value != NULL) {
+		FREE_AND_NULL(r->target_value);
+	}
+	if (!seen_value && r->value != NULL) {
+		FREE_AND_NULL(r->value);
+	}
+
+	return start.len - in.len;
+}
+
+static bool reftable_ref_record_is_deletion_void(const void *p)
+{
+	return reftable_ref_record_is_deletion(
+		(const struct reftable_ref_record *)p);
+}
+
+struct reftable_record_vtable reftable_ref_record_vtable = {
+	.key = &reftable_ref_record_key,
+	.type = BLOCK_TYPE_REF,
+	.copy_from = &reftable_ref_record_copy_from,
+	.val_type = &reftable_ref_record_val_type,
+	.encode = &reftable_ref_record_encode,
+	.decode = &reftable_ref_record_decode,
+	.clear = &reftable_ref_record_clear_void,
+	.is_deletion = &reftable_ref_record_is_deletion_void,
+};
+
+static void reftable_obj_record_key(const void *r, struct slice *dest)
+{
+	const struct reftable_obj_record *rec =
+		(const struct reftable_obj_record *)r;
+	slice_resize(dest, rec->hash_prefix_len);
+	memcpy(dest->buf, rec->hash_prefix, rec->hash_prefix_len);
+}
+
+static void reftable_obj_record_clear(void *rec)
+{
+	struct reftable_obj_record *obj = (struct reftable_obj_record *)rec;
+	FREE_AND_NULL(obj->hash_prefix);
+	FREE_AND_NULL(obj->offsets);
+	memset(obj, 0, sizeof(struct reftable_obj_record));
+}
+
+static void reftable_obj_record_copy_from(void *rec, const void *src_rec,
+					  int hash_size)
+{
+	struct reftable_obj_record *obj = (struct reftable_obj_record *)rec;
+	const struct reftable_obj_record *src =
+		(const struct reftable_obj_record *)src_rec;
+	int olen;
+
+	reftable_obj_record_clear(obj);
+	*obj = *src;
+	obj->hash_prefix = reftable_malloc(obj->hash_prefix_len);
+	memcpy(obj->hash_prefix, src->hash_prefix, obj->hash_prefix_len);
+
+	olen = obj->offset_len * sizeof(uint64_t);
+	obj->offsets = reftable_malloc(olen);
+	memcpy(obj->offsets, src->offsets, olen);
+}
+
+static byte reftable_obj_record_val_type(const void *rec)
+{
+	struct reftable_obj_record *r = (struct reftable_obj_record *)rec;
+	if (r->offset_len > 0 && r->offset_len < 8)
+		return r->offset_len;
+	return 0;
+}
+
+static int reftable_obj_record_encode(const void *rec, struct slice s,
+				      int hash_size)
+{
+	struct reftable_obj_record *r = (struct reftable_obj_record *)rec;
+	struct slice start = s;
+	int i = 0;
+	int n = 0;
+	uint64_t last = 0;
+	if (r->offset_len == 0 || r->offset_len >= 8) {
+		n = put_var_int(&s, r->offset_len);
+		if (n < 0) {
+			return -1;
+		}
+		slice_consume(&s, n);
+	}
+	if (r->offset_len == 0)
+		return start.len - s.len;
+	n = put_var_int(&s, r->offsets[0]);
+	if (n < 0)
+		return -1;
+	slice_consume(&s, n);
+
+	last = r->offsets[0];
+	for (i = 1; i < r->offset_len; i++) {
+		int n = put_var_int(&s, r->offsets[i] - last);
+		if (n < 0) {
+			return -1;
+		}
+		slice_consume(&s, n);
+		last = r->offsets[i];
+	}
+	return start.len - s.len;
+}
+
+static int reftable_obj_record_decode(void *rec, struct slice key,
+				      byte val_type, struct slice in,
+				      int hash_size)
+{
+	struct slice start = in;
+	struct reftable_obj_record *r = (struct reftable_obj_record *)rec;
+	uint64_t count = val_type;
+	int n = 0;
+	uint64_t last;
+	int j;
+	r->hash_prefix = reftable_malloc(key.len);
+	memcpy(r->hash_prefix, key.buf, key.len);
+	r->hash_prefix_len = key.len;
+
+	if (val_type == 0) {
+		n = get_var_int(&count, &in);
+		if (n < 0) {
+			return n;
+		}
+
+		slice_consume(&in, n);
+	}
+
+	r->offsets = NULL;
+	r->offset_len = 0;
+	if (count == 0)
+		return start.len - in.len;
+
+	r->offsets = reftable_malloc(count * sizeof(uint64_t));
+	r->offset_len = count;
+
+	n = get_var_int(&r->offsets[0], &in);
+	if (n < 0)
+		return n;
+	slice_consume(&in, n);
+
+	last = r->offsets[0];
+	j = 1;
+	while (j < count) {
+		uint64_t delta = 0;
+		int n = get_var_int(&delta, &in);
+		if (n < 0) {
+			return n;
+		}
+		slice_consume(&in, n);
+
+		last = r->offsets[j] = (delta + last);
+		j++;
+	}
+	return start.len - in.len;
+}
+
+static bool not_a_deletion(const void *p)
+{
+	return false;
+}
+
+struct reftable_record_vtable reftable_obj_record_vtable = {
+	.key = &reftable_obj_record_key,
+	.type = BLOCK_TYPE_OBJ,
+	.copy_from = &reftable_obj_record_copy_from,
+	.val_type = &reftable_obj_record_val_type,
+	.encode = &reftable_obj_record_encode,
+	.decode = &reftable_obj_record_decode,
+	.clear = &reftable_obj_record_clear,
+	.is_deletion = not_a_deletion,
+};
+
+void reftable_log_record_print(struct reftable_log_record *log,
+			       uint32_t hash_id)
+{
+	char hex[SHA256_SIZE + 1] = { 0 };
+
+	printf("log{%s(%" PRIu64 ") %s <%s> %" PRIu64 " %04d\n", log->ref_name,
+	       log->update_index, log->name, log->email, log->time,
+	       log->tz_offset);
+	hex_format(hex, log->old_hash, hash_size(hash_id));
+	printf("%s => ", hex);
+	hex_format(hex, log->new_hash, hash_size(hash_id));
+	printf("%s\n\n%s\n}\n", hex, log->message);
+}
+
+static void reftable_log_record_key(const void *r, struct slice *dest)
+{
+	const struct reftable_log_record *rec =
+		(const struct reftable_log_record *)r;
+	int len = strlen(rec->ref_name);
+	uint64_t ts = 0;
+	slice_resize(dest, len + 9);
+	memcpy(dest->buf, rec->ref_name, len + 1);
+	ts = (~ts) - rec->update_index;
+	put_be64(dest->buf + 1 + len, ts);
+}
+
+static void reftable_log_record_copy_from(void *rec, const void *src_rec,
+					  int hash_size)
+{
+	struct reftable_log_record *dst = (struct reftable_log_record *)rec;
+	const struct reftable_log_record *src =
+		(const struct reftable_log_record *)src_rec;
+
+	reftable_log_record_clear(dst);
+	*dst = *src;
+	if (dst->ref_name != NULL) {
+		dst->ref_name = xstrdup(dst->ref_name);
+	}
+	if (dst->email != NULL) {
+		dst->email = xstrdup(dst->email);
+	}
+	if (dst->name != NULL) {
+		dst->name = xstrdup(dst->name);
+	}
+	if (dst->message != NULL) {
+		dst->message = xstrdup(dst->message);
+	}
+
+	if (dst->new_hash != NULL) {
+		dst->new_hash = reftable_malloc(hash_size);
+		memcpy(dst->new_hash, src->new_hash, hash_size);
+	}
+	if (dst->old_hash != NULL) {
+		dst->old_hash = reftable_malloc(hash_size);
+		memcpy(dst->old_hash, src->old_hash, hash_size);
+	}
+}
+
+static void reftable_log_record_clear_void(void *rec)
+{
+	struct reftable_log_record *r = (struct reftable_log_record *)rec;
+	reftable_log_record_clear(r);
+}
+
+void reftable_log_record_clear(struct reftable_log_record *r)
+{
+	reftable_free(r->ref_name);
+	reftable_free(r->new_hash);
+	reftable_free(r->old_hash);
+	reftable_free(r->name);
+	reftable_free(r->email);
+	reftable_free(r->message);
+	memset(r, 0, sizeof(struct reftable_log_record));
+}
+
+static byte reftable_log_record_val_type(const void *rec)
+{
+	const struct reftable_log_record *log =
+		(const struct reftable_log_record *)rec;
+
+	return reftable_log_record_is_deletion(log) ? 0 : 1;
+}
+
+static byte zero[SHA256_SIZE] = { 0 };
+
+static int reftable_log_record_encode(const void *rec, struct slice s,
+				      int hash_size)
+{
+	struct reftable_log_record *r = (struct reftable_log_record *)rec;
+	struct slice start = s;
+	int n = 0;
+	byte *oldh = r->old_hash;
+	byte *newh = r->new_hash;
+	if (reftable_log_record_is_deletion(r))
+		return 0;
+
+	if (oldh == NULL) {
+		oldh = zero;
+	}
+	if (newh == NULL) {
+		newh = zero;
+	}
+
+	if (s.len < 2 * hash_size)
+		return -1;
+
+	memcpy(s.buf, oldh, hash_size);
+	memcpy(s.buf + hash_size, newh, hash_size);
+	slice_consume(&s, 2 * hash_size);
+
+	n = encode_string(r->name ? r->name : "", s);
+	if (n < 0)
+		return -1;
+	slice_consume(&s, n);
+
+	n = encode_string(r->email ? r->email : "", s);
+	if (n < 0)
+		return -1;
+	slice_consume(&s, n);
+
+	n = put_var_int(&s, r->time);
+	if (n < 0)
+		return -1;
+	slice_consume(&s, n);
+
+	if (s.len < 2)
+		return -1;
+
+	put_be16(s.buf, r->tz_offset);
+	slice_consume(&s, 2);
+
+	n = encode_string(r->message ? r->message : "", s);
+	if (n < 0)
+		return -1;
+	slice_consume(&s, n);
+
+	return start.len - s.len;
+}
+
+static int reftable_log_record_decode(void *rec, struct slice key,
+				      byte val_type, struct slice in,
+				      int hash_size)
+{
+	struct slice start = in;
+	struct reftable_log_record *r = (struct reftable_log_record *)rec;
+	uint64_t max = 0;
+	uint64_t ts = 0;
+	struct slice dest = SLICE_INIT;
+	int n;
+
+	if (key.len <= 9 || key.buf[key.len - 9] != 0)
+		return REFTABLE_FORMAT_ERROR;
+
+	r->ref_name = reftable_realloc(r->ref_name, key.len - 8);
+	memcpy(r->ref_name, key.buf, key.len - 8);
+	ts = get_be64(key.buf + key.len - 8);
+
+	r->update_index = (~max) - ts;
+
+	if (val_type == 0) {
+		FREE_AND_NULL(r->old_hash);
+		FREE_AND_NULL(r->new_hash);
+		FREE_AND_NULL(r->message);
+		FREE_AND_NULL(r->email);
+		FREE_AND_NULL(r->name);
+		return 0;
+	}
+
+	if (in.len < 2 * hash_size)
+		return REFTABLE_FORMAT_ERROR;
+
+	r->old_hash = reftable_realloc(r->old_hash, hash_size);
+	r->new_hash = reftable_realloc(r->new_hash, hash_size);
+
+	memcpy(r->old_hash, in.buf, hash_size);
+	memcpy(r->new_hash, in.buf + hash_size, hash_size);
+
+	slice_consume(&in, 2 * hash_size);
+
+	n = decode_string(&dest, in);
+	if (n < 0)
+		goto done;
+	slice_consume(&in, n);
+
+	r->name = reftable_realloc(r->name, dest.len + 1);
+	memcpy(r->name, dest.buf, dest.len);
+	r->name[dest.len] = 0;
+
+	slice_resize(&dest, 0);
+	n = decode_string(&dest, in);
+	if (n < 0)
+		goto done;
+	slice_consume(&in, n);
+
+	r->email = reftable_realloc(r->email, dest.len + 1);
+	memcpy(r->email, dest.buf, dest.len);
+	r->email[dest.len] = 0;
+
+	ts = 0;
+	n = get_var_int(&ts, &in);
+	if (n < 0)
+		goto done;
+	slice_consume(&in, n);
+	r->time = ts;
+	if (in.len < 2)
+		goto done;
+
+	r->tz_offset = get_be16(in.buf);
+	slice_consume(&in, 2);
+
+	slice_resize(&dest, 0);
+	n = decode_string(&dest, in);
+	if (n < 0)
+		goto done;
+	slice_consume(&in, n);
+
+	r->message = reftable_realloc(r->message, dest.len + 1);
+	memcpy(r->message, dest.buf, dest.len);
+	r->message[dest.len] = 0;
+
+	slice_release(&dest);
+	return start.len - in.len;
+
+done:
+	slice_release(&dest);
+	return REFTABLE_FORMAT_ERROR;
+}
+
+static bool null_streq(char *a, char *b)
+{
+	char *empty = "";
+	if (a == NULL)
+		a = empty;
+
+	if (b == NULL)
+		b = empty;
+
+	return 0 == strcmp(a, b);
+}
+
+static bool zero_hash_eq(byte *a, byte *b, int sz)
+{
+	if (a == NULL)
+		a = zero;
+
+	if (b == NULL)
+		b = zero;
+
+	return !memcmp(a, b, sz);
+}
+
+bool reftable_log_record_equal(struct reftable_log_record *a,
+			       struct reftable_log_record *b, int hash_size)
+{
+	return null_streq(a->name, b->name) && null_streq(a->email, b->email) &&
+	       null_streq(a->message, b->message) &&
+	       zero_hash_eq(a->old_hash, b->old_hash, hash_size) &&
+	       zero_hash_eq(a->new_hash, b->new_hash, hash_size) &&
+	       a->time == b->time && a->tz_offset == b->tz_offset &&
+	       a->update_index == b->update_index;
+}
+
+static bool reftable_log_record_is_deletion_void(const void *p)
+{
+	return reftable_log_record_is_deletion(
+		(const struct reftable_log_record *)p);
+}
+
+struct reftable_record_vtable reftable_log_record_vtable = {
+	.key = &reftable_log_record_key,
+	.type = BLOCK_TYPE_LOG,
+	.copy_from = &reftable_log_record_copy_from,
+	.val_type = &reftable_log_record_val_type,
+	.encode = &reftable_log_record_encode,
+	.decode = &reftable_log_record_decode,
+	.clear = &reftable_log_record_clear_void,
+	.is_deletion = &reftable_log_record_is_deletion_void,
+};
+
+struct reftable_record reftable_new_record(byte typ)
+{
+	struct reftable_record rec = { NULL };
+	switch (typ) {
+	case BLOCK_TYPE_REF: {
+		struct reftable_ref_record *r =
+			reftable_calloc(sizeof(struct reftable_ref_record));
+		reftable_record_from_ref(&rec, r);
+		return rec;
+	}
+
+	case BLOCK_TYPE_OBJ: {
+		struct reftable_obj_record *r =
+			reftable_calloc(sizeof(struct reftable_obj_record));
+		reftable_record_from_obj(&rec, r);
+		return rec;
+	}
+	case BLOCK_TYPE_LOG: {
+		struct reftable_log_record *r =
+			reftable_calloc(sizeof(struct reftable_log_record));
+		reftable_record_from_log(&rec, r);
+		return rec;
+	}
+	case BLOCK_TYPE_INDEX: {
+		struct reftable_index_record empty = { .last_key = SLICE_INIT };
+		struct reftable_index_record *r =
+			reftable_calloc(sizeof(struct reftable_index_record));
+		*r = empty;
+		reftable_record_from_index(&rec, r);
+		return rec;
+	}
+	}
+	abort();
+	return rec;
+}
+
+void *reftable_record_yield(struct reftable_record *rec)
+{
+	void *p = rec->data;
+	rec->data = NULL;
+	return p;
+}
+
+void reftable_record_destroy(struct reftable_record *rec)
+{
+	reftable_record_clear(rec);
+	reftable_free(reftable_record_yield(rec));
+}
+
+static void reftable_index_record_key(const void *r, struct slice *dest)
+{
+	struct reftable_index_record *rec = (struct reftable_index_record *)r;
+	slice_copy(dest, &rec->last_key);
+}
+
+static void reftable_index_record_copy_from(void *rec, const void *src_rec,
+					    int hash_size)
+{
+	struct reftable_index_record *dst = (struct reftable_index_record *)rec;
+	struct reftable_index_record *src =
+		(struct reftable_index_record *)src_rec;
+
+	slice_copy(&dst->last_key, &src->last_key);
+	dst->offset = src->offset;
+}
+
+static void reftable_index_record_clear(void *rec)
+{
+	struct reftable_index_record *idx = (struct reftable_index_record *)rec;
+	slice_release(&idx->last_key);
+}
+
+static byte reftable_index_record_val_type(const void *rec)
+{
+	return 0;
+}
+
+static int reftable_index_record_encode(const void *rec, struct slice out,
+					int hash_size)
+{
+	const struct reftable_index_record *r =
+		(const struct reftable_index_record *)rec;
+	struct slice start = out;
+
+	int n = put_var_int(&out, r->offset);
+	if (n < 0)
+		return n;
+
+	slice_consume(&out, n);
+
+	return start.len - out.len;
+}
+
+static int reftable_index_record_decode(void *rec, struct slice key,
+					byte val_type, struct slice in,
+					int hash_size)
+{
+	struct slice start = in;
+	struct reftable_index_record *r = (struct reftable_index_record *)rec;
+	int n = 0;
+
+	slice_copy(&r->last_key, &key);
+
+	n = get_var_int(&r->offset, &in);
+	if (n < 0)
+		return n;
+
+	slice_consume(&in, n);
+	return start.len - in.len;
+}
+
+struct reftable_record_vtable reftable_index_record_vtable = {
+	.key = &reftable_index_record_key,
+	.type = BLOCK_TYPE_INDEX,
+	.copy_from = &reftable_index_record_copy_from,
+	.val_type = &reftable_index_record_val_type,
+	.encode = &reftable_index_record_encode,
+	.decode = &reftable_index_record_decode,
+	.clear = &reftable_index_record_clear,
+	.is_deletion = &not_a_deletion,
+};
+
+void reftable_record_key(struct reftable_record *rec, struct slice *dest)
+{
+	rec->ops->key(rec->data, dest);
+}
+
+byte reftable_record_type(struct reftable_record *rec)
+{
+	return rec->ops->type;
+}
+
+int reftable_record_encode(struct reftable_record *rec, struct slice dest,
+			   int hash_size)
+{
+	return rec->ops->encode(rec->data, dest, hash_size);
+}
+
+void reftable_record_copy_from(struct reftable_record *rec,
+			       struct reftable_record *src, int hash_size)
+{
+	assert(src->ops->type == rec->ops->type);
+
+	rec->ops->copy_from(rec->data, src->data, hash_size);
+}
+
+byte reftable_record_val_type(struct reftable_record *rec)
+{
+	return rec->ops->val_type(rec->data);
+}
+
+int reftable_record_decode(struct reftable_record *rec, struct slice key,
+			   byte extra, struct slice src, int hash_size)
+{
+	return rec->ops->decode(rec->data, key, extra, src, hash_size);
+}
+
+void reftable_record_clear(struct reftable_record *rec)
+{
+	rec->ops->clear(rec->data);
+}
+
+bool reftable_record_is_deletion(struct reftable_record *rec)
+{
+	return rec->ops->is_deletion(rec->data);
+}
+
+void reftable_record_from_ref(struct reftable_record *rec,
+			      struct reftable_ref_record *ref_rec)
+{
+	assert(rec->ops == NULL);
+	rec->data = ref_rec;
+	rec->ops = &reftable_ref_record_vtable;
+}
+
+void reftable_record_from_obj(struct reftable_record *rec,
+			      struct reftable_obj_record *obj_rec)
+{
+	assert(rec->ops == NULL);
+	rec->data = obj_rec;
+	rec->ops = &reftable_obj_record_vtable;
+}
+
+void reftable_record_from_index(struct reftable_record *rec,
+				struct reftable_index_record *index_rec)
+{
+	assert(rec->ops == NULL);
+	rec->data = index_rec;
+	rec->ops = &reftable_index_record_vtable;
+}
+
+void reftable_record_from_log(struct reftable_record *rec,
+			      struct reftable_log_record *log_rec)
+{
+	assert(rec->ops == NULL);
+	rec->data = log_rec;
+	rec->ops = &reftable_log_record_vtable;
+}
+
+struct reftable_ref_record *reftable_record_as_ref(struct reftable_record *rec)
+{
+	assert(reftable_record_type(rec) == BLOCK_TYPE_REF);
+	return (struct reftable_ref_record *)rec->data;
+}
+
+struct reftable_log_record *reftable_record_as_log(struct reftable_record *rec)
+{
+	assert(reftable_record_type(rec) == BLOCK_TYPE_LOG);
+	return (struct reftable_log_record *)rec->data;
+}
+
+static bool hash_equal(byte *a, byte *b, int hash_size)
+{
+	if (a != NULL && b != NULL)
+		return !memcmp(a, b, hash_size);
+
+	return a == b;
+}
+
+static bool str_equal(char *a, char *b)
+{
+	if (a != NULL && b != NULL)
+		return 0 == strcmp(a, b);
+
+	return a == b;
+}
+
+bool reftable_ref_record_equal(struct reftable_ref_record *a,
+			       struct reftable_ref_record *b, int hash_size)
+{
+	assert(hash_size > 0);
+	return 0 == strcmp(a->ref_name, b->ref_name) &&
+	       a->update_index == b->update_index &&
+	       hash_equal(a->value, b->value, hash_size) &&
+	       hash_equal(a->target_value, b->target_value, hash_size) &&
+	       str_equal(a->target, b->target);
+}
+
+int reftable_ref_record_compare_name(const void *a, const void *b)
+{
+	return strcmp(((struct reftable_ref_record *)a)->ref_name,
+		      ((struct reftable_ref_record *)b)->ref_name);
+}
+
+bool reftable_ref_record_is_deletion(const struct reftable_ref_record *ref)
+{
+	return ref->value == NULL && ref->target == NULL &&
+	       ref->target_value == NULL;
+}
+
+int reftable_log_record_compare_key(const void *a, const void *b)
+{
+	struct reftable_log_record *la = (struct reftable_log_record *)a;
+	struct reftable_log_record *lb = (struct reftable_log_record *)b;
+
+	int cmp = strcmp(la->ref_name, lb->ref_name);
+	if (cmp)
+		return cmp;
+	if (la->update_index > lb->update_index)
+		return -1;
+	return (la->update_index < lb->update_index) ? 1 : 0;
+}
+
+bool reftable_log_record_is_deletion(const struct reftable_log_record *log)
+{
+	return (log->new_hash == NULL && log->old_hash == NULL &&
+		log->name == NULL && log->email == NULL &&
+		log->message == NULL && log->time == 0 && log->tz_offset == 0 &&
+		log->message == NULL);
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
diff --git a/reftable/record.h b/reftable/record.h
new file mode 100644
index 00000000000..f9cd6cc3ce2
--- /dev/null
+++ b/reftable/record.h
@@ -0,0 +1,128 @@
+/*
+Copyright 2020 Google LLC
+
+Use of this source code is governed by a BSD-style
+license that can be found in the LICENSE file or at
+https://developers.google.com/open-source/licenses/bsd
+*/
+
+#ifndef RECORD_H
+#define RECORD_H
+
+#include "reftable.h"
+#include "slice.h"
+
+/* utilities for de/encoding varints */
+
+int get_var_int(uint64_t *dest, struct slice *in);
+int put_var_int(struct slice *dest, uint64_t val);
+
+/* Methods for records. */
+struct reftable_record_vtable {
+	/* encode the key of to a byte slice. */
+	void (*key)(const void *rec, struct slice *dest);
+
+	/* The record type of ('r' for ref). */
+	byte type;
+
+	void (*copy_from)(void *dest, const void *src, int hash_size);
+
+	/* a value of [0..7], indicating record subvariants (eg. ref vs. symref
+	 * vs ref deletion) */
+	byte (*val_type)(const void *rec);
+
+	/* encodes rec into dest, returning how much space was used. */
+	int (*encode)(const void *rec, struct slice dest, int hash_size);
+
+	/* decode data from `src` into the record. */
+	int (*decode)(void *rec, struct slice key, byte extra, struct slice src,
+		      int hash_size);
+
+	/* deallocate and null the record. */
+	void (*clear)(void *rec);
+
+	/* is this a tombstone? */
+	bool (*is_deletion)(const void *rec);
+};
+
+/* record is a generic wrapper for different types of records. */
+struct reftable_record {
+	void *data;
+	struct reftable_record_vtable *ops;
+};
+
+/* returns true for recognized block types. Block start with the block type. */
+int reftable_is_block_type(byte typ);
+
+/* creates a malloced record of the given type. Dispose with record_destroy */
+struct reftable_record reftable_new_record(byte typ);
+
+extern struct reftable_record_vtable reftable_ref_record_vtable;
+
+/* Encode `key` into `dest`. Sets `restart` to indicate a restart. Returns
+   number of bytes written. */
+int reftable_encode_key(bool *restart, struct slice dest, struct slice prev_key,
+			struct slice key, byte extra);
+
+/* Decode into `key` and `extra` from `in` */
+int reftable_decode_key(struct slice *key, byte *extra, struct slice last_key,
+			struct slice in);
+
+/* reftable_index_record are used internally to speed up lookups. */
+struct reftable_index_record {
+	uint64_t offset; /* Offset of block */
+	struct slice last_key; /* Last key of the block. */
+};
+
+/* reftable_obj_record stores an object ID => ref mapping. */
+struct reftable_obj_record {
+	byte *hash_prefix; /* leading bytes of the object ID */
+	int hash_prefix_len; /* number of leading bytes. Constant
+			      * across a single table. */
+	uint64_t *offsets; /* a vector of file offsets. */
+	int offset_len;
+};
+
+/* see struct record_vtable */
+
+void reftable_record_key(struct reftable_record *rec, struct slice *dest);
+byte reftable_record_type(struct reftable_record *rec);
+void reftable_record_copy_from(struct reftable_record *rec,
+			       struct reftable_record *src, int hash_size);
+byte reftable_record_val_type(struct reftable_record *rec);
+int reftable_record_encode(struct reftable_record *rec, struct slice dest,
+			   int hash_size);
+int reftable_record_decode(struct reftable_record *rec, struct slice key,
+			   byte extra, struct slice src, int hash_size);
+bool reftable_record_is_deletion(struct reftable_record *rec);
+
+/* zeroes out the embedded record */
+void reftable_record_clear(struct reftable_record *rec);
+
+/* clear out the record, yielding the reftable_record data that was
+ * encapsulated. */
+void *reftable_record_yield(struct reftable_record *rec);
+
+/* clear and deallocate embedded record, and zero `rec`. */
+void reftable_record_destroy(struct reftable_record *rec);
+
+/* initialize generic records from concrete records. The generic record should
+ * be zeroed out. */
+void reftable_record_from_obj(struct reftable_record *rec,
+			      struct reftable_obj_record *objrec);
+void reftable_record_from_index(struct reftable_record *rec,
+				struct reftable_index_record *idxrec);
+void reftable_record_from_ref(struct reftable_record *rec,
+			      struct reftable_ref_record *refrec);
+void reftable_record_from_log(struct reftable_record *rec,
+			      struct reftable_log_record *logrec);
+struct reftable_ref_record *reftable_record_as_ref(struct reftable_record *ref);
+struct reftable_log_record *reftable_record_as_log(struct reftable_record *ref);
+
+/* for qsort. */
+int reftable_ref_record_compare_name(const void *a, const void *b);
+
+/* for qsort. */
+int reftable_log_record_compare_key(const void *a, const void *b);
+
+#endif
diff --git a/reftable/record_test.c b/reftable/record_test.c
new file mode 100644
index 00000000000..acdc07688b2
--- /dev/null
+++ b/reftable/record_test.c
@@ -0,0 +1,400 @@
+/*
+Copyright 2020 Google LLC
+
+Use of this source code is governed by a BSD-style
+license that can be found in the LICENSE file or at
+https://developers.google.com/open-source/licenses/bsd
+*/
+
+#include "record.h"
+
+#include "system.h"
+#include "basics.h"
+#include "constants.h"
+#include "reftable.h"
+#include "test_framework.h"
+#include "reftable-tests.h"
+
+static void test_copy(struct reftable_record *rec)
+{
+	struct reftable_record copy =
+		reftable_new_record(reftable_record_type(rec));
+	reftable_record_copy_from(&copy, rec, SHA1_SIZE);
+	/* do it twice to catch memory leaks */
+	reftable_record_copy_from(&copy, rec, SHA1_SIZE);
+	switch (reftable_record_type(&copy)) {
+	case BLOCK_TYPE_REF:
+		assert(reftable_ref_record_equal(reftable_record_as_ref(&copy),
+						 reftable_record_as_ref(rec),
+						 SHA1_SIZE));
+		break;
+	case BLOCK_TYPE_LOG:
+		assert(reftable_log_record_equal(reftable_record_as_log(&copy),
+						 reftable_record_as_log(rec),
+						 SHA1_SIZE));
+		break;
+	}
+	reftable_record_destroy(&copy);
+}
+
+static void test_varint_roundtrip(void)
+{
+	uint64_t inputs[] = { 0,
+			      1,
+			      27,
+			      127,
+			      128,
+			      257,
+			      4096,
+			      ((uint64_t)1 << 63),
+			      ((uint64_t)1 << 63) + ((uint64_t)1 << 63) - 1 };
+	int i = 0;
+	for (i = 0; i < ARRAY_SIZE(inputs); i++) {
+		byte dest[10];
+
+		struct slice out = { .buf = dest, .len = 10, .cap = 10 };
+
+		uint64_t in = inputs[i];
+		int n = put_var_int(&out, in);
+		uint64_t got = 0;
+
+		assert(n > 0);
+		out.len = n;
+		n = get_var_int(&got, &out);
+		assert(n > 0);
+
+		assert(got == in);
+	}
+}
+
+static void test_common_prefix(void)
+{
+	struct {
+		const char *a, *b;
+		int want;
+	} cases[] = {
+		{ "abc", "ab", 2 },
+		{ "", "abc", 0 },
+		{ "abc", "abd", 2 },
+		{ "abc", "pqr", 0 },
+	};
+
+	int i = 0;
+	for (i = 0; i < ARRAY_SIZE(cases); i++) {
+		struct slice a = SLICE_INIT;
+		struct slice b = SLICE_INIT;
+		slice_set_string(&a, cases[i].a);
+		slice_set_string(&b, cases[i].b);
+
+		assert(common_prefix_size(&a, &b) == cases[i].want);
+
+		slice_release(&a);
+		slice_release(&b);
+	}
+}
+
+static void set_hash(byte *h, int j)
+{
+	int i = 0;
+	for (i = 0; i < hash_size(SHA1_ID); i++) {
+		h[i] = (j >> i) & 0xff;
+	}
+}
+
+static void test_reftable_ref_record_roundtrip(void)
+{
+	int i = 0;
+
+	for (i = 0; i <= 3; i++) {
+		struct reftable_ref_record in = { 0 };
+		struct reftable_ref_record out = {
+			.ref_name = xstrdup("old name"),
+			.value = reftable_calloc(SHA1_SIZE),
+			.target_value = reftable_calloc(SHA1_SIZE),
+			.target = xstrdup("old value"),
+		};
+		struct reftable_record rec_out = { 0 };
+		struct slice key = SLICE_INIT;
+		struct reftable_record rec = { 0 };
+		struct slice dest = SLICE_INIT;
+		int n, m;
+
+		switch (i) {
+		case 0:
+			break;
+		case 1:
+			in.value = reftable_malloc(SHA1_SIZE);
+			set_hash(in.value, 1);
+			break;
+		case 2:
+			in.value = reftable_malloc(SHA1_SIZE);
+			set_hash(in.value, 1);
+			in.target_value = reftable_malloc(SHA1_SIZE);
+			set_hash(in.target_value, 2);
+			break;
+		case 3:
+			in.target = xstrdup("target");
+			break;
+		}
+		in.ref_name = xstrdup("refs/heads/master");
+
+		reftable_record_from_ref(&rec, &in);
+		test_copy(&rec);
+
+		assert(reftable_record_val_type(&rec) == i);
+
+		reftable_record_key(&rec, &key);
+		slice_resize(&dest, 1024);
+		n = reftable_record_encode(&rec, dest, SHA1_SIZE);
+		assert(n > 0);
+
+		/* decode into a non-zero reftable_record to test for leaks. */
+
+		reftable_record_from_ref(&rec_out, &out);
+		m = reftable_record_decode(&rec_out, key, i, dest, SHA1_SIZE);
+		assert(n == m);
+
+		assert((out.value != NULL) == (in.value != NULL));
+		assert((out.target_value != NULL) == (in.target_value != NULL));
+		assert((out.target != NULL) == (in.target != NULL));
+		reftable_record_clear(&rec_out);
+
+		slice_release(&key);
+		slice_release(&dest);
+		reftable_ref_record_clear(&in);
+	}
+}
+
+static void test_reftable_log_record_equal(void)
+{
+	struct reftable_log_record in[2] = {
+		{
+			.ref_name = xstrdup("refs/heads/master"),
+			.update_index = 42,
+		},
+		{
+			.ref_name = xstrdup("refs/heads/master"),
+			.update_index = 22,
+		}
+	};
+
+	assert(!reftable_log_record_equal(&in[0], &in[1], SHA1_SIZE));
+	in[1].update_index = in[0].update_index;
+	assert(reftable_log_record_equal(&in[0], &in[1], SHA1_SIZE));
+	reftable_log_record_clear(&in[0]);
+	reftable_log_record_clear(&in[1]);
+}
+
+static void test_reftable_log_record_roundtrip(void)
+{
+	struct reftable_log_record in[2] = {
+		{
+			.ref_name = xstrdup("refs/heads/master"),
+			.old_hash = reftable_malloc(SHA1_SIZE),
+			.new_hash = reftable_malloc(SHA1_SIZE),
+			.name = xstrdup("han-wen"),
+			.email = xstrdup("hanwen@google.com"),
+			.message = xstrdup("test"),
+			.update_index = 42,
+			.time = 1577123507,
+			.tz_offset = 100,
+		},
+		{
+			.ref_name = xstrdup("refs/heads/master"),
+			.update_index = 22,
+		}
+	};
+	set_test_hash(in[0].new_hash, 1);
+	set_test_hash(in[0].old_hash, 2);
+	for (int i = 0; i < ARRAY_SIZE(in); i++) {
+		struct reftable_record rec = { 0 };
+		struct slice key = SLICE_INIT;
+		struct slice dest = SLICE_INIT;
+		/* populate out, to check for leaks. */
+		struct reftable_log_record out = {
+			.ref_name = xstrdup("old name"),
+			.new_hash = reftable_calloc(SHA1_SIZE),
+			.old_hash = reftable_calloc(SHA1_SIZE),
+			.name = xstrdup("old name"),
+			.email = xstrdup("old@email"),
+			.message = xstrdup("old message"),
+		};
+		struct reftable_record rec_out = { 0 };
+		int n, m, valtype;
+
+		reftable_record_from_log(&rec, &in[i]);
+
+		test_copy(&rec);
+
+		reftable_record_key(&rec, &key);
+
+		slice_resize(&dest, 1024);
+
+		n = reftable_record_encode(&rec, dest, SHA1_SIZE);
+		assert(n >= 0);
+		reftable_record_from_log(&rec_out, &out);
+		valtype = reftable_record_val_type(&rec);
+		m = reftable_record_decode(&rec_out, key, valtype, dest,
+					   SHA1_SIZE);
+		assert(n == m);
+
+		assert(reftable_log_record_equal(&in[i], &out, SHA1_SIZE));
+		reftable_log_record_clear(&in[i]);
+		slice_release(&key);
+		slice_release(&dest);
+		reftable_record_clear(&rec_out);
+	}
+}
+
+static void test_u24_roundtrip(void)
+{
+	uint32_t in = 0x112233;
+	byte dest[3];
+	uint32_t out;
+	put_be24(dest, in);
+	out = get_be24(dest);
+	assert(in == out);
+}
+
+static void test_key_roundtrip(void)
+{
+	struct slice dest = SLICE_INIT;
+	struct slice last_key = SLICE_INIT;
+	struct slice key = SLICE_INIT;
+	struct slice roundtrip = SLICE_INIT;
+	bool restart;
+	byte extra;
+	int n, m;
+	byte rt_extra;
+
+	slice_resize(&dest, 1024);
+	slice_set_string(&last_key, "refs/heads/master");
+	slice_set_string(&key, "refs/tags/bla");
+
+	extra = 6;
+	n = reftable_encode_key(&restart, dest, last_key, key, extra);
+	assert(!restart);
+	assert(n > 0);
+
+	m = reftable_decode_key(&roundtrip, &rt_extra, last_key, dest);
+	assert(n == m);
+	assert(slice_equal(&key, &roundtrip));
+	assert(rt_extra == extra);
+
+	slice_release(&last_key);
+	slice_release(&key);
+	slice_release(&dest);
+	slice_release(&roundtrip);
+}
+
+static void test_reftable_obj_record_roundtrip(void)
+{
+	byte testHash1[SHA1_SIZE] = { 1, 2, 3, 4, 0 };
+	uint64_t till9[] = { 1, 2, 3, 4, 500, 600, 700, 800, 9000 };
+	struct reftable_obj_record recs[3] = { {
+						       .hash_prefix = testHash1,
+						       .hash_prefix_len = 5,
+						       .offsets = till9,
+						       .offset_len = 3,
+					       },
+					       {
+						       .hash_prefix = testHash1,
+						       .hash_prefix_len = 5,
+						       .offsets = till9,
+						       .offset_len = 9,
+					       },
+					       {
+						       .hash_prefix = testHash1,
+						       .hash_prefix_len = 5,
+					       } };
+	int i = 0;
+	for (i = 0; i < ARRAY_SIZE(recs); i++) {
+		struct reftable_obj_record in = recs[i];
+		struct slice dest = SLICE_INIT;
+		struct reftable_record rec = { 0 };
+		struct slice key = SLICE_INIT;
+		struct reftable_obj_record out = { 0 };
+		struct reftable_record rec_out = { 0 };
+		int n, m;
+		byte extra;
+
+		reftable_record_from_obj(&rec, &in);
+		test_copy(&rec);
+		reftable_record_key(&rec, &key);
+		slice_resize(&dest, 1024);
+		n = reftable_record_encode(&rec, dest, SHA1_SIZE);
+		assert(n > 0);
+		extra = reftable_record_val_type(&rec);
+		reftable_record_from_obj(&rec_out, &out);
+		m = reftable_record_decode(&rec_out, key, extra, dest,
+					   SHA1_SIZE);
+		assert(n == m);
+
+		assert(in.hash_prefix_len == out.hash_prefix_len);
+		assert(in.offset_len == out.offset_len);
+
+		assert(!memcmp(in.hash_prefix, out.hash_prefix,
+			       in.hash_prefix_len));
+		assert(0 == memcmp(in.offsets, out.offsets,
+				   sizeof(uint64_t) * in.offset_len));
+		slice_release(&key);
+		slice_release(&dest);
+		reftable_record_clear(&rec_out);
+	}
+}
+
+static void test_reftable_index_record_roundtrip(void)
+{
+	struct reftable_index_record in = {
+		.offset = 42,
+		.last_key = SLICE_INIT,
+	};
+	struct slice dest = SLICE_INIT;
+	struct slice key = SLICE_INIT;
+	struct reftable_record rec = { 0 };
+	struct reftable_index_record out = { .last_key = SLICE_INIT };
+	struct reftable_record out_rec = { NULL };
+	int n, m;
+	byte extra;
+
+	slice_set_string(&in.last_key, "refs/heads/master");
+	reftable_record_from_index(&rec, &in);
+	reftable_record_key(&rec, &key);
+	test_copy(&rec);
+
+	assert(0 == slice_cmp(&key, &in.last_key));
+	slice_resize(&dest, 1024);
+	n = reftable_record_encode(&rec, dest, SHA1_SIZE);
+	assert(n > 0);
+
+	extra = reftable_record_val_type(&rec);
+	reftable_record_from_index(&out_rec, &out);
+	m = reftable_record_decode(&out_rec, key, extra, dest, SHA1_SIZE);
+	assert(m == n);
+
+	assert(in.offset == out.offset);
+
+	reftable_record_clear(&out_rec);
+	slice_release(&key);
+	slice_release(&in.last_key);
+	slice_release(&dest);
+}
+
+int record_test_main(int argc, const char *argv[])
+{
+	add_test_case("test_reftable_log_record_equal",
+		      &test_reftable_log_record_equal);
+	add_test_case("test_reftable_log_record_roundtrip",
+		      &test_reftable_log_record_roundtrip);
+	add_test_case("test_reftable_ref_record_roundtrip",
+		      &test_reftable_ref_record_roundtrip);
+	add_test_case("test_varint_roundtrip", &test_varint_roundtrip);
+	add_test_case("test_key_roundtrip", &test_key_roundtrip);
+	add_test_case("test_common_prefix", &test_common_prefix);
+	add_test_case("test_reftable_obj_record_roundtrip",
+		      &test_reftable_obj_record_roundtrip);
+	add_test_case("test_reftable_index_record_roundtrip",
+		      &test_reftable_index_record_roundtrip);
+	add_test_case("test_u24_roundtrip", &test_u24_roundtrip);
+	return test_main(argc, argv);
+}
diff --git a/reftable/refname.c b/reftable/refname.c
new file mode 100644
index 00000000000..7226329e20b
--- /dev/null
+++ b/reftable/refname.c
@@ -0,0 +1,209 @@
+/*
+  Copyright 2020 Google LLC
+
+  Use of this source code is governed by a BSD-style
+  license that can be found in the LICENSE file or at
+  https://developers.google.com/open-source/licenses/bsd
+*/
+
+#include "system.h"
+#include "reftable.h"
+#include "basics.h"
+#include "refname.h"
+#include "slice.h"
+
+struct find_arg {
+	char **names;
+	const char *want;
+};
+
+static int find_name(size_t k, void *arg)
+{
+	struct find_arg *f_arg = (struct find_arg *)arg;
+	return strcmp(f_arg->names[k], f_arg->want) >= 0;
+}
+
+int modification_has_ref(struct modification *mod, const char *name)
+{
+	struct reftable_ref_record ref = { 0 };
+	int err = 0;
+
+	if (mod->add_len > 0) {
+		struct find_arg arg = {
+			.names = mod->add,
+			.want = name,
+		};
+		int idx = binsearch(mod->add_len, find_name, &arg);
+		if (idx < mod->add_len && !strcmp(mod->add[idx], name)) {
+			return 0;
+		}
+	}
+
+	if (mod->del_len > 0) {
+		struct find_arg arg = {
+			.names = mod->del,
+			.want = name,
+		};
+		int idx = binsearch(mod->del_len, find_name, &arg);
+		if (idx < mod->del_len && !strcmp(mod->del[idx], name)) {
+			return 1;
+		}
+	}
+
+	err = reftable_table_read_ref(&mod->tab, name, &ref);
+	reftable_ref_record_clear(&ref);
+	return err;
+}
+
+static void modification_clear(struct modification *mod)
+{
+	/* don't delete the strings themselves; they're owned by ref records.
+	 */
+	FREE_AND_NULL(mod->add);
+	FREE_AND_NULL(mod->del);
+	mod->add_len = 0;
+	mod->del_len = 0;
+}
+
+int modification_has_ref_with_prefix(struct modification *mod,
+				     const char *prefix)
+{
+	struct reftable_iterator it = { NULL };
+	struct reftable_ref_record ref = { NULL };
+	int err = 0;
+
+	if (mod->add_len > 0) {
+		struct find_arg arg = {
+			.names = mod->add,
+			.want = prefix,
+		};
+		int idx = binsearch(mod->add_len, find_name, &arg);
+		if (idx < mod->add_len &&
+		    !strncmp(prefix, mod->add[idx], strlen(prefix)))
+			goto done;
+	}
+	err = reftable_table_seek_ref(&mod->tab, &it, prefix);
+	if (err)
+		goto done;
+
+	while (true) {
+		err = reftable_iterator_next_ref(&it, &ref);
+		if (err)
+			goto done;
+
+		if (mod->del_len > 0) {
+			struct find_arg arg = {
+				.names = mod->del,
+				.want = ref.ref_name,
+			};
+			int idx = binsearch(mod->del_len, find_name, &arg);
+			if (idx < mod->del_len &&
+			    !strcmp(ref.ref_name, mod->del[idx])) {
+				continue;
+			}
+		}
+
+		if (strncmp(ref.ref_name, prefix, strlen(prefix))) {
+			err = 1;
+			goto done;
+		}
+		err = 0;
+		goto done;
+	}
+
+done:
+	reftable_ref_record_clear(&ref);
+	reftable_iterator_destroy(&it);
+	return err;
+}
+
+int validate_ref_name(const char *name)
+{
+	while (true) {
+		char *next = strchr(name, '/');
+		if (!*name) {
+			return REFTABLE_REFNAME_ERROR;
+		}
+		if (!next) {
+			return 0;
+		}
+		if (next - name == 0 || (next - name == 1 && *name == '.') ||
+		    (next - name == 2 && name[0] == '.' && name[1] == '.'))
+			return REFTABLE_REFNAME_ERROR;
+		name = next + 1;
+	}
+	return 0;
+}
+
+int validate_ref_record_addition(struct reftable_table tab,
+				 struct reftable_ref_record *recs, size_t sz)
+{
+	struct modification mod = {
+		.tab = tab,
+		.add = reftable_calloc(sizeof(char *) * sz),
+		.del = reftable_calloc(sizeof(char *) * sz),
+	};
+	int i = 0;
+	int err = 0;
+	for (; i < sz; i++) {
+		if (reftable_ref_record_is_deletion(&recs[i])) {
+			mod.del[mod.del_len++] = recs[i].ref_name;
+		} else {
+			mod.add[mod.add_len++] = recs[i].ref_name;
+		}
+	}
+
+	err = modification_validate(&mod);
+	modification_clear(&mod);
+	return err;
+}
+
+static void slice_trim_component(struct slice *sl)
+{
+	while (sl->len > 0) {
+		bool is_slash = (sl->buf[sl->len - 1] == '/');
+		sl->len--;
+		if (is_slash)
+			break;
+	}
+}
+
+int modification_validate(struct modification *mod)
+{
+	struct slice slashed = SLICE_INIT;
+	int err = 0;
+	int i = 0;
+	for (; i < mod->add_len; i++) {
+		err = validate_ref_name(mod->add[i]);
+		if (err)
+			goto done;
+		slice_set_string(&slashed, mod->add[i]);
+		slice_addstr(&slashed, "/");
+
+		err = modification_has_ref_with_prefix(
+			mod, slice_as_string(&slashed));
+		if (err == 0) {
+			err = REFTABLE_NAME_CONFLICT;
+			goto done;
+		}
+		if (err < 0)
+			goto done;
+
+		slice_set_string(&slashed, mod->add[i]);
+		while (slashed.len) {
+			slice_trim_component(&slashed);
+			err = modification_has_ref(mod,
+						   slice_as_string(&slashed));
+			if (err == 0) {
+				err = REFTABLE_NAME_CONFLICT;
+				goto done;
+			}
+			if (err < 0)
+				goto done;
+		}
+	}
+	err = 0;
+done:
+	slice_release(&slashed);
+	return err;
+}
diff --git a/reftable/refname.h b/reftable/refname.h
new file mode 100644
index 00000000000..f335287fcdb
--- /dev/null
+++ b/reftable/refname.h
@@ -0,0 +1,38 @@
+/*
+  Copyright 2020 Google LLC
+
+  Use of this source code is governed by a BSD-style
+  license that can be found in the LICENSE file or at
+  https://developers.google.com/open-source/licenses/bsd
+*/
+#ifndef REFNAME_H
+#define REFNAME_H
+
+#include "reftable.h"
+
+struct modification {
+	struct reftable_table tab;
+
+	char **add;
+	size_t add_len;
+
+	char **del;
+	size_t del_len;
+};
+
+// -1 = error, 0 = found, 1 = not found
+int modification_has_ref(struct modification *mod, const char *name);
+
+// -1 = error, 0 = found, 1 = not found.
+int modification_has_ref_with_prefix(struct modification *mod,
+				     const char *prefix);
+
+// 0 = OK.
+int validate_ref_name(const char *name);
+
+int validate_ref_record_addition(struct reftable_table tab,
+				 struct reftable_ref_record *recs, size_t sz);
+
+int modification_validate(struct modification *mod);
+
+#endif
diff --git a/reftable/refname_test.c b/reftable/refname_test.c
new file mode 100644
index 00000000000..c8a91ccaa18
--- /dev/null
+++ b/reftable/refname_test.c
@@ -0,0 +1,99 @@
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
+#include "block.h"
+#include "constants.h"
+#include "reader.h"
+#include "record.h"
+#include "refname.h"
+#include "system.h"
+
+#include "test_framework.h"
+#include "reftable-tests.h"
+
+struct testcase {
+	char *add;
+	char *del;
+	int error_code;
+};
+
+static void test_conflict(void)
+{
+	struct reftable_write_options opts = { 0 };
+	struct slice buf = SLICE_INIT;
+	struct reftable_writer *w =
+		reftable_new_writer(&slice_add_void, &buf, &opts);
+	struct reftable_ref_record rec = {
+		.ref_name = "a/b",
+		.target = "destination", /* make sure it's not a symref. */
+		.update_index = 1,
+	};
+	int err;
+	int i;
+	struct reftable_block_source source = { 0 };
+	struct reftable_reader *rd = NULL;
+	struct reftable_table tab = { NULL };
+	struct testcase cases[] = {
+		{ "a/b/c", NULL, REFTABLE_NAME_CONFLICT },
+		{ "b", NULL, 0 },
+		{ "a", NULL, REFTABLE_NAME_CONFLICT },
+		{ "a", "a/b", 0 },
+
+		{ "p/", NULL, REFTABLE_REFNAME_ERROR },
+		{ "p//q", NULL, REFTABLE_REFNAME_ERROR },
+		{ "p/./q", NULL, REFTABLE_REFNAME_ERROR },
+		{ "p/../q", NULL, REFTABLE_REFNAME_ERROR },
+
+		{ "a/b/c", "a/b", 0 },
+		{ NULL, "a//b", 0 },
+	};
+	reftable_writer_set_limits(w, 1, 1);
+
+	err = reftable_writer_add_ref(w, &rec);
+	assert_err(err);
+
+	err = reftable_writer_close(w);
+	assert_err(err);
+	reftable_writer_free(w);
+
+	block_source_from_slice(&source, &buf);
+	err = reftable_new_reader(&rd, &source, "filename");
+	assert_err(err);
+
+	reftable_table_from_reader(&tab, rd);
+
+	for (i = 0; i < ARRAY_SIZE(cases); i++) {
+		struct modification mod = {
+			.tab = tab,
+		};
+
+		if (cases[i].add != NULL) {
+			mod.add = &cases[i].add;
+			mod.add_len = 1;
+		}
+		if (cases[i].del != NULL) {
+			mod.del = &cases[i].del;
+			mod.del_len = 1;
+		}
+
+		err = modification_validate(&mod);
+		assert(err == cases[i].error_code);
+	}
+
+	reftable_reader_free(rd);
+	slice_release(&buf);
+}
+
+int refname_test_main(int argc, const char *argv[])
+{
+	add_test_case("test_conflict", &test_conflict);
+	return test_main(argc, argv);
+}
diff --git a/reftable/reftable-tests.h b/reftable/reftable-tests.h
new file mode 100644
index 00000000000..031e1ef2c5b
--- /dev/null
+++ b/reftable/reftable-tests.h
@@ -0,0 +1,13 @@
+#ifndef REFTABLE_TESTS_H
+#define REFTABLE_TESTS_H
+
+int block_test_main(int argc, const char **argv);
+int merged_test_main(int argc, const char **argv);
+int record_test_main(int argc, const char **argv);
+int refname_test_main(int argc, const char **argv);
+int reftable_test_main(int argc, const char **argv);
+int slice_test_main(int argc, const char **argv);
+int stack_test_main(int argc, const char **argv);
+int tree_test_main(int argc, const char **argv);
+
+#endif
diff --git a/reftable/reftable.c b/reftable/reftable.c
new file mode 100644
index 00000000000..6e7d1da10e7
--- /dev/null
+++ b/reftable/reftable.c
@@ -0,0 +1,90 @@
+/*
+Copyright 2020 Google LLC
+
+Use of this source code is governed by a BSD-style
+license that can be found in the LICENSE file or at
+https://developers.google.com/open-source/licenses/bsd
+*/
+
+#include "reftable.h"
+#include "record.h"
+#include "reader.h"
+#include "merged.h"
+
+struct reftable_table_vtable {
+	int (*seek)(void *tab, struct reftable_iterator *it,
+		    struct reftable_record *);
+};
+
+static int reftable_reader_seek_void(void *tab, struct reftable_iterator *it,
+				     struct reftable_record *rec)
+{
+	return reader_seek((struct reftable_reader *)tab, it, rec);
+}
+
+static struct reftable_table_vtable reader_vtable = {
+	.seek = reftable_reader_seek_void,
+};
+
+static int reftable_merged_table_seek_void(void *tab,
+					   struct reftable_iterator *it,
+					   struct reftable_record *rec)
+{
+	return merged_table_seek_record((struct reftable_merged_table *)tab, it,
+					rec);
+}
+
+static struct reftable_table_vtable merged_table_vtable = {
+	.seek = reftable_merged_table_seek_void,
+};
+
+int reftable_table_seek_ref(struct reftable_table *tab,
+			    struct reftable_iterator *it, const char *name)
+{
+	struct reftable_ref_record ref = {
+		.ref_name = (char *)name,
+	};
+	struct reftable_record rec = { 0 };
+	reftable_record_from_ref(&rec, &ref);
+	return tab->ops->seek(tab->table_arg, it, &rec);
+}
+
+void reftable_table_from_reader(struct reftable_table *tab,
+				struct reftable_reader *reader)
+{
+	assert(tab->ops == NULL);
+	tab->ops = &reader_vtable;
+	tab->table_arg = reader;
+}
+
+void reftable_table_from_merged_table(struct reftable_table *tab,
+				      struct reftable_merged_table *merged)
+{
+	assert(tab->ops == NULL);
+	tab->ops = &merged_table_vtable;
+	tab->table_arg = merged;
+}
+
+int reftable_table_read_ref(struct reftable_table *tab, const char *name,
+			    struct reftable_ref_record *ref)
+{
+	struct reftable_iterator it = { 0 };
+	int err = reftable_table_seek_ref(tab, &it, name);
+	if (err)
+		goto done;
+
+	err = reftable_iterator_next_ref(&it, ref);
+	if (err)
+		goto done;
+
+	if (strcmp(ref->ref_name, name) ||
+	    reftable_ref_record_is_deletion(ref)) {
+		reftable_ref_record_clear(ref);
+		err = 1;
+		goto done;
+	}
+
+done:
+	reftable_iterator_destroy(&it);
+	return err;
+}
diff --git a/reftable/reftable.h b/reftable/reftable.h
new file mode 100644
index 00000000000..86f2dcf33d4
--- /dev/null
+++ b/reftable/reftable.h
@@ -0,0 +1,564 @@
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
+#include <stdint.h>
+#include <stddef.h>
+
+void reftable_set_alloc(void *(*malloc)(size_t),
+			void *(*realloc)(void *, size_t), void (*free)(void *));
+
+/****************************************************************
+ Basic data types
+
+ Reftables store the state of each ref in struct reftable_ref_record, and they
+ store a sequence of reflog updates in struct reftable_log_record.
+ ****************************************************************/
+
+/* reftable_ref_record holds a ref database entry target_value */
+struct reftable_ref_record {
+	char *ref_name; /* Name of the ref, malloced. */
+	uint64_t update_index; /* Logical timestamp at which this value is
+				  written */
+	uint8_t *value; /* SHA1, or NULL. malloced. */
+	uint8_t *target_value; /* peeled annotated tag, or NULL. malloced. */
+	char *target; /* symref, or NULL. malloced. */
+};
+
+/* returns whether 'ref' represents a deletion */
+int reftable_ref_record_is_deletion(const struct reftable_ref_record *ref);
+
+/* prints a reftable_ref_record onto stdout */
+void reftable_ref_record_print(struct reftable_ref_record *ref,
+			       uint32_t hash_id);
+
+/* frees and nulls all pointer values. */
+void reftable_ref_record_clear(struct reftable_ref_record *ref);
+
+/* returns whether two reftable_ref_records are the same */
+int reftable_ref_record_equal(struct reftable_ref_record *a,
+			      struct reftable_ref_record *b, int hash_size);
+
+/* reftable_log_record holds a reflog entry */
+struct reftable_log_record {
+	char *ref_name;
+	uint64_t update_index; /* logical timestamp of a transactional update.
+				*/
+	uint8_t *new_hash;
+	uint8_t *old_hash;
+	char *name;
+	char *email;
+	uint64_t time;
+	int16_t tz_offset;
+	char *message;
+};
+
+/* returns whether 'ref' represents the deletion of a log record. */
+int reftable_log_record_is_deletion(const struct reftable_log_record *log);
+
+/* frees and nulls all pointer values. */
+void reftable_log_record_clear(struct reftable_log_record *log);
+
+/* returns whether two records are equal. */
+int reftable_log_record_equal(struct reftable_log_record *a,
+			      struct reftable_log_record *b, int hash_size);
+
+/* dumps a reftable_log_record on stdout, for debugging/testing. */
+void reftable_log_record_print(struct reftable_log_record *log,
+			       uint32_t hash_id);
+
+/****************************************************************
+ Error handling
+
+ Error are signaled with negative integer return values. 0 means success.
+ ****************************************************************/
+
+/* different types of errors */
+enum reftable_error {
+	/* Unexpected file system behavior */
+	REFTABLE_IO_ERROR = -2,
+
+	/* Format inconsistency on reading data
+	 */
+	REFTABLE_FORMAT_ERROR = -3,
+
+	/* File does not exist. Returned from block_source_from_file(),  because
+	   it needs special handling in stack.
+	*/
+	REFTABLE_NOT_EXIST_ERROR = -4,
+
+	/* Trying to write out-of-date data. */
+	REFTABLE_LOCK_ERROR = -5,
+
+	/* Misuse of the API:
+	   - on writing a record with NULL ref_name.
+	   - on writing a reftable_ref_record outside the table limits
+	   - on writing a ref or log record before the stack's next_update_index
+	   - on reading a reftable_ref_record from log iterator, or vice versa.
+	*/
+	REFTABLE_API_ERROR = -6,
+
+	/* Decompression error */
+	REFTABLE_ZLIB_ERROR = -7,
+
+	/* Wrote a table without blocks. */
+	REFTABLE_EMPTY_TABLE_ERROR = -8,
+
+	/* Dir/file conflict. */
+	REFTABLE_NAME_CONFLICT = -9,
+
+	/* Illegal ref name. */
+	REFTABLE_REFNAME_ERROR = -10,
+};
+
+/* convert the numeric error code to a string. The string should not be
+ * deallocated. */
+const char *reftable_error_str(int err);
+
+/*
+ * Convert the numeric error code to an equivalent errno code.
+ */
+int reftable_error_to_errno(int err);
+
+/****************************************************************
+ Writing
+
+ Writing single reftables
+ ****************************************************************/
+
+/* reftable_write_options sets options for writing a single reftable. */
+struct reftable_write_options {
+	/* boolean: do not pad out blocks to block size. */
+	int unpadded;
+
+	/* the blocksize. Should be less than 2^24. */
+	uint32_t block_size;
+
+	/* boolean: do not generate a SHA1 => ref index. */
+	int skip_index_objects;
+
+	/* how often to write complete keys in each block. */
+	int restart_interval;
+
+	/* 4-byte identifier ("sha1", "s256") of the hash.
+	 * Defaults to SHA1 if unset
+	 */
+	uint32_t hash_id;
+
+	/* boolean: do not check ref names for validity or dir/file conflicts.
+	 */
+	int skip_name_check;
+};
+
+/* reftable_block_stats holds statistics for a single block type */
+struct reftable_block_stats {
+	/* total number of entries written */
+	int entries;
+	/* total number of key restarts */
+	int restarts;
+	/* total number of blocks */
+	int blocks;
+	/* total number of index blocks */
+	int index_blocks;
+	/* depth of the index */
+	int max_index_level;
+
+	/* offset of the first block for this type */
+	uint64_t offset;
+	/* offset of the top level index block for this type, or 0 if not
+	 * present */
+	uint64_t index_offset;
+};
+
+/* stats holds overall statistics for a single reftable */
+struct reftable_stats {
+	/* total number of blocks written. */
+	int blocks;
+	/* stats for ref data */
+	struct reftable_block_stats ref_stats;
+	/* stats for the SHA1 to ref map. */
+	struct reftable_block_stats obj_stats;
+	/* stats for index blocks */
+	struct reftable_block_stats idx_stats;
+	/* stats for log blocks */
+	struct reftable_block_stats log_stats;
+
+	/* disambiguation length of shortened object IDs. */
+	int object_id_len;
+};
+
+/* reftable_new_writer creates a new writer */
+struct reftable_writer *
+reftable_new_writer(int (*writer_func)(void *, uint8_t *, size_t),
+		    void *writer_arg, struct reftable_write_options *opts);
+
+/* write to a file descriptor. fdp should be an int* pointing to the fd. */
+int reftable_fd_write(void *fdp, uint8_t *data, size_t size);
+
+/* Set the range of update indices for the records we will add.  When
+   writing a table into a stack, the min should be at least
+   reftable_stack_next_update_index(), or REFTABLE_API_ERROR is returned.
+
+   For transactional updates, typically min==max. When converting an existing
+   ref database into a single reftable, this would be a range of update-index
+   timestamps.
+ */
+void reftable_writer_set_limits(struct reftable_writer *w, uint64_t min,
+				uint64_t max);
+
+/* adds a reftable_ref_record. Must be called in ascending
+   order. The update_index must be within the limits set by
+   reftable_writer_set_limits(), or REFTABLE_API_ERROR is returned.
+
+   It is an error to write a ref record after a log record.
+ */
+int reftable_writer_add_ref(struct reftable_writer *w,
+			    struct reftable_ref_record *ref);
+
+/* Convenience function to add multiple refs. Will sort the refs by
+   name before adding. */
+int reftable_writer_add_refs(struct reftable_writer *w,
+			     struct reftable_ref_record *refs, int n);
+
+/* adds a reftable_log_record. Must be called in ascending order (with more
+   recent log entries first.)
+ */
+int reftable_writer_add_log(struct reftable_writer *w,
+			    struct reftable_log_record *log);
+
+/* Convenience function to add multiple logs. Will sort the records by
+   key before adding. */
+int reftable_writer_add_logs(struct reftable_writer *w,
+			     struct reftable_log_record *logs, int n);
+
+/* reftable_writer_close finalizes the reftable. The writer is retained so
+ * statistics can be inspected. */
+int reftable_writer_close(struct reftable_writer *w);
+
+/* writer_stats returns the statistics on the reftable being written.
+
+   This struct becomes invalid when the writer is freed.
+ */
+const struct reftable_stats *writer_stats(struct reftable_writer *w);
+
+/* reftable_writer_free deallocates memory for the writer */
+void reftable_writer_free(struct reftable_writer *w);
+
+/****************************************************************
+ * ITERATING
+ ****************************************************************/
+
+/* iterator is the generic interface for walking over data stored in a
+   reftable. It is generally passed around by value.
+*/
+struct reftable_iterator {
+	struct reftable_iterator_vtable *ops;
+	void *iter_arg;
+};
+
+/* reads the next reftable_ref_record. Returns < 0 for error, 0 for OK and > 0:
+   end of iteration.
+*/
+int reftable_iterator_next_ref(struct reftable_iterator *it,
+			       struct reftable_ref_record *ref);
+
+/* reads the next reftable_log_record. Returns < 0 for error, 0 for OK and > 0:
+   end of iteration.
+*/
+int reftable_iterator_next_log(struct reftable_iterator *it,
+			       struct reftable_log_record *log);
+
+/* releases resources associated with an iterator. */
+void reftable_iterator_destroy(struct reftable_iterator *it);
+
+/****************************************************************
+ Reading single tables
+
+ The follow routines are for reading single files. For an application-level
+ interface, skip ahead to struct reftable_merged_table and struct
+ reftable_stack.
+ ****************************************************************/
+
+/* block_source is a generic wrapper for a seekable readable file.
+   It is generally passed around by value.
+ */
+struct reftable_block_source {
+	struct reftable_block_source_vtable *ops;
+	void *arg;
+};
+
+/* a contiguous segment of bytes. It keeps track of its generating block_source
+   so it can return itself into the pool.
+*/
+struct reftable_block {
+	uint8_t *data;
+	int len;
+	struct reftable_block_source source;
+};
+
+/* block_source_vtable are the operations that make up block_source */
+struct reftable_block_source_vtable {
+	/* returns the size of a block source */
+	uint64_t (*size)(void *source);
+
+	/* reads a segment from the block source. It is an error to read
+	   beyond the end of the block */
+	int (*read_block)(void *source, struct reftable_block *dest,
+			  uint64_t off, uint32_t size);
+	/* mark the block as read; may return the data back to malloc */
+	void (*return_block)(void *source, struct reftable_block *blockp);
+
+	/* release all resources associated with the block source */
+	void (*close)(void *source);
+};
+
+/* opens a file on the file system as a block_source */
+int reftable_block_source_from_file(struct reftable_block_source *block_src,
+				    const char *name);
+
+/* The reader struct is a handle to an open reftable file. */
+struct reftable_reader;
+
+/* reftable_new_reader opens a reftable for reading. If successful, returns 0
+ * code and sets pp. The name is used for creating a stack. Typically, it is the
+ * basename of the file. The block source `src` is owned by the reader, and is
+ * closed on calling reftable_reader_destroy().
+ */
+int reftable_new_reader(struct reftable_reader **pp,
+			struct reftable_block_source *src, const char *name);
+
+/* reftable_reader_seek_ref returns an iterator where 'name' would be inserted
+   in the table.  To seek to the start of the table, use name = "".
+
+   example:
+
+   struct reftable_reader *r = NULL;
+   int err = reftable_new_reader(&r, &src, "filename");
+   if (err < 0) { ... }
+   struct reftable_iterator it  = {0};
+   err = reftable_reader_seek_ref(r, &it, "refs/heads/master");
+   if (err < 0) { ... }
+   struct reftable_ref_record ref  = {0};
+   while (1) {
+     err = reftable_iterator_next_ref(&it, &ref);
+     if (err > 0) {
+       break;
+     }
+     if (err < 0) {
+       ..error handling..
+     }
+     ..found..
+   }
+   reftable_iterator_destroy(&it);
+   reftable_ref_record_clear(&ref);
+ */
+int reftable_reader_seek_ref(struct reftable_reader *r,
+			     struct reftable_iterator *it, const char *name);
+
+/* returns the hash ID used in this table. */
+uint32_t reftable_reader_hash_id(struct reftable_reader *r);
+
+/* seek to logs for the given name, older than update_index. To seek to the
+   start of the table, use name = "".
+ */
+int reftable_reader_seek_log_at(struct reftable_reader *r,
+				struct reftable_iterator *it, const char *name,
+				uint64_t update_index);
+
+/* seek to newest log entry for given name. */
+int reftable_reader_seek_log(struct reftable_reader *r,
+			     struct reftable_iterator *it, const char *name);
+
+/* closes and deallocates a reader. */
+void reftable_reader_free(struct reftable_reader *);
+
+/* return an iterator for the refs pointing to `oid`. */
+int reftable_reader_refs_for(struct reftable_reader *r,
+			     struct reftable_iterator *it, uint8_t *oid);
+
+/* return the max_update_index for a table */
+uint64_t reftable_reader_max_update_index(struct reftable_reader *r);
+
+/* return the min_update_index for a table */
+uint64_t reftable_reader_min_update_index(struct reftable_reader *r);
+
+/****************************************************************
+ Merged tables
+
+ A ref database kept in a sequence of table files. The merged_table presents a
+ unified view to reading (seeking, iterating) a sequence of immutable tables.
+ ****************************************************************/
+
+/* A merged table is implements seeking/iterating over a stack of tables. */
+struct reftable_merged_table;
+
+/* reftable_new_merged_table creates a new merged table. It takes ownership of
+   the stack array.
+*/
+int reftable_new_merged_table(struct reftable_merged_table **dest,
+			      struct reftable_reader **stack, int n,
+			      uint32_t hash_id);
+
+/* returns an iterator positioned just before 'name' */
+int reftable_merged_table_seek_ref(struct reftable_merged_table *mt,
+				   struct reftable_iterator *it,
+				   const char *name);
+
+/* returns an iterator for log entry, at given update_index */
+int reftable_merged_table_seek_log_at(struct reftable_merged_table *mt,
+				      struct reftable_iterator *it,
+				      const char *name, uint64_t update_index);
+
+/* like reftable_merged_table_seek_log_at but look for the newest entry. */
+int reftable_merged_table_seek_log(struct reftable_merged_table *mt,
+				   struct reftable_iterator *it,
+				   const char *name);
+
+/* returns the max update_index covered by this merged table. */
+uint64_t
+reftable_merged_table_max_update_index(struct reftable_merged_table *mt);
+
+/* returns the min update_index covered by this merged table. */
+uint64_t
+reftable_merged_table_min_update_index(struct reftable_merged_table *mt);
+
+/* closes readers for the merged tables */
+void reftable_merged_table_close(struct reftable_merged_table *mt);
+
+/* releases memory for the merged_table */
+void reftable_merged_table_free(struct reftable_merged_table *m);
+
+/****************************************************************
+ Generic tables
+
+ A unified API for reading tables, either merged tables, or single readers.
+ ****************************************************************/
+
+struct reftable_table {
+	struct reftable_table_vtable *ops;
+	void *table_arg;
+};
+
+int reftable_table_seek_ref(struct reftable_table *tab,
+			    struct reftable_iterator *it, const char *name);
+
+void reftable_table_from_reader(struct reftable_table *tab,
+				struct reftable_reader *reader);
+void reftable_table_from_merged_table(struct reftable_table *tab,
+				      struct reftable_merged_table *table);
+
+/* convenience function to read a single ref. Returns < 0 for error, 0
+   for success, and 1 if ref not found. */
+int reftable_table_read_ref(struct reftable_table *tab, const char *name,
+			    struct reftable_ref_record *ref);
+
+/****************************************************************
+ Mutable ref database
+
+ The stack presents an interface to a mutable sequence of reftables.
+ ****************************************************************/
+
+/* a stack is a stack of reftables, which can be mutated by pushing a table to
+ * the top of the stack */
+struct reftable_stack;
+
+/* open a new reftable stack. The tables along with the table list will be
+   stored in 'dir'. Typically, this should be .git/reftables.
+*/
+int reftable_new_stack(struct reftable_stack **dest, const char *dir,
+		       struct reftable_write_options config);
+
+/* returns the update_index at which a next table should be written. */
+uint64_t reftable_stack_next_update_index(struct reftable_stack *st);
+
+/* holds a transaction to add tables at the top of a stack. */
+struct reftable_addition;
+
+/*
+  returns a new transaction to add reftables to the given stack. As a side
+  effect, the ref database is locked.
+*/
+int reftable_stack_new_addition(struct reftable_addition **dest,
+				struct reftable_stack *st);
+
+/* Adds a reftable to transaction. */
+int reftable_addition_add(struct reftable_addition *add,
+			  int (*write_table)(struct reftable_writer *wr,
+					     void *arg),
+			  void *arg);
+
+/* Commits the transaction, releasing the lock. */
+int reftable_addition_commit(struct reftable_addition *add);
+
+/* Release all non-committed data from the transaction, and deallocate the
+   transaction. Releases the lock if held. */
+void reftable_addition_destroy(struct reftable_addition *add);
+
+/* add a new table to the stack. The write_table function must call
+   reftable_writer_set_limits, add refs and return an error value. */
+int reftable_stack_add(struct reftable_stack *st,
+		       int (*write_table)(struct reftable_writer *wr,
+					  void *write_arg),
+		       void *write_arg);
+
+/* returns the merged_table for seeking. This table is valid until the
+   next write or reload, and should not be closed or deleted.
+*/
+struct reftable_merged_table *
+reftable_stack_merged_table(struct reftable_stack *st);
+
+/* frees all resources associated with the stack. */
+void reftable_stack_destroy(struct reftable_stack *st);
+
+/* Reloads the stack if necessary. This is very cheap to run if the stack was up
+ * to date */
+int reftable_stack_reload(struct reftable_stack *st);
+
+/* Policy for expiring reflog entries. */
+struct reftable_log_expiry_config {
+	/* Drop entries older than this timestamp */
+	uint64_t time;
+
+	/* Drop older entries */
+	uint64_t min_update_index;
+};
+
+/* compacts all reftables into a giant table. Expire reflog entries if config is
+ * non-NULL */
+int reftable_stack_compact_all(struct reftable_stack *st,
+			       struct reftable_log_expiry_config *config);
+
+/* heuristically compact unbalanced table stack. */
+int reftable_stack_auto_compact(struct reftable_stack *st);
+
+/* convenience function to read a single ref. Returns < 0 for error, 0
+   for success, and 1 if ref not found. */
+int reftable_stack_read_ref(struct reftable_stack *st, const char *refname,
+			    struct reftable_ref_record *ref);
+
+/* convenience function to read a single log. Returns < 0 for error, 0
+   for success, and 1 if ref not found. */
+int reftable_stack_read_log(struct reftable_stack *st, const char *refname,
+			    struct reftable_log_record *log);
+
+/* statistics on past compactions. */
+struct reftable_compaction_stats {
+	uint64_t bytes; /* total number of bytes written */
+	uint64_t entries_written; /* total number of entries written, including
+				     failures. */
+	int attempts; /* how often we tried to compact */
+	int failures; /* failures happen on concurrent updates */
+};
+
+/* return statistics for compaction up till now. */
+struct reftable_compaction_stats *
+reftable_stack_compaction_stats(struct reftable_stack *st);
+
+#endif
diff --git a/reftable/reftable_test.c b/reftable/reftable_test.c
new file mode 100644
index 00000000000..da0a7460a46
--- /dev/null
+++ b/reftable/reftable_test.c
@@ -0,0 +1,631 @@
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
+#include "system.h"
+
+#include "basics.h"
+#include "block.h"
+#include "constants.h"
+#include "reader.h"
+#include "record.h"
+#include "test_framework.h"
+#include "reftable-tests.h"
+
+static const int update_index = 5;
+
+static void test_buffer(void)
+{
+	struct slice buf = SLICE_INIT;
+	struct reftable_block_source source = { NULL };
+	struct reftable_block out = { 0 };
+	int n;
+	byte in[] = "hello";
+	slice_add(&buf, in, sizeof(in));
+	block_source_from_slice(&source, &buf);
+	assert(block_source_size(&source) == 6);
+	n = block_source_read_block(&source, &out, 0, sizeof(in));
+	assert(n == sizeof(in));
+	assert(!memcmp(in, out.data, n));
+	reftable_block_done(&out);
+
+	n = block_source_read_block(&source, &out, 1, 2);
+	assert(n == 2);
+	assert(!memcmp(out.data, "el", 2));
+
+	reftable_block_done(&out);
+	block_source_close(&source);
+	slice_release(&buf);
+}
+
+static void test_default_write_opts(void)
+{
+	struct reftable_write_options opts = { 0 };
+	struct slice buf = SLICE_INIT;
+	struct reftable_writer *w =
+		reftable_new_writer(&slice_add_void, &buf, &opts);
+
+	struct reftable_ref_record rec = {
+		.ref_name = "master",
+		.update_index = 1,
+	};
+	int err;
+	struct reftable_block_source source = { 0 };
+	struct reftable_reader **readers = malloc(sizeof(*readers) * 1);
+	uint32_t hash_id;
+	struct reftable_reader *rd = NULL;
+	struct reftable_merged_table *merged = NULL;
+
+	reftable_writer_set_limits(w, 1, 1);
+
+	err = reftable_writer_add_ref(w, &rec);
+	assert_err(err);
+
+	err = reftable_writer_close(w);
+	assert_err(err);
+	reftable_writer_free(w);
+
+	block_source_from_slice(&source, &buf);
+
+	err = reftable_new_reader(&rd, &source, "filename");
+	assert_err(err);
+
+	hash_id = reftable_reader_hash_id(rd);
+	assert(hash_id == SHA1_ID);
+
+	readers[0] = rd;
+
+	err = reftable_new_merged_table(&merged, readers, 1, SHA1_ID);
+	assert_err(err);
+
+	reftable_merged_table_close(merged);
+	reftable_merged_table_free(merged);
+	slice_release(&buf);
+}
+
+static void write_table(char ***names, struct slice *buf, int N, int block_size,
+			uint32_t hash_id)
+{
+	struct reftable_write_options opts = {
+		.block_size = block_size,
+		.hash_id = hash_id,
+	};
+	struct reftable_writer *w =
+		reftable_new_writer(&slice_add_void, buf, &opts);
+	struct reftable_ref_record ref = { 0 };
+	int i = 0, n;
+	struct reftable_log_record log = { 0 };
+	const struct reftable_stats *stats = NULL;
+	*names = reftable_calloc(sizeof(char *) * (N + 1));
+	reftable_writer_set_limits(w, update_index, update_index);
+	for (i = 0; i < N; i++) {
+		byte hash[SHA256_SIZE] = { 0 };
+		char name[100];
+		int n;
+
+		set_test_hash(hash, i);
+
+		snprintf(name, sizeof(name), "refs/heads/branch%02d", i);
+
+		ref.ref_name = name;
+		ref.value = hash;
+		ref.update_index = update_index;
+		(*names)[i] = xstrdup(name);
+
+		n = reftable_writer_add_ref(w, &ref);
+		assert(n == 0);
+	}
+
+	for (i = 0; i < N; i++) {
+		byte hash[SHA256_SIZE] = { 0 };
+		char name[100];
+		int n;
+
+		set_test_hash(hash, i);
+
+		snprintf(name, sizeof(name), "refs/heads/branch%02d", i);
+
+		log.ref_name = name;
+		log.new_hash = hash;
+		log.update_index = update_index;
+		log.message = "message";
+
+		n = reftable_writer_add_log(w, &log);
+		assert(n == 0);
+	}
+
+	n = reftable_writer_close(w);
+	assert(n == 0);
+
+	stats = writer_stats(w);
+	for (i = 0; i < stats->ref_stats.blocks; i++) {
+		int off = i * opts.block_size;
+		if (off == 0) {
+			off = header_size((hash_id == SHA256_ID) ? 2 : 1);
+		}
+		assert(buf->buf[off] == 'r');
+	}
+
+	assert(stats->log_stats.blocks > 0);
+	reftable_writer_free(w);
+}
+
+static void test_log_buffer_size(void)
+{
+	struct slice buf = SLICE_INIT;
+	struct reftable_write_options opts = {
+		.block_size = 4096,
+	};
+	int err;
+	struct reftable_log_record log = {
+		.ref_name = "refs/heads/master",
+		.name = "Han-Wen Nienhuys",
+		.email = "hanwen@google.com",
+		.tz_offset = 100,
+		.time = 0x5e430672,
+		.update_index = 0xa,
+		.message = "commit: 9\n",
+	};
+	struct reftable_writer *w =
+		reftable_new_writer(&slice_add_void, &buf, &opts);
+
+	/* This tests buffer extension for log compression. Must use a random
+	   hash, to ensure that the compressed part is larger than the original.
+	*/
+	byte hash1[SHA1_SIZE], hash2[SHA1_SIZE];
+	for (int i = 0; i < SHA1_SIZE; i++) {
+		hash1[i] = (byte)(rand() % 256);
+		hash2[i] = (byte)(rand() % 256);
+	}
+	log.old_hash = hash1;
+	log.new_hash = hash2;
+	reftable_writer_set_limits(w, update_index, update_index);
+	err = reftable_writer_add_log(w, &log);
+	assert_err(err);
+	err = reftable_writer_close(w);
+	assert_err(err);
+	reftable_writer_free(w);
+	slice_release(&buf);
+}
+
+static void test_log_write_read(void)
+{
+	int N = 2;
+	char **names = reftable_calloc(sizeof(char *) * (N + 1));
+	int err;
+	struct reftable_write_options opts = {
+		.block_size = 256,
+	};
+	struct reftable_ref_record ref = { 0 };
+	int i = 0;
+	struct reftable_log_record log = { 0 };
+	int n;
+	struct reftable_iterator it = { 0 };
+	struct reftable_reader rd = { 0 };
+	struct reftable_block_source source = { 0 };
+	struct slice buf = SLICE_INIT;
+	struct reftable_writer *w =
+		reftable_new_writer(&slice_add_void, &buf, &opts);
+	const struct reftable_stats *stats = NULL;
+	reftable_writer_set_limits(w, 0, N);
+	for (i = 0; i < N; i++) {
+		char name[256];
+		struct reftable_ref_record ref = { 0 };
+		snprintf(name, sizeof(name), "b%02d%0*d", i, 130, 7);
+		names[i] = xstrdup(name);
+		puts(name);
+		ref.ref_name = name;
+		ref.update_index = i;
+
+		err = reftable_writer_add_ref(w, &ref);
+		assert_err(err);
+	}
+	for (i = 0; i < N; i++) {
+		byte hash1[SHA1_SIZE], hash2[SHA1_SIZE];
+		struct reftable_log_record log = { 0 };
+		set_test_hash(hash1, i);
+		set_test_hash(hash2, i + 1);
+
+		log.ref_name = names[i];
+		log.update_index = i;
+		log.old_hash = hash1;
+		log.new_hash = hash2;
+
+		err = reftable_writer_add_log(w, &log);
+		assert_err(err);
+	}
+
+	n = reftable_writer_close(w);
+	assert(n == 0);
+
+	stats = writer_stats(w);
+	assert(stats->log_stats.blocks > 0);
+	reftable_writer_free(w);
+	w = NULL;
+
+	block_source_from_slice(&source, &buf);
+
+	err = init_reader(&rd, &source, "file.log");
+	assert_err(err);
+
+	err = reftable_reader_seek_ref(&rd, &it, names[N - 1]);
+	assert_err(err);
+
+	err = reftable_iterator_next_ref(&it, &ref);
+	assert_err(err);
+
+	/* end of iteration. */
+	err = reftable_iterator_next_ref(&it, &ref);
+	assert(0 < err);
+
+	reftable_iterator_destroy(&it);
+	reftable_ref_record_clear(&ref);
+
+	err = reftable_reader_seek_log(&rd, &it, "");
+	assert_err(err);
+
+	i = 0;
+	while (true) {
+		int err = reftable_iterator_next_log(&it, &log);
+		if (err > 0) {
+			break;
+		}
+
+		assert_err(err);
+		assert_streq(names[i], log.ref_name);
+		assert(i == log.update_index);
+		i++;
+		reftable_log_record_clear(&log);
+	}
+
+	assert(i == N);
+	reftable_iterator_destroy(&it);
+
+	/* cleanup. */
+	slice_release(&buf);
+	free_names(names);
+	reader_close(&rd);
+}
+
+static void test_table_read_write_sequential(void)
+{
+	char **names;
+	struct slice buf = SLICE_INIT;
+	int N = 50;
+	struct reftable_iterator it = { 0 };
+	struct reftable_block_source source = { 0 };
+	struct reftable_reader rd = { 0 };
+	int err = 0;
+	int j = 0;
+
+	write_table(&names, &buf, N, 256, SHA1_ID);
+
+	block_source_from_slice(&source, &buf);
+
+	err = init_reader(&rd, &source, "file.ref");
+	assert_err(err);
+
+	err = reftable_reader_seek_ref(&rd, &it, "");
+	assert_err(err);
+
+	while (true) {
+		struct reftable_ref_record ref = { 0 };
+		int r = reftable_iterator_next_ref(&it, &ref);
+		assert(r >= 0);
+		if (r > 0) {
+			break;
+		}
+		assert(0 == strcmp(names[j], ref.ref_name));
+		assert(update_index == ref.update_index);
+
+		j++;
+		reftable_ref_record_clear(&ref);
+	}
+	assert(j == N);
+	reftable_iterator_destroy(&it);
+	slice_release(&buf);
+	free_names(names);
+
+	reader_close(&rd);
+}
+
+static void test_table_write_small_table(void)
+{
+	char **names;
+	struct slice buf = SLICE_INIT;
+	int N = 1;
+	write_table(&names, &buf, N, 4096, SHA1_ID);
+	assert(buf.len < 200);
+	slice_release(&buf);
+	free_names(names);
+}
+
+static void test_table_read_api(void)
+{
+	char **names;
+	struct slice buf = SLICE_INIT;
+	int N = 50;
+	struct reftable_reader rd = { 0 };
+	struct reftable_block_source source = { 0 };
+	int err;
+	int i;
+	struct reftable_log_record log = { 0 };
+	struct reftable_iterator it = { 0 };
+
+	write_table(&names, &buf, N, 256, SHA1_ID);
+
+	block_source_from_slice(&source, &buf);
+
+	err = init_reader(&rd, &source, "file.ref");
+	assert_err(err);
+
+	err = reftable_reader_seek_ref(&rd, &it, names[0]);
+	assert_err(err);
+
+	err = reftable_iterator_next_log(&it, &log);
+	assert(err == REFTABLE_API_ERROR);
+
+	slice_release(&buf);
+	for (i = 0; i < N; i++) {
+		reftable_free(names[i]);
+	}
+	reftable_iterator_destroy(&it);
+	reftable_free(names);
+	reader_close(&rd);
+	slice_release(&buf);
+}
+
+static void test_table_read_write_seek(bool index, int hash_id)
+{
+	char **names;
+	struct slice buf = SLICE_INIT;
+	int N = 50;
+	struct reftable_reader rd = { 0 };
+	struct reftable_block_source source = { 0 };
+	int err;
+	int i = 0;
+
+	struct reftable_iterator it = { 0 };
+	struct slice pastLast = SLICE_INIT;
+	struct reftable_ref_record ref = { 0 };
+
+	write_table(&names, &buf, N, 256, hash_id);
+
+	block_source_from_slice(&source, &buf);
+
+	err = init_reader(&rd, &source, "file.ref");
+	assert_err(err);
+	assert(hash_id == reftable_reader_hash_id(&rd));
+
+	if (!index) {
+		rd.ref_offsets.index_offset = 0;
+	} else {
+		assert(rd.ref_offsets.index_offset > 0);
+	}
+
+	for (i = 1; i < N; i++) {
+		int err = reftable_reader_seek_ref(&rd, &it, names[i]);
+		assert_err(err);
+		err = reftable_iterator_next_ref(&it, &ref);
+		assert_err(err);
+		assert(0 == strcmp(names[i], ref.ref_name));
+		assert(i == ref.value[0]);
+
+		reftable_ref_record_clear(&ref);
+		reftable_iterator_destroy(&it);
+	}
+
+	slice_set_string(&pastLast, names[N - 1]);
+	slice_addstr(&pastLast, "/");
+
+	err = reftable_reader_seek_ref(&rd, &it, slice_as_string(&pastLast));
+	if (err == 0) {
+		struct reftable_ref_record ref = { 0 };
+		int err = reftable_iterator_next_ref(&it, &ref);
+		assert(err > 0);
+	} else {
+		assert(err > 0);
+	}
+
+	slice_release(&pastLast);
+	reftable_iterator_destroy(&it);
+
+	slice_release(&buf);
+	for (i = 0; i < N; i++) {
+		reftable_free(names[i]);
+	}
+	reftable_free(names);
+	reader_close(&rd);
+}
+
+static void test_table_read_write_seek_linear(void)
+{
+	test_table_read_write_seek(false, SHA1_ID);
+}
+
+static void test_table_read_write_seek_linear_sha256(void)
+{
+	test_table_read_write_seek(false, SHA256_ID);
+}
+
+static void test_table_read_write_seek_index(void)
+{
+	test_table_read_write_seek(true, SHA1_ID);
+}
+
+static void test_table_refs_for(bool indexed)
+{
+	int N = 50;
+	char **want_names = reftable_calloc(sizeof(char *) * (N + 1));
+	int want_names_len = 0;
+	byte want_hash[SHA1_SIZE];
+
+	struct reftable_write_options opts = {
+		.block_size = 256,
+	};
+	struct reftable_ref_record ref = { 0 };
+	int i = 0;
+	int n;
+	int err;
+	struct reftable_reader rd;
+	struct reftable_block_source source = { 0 };
+
+	struct slice buf = SLICE_INIT;
+	struct reftable_writer *w =
+		reftable_new_writer(&slice_add_void, &buf, &opts);
+
+	struct reftable_iterator it = { 0 };
+	int j;
+
+	set_test_hash(want_hash, 4);
+
+	for (i = 0; i < N; i++) {
+		byte hash[SHA1_SIZE];
+		char fill[51] = { 0 };
+		char name[100];
+		byte hash1[SHA1_SIZE];
+		byte hash2[SHA1_SIZE];
+		struct reftable_ref_record ref = { 0 };
+
+		memset(hash, i, sizeof(hash));
+		memset(fill, 'x', 50);
+		/* Put the variable part in the start */
+		snprintf(name, sizeof(name), "br%02d%s", i, fill);
+		name[40] = 0;
+		ref.ref_name = name;
+
+		set_test_hash(hash1, i / 4);
+		set_test_hash(hash2, 3 + i / 4);
+		ref.value = hash1;
+		ref.target_value = hash2;
+
+		/* 80 bytes / entry, so 3 entries per block. Yields 17
+		 */
+		/* blocks. */
+		n = reftable_writer_add_ref(w, &ref);
+		assert(n == 0);
+
+		if (!memcmp(hash1, want_hash, SHA1_SIZE) ||
+		    !memcmp(hash2, want_hash, SHA1_SIZE)) {
+			want_names[want_names_len++] = xstrdup(name);
+		}
+	}
+
+	n = reftable_writer_close(w);
+	assert(n == 0);
+
+	reftable_writer_free(w);
+	w = NULL;
+
+	block_source_from_slice(&source, &buf);
+
+	err = init_reader(&rd, &source, "file.ref");
+	assert_err(err);
+	if (!indexed) {
+		rd.obj_offsets.present = 0;
+	}
+
+	err = reftable_reader_seek_ref(&rd, &it, "");
+	assert_err(err);
+	reftable_iterator_destroy(&it);
+
+	err = reftable_reader_refs_for(&rd, &it, want_hash);
+	assert_err(err);
+
+	j = 0;
+	while (true) {
+		int err = reftable_iterator_next_ref(&it, &ref);
+		assert(err >= 0);
+		if (err > 0) {
+			break;
+		}
+
+		assert(j < want_names_len);
+		assert(0 == strcmp(ref.ref_name, want_names[j]));
+		j++;
+		reftable_ref_record_clear(&ref);
+	}
+	assert(j == want_names_len);
+
+	slice_release(&buf);
+	free_names(want_names);
+	reftable_iterator_destroy(&it);
+	reader_close(&rd);
+}
+
+static void test_table_refs_for_no_index(void)
+{
+	test_table_refs_for(false);
+}
+
+static void test_table_refs_for_obj_index(void)
+{
+	test_table_refs_for(true);
+}
+
+static void test_table_empty(void)
+{
+	struct reftable_write_options opts = { 0 };
+	struct slice buf = SLICE_INIT;
+	struct reftable_writer *w =
+		reftable_new_writer(&slice_add_void, &buf, &opts);
+	struct reftable_block_source source = { 0 };
+	struct reftable_reader *rd = NULL;
+	struct reftable_ref_record rec = { 0 };
+	struct reftable_iterator it = { 0 };
+	int err;
+
+	reftable_writer_set_limits(w, 1, 1);
+
+	err = reftable_writer_close(w);
+	assert(err == REFTABLE_EMPTY_TABLE_ERROR);
+	reftable_writer_free(w);
+
+	assert(buf.len == header_size(1) + footer_size(1));
+
+	block_source_from_slice(&source, &buf);
+
+	err = reftable_new_reader(&rd, &source, "filename");
+	assert_err(err);
+
+	err = reftable_reader_seek_ref(rd, &it, "");
+	assert_err(err);
+
+	err = reftable_iterator_next_ref(&it, &rec);
+	assert(err > 0);
+
+	reftable_iterator_destroy(&it);
+	reftable_reader_free(rd);
+	slice_release(&buf);
+}
+
+int reftable_test_main(int argc, const char *argv[])
+{
+	add_test_case("test_default_write_opts", test_default_write_opts);
+	add_test_case("test_log_write_read", test_log_write_read);
+	add_test_case("test_table_read_write_seek_linear_sha256",
+		      &test_table_read_write_seek_linear_sha256);
+	add_test_case("test_log_buffer_size", test_log_buffer_size);
+	add_test_case("test_table_write_small_table",
+		      &test_table_write_small_table);
+	add_test_case("test_buffer", &test_buffer);
+	add_test_case("test_table_read_api", &test_table_read_api);
+	add_test_case("test_table_read_write_sequential",
+		      &test_table_read_write_sequential);
+	add_test_case("test_table_read_write_seek_linear",
+		      &test_table_read_write_seek_linear);
+	add_test_case("test_table_read_write_seek_index",
+		      &test_table_read_write_seek_index);
+	add_test_case("test_table_read_write_refs_for_no_index",
+		      &test_table_refs_for_no_index);
+	add_test_case("test_table_read_write_refs_for_obj_index",
+		      &test_table_refs_for_obj_index);
+	add_test_case("test_table_empty", &test_table_empty);
+	return test_main(argc, argv);
+}
diff --git a/reftable/slice.c b/reftable/slice.c
new file mode 100644
index 00000000000..c491a8575e5
--- /dev/null
+++ b/reftable/slice.c
@@ -0,0 +1,243 @@
+/*
+Copyright 2020 Google LLC
+
+Use of this source code is governed by a BSD-style
+license that can be found in the LICENSE file or at
+https://developers.google.com/open-source/licenses/bsd
+*/
+
+#include "slice.h"
+
+#include "system.h"
+
+#include "reftable.h"
+
+struct slice reftable_empty_slice = SLICE_INIT;
+
+void slice_set_string(struct slice *s, const char *str)
+{
+	int l;
+	if (str == NULL) {
+		s->len = 0;
+		return;
+	}
+	assert(s->canary == SLICE_CANARY);
+
+	l = strlen(str);
+	l++; /* \0 */
+	slice_resize(s, l);
+	memcpy(s->buf, str, l);
+	s->len = l - 1;
+}
+
+void slice_init(struct slice *s)
+{
+	struct slice empty = SLICE_INIT;
+	*s = empty;
+}
+
+void slice_resize(struct slice *s, int l)
+{
+	assert(s->canary == SLICE_CANARY);
+	if (s->cap < l) {
+		int c = s->cap * 2;
+		if (c < l) {
+			c = l;
+		}
+		s->cap = c;
+		s->buf = reftable_realloc(s->buf, s->cap);
+	}
+	s->len = l;
+}
+
+void slice_addstr(struct slice *d, const char *s)
+{
+	int l1 = d->len;
+	int l2 = strlen(s);
+	assert(d->canary == SLICE_CANARY);
+
+	slice_resize(d, l2 + l1);
+	memcpy(d->buf + l1, s, l2);
+}
+
+void slice_addbuf(struct slice *s, struct slice *a)
+{
+	int end = s->len;
+	assert(s->canary == SLICE_CANARY);
+	slice_resize(s, s->len + a->len);
+	memcpy(s->buf + end, a->buf, a->len);
+}
+
+void slice_consume(struct slice *s, int n)
+{
+	assert(s->canary == SLICE_CANARY);
+	s->buf += n;
+	s->len -= n;
+}
+
+byte *slice_detach(struct slice *s)
+{
+	byte *p = s->buf;
+	assert(s->canary == SLICE_CANARY);
+	s->buf = NULL;
+	s->cap = 0;
+	s->len = 0;
+	return p;
+}
+
+void slice_release(struct slice *s)
+{
+	assert(s->canary == SLICE_CANARY);
+	reftable_free(slice_detach(s));
+}
+
+void slice_copy(struct slice *dest, struct slice *src)
+{
+	assert(dest->canary == SLICE_CANARY);
+	assert(src->canary == SLICE_CANARY);
+	slice_resize(dest, src->len);
+	memcpy(dest->buf, src->buf, src->len);
+}
+
+/* return the underlying data as char*. len is left unchanged, but
+   a \0 is added at the end. */
+const char *slice_as_string(struct slice *s)
+{
+	assert(s->canary == SLICE_CANARY);
+	if (s->cap == s->len) {
+		int l = s->len;
+		slice_resize(s, l + 1);
+		s->len = l;
+	}
+	s->buf[s->len] = 0;
+	return (const char *)s->buf;
+}
+
+/* return a newly malloced string for this slice */
+char *slice_to_string(struct slice *in)
+{
+	struct slice s = SLICE_INIT;
+	assert(in->canary == SLICE_CANARY);
+	slice_resize(&s, in->len + 1);
+	s.buf[in->len] = 0;
+	memcpy(s.buf, in->buf, in->len);
+	return (char *)slice_detach(&s);
+}
+
+bool slice_equal(struct slice *a, struct slice *b)
+{
+	return slice_cmp(a, b) == 0;
+}
+
+int slice_cmp(const struct slice *a, const struct slice *b)
+{
+	int min = a->len < b->len ? a->len : b->len;
+	int res = memcmp(a->buf, b->buf, min);
+	assert(a->canary == SLICE_CANARY);
+	assert(b->canary == SLICE_CANARY);
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
+int slice_add(struct slice *b, byte *data, size_t sz)
+{
+	assert(b->canary == SLICE_CANARY);
+	if (b->len + sz > b->cap) {
+		int newcap = 2 * b->cap + 1;
+		if (newcap < b->len + sz) {
+			newcap = (b->len + sz);
+		}
+		b->buf = reftable_realloc(b->buf, newcap);
+		b->cap = newcap;
+	}
+
+	memcpy(b->buf + b->len, data, sz);
+	b->len += sz;
+	return sz;
+}
+
+int slice_add_void(void *b, byte *data, size_t sz)
+{
+	return slice_add((struct slice *)b, data, sz);
+}
+
+static uint64_t slice_size(void *b)
+{
+	return ((struct slice *)b)->len;
+}
+
+static void slice_return_block(void *b, struct reftable_block *dest)
+{
+	memset(dest->data, 0xff, dest->len);
+	reftable_free(dest->data);
+}
+
+static void slice_close(void *b)
+{
+}
+
+static int slice_read_block(void *v, struct reftable_block *dest, uint64_t off,
+			    uint32_t size)
+{
+	struct slice *b = (struct slice *)v;
+	assert(off + size <= b->len);
+	dest->data = reftable_calloc(size);
+	memcpy(dest->data, b->buf + off, size);
+	dest->len = size;
+	return size;
+}
+
+struct reftable_block_source_vtable slice_vtable = {
+	.size = &slice_size,
+	.read_block = &slice_read_block,
+	.return_block = &slice_return_block,
+	.close = &slice_close,
+};
+
+void block_source_from_slice(struct reftable_block_source *bs,
+			     struct slice *buf)
+{
+	assert(bs->ops == NULL);
+	bs->ops = &slice_vtable;
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
+int common_prefix_size(struct slice *a, struct slice *b)
+{
+	int p = 0;
+	assert(a->canary == SLICE_CANARY);
+	assert(b->canary == SLICE_CANARY);
+	while (p < a->len && p < b->len) {
+		if (a->buf[p] != b->buf[p]) {
+			break;
+		}
+		p++;
+	}
+
+	return p;
+}
diff --git a/reftable/slice.h b/reftable/slice.h
new file mode 100644
index 00000000000..1a2bde3fc69
--- /dev/null
+++ b/reftable/slice.h
@@ -0,0 +1,87 @@
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
+#include "basics.h"
+#include "reftable.h"
+
+/*
+  provides bounds-checked byte ranges.
+  To use, initialize as "slice x = {0};"
+ */
+struct slice {
+	int len;
+	int cap;
+	byte *buf;
+	byte canary;
+};
+#define SLICE_CANARY 0x42
+#define SLICE_INIT                       \
+	{                                \
+		0, 0, NULL, SLICE_CANARY \
+	}
+extern struct slice reftable_empty_slice;
+
+void slice_set_string(struct slice *dest, const char *src);
+void slice_addstr(struct slice *dest, const char *src);
+
+/* Deallocate and clear slice */
+void slice_release(struct slice *slice);
+
+/* Return a malloced string for `src` */
+char *slice_to_string(struct slice *src);
+
+/* Initializes a slice. Accepts a slice with random garbage. */
+void slice_init(struct slice *slice);
+
+/* Ensure that `buf` is \0 terminated. */
+const char *slice_as_string(struct slice *src);
+
+/* Compare slices */
+bool slice_equal(struct slice *a, struct slice *b);
+
+/* Return `buf`, clearing out `s` */
+byte *slice_detach(struct slice *s);
+
+/* Copy bytes */
+void slice_copy(struct slice *dest, struct slice *src);
+
+/* Advance `buf` by `n`, and decrease length. A copy of the slice
+   should be kept for deallocating the slice. */
+void slice_consume(struct slice *s, int n);
+
+/* Set length of the slice to `l` */
+void slice_resize(struct slice *s, int l);
+
+/* Signed comparison */
+int slice_cmp(const struct slice *a, const struct slice *b);
+
+/* Append `data` to the `dest` slice.  */
+int slice_add(struct slice *dest, byte *data, size_t sz);
+
+/* Append `add` to `dest. */
+void slice_addbuf(struct slice *dest, struct slice *add);
+
+/* Like slice_add, but suitable for passing to reftable_new_writer
+ */
+int slice_add_void(void *b, byte *data, size_t sz);
+
+/* Find the longest shared prefix size of `a` and `b` */
+int common_prefix_size(struct slice *a, struct slice *b);
+
+struct reftable_block_source;
+
+/* Create an in-memory block source for reading reftables */
+void block_source_from_slice(struct reftable_block_source *bs,
+			     struct slice *buf);
+
+struct reftable_block_source malloc_block_source(void);
+
+#endif
diff --git a/reftable/slice_test.c b/reftable/slice_test.c
new file mode 100644
index 00000000000..f95790c7643
--- /dev/null
+++ b/reftable/slice_test.c
@@ -0,0 +1,40 @@
+/*
+Copyright 2020 Google LLC
+
+Use of this source code is governed by a BSD-style
+license that can be found in the LICENSE file or at
+https://developers.google.com/open-source/licenses/bsd
+*/
+
+#include "slice.h"
+
+#include "system.h"
+
+#include "basics.h"
+#include "record.h"
+#include "reftable.h"
+#include "test_framework.h"
+#include "reftable-tests.h"
+
+static void test_slice(void)
+{
+	struct slice s = SLICE_INIT;
+	struct slice t = SLICE_INIT;
+
+	slice_set_string(&s, "abc");
+	assert(0 == strcmp("abc", slice_as_string(&s)));
+
+	slice_set_string(&t, "pqr");
+
+	slice_addbuf(&s, &t);
+	assert(0 == strcmp("abcpqr", slice_as_string(&s)));
+
+	slice_release(&s);
+	slice_release(&t);
+}
+
+int slice_test_main(int argc, const char *argv[])
+{
+	add_test_case("test_slice", &test_slice);
+	return test_main(argc, argv);
+}
diff --git a/reftable/stack.c b/reftable/stack.c
new file mode 100644
index 00000000000..4c0ea0556ab
--- /dev/null
+++ b/reftable/stack.c
@@ -0,0 +1,1207 @@
+/*
+Copyright 2020 Google LLC
+
+Use of this source code is governed by a BSD-style
+license that can be found in the LICENSE file or at
+https://developers.google.com/open-source/licenses/bsd
+*/
+
+#include "stack.h"
+
+#include "system.h"
+#include "merged.h"
+#include "reader.h"
+#include "refname.h"
+#include "reftable.h"
+#include "writer.h"
+
+int reftable_new_stack(struct reftable_stack **dest, const char *dir,
+		       struct reftable_write_options config)
+{
+	struct reftable_stack *p =
+		reftable_calloc(sizeof(struct reftable_stack));
+	struct slice list_file_name = SLICE_INIT;
+	int err = 0;
+
+	if (config.hash_id == 0) {
+		config.hash_id = SHA1_ID;
+	}
+
+	*dest = NULL;
+
+	slice_set_string(&list_file_name, dir);
+	slice_addstr(&list_file_name, "/tables.list");
+
+	p->list_file = slice_to_string(&list_file_name);
+	slice_release(&list_file_name);
+	p->reftable_dir = xstrdup(dir);
+	p->config = config;
+
+	err = reftable_stack_reload_maybe_reuse(p, true);
+	if (err < 0) {
+		reftable_stack_destroy(p);
+	} else {
+		*dest = p;
+	}
+	return err;
+}
+
+static int fd_read_lines(int fd, char ***namesp)
+{
+	off_t size = lseek(fd, 0, SEEK_END);
+	char *buf = NULL;
+	int err = 0;
+	if (size < 0) {
+		err = REFTABLE_IO_ERROR;
+		goto done;
+	}
+	err = lseek(fd, 0, SEEK_SET);
+	if (err < 0) {
+		err = REFTABLE_IO_ERROR;
+		goto done;
+	}
+
+	buf = reftable_malloc(size + 1);
+	if (read(fd, buf, size) != size) {
+		err = REFTABLE_IO_ERROR;
+		goto done;
+	}
+	buf[size] = 0;
+
+	parse_names(buf, size, namesp);
+
+done:
+	reftable_free(buf);
+	return err;
+}
+
+int read_lines(const char *filename, char ***namesp)
+{
+	int fd = open(filename, O_RDONLY, 0644);
+	int err = 0;
+	if (fd < 0) {
+		if (errno == ENOENT) {
+			*namesp = reftable_calloc(sizeof(char *));
+			return 0;
+		}
+
+		return REFTABLE_IO_ERROR;
+	}
+	err = fd_read_lines(fd, namesp);
+	close(fd);
+	return err;
+}
+
+struct reftable_merged_table *
+reftable_stack_merged_table(struct reftable_stack *st)
+{
+	return st->merged;
+}
+
+/* Close and free the stack */
+void reftable_stack_destroy(struct reftable_stack *st)
+{
+	if (st->merged != NULL) {
+		reftable_merged_table_close(st->merged);
+		reftable_merged_table_free(st->merged);
+		st->merged = NULL;
+	}
+	FREE_AND_NULL(st->list_file);
+	FREE_AND_NULL(st->reftable_dir);
+	reftable_free(st);
+}
+
+static struct reftable_reader **stack_copy_readers(struct reftable_stack *st,
+						   int cur_len)
+{
+	struct reftable_reader **cur =
+		reftable_calloc(sizeof(struct reftable_reader *) * cur_len);
+	int i = 0;
+	for (i = 0; i < cur_len; i++) {
+		cur[i] = st->merged->stack[i];
+	}
+	return cur;
+}
+
+static int reftable_stack_reload_once(struct reftable_stack *st, char **names,
+				      bool reuse_open)
+{
+	int cur_len = st->merged == NULL ? 0 : st->merged->stack_len;
+	struct reftable_reader **cur = stack_copy_readers(st, cur_len);
+	int err = 0;
+	int names_len = names_length(names);
+	struct reftable_reader **new_tables =
+		reftable_malloc(sizeof(struct reftable_reader *) * names_len);
+	int new_tables_len = 0;
+	struct reftable_merged_table *new_merged = NULL;
+	int i;
+	struct slice table_path = SLICE_INIT;
+
+	while (*names) {
+		struct reftable_reader *rd = NULL;
+		char *name = *names++;
+
+		/* this is linear; we assume compaction keeps the number of
+		   tables under control so this is not quadratic. */
+		int j = 0;
+		for (j = 0; reuse_open && j < cur_len; j++) {
+			if (cur[j] != NULL && 0 == strcmp(cur[j]->name, name)) {
+				rd = cur[j];
+				cur[j] = NULL;
+				break;
+			}
+		}
+
+		if (rd == NULL) {
+			struct reftable_block_source src = { 0 };
+			slice_set_string(&table_path, st->reftable_dir);
+			slice_addstr(&table_path, "/");
+			slice_addstr(&table_path, name);
+
+			err = reftable_block_source_from_file(
+				&src, slice_as_string(&table_path));
+			if (err < 0)
+				goto done;
+
+			err = reftable_new_reader(&rd, &src, name);
+			if (err < 0)
+				goto done;
+		}
+
+		new_tables[new_tables_len++] = rd;
+	}
+
+	/* success! */
+	err = reftable_new_merged_table(&new_merged, new_tables, new_tables_len,
+					st->config.hash_id);
+	if (err < 0)
+		goto done;
+
+	new_tables = NULL;
+	new_tables_len = 0;
+	if (st->merged != NULL) {
+		merged_table_clear(st->merged);
+		reftable_merged_table_free(st->merged);
+	}
+	new_merged->suppress_deletions = true;
+	st->merged = new_merged;
+
+	for (i = 0; i < cur_len; i++) {
+		if (cur[i] != NULL) {
+			reader_close(cur[i]);
+			reftable_reader_free(cur[i]);
+		}
+	}
+
+done:
+	slice_release(&table_path);
+	for (i = 0; i < new_tables_len; i++) {
+		reader_close(new_tables[i]);
+		reftable_reader_free(new_tables[i]);
+	}
+	reftable_free(new_tables);
+	reftable_free(cur);
+	return err;
+}
+
+/* return negative if a before b. */
+static int tv_cmp(struct timeval *a, struct timeval *b)
+{
+	time_t diff = a->tv_sec - b->tv_sec;
+	int udiff = a->tv_usec - b->tv_usec;
+
+	if (diff != 0)
+		return diff;
+
+	return udiff;
+}
+
+int reftable_stack_reload_maybe_reuse(struct reftable_stack *st,
+				      bool reuse_open)
+{
+	struct timeval deadline = { 0 };
+	int err = gettimeofday(&deadline, NULL);
+	int64_t delay = 0;
+	int tries = 0;
+	if (err < 0)
+		return err;
+
+	deadline.tv_sec += 3;
+	while (true) {
+		char **names = NULL;
+		char **names_after = NULL;
+		struct timeval now = { 0 };
+		int err = gettimeofday(&now, NULL);
+		int err2 = 0;
+		if (err < 0) {
+			return err;
+		}
+
+		/* Only look at deadlines after the first few times. This
+		   simplifies debugging in GDB */
+		tries++;
+		if (tries > 3 && tv_cmp(&now, &deadline) >= 0) {
+			break;
+		}
+
+		err = read_lines(st->list_file, &names);
+		if (err < 0) {
+			free_names(names);
+			return err;
+		}
+		err = reftable_stack_reload_once(st, names, reuse_open);
+		if (err == 0) {
+			free_names(names);
+			break;
+		}
+		if (err != REFTABLE_NOT_EXIST_ERROR) {
+			free_names(names);
+			return err;
+		}
+
+		/* err == REFTABLE_NOT_EXIST_ERROR can be caused by a concurrent
+		   writer. Check if there was one by checking if the name list
+		   changed.
+		*/
+		err2 = read_lines(st->list_file, &names_after);
+		if (err2 < 0) {
+			free_names(names);
+			return err2;
+		}
+
+		if (names_equal(names_after, names)) {
+			free_names(names);
+			free_names(names_after);
+			return err;
+		}
+		free_names(names);
+		free_names(names_after);
+
+		delay = delay + (delay * rand()) / RAND_MAX + 1;
+		sleep_millisec(delay);
+	}
+
+	return 0;
+}
+
+/* -1 = error
+ 0 = up to date
+ 1 = changed. */
+static int stack_uptodate(struct reftable_stack *st)
+{
+	char **names = NULL;
+	int err = read_lines(st->list_file, &names);
+	int i = 0;
+	if (err < 0)
+		return err;
+
+	for (i = 0; i < st->merged->stack_len; i++) {
+		if (names[i] == NULL) {
+			err = 1;
+			goto done;
+		}
+
+		if (strcmp(st->merged->stack[i]->name, names[i])) {
+			err = 1;
+			goto done;
+		}
+	}
+
+	if (names[st->merged->stack_len] != NULL) {
+		err = 1;
+		goto done;
+	}
+
+done:
+	free_names(names);
+	return err;
+}
+
+int reftable_stack_reload(struct reftable_stack *st)
+{
+	int err = stack_uptodate(st);
+	if (err > 0)
+		return reftable_stack_reload_maybe_reuse(st, true);
+	return err;
+}
+
+int reftable_stack_add(struct reftable_stack *st,
+		       int (*write)(struct reftable_writer *wr, void *arg),
+		       void *arg)
+{
+	int err = stack_try_add(st, write, arg);
+	if (err < 0) {
+		if (err == REFTABLE_LOCK_ERROR) {
+			/* Ignore error return, we want to propagate
+			   REFTABLE_LOCK_ERROR.
+			*/
+			reftable_stack_reload(st);
+		}
+		return err;
+	}
+
+	if (!st->disable_auto_compact)
+		return reftable_stack_auto_compact(st);
+
+	return 0;
+}
+
+static void format_name(struct slice *dest, uint64_t min, uint64_t max)
+{
+	char buf[100];
+	snprintf(buf, sizeof(buf), "0x%012" PRIx64 "-0x%012" PRIx64, min, max);
+	slice_set_string(dest, buf);
+}
+
+struct reftable_addition {
+	int lock_file_fd;
+	struct slice lock_file_name;
+	struct reftable_stack *stack;
+	char **names;
+	char **new_tables;
+	int new_tables_len;
+	uint64_t next_update_index;
+};
+
+#define REFTABLE_ADDITION_INIT               \
+	{                                    \
+		.lock_file_name = SLICE_INIT \
+	}
+
+static int reftable_stack_init_addition(struct reftable_addition *add,
+					struct reftable_stack *st)
+{
+	int err = 0;
+	add->stack = st;
+
+	slice_set_string(&add->lock_file_name, st->list_file);
+	slice_addstr(&add->lock_file_name, ".lock");
+
+	add->lock_file_fd = open(slice_as_string(&add->lock_file_name),
+				 O_EXCL | O_CREAT | O_WRONLY, 0644);
+	if (add->lock_file_fd < 0) {
+		if (errno == EEXIST) {
+			err = REFTABLE_LOCK_ERROR;
+		} else {
+			err = REFTABLE_IO_ERROR;
+		}
+		goto done;
+	}
+	err = stack_uptodate(st);
+	if (err < 0)
+		goto done;
+
+	if (err > 1) {
+		err = REFTABLE_LOCK_ERROR;
+		goto done;
+	}
+
+	add->next_update_index = reftable_stack_next_update_index(st);
+done:
+	if (err) {
+		reftable_addition_close(add);
+	}
+	return err;
+}
+
+void reftable_addition_close(struct reftable_addition *add)
+{
+	int i = 0;
+	struct slice nm = SLICE_INIT;
+	for (i = 0; i < add->new_tables_len; i++) {
+		slice_set_string(&nm, add->stack->list_file);
+		slice_addstr(&nm, "/");
+		slice_addstr(&nm, add->new_tables[i]);
+		unlink(slice_as_string(&nm));
+		reftable_free(add->new_tables[i]);
+		add->new_tables[i] = NULL;
+	}
+	reftable_free(add->new_tables);
+	add->new_tables = NULL;
+	add->new_tables_len = 0;
+
+	if (add->lock_file_fd > 0) {
+		close(add->lock_file_fd);
+		add->lock_file_fd = 0;
+	}
+	if (add->lock_file_name.len > 0) {
+		unlink(slice_as_string(&add->lock_file_name));
+		slice_release(&add->lock_file_name);
+	}
+
+	free_names(add->names);
+	add->names = NULL;
+	slice_release(&nm);
+}
+
+void reftable_addition_destroy(struct reftable_addition *add)
+{
+	if (add == NULL) {
+		return;
+	}
+	reftable_addition_close(add);
+	reftable_free(add);
+}
+
+int reftable_addition_commit(struct reftable_addition *add)
+{
+	struct slice table_list = SLICE_INIT;
+	int i = 0;
+	int err = 0;
+	if (add->new_tables_len == 0)
+		goto done;
+
+	for (i = 0; i < add->stack->merged->stack_len; i++) {
+		slice_addstr(&table_list, add->stack->merged->stack[i]->name);
+		slice_addstr(&table_list, "\n");
+	}
+	for (i = 0; i < add->new_tables_len; i++) {
+		slice_addstr(&table_list, add->new_tables[i]);
+		slice_addstr(&table_list, "\n");
+	}
+
+	err = write(add->lock_file_fd, table_list.buf, table_list.len);
+	slice_release(&table_list);
+	if (err < 0) {
+		err = REFTABLE_IO_ERROR;
+		goto done;
+	}
+
+	err = close(add->lock_file_fd);
+	add->lock_file_fd = 0;
+	if (err < 0) {
+		err = REFTABLE_IO_ERROR;
+		goto done;
+	}
+
+	err = rename(slice_as_string(&add->lock_file_name),
+		     add->stack->list_file);
+	if (err < 0) {
+		err = REFTABLE_IO_ERROR;
+		goto done;
+	}
+
+	err = reftable_stack_reload(add->stack);
+
+done:
+	reftable_addition_close(add);
+	return err;
+}
+
+int reftable_stack_new_addition(struct reftable_addition **dest,
+				struct reftable_stack *st)
+{
+	int err = 0;
+	struct reftable_addition empty = REFTABLE_ADDITION_INIT;
+	*dest = reftable_calloc(sizeof(**dest));
+	**dest = empty;
+	err = reftable_stack_init_addition(*dest, st);
+	if (err) {
+		reftable_free(*dest);
+		*dest = NULL;
+	}
+	return err;
+}
+
+int stack_try_add(struct reftable_stack *st,
+		  int (*write_table)(struct reftable_writer *wr, void *arg),
+		  void *arg)
+{
+	struct reftable_addition add = REFTABLE_ADDITION_INIT;
+	int err = reftable_stack_init_addition(&add, st);
+	if (err < 0)
+		goto done;
+	if (err > 0) {
+		err = REFTABLE_LOCK_ERROR;
+		goto done;
+	}
+
+	err = reftable_addition_add(&add, write_table, arg);
+	if (err < 0)
+		goto done;
+
+	err = reftable_addition_commit(&add);
+done:
+	reftable_addition_close(&add);
+	return err;
+}
+
+int reftable_addition_add(struct reftable_addition *add,
+			  int (*write_table)(struct reftable_writer *wr,
+					     void *arg),
+			  void *arg)
+{
+	struct slice temp_tab_file_name = SLICE_INIT;
+	struct slice tab_file_name = SLICE_INIT;
+	struct slice next_name = SLICE_INIT;
+	struct reftable_writer *wr = NULL;
+	int err = 0;
+	int tab_fd = 0;
+
+	slice_resize(&next_name, 0);
+	format_name(&next_name, add->next_update_index, add->next_update_index);
+
+	slice_set_string(&temp_tab_file_name, add->stack->reftable_dir);
+	slice_addstr(&temp_tab_file_name, "/");
+	slice_addbuf(&temp_tab_file_name, &next_name);
+	slice_addstr(&temp_tab_file_name, ".temp.XXXXXX");
+
+	tab_fd = mkstemp((char *)slice_as_string(&temp_tab_file_name));
+	if (tab_fd < 0) {
+		err = REFTABLE_IO_ERROR;
+		goto done;
+	}
+
+	wr = reftable_new_writer(reftable_fd_write, &tab_fd,
+				 &add->stack->config);
+	err = write_table(wr, arg);
+	if (err < 0)
+		goto done;
+
+	err = reftable_writer_close(wr);
+	if (err == REFTABLE_EMPTY_TABLE_ERROR) {
+		err = 0;
+		goto done;
+	}
+	if (err < 0)
+		goto done;
+
+	err = close(tab_fd);
+	tab_fd = 0;
+	if (err < 0) {
+		err = REFTABLE_IO_ERROR;
+		goto done;
+	}
+
+	err = stack_check_addition(add->stack,
+				   slice_as_string(&temp_tab_file_name));
+	if (err < 0)
+		goto done;
+
+	if (wr->min_update_index < add->next_update_index) {
+		err = REFTABLE_API_ERROR;
+		goto done;
+	}
+
+	format_name(&next_name, wr->min_update_index, wr->max_update_index);
+	slice_addstr(&next_name, ".ref");
+
+	slice_set_string(&tab_file_name, add->stack->reftable_dir);
+	slice_addstr(&tab_file_name, "/");
+	slice_addbuf(&tab_file_name, &next_name);
+
+	/* TODO: should check destination out of paranoia */
+	err = rename(slice_as_string(&temp_tab_file_name),
+		     slice_as_string(&tab_file_name));
+	if (err < 0) {
+		err = REFTABLE_IO_ERROR;
+		goto done;
+	}
+
+	add->new_tables = reftable_realloc(add->new_tables,
+					   sizeof(*add->new_tables) *
+						   (add->new_tables_len + 1));
+	add->new_tables[add->new_tables_len] = slice_to_string(&next_name);
+	add->new_tables_len++;
+done:
+	if (tab_fd > 0) {
+		close(tab_fd);
+		tab_fd = 0;
+	}
+	if (temp_tab_file_name.len > 0) {
+		unlink(slice_as_string(&temp_tab_file_name));
+	}
+
+	slice_release(&temp_tab_file_name);
+	slice_release(&tab_file_name);
+	slice_release(&next_name);
+	reftable_writer_free(wr);
+	return err;
+}
+
+uint64_t reftable_stack_next_update_index(struct reftable_stack *st)
+{
+	int sz = st->merged->stack_len;
+	if (sz > 0)
+		return reftable_reader_max_update_index(
+			       st->merged->stack[sz - 1]) +
+		       1;
+	return 1;
+}
+
+static int stack_compact_locked(struct reftable_stack *st, int first, int last,
+				struct slice *temp_tab,
+				struct reftable_log_expiry_config *config)
+{
+	struct slice next_name = SLICE_INIT;
+	int tab_fd = -1;
+	struct reftable_writer *wr = NULL;
+	int err = 0;
+
+	format_name(&next_name,
+		    reftable_reader_min_update_index(st->merged->stack[first]),
+		    reftable_reader_max_update_index(st->merged->stack[first]));
+
+	slice_set_string(temp_tab, st->reftable_dir);
+	slice_addstr(temp_tab, "/");
+	slice_addbuf(temp_tab, &next_name);
+	slice_addstr(temp_tab, ".temp.XXXXXX");
+
+	tab_fd = mkstemp((char *)slice_as_string(temp_tab));
+	wr = reftable_new_writer(reftable_fd_write, &tab_fd, &st->config);
+
+	err = stack_write_compact(st, wr, first, last, config);
+	if (err < 0)
+		goto done;
+	err = reftable_writer_close(wr);
+	if (err < 0)
+		goto done;
+
+	err = close(tab_fd);
+	tab_fd = 0;
+
+done:
+	reftable_writer_free(wr);
+	if (tab_fd > 0) {
+		close(tab_fd);
+		tab_fd = 0;
+	}
+	if (err != 0 && temp_tab->len > 0) {
+		unlink(slice_as_string(temp_tab));
+		slice_release(temp_tab);
+	}
+	slice_release(&next_name);
+	return err;
+}
+
+int stack_write_compact(struct reftable_stack *st, struct reftable_writer *wr,
+			int first, int last,
+			struct reftable_log_expiry_config *config)
+{
+	int subtabs_len = last - first + 1;
+	struct reftable_reader **subtabs = reftable_calloc(
+		sizeof(struct reftable_reader *) * (last - first + 1));
+	struct reftable_merged_table *mt = NULL;
+	int err = 0;
+	struct reftable_iterator it = { 0 };
+	struct reftable_ref_record ref = { 0 };
+	struct reftable_log_record log = { 0 };
+
+	uint64_t entries = 0;
+
+	int i = 0, j = 0;
+	for (i = first, j = 0; i <= last; i++) {
+		struct reftable_reader *t = st->merged->stack[i];
+		subtabs[j++] = t;
+		st->stats.bytes += t->size;
+	}
+	reftable_writer_set_limits(wr,
+				   st->merged->stack[first]->min_update_index,
+				   st->merged->stack[last]->max_update_index);
+
+	err = reftable_new_merged_table(&mt, subtabs, subtabs_len,
+					st->config.hash_id);
+	if (err < 0) {
+		reftable_free(subtabs);
+		goto done;
+	}
+
+	err = reftable_merged_table_seek_ref(mt, &it, "");
+	if (err < 0)
+		goto done;
+
+	while (true) {
+		err = reftable_iterator_next_ref(&it, &ref);
+		if (err > 0) {
+			err = 0;
+			break;
+		}
+		if (err < 0) {
+			break;
+		}
+		if (first == 0 && reftable_ref_record_is_deletion(&ref)) {
+			continue;
+		}
+
+		err = reftable_writer_add_ref(wr, &ref);
+		if (err < 0) {
+			break;
+		}
+		entries++;
+	}
+	reftable_iterator_destroy(&it);
+
+	err = reftable_merged_table_seek_log(mt, &it, "");
+	if (err < 0)
+		goto done;
+
+	while (true) {
+		err = reftable_iterator_next_log(&it, &log);
+		if (err > 0) {
+			err = 0;
+			break;
+		}
+		if (err < 0) {
+			break;
+		}
+		if (first == 0 && reftable_log_record_is_deletion(&log)) {
+			continue;
+		}
+
+		if (config != NULL && config->time > 0 &&
+		    log.time < config->time) {
+			continue;
+		}
+
+		if (config != NULL && config->min_update_index > 0 &&
+		    log.update_index < config->min_update_index) {
+			continue;
+		}
+
+		err = reftable_writer_add_log(wr, &log);
+		if (err < 0) {
+			break;
+		}
+		entries++;
+	}
+
+done:
+	reftable_iterator_destroy(&it);
+	if (mt != NULL) {
+		merged_table_clear(mt);
+		reftable_merged_table_free(mt);
+	}
+	reftable_ref_record_clear(&ref);
+	reftable_log_record_clear(&log);
+	st->stats.entries_written += entries;
+	return err;
+}
+
+/* <  0: error. 0 == OK, > 0 attempt failed; could retry. */
+static int stack_compact_range(struct reftable_stack *st, int first, int last,
+			       struct reftable_log_expiry_config *expiry)
+{
+	struct slice temp_tab_file_name = SLICE_INIT;
+	struct slice new_table_name = SLICE_INIT;
+	struct slice lock_file_name = SLICE_INIT;
+	struct slice ref_list_contents = SLICE_INIT;
+	struct slice new_table_path = SLICE_INIT;
+	int err = 0;
+	bool have_lock = false;
+	int lock_file_fd = 0;
+	int compact_count = last - first + 1;
+	char **listp = NULL;
+	char **delete_on_success =
+		reftable_calloc(sizeof(char *) * (compact_count + 1));
+	char **subtable_locks =
+		reftable_calloc(sizeof(char *) * (compact_count + 1));
+	int i = 0;
+	int j = 0;
+	bool is_empty_table = false;
+
+	if (first > last || (expiry == NULL && first == last)) {
+		err = 0;
+		goto done;
+	}
+
+	st->stats.attempts++;
+
+	slice_set_string(&lock_file_name, st->list_file);
+	slice_addstr(&lock_file_name, ".lock");
+
+	lock_file_fd = open(slice_as_string(&lock_file_name),
+			    O_EXCL | O_CREAT | O_WRONLY, 0644);
+	if (lock_file_fd < 0) {
+		if (errno == EEXIST) {
+			err = 1;
+		} else {
+			err = REFTABLE_IO_ERROR;
+		}
+		goto done;
+	}
+	/* Don't want to write to the lock for now.  */
+	close(lock_file_fd);
+	lock_file_fd = 0;
+
+	have_lock = true;
+	err = stack_uptodate(st);
+	if (err != 0)
+		goto done;
+
+	for (i = first, j = 0; i <= last; i++) {
+		struct slice subtab_file_name = SLICE_INIT;
+		struct slice subtab_lock = SLICE_INIT;
+		int sublock_file_fd = -1;
+
+		slice_set_string(&subtab_file_name, st->reftable_dir);
+		slice_addstr(&subtab_file_name, "/");
+		slice_addstr(&subtab_file_name,
+			     reader_name(st->merged->stack[i]));
+
+		slice_copy(&subtab_lock, &subtab_file_name);
+		slice_addstr(&subtab_lock, ".lock");
+
+		sublock_file_fd = open(slice_as_string(&subtab_lock),
+				       O_EXCL | O_CREAT | O_WRONLY, 0644);
+		if (sublock_file_fd > 0) {
+			close(sublock_file_fd);
+		} else if (sublock_file_fd < 0) {
+			if (errno == EEXIST) {
+				err = 1;
+			} else {
+				err = REFTABLE_IO_ERROR;
+			}
+		}
+
+		subtable_locks[j] = (char *)slice_as_string(&subtab_lock);
+		delete_on_success[j] =
+			(char *)slice_as_string(&subtab_file_name);
+		j++;
+
+		if (err != 0)
+			goto done;
+	}
+
+	err = unlink(slice_as_string(&lock_file_name));
+	if (err < 0)
+		goto done;
+	have_lock = false;
+
+	err = stack_compact_locked(st, first, last, &temp_tab_file_name,
+				   expiry);
+	/* Compaction + tombstones can create an empty table out of non-empty
+	 * tables. */
+	is_empty_table = (err == REFTABLE_EMPTY_TABLE_ERROR);
+	if (is_empty_table) {
+		err = 0;
+	}
+	if (err < 0)
+		goto done;
+
+	lock_file_fd = open(slice_as_string(&lock_file_name),
+			    O_EXCL | O_CREAT | O_WRONLY, 0644);
+	if (lock_file_fd < 0) {
+		if (errno == EEXIST) {
+			err = 1;
+		} else {
+			err = REFTABLE_IO_ERROR;
+		}
+		goto done;
+	}
+	have_lock = true;
+
+	format_name(&new_table_name, st->merged->stack[first]->min_update_index,
+		    st->merged->stack[last]->max_update_index);
+	slice_addstr(&new_table_name, ".ref");
+
+	slice_set_string(&new_table_path, st->reftable_dir);
+	slice_addstr(&new_table_path, "/");
+
+	slice_addbuf(&new_table_path, &new_table_name);
+
+	if (!is_empty_table) {
+		err = rename(slice_as_string(&temp_tab_file_name),
+			     slice_as_string(&new_table_path));
+		if (err < 0) {
+			err = REFTABLE_IO_ERROR;
+			goto done;
+		}
+	}
+
+	for (i = 0; i < first; i++) {
+		slice_addstr(&ref_list_contents, st->merged->stack[i]->name);
+		slice_addstr(&ref_list_contents, "\n");
+	}
+	if (!is_empty_table) {
+		slice_addbuf(&ref_list_contents, &new_table_name);
+		slice_addstr(&ref_list_contents, "\n");
+	}
+	for (i = last + 1; i < st->merged->stack_len; i++) {
+		slice_addstr(&ref_list_contents, st->merged->stack[i]->name);
+		slice_addstr(&ref_list_contents, "\n");
+	}
+
+	err = write(lock_file_fd, ref_list_contents.buf, ref_list_contents.len);
+	if (err < 0) {
+		err = REFTABLE_IO_ERROR;
+		unlink(slice_as_string(&new_table_path));
+		goto done;
+	}
+	err = close(lock_file_fd);
+	lock_file_fd = 0;
+	if (err < 0) {
+		err = REFTABLE_IO_ERROR;
+		unlink(slice_as_string(&new_table_path));
+		goto done;
+	}
+
+	err = rename(slice_as_string(&lock_file_name), st->list_file);
+	if (err < 0) {
+		err = REFTABLE_IO_ERROR;
+		unlink(slice_as_string(&new_table_path));
+		goto done;
+	}
+	have_lock = false;
+
+	/* Reload the stack before deleting. On windows, we can only delete the
+	   files after we closed them.
+	*/
+	err = reftable_stack_reload_maybe_reuse(st, first < last);
+
+	listp = delete_on_success;
+	while (*listp) {
+		if (strcmp(*listp, slice_as_string(&new_table_path))) {
+			unlink(*listp);
+		}
+		listp++;
+	}
+
+done:
+	free_names(delete_on_success);
+
+	listp = subtable_locks;
+	while (*listp) {
+		unlink(*listp);
+		listp++;
+	}
+	free_names(subtable_locks);
+	if (lock_file_fd > 0) {
+		close(lock_file_fd);
+		lock_file_fd = 0;
+	}
+	if (have_lock) {
+		unlink(slice_as_string(&lock_file_name));
+	}
+	slice_release(&new_table_name);
+	slice_release(&new_table_path);
+	slice_release(&ref_list_contents);
+	slice_release(&temp_tab_file_name);
+	slice_release(&lock_file_name);
+	return err;
+}
+
+int reftable_stack_compact_all(struct reftable_stack *st,
+			       struct reftable_log_expiry_config *config)
+{
+	return stack_compact_range(st, 0, st->merged->stack_len - 1, config);
+}
+
+static int stack_compact_range_stats(struct reftable_stack *st, int first,
+				     int last,
+				     struct reftable_log_expiry_config *config)
+{
+	int err = stack_compact_range(st, first, last, config);
+	if (err > 0) {
+		st->stats.failures++;
+	}
+	return err;
+}
+
+static int segment_size(struct segment *s)
+{
+	return s->end - s->start;
+}
+
+int fastlog2(uint64_t sz)
+{
+	int l = 0;
+	if (sz == 0)
+		return 0;
+	for (; sz; sz /= 2) {
+		l++;
+	}
+	return l - 1;
+}
+
+struct segment *sizes_to_segments(int *seglen, uint64_t *sizes, int n)
+{
+	struct segment *segs = reftable_calloc(sizeof(struct segment) * n);
+	int next = 0;
+	struct segment cur = { 0 };
+	int i = 0;
+
+	if (n == 0) {
+		*seglen = 0;
+		return segs;
+	}
+	for (i = 0; i < n; i++) {
+		int log = fastlog2(sizes[i]);
+		if (cur.log != log && cur.bytes > 0) {
+			struct segment fresh = {
+				.start = i,
+			};
+
+			segs[next++] = cur;
+			cur = fresh;
+		}
+
+		cur.log = log;
+		cur.end = i + 1;
+		cur.bytes += sizes[i];
+	}
+	segs[next++] = cur;
+	*seglen = next;
+	return segs;
+}
+
+struct segment suggest_compaction_segment(uint64_t *sizes, int n)
+{
+	int seglen = 0;
+	struct segment *segs = sizes_to_segments(&seglen, sizes, n);
+	struct segment min_seg = {
+		.log = 64,
+	};
+	int i = 0;
+	for (i = 0; i < seglen; i++) {
+		if (segment_size(&segs[i]) == 1) {
+			continue;
+		}
+
+		if (segs[i].log < min_seg.log) {
+			min_seg = segs[i];
+		}
+	}
+
+	while (min_seg.start > 0) {
+		int prev = min_seg.start - 1;
+		if (fastlog2(min_seg.bytes) < fastlog2(sizes[prev])) {
+			break;
+		}
+
+		min_seg.start = prev;
+		min_seg.bytes += sizes[prev];
+	}
+
+	reftable_free(segs);
+	return min_seg;
+}
+
+static uint64_t *stack_table_sizes_for_compaction(struct reftable_stack *st)
+{
+	uint64_t *sizes =
+		reftable_calloc(sizeof(uint64_t) * st->merged->stack_len);
+	int version = (st->config.hash_id == SHA1_ID) ? 1 : 2;
+	int overhead = header_size(version) - 1;
+	int i = 0;
+	for (i = 0; i < st->merged->stack_len; i++) {
+		sizes[i] = st->merged->stack[i]->size - overhead;
+	}
+	return sizes;
+}
+
+int reftable_stack_auto_compact(struct reftable_stack *st)
+{
+	uint64_t *sizes = stack_table_sizes_for_compaction(st);
+	struct segment seg =
+		suggest_compaction_segment(sizes, st->merged->stack_len);
+	reftable_free(sizes);
+	if (segment_size(&seg) > 0)
+		return stack_compact_range_stats(st, seg.start, seg.end - 1,
+						 NULL);
+
+	return 0;
+}
+
+struct reftable_compaction_stats *
+reftable_stack_compaction_stats(struct reftable_stack *st)
+{
+	return &st->stats;
+}
+
+int reftable_stack_read_ref(struct reftable_stack *st, const char *refname,
+			    struct reftable_ref_record *ref)
+{
+	struct reftable_table tab = { NULL };
+	reftable_table_from_merged_table(&tab, reftable_stack_merged_table(st));
+	return reftable_table_read_ref(&tab, refname, ref);
+}
+
+int reftable_stack_read_log(struct reftable_stack *st, const char *refname,
+			    struct reftable_log_record *log)
+{
+	struct reftable_iterator it = { 0 };
+	struct reftable_merged_table *mt = reftable_stack_merged_table(st);
+	int err = reftable_merged_table_seek_log(mt, &it, refname);
+	if (err)
+		goto done;
+
+	err = reftable_iterator_next_log(&it, log);
+	if (err)
+		goto done;
+
+	if (strcmp(log->ref_name, refname) ||
+	    reftable_log_record_is_deletion(log)) {
+		err = 1;
+		goto done;
+	}
+
+done:
+	if (err) {
+		reftable_log_record_clear(log);
+	}
+	reftable_iterator_destroy(&it);
+	return err;
+}
+
+int stack_check_addition(struct reftable_stack *st, const char *new_tab_name)
+{
+	int err = 0;
+	struct reftable_block_source src = { 0 };
+	struct reftable_reader *rd = NULL;
+	struct reftable_table tab = { NULL };
+	struct reftable_ref_record *refs = NULL;
+	struct reftable_iterator it = { NULL };
+	int cap = 0;
+	int len = 0;
+	int i = 0;
+
+	if (st->config.skip_name_check)
+		return 0;
+
+	err = reftable_block_source_from_file(&src, new_tab_name);
+	if (err < 0)
+		goto done;
+
+	err = reftable_new_reader(&rd, &src, new_tab_name);
+	if (err < 0)
+		goto done;
+
+	err = reftable_reader_seek_ref(rd, &it, "");
+	if (err > 0) {
+		err = 0;
+		goto done;
+	}
+	if (err < 0)
+		goto done;
+
+	while (true) {
+		struct reftable_ref_record ref = { 0 };
+		err = reftable_iterator_next_ref(&it, &ref);
+		if (err > 0) {
+			break;
+		}
+		if (err < 0)
+			goto done;
+
+		if (len >= cap) {
+			cap = 2 * cap + 1;
+			refs = reftable_realloc(refs, cap * sizeof(refs[0]));
+		}
+
+		refs[len++] = ref;
+	}
+
+	reftable_table_from_merged_table(&tab, reftable_stack_merged_table(st));
+
+	err = validate_ref_record_addition(tab, refs, len);
+
+done:
+	for (i = 0; i < len; i++) {
+		reftable_ref_record_clear(&refs[i]);
+	}
+
+	free(refs);
+	reftable_iterator_destroy(&it);
+	reftable_reader_free(rd);
+	return err;
+}
diff --git a/reftable/stack.h b/reftable/stack.h
new file mode 100644
index 00000000000..60bca3b3e58
--- /dev/null
+++ b/reftable/stack.h
@@ -0,0 +1,48 @@
+/*
+Copyright 2020 Google LLC
+
+Use of this source code is governed by a BSD-style
+license that can be found in the LICENSE file or at
+https://developers.google.com/open-source/licenses/bsd
+*/
+
+#ifndef STACK_H
+#define STACK_H
+
+#include "reftable.h"
+#include "system.h"
+
+struct reftable_stack {
+	char *list_file;
+	char *reftable_dir;
+	bool disable_auto_compact;
+
+	struct reftable_write_options config;
+
+	struct reftable_merged_table *merged;
+	struct reftable_compaction_stats stats;
+};
+
+int read_lines(const char *filename, char ***lines);
+int stack_try_add(struct reftable_stack *st,
+		  int (*write_table)(struct reftable_writer *wr, void *arg),
+		  void *arg);
+int stack_write_compact(struct reftable_stack *st, struct reftable_writer *wr,
+			int first, int last,
+			struct reftable_log_expiry_config *config);
+int fastlog2(uint64_t sz);
+int stack_check_addition(struct reftable_stack *st, const char *new_tab_name);
+void reftable_addition_close(struct reftable_addition *add);
+int reftable_stack_reload_maybe_reuse(struct reftable_stack *st,
+				      bool reuse_open);
+
+struct segment {
+	int start, end;
+	int log;
+	uint64_t bytes;
+};
+
+struct segment *sizes_to_segments(int *seglen, uint64_t *sizes, int n);
+struct segment suggest_compaction_segment(uint64_t *sizes, int n);
+
+#endif
diff --git a/reftable/stack_test.c b/reftable/stack_test.c
new file mode 100644
index 00000000000..ffcc1e42819
--- /dev/null
+++ b/reftable/stack_test.c
@@ -0,0 +1,743 @@
+/*
+Copyright 2020 Google LLC
+
+Use of this source code is governed by a BSD-style
+license that can be found in the LICENSE file or at
+https://developers.google.com/open-source/licenses/bsd
+*/
+
+#include "stack.h"
+
+#include "system.h"
+
+#include "merged.h"
+#include "basics.h"
+#include "constants.h"
+#include "record.h"
+#include "reftable.h"
+#include "test_framework.h"
+#include "reftable-tests.h"
+
+#include <sys/types.h>
+#include <dirent.h>
+
+static void clear_dir(const char *dirname)
+{
+	int fd = open(dirname, O_DIRECTORY, 0);
+	DIR *dir = fdopendir(fd);
+	struct dirent *ent = NULL;
+
+	assert(fd >= 0);
+
+	while ((ent = readdir(dir)) != NULL) {
+		unlinkat(fd, ent->d_name, 0);
+	}
+	closedir(dir);
+	rmdir(dirname);
+}
+
+static void test_read_file(void)
+{
+	char fn[256] = "/tmp/stack.test_read_file.XXXXXX";
+	int fd = mkstemp(fn);
+	char out[1024] = "line1\n\nline2\nline3";
+	int n, err;
+	char **names = NULL;
+	char *want[] = { "line1", "line2", "line3" };
+	int i = 0;
+
+	assert(fd > 0);
+	n = write(fd, out, strlen(out));
+	assert(n == strlen(out));
+	err = close(fd);
+	assert(err >= 0);
+
+	err = read_lines(fn, &names);
+	assert_err(err);
+
+	for (i = 0; names[i] != NULL; i++) {
+		assert(0 == strcmp(want[i], names[i]));
+	}
+	free_names(names);
+	remove(fn);
+}
+
+static void test_parse_names(void)
+{
+	char buf[] = "line\n";
+	char **names = NULL;
+	parse_names(buf, strlen(buf), &names);
+
+	assert(NULL != names[0]);
+	assert(0 == strcmp(names[0], "line"));
+	assert(NULL == names[1]);
+	free_names(names);
+}
+
+static void test_names_equal(void)
+{
+	char *a[] = { "a", "b", "c", NULL };
+	char *b[] = { "a", "b", "d", NULL };
+	char *c[] = { "a", "b", NULL };
+
+	assert(names_equal(a, a));
+	assert(!names_equal(a, b));
+	assert(!names_equal(a, c));
+}
+
+static int write_test_ref(struct reftable_writer *wr, void *arg)
+{
+	struct reftable_ref_record *ref = arg;
+	reftable_writer_set_limits(wr, ref->update_index, ref->update_index);
+	return reftable_writer_add_ref(wr, ref);
+}
+
+struct write_log_arg {
+	struct reftable_log_record *log;
+	uint64_t update_index;
+};
+
+static int write_test_log(struct reftable_writer *wr, void *arg)
+{
+	struct write_log_arg *wla = arg;
+
+	reftable_writer_set_limits(wr, wla->update_index, wla->update_index);
+	return reftable_writer_add_log(wr, wla->log);
+}
+
+static void test_reftable_stack_add_one(void)
+{
+	char dir[256] = "/tmp/stack_test.XXXXXX";
+	struct reftable_write_options cfg = { 0 };
+	struct reftable_stack *st = NULL;
+	int err;
+	struct reftable_ref_record ref = {
+		.ref_name = "HEAD",
+		.update_index = 1,
+		.target = "master",
+	};
+	struct reftable_ref_record dest = { 0 };
+
+	assert(mkdtemp(dir));
+
+	err = reftable_new_stack(&st, dir, cfg);
+	assert_err(err);
+
+	err = reftable_stack_add(st, &write_test_ref, &ref);
+	assert_err(err);
+
+	err = reftable_stack_read_ref(st, ref.ref_name, &dest);
+	assert_err(err);
+	assert(0 == strcmp("master", dest.target));
+
+	reftable_ref_record_clear(&dest);
+	reftable_stack_destroy(st);
+	clear_dir(dir);
+}
+
+static void test_reftable_stack_uptodate(void)
+{
+	struct reftable_write_options cfg = { 0 };
+	struct reftable_stack *st1 = NULL;
+	struct reftable_stack *st2 = NULL;
+	char dir[256] = "/tmp/stack_test.XXXXXX";
+	int err;
+	struct reftable_ref_record ref1 = {
+		.ref_name = "HEAD",
+		.update_index = 1,
+		.target = "master",
+	};
+	struct reftable_ref_record ref2 = {
+		.ref_name = "branch2",
+		.update_index = 2,
+		.target = "master",
+	};
+
+	assert(mkdtemp(dir));
+
+	err = reftable_new_stack(&st1, dir, cfg);
+	assert_err(err);
+
+	err = reftable_new_stack(&st2, dir, cfg);
+	assert_err(err);
+
+	err = reftable_stack_add(st1, &write_test_ref, &ref1);
+	assert_err(err);
+
+	err = reftable_stack_add(st2, &write_test_ref, &ref2);
+	assert(err == REFTABLE_LOCK_ERROR);
+
+	err = reftable_stack_reload(st2);
+	assert_err(err);
+
+	err = reftable_stack_add(st2, &write_test_ref, &ref2);
+	assert_err(err);
+	reftable_stack_destroy(st1);
+	reftable_stack_destroy(st2);
+	clear_dir(dir);
+}
+
+static void test_reftable_stack_transaction_api(void)
+{
+	char dir[256] = "/tmp/stack_test.XXXXXX";
+	struct reftable_write_options cfg = { 0 };
+	struct reftable_stack *st = NULL;
+	int err;
+	struct reftable_addition *add = NULL;
+
+	struct reftable_ref_record ref = {
+		.ref_name = "HEAD",
+		.update_index = 1,
+		.target = "master",
+	};
+	struct reftable_ref_record dest = { 0 };
+
+	assert(mkdtemp(dir));
+
+	err = reftable_new_stack(&st, dir, cfg);
+	assert_err(err);
+
+	reftable_addition_destroy(add);
+
+	err = reftable_stack_new_addition(&add, st);
+	assert_err(err);
+
+	err = reftable_addition_add(add, &write_test_ref, &ref);
+	assert_err(err);
+
+	err = reftable_addition_commit(add);
+	assert_err(err);
+
+	reftable_addition_destroy(add);
+
+	err = reftable_stack_read_ref(st, ref.ref_name, &dest);
+	assert_err(err);
+	assert(0 == strcmp("master", dest.target));
+
+	reftable_ref_record_clear(&dest);
+	reftable_stack_destroy(st);
+	clear_dir(dir);
+}
+
+static void test_reftable_stack_validate_refname(void)
+{
+	struct reftable_write_options cfg = { 0 };
+	struct reftable_stack *st = NULL;
+	int err;
+	char dir[256] = "/tmp/stack_test.XXXXXX";
+	int i;
+	struct reftable_ref_record ref = {
+		.ref_name = "a/b",
+		.update_index = 1,
+		.target = "master",
+	};
+	char *additions[] = { "a", "a/b/c" };
+
+	assert(mkdtemp(dir));
+	err = reftable_new_stack(&st, dir, cfg);
+	assert_err(err);
+
+	err = reftable_stack_add(st, &write_test_ref, &ref);
+	assert_err(err);
+
+	for (i = 0; i < ARRAY_SIZE(additions); i++) {
+		struct reftable_ref_record ref = {
+			.ref_name = additions[i],
+			.update_index = 1,
+			.target = "master",
+		};
+
+		err = reftable_stack_add(st, &write_test_ref, &ref);
+		assert(err == REFTABLE_NAME_CONFLICT);
+	}
+
+	reftable_stack_destroy(st);
+	clear_dir(dir);
+}
+
+static int write_error(struct reftable_writer *wr, void *arg)
+{
+	return *((int *)arg);
+}
+
+static void test_reftable_stack_update_index_check(void)
+{
+	char dir[256] = "/tmp/stack_test.XXXXXX";
+	struct reftable_write_options cfg = { 0 };
+	struct reftable_stack *st = NULL;
+	int err;
+	struct reftable_ref_record ref1 = {
+		.ref_name = "name1",
+		.update_index = 1,
+		.target = "master",
+	};
+	struct reftable_ref_record ref2 = {
+		.ref_name = "name2",
+		.update_index = 1,
+		.target = "master",
+	};
+	assert(mkdtemp(dir));
+
+	err = reftable_new_stack(&st, dir, cfg);
+	assert_err(err);
+
+	err = reftable_stack_add(st, &write_test_ref, &ref1);
+	assert_err(err);
+
+	err = reftable_stack_add(st, &write_test_ref, &ref2);
+	assert(err == REFTABLE_API_ERROR);
+	reftable_stack_destroy(st);
+	clear_dir(dir);
+}
+
+static void test_reftable_stack_lock_failure(void)
+{
+	char dir[256] = "/tmp/stack_test.XXXXXX";
+	struct reftable_write_options cfg = { 0 };
+	struct reftable_stack *st = NULL;
+	int err, i;
+	assert(mkdtemp(dir));
+
+	err = reftable_new_stack(&st, dir, cfg);
+	assert_err(err);
+	for (i = -1; i != REFTABLE_EMPTY_TABLE_ERROR; i--) {
+		err = reftable_stack_add(st, &write_error, &i);
+		assert(err == i);
+	}
+
+	reftable_stack_destroy(st);
+	clear_dir(dir);
+}
+
+static void test_reftable_stack_add(void)
+{
+	int i = 0;
+	int err = 0;
+	struct reftable_write_options cfg = { 0 };
+	struct reftable_stack *st = NULL;
+	char dir[256] = "/tmp/stack_test.XXXXXX";
+	struct reftable_ref_record refs[2] = { 0 };
+	struct reftable_log_record logs[2] = { 0 };
+	int N = ARRAY_SIZE(refs);
+
+	assert(mkdtemp(dir));
+
+	err = reftable_new_stack(&st, dir, cfg);
+	assert_err(err);
+	st->disable_auto_compact = true;
+
+	for (i = 0; i < N; i++) {
+		char buf[256];
+		snprintf(buf, sizeof(buf), "branch%02d", i);
+		refs[i].ref_name = xstrdup(buf);
+		refs[i].value = reftable_malloc(SHA1_SIZE);
+		refs[i].update_index = i + 1;
+		set_test_hash(refs[i].value, i);
+
+		logs[i].ref_name = xstrdup(buf);
+		logs[i].update_index = N + i + 1;
+		logs[i].new_hash = reftable_malloc(SHA1_SIZE);
+		logs[i].email = xstrdup("identity@invalid");
+		set_test_hash(logs[i].new_hash, i);
+	}
+
+	for (i = 0; i < N; i++) {
+		int err = reftable_stack_add(st, &write_test_ref, &refs[i]);
+		assert_err(err);
+	}
+
+	for (i = 0; i < N; i++) {
+		struct write_log_arg arg = {
+			.log = &logs[i],
+			.update_index = reftable_stack_next_update_index(st),
+		};
+		int err = reftable_stack_add(st, &write_test_log, &arg);
+		assert_err(err);
+	}
+
+	err = reftable_stack_compact_all(st, NULL);
+	assert_err(err);
+
+	for (i = 0; i < N; i++) {
+		struct reftable_ref_record dest = { 0 };
+		int err = reftable_stack_read_ref(st, refs[i].ref_name, &dest);
+		assert_err(err);
+		assert(reftable_ref_record_equal(&dest, refs + i, SHA1_SIZE));
+		reftable_ref_record_clear(&dest);
+	}
+
+	for (i = 0; i < N; i++) {
+		struct reftable_log_record dest = { 0 };
+		int err = reftable_stack_read_log(st, refs[i].ref_name, &dest);
+		assert_err(err);
+		assert(reftable_log_record_equal(&dest, logs + i, SHA1_SIZE));
+		reftable_log_record_clear(&dest);
+	}
+
+	/* cleanup */
+	reftable_stack_destroy(st);
+	for (i = 0; i < N; i++) {
+		reftable_ref_record_clear(&refs[i]);
+		reftable_log_record_clear(&logs[i]);
+	}
+	clear_dir(dir);
+}
+
+static void test_reftable_stack_tombstone(void)
+{
+	int i = 0;
+	char dir[256] = "/tmp/stack_test.XXXXXX";
+	struct reftable_write_options cfg = { 0 };
+	struct reftable_stack *st = NULL;
+	int err;
+	struct reftable_ref_record refs[2] = { 0 };
+	struct reftable_log_record logs[2] = { 0 };
+	int N = ARRAY_SIZE(refs);
+	struct reftable_ref_record dest = { 0 };
+	struct reftable_log_record log_dest = { 0 };
+
+	assert(mkdtemp(dir));
+
+	err = reftable_new_stack(&st, dir, cfg);
+	assert_err(err);
+
+	for (i = 0; i < N; i++) {
+		const char *buf = "branch";
+		refs[i].ref_name = xstrdup(buf);
+		refs[i].update_index = i + 1;
+		if (i % 2 == 0) {
+			refs[i].value = reftable_malloc(SHA1_SIZE);
+			set_test_hash(refs[i].value, i);
+		}
+		logs[i].ref_name = xstrdup(buf);
+		/* update_index is part of the key. */
+		logs[i].update_index = 42;
+		if (i % 2 == 0) {
+			logs[i].new_hash = reftable_malloc(SHA1_SIZE);
+			set_test_hash(logs[i].new_hash, i);
+			logs[i].email = xstrdup("identity@invalid");
+		}
+	}
+	for (i = 0; i < N; i++) {
+		int err = reftable_stack_add(st, &write_test_ref, &refs[i]);
+		assert_err(err);
+	}
+	for (i = 0; i < N; i++) {
+		struct write_log_arg arg = {
+			.log = &logs[i],
+			.update_index = reftable_stack_next_update_index(st),
+		};
+		int err = reftable_stack_add(st, &write_test_log, &arg);
+		assert_err(err);
+	}
+
+	err = reftable_stack_read_ref(st, "branch", &dest);
+	assert(err == 1);
+	reftable_ref_record_clear(&dest);
+
+	err = reftable_stack_read_log(st, "branch", &log_dest);
+	assert(err == 1);
+	reftable_log_record_clear(&log_dest);
+
+	err = reftable_stack_compact_all(st, NULL);
+	assert_err(err);
+
+	err = reftable_stack_read_ref(st, "branch", &dest);
+	assert(err == 1);
+
+	err = reftable_stack_read_log(st, "branch", &log_dest);
+	assert(err == 1);
+	reftable_ref_record_clear(&dest);
+	reftable_log_record_clear(&log_dest);
+
+	/* cleanup */
+	reftable_stack_destroy(st);
+	for (i = 0; i < N; i++) {
+		reftable_ref_record_clear(&refs[i]);
+		reftable_log_record_clear(&logs[i]);
+	}
+	clear_dir(dir);
+}
+
+static void test_reftable_stack_hash_id(void)
+{
+	char dir[256] = "/tmp/stack_test.XXXXXX";
+	struct reftable_write_options cfg = { 0 };
+	struct reftable_stack *st = NULL;
+	int err;
+
+	struct reftable_ref_record ref = {
+		.ref_name = "master",
+		.target = "target",
+		.update_index = 1,
+	};
+	struct reftable_write_options cfg32 = { .hash_id = SHA256_ID };
+	struct reftable_stack *st32 = NULL;
+	struct reftable_write_options cfg_default = { 0 };
+	struct reftable_stack *st_default = NULL;
+	struct reftable_ref_record dest = { 0 };
+
+	assert(mkdtemp(dir));
+	err = reftable_new_stack(&st, dir, cfg);
+	assert_err(err);
+
+	err = reftable_stack_add(st, &write_test_ref, &ref);
+	assert_err(err);
+
+	/* can't read it with the wrong hash ID. */
+	err = reftable_new_stack(&st32, dir, cfg32);
+	assert(err == REFTABLE_FORMAT_ERROR);
+
+	/* check that we can read it back with default config too. */
+	err = reftable_new_stack(&st_default, dir, cfg_default);
+	assert_err(err);
+
+	err = reftable_stack_read_ref(st_default, "master", &dest);
+	assert_err(err);
+
+	assert(!strcmp(dest.target, ref.target));
+	reftable_ref_record_clear(&dest);
+	reftable_stack_destroy(st);
+	reftable_stack_destroy(st_default);
+	clear_dir(dir);
+}
+
+static void test_log2(void)
+{
+	assert(1 == fastlog2(3));
+	assert(2 == fastlog2(4));
+	assert(2 == fastlog2(5));
+}
+
+static void test_sizes_to_segments(void)
+{
+	uint64_t sizes[] = { 2, 3, 4, 5, 7, 9 };
+	/* .................0  1  2  3  4  5 */
+
+	int seglen = 0;
+	struct segment *segs =
+		sizes_to_segments(&seglen, sizes, ARRAY_SIZE(sizes));
+	assert(segs[2].log == 3);
+	assert(segs[2].start == 5);
+	assert(segs[2].end == 6);
+
+	assert(segs[1].log == 2);
+	assert(segs[1].start == 2);
+	assert(segs[1].end == 5);
+	reftable_free(segs);
+}
+
+static void test_sizes_to_segments_empty(void)
+{
+	uint64_t sizes[0];
+
+	int seglen = 0;
+	struct segment *segs =
+		sizes_to_segments(&seglen, sizes, ARRAY_SIZE(sizes));
+	assert(seglen == 0);
+	reftable_free(segs);
+}
+
+static void test_sizes_to_segments_all_equal(void)
+{
+	uint64_t sizes[] = { 5, 5 };
+
+	int seglen = 0;
+	struct segment *segs =
+		sizes_to_segments(&seglen, sizes, ARRAY_SIZE(sizes));
+	assert(seglen == 1);
+	assert(segs[0].start == 0);
+	assert(segs[0].end == 2);
+	reftable_free(segs);
+}
+
+static void test_suggest_compaction_segment(void)
+{
+	uint64_t sizes[] = { 128, 64, 17, 16, 9, 9, 9, 16, 16 };
+	/* .................0    1    2  3   4  5  6 */
+	struct segment min =
+		suggest_compaction_segment(sizes, ARRAY_SIZE(sizes));
+	assert(min.start == 2);
+	assert(min.end == 7);
+}
+
+static void test_suggest_compaction_segment_nothing(void)
+{
+	uint64_t sizes[] = { 64, 32, 16, 8, 4, 2 };
+	struct segment result =
+		suggest_compaction_segment(sizes, ARRAY_SIZE(sizes));
+	assert(result.start == result.end);
+}
+
+static void test_reflog_expire(void)
+{
+	char dir[256] = "/tmp/stack.test_reflog_expire.XXXXXX";
+	struct reftable_write_options cfg = { 0 };
+	struct reftable_stack *st = NULL;
+	struct reftable_log_record logs[20] = { 0 };
+	int N = ARRAY_SIZE(logs) - 1;
+	int i = 0;
+	int err;
+	struct reftable_log_expiry_config expiry = {
+		.time = 10,
+	};
+	struct reftable_log_record log = { 0 };
+
+	assert(mkdtemp(dir));
+
+	err = reftable_new_stack(&st, dir, cfg);
+	assert_err(err);
+
+	for (i = 1; i <= N; i++) {
+		char buf[256];
+		snprintf(buf, sizeof(buf), "branch%02d", i);
+
+		logs[i].ref_name = xstrdup(buf);
+		logs[i].update_index = i;
+		logs[i].time = i;
+		logs[i].new_hash = reftable_malloc(SHA1_SIZE);
+		logs[i].email = xstrdup("identity@invalid");
+		set_test_hash(logs[i].new_hash, i);
+	}
+
+	for (i = 1; i <= N; i++) {
+		struct write_log_arg arg = {
+			.log = &logs[i],
+			.update_index = reftable_stack_next_update_index(st),
+		};
+		int err = reftable_stack_add(st, &write_test_log, &arg);
+		assert_err(err);
+	}
+
+	err = reftable_stack_compact_all(st, NULL);
+	assert_err(err);
+
+	err = reftable_stack_compact_all(st, &expiry);
+	assert_err(err);
+
+	err = reftable_stack_read_log(st, logs[9].ref_name, &log);
+	assert(err == 1);
+
+	err = reftable_stack_read_log(st, logs[11].ref_name, &log);
+	assert_err(err);
+
+	expiry.min_update_index = 15;
+	err = reftable_stack_compact_all(st, &expiry);
+	assert_err(err);
+
+	err = reftable_stack_read_log(st, logs[14].ref_name, &log);
+	assert(err == 1);
+
+	err = reftable_stack_read_log(st, logs[16].ref_name, &log);
+	assert_err(err);
+
+	/* cleanup */
+	reftable_stack_destroy(st);
+	for (i = 0; i <= N; i++) {
+		reftable_log_record_clear(&logs[i]);
+	}
+	clear_dir(dir);
+	reftable_log_record_clear(&log);
+}
+
+static int write_nothing(struct reftable_writer *wr, void *arg)
+{
+	reftable_writer_set_limits(wr, 1, 1);
+	return 0;
+}
+
+static void test_empty_add(void)
+{
+	struct reftable_write_options cfg = { 0 };
+	struct reftable_stack *st = NULL;
+	int err;
+	char dir[256] = "/tmp/stack_test.XXXXXX";
+	struct reftable_stack *st2 = NULL;
+
+	assert(mkdtemp(dir));
+
+	err = reftable_new_stack(&st, dir, cfg);
+	assert_err(err);
+
+	err = reftable_stack_add(st, &write_nothing, NULL);
+	assert_err(err);
+
+	err = reftable_new_stack(&st2, dir, cfg);
+	assert_err(err);
+	clear_dir(dir);
+	reftable_stack_destroy(st);
+	reftable_stack_destroy(st2);
+}
+
+static void test_reftable_stack_auto_compaction(void)
+{
+	struct reftable_write_options cfg = { 0 };
+	struct reftable_stack *st = NULL;
+	char dir[256] = "/tmp/stack_test.XXXXXX";
+	int err, i;
+	int N = 100;
+	assert(mkdtemp(dir));
+
+	err = reftable_new_stack(&st, dir, cfg);
+	assert_err(err);
+
+	for (i = 0; i < N; i++) {
+		char name[100];
+		struct reftable_ref_record ref = {
+			.ref_name = name,
+			.update_index = reftable_stack_next_update_index(st),
+			.target = "master",
+		};
+		snprintf(name, sizeof(name), "branch%04d", i);
+
+		err = reftable_stack_add(st, &write_test_ref, &ref);
+		assert_err(err);
+
+		assert(i < 3 || st->merged->stack_len < 2 * fastlog2(i));
+	}
+
+	assert(reftable_stack_compaction_stats(st)->entries_written <
+	       (uint64_t)(N * fastlog2(N)));
+
+	reftable_stack_destroy(st);
+	clear_dir(dir);
+}
+
+int stack_test_main(int argc, const char *argv[])
+{
+	add_test_case("test_reftable_stack_uptodate",
+		      &test_reftable_stack_uptodate);
+	add_test_case("test_reftable_stack_transaction_api",
+		      &test_reftable_stack_transaction_api);
+	add_test_case("test_reftable_stack_hash_id",
+		      &test_reftable_stack_hash_id);
+	add_test_case("test_sizes_to_segments_all_equal",
+		      &test_sizes_to_segments_all_equal);
+	add_test_case("test_reftable_stack_auto_compaction",
+		      &test_reftable_stack_auto_compaction);
+	add_test_case("test_reftable_stack_validate_refname",
+		      &test_reftable_stack_validate_refname);
+	add_test_case("test_reftable_stack_update_index_check",
+		      &test_reftable_stack_update_index_check);
+	add_test_case("test_reftable_stack_lock_failure",
+		      &test_reftable_stack_lock_failure);
+	add_test_case("test_reftable_stack_tombstone",
+		      &test_reftable_stack_tombstone);
+	add_test_case("test_reftable_stack_add_one",
+		      &test_reftable_stack_add_one);
+	add_test_case("test_empty_add", test_empty_add);
+	add_test_case("test_reflog_expire", test_reflog_expire);
+	add_test_case("test_suggest_compaction_segment",
+		      &test_suggest_compaction_segment);
+	add_test_case("test_suggest_compaction_segment_nothing",
+		      &test_suggest_compaction_segment_nothing);
+	add_test_case("test_sizes_to_segments", &test_sizes_to_segments);
+	add_test_case("test_sizes_to_segments_empty",
+		      &test_sizes_to_segments_empty);
+	add_test_case("test_log2", &test_log2);
+	add_test_case("test_parse_names", &test_parse_names);
+	add_test_case("test_read_file", &test_read_file);
+	add_test_case("test_names_equal", &test_names_equal);
+	add_test_case("test_reftable_stack_add", &test_reftable_stack_add);
+	return test_main(argc, argv);
+}
diff --git a/reftable/system.h b/reftable/system.h
new file mode 100644
index 00000000000..9e2c4b8d9ac
--- /dev/null
+++ b/reftable/system.h
@@ -0,0 +1,54 @@
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
+#if 1 /* REFTABLE_IN_GITCORE */
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
+#endif /* REFTABLE_IN_GITCORE */
+
+#define SHA1_ID 0x73686131
+#define SHA256_ID 0x73323536
+#define SHA1_SIZE 20
+#define SHA256_SIZE 32
+
+typedef uint8_t byte;
+typedef int bool;
+
+/* This is uncompress2, which is only available in zlib as of 2017.
+ *
+ * TODO: in git-core, this should fallback to uncompress2 if it is available.
+ */
+int uncompress_return_consumed(Bytef *dest, uLongf *destLen,
+			       const Bytef *source, uLong *sourceLen);
+int hash_size(uint32_t id);
+
+#endif
diff --git a/reftable/test_framework.c b/reftable/test_framework.c
new file mode 100644
index 00000000000..44de31b7338
--- /dev/null
+++ b/reftable/test_framework.c
@@ -0,0 +1,69 @@
+/*
+Copyright 2020 Google LLC
+
+Use of this source code is governed by a BSD-style
+license that can be found in the LICENSE file or at
+https://developers.google.com/open-source/licenses/bsd
+*/
+
+#include "test_framework.h"
+
+#include "system.h"
+#include "basics.h"
+#include "constants.h"
+
+struct test_case **test_cases;
+int test_case_len;
+int test_case_cap;
+
+struct test_case *new_test_case(const char *name, void (*testfunc)(void))
+{
+	struct test_case *tc = reftable_malloc(sizeof(struct test_case));
+	tc->name = name;
+	tc->testfunc = testfunc;
+	return tc;
+}
+
+struct test_case *add_test_case(const char *name, void (*testfunc)(void))
+{
+	struct test_case *tc = new_test_case(name, testfunc);
+	if (test_case_len == test_case_cap) {
+		test_case_cap = 2 * test_case_cap + 1;
+		test_cases = reftable_realloc(
+			test_cases, sizeof(struct test_case) * test_case_cap);
+	}
+
+	test_cases[test_case_len++] = tc;
+	return tc;
+}
+
+int test_main(int argc, const char *argv[])
+{
+	const char *filter = NULL;
+	int i = 0;
+	if (argc > 1) {
+		filter = argv[1];
+	}
+
+	for (i = 0; i < test_case_len; i++) {
+		const char *name = test_cases[i]->name;
+		if (filter == NULL || strstr(name, filter) != NULL) {
+			printf("case %s\n", name);
+			test_cases[i]->testfunc();
+		} else {
+			printf("skip %s\n", name);
+		}
+
+		reftable_free(test_cases[i]);
+	}
+	reftable_free(test_cases);
+	test_cases = 0;
+	test_case_len = 0;
+	test_case_cap = 0;
+	return 0;
+}
+
+void set_test_hash(byte *p, int i)
+{
+	memset(p, (byte)i, hash_size(SHA1_ID));
+}
diff --git a/reftable/test_framework.h b/reftable/test_framework.h
new file mode 100644
index 00000000000..a3ba7d9a6e6
--- /dev/null
+++ b/reftable/test_framework.h
@@ -0,0 +1,64 @@
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
+
+#include "reftable.h"
+
+#ifdef NDEBUG
+#undef NDEBUG
+#endif
+
+#include "system.h"
+
+#ifdef assert
+#undef assert
+#endif
+
+#define assert_err(c)                                                  \
+	if (c != 0) {                                                  \
+		fflush(stderr);                                        \
+		fflush(stdout);                                        \
+		fprintf(stderr, "%s: %d: error == %d (%s), want 0\n",  \
+			__FILE__, __LINE__, c, reftable_error_str(c)); \
+		abort();                                               \
+	}
+
+#define assert_streq(a, b)                                               \
+	if (strcmp(a, b)) {                                              \
+		fflush(stderr);                                          \
+		fflush(stdout);                                          \
+		fprintf(stderr, "%s:%d: %s (%s) != %s (%s)\n", __FILE__, \
+			__LINE__, #a, a, #b, b);                         \
+		abort();                                                 \
+	}
+
+#define assert(c)                                                          \
+	if (!(c)) {                                                        \
+		fflush(stderr);                                            \
+		fflush(stdout);                                            \
+		fprintf(stderr, "%s: %d: failed assertion %s\n", __FILE__, \
+			__LINE__, #c);                                     \
+		abort();                                                   \
+	}
+
+struct test_case {
+	const char *name;
+	void (*testfunc)(void);
+};
+
+struct test_case *new_test_case(const char *name, void (*testfunc)(void));
+struct test_case *add_test_case(const char *name, void (*testfunc)(void));
+int test_main(int argc, const char *argv[]);
+
+void set_test_hash(byte *p, int i);
+
+#endif
diff --git a/reftable/tree.c b/reftable/tree.c
new file mode 100644
index 00000000000..0061d14e306
--- /dev/null
+++ b/reftable/tree.c
@@ -0,0 +1,63 @@
+/*
+Copyright 2020 Google LLC
+
+Use of this source code is governed by a BSD-style
+license that can be found in the LICENSE file or at
+https://developers.google.com/open-source/licenses/bsd
+*/
+
+#include "tree.h"
+
+#include "basics.h"
+#include "system.h"
+
+struct tree_node *tree_search(void *key, struct tree_node **rootp,
+			      int (*compare)(const void *, const void *),
+			      int insert)
+{
+	int res;
+	if (*rootp == NULL) {
+		if (!insert) {
+			return NULL;
+		} else {
+			struct tree_node *n =
+				reftable_calloc(sizeof(struct tree_node));
+			n->key = key;
+			*rootp = n;
+			return *rootp;
+		}
+	}
+
+	res = compare(key, (*rootp)->key);
+	if (res < 0)
+		return tree_search(key, &(*rootp)->left, compare, insert);
+	else if (res > 0)
+		return tree_search(key, &(*rootp)->right, compare, insert);
+	return *rootp;
+}
+
+void infix_walk(struct tree_node *t, void (*action)(void *arg, void *key),
+		void *arg)
+{
+	if (t->left != NULL) {
+		infix_walk(t->left, action, arg);
+	}
+	action(arg, t->key);
+	if (t->right != NULL) {
+		infix_walk(t->right, action, arg);
+	}
+}
+
+void tree_free(struct tree_node *t)
+{
+	if (t == NULL) {
+		return;
+	}
+	if (t->left != NULL) {
+		tree_free(t->left);
+	}
+	if (t->right != NULL) {
+		tree_free(t->right);
+	}
+	reftable_free(t);
+}
diff --git a/reftable/tree.h b/reftable/tree.h
new file mode 100644
index 00000000000..954512e9a3a
--- /dev/null
+++ b/reftable/tree.h
@@ -0,0 +1,34 @@
+/*
+Copyright 2020 Google LLC
+
+Use of this source code is governed by a BSD-style
+license that can be found in the LICENSE file or at
+https://developers.google.com/open-source/licenses/bsd
+*/
+
+#ifndef TREE_H
+#define TREE_H
+
+/* tree_node is a generic binary search tree. */
+struct tree_node {
+	void *key;
+	struct tree_node *left, *right;
+};
+
+/* looks for `key` in `rootp` using `compare` as comparison function. If insert
+   is set, insert the key if it's not found. Else, return NULL.
+*/
+struct tree_node *tree_search(void *key, struct tree_node **rootp,
+			      int (*compare)(const void *, const void *),
+			      int insert);
+
+/* performs an infix walk of the tree. */
+void infix_walk(struct tree_node *t, void (*action)(void *arg, void *key),
+		void *arg);
+
+/*
+  deallocates the tree nodes recursively. Keys should be deallocated separately
+  by walking over the tree. */
+void tree_free(struct tree_node *t);
+
+#endif
diff --git a/reftable/tree_test.c b/reftable/tree_test.c
new file mode 100644
index 00000000000..c6d448cbe8a
--- /dev/null
+++ b/reftable/tree_test.c
@@ -0,0 +1,62 @@
+/*
+Copyright 2020 Google LLC
+
+Use of this source code is governed by a BSD-style
+license that can be found in the LICENSE file or at
+https://developers.google.com/open-source/licenses/bsd
+*/
+
+#include "tree.h"
+
+#include "basics.h"
+#include "record.h"
+#include "reftable.h"
+#include "test_framework.h"
+#include "reftable-tests.h"
+
+static int test_compare(const void *a, const void *b)
+{
+	return (char *)a - (char *)b;
+}
+
+struct curry {
+	void *last;
+};
+
+static void check_increasing(void *arg, void *key)
+{
+	struct curry *c = (struct curry *)arg;
+	if (c->last != NULL) {
+		assert(test_compare(c->last, key) < 0);
+	}
+	c->last = key;
+}
+
+static void test_tree(void)
+{
+	struct tree_node *root = NULL;
+
+	void *values[11] = { 0 };
+	struct tree_node *nodes[11] = { 0 };
+	int i = 1;
+	struct curry c = { 0 };
+	do {
+		nodes[i] = tree_search(values + i, &root, &test_compare, 1);
+		i = (i * 7) % 11;
+	} while (i != 1);
+
+	for (i = 1; i < ARRAY_SIZE(nodes); i++) {
+		assert(values + i == nodes[i]->key);
+		assert(nodes[i] ==
+		       tree_search(values + i, &root, &test_compare, 0));
+	}
+
+	infix_walk(root, check_increasing, &c);
+	tree_free(root);
+}
+
+int tree_test_main(int argc, const char *argv[])
+{
+	add_test_case("test_tree", &test_tree);
+	return test_main(argc, argv);
+}
diff --git a/reftable/update.sh b/reftable/update.sh
new file mode 100755
index 00000000000..b1d0c649f1f
--- /dev/null
+++ b/reftable/update.sh
@@ -0,0 +1,25 @@
+#!/bin/sh
+
+set -eu
+
+# Override this to import from somewhere else, say "../reftable".
+SRC=${SRC:-origin}
+BRANCH=${BRANCH:-master}
+
+((git --git-dir reftable-repo/.git fetch -f ${SRC} ${BRANCH}:import && cd reftable-repo && git checkout -f $(git rev-parse import) ) ||
+   git clone https://github.com/google/reftable reftable-repo)
+
+cp reftable-repo/c/*.[ch] reftable/
+cp reftable-repo/c/include/*.[ch] reftable/
+cp reftable-repo/LICENSE reftable/
+
+git --git-dir reftable-repo/.git show --no-patch --format=oneline HEAD \
+  > reftable/VERSION
+
+mv reftable/system.h reftable/system.h~
+sed 's|if REFTABLE_IN_GITCORE|if 1 /* REFTABLE_IN_GITCORE */|'  < reftable/system.h~ > reftable/system.h
+
+# Remove compatibility hacks we don't need here.
+rm reftable/compat.*
+
+git add reftable/*.[ch] reftable/LICENSE reftable/VERSION
diff --git a/reftable/writer.c b/reftable/writer.c
new file mode 100644
index 00000000000..c55ff238d96
--- /dev/null
+++ b/reftable/writer.c
@@ -0,0 +1,644 @@
+/*
+Copyright 2020 Google LLC
+
+Use of this source code is governed by a BSD-style
+license that can be found in the LICENSE file or at
+https://developers.google.com/open-source/licenses/bsd
+*/
+
+#include "writer.h"
+
+#include "system.h"
+
+#include "block.h"
+#include "constants.h"
+#include "record.h"
+#include "reftable.h"
+#include "tree.h"
+
+static struct reftable_block_stats *
+writer_reftable_block_stats(struct reftable_writer *w, byte typ)
+{
+	switch (typ) {
+	case 'r':
+		return &w->stats.ref_stats;
+	case 'o':
+		return &w->stats.obj_stats;
+	case 'i':
+		return &w->stats.idx_stats;
+	case 'g':
+		return &w->stats.log_stats;
+	}
+	assert(false);
+	return NULL;
+}
+
+/* write data, queuing the padding for the next write. Returns negative for
+ * error. */
+static int padded_write(struct reftable_writer *w, byte *data, size_t len,
+			int padding)
+{
+	int n = 0;
+	if (w->pending_padding > 0) {
+		byte *zeroed = reftable_calloc(w->pending_padding);
+		int n = w->write(w->write_arg, zeroed, w->pending_padding);
+		if (n < 0)
+			return n;
+
+		w->pending_padding = 0;
+		reftable_free(zeroed);
+	}
+
+	w->pending_padding = padding;
+	n = w->write(w->write_arg, data, len);
+	if (n < 0)
+		return n;
+	n += padding;
+	return 0;
+}
+
+static void options_set_defaults(struct reftable_write_options *opts)
+{
+	if (opts->restart_interval == 0) {
+		opts->restart_interval = 16;
+	}
+
+	if (opts->hash_id == 0) {
+		opts->hash_id = SHA1_ID;
+	}
+	if (opts->block_size == 0) {
+		opts->block_size = DEFAULT_BLOCK_SIZE;
+	}
+}
+
+static int writer_version(struct reftable_writer *w)
+{
+	return (w->opts.hash_id == 0 || w->opts.hash_id == SHA1_ID) ? 1 : 2;
+}
+
+static int writer_write_header(struct reftable_writer *w, byte *dest)
+{
+	memcpy((char *)dest, "REFT", 4);
+
+	dest[4] = writer_version(w);
+
+	put_be24(dest + 5, w->opts.block_size);
+	put_be64(dest + 8, w->min_update_index);
+	put_be64(dest + 16, w->max_update_index);
+	if (writer_version(w) == 2) {
+		put_be32(dest + 24, w->opts.hash_id);
+	}
+	return header_size(writer_version(w));
+}
+
+static void writer_reinit_block_writer(struct reftable_writer *w, byte typ)
+{
+	int block_start = 0;
+	if (w->next == 0) {
+		block_start = header_size(writer_version(w));
+	}
+
+	slice_release(&w->last_key);
+	block_writer_init(&w->block_writer_data, typ, w->block,
+			  w->opts.block_size, block_start,
+			  hash_size(w->opts.hash_id));
+	w->block_writer = &w->block_writer_data;
+	w->block_writer->restart_interval = w->opts.restart_interval;
+}
+
+struct reftable_writer *
+reftable_new_writer(int (*writer_func)(void *, byte *, size_t),
+		    void *writer_arg, struct reftable_write_options *opts)
+{
+	struct reftable_writer *wp =
+		reftable_calloc(sizeof(struct reftable_writer));
+	slice_init(&wp->block_writer_data.last_key);
+	options_set_defaults(opts);
+	if (opts->block_size >= (1 << 24)) {
+		/* TODO - error return? */
+		abort();
+	}
+	wp->last_key = reftable_empty_slice;
+	wp->block = reftable_calloc(opts->block_size);
+	wp->write = writer_func;
+	wp->write_arg = writer_arg;
+	wp->opts = *opts;
+	writer_reinit_block_writer(wp, BLOCK_TYPE_REF);
+
+	return wp;
+}
+
+void reftable_writer_set_limits(struct reftable_writer *w, uint64_t min,
+				uint64_t max)
+{
+	w->min_update_index = min;
+	w->max_update_index = max;
+}
+
+void reftable_writer_free(struct reftable_writer *w)
+{
+	reftable_free(w->block);
+	reftable_free(w);
+}
+
+struct obj_index_tree_node {
+	struct slice hash;
+	uint64_t *offsets;
+	int offset_len;
+	int offset_cap;
+};
+#define OBJ_INDEX_TREE_NODE_INIT   \
+	{                          \
+		.hash = SLICE_INIT \
+	}
+
+static int obj_index_tree_node_compare(const void *a, const void *b)
+{
+	return slice_cmp(&((const struct obj_index_tree_node *)a)->hash,
+			 &((const struct obj_index_tree_node *)b)->hash);
+}
+
+static void writer_index_hash(struct reftable_writer *w, struct slice *hash)
+{
+	uint64_t off = w->next;
+
+	struct obj_index_tree_node want = { .hash = *hash };
+
+	struct tree_node *node = tree_search(&want, &w->obj_index_tree,
+					     &obj_index_tree_node_compare, 0);
+	struct obj_index_tree_node *key = NULL;
+	if (node == NULL) {
+		struct obj_index_tree_node empty = OBJ_INDEX_TREE_NODE_INIT;
+		key = reftable_malloc(sizeof(struct obj_index_tree_node));
+		*key = empty;
+
+		slice_copy(&key->hash, hash);
+		tree_search((void *)key, &w->obj_index_tree,
+			    &obj_index_tree_node_compare, 1);
+	} else {
+		key = node->key;
+	}
+
+	if (key->offset_len > 0 && key->offsets[key->offset_len - 1] == off) {
+		return;
+	}
+
+	if (key->offset_len == key->offset_cap) {
+		key->offset_cap = 2 * key->offset_cap + 1;
+		key->offsets = reftable_realloc(
+			key->offsets, sizeof(uint64_t) * key->offset_cap);
+	}
+
+	key->offsets[key->offset_len++] = off;
+}
+
+static int writer_add_record(struct reftable_writer *w,
+			     struct reftable_record *rec)
+{
+	int result = -1;
+	struct slice key = SLICE_INIT;
+	int err = 0;
+	reftable_record_key(rec, &key);
+	if (slice_cmp(&w->last_key, &key) >= 0)
+		goto done;
+
+	slice_copy(&w->last_key, &key);
+	if (w->block_writer == NULL) {
+		writer_reinit_block_writer(w, reftable_record_type(rec));
+	}
+
+	assert(block_writer_type(w->block_writer) == reftable_record_type(rec));
+
+	if (block_writer_add(w->block_writer, rec) == 0) {
+		result = 0;
+		goto done;
+	}
+
+	err = writer_flush_block(w);
+	if (err < 0) {
+		result = err;
+		goto done;
+	}
+
+	writer_reinit_block_writer(w, reftable_record_type(rec));
+	err = block_writer_add(w->block_writer, rec);
+	if (err < 0) {
+		result = err;
+		goto done;
+	}
+
+	result = 0;
+done:
+	slice_release(&key);
+	return result;
+}
+
+int reftable_writer_add_ref(struct reftable_writer *w,
+			    struct reftable_ref_record *ref)
+{
+	struct reftable_record rec = { 0 };
+	struct reftable_ref_record copy = *ref;
+	int err = 0;
+
+	if (ref->ref_name == NULL)
+		return REFTABLE_API_ERROR;
+	if (ref->update_index < w->min_update_index ||
+	    ref->update_index > w->max_update_index)
+		return REFTABLE_API_ERROR;
+
+	reftable_record_from_ref(&rec, &copy);
+	copy.update_index -= w->min_update_index;
+	err = writer_add_record(w, &rec);
+	if (err < 0)
+		return err;
+
+	if (!w->opts.skip_index_objects && ref->value != NULL) {
+		struct slice h = {
+			.buf = ref->value,
+			.len = hash_size(w->opts.hash_id),
+			.canary = SLICE_CANARY,
+		};
+
+		writer_index_hash(w, &h);
+	}
+
+	if (!w->opts.skip_index_objects && ref->target_value != NULL) {
+		struct slice h = {
+			.buf = ref->target_value,
+			.len = hash_size(w->opts.hash_id),
+			.canary = SLICE_CANARY,
+		};
+		writer_index_hash(w, &h);
+	}
+	return 0;
+}
+
+int reftable_writer_add_refs(struct reftable_writer *w,
+			     struct reftable_ref_record *refs, int n)
+{
+	int err = 0;
+	int i = 0;
+	QSORT(refs, n, reftable_ref_record_compare_name);
+	for (i = 0; err == 0 && i < n; i++) {
+		err = reftable_writer_add_ref(w, &refs[i]);
+	}
+	return err;
+}
+
+int reftable_writer_add_log(struct reftable_writer *w,
+			    struct reftable_log_record *log)
+{
+	struct reftable_record rec = { 0 };
+	int err;
+	if (log->ref_name == NULL)
+		return REFTABLE_API_ERROR;
+
+	if (w->block_writer != NULL &&
+	    block_writer_type(w->block_writer) == BLOCK_TYPE_REF) {
+		int err = writer_finish_public_section(w);
+		if (err < 0)
+			return err;
+	}
+
+	w->next -= w->pending_padding;
+	w->pending_padding = 0;
+
+	reftable_record_from_log(&rec, log);
+	err = writer_add_record(w, &rec);
+	return err;
+}
+
+int reftable_writer_add_logs(struct reftable_writer *w,
+			     struct reftable_log_record *logs, int n)
+{
+	int err = 0;
+	int i = 0;
+	QSORT(logs, n, reftable_log_record_compare_key);
+	for (i = 0; err == 0 && i < n; i++) {
+		err = reftable_writer_add_log(w, &logs[i]);
+	}
+	return err;
+}
+
+static int writer_finish_section(struct reftable_writer *w)
+{
+	byte typ = block_writer_type(w->block_writer);
+	uint64_t index_start = 0;
+	int max_level = 0;
+	int threshold = w->opts.unpadded ? 1 : 3;
+	int before_blocks = w->stats.idx_stats.blocks;
+	int err = writer_flush_block(w);
+	int i = 0;
+	struct reftable_block_stats *bstats = NULL;
+	if (err < 0)
+		return err;
+
+	while (w->index_len > threshold) {
+		struct reftable_index_record *idx = NULL;
+		int idx_len = 0;
+
+		max_level++;
+		index_start = w->next;
+		writer_reinit_block_writer(w, BLOCK_TYPE_INDEX);
+
+		idx = w->index;
+		idx_len = w->index_len;
+
+		w->index = NULL;
+		w->index_len = 0;
+		w->index_cap = 0;
+		for (i = 0; i < idx_len; i++) {
+			struct reftable_record rec = { 0 };
+			reftable_record_from_index(&rec, idx + i);
+			if (block_writer_add(w->block_writer, &rec) == 0) {
+				continue;
+			}
+
+			err = writer_flush_block(w);
+			if (err < 0)
+				return err;
+
+			writer_reinit_block_writer(w, BLOCK_TYPE_INDEX);
+
+			err = block_writer_add(w->block_writer, &rec);
+			if (err != 0) {
+				/* write into fresh block should always succeed
+				 */
+				abort();
+			}
+		}
+		for (i = 0; i < idx_len; i++) {
+			slice_release(&idx[i].last_key);
+		}
+		reftable_free(idx);
+	}
+
+	writer_clear_index(w);
+
+	err = writer_flush_block(w);
+	if (err < 0)
+		return err;
+
+	bstats = writer_reftable_block_stats(w, typ);
+	bstats->index_blocks = w->stats.idx_stats.blocks - before_blocks;
+	bstats->index_offset = index_start;
+	bstats->max_index_level = max_level;
+
+	/* Reinit lastKey, as the next section can start with any key. */
+	w->last_key.len = 0;
+
+	return 0;
+}
+
+struct common_prefix_arg {
+	struct slice *last;
+	int max;
+};
+
+static void update_common(void *void_arg, void *key)
+{
+	struct common_prefix_arg *arg = (struct common_prefix_arg *)void_arg;
+	struct obj_index_tree_node *entry = (struct obj_index_tree_node *)key;
+	if (arg->last != NULL) {
+		int n = common_prefix_size(&entry->hash, arg->last);
+		if (n > arg->max) {
+			arg->max = n;
+		}
+	}
+	arg->last = &entry->hash;
+}
+
+struct write_record_arg {
+	struct reftable_writer *w;
+	int err;
+};
+
+static void write_object_record(void *void_arg, void *key)
+{
+	struct write_record_arg *arg = (struct write_record_arg *)void_arg;
+	struct obj_index_tree_node *entry = (struct obj_index_tree_node *)key;
+	struct reftable_obj_record obj_rec = {
+		.hash_prefix = entry->hash.buf,
+		.hash_prefix_len = arg->w->stats.object_id_len,
+		.offsets = entry->offsets,
+		.offset_len = entry->offset_len,
+	};
+	struct reftable_record rec = { 0 };
+	if (arg->err < 0)
+		goto done;
+
+	reftable_record_from_obj(&rec, &obj_rec);
+	arg->err = block_writer_add(arg->w->block_writer, &rec);
+	if (arg->err == 0)
+		goto done;
+
+	arg->err = writer_flush_block(arg->w);
+	if (arg->err < 0)
+		goto done;
+
+	writer_reinit_block_writer(arg->w, BLOCK_TYPE_OBJ);
+	arg->err = block_writer_add(arg->w->block_writer, &rec);
+	if (arg->err == 0)
+		goto done;
+	obj_rec.offset_len = 0;
+	arg->err = block_writer_add(arg->w->block_writer, &rec);
+
+	/* Should be able to write into a fresh block. */
+	assert(arg->err == 0);
+
+done:;
+}
+
+static void object_record_free(void *void_arg, void *key)
+{
+	struct obj_index_tree_node *entry = (struct obj_index_tree_node *)key;
+
+	FREE_AND_NULL(entry->offsets);
+	slice_release(&entry->hash);
+	reftable_free(entry);
+}
+
+static int writer_dump_object_index(struct reftable_writer *w)
+{
+	struct write_record_arg closure = { .w = w };
+	struct common_prefix_arg common = { 0 };
+	if (w->obj_index_tree != NULL) {
+		infix_walk(w->obj_index_tree, &update_common, &common);
+	}
+	w->stats.object_id_len = common.max + 1;
+
+	writer_reinit_block_writer(w, BLOCK_TYPE_OBJ);
+
+	if (w->obj_index_tree != NULL) {
+		infix_walk(w->obj_index_tree, &write_object_record, &closure);
+	}
+
+	if (closure.err < 0)
+		return closure.err;
+	return writer_finish_section(w);
+}
+
+int writer_finish_public_section(struct reftable_writer *w)
+{
+	byte typ = 0;
+	int err = 0;
+
+	if (w->block_writer == NULL)
+		return 0;
+
+	typ = block_writer_type(w->block_writer);
+	err = writer_finish_section(w);
+	if (err < 0)
+		return err;
+	if (typ == BLOCK_TYPE_REF && !w->opts.skip_index_objects &&
+	    w->stats.ref_stats.index_blocks > 0) {
+		err = writer_dump_object_index(w);
+		if (err < 0)
+			return err;
+	}
+
+	if (w->obj_index_tree != NULL) {
+		infix_walk(w->obj_index_tree, &object_record_free, NULL);
+		tree_free(w->obj_index_tree);
+		w->obj_index_tree = NULL;
+	}
+
+	w->block_writer = NULL;
+	return 0;
+}
+
+int reftable_writer_close(struct reftable_writer *w)
+{
+	byte footer[72];
+	byte *p = footer;
+	int err = writer_finish_public_section(w);
+	int empty_table = w->next == 0;
+	if (err != 0)
+		goto done;
+	w->pending_padding = 0;
+	if (empty_table) {
+		/* Empty tables need a header anyway. */
+		byte header[28];
+		int n = writer_write_header(w, header);
+		err = padded_write(w, header, n, 0);
+		if (err < 0)
+			goto done;
+	}
+
+	p += writer_write_header(w, footer);
+	put_be64(p, w->stats.ref_stats.index_offset);
+	p += 8;
+	put_be64(p, (w->stats.obj_stats.offset) << 5 | w->stats.object_id_len);
+	p += 8;
+	put_be64(p, w->stats.obj_stats.index_offset);
+	p += 8;
+
+	put_be64(p, w->stats.log_stats.offset);
+	p += 8;
+	put_be64(p, w->stats.log_stats.index_offset);
+	p += 8;
+
+	put_be32(p, crc32(0, footer, p - footer));
+	p += 4;
+
+	err = padded_write(w, footer, footer_size(writer_version(w)), 0);
+	if (err < 0)
+		goto done;
+
+	if (empty_table) {
+		err = REFTABLE_EMPTY_TABLE_ERROR;
+		goto done;
+	}
+
+done:
+	/* free up memory. */
+	block_writer_clear(&w->block_writer_data);
+	writer_clear_index(w);
+	slice_release(&w->last_key);
+	return err;
+}
+
+void writer_clear_index(struct reftable_writer *w)
+{
+	int i = 0;
+	for (i = 0; i < w->index_len; i++) {
+		slice_release(&w->index[i].last_key);
+	}
+
+	FREE_AND_NULL(w->index);
+	w->index_len = 0;
+	w->index_cap = 0;
+}
+
+const int debug = 0;
+
+static int writer_flush_nonempty_block(struct reftable_writer *w)
+{
+	byte typ = block_writer_type(w->block_writer);
+	struct reftable_block_stats *bstats =
+		writer_reftable_block_stats(w, typ);
+	uint64_t block_typ_off = (bstats->blocks == 0) ? w->next : 0;
+	int raw_bytes = block_writer_finish(w->block_writer);
+	int padding = 0;
+	int err = 0;
+	struct reftable_index_record ir = { .last_key = SLICE_INIT };
+	if (raw_bytes < 0)
+		return raw_bytes;
+
+	if (!w->opts.unpadded && typ != BLOCK_TYPE_LOG) {
+		padding = w->opts.block_size - raw_bytes;
+	}
+
+	if (block_typ_off > 0) {
+		bstats->offset = block_typ_off;
+	}
+
+	bstats->entries += w->block_writer->entries;
+	bstats->restarts += w->block_writer->restart_len;
+	bstats->blocks++;
+	w->stats.blocks++;
+
+	if (debug) {
+		fprintf(stderr, "block %c off %" PRIu64 " sz %d (%d)\n", typ,
+			w->next, raw_bytes,
+			get_be24(w->block + w->block_writer->header_off + 1));
+	}
+
+	if (w->next == 0) {
+		writer_write_header(w, w->block);
+	}
+
+	err = padded_write(w, w->block, raw_bytes, padding);
+	if (err < 0)
+		return err;
+
+	if (w->index_cap == w->index_len) {
+		w->index_cap = 2 * w->index_cap + 1;
+		w->index = reftable_realloc(
+			w->index,
+			sizeof(struct reftable_index_record) * w->index_cap);
+	}
+
+	ir.offset = w->next;
+	slice_copy(&ir.last_key, &w->block_writer->last_key);
+	w->index[w->index_len] = ir;
+
+	w->index_len++;
+	w->next += padding + raw_bytes;
+	w->block_writer = NULL;
+	return 0;
+}
+
+int writer_flush_block(struct reftable_writer *w)
+{
+	if (w->block_writer == NULL)
+		return 0;
+	if (w->block_writer->entries == 0)
+		return 0;
+	return writer_flush_nonempty_block(w);
+}
+
+const struct reftable_stats *writer_stats(struct reftable_writer *w)
+{
+	return &w->stats;
+}
diff --git a/reftable/writer.h b/reftable/writer.h
new file mode 100644
index 00000000000..c56d67f7116
--- /dev/null
+++ b/reftable/writer.h
@@ -0,0 +1,60 @@
+/*
+Copyright 2020 Google LLC
+
+Use of this source code is governed by a BSD-style
+license that can be found in the LICENSE file or at
+https://developers.google.com/open-source/licenses/bsd
+*/
+
+#ifndef WRITER_H
+#define WRITER_H
+
+#include "basics.h"
+#include "block.h"
+#include "reftable.h"
+#include "slice.h"
+#include "tree.h"
+
+struct reftable_writer {
+	int (*write)(void *, byte *, size_t);
+	void *write_arg;
+	int pending_padding;
+	struct slice last_key;
+
+	/* offset of next block to write. */
+	uint64_t next;
+	uint64_t min_update_index, max_update_index;
+	struct reftable_write_options opts;
+
+	/* memory buffer for writing */
+	byte *block;
+
+	/* writer for the current section. NULL or points to
+	 * block_writer_data */
+	struct block_writer *block_writer;
+
+	struct block_writer block_writer_data;
+
+	/* pending index records for the current section */
+	struct reftable_index_record *index;
+	int index_len;
+	int index_cap;
+
+	/*
+	  tree for use with tsearch; used to populate the 'o' inverse OID
+	  map */
+	struct tree_node *obj_index_tree;
+
+	struct reftable_stats stats;
+};
+
+/* finishes a block, and writes it to storage */
+int writer_flush_block(struct reftable_writer *w);
+
+/* deallocates memory related to the index */
+void writer_clear_index(struct reftable_writer *w);
+
+/* finishes writing a 'r' (refs) or 'g' (reflogs) section */
+int writer_finish_public_section(struct reftable_writer *w);
+
+#endif
diff --git a/reftable/zlib-compat.c b/reftable/zlib-compat.c
new file mode 100644
index 00000000000..3e0b0f24f1c
--- /dev/null
+++ b/reftable/zlib-compat.c
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
+int ZEXPORT uncompress_return_consumed (
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
-- 
gitgitgadget

