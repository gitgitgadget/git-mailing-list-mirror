Return-Path: <SRS0=mOGp=6L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32ACBC81BC2
	for <git@archiver.kernel.org>; Mon, 27 Apr 2020 20:20:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF871206E2
	for <git@archiver.kernel.org>; Mon, 27 Apr 2020 20:20:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RiG1B64g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726887AbgD0UUs (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Apr 2020 16:20:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726822AbgD0UUc (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 27 Apr 2020 16:20:32 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 485BDC0A3BF4
        for <git@vger.kernel.org>; Mon, 27 Apr 2020 13:13:53 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id d17so22077317wrg.11
        for <git@vger.kernel.org>; Mon, 27 Apr 2020 13:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=oyMCXW/As/ryo35MBP7MfzVW/XpUJ9KFLhUiNorcVlc=;
        b=RiG1B64g5zlgKt24lwe1KtFpSJrPJkr9HzRmHhWsJEItRZQbpShpDMl59vFt9J5bk0
         RZ8t273XP0g0FTZ24tGbLU/gRGKVulbIpOYf4nO9l/5YliEnFNs8mqZdMfVPwohAjDWA
         na0s9amYuLHLnOaWZYAj16rneBz1ZPn9nhALsXYX54ocqVoh7R5CvXczhnl3/DXueQuT
         MNCHdMqftrHZA93FTUt3VsU8fjRfA4Le77yBSa09eMwf2ZE6bYLA7TW+LFd7+r+KvIv5
         AF1xg8nYVKxsctO/ifmLQr1MNccxgeQed8U2w/l4KHvqdq3Sc1d+9cqEEL031SKCGfzO
         I3zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=oyMCXW/As/ryo35MBP7MfzVW/XpUJ9KFLhUiNorcVlc=;
        b=eVSBxM4H0ja0g5YFD1AR/vyadPaC86GrCV3dtH9hdczUjeQCdEIP1rFFPVid4eGksq
         9xtg+lWhnUT20cBwAJ5qDrotzluXi6eF8XslWPh8TuezuspD3GO11O257debKs20eAZv
         +6vefT8a8MQ0sVXWJVaK8+eC6ewgJddb8EgIs/qsacrr1/T9evzR5PUNvPz4UMnIozIw
         w3ly03FIYCcgEdwHOYjyK52bcbZY1zgNV93WpTS99W5BhIBP1VF0YtezaYgs/3ZnG2SJ
         qNvZNakFqdOH6gQ40q/KB2d/iidABhoGcpNq5KisPbgu1qA2bVPdeCXqpc1z+Hcr/zuB
         szaQ==
X-Gm-Message-State: AGi0PuZEFZOLdxx6h0CQIkvtf25B/CATEYy7U9glmfTDw3DyCI32psc7
        4OHCL60G8LDM0mmmczeG1u8sFPnI
X-Google-Smtp-Source: APiQypLAPIZlCZk++iwZ4yBhYNk0ZbYD7TFqJ8iXfwH33zJZnIB5f8py2P7VlWPaCk9tlC9zLcNTVA==
X-Received: by 2002:a5d:61c5:: with SMTP id q5mr29418665wrv.260.1588018428506;
        Mon, 27 Apr 2020 13:13:48 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q184sm330591wma.25.2020.04.27.13.13.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2020 13:13:47 -0700 (PDT)
Message-Id: <59209a5ad39326cf88966715312922f08f149942.1588018418.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.539.v10.git.1588018418.gitgitgadget@gmail.com>
References: <pull.539.v9.git.1587417295.gitgitgadget@gmail.com>
        <pull.539.v10.git.1588018418.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 27 Apr 2020 20:13:35 +0000
Subject: [PATCH v10 09/12] Add reftable library
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
 reftable/LICENSE       |   31 ++
 reftable/README.md     |   11 +
 reftable/VERSION       |    5 +
 reftable/basics.c      |  209 ++++++++
 reftable/basics.h      |   53 ++
 reftable/block.c       |  425 +++++++++++++++
 reftable/block.h       |  124 +++++
 reftable/blocksource.h |   22 +
 reftable/bytes.c       |    0
 reftable/config.h      |    1 +
 reftable/constants.h   |   21 +
 reftable/dump.c        |   97 ++++
 reftable/file.c        |   98 ++++
 reftable/iter.c        |  234 ++++++++
 reftable/iter.h        |   60 +++
 reftable/merged.c      |  327 ++++++++++++
 reftable/merged.h      |   36 ++
 reftable/pq.c          |  115 ++++
 reftable/pq.h          |   34 ++
 reftable/reader.c      |  754 ++++++++++++++++++++++++++
 reftable/reader.h      |   68 +++
 reftable/record.c      | 1126 +++++++++++++++++++++++++++++++++++++++
 reftable/record.h      |  121 +++++
 reftable/reftable.h    |  527 ++++++++++++++++++
 reftable/slice.c       |  224 ++++++++
 reftable/slice.h       |   76 +++
 reftable/stack.c       | 1151 ++++++++++++++++++++++++++++++++++++++++
 reftable/stack.h       |   44 ++
 reftable/system.h      |   53 ++
 reftable/tree.c        |   67 +++
 reftable/tree.h        |   34 ++
 reftable/update.sh     |   23 +
 reftable/writer.c      |  661 +++++++++++++++++++++++
 reftable/writer.h      |   60 +++
 reftable/zlib-compat.c |   92 ++++
 35 files changed, 6984 insertions(+)
 create mode 100644 reftable/LICENSE
 create mode 100644 reftable/README.md
 create mode 100644 reftable/VERSION
 create mode 100644 reftable/basics.c
 create mode 100644 reftable/basics.h
 create mode 100644 reftable/block.c
 create mode 100644 reftable/block.h
 create mode 100644 reftable/blocksource.h
 create mode 100644 reftable/bytes.c
 create mode 100644 reftable/config.h
 create mode 100644 reftable/constants.h
 create mode 100644 reftable/dump.c
 create mode 100644 reftable/file.c
 create mode 100644 reftable/iter.c
 create mode 100644 reftable/iter.h
 create mode 100644 reftable/merged.c
 create mode 100644 reftable/merged.h
 create mode 100644 reftable/pq.c
 create mode 100644 reftable/pq.h
 create mode 100644 reftable/reader.c
 create mode 100644 reftable/reader.h
 create mode 100644 reftable/record.c
 create mode 100644 reftable/record.h
 create mode 100644 reftable/reftable.h
 create mode 100644 reftable/slice.c
 create mode 100644 reftable/slice.h
 create mode 100644 reftable/stack.c
 create mode 100644 reftable/stack.h
 create mode 100644 reftable/system.h
 create mode 100644 reftable/tree.c
 create mode 100644 reftable/tree.h
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
index 00000000000..5d6fb5d9130
--- /dev/null
+++ b/reftable/VERSION
@@ -0,0 +1,5 @@
+commit a6d6b31bea256044621d789df64a8159647f21bc
+Author: Han-Wen Nienhuys <hanwen@google.com>
+Date:   Mon Apr 27 20:46:21 2020 +0200
+
+    C: prefix error codes with REFTABLE_
diff --git a/reftable/basics.c b/reftable/basics.c
new file mode 100644
index 00000000000..87fc235850e
--- /dev/null
+++ b/reftable/basics.c
@@ -0,0 +1,209 @@
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
+	out[2] = (byte)((i)&0xff);
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
+	out[1] = (uint8_t)((i)&0xff);
+}
+
+int binsearch(int sz, int (*f)(int k, void *args), void *args)
+{
+	int lo = 0;
+	int hi = sz;
+
+	/* invariant: (hi == sz) || f(hi) == true
+	   (lo == 0 && f(0) == true) || fi(lo) == false
+	 */
+	while (hi - lo > 1) {
+		int mid = lo + (hi - lo) / 2;
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
+	case -1:
+		return "general error";
+	default:
+		return "unknown error code";
+	}
+}
+
+int reftable_error_to_errno(int err) {
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
index 00000000000..6d89eb5d931
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
+int binsearch(int sz, int (*f)(int k, void *args), void *args);
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
index 00000000000..4b4344fcd87
--- /dev/null
+++ b/reftable/block.c
@@ -0,0 +1,425 @@
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
+#include "blocksource.h"
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
+				  struct slice key);
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
+}
+
+byte block_writer_type(struct block_writer *bw)
+{
+	return bw->buf[bw->header_off];
+}
+
+/* adds the record to the block. Returns -1 if it does not fit, 0 on
+   success */
+int block_writer_add(struct block_writer *w, struct record rec)
+{
+	struct slice empty = { 0 };
+	struct slice last = w->entries % w->restart_interval == 0 ? empty :
+								    w->last_key;
+	struct slice out = {
+		.buf = w->buf + w->next,
+		.len = w->block_size - w->next,
+	};
+
+	struct slice start = out;
+
+	bool restart = false;
+	struct slice key = { 0 };
+	int n = 0;
+
+	record_key(rec, &key);
+	n = encode_key(&restart, out, last, key, record_val_type(rec));
+	if (n < 0) {
+		goto err;
+	}
+	slice_consume(&out, n);
+
+	n = record_encode(rec, out, w->hash_size);
+	if (n < 0) {
+		goto err;
+	}
+	slice_consume(&out, n);
+
+	if (block_writer_register_restart(w, start.len - out.len, restart,
+					  key) < 0) {
+		goto err;
+	}
+
+	slice_clear(&key);
+	return 0;
+
+err:
+	slice_clear(&key);
+	return -1;
+}
+
+int block_writer_register_restart(struct block_writer *w, int n, bool restart,
+				  struct slice key)
+{
+	int rlen = w->restart_len;
+	if (rlen >= MAX_RESTARTS) {
+		restart = false;
+	}
+
+	if (restart) {
+		rlen++;
+	}
+	if (2 + 3 * rlen + n > w->block_size - w->next) {
+		return -1;
+	}
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
+		struct slice compressed = { 0 };
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
+				slice_clear(&compressed);
+				return REFTABLE_ZLIB_ERROR;
+			}
+
+			memcpy(w->buf + block_header_skip, compressed.buf,
+			       dest_len);
+			w->next = dest_len + block_header_skip;
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
+	if (!is_block_type(typ)) {
+		return REFTABLE_FORMAT_ERROR;
+	}
+
+	if (typ == BLOCK_TYPE_LOG) {
+		struct slice uncompressed = { 0 };
+		int block_header_skip = 4 + header_off;
+		uLongf dst_len = sz - block_header_skip;
+		uLongf src_len = block->len - block_header_skip;
+
+		slice_resize(&uncompressed, sz);
+		memcpy(uncompressed.buf, block->data, block_header_skip);
+
+		if (Z_OK != uncompress_return_consumed(
+				    uncompressed.buf + block_header_skip,
+				    &dst_len, block->data + block_header_skip,
+				    &src_len)) {
+			slice_clear(&uncompressed);
+			return REFTABLE_ZLIB_ERROR;
+		}
+
+		block_source_return_block(block->source, block);
+		block->data = uncompressed.buf;
+		block->len = dst_len; /* XXX: 4 bytes missing? */
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
+	{
+		uint16_t restart_count = get_be16(block->data + sz - 2);
+		uint32_t restart_start = sz - 2 - 3 * restart_count;
+
+		byte *restart_bytes = block->data + restart_start;
+
+		/* transfer ownership. */
+		br->block = *block;
+		block->data = NULL;
+		block->len = 0;
+
+		br->hash_size = hash_size;
+		br->block_len = restart_start;
+		br->full_block_size = full_block_size;
+		br->header_off = header_off;
+		br->restart_count = restart_count;
+		br->restart_bytes = restart_bytes;
+	}
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
+static int restart_key_less(int idx, void *args)
+{
+	struct restart_find_args *a = (struct restart_find_args *)args;
+	uint32_t off = block_reader_restart_offset(a->r, idx);
+	struct slice in = {
+		.buf = a->r->block.data + off,
+		.len = a->r->block_len - off,
+	};
+
+	/* the restart key is verbatim in the block, so this could avoid the
+	   alloc for decoding the key */
+	struct slice rkey = { 0 };
+	struct slice last_key = { 0 };
+	byte unused_extra;
+	int n = decode_key(&rkey, &unused_extra, last_key, in);
+	if (n < 0) {
+		a->error = 1;
+		return -1;
+	}
+
+	{
+		int result = slice_compare(a->key, rkey);
+		slice_clear(&rkey);
+		return result;
+	}
+}
+
+void block_iter_copy_from(struct block_iter *dest, struct block_iter *src)
+{
+	dest->br = src->br;
+	dest->next_off = src->next_off;
+	slice_copy(&dest->last_key, src->last_key);
+}
+
+/* return < 0 for error, 0 for OK, > 0 for EOF. */
+int block_iter_next(struct block_iter *it, struct record rec)
+{
+	if (it->next_off >= it->br->block_len) {
+		return 1;
+	}
+
+	{
+		struct slice in = {
+			.buf = it->br->block.data + it->next_off,
+			.len = it->br->block_len - it->next_off,
+		};
+		struct slice start = in;
+		struct slice key = { 0 };
+		byte extra;
+		int n = decode_key(&key, &extra, it->last_key, in);
+		if (n < 0) {
+			return -1;
+		}
+
+		slice_consume(&in, n);
+		n = record_decode(rec, key, extra, in, it->br->hash_size);
+		if (n < 0) {
+			return -1;
+		}
+		slice_consume(&in, n);
+
+		slice_copy(&it->last_key, key);
+		it->next_off += start.len - in.len;
+		slice_clear(&key);
+		return 0;
+	}
+}
+
+int block_reader_first_key(struct block_reader *br, struct slice *key)
+{
+	struct slice empty = { 0 };
+	int off = br->header_off + 4;
+	struct slice in = {
+		.buf = br->block.data + off,
+		.len = br->block_len - off,
+	};
+
+	byte extra = 0;
+	int n = decode_key(key, &extra, empty, in);
+	if (n < 0) {
+		return n;
+	}
+	return 0;
+}
+
+int block_iter_seek(struct block_iter *it, struct slice want)
+{
+	return block_reader_seek(it->br, it, want);
+}
+
+void block_iter_close(struct block_iter *it)
+{
+	slice_clear(&it->last_key);
+}
+
+int block_reader_seek(struct block_reader *br, struct block_iter *it,
+		      struct slice want)
+{
+	struct restart_find_args args = {
+		.key = want,
+		.r = br,
+	};
+
+	int i = binsearch(br->restart_count, &restart_key_less, &args);
+	if (args.error) {
+		return -1;
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
+	{
+		struct record rec = new_record(block_reader_type(br));
+		struct slice key = { 0 };
+		int result = 0;
+		int err = 0;
+		struct block_iter next = { 0 };
+		while (true) {
+			block_iter_copy_from(&next, it);
+
+			err = block_iter_next(&next, rec);
+			if (err < 0) {
+				result = -1;
+				goto exit;
+			}
+
+			record_key(rec, &key);
+			if (err > 0 || slice_compare(key, want) >= 0) {
+				result = 0;
+				goto exit;
+			}
+
+			block_iter_copy_from(it, &next);
+		}
+
+	exit:
+		slice_clear(&key);
+		slice_clear(&next.last_key);
+		record_destroy(&rec);
+
+		return result;
+	}
+}
+
+void block_writer_clear(struct block_writer *bw)
+{
+	FREE_AND_NULL(bw->restarts);
+	slice_clear(&bw->last_key);
+	/* the block is not owned. */
+}
diff --git a/reftable/block.h b/reftable/block.h
new file mode 100644
index 00000000000..62b2e0fec6d
--- /dev/null
+++ b/reftable/block.h
@@ -0,0 +1,124 @@
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
+int block_writer_add(struct block_writer *w, struct record rec);
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
+/* initializes a block reader */
+int block_reader_init(struct block_reader *br, struct reftable_block *bl,
+		      uint32_t header_off, uint32_t table_block_size,
+		      int hash_size);
+
+/* Position `it` at start of the block */
+void block_reader_start(struct block_reader *br, struct block_iter *it);
+
+/* Position `it` to the `want` key in the block */
+int block_reader_seek(struct block_reader *br, struct block_iter *it,
+		      struct slice want);
+
+/* Returns the block type (eg. 'r' for refs) */
+byte block_reader_type(struct block_reader *r);
+
+/* Decodes the first key in the block */
+int block_reader_first_key(struct block_reader *br, struct slice *key);
+
+void block_iter_copy_from(struct block_iter *dest, struct block_iter *src);
+int block_iter_next(struct block_iter *it, struct record rec);
+
+/* Seek to `want` with in the block pointed to by `it` */
+int block_iter_seek(struct block_iter *it, struct slice want);
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
+#endif
diff --git a/reftable/blocksource.h b/reftable/blocksource.h
new file mode 100644
index 00000000000..1fdf0bf4557
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
+#include "reftable.h"
+
+uint64_t block_source_size(struct reftable_block_source source);
+int block_source_read_block(struct reftable_block_source source,
+			    struct reftable_block *dest, uint64_t off,
+			    uint32_t size);
+void block_source_return_block(struct reftable_block_source source,
+			       struct reftable_block *ret);
+void block_source_close(struct reftable_block_source source);
+
+#endif
diff --git a/reftable/bytes.c b/reftable/bytes.c
new file mode 100644
index 00000000000..e69de29bb2d
diff --git a/reftable/config.h b/reftable/config.h
new file mode 100644
index 00000000000..40a8c178f10
--- /dev/null
+++ b/reftable/config.h
@@ -0,0 +1 @@
+/* empty */
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
diff --git a/reftable/dump.c b/reftable/dump.c
new file mode 100644
index 00000000000..c0065792a4f
--- /dev/null
+++ b/reftable/dump.c
@@ -0,0 +1,97 @@
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
+#include "reftable.h"
+
+static int dump_table(const char *tablename)
+{
+	struct block_source src = { 0 };
+	int err = block_source_from_file(&src, tablename);
+	if (err < 0) {
+		return err;
+	}
+
+	struct reader *r = NULL;
+	err = new_reader(&r, src, tablename);
+	if (err < 0) {
+		return err;
+	}
+
+	{
+		struct iterator it = { 0 };
+		err = reader_seek_ref(r, &it, "");
+		if (err < 0) {
+			return err;
+		}
+
+		struct ref_record ref = { 0 };
+		while (1) {
+			err = iterator_next_ref(it, &ref);
+			if (err > 0) {
+				break;
+			}
+			if (err < 0) {
+				return err;
+			}
+			ref_record_print(&ref, 20);
+		}
+		iterator_destroy(&it);
+		ref_record_clear(&ref);
+	}
+
+	{
+		struct iterator it = { 0 };
+		err = reader_seek_log(r, &it, "");
+		if (err < 0) {
+			return err;
+		}
+		struct log_record log = { 0 };
+		while (1) {
+			err = iterator_next_log(it, &log);
+			if (err > 0) {
+				break;
+			}
+			if (err < 0) {
+				return err;
+			}
+			log_record_print(&log, 20);
+		}
+		iterator_destroy(&it);
+		log_record_clear(&log);
+	}
+	return 0;
+}
+
+int main(int argc, char *argv[])
+{
+	int opt;
+	const char *table = NULL;
+	while ((opt = getopt(argc, argv, "t:")) != -1) {
+		switch (opt) {
+		case 't':
+			table = xstrdup(optarg);
+			break;
+		case '?':
+			printf("usage: %s [-table tablefile]\n", argv[0]);
+			return 2;
+			break;
+		}
+	}
+
+	if (table != NULL) {
+		int err = dump_table(table);
+		if (err < 0) {
+			fprintf(stderr, "%s: %s: %s\n", argv[0], table,
+				error_str(err));
+			return 1;
+		}
+	}
+	return 0;
+}
diff --git a/reftable/file.c b/reftable/file.c
new file mode 100644
index 00000000000..f29448ee4eb
--- /dev/null
+++ b/reftable/file.c
@@ -0,0 +1,98 @@
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
+	if (pread(b->fd, dest->data, size, off) != size) {
+		return -1;
+	}
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
+	if (fd < 0) {
+		if (errno == ENOENT) {
+			return REFTABLE_NOT_EXIST_ERROR;
+		}
+		return -1;
+	}
+
+	err = fstat(fd, &st);
+	if (err < 0) {
+		return -1;
+	}
+
+	{
+		struct file_block_source *p =
+			reftable_calloc(sizeof(struct file_block_source));
+		p->size = st.st_size;
+		p->fd = fd;
+
+		bs->ops = &file_vtable;
+		bs->arg = p;
+	}
+	return 0;
+}
+
+int reftable_fd_write(void *arg, byte *data, int sz)
+{
+	int *fdp = (int *)arg;
+	return write(*fdp, data, sz);
+}
diff --git a/reftable/iter.c b/reftable/iter.c
new file mode 100644
index 00000000000..747f3eae256
--- /dev/null
+++ b/reftable/iter.c
@@ -0,0 +1,234 @@
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
+bool iterator_is_null(struct reftable_iterator it)
+{
+	return it.ops == NULL;
+}
+
+static int empty_iterator_next(void *arg, struct record rec)
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
+	it->iter_arg = NULL;
+	it->ops = &empty_vtable;
+}
+
+int iterator_next(struct reftable_iterator it, struct record rec)
+{
+	return it.ops->next(it.iter_arg, rec);
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
+int reftable_iterator_next_ref(struct reftable_iterator it,
+			       struct reftable_ref_record *ref)
+{
+	struct record rec = { 0 };
+	record_from_ref(&rec, ref);
+	return iterator_next(it, rec);
+}
+
+int reftable_iterator_next_log(struct reftable_iterator it,
+			       struct reftable_log_record *log)
+{
+	struct record rec = { 0 };
+	record_from_log(&rec, log);
+	return iterator_next(it, rec);
+}
+
+static void filtering_ref_iterator_close(void *iter_arg)
+{
+	struct filtering_ref_iterator *fri =
+		(struct filtering_ref_iterator *)iter_arg;
+	slice_clear(&fri->oid);
+	reftable_iterator_destroy(&fri->it);
+}
+
+static int filtering_ref_iterator_next(void *iter_arg, struct record rec)
+{
+	struct filtering_ref_iterator *fri =
+		(struct filtering_ref_iterator *)iter_arg;
+	struct reftable_ref_record *ref =
+		(struct reftable_ref_record *)rec.data;
+
+	while (true) {
+		int err = reftable_iterator_next_ref(fri->it, ref);
+		if (err != 0) {
+			return err;
+		}
+
+		if (fri->double_check) {
+			struct reftable_iterator it = { 0 };
+
+			int err = reftable_reader_seek_ref(fri->r, &it,
+							   ref->ref_name);
+			if (err == 0) {
+				err = reftable_iterator_next_ref(it, ref);
+			}
+
+			reftable_iterator_destroy(&it);
+
+			if (err < 0) {
+				return err;
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
+	it->iter_arg = fri;
+	it->ops = &filtering_ref_iterator_vtable;
+}
+
+static void indexed_table_ref_iter_close(void *p)
+{
+	struct indexed_table_ref_iter *it = (struct indexed_table_ref_iter *)p;
+	block_iter_close(&it->cur);
+	reader_return_block(it->r, &it->block_reader.block);
+	slice_clear(&it->oid);
+}
+
+static int indexed_table_ref_iter_next_block(struct indexed_table_ref_iter *it)
+{
+	if (it->offset_idx == it->offset_len) {
+		it->finished = true;
+		return 1;
+	}
+
+	reader_return_block(it->r, &it->block_reader.block);
+
+	{
+		uint64_t off = it->offsets[it->offset_idx++];
+		int err = reader_init_block_reader(it->r, &it->block_reader,
+						   off, BLOCK_TYPE_REF);
+		if (err < 0) {
+			return err;
+		}
+		if (err > 0) {
+			/* indexed block does not exist. */
+			return REFTABLE_FORMAT_ERROR;
+		}
+	}
+	block_reader_start(&it->block_reader, &it->cur);
+	return 0;
+}
+
+static int indexed_table_ref_iter_next(void *p, struct record rec)
+{
+	struct indexed_table_ref_iter *it = (struct indexed_table_ref_iter *)p;
+	struct reftable_ref_record *ref =
+		(struct reftable_ref_record *)rec.data;
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
+	struct indexed_table_ref_iter *itr =
+		reftable_calloc(sizeof(struct indexed_table_ref_iter));
+	int err = 0;
+
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
+	it->iter_arg = itr;
+	it->ops = &indexed_table_ref_iter_vtable;
+}
diff --git a/reftable/iter.h b/reftable/iter.h
new file mode 100644
index 00000000000..408b7f41a74
--- /dev/null
+++ b/reftable/iter.h
@@ -0,0 +1,60 @@
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
+	int (*next)(void *iter_arg, struct record rec);
+	void (*close)(void *iter_arg);
+};
+
+void iterator_set_empty(struct reftable_iterator *it);
+int iterator_next(struct reftable_iterator it, struct record rec);
+bool iterator_is_null(struct reftable_iterator it);
+
+/* iterator that produces only ref records that point to `oid` */
+struct filtering_ref_iterator {
+	bool double_check;
+	struct reftable_reader *r;
+	struct slice oid;
+	struct reftable_iterator it;
+};
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
+void iterator_from_indexed_table_ref_iter(struct reftable_iterator *it,
+					  struct indexed_table_ref_iter *itr);
+int new_indexed_table_ref_iter(struct indexed_table_ref_iter **dest,
+			       struct reftable_reader *r, byte *oid,
+			       int oid_len, uint64_t *offsets, int offset_len);
+
+#endif
diff --git a/reftable/merged.c b/reftable/merged.c
new file mode 100644
index 00000000000..929ccc621db
--- /dev/null
+++ b/reftable/merged.c
@@ -0,0 +1,327 @@
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
+		struct record rec = new_record(mi->typ);
+		int err = iterator_next(mi->stack[i], rec);
+		if (err < 0) {
+			return err;
+		}
+
+		if (err > 0) {
+			reftable_iterator_destroy(&mi->stack[i]);
+			record_destroy(&rec);
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
+static int merged_iter_advance_subiter(struct merged_iter *mi, int idx)
+{
+	if (iterator_is_null(mi->stack[idx])) {
+		return 0;
+	}
+
+	{
+		struct record rec = new_record(mi->typ);
+		struct pq_entry e = {
+			.rec = rec,
+			.index = idx,
+		};
+		int err = iterator_next(mi->stack[idx], rec);
+		if (err < 0) {
+			return err;
+		}
+
+		if (err > 0) {
+			reftable_iterator_destroy(&mi->stack[idx]);
+			record_destroy(&rec);
+			return 0;
+		}
+
+		merged_iter_pqueue_add(&mi->pq, e);
+	}
+	return 0;
+}
+
+static int merged_iter_next_entry(struct merged_iter *mi, struct record rec)
+{
+	struct slice entry_key = { 0 };
+	struct pq_entry entry = { 0 };
+	int err = 0;
+
+	if (merged_iter_pqueue_is_empty(mi->pq)) {
+		return 1;
+	}
+
+	entry = merged_iter_pqueue_remove(&mi->pq);
+	err = merged_iter_advance_subiter(mi, entry.index);
+	if (err < 0) {
+		return err;
+	}
+
+	/*
+	  One can also use reftable as datacenter-local storage, where the ref
+	  database is maintained in globally consistent database (eg.
+	  CockroachDB or Spanner). In this scenario, replication delays together
+	  with compaction may cause newer tables to contain older entries. In
+	  such a deployment, the loop below must be changed to collect all
+	  entries for the same key, and return new the newest one.
+	*/
+	record_key(entry.rec, &entry_key);
+	while (!merged_iter_pqueue_is_empty(mi->pq)) {
+		struct pq_entry top = merged_iter_pqueue_top(mi->pq);
+		struct slice k = { 0 };
+		int err = 0, cmp = 0;
+
+		record_key(top.rec, &k);
+
+		cmp = slice_compare(k, entry_key);
+		slice_clear(&k);
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
+		record_clear(top.rec);
+		reftable_free(record_yield(&top.rec));
+	}
+
+	record_copy_from(rec, entry.rec, hash_size(mi->hash_id));
+	record_clear(entry.rec);
+	reftable_free(record_yield(&entry.rec));
+	slice_clear(&entry_key);
+	return 0;
+}
+
+static int merged_iter_next(struct merged_iter *mi, struct record rec)
+{
+	while (true) {
+		int err = merged_iter_next_entry(mi, rec);
+		if (err == 0 && mi->suppress_deletions &&
+		    record_is_deletion(rec)) {
+			continue;
+		}
+
+		return err;
+	}
+}
+
+static int merged_iter_next_void(void *p, struct record rec)
+{
+	struct merged_iter *mi = (struct merged_iter *)p;
+	if (merged_iter_pqueue_is_empty(mi->pq)) {
+		return 1;
+	}
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
+	it->iter_arg = mi;
+	it->ops = &merged_iter_vtable;
+}
+
+int reftable_new_merged_table(struct reftable_merged_table **dest,
+			      struct reftable_reader **stack, int n,
+			      uint32_t hash_id)
+{
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
+	{
+		struct reftable_merged_table m = {
+			.stack = stack,
+			.stack_len = n,
+			.min = first_min,
+			.max = last_max,
+			.hash_id = hash_id,
+		};
+
+		*dest = reftable_calloc(sizeof(struct reftable_merged_table));
+		**dest = m;
+	}
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
+static int merged_table_seek_record(struct reftable_merged_table *mt,
+				    struct reftable_iterator *it,
+				    struct record rec)
+{
+	struct reftable_iterator *iters = reftable_calloc(
+		sizeof(struct reftable_iterator) * mt->stack_len);
+	struct merged_iter merged = {
+		.stack = iters,
+		.typ = record_type(rec),
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
+	}
+
+	{
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
+	struct record rec = { 0 };
+	record_from_ref(&rec, &ref);
+	return merged_table_seek_record(mt, it, rec);
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
+	struct record rec = { 0 };
+	record_from_log(&rec, &log);
+	return merged_table_seek_record(mt, it, rec);
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
index 00000000000..d6e1a72733e
--- /dev/null
+++ b/reftable/merged.h
@@ -0,0 +1,36 @@
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
+
+#endif
diff --git a/reftable/pq.c b/reftable/pq.c
new file mode 100644
index 00000000000..bfad96c6695
--- /dev/null
+++ b/reftable/pq.c
@@ -0,0 +1,115 @@
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
+	struct slice ak = { 0 };
+	struct slice bk = { 0 };
+	int cmp = 0;
+	record_key(a.rec, &ak);
+	record_key(b.rec, &bk);
+
+	cmp = slice_compare(ak, bk);
+
+	slice_clear(&ak);
+	slice_clear(&bk);
+
+	if (cmp == 0) {
+		return a.index > b.index;
+	}
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
+		record_clear(pq->heap[i].rec);
+		reftable_free(record_yield(&pq->heap[i].rec));
+	}
+	FREE_AND_NULL(pq->heap);
+	pq->len = pq->cap = 0;
+}
diff --git a/reftable/pq.h b/reftable/pq.h
new file mode 100644
index 00000000000..b585a52ee14
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
+	struct record rec;
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
index 00000000000..d91b089f703
--- /dev/null
+++ b/reftable/reader.c
@@ -0,0 +1,754 @@
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
+
+#include "block.h"
+#include "constants.h"
+#include "iter.h"
+#include "record.h"
+#include "reftable.h"
+#include "tree.h"
+
+uint64_t block_source_size(struct reftable_block_source source)
+{
+	return source.ops->size(source.arg);
+}
+
+int block_source_read_block(struct reftable_block_source source,
+			    struct reftable_block *dest, uint64_t off,
+			    uint32_t size)
+{
+	int result = source.ops->read_block(source.arg, dest, off, size);
+	dest->source = source;
+	return result;
+}
+
+void block_source_return_block(struct reftable_block_source source,
+			       struct reftable_block *blockp)
+{
+	source.ops->return_block(source.arg, blockp);
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
+	if (off >= r->size) {
+		return 0;
+	}
+
+	if (off + sz > r->size) {
+		sz = r->size - off;
+	}
+
+	return block_source_read_block(r->source, dest, off, sz);
+}
+
+void reader_return_block(struct reftable_reader *r, struct reftable_block *p)
+{
+	block_source_return_block(r->source, p);
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
+	int err = 0;
+	if (memcmp(f, "REFT", 4)) {
+		err = REFTABLE_FORMAT_ERROR;
+		goto exit;
+	}
+	f += 4;
+
+	if (memcmp(footer, header, header_size(r->version))) {
+		err = REFTABLE_FORMAT_ERROR;
+		goto exit;
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
+			goto exit;
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
+	{
+		uint32_t computed_crc = crc32(0, footer, f - footer);
+		uint32_t file_crc = get_be32(f);
+		f += 4;
+		if (computed_crc != file_crc) {
+			err = REFTABLE_FORMAT_ERROR;
+			goto exit;
+		}
+	}
+
+	{
+		byte first_block_typ = header[header_size(r->version)];
+		r->ref_offsets.present = (first_block_typ == BLOCK_TYPE_REF);
+		r->ref_offsets.offset = 0;
+		r->log_offsets.present = (first_block_typ == BLOCK_TYPE_LOG ||
+					  r->log_offsets.offset > 0);
+		r->obj_offsets.present = r->obj_offsets.offset > 0;
+	}
+	err = 0;
+exit:
+	return err;
+}
+
+int init_reader(struct reftable_reader *r, struct reftable_block_source source,
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
+		goto exit;
+	}
+
+	if (memcmp(header.data, "REFT", 4)) {
+		err = REFTABLE_FORMAT_ERROR;
+		goto exit;
+	}
+	r->version = header.data[4];
+	if (r->version != 1 && r->version != 2) {
+		err = REFTABLE_FORMAT_ERROR;
+		goto exit;
+	}
+
+	r->size = block_source_size(source) - footer_size(r->version);
+	r->source = source;
+	r->name = xstrdup(name);
+	r->hash_id = 0;
+
+	err = block_source_read_block(source, &footer, r->size,
+				      footer_size(r->version));
+	if (err != footer_size(r->version)) {
+		err = REFTABLE_IO_ERROR;
+		goto exit;
+	}
+
+	err = parse_footer(r, footer.data, header.data);
+exit:
+	block_source_return_block(r->source, &footer);
+	block_source_return_block(r->source, &header);
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
+static int table_iter_next_in_block(struct table_iter *ti, struct record rec)
+{
+	int res = block_iter_next(&ti->bi, rec);
+	if (res == 0 && record_type(rec) == BLOCK_TYPE_REF) {
+		((struct reftable_ref_record *)rec.data)->update_index +=
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
+	reader_return_block(ti->r, &ti->bi.br->block);
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
+	if (is_block_type(*typ)) {
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
+	if (next_off >= r->size) {
+		return 1;
+	}
+
+	err = reader_get_block(r, &block, next_off, guess_block_size);
+	if (err < 0) {
+		return err;
+	}
+
+	block_size = extract_block_size(block.data, &block_typ, next_off,
+					r->version);
+	if (block_size < 0) {
+		return block_size;
+	}
+
+	if (want_typ != BLOCK_TYPE_ANY && block_typ != want_typ) {
+		reader_return_block(r, &block);
+		return 1;
+	}
+
+	if (block_size > guess_block_size) {
+		reader_return_block(r, &block);
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
+	if (err != 0) {
+		return err;
+	}
+
+	{
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
+static int table_iter_next(struct table_iter *ti, struct record rec)
+{
+	if (record_type(rec) != ti->typ) {
+		return REFTABLE_API_ERROR;
+	}
+
+	while (true) {
+		struct table_iter next = { 0 };
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
+static int table_iter_next_void(void *ti, struct record rec)
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
+	if (err != 0) {
+		return err;
+	}
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
+			      struct record want)
+{
+	struct record rec = new_record(record_type(want));
+	struct slice want_key = { 0 };
+	struct slice got_key = { 0 };
+	struct table_iter next = { 0 };
+	int err = -1;
+	record_key(want, &want_key);
+
+	while (true) {
+		err = table_iter_next_block(&next, ti);
+		if (err < 0) {
+			goto exit;
+		}
+
+		if (err > 0) {
+			break;
+		}
+
+		err = block_reader_first_key(next.bi.br, &got_key);
+		if (err < 0) {
+			goto exit;
+		}
+		{
+			int cmp = slice_compare(got_key, want_key);
+			if (cmp > 0) {
+				table_iter_block_done(&next);
+				break;
+			}
+		}
+
+		table_iter_block_done(ti);
+		table_iter_copy_from(ti, &next);
+	}
+
+	err = block_iter_seek(&ti->bi, want_key);
+	if (err < 0) {
+		goto exit;
+	}
+	err = 0;
+
+exit:
+	block_iter_close(&next.bi);
+	record_destroy(&rec);
+	slice_clear(&want_key);
+	slice_clear(&got_key);
+	return err;
+}
+
+static int reader_seek_indexed(struct reftable_reader *r,
+			       struct reftable_iterator *it, struct record rec)
+{
+	struct index_record want_index = { 0 };
+	struct record want_index_rec = { 0 };
+	struct index_record index_result = { 0 };
+	struct record index_result_rec = { 0 };
+	struct table_iter index_iter = { 0 };
+	struct table_iter next = { 0 };
+	int err = 0;
+
+	record_key(rec, &want_index.last_key);
+	record_from_index(&want_index_rec, &want_index);
+	record_from_index(&index_result_rec, &index_result);
+
+	err = reader_start(r, &index_iter, record_type(rec), true);
+	if (err < 0) {
+		goto exit;
+	}
+
+	err = reader_seek_linear(r, &index_iter, want_index_rec);
+	while (true) {
+		err = table_iter_next(&index_iter, index_result_rec);
+		table_iter_block_done(&index_iter);
+		if (err != 0) {
+			goto exit;
+		}
+
+		err = reader_table_iter_at(r, &next, index_result.offset, 0);
+		if (err != 0) {
+			goto exit;
+		}
+
+		err = block_iter_seek(&next.bi, want_index.last_key);
+		if (err < 0) {
+			goto exit;
+		}
+
+		if (next.typ == record_type(rec)) {
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
+		struct table_iter *malloced =
+			reftable_calloc(sizeof(struct table_iter));
+		table_iter_copy_from(malloced, &next);
+		iterator_from_table_iter(it, malloced);
+	}
+exit:
+	block_iter_close(&next.bi);
+	table_iter_close(&index_iter);
+	record_clear(want_index_rec);
+	record_clear(index_result_rec);
+	return err;
+}
+
+static int reader_seek_internal(struct reftable_reader *r,
+				struct reftable_iterator *it, struct record rec)
+{
+	struct reftable_reader_offsets *offs =
+		reader_offsets_for(r, record_type(rec));
+	uint64_t idx = offs->index_offset;
+	struct table_iter ti = { 0 };
+	int err = 0;
+	if (idx > 0) {
+		return reader_seek_indexed(r, it, rec);
+	}
+
+	err = reader_start(r, &ti, record_type(rec), false);
+	if (err < 0) {
+		return err;
+	}
+	err = reader_seek_linear(r, &ti, rec);
+	if (err < 0) {
+		return err;
+	}
+
+	{
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
+		struct record rec)
+{
+	byte typ = record_type(rec);
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
+	struct record rec = { 0 };
+	record_from_ref(&rec, &ref);
+	return reader_seek(r, it, rec);
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
+	struct record rec = { 0 };
+	record_from_log(&rec, &log);
+	return reader_seek(r, it, rec);
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
+			struct reftable_block_source src, char const *name)
+{
+	struct reftable_reader *rd =
+		reftable_calloc(sizeof(struct reftable_reader));
+	int err = init_reader(rd, src, name);
+	if (err == 0) {
+		*p = rd;
+	} else {
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
+	struct obj_record want = {
+		.hash_prefix = oid,
+		.hash_prefix_len = r->object_id_len,
+	};
+	struct record want_rec = { 0 };
+	struct reftable_iterator oit = { 0 };
+	struct obj_record got = { 0 };
+	struct record got_rec = { 0 };
+	int err = 0;
+
+	record_from_obj(&want_rec, &want);
+
+	err = reader_seek(r, &oit, want_rec);
+	if (err != 0) {
+		return err;
+	}
+
+	record_from_obj(&got_rec, &got);
+	err = iterator_next(oit, got_rec);
+	reftable_iterator_destroy(&oit);
+	if (err < 0) {
+		return err;
+	}
+
+	if (err > 0 ||
+	    memcmp(want.hash_prefix, got.hash_prefix, r->object_id_len)) {
+		iterator_set_empty(it);
+		return 0;
+	}
+
+	{
+		struct indexed_table_ref_iter *itr = NULL;
+		err = new_indexed_table_ref_iter(&itr, r, oid,
+						 hash_size(r->hash_id),
+						 got.offsets, got.offset_len);
+		if (err < 0) {
+			record_clear(got_rec);
+			return err;
+		}
+		got.offsets = NULL;
+		record_clear(got_rec);
+
+		iterator_from_indexed_table_ref_iter(it, itr);
+	}
+
+	return 0;
+}
+
+static int reftable_reader_refs_for_unindexed(struct reftable_reader *r,
+					      struct reftable_iterator *it,
+					      byte *oid, int oid_len)
+{
+	struct table_iter *ti = reftable_calloc(sizeof(struct table_iter));
+	struct filtering_ref_iterator *filter = NULL;
+	int err = reader_start(r, ti, BLOCK_TYPE_REF, false);
+	if (err < 0) {
+		reftable_free(ti);
+		return err;
+	}
+
+	filter = reftable_calloc(sizeof(struct filtering_ref_iterator));
+	slice_resize(&filter->oid, oid_len);
+	memcpy(filter->oid.buf, oid, oid_len);
+	filter->r = r;
+	filter->double_check = false;
+	iterator_from_table_iter(&filter->it, ti);
+
+	iterator_from_filtering_ref_iterator(it, filter);
+	return 0;
+}
+
+int reftable_reader_refs_for(struct reftable_reader *r,
+			     struct reftable_iterator *it, byte *oid,
+			     int oid_len)
+{
+	if (r->obj_offsets.present) {
+		return reftable_reader_refs_for_indexed(r, it, oid);
+	}
+	return reftable_reader_refs_for_unindexed(r, it, oid, oid_len);
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
index 00000000000..80d8a5adbaa
--- /dev/null
+++ b/reftable/reader.h
@@ -0,0 +1,68 @@
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
+uint64_t block_source_size(struct reftable_block_source source);
+
+int block_source_read_block(struct reftable_block_source source,
+			    struct reftable_block *dest, uint64_t off,
+			    uint32_t size);
+void block_source_return_block(struct reftable_block_source source,
+			       struct reftable_block *ret);
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
+int init_reader(struct reftable_reader *r, struct reftable_block_source source,
+		const char *name);
+int reader_seek(struct reftable_reader *r, struct reftable_iterator *it,
+		struct record rec);
+void reader_close(struct reftable_reader *r);
+const char *reader_name(struct reftable_reader *r);
+void reader_return_block(struct reftable_reader *r, struct reftable_block *p);
+
+/* initialize a block reader to read from `r` */
+int reader_init_block_reader(struct reftable_reader *r, struct block_reader *br,
+			     uint64_t next_off, byte want_typ);
+
+#endif
diff --git a/reftable/record.c b/reftable/record.c
new file mode 100644
index 00000000000..b0f18f26c55
--- /dev/null
+++ b/reftable/record.c
@@ -0,0 +1,1126 @@
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
+int get_var_int(uint64_t *dest, struct slice in)
+{
+	int ptr = 0;
+	uint64_t val;
+
+	if (in.len == 0) {
+		return -1;
+	}
+	val = in.buf[ptr] & 0x7f;
+
+	while (in.buf[ptr] & 0x80) {
+		ptr++;
+		if (ptr > in.len) {
+			return -1;
+		}
+		val = (val + 1) << 7 | (uint64_t)(in.buf[ptr] & 0x7f);
+	}
+
+	*dest = val;
+	return ptr + 1;
+}
+
+int put_var_int(struct slice dest, uint64_t val)
+{
+	byte buf[10] = { 0 };
+	int i = 9;
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
+	{
+		int n = sizeof(buf) - i - 1;
+		if (dest.len < n) {
+			return -1;
+		}
+		memcpy(dest.buf, &buf[i + 1], n);
+		return n;
+	}
+}
+
+int is_block_type(byte typ)
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
+	int n = get_var_int(&tsize, in);
+	if (n <= 0) {
+		return -1;
+	}
+	slice_consume(&in, n);
+	if (in.len < tsize) {
+		return -1;
+	}
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
+	int n = put_var_int(s, l);
+	if (n < 0) {
+		return -1;
+	}
+	slice_consume(&s, n);
+	if (s.len < l) {
+		return -1;
+	}
+	memcpy(s.buf, str, l);
+	slice_consume(&s, l);
+
+	return start.len - s.len;
+}
+
+int encode_key(bool *restart, struct slice dest, struct slice prev_key,
+	       struct slice key, byte extra)
+{
+	struct slice start = dest;
+	int prefix_len = common_prefix_size(prev_key, key);
+	uint64_t suffix_len = key.len - prefix_len;
+	int n = put_var_int(dest, (uint64_t)prefix_len);
+	if (n < 0) {
+		return -1;
+	}
+	slice_consume(&dest, n);
+
+	*restart = (prefix_len == 0);
+
+	n = put_var_int(dest, suffix_len << 3 | (uint64_t)extra);
+	if (n < 0) {
+		return -1;
+	}
+	slice_consume(&dest, n);
+
+	if (dest.len < suffix_len) {
+		return -1;
+	}
+	memcpy(dest.buf, key.buf + prefix_len, suffix_len);
+	slice_consume(&dest, suffix_len);
+
+	return start.len - dest.len;
+}
+
+int decode_key(struct slice *key, byte *extra, struct slice last_key,
+	       struct slice in)
+{
+	int start_len = in.len;
+	uint64_t prefix_len = 0;
+	uint64_t suffix_len = 0;
+	int n = get_var_int(&prefix_len, in);
+	if (n < 0) {
+		return -1;
+	}
+	slice_consume(&in, n);
+
+	if (prefix_len > last_key.len) {
+		return -1;
+	}
+
+	n = get_var_int(&suffix_len, in);
+	if (n <= 0) {
+		return -1;
+	}
+	slice_consume(&in, n);
+
+	*extra = (byte)(suffix_len & 0x7);
+	suffix_len >>= 3;
+
+	if (in.len < suffix_len) {
+		return -1;
+	}
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
+	if (c <= 9) {
+		return '0' + c;
+	}
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
+	} else if (r->target != NULL) {
+		return 3;
+	}
+	return 0;
+}
+
+static int reftable_ref_record_encode(const void *rec, struct slice s,
+				      int hash_size)
+{
+	const struct reftable_ref_record *r =
+		(const struct reftable_ref_record *)rec;
+	struct slice start = s;
+	int n = put_var_int(s, r->update_index);
+	assert(hash_size > 0);
+	if (n < 0) {
+		return -1;
+	}
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
+	int n = get_var_int(&r->update_index, in);
+	if (n < 0) {
+		return n;
+	}
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
+		struct slice dest = { 0 };
+		int n = decode_string(&dest, in);
+		if (n < 0) {
+			return -1;
+		}
+		slice_consume(&in, n);
+		seen_target = true;
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
+struct record_vtable reftable_ref_record_vtable = {
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
+static void obj_record_key(const void *r, struct slice *dest)
+{
+	const struct obj_record *rec = (const struct obj_record *)r;
+	slice_resize(dest, rec->hash_prefix_len);
+	memcpy(dest->buf, rec->hash_prefix, rec->hash_prefix_len);
+}
+
+static void obj_record_copy_from(void *rec, const void *src_rec, int hash_size)
+{
+	struct obj_record *ref = (struct obj_record *)rec;
+	const struct obj_record *src = (const struct obj_record *)src_rec;
+
+	*ref = *src;
+	ref->hash_prefix = reftable_malloc(ref->hash_prefix_len);
+	memcpy(ref->hash_prefix, src->hash_prefix, ref->hash_prefix_len);
+
+	{
+		int olen = ref->offset_len * sizeof(uint64_t);
+		ref->offsets = reftable_malloc(olen);
+		memcpy(ref->offsets, src->offsets, olen);
+	}
+}
+
+static void obj_record_clear(void *rec)
+{
+	struct obj_record *ref = (struct obj_record *)rec;
+	FREE_AND_NULL(ref->hash_prefix);
+	FREE_AND_NULL(ref->offsets);
+	memset(ref, 0, sizeof(struct obj_record));
+}
+
+static byte obj_record_val_type(const void *rec)
+{
+	struct obj_record *r = (struct obj_record *)rec;
+	if (r->offset_len > 0 && r->offset_len < 8) {
+		return r->offset_len;
+	}
+	return 0;
+}
+
+static int obj_record_encode(const void *rec, struct slice s, int hash_size)
+{
+	struct obj_record *r = (struct obj_record *)rec;
+	struct slice start = s;
+	int n = 0;
+	if (r->offset_len == 0 || r->offset_len >= 8) {
+		n = put_var_int(s, r->offset_len);
+		if (n < 0) {
+			return -1;
+		}
+		slice_consume(&s, n);
+	}
+	if (r->offset_len == 0) {
+		return start.len - s.len;
+	}
+	n = put_var_int(s, r->offsets[0]);
+	if (n < 0) {
+		return -1;
+	}
+	slice_consume(&s, n);
+
+	{
+		uint64_t last = r->offsets[0];
+		int i = 0;
+		for (i = 1; i < r->offset_len; i++) {
+			int n = put_var_int(s, r->offsets[i] - last);
+			if (n < 0) {
+				return -1;
+			}
+			slice_consume(&s, n);
+			last = r->offsets[i];
+		}
+	}
+	return start.len - s.len;
+}
+
+static int obj_record_decode(void *rec, struct slice key, byte val_type,
+			     struct slice in, int hash_size)
+{
+	struct slice start = in;
+	struct obj_record *r = (struct obj_record *)rec;
+	uint64_t count = val_type;
+	int n = 0;
+	r->hash_prefix = reftable_malloc(key.len);
+	memcpy(r->hash_prefix, key.buf, key.len);
+	r->hash_prefix_len = key.len;
+
+	if (val_type == 0) {
+		n = get_var_int(&count, in);
+		if (n < 0) {
+			return n;
+		}
+
+		slice_consume(&in, n);
+	}
+
+	r->offsets = NULL;
+	r->offset_len = 0;
+	if (count == 0) {
+		return start.len - in.len;
+	}
+
+	r->offsets = reftable_malloc(count * sizeof(uint64_t));
+	r->offset_len = count;
+
+	n = get_var_int(&r->offsets[0], in);
+	if (n < 0) {
+		return n;
+	}
+	slice_consume(&in, n);
+
+	{
+		uint64_t last = r->offsets[0];
+		int j = 1;
+		while (j < count) {
+			uint64_t delta = 0;
+			int n = get_var_int(&delta, in);
+			if (n < 0) {
+				return n;
+			}
+			slice_consume(&in, n);
+
+			last = r->offsets[j] = (delta + last);
+			j++;
+		}
+	}
+	return start.len - in.len;
+}
+
+static bool not_a_deletion(const void *p)
+{
+	return false;
+}
+
+struct record_vtable obj_record_vtable = {
+	.key = &obj_record_key,
+	.type = BLOCK_TYPE_OBJ,
+	.copy_from = &obj_record_copy_from,
+	.val_type = &obj_record_val_type,
+	.encode = &obj_record_encode,
+	.decode = &obj_record_decode,
+	.clear = &obj_record_clear,
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
+	if (reftable_log_record_is_deletion(r)) {
+		return 0;
+	}
+
+	if (oldh == NULL) {
+		oldh = zero;
+	}
+	if (newh == NULL) {
+		newh = zero;
+	}
+
+	if (s.len < 2 * hash_size) {
+		return -1;
+	}
+
+	memcpy(s.buf, oldh, hash_size);
+	memcpy(s.buf + hash_size, newh, hash_size);
+	slice_consume(&s, 2 * hash_size);
+
+	n = encode_string(r->name ? r->name : "", s);
+	if (n < 0) {
+		return -1;
+	}
+	slice_consume(&s, n);
+
+	n = encode_string(r->email ? r->email : "", s);
+	if (n < 0) {
+		return -1;
+	}
+	slice_consume(&s, n);
+
+	n = put_var_int(s, r->time);
+	if (n < 0) {
+		return -1;
+	}
+	slice_consume(&s, n);
+
+	if (s.len < 2) {
+		return -1;
+	}
+
+	put_be16(s.buf, r->tz_offset);
+	slice_consume(&s, 2);
+
+	n = encode_string(r->message ? r->message : "", s);
+	if (n < 0) {
+		return -1;
+	}
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
+	struct slice dest = { 0 };
+	int n;
+
+	if (key.len <= 9 || key.buf[key.len - 9] != 0) {
+		return REFTABLE_FORMAT_ERROR;
+	}
+
+	r->ref_name = reftable_realloc(r->ref_name, key.len - 8);
+	memcpy(r->ref_name, key.buf, key.len - 8);
+	ts = get_be64(key.buf + key.len - 8);
+
+	r->update_index = (~max) - ts;
+
+	if (val_type == 0) {
+		return 0;
+	}
+
+	if (in.len < 2 * hash_size) {
+		return REFTABLE_FORMAT_ERROR;
+	}
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
+	if (n < 0) {
+		goto error;
+	}
+	slice_consume(&in, n);
+
+	r->name = reftable_realloc(r->name, dest.len + 1);
+	memcpy(r->name, dest.buf, dest.len);
+	r->name[dest.len] = 0;
+
+	slice_resize(&dest, 0);
+	n = decode_string(&dest, in);
+	if (n < 0) {
+		goto error;
+	}
+	slice_consume(&in, n);
+
+	r->email = reftable_realloc(r->email, dest.len + 1);
+	memcpy(r->email, dest.buf, dest.len);
+	r->email[dest.len] = 0;
+
+	ts = 0;
+	n = get_var_int(&ts, in);
+	if (n < 0) {
+		goto error;
+	}
+	slice_consume(&in, n);
+	r->time = ts;
+	if (in.len < 2) {
+		goto error;
+	}
+
+	r->tz_offset = get_be16(in.buf);
+	slice_consume(&in, 2);
+
+	slice_resize(&dest, 0);
+	n = decode_string(&dest, in);
+	if (n < 0) {
+		goto error;
+	}
+	slice_consume(&in, n);
+
+	r->message = reftable_realloc(r->message, dest.len + 1);
+	memcpy(r->message, dest.buf, dest.len);
+	r->message[dest.len] = 0;
+
+	return start.len - in.len;
+
+error:
+	slice_clear(&dest);
+	return REFTABLE_FORMAT_ERROR;
+}
+
+static bool null_streq(char *a, char *b)
+{
+	char *empty = "";
+	if (a == NULL) {
+		a = empty;
+	}
+	if (b == NULL) {
+		b = empty;
+	}
+	return 0 == strcmp(a, b);
+}
+
+static bool zero_hash_eq(byte *a, byte *b, int sz)
+{
+	if (a == NULL) {
+		a = zero;
+	}
+	if (b == NULL) {
+		b = zero;
+	}
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
+struct record_vtable reftable_log_record_vtable = {
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
+struct record new_record(byte typ)
+{
+	struct record rec;
+	switch (typ) {
+	case BLOCK_TYPE_REF: {
+		struct reftable_ref_record *r =
+			reftable_calloc(sizeof(struct reftable_ref_record));
+		record_from_ref(&rec, r);
+		return rec;
+	}
+
+	case BLOCK_TYPE_OBJ: {
+		struct obj_record *r =
+			reftable_calloc(sizeof(struct obj_record));
+		record_from_obj(&rec, r);
+		return rec;
+	}
+	case BLOCK_TYPE_LOG: {
+		struct reftable_log_record *r =
+			reftable_calloc(sizeof(struct reftable_log_record));
+		record_from_log(&rec, r);
+		return rec;
+	}
+	case BLOCK_TYPE_INDEX: {
+		struct index_record *r =
+			reftable_calloc(sizeof(struct index_record));
+		record_from_index(&rec, r);
+		return rec;
+	}
+	}
+	abort();
+	return rec;
+}
+
+void *record_yield(struct record *rec)
+{
+	void *p = rec->data;
+	rec->data = NULL;
+	return p;
+}
+
+void record_destroy(struct record *rec)
+{
+	record_clear(*rec);
+	reftable_free(record_yield(rec));
+}
+
+static void index_record_key(const void *r, struct slice *dest)
+{
+	struct index_record *rec = (struct index_record *)r;
+	slice_copy(dest, rec->last_key);
+}
+
+static void index_record_copy_from(void *rec, const void *src_rec,
+				   int hash_size)
+{
+	struct index_record *dst = (struct index_record *)rec;
+	struct index_record *src = (struct index_record *)src_rec;
+
+	slice_copy(&dst->last_key, src->last_key);
+	dst->offset = src->offset;
+}
+
+static void index_record_clear(void *rec)
+{
+	struct index_record *idx = (struct index_record *)rec;
+	slice_clear(&idx->last_key);
+}
+
+static byte index_record_val_type(const void *rec)
+{
+	return 0;
+}
+
+static int index_record_encode(const void *rec, struct slice out, int hash_size)
+{
+	const struct index_record *r = (const struct index_record *)rec;
+	struct slice start = out;
+
+	int n = put_var_int(out, r->offset);
+	if (n < 0) {
+		return n;
+	}
+
+	slice_consume(&out, n);
+
+	return start.len - out.len;
+}
+
+static int index_record_decode(void *rec, struct slice key, byte val_type,
+			       struct slice in, int hash_size)
+{
+	struct slice start = in;
+	struct index_record *r = (struct index_record *)rec;
+	int n = 0;
+
+	slice_copy(&r->last_key, key);
+
+	n = get_var_int(&r->offset, in);
+	if (n < 0) {
+		return n;
+	}
+
+	slice_consume(&in, n);
+	return start.len - in.len;
+}
+
+struct record_vtable index_record_vtable = {
+	.key = &index_record_key,
+	.type = BLOCK_TYPE_INDEX,
+	.copy_from = &index_record_copy_from,
+	.val_type = &index_record_val_type,
+	.encode = &index_record_encode,
+	.decode = &index_record_decode,
+	.clear = &index_record_clear,
+	.is_deletion = &not_a_deletion,
+};
+
+void record_key(struct record rec, struct slice *dest)
+{
+	rec.ops->key(rec.data, dest);
+}
+
+byte record_type(struct record rec)
+{
+	return rec.ops->type;
+}
+
+int record_encode(struct record rec, struct slice dest, int hash_size)
+{
+	return rec.ops->encode(rec.data, dest, hash_size);
+}
+
+void record_copy_from(struct record rec, struct record src, int hash_size)
+{
+	assert(src.ops->type == rec.ops->type);
+
+	rec.ops->copy_from(rec.data, src.data, hash_size);
+}
+
+byte record_val_type(struct record rec)
+{
+	return rec.ops->val_type(rec.data);
+}
+
+int record_decode(struct record rec, struct slice key, byte extra,
+		  struct slice src, int hash_size)
+{
+	return rec.ops->decode(rec.data, key, extra, src, hash_size);
+}
+
+void record_clear(struct record rec)
+{
+	return rec.ops->clear(rec.data);
+}
+
+bool record_is_deletion(struct record rec)
+{
+	return rec.ops->is_deletion(rec.data);
+}
+
+void record_from_ref(struct record *rec, struct reftable_ref_record *ref_rec)
+{
+	rec->data = ref_rec;
+	rec->ops = &reftable_ref_record_vtable;
+}
+
+void record_from_obj(struct record *rec, struct obj_record *obj_rec)
+{
+	rec->data = obj_rec;
+	rec->ops = &obj_record_vtable;
+}
+
+void record_from_index(struct record *rec, struct index_record *index_rec)
+{
+	rec->data = index_rec;
+	rec->ops = &index_record_vtable;
+}
+
+void record_from_log(struct record *rec, struct reftable_log_record *log_rec)
+{
+	rec->data = log_rec;
+	rec->ops = &reftable_log_record_vtable;
+}
+
+struct reftable_ref_record *record_as_ref(struct record rec)
+{
+	assert(record_type(rec) == BLOCK_TYPE_REF);
+	return (struct reftable_ref_record *)rec.data;
+}
+
+struct reftable_log_record *record_as_log(struct record rec)
+{
+	assert(record_type(rec) == BLOCK_TYPE_LOG);
+	return (struct reftable_log_record *)rec.data;
+}
+
+static bool hash_equal(byte *a, byte *b, int hash_size)
+{
+	if (a != NULL && b != NULL) {
+		return !memcmp(a, b, hash_size);
+	}
+
+	return a == b;
+}
+
+static bool str_equal(char *a, char *b)
+{
+	if (a != NULL && b != NULL) {
+		return 0 == strcmp(a, b);
+	}
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
+	if (cmp) {
+		return cmp;
+	}
+	if (la->update_index > lb->update_index) {
+		return -1;
+	}
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
index 00000000000..011d9bc56fc
--- /dev/null
+++ b/reftable/record.h
@@ -0,0 +1,121 @@
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
+int get_var_int(uint64_t *dest, struct slice in);
+int put_var_int(struct slice dest, uint64_t val);
+
+/* Methods for records. */
+struct record_vtable {
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
+struct record {
+	void *data;
+	struct record_vtable *ops;
+};
+
+/* returns true for recognized block types. Block start with the block type. */
+int is_block_type(byte typ);
+
+/* creates a malloced record of the given type. Dispose with record_destroy */
+struct record new_record(byte typ);
+
+extern struct record_vtable reftable_ref_record_vtable;
+
+/* Encode `key` into `dest`. Sets `restart` to indicate a restart. Returns
+   number of bytes written. */
+int encode_key(bool *restart, struct slice dest, struct slice prev_key,
+	       struct slice key, byte extra);
+
+/* Decode into `key` and `extra` from `in` */
+int decode_key(struct slice *key, byte *extra, struct slice last_key,
+	       struct slice in);
+
+/* index_record are used internally to speed up lookups. */
+struct index_record {
+	uint64_t offset; /* Offset of block */
+	struct slice last_key; /* Last key of the block. */
+};
+
+/* obj_record stores an object ID => ref mapping. */
+struct obj_record {
+	byte *hash_prefix; /* leading bytes of the object ID */
+	int hash_prefix_len; /* number of leading bytes. Constant
+			      * across a single table. */
+	uint64_t *offsets; /* a vector of file offsets. */
+	int offset_len;
+};
+
+/* see struct record_vtable */
+
+void record_key(struct record rec, struct slice *dest);
+byte record_type(struct record rec);
+void record_copy_from(struct record rec, struct record src, int hash_size);
+byte record_val_type(struct record rec);
+int record_encode(struct record rec, struct slice dest, int hash_size);
+int record_decode(struct record rec, struct slice key, byte extra,
+		  struct slice src, int hash_size);
+bool record_is_deletion(struct record rec);
+
+/* zeroes out the embedded record */
+void record_clear(struct record rec);
+
+/* clear out the record, yielding the record data that was encapsulated. */
+void *record_yield(struct record *rec);
+
+/* clear and deallocate embedded record, and zero `rec`. */
+void record_destroy(struct record *rec);
+
+/* initialize generic records from concrete records. The generic record should
+ * be zeroed out. */
+void record_from_obj(struct record *rec, struct obj_record *objrec);
+void record_from_index(struct record *rec, struct index_record *idxrec);
+void record_from_ref(struct record *rec, struct reftable_ref_record *refrec);
+void record_from_log(struct record *rec, struct reftable_log_record *logrec);
+struct reftable_ref_record *record_as_ref(struct record ref);
+struct reftable_log_record *record_as_log(struct record ref);
+
+/* for qsort. */
+int reftable_ref_record_compare_name(const void *a, const void *b);
+
+/* for qsort. */
+int reftable_log_record_compare_key(const void *a, const void *b);
+
+#endif
diff --git a/reftable/reftable.h b/reftable/reftable.h
new file mode 100644
index 00000000000..318b15af717
--- /dev/null
+++ b/reftable/reftable.h
@@ -0,0 +1,527 @@
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
+reftable_new_writer(int (*writer_func)(void *, uint8_t *, int),
+		    void *writer_arg, struct reftable_write_options *opts);
+
+/* write to a file descriptor. fdp should be an int* pointing to the fd. */
+int reftable_fd_write(void *fdp, uint8_t *data, int size);
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
+int reftable_iterator_next_ref(struct reftable_iterator it,
+			       struct reftable_ref_record *ref);
+
+/* reads the next reftable_log_record. Returns < 0 for error, 0 for OK and > 0:
+   end of iteration.
+*/
+int reftable_iterator_next_log(struct reftable_iterator it,
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
+ * code and sets pp.  The name is used for creating a
+ * stack. Typically, it is the basename of the file.
+ */
+int reftable_new_reader(struct reftable_reader **pp,
+			struct reftable_block_source, const char *name);
+
+/* reftable_reader_seek_ref returns an iterator where 'name' would be inserted
+   in the table.  To seek to the start of the table, use name = "".
+
+   example:
+
+   struct reftable_reader *r = NULL;
+   int err = reftable_new_reader(&r, src, "filename");
+   if (err < 0) { ... }
+   struct reftable_iterator it  = {0};
+   err = reftable_reader_seek_ref(r, &it, "refs/heads/master");
+   if (err < 0) { ... }
+   struct reftable_ref_record ref  = {0};
+   while (1) {
+     err = reftable_iterator_next_ref(it, &ref);
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
+/* return an iterator for the refs pointing to oid */
+int reftable_reader_refs_for(struct reftable_reader *r,
+			     struct reftable_iterator *it, uint8_t *oid,
+			     int oid_len);
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
+/* Release all non-committed data from the transaction; releases the lock if
+ * held. */
+void reftable_addition_close(struct reftable_addition *add);
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
+/* reloads the stack if necessary. */
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
+	int attempts; /* how often we tried to compact */
+	int failures; /* failures happen on concurrent updates */
+};
+
+/* return statistics for compaction up till now. */
+struct reftable_compaction_stats *
+reftable_stack_compaction_stats(struct reftable_stack *st);
+
+#endif
diff --git a/reftable/slice.c b/reftable/slice.c
new file mode 100644
index 00000000000..f3f190c3918
--- /dev/null
+++ b/reftable/slice.c
@@ -0,0 +1,224 @@
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
+void slice_set_string(struct slice *s, const char *str)
+{
+	if (str == NULL) {
+		s->len = 0;
+		return;
+	}
+
+	{
+		int l = strlen(str);
+		l++; /* \0 */
+		slice_resize(s, l);
+		memcpy(s->buf, str, l);
+		s->len = l - 1;
+	}
+}
+
+void slice_resize(struct slice *s, int l)
+{
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
+void slice_append_string(struct slice *d, const char *s)
+{
+	int l1 = d->len;
+	int l2 = strlen(s);
+
+	slice_resize(d, l2 + l1);
+	memcpy(d->buf + l1, s, l2);
+}
+
+void slice_append(struct slice *s, struct slice a)
+{
+	int end = s->len;
+	slice_resize(s, s->len + a.len);
+	memcpy(s->buf + end, a.buf, a.len);
+}
+
+void slice_consume(struct slice *s, int n)
+{
+	s->buf += n;
+	s->len -= n;
+}
+
+byte *slice_yield(struct slice *s)
+{
+	byte *p = s->buf;
+	s->buf = NULL;
+	s->cap = 0;
+	s->len = 0;
+	return p;
+}
+
+void slice_clear(struct slice *s)
+{
+	reftable_free(slice_yield(s));
+}
+
+void slice_copy(struct slice *dest, struct slice src)
+{
+	slice_resize(dest, src.len);
+	memcpy(dest->buf, src.buf, src.len);
+}
+
+/* return the underlying data as char*. len is left unchanged, but
+   a \0 is added at the end. */
+const char *slice_as_string(struct slice *s)
+{
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
+char *slice_to_string(struct slice in)
+{
+	struct slice s = { 0 };
+	slice_resize(&s, in.len + 1);
+	s.buf[in.len] = 0;
+	memcpy(s.buf, in.buf, in.len);
+	return (char *)slice_yield(&s);
+}
+
+bool slice_equal(struct slice a, struct slice b)
+{
+	if (a.len != b.len) {
+		return 0;
+	}
+	return memcmp(a.buf, b.buf, a.len) == 0;
+}
+
+int slice_compare(struct slice a, struct slice b)
+{
+	int min = a.len < b.len ? a.len : b.len;
+	int res = memcmp(a.buf, b.buf, min);
+	if (res != 0) {
+		return res;
+	}
+	if (a.len < b.len) {
+		return -1;
+	} else if (a.len > b.len) {
+		return 1;
+	} else {
+		return 0;
+	}
+}
+
+int slice_write(struct slice *b, byte *data, int sz)
+{
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
+int slice_write_void(void *b, byte *data, int sz)
+{
+	return slice_write((struct slice *)b, data, sz);
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
+int common_prefix_size(struct slice a, struct slice b)
+{
+	int p = 0;
+	while (p < a.len && p < b.len) {
+		if (a.buf[p] != b.buf[p]) {
+			break;
+		}
+		p++;
+	}
+
+	return p;
+}
diff --git a/reftable/slice.h b/reftable/slice.h
new file mode 100644
index 00000000000..d7e0603d346
--- /dev/null
+++ b/reftable/slice.h
@@ -0,0 +1,76 @@
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
+};
+
+void slice_set_string(struct slice *dest, const char *src);
+void slice_append_string(struct slice *dest, const char *src);
+/* Set length to 0, but retain buffer */
+void slice_clear(struct slice *slice);
+
+/* Return a malloced string for `src` */
+char *slice_to_string(struct slice src);
+
+/* Ensure that `buf` is \0 terminated. */
+const char *slice_as_string(struct slice *src);
+
+/* Compare slices */
+bool slice_equal(struct slice a, struct slice b);
+
+/* Return `buf`, clearing out `s` */
+byte *slice_yield(struct slice *s);
+
+/* Copy bytes */
+void slice_copy(struct slice *dest, struct slice src);
+
+/* Advance `buf` by `n`, and decrease length. A copy of the slice
+   should be kept for deallocating the slice. */
+void slice_consume(struct slice *s, int n);
+
+/* Set length of the slice to `l` */
+void slice_resize(struct slice *s, int l);
+
+/* Signed comparison */
+int slice_compare(struct slice a, struct slice b);
+
+/* Append `data` to the `dest` slice.  */
+int slice_write(struct slice *dest, byte *data, int sz);
+
+/* Append `add` to `dest. */
+void slice_append(struct slice *dest, struct slice add);
+
+/* Like slice_write, but suitable for passing to reftable_new_writer
+ */
+int slice_write_void(void *b, byte *data, int sz);
+
+/* Find the longest shared prefix size of `a` and `b` */
+int common_prefix_size(struct slice a, struct slice b);
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
diff --git a/reftable/stack.c b/reftable/stack.c
new file mode 100644
index 00000000000..e7b625d924a
--- /dev/null
+++ b/reftable/stack.c
@@ -0,0 +1,1151 @@
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
+#include "reftable.h"
+#include "writer.h"
+
+int reftable_new_stack(struct reftable_stack **dest, const char *dir,
+		       struct reftable_write_options config)
+{
+	struct reftable_stack *p =
+		reftable_calloc(sizeof(struct reftable_stack));
+	struct slice list_file_name = {};
+	int err = 0;
+
+	if (config.hash_id == 0) {
+		config.hash_id = SHA1_ID;
+	}
+
+	*dest = NULL;
+
+	slice_set_string(&list_file_name, dir);
+	slice_append_string(&list_file_name, "/tables.list");
+
+	p->list_file = slice_to_string(list_file_name);
+	slice_clear(&list_file_name);
+	p->reftable_dir = xstrdup(dir);
+	p->config = config;
+
+	err = reftable_stack_reload(p);
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
+		goto exit;
+	}
+	err = lseek(fd, 0, SEEK_SET);
+	if (err < 0) {
+		err = REFTABLE_IO_ERROR;
+		goto exit;
+	}
+
+	buf = reftable_malloc(size + 1);
+	if (read(fd, buf, size) != size) {
+		err = REFTABLE_IO_ERROR;
+		goto exit;
+	}
+	buf[size] = 0;
+
+	parse_names(buf, size, namesp);
+
+exit:
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
+	if (st->merged == NULL) {
+		return;
+	}
+
+	reftable_merged_table_close(st->merged);
+	reftable_merged_table_free(st->merged);
+	st->merged = NULL;
+
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
+
+	struct slice table_path = { 0 };
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
+			slice_append_string(&table_path, "/");
+			slice_append_string(&table_path, name);
+
+			err = reftable_block_source_from_file(
+				&src, slice_as_string(&table_path));
+			if (err < 0) {
+				goto exit;
+			}
+
+			err = reftable_new_reader(&rd, src, name);
+			if (err < 0) {
+				goto exit;
+			}
+		}
+
+		new_tables[new_tables_len++] = rd;
+	}
+
+	/* success! */
+	err = reftable_new_merged_table(&new_merged, new_tables, new_tables_len,
+					st->config.hash_id);
+	if (err < 0) {
+		goto exit;
+	}
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
+	{
+		int i = 0;
+		for (i = 0; i < cur_len; i++) {
+			if (cur[i] != NULL) {
+				reader_close(cur[i]);
+				reftable_reader_free(cur[i]);
+			}
+		}
+	}
+exit:
+	slice_clear(&table_path);
+	{
+		int i = 0;
+		for (i = 0; i < new_tables_len; i++) {
+			reader_close(new_tables[i]);
+		}
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
+	if (diff != 0) {
+		return diff;
+	}
+
+	return udiff;
+}
+
+static int reftable_stack_reload_maybe_reuse(struct reftable_stack *st,
+					     bool reuse_open)
+{
+	struct timeval deadline = { 0 };
+	int err = gettimeofday(&deadline, NULL);
+	int64_t delay = 0;
+	int tries = 0;
+	if (err < 0) {
+		return err;
+	}
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
+		delay = delay + (delay * rand()) / RAND_MAX + 100;
+		usleep(delay);
+	}
+
+	return 0;
+}
+
+int reftable_stack_reload(struct reftable_stack *st)
+{
+	return reftable_stack_reload_maybe_reuse(st, true);
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
+	if (err < 0) {
+		return err;
+	}
+
+	for (i = 0; i < st->merged->stack_len; i++) {
+		if (names[i] == NULL) {
+			err = 1;
+			goto exit;
+		}
+
+		if (strcmp(st->merged->stack[i]->name, names[i])) {
+			err = 1;
+			goto exit;
+		}
+	}
+
+	if (names[st->merged->stack_len] != NULL) {
+		err = 1;
+		goto exit;
+	}
+
+exit:
+	free_names(names);
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
+			// Ignore error return, we want to propagate
+			// REFTABLE_LOCK_ERROR.
+			reftable_stack_reload(st);
+		}
+		return err;
+	}
+
+	if (!st->disable_auto_compact) {
+		return reftable_stack_auto_compact(st);
+	}
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
+static int reftable_stack_init_addition(struct reftable_addition *add,
+					struct reftable_stack *st)
+{
+	int err = 0;
+	add->stack = st;
+
+	slice_set_string(&add->lock_file_name, st->list_file);
+	slice_append_string(&add->lock_file_name, ".lock");
+
+	add->lock_file_fd = open(slice_as_string(&add->lock_file_name),
+				 O_EXCL | O_CREAT | O_WRONLY, 0644);
+	if (add->lock_file_fd < 0) {
+		if (errno == EEXIST) {
+			err = REFTABLE_LOCK_ERROR;
+		} else {
+			err = REFTABLE_IO_ERROR;
+		}
+		goto exit;
+	}
+	err = stack_uptodate(st);
+	if (err < 0) {
+		goto exit;
+	}
+
+	if (err > 1) {
+		err = REFTABLE_LOCK_ERROR;
+		goto exit;
+	}
+
+	add->next_update_index = reftable_stack_next_update_index(st);
+exit:
+	if (err) {
+		reftable_addition_close(add);
+	}
+	return err;
+}
+
+void reftable_addition_close(struct reftable_addition *add)
+{
+	int i = 0;
+	struct slice nm = {};
+	for (i = 0; i < add->new_tables_len; i++) {
+		slice_set_string(&nm, add->stack->list_file);
+		slice_append_string(&nm, "/");
+		slice_append_string(&nm, add->new_tables[i]);
+		unlink(slice_as_string(&nm));
+
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
+		slice_clear(&add->lock_file_name);
+	}
+
+	free_names(add->names);
+	add->names = NULL;
+}
+
+int reftable_addition_commit(struct reftable_addition *add)
+{
+	struct slice table_list = { 0 };
+	int i = 0;
+	int err = 0;
+	if (add->new_tables_len == 0) {
+		goto exit;
+	}
+
+	for (i = 0; i < add->stack->merged->stack_len; i++) {
+		slice_append_string(&table_list,
+				    add->stack->merged->stack[i]->name);
+		slice_append_string(&table_list, "\n");
+	}
+	for (i = 0; i < add->new_tables_len; i++) {
+		slice_append_string(&table_list, add->new_tables[i]);
+		slice_append_string(&table_list, "\n");
+	}
+
+	err = write(add->lock_file_fd, table_list.buf, table_list.len);
+	slice_clear(&table_list);
+	if (err < 0) {
+		err = REFTABLE_IO_ERROR;
+		goto exit;
+	}
+
+	err = close(add->lock_file_fd);
+	add->lock_file_fd = 0;
+	if (err < 0) {
+		err = REFTABLE_IO_ERROR;
+		goto exit;
+	}
+
+	err = rename(slice_as_string(&add->lock_file_name),
+		     add->stack->list_file);
+	if (err < 0) {
+		err = REFTABLE_IO_ERROR;
+		goto exit;
+	}
+
+	err = reftable_stack_reload(add->stack);
+
+exit:
+	reftable_addition_close(add);
+	return err;
+}
+
+int reftable_stack_new_addition(struct reftable_addition **dest,
+				struct reftable_stack *st)
+{
+	int err = 0;
+	*dest = reftable_malloc(sizeof(**dest));
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
+	struct reftable_addition add = { 0 };
+	int err = reftable_stack_init_addition(&add, st);
+	if (err < 0) {
+		goto exit;
+	}
+
+	err = reftable_addition_add(&add, write_table, arg);
+	if (err < 0) {
+		goto exit;
+	}
+
+	err = reftable_addition_commit(&add);
+exit:
+	reftable_addition_close(&add);
+	return err;
+}
+
+int reftable_addition_add(struct reftable_addition *add,
+			  int (*write_table)(struct reftable_writer *wr,
+					     void *arg),
+			  void *arg)
+{
+	struct slice temp_tab_file_name = { 0 };
+	struct slice tab_file_name = { 0 };
+	struct slice next_name = { 0 };
+	struct reftable_writer *wr = NULL;
+	int err = 0;
+	int tab_fd = 0;
+	uint64_t next_update_index = 0;
+
+	slice_resize(&next_name, 0);
+	format_name(&next_name, next_update_index, next_update_index);
+
+	slice_set_string(&temp_tab_file_name, add->stack->reftable_dir);
+	slice_append_string(&temp_tab_file_name, "/");
+	slice_append(&temp_tab_file_name, next_name);
+	slice_append_string(&temp_tab_file_name, ".temp.XXXXXX");
+
+	tab_fd = mkstemp((char *)slice_as_string(&temp_tab_file_name));
+	if (tab_fd < 0) {
+		err = REFTABLE_IO_ERROR;
+		goto exit;
+	}
+
+	wr = reftable_new_writer(reftable_fd_write, &tab_fd,
+				 &add->stack->config);
+	err = write_table(wr, arg);
+	if (err < 0) {
+		goto exit;
+	}
+
+	err = reftable_writer_close(wr);
+	if (err == REFTABLE_EMPTY_TABLE_ERROR) {
+		err = 0;
+		goto exit;
+	}
+	if (err < 0) {
+		goto exit;
+	}
+
+	err = close(tab_fd);
+	tab_fd = 0;
+	if (err < 0) {
+		err = REFTABLE_IO_ERROR;
+		goto exit;
+	}
+
+	if (wr->min_update_index < next_update_index) {
+		err = REFTABLE_API_ERROR;
+		goto exit;
+	}
+
+	format_name(&next_name, wr->min_update_index, wr->max_update_index);
+	slice_append_string(&next_name, ".ref");
+
+	slice_set_string(&tab_file_name, add->stack->reftable_dir);
+	slice_append_string(&tab_file_name, "/");
+	slice_append(&tab_file_name, next_name);
+
+	err = rename(slice_as_string(&temp_tab_file_name),
+		     slice_as_string(&tab_file_name));
+	if (err < 0) {
+		err = REFTABLE_IO_ERROR;
+		goto exit;
+	}
+
+	add->new_tables = reftable_realloc(add->new_tables,
+					   sizeof(*add->new_tables) *
+						   (add->new_tables_len + 1));
+	add->new_tables[add->new_tables_len] = slice_to_string(next_name);
+	add->new_tables_len++;
+exit:
+	if (tab_fd > 0) {
+		close(tab_fd);
+		tab_fd = 0;
+	}
+	if (temp_tab_file_name.len > 0) {
+		unlink(slice_as_string(&temp_tab_file_name));
+	}
+
+	slice_clear(&temp_tab_file_name);
+	slice_clear(&tab_file_name);
+	slice_clear(&next_name);
+	reftable_writer_free(wr);
+	return err;
+}
+
+uint64_t reftable_stack_next_update_index(struct reftable_stack *st)
+{
+	int sz = st->merged->stack_len;
+	if (sz > 0) {
+		return reftable_reader_max_update_index(
+			       st->merged->stack[sz - 1]) +
+		       1;
+	}
+	return 1;
+}
+
+static int stack_compact_locked(struct reftable_stack *st, int first, int last,
+				struct slice *temp_tab,
+				struct reftable_log_expiry_config *config)
+{
+	struct slice next_name = { 0 };
+	int tab_fd = -1;
+	struct reftable_writer *wr = NULL;
+	int err = 0;
+
+	format_name(&next_name,
+		    reftable_reader_min_update_index(st->merged->stack[first]),
+		    reftable_reader_max_update_index(st->merged->stack[first]));
+
+	slice_set_string(temp_tab, st->reftable_dir);
+	slice_append_string(temp_tab, "/");
+	slice_append(temp_tab, next_name);
+	slice_append_string(temp_tab, ".temp.XXXXXX");
+
+	tab_fd = mkstemp((char *)slice_as_string(temp_tab));
+	wr = reftable_new_writer(reftable_fd_write, &tab_fd, &st->config);
+
+	err = stack_write_compact(st, wr, first, last, config);
+	if (err < 0) {
+		goto exit;
+	}
+	err = reftable_writer_close(wr);
+	if (err < 0) {
+		goto exit;
+	}
+	reftable_writer_free(wr);
+
+	err = close(tab_fd);
+	tab_fd = 0;
+
+exit:
+	if (tab_fd > 0) {
+		close(tab_fd);
+		tab_fd = 0;
+	}
+	if (err != 0 && temp_tab->len > 0) {
+		unlink(slice_as_string(temp_tab));
+		slice_clear(temp_tab);
+	}
+	slice_clear(&next_name);
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
+		goto exit;
+	}
+
+	err = reftable_merged_table_seek_ref(mt, &it, "");
+	if (err < 0) {
+		goto exit;
+	}
+
+	while (true) {
+		err = reftable_iterator_next_ref(it, &ref);
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
+	}
+
+	err = reftable_merged_table_seek_log(mt, &it, "");
+	if (err < 0) {
+		goto exit;
+	}
+
+	while (true) {
+		err = reftable_iterator_next_log(it, &log);
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
+		/* XXX collect stats? */
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
+	}
+
+exit:
+	reftable_iterator_destroy(&it);
+	if (mt != NULL) {
+		merged_table_clear(mt);
+		reftable_merged_table_free(mt);
+	}
+	reftable_ref_record_clear(&ref);
+
+	return err;
+}
+
+/* <  0: error. 0 == OK, > 0 attempt failed; could retry. */
+static int stack_compact_range(struct reftable_stack *st, int first, int last,
+			       struct reftable_log_expiry_config *expiry)
+{
+	struct slice temp_tab_file_name = { 0 };
+	struct slice new_table_name = { 0 };
+	struct slice lock_file_name = { 0 };
+	struct slice ref_list_contents = { 0 };
+	struct slice new_table_path = { 0 };
+	int err = 0;
+	bool have_lock = false;
+	int lock_file_fd = 0;
+	int compact_count = last - first + 1;
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
+		goto exit;
+	}
+
+	st->stats.attempts++;
+
+	slice_set_string(&lock_file_name, st->list_file);
+	slice_append_string(&lock_file_name, ".lock");
+
+	lock_file_fd = open(slice_as_string(&lock_file_name),
+			    O_EXCL | O_CREAT | O_WRONLY, 0644);
+	if (lock_file_fd < 0) {
+		if (errno == EEXIST) {
+			err = 1;
+		} else {
+			err = REFTABLE_IO_ERROR;
+		}
+		goto exit;
+	}
+	have_lock = true;
+	err = stack_uptodate(st);
+	if (err != 0) {
+		goto exit;
+	}
+
+	for (i = first, j = 0; i <= last; i++) {
+		struct slice subtab_file_name = { 0 };
+		struct slice subtab_lock = { 0 };
+		slice_set_string(&subtab_file_name, st->reftable_dir);
+		slice_append_string(&subtab_file_name, "/");
+		slice_append_string(&subtab_file_name,
+				    reader_name(st->merged->stack[i]));
+
+		slice_copy(&subtab_lock, subtab_file_name);
+		slice_append_string(&subtab_lock, ".lock");
+
+		{
+			int sublock_file_fd =
+				open(slice_as_string(&subtab_lock),
+				     O_EXCL | O_CREAT | O_WRONLY, 0644);
+			if (sublock_file_fd > 0) {
+				close(sublock_file_fd);
+			} else if (sublock_file_fd < 0) {
+				if (errno == EEXIST) {
+					err = 1;
+				} else {
+					err = REFTABLE_IO_ERROR;
+				}
+			}
+		}
+
+		subtable_locks[j] = (char *)slice_as_string(&subtab_lock);
+		delete_on_success[j] =
+			(char *)slice_as_string(&subtab_file_name);
+		j++;
+
+		if (err != 0) {
+			goto exit;
+		}
+	}
+
+	err = unlink(slice_as_string(&lock_file_name));
+	if (err < 0) {
+		goto exit;
+	}
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
+	if (err < 0) {
+		goto exit;
+	}
+
+	lock_file_fd = open(slice_as_string(&lock_file_name),
+			    O_EXCL | O_CREAT | O_WRONLY, 0644);
+	if (lock_file_fd < 0) {
+		if (errno == EEXIST) {
+			err = 1;
+		} else {
+			err = REFTABLE_IO_ERROR;
+		}
+		goto exit;
+	}
+	have_lock = true;
+
+	format_name(&new_table_name, st->merged->stack[first]->min_update_index,
+		    st->merged->stack[last]->max_update_index);
+	slice_append_string(&new_table_name, ".ref");
+
+	slice_set_string(&new_table_path, st->reftable_dir);
+	slice_append_string(&new_table_path, "/");
+
+	slice_append(&new_table_path, new_table_name);
+
+	if (!is_empty_table) {
+		err = rename(slice_as_string(&temp_tab_file_name),
+			     slice_as_string(&new_table_path));
+		if (err < 0) {
+			err = REFTABLE_IO_ERROR;
+			goto exit;
+		}
+	}
+
+	for (i = 0; i < first; i++) {
+		slice_append_string(&ref_list_contents,
+				    st->merged->stack[i]->name);
+		slice_append_string(&ref_list_contents, "\n");
+	}
+	if (!is_empty_table) {
+		slice_append(&ref_list_contents, new_table_name);
+		slice_append_string(&ref_list_contents, "\n");
+	}
+	for (i = last + 1; i < st->merged->stack_len; i++) {
+		slice_append_string(&ref_list_contents,
+				    st->merged->stack[i]->name);
+		slice_append_string(&ref_list_contents, "\n");
+	}
+
+	err = write(lock_file_fd, ref_list_contents.buf, ref_list_contents.len);
+	if (err < 0) {
+		err = REFTABLE_IO_ERROR;
+		unlink(slice_as_string(&new_table_path));
+		goto exit;
+	}
+	err = close(lock_file_fd);
+	lock_file_fd = 0;
+	if (err < 0) {
+		err = REFTABLE_IO_ERROR;
+		unlink(slice_as_string(&new_table_path));
+		goto exit;
+	}
+
+	err = rename(slice_as_string(&lock_file_name), st->list_file);
+	if (err < 0) {
+		err = REFTABLE_IO_ERROR;
+		unlink(slice_as_string(&new_table_path));
+		goto exit;
+	}
+	have_lock = false;
+
+	{
+		char **p = delete_on_success;
+		while (*p) {
+			if (strcmp(*p, slice_as_string(&new_table_path))) {
+				unlink(*p);
+			}
+			p++;
+		}
+	}
+
+	err = reftable_stack_reload_maybe_reuse(st, first < last);
+exit:
+	free_names(delete_on_success);
+	{
+		char **p = subtable_locks;
+		while (*p) {
+			unlink(*p);
+			p++;
+		}
+	}
+	free_names(subtable_locks);
+	if (lock_file_fd > 0) {
+		close(lock_file_fd);
+		lock_file_fd = 0;
+	}
+	if (have_lock) {
+		unlink(slice_as_string(&lock_file_name));
+	}
+	slice_clear(&new_table_name);
+	slice_clear(&new_table_path);
+	slice_clear(&ref_list_contents);
+	slice_clear(&temp_tab_file_name);
+	slice_clear(&lock_file_name);
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
+	assert(sz > 0);
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
+	if (next > 0) {
+		segs[next++] = cur;
+	}
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
+	int overhead = footer_size(version) + header_size(version) - 1;
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
+	if (segment_size(&seg) > 0) {
+		return stack_compact_range_stats(st, seg.start, seg.end - 1,
+						 NULL);
+	}
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
+	struct reftable_iterator it = { 0 };
+	struct reftable_merged_table *mt = reftable_stack_merged_table(st);
+	int err = reftable_merged_table_seek_ref(mt, &it, refname);
+	if (err) {
+		goto exit;
+	}
+
+	err = reftable_iterator_next_ref(it, ref);
+	if (err) {
+		goto exit;
+	}
+
+	if (strcmp(ref->ref_name, refname) ||
+	    reftable_ref_record_is_deletion(ref)) {
+		err = 1;
+		goto exit;
+	}
+
+exit:
+	reftable_iterator_destroy(&it);
+	return err;
+}
+
+int reftable_stack_read_log(struct reftable_stack *st, const char *refname,
+			    struct reftable_log_record *log)
+{
+	struct reftable_iterator it = { 0 };
+	struct reftable_merged_table *mt = reftable_stack_merged_table(st);
+	int err = reftable_merged_table_seek_log(mt, &it, refname);
+	if (err) {
+		goto exit;
+	}
+
+	err = reftable_iterator_next_log(it, log);
+	if (err) {
+		goto exit;
+	}
+
+	if (strcmp(log->ref_name, refname) ||
+	    reftable_log_record_is_deletion(log)) {
+		err = 1;
+		goto exit;
+	}
+
+exit:
+	reftable_iterator_destroy(&it);
+	return err;
+}
diff --git a/reftable/stack.h b/reftable/stack.h
new file mode 100644
index 00000000000..26017f1f2d4
--- /dev/null
+++ b/reftable/stack.h
@@ -0,0 +1,44 @@
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
diff --git a/reftable/system.h b/reftable/system.h
new file mode 100644
index 00000000000..99f453bfec8
--- /dev/null
+++ b/reftable/system.h
@@ -0,0 +1,53 @@
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
diff --git a/reftable/tree.c b/reftable/tree.c
new file mode 100644
index 00000000000..0341c865569
--- /dev/null
+++ b/reftable/tree.c
@@ -0,0 +1,67 @@
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
+	{
+		int res = compare(key, (*rootp)->key);
+		if (res < 0) {
+			return tree_search(key, &(*rootp)->left, compare,
+					   insert);
+		} else if (res > 0) {
+			return tree_search(key, &(*rootp)->right, compare,
+					   insert);
+		}
+	}
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
diff --git a/reftable/update.sh b/reftable/update.sh
new file mode 100755
index 00000000000..c37776c573f
--- /dev/null
+++ b/reftable/update.sh
@@ -0,0 +1,23 @@
+#!/bin/sh
+
+set -eu
+
+# Override this to import from somewhere else, say "../reftable".
+SRC=${SRC:-origin} BRANCH=${BRANCH:-origin/master}
+
+((git --git-dir reftable-repo/.git fetch ${SRC} && cd reftable-repo && git checkout ${BRANCH} ) ||
+   git clone https://github.com/google/reftable reftable-repo)
+
+cp reftable-repo/c/*.[ch] reftable/
+cp reftable-repo/c/include/*.[ch] reftable/
+cp reftable-repo/LICENSE reftable/
+git --git-dir reftable-repo/.git show --no-patch origin/master \
+  > reftable/VERSION
+
+mv reftable/system.h reftable/system.h~
+sed 's|if REFTABLE_IN_GITCORE|if 1 /* REFTABLE_IN_GITCORE */|'  < reftable/system.h~ > reftable/system.h
+
+# Remove unittests and compatibility hacks we don't need here.  
+rm reftable/*_test.c reftable/test_framework.* reftable/compat.*
+
+git add reftable/*.[ch] reftable/LICENSE reftable/VERSION 
diff --git a/reftable/writer.c b/reftable/writer.c
new file mode 100644
index 00000000000..123bae75286
--- /dev/null
+++ b/reftable/writer.c
@@ -0,0 +1,661 @@
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
+		if (n < 0) {
+			return n;
+		}
+
+		w->pending_padding = 0;
+		reftable_free(zeroed);
+	}
+
+	w->pending_padding = padding;
+	n = w->write(w->write_arg, data, len);
+	if (n < 0) {
+		return n;
+	}
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
+	block_writer_init(&w->block_writer_data, typ, w->block,
+			  w->opts.block_size, block_start,
+			  hash_size(w->opts.hash_id));
+	w->block_writer = &w->block_writer_data;
+	w->block_writer->restart_interval = w->opts.restart_interval;
+}
+
+struct reftable_writer *
+reftable_new_writer(int (*writer_func)(void *, byte *, int), void *writer_arg,
+		    struct reftable_write_options *opts)
+{
+	struct reftable_writer *wp =
+		reftable_calloc(sizeof(struct reftable_writer));
+	options_set_defaults(opts);
+	if (opts->block_size >= (1 << 24)) {
+		/* TODO - error return? */
+		abort();
+	}
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
+
+static int obj_index_tree_node_compare(const void *a, const void *b)
+{
+	return slice_compare(((const struct obj_index_tree_node *)a)->hash,
+			     ((const struct obj_index_tree_node *)b)->hash);
+}
+
+static void writer_index_hash(struct reftable_writer *w, struct slice hash)
+{
+	uint64_t off = w->next;
+
+	struct obj_index_tree_node want = { .hash = hash };
+
+	struct tree_node *node = tree_search(&want, &w->obj_index_tree,
+					     &obj_index_tree_node_compare, 0);
+	struct obj_index_tree_node *key = NULL;
+	if (node == NULL) {
+		key = reftable_calloc(sizeof(struct obj_index_tree_node));
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
+static int writer_add_record(struct reftable_writer *w, struct record rec)
+{
+	int result = -1;
+	struct slice key = { 0 };
+	int err = 0;
+	record_key(rec, &key);
+	if (slice_compare(w->last_key, key) >= 0) {
+		goto exit;
+	}
+
+	slice_copy(&w->last_key, key);
+	if (w->block_writer == NULL) {
+		writer_reinit_block_writer(w, record_type(rec));
+	}
+
+	assert(block_writer_type(w->block_writer) == record_type(rec));
+
+	if (block_writer_add(w->block_writer, rec) == 0) {
+		result = 0;
+		goto exit;
+	}
+
+	err = writer_flush_block(w);
+	if (err < 0) {
+		result = err;
+		goto exit;
+	}
+
+	writer_reinit_block_writer(w, record_type(rec));
+	err = block_writer_add(w->block_writer, rec);
+	if (err < 0) {
+		result = err;
+		goto exit;
+	}
+
+	result = 0;
+exit:
+	slice_clear(&key);
+	return result;
+}
+
+int reftable_writer_add_ref(struct reftable_writer *w,
+			    struct reftable_ref_record *ref)
+{
+	struct record rec = { 0 };
+	struct reftable_ref_record copy = *ref;
+	int err = 0;
+
+	if (ref->ref_name == NULL) {
+		return REFTABLE_API_ERROR;
+	}
+	if (ref->update_index < w->min_update_index ||
+	    ref->update_index > w->max_update_index) {
+		return REFTABLE_API_ERROR;
+	}
+
+	record_from_ref(&rec, &copy);
+	copy.update_index -= w->min_update_index;
+	err = writer_add_record(w, rec);
+	if (err < 0) {
+		return err;
+	}
+
+	if (!w->opts.skip_index_objects && ref->value != NULL) {
+		struct slice h = {
+			.buf = ref->value,
+			.len = hash_size(w->opts.hash_id),
+		};
+
+		writer_index_hash(w, h);
+	}
+	if (!w->opts.skip_index_objects && ref->target_value != NULL) {
+		struct slice h = {
+			.buf = ref->target_value,
+			.len = hash_size(w->opts.hash_id),
+		};
+		writer_index_hash(w, h);
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
+	if (log->ref_name == NULL) {
+		return REFTABLE_API_ERROR;
+	}
+
+	if (w->block_writer != NULL &&
+	    block_writer_type(w->block_writer) == BLOCK_TYPE_REF) {
+		int err = writer_finish_public_section(w);
+		if (err < 0) {
+			return err;
+		}
+	}
+
+	w->next -= w->pending_padding;
+	w->pending_padding = 0;
+
+	{
+		struct record rec = { 0 };
+		int err;
+		record_from_log(&rec, log);
+		err = writer_add_record(w, rec);
+		return err;
+	}
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
+	if (err < 0) {
+		return err;
+	}
+
+	while (w->index_len > threshold) {
+		struct index_record *idx = NULL;
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
+			struct record rec = { 0 };
+			record_from_index(&rec, idx + i);
+			if (block_writer_add(w->block_writer, rec) == 0) {
+				continue;
+			}
+
+			{
+				int err = writer_flush_block(w);
+				if (err < 0) {
+					return err;
+				}
+			}
+
+			writer_reinit_block_writer(w, BLOCK_TYPE_INDEX);
+
+			err = block_writer_add(w->block_writer, rec);
+			assert(err == 0);
+		}
+		for (i = 0; i < idx_len; i++) {
+			slice_clear(&idx[i].last_key);
+		}
+		reftable_free(idx);
+	}
+
+	writer_clear_index(w);
+
+	err = writer_flush_block(w);
+	if (err < 0) {
+		return err;
+	}
+
+	{
+		struct reftable_block_stats *bstats =
+			writer_reftable_block_stats(w, typ);
+		bstats->index_blocks =
+			w->stats.idx_stats.blocks - before_blocks;
+		bstats->index_offset = index_start;
+		bstats->max_index_level = max_level;
+	}
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
+		int n = common_prefix_size(entry->hash, *arg->last);
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
+	struct obj_record obj_rec = {
+		.hash_prefix = entry->hash.buf,
+		.hash_prefix_len = arg->w->stats.object_id_len,
+		.offsets = entry->offsets,
+		.offset_len = entry->offset_len,
+	};
+	struct record rec = { 0 };
+	if (arg->err < 0) {
+		goto exit;
+	}
+
+	record_from_obj(&rec, &obj_rec);
+	arg->err = block_writer_add(arg->w->block_writer, rec);
+	if (arg->err == 0) {
+		goto exit;
+	}
+
+	arg->err = writer_flush_block(arg->w);
+	if (arg->err < 0) {
+		goto exit;
+	}
+
+	writer_reinit_block_writer(arg->w, BLOCK_TYPE_OBJ);
+	arg->err = block_writer_add(arg->w->block_writer, rec);
+	if (arg->err == 0) {
+		goto exit;
+	}
+	obj_rec.offset_len = 0;
+	arg->err = block_writer_add(arg->w->block_writer, rec);
+
+	/* Should be able to write into a fresh block. */
+	assert(arg->err == 0);
+
+exit:;
+}
+
+static void object_record_free(void *void_arg, void *key)
+{
+	struct obj_index_tree_node *entry = (struct obj_index_tree_node *)key;
+
+	FREE_AND_NULL(entry->offsets);
+	slice_clear(&entry->hash);
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
+	if (closure.err < 0) {
+		return closure.err;
+	}
+	return writer_finish_section(w);
+}
+
+int writer_finish_public_section(struct reftable_writer *w)
+{
+	byte typ = 0;
+	int err = 0;
+
+	if (w->block_writer == NULL) {
+		return 0;
+	}
+
+	typ = block_writer_type(w->block_writer);
+	err = writer_finish_section(w);
+	if (err < 0) {
+		return err;
+	}
+	if (typ == BLOCK_TYPE_REF && !w->opts.skip_index_objects &&
+	    w->stats.ref_stats.index_blocks > 0) {
+		err = writer_dump_object_index(w);
+		if (err < 0) {
+			return err;
+		}
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
+	if (err != 0) {
+		goto exit;
+	}
+	w->pending_padding = 0;
+	if (empty_table) {
+		// Empty tables need a header anyway.
+		byte header[28];
+		int n = writer_write_header(w, header);
+		err = padded_write(w, header, n, 0);
+		if (err < 0) {
+			goto exit;
+		}
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
+	if (err < 0) {
+		goto exit;
+	}
+
+	if (empty_table) {
+		err = REFTABLE_EMPTY_TABLE_ERROR;
+		goto exit;
+	}
+
+exit:
+	/* free up memory. */
+	block_writer_clear(&w->block_writer_data);
+	writer_clear_index(w);
+	slice_clear(&w->last_key);
+	return err;
+}
+
+void writer_clear_index(struct reftable_writer *w)
+{
+	int i = 0;
+	for (i = 0; i < w->index_len; i++) {
+		slice_clear(&w->index[i].last_key);
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
+	if (raw_bytes < 0) {
+		return raw_bytes;
+	}
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
+	if (err < 0) {
+		return err;
+	}
+
+	if (w->index_cap == w->index_len) {
+		w->index_cap = 2 * w->index_cap + 1;
+		w->index = reftable_realloc(
+			w->index, sizeof(struct index_record) * w->index_cap);
+	}
+
+	{
+		struct index_record ir = {
+			.offset = w->next,
+		};
+		slice_copy(&ir.last_key, w->block_writer->last_key);
+		w->index[w->index_len] = ir;
+	}
+
+	w->index_len++;
+	w->next += padding + raw_bytes;
+	w->block_writer = NULL;
+	return 0;
+}
+
+int writer_flush_block(struct reftable_writer *w)
+{
+	if (w->block_writer == NULL) {
+		return 0;
+	}
+	if (w->block_writer->entries == 0) {
+		return 0;
+	}
+	return writer_flush_nonempty_block(w);
+}
+
+const struct reftable_stats *writer_stats(struct reftable_writer *w)
+{
+	return &w->stats;
+}
diff --git a/reftable/writer.h b/reftable/writer.h
new file mode 100644
index 00000000000..5115e762b12
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
+	int (*write)(void *, byte *, int);
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
+	struct index_record *index;
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

