Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7648EC4338F
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 12:13:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60A736137F
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 12:13:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236901AbhHWMNt (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Aug 2021 08:13:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236877AbhHWMNo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Aug 2021 08:13:44 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11D5AC0613C1
        for <git@vger.kernel.org>; Mon, 23 Aug 2021 05:13:02 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id v10so14736303wrd.4
        for <git@vger.kernel.org>; Mon, 23 Aug 2021 05:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dPy68jUjcETiLHVqBLTsI9cZjgcpZ3tSoy2uU3ySj8E=;
        b=nMe7kj4hLNdkJokCnTGIQ2ZJj99UG7barSxhIpZTxuDdqg5l5EBUpZPnmzOGDSMuzo
         52YSB63AaMPsm8mnAwTM+yK6uifaJltL+/PsMRjlfX+M9xuRBq1XF/kqnFuSQSro112D
         AQRUOw0xLex71IzB/mxeoi1eEdR0cLPt+4xt7dybZkTStLX6vJJoZOZ8DT42oDPBeaYz
         81TXsiaZhwp4Hj0gJqnMnMirG/KKEMjvod/lLAAKE5cBdMlMCmZCn5wcjVmh1jS6h5M1
         zpbmql07e9cKTa/C5iF46It5eKt5E29ffebl1X5Vl0yjFtQCgm2Wa/DrfuebjkUALQ2H
         WUlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dPy68jUjcETiLHVqBLTsI9cZjgcpZ3tSoy2uU3ySj8E=;
        b=iNtLGXH0ij1hVhgc0SJmPN6tnXYppij983m3xO1v37SdUaUNJd7JzEvPpadOn0WuSn
         1fDcXq+Nx/xHM/oinKtqixTYW03388qF1QIPLxFFI7zwRBS+46icuUE+q8aaMBrWvIZE
         WbTDIy11W9J+kzITUPFcdG9DWNCUh96U9BJWmCJVCa20wUTY5whH5CfZxoEG6ffW0FbS
         yUfFNfA8U9wg0KgKXCO8CkU8oVR1ZBkyQnOPCDctMaORiW2qNM9RErbphljr5Pcy/M6P
         e10PS59xLY3UTqJh3kWGykK4QBtnphXIccp83lTOOrb6M/uFZyIGb26zz16ml8v9Gq0G
         SBMw==
X-Gm-Message-State: AOAM532ZtwyoTKn8CQCkmLyvGxWBfHua+4KSFbTYXWGWaZS1mmscQ5ww
        tT0C3wOh6LS3iBhXCrtucvOp6ubE9KLT3s8x
X-Google-Smtp-Source: ABdhPJw8FgC9+gGhZoe1DTtL3eRZX48b16dcfrNKji19ewvU0azH0dvd6QQxyP6bNPAS6cWLR34a/g==
X-Received: by 2002:adf:ed0c:: with SMTP id a12mr7158318wro.102.1629720780303;
        Mon, 23 Aug 2021 05:13:00 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id u10sm14824952wrt.14.2021.08.23.05.12.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Aug 2021 05:12:59 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>, Han-Wen Nienhuys <hanwen@google.com>
Subject: [PATCH v4 06/28] reftable: add blocksource, an abstraction for random access reads
Date:   Mon, 23 Aug 2021 14:12:17 +0200
Message-Id: <patch-v4-06.28-9429aaf7c76-20210823T120208Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.662.gbaddc25a55e
In-Reply-To: <cover-v4-00.28-00000000000-20210823T120208Z-avarab@gmail.com>
References: <pull.1054.v3.git.git.1629207607.gitgitgadget@gmail.com> <cover-v4-00.28-00000000000-20210823T120208Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

The reftable format is usually used with files for storage. However, we abstract
away this using the blocksource data structure. This has two advantages:

* log blocks are zlib compressed, and handling them is simplified if we can
  discard byte segments from within the block layer.

* for unittests, it is useful to read and write in-memory. The blocksource
  allows us to abstract the data away from on-disk files.

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 Makefile                        |   1 +
 reftable/blocksource.c          | 148 ++++++++++++++++++++++++++++++++
 reftable/blocksource.h          |  22 +++++
 reftable/reftable-blocksource.h |  49 +++++++++++
 4 files changed, 220 insertions(+)
 create mode 100644 reftable/blocksource.c
 create mode 100644 reftable/blocksource.h
 create mode 100644 reftable/reftable-blocksource.h

diff --git a/Makefile b/Makefile
index addf2813086..86ba58cf140 100644
--- a/Makefile
+++ b/Makefile
@@ -2447,6 +2447,7 @@ xdiff-objs: $(XDIFF_OBJS)
 
 REFTABLE_OBJS += reftable/basics.o
 REFTABLE_OBJS += reftable/error.o
+REFTABLE_OBJS += reftable/blocksource.o
 REFTABLE_OBJS += reftable/publicbasics.o
 
 REFTABLE_TEST_OBJS += reftable/test_framework.o
diff --git a/reftable/blocksource.c b/reftable/blocksource.c
new file mode 100644
index 00000000000..0044eecd9aa
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
+#include "reftable-blocksource.h"
+#include "reftable-error.h"
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
+	struct strbuf *b = v;
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
+static struct reftable_block_source_vtable strbuf_vtable = {
+	.size = &strbuf_size,
+	.read_block = &strbuf_read_block,
+	.return_block = &strbuf_return_block,
+	.close = &strbuf_close,
+};
+
+void block_source_from_strbuf(struct reftable_block_source *bs,
+			      struct strbuf *buf)
+{
+	assert(!bs->ops);
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
+static struct reftable_block_source_vtable malloc_vtable = {
+	.return_block = &malloc_return_block,
+};
+
+static struct reftable_block_source malloc_block_source_instance = {
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
+	struct file_block_source *b = v;
+	assert(off + size <= b->size);
+	dest->data = reftable_malloc(size);
+	if (pread(b->fd, dest->data, size, off) != size)
+		return -1;
+	dest->len = size;
+	return size;
+}
+
+static struct reftable_block_source_vtable file_vtable = {
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
+	assert(!bs->ops);
+	bs->ops = &file_vtable;
+	bs->arg = p;
+	return 0;
+}
diff --git a/reftable/blocksource.h b/reftable/blocksource.h
new file mode 100644
index 00000000000..072e2727ad2
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
+#include "system.h"
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
diff --git a/reftable/reftable-blocksource.h b/reftable/reftable-blocksource.h
new file mode 100644
index 00000000000..5aa3990a573
--- /dev/null
+++ b/reftable/reftable-blocksource.h
@@ -0,0 +1,49 @@
+/*
+Copyright 2020 Google LLC
+
+Use of this source code is governed by a BSD-style
+license that can be found in the LICENSE file or at
+https://developers.google.com/open-source/licenses/bsd
+*/
+
+#ifndef REFTABLE_BLOCKSOURCE_H
+#define REFTABLE_BLOCKSOURCE_H
+
+#include <stdint.h>
+
+/* block_source is a generic wrapper for a seekable readable file.
+ */
+struct reftable_block_source {
+	struct reftable_block_source_vtable *ops;
+	void *arg;
+};
+
+/* a contiguous segment of bytes. It keeps track of its generating block_source
+ * so it can return itself into the pool. */
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
+#endif
-- 
2.33.0.662.gbaddc25a55e

