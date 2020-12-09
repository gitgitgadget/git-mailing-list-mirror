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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74D01C433FE
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 14:03:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3890E23B42
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 14:03:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732786AbgLIOCM (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Dec 2020 09:02:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732779AbgLIOB5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Dec 2020 09:01:57 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2518AC0617B0
        for <git@vger.kernel.org>; Wed,  9 Dec 2020 06:00:38 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id e25so1789201wme.0
        for <git@vger.kernel.org>; Wed, 09 Dec 2020 06:00:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=JyxmAVIRZ2EULz8ridZs410zSRPcviD//ZA3AWZLvQM=;
        b=TgRNWtx43bIYmA0/FsPeVA0Zj9Xj+3qAE3V340g3sw3jA3F3NBV+5F2d5WZ9y3tZ4A
         BeLt6CpJcImIveSZA7xMkSzZNlYGLUhNOuQVY7yiYrzoPYhE1r0df0vsChfLdUqvscyW
         Tt+GQU6vEFTQ8tsSWDCf3iWpp6Z7uaY2NmcLFWwgR5MKroZHdcRgAv0Vin1BsXfvZk4y
         seNtB3URQtgGHklJ1e9ZsUNR4+0G/+2+Q1YTkVQuTtvIkXr5rL7/eB72Tsp4LLSnI3Sc
         qFC8qrOaYbEhS1MDP6W3zV75ETmkzJpraRvybAARWz8wL56CnNrAPudLGUJNsqjMviiG
         7gmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=JyxmAVIRZ2EULz8ridZs410zSRPcviD//ZA3AWZLvQM=;
        b=RWp1IYUnwAiWN5IPAGQHF0ON88qsKCfL2K4bsMZAvLVv8PkHzZ11w9QUR4e2IK/Wq1
         pnE1rIKbVz77adrYkcdFnQ+laveixL5y73sQptbhAZ/a62eLQIX9iE+VWhuNiTKZPVQl
         JkiAvJcwN3ogoJJ6oqTRNVEK1ozh3qUnFr6GyJGMtB76OqjCLotxZMJ9b22mMKjCERoW
         QenvsL46s0+57jhgF9Ns+Pg3R8XypknSndLORBf9y/B0WYfpaKstl3zP+Y7BvYA4Moqo
         IM9/0Wb6b2OBZth9VFHnvGkObdzoHpkydjHcuR5LVkIS2LJYf5w151ROQdR/TSl953+1
         MDDA==
X-Gm-Message-State: AOAM530ghRl/5AcnNk7VSNxgboYOdgT5eWlN+IOGlzRI+BEWW0A7XcGz
        /k3WPHIBlC4ie9fBpE8Ms4Y4pkvHK3g=
X-Google-Smtp-Source: ABdhPJyS5dF26bBrY2CNY/GjRUbgMRSFvNMTRHEiKwaVPC5RNpTsI+RG3sqjze7N37cI8lgHr+B/DA==
X-Received: by 2002:a1c:87:: with SMTP id 129mr2925045wma.183.1607522436606;
        Wed, 09 Dec 2020 06:00:36 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y6sm3637034wmg.39.2020.12.09.06.00.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Dec 2020 06:00:35 -0800 (PST)
Message-Id: <aaa817f8598bd5eee3b3f0fa35d613a8687cdd01.1607522429.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.847.v4.git.git.1607522429.gitgitgadget@gmail.com>
References: <pull.847.v3.git.git.1606419752.gitgitgadget@gmail.com>
        <pull.847.v4.git.git.1607522429.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 09 Dec 2020 14:00:19 +0000
Subject: [PATCH v4 05/15] reftable: add blocksource, an abstraction for random
 access reads
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
        Han-Wen Nienhuys <hanwenn@gmail.com>,
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
index 9b6d84af8f6..f623611bde2 100644
--- a/Makefile
+++ b/Makefile
@@ -2391,6 +2391,7 @@ XDIFF_OBJS += xdiff/xutils.o
 
 REFTABLE_OBJS += reftable/basics.o
 REFTABLE_OBJS += reftable/error.o
+REFTABLE_OBJS += reftable/blocksource.o
 REFTABLE_OBJS += reftable/publicbasics.o
 
 REFTABLE_TEST_OBJS += reftable/test_framework.o
diff --git a/reftable/blocksource.c b/reftable/blocksource.c
new file mode 100644
index 00000000000..25d4d95b52b
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
+	struct file_block_source *b = (struct file_block_source *)v;
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
+	assert(bs->ops == NULL);
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

