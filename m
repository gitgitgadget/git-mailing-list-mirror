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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05D0AC433FE
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 18:48:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E36EA610FF
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 18:48:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245420AbhIIStp (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Sep 2021 14:49:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244661AbhIIStB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Sep 2021 14:49:01 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B89ABC061766
        for <git@vger.kernel.org>; Thu,  9 Sep 2021 11:47:50 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id g16so3958510wrb.3
        for <git@vger.kernel.org>; Thu, 09 Sep 2021 11:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=0H7sIllJ5diD/aIGOgMpHSEiTdVmkZz40GtDvbxm9BA=;
        b=CO4gKLYqbPEzabNnibP/oQcIQxz99hl6la3oGzm9sg8m7xOrhhR9QHd9aYHNTcrWKD
         A3nV6cl3FryUXy1CT9PVgff5lASB1i6unYAzx9hH7NGDC2uMcx7oUUw2alPACjlRZ1PC
         6DusVkKclNt2CqXTp9YG6/MBIIxM2FxtkXJmwC7zekchzkgTVmSWFGRTuY3srNh8o7lg
         hAHzvTOOv9OXRZY+6Ld/SfxqDBzlJqCLWuRqTpLDSF9R8K4Olif/2dBGyLsFuE+lI75O
         /Fi9LFqzbvoTF7J8IESrn9Poqj86z3H4bf6SjktYuSzQgUuN8Npk2AWCnZkm1v/nR8g0
         OrUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=0H7sIllJ5diD/aIGOgMpHSEiTdVmkZz40GtDvbxm9BA=;
        b=zurkHAin5YjhSyZMWDtofriSzkYC6jAlNsD9aJFo+se0Envq1zsc3ZtYQZuOAE5LXc
         FZyd5NzRqC4tTH2jzUvn8rmbYXalCUU7hd7Z6oJ1Fzz/o6R3UKQUk94inSUV5xvIgmjM
         jYMppXnw/6xvo0QJyywnctbyr/CZGXdPFcbTuwcS8HiaiNH9HV7XU7bngS+rfn9iILBL
         yALk7j6awMbLSalT+8zgVYS561TgLT7GgYINEqIOXoNC+aC5PznOPT/tjTITddVulnfY
         bdxJaYmkWrHbXtx7b1SEBHyuoUv9umPgKox7dlW98CaB9PZlsU+4gLbh9M4C8TcCp3jk
         4oPQ==
X-Gm-Message-State: AOAM532AeYMkdoQ4WO+kDRqhGpdnk6d8abM/pdSUNMs344PhUUcfUjnS
        KW4kc/vJDXd2oQDDz2ZxjvTM6+Hvvjc=
X-Google-Smtp-Source: ABdhPJykIPaewJ44O4W0l2AHBsNkewHmwmCy9in4hv+tvnI+VNgBXWHlSWW/7AaCKQDq/0t5W1fYRA==
X-Received: by 2002:adf:b781:: with SMTP id s1mr5451045wre.165.1631213269355;
        Thu, 09 Sep 2021 11:47:49 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f3sm2231949wmj.28.2021.09.09.11.47.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Sep 2021 11:47:49 -0700 (PDT)
Message-Id: <e9206532126ea165abb3ebd157ae3b0750e865cc.1631213265.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1081.v2.git.git.1631213264.gitgitgadget@gmail.com>
References: <pull.1081.git.git.1630335476.gitgitgadget@gmail.com>
        <pull.1081.v2.git.git.1631213264.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 09 Sep 2021 18:47:30 +0000
Subject: [PATCH v2 05/19] reftable: add blocksource, an abstraction for random
 access reads
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwen@google.com>,
        Carlo Marcelo Arenas =?UTF-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
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
index 0bf5e49aa61..c7ffc27a727 100644
--- a/Makefile
+++ b/Makefile
@@ -2451,6 +2451,7 @@ xdiff-objs: $(XDIFF_OBJS)
 
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
gitgitgadget

