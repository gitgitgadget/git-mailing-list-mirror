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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B4A1C433DB
	for <git@archiver.kernel.org>; Tue, 26 Jan 2021 16:02:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF46E221EC
	for <git@archiver.kernel.org>; Tue, 26 Jan 2021 16:02:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404144AbhAZQCW (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Jan 2021 11:02:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391058AbhAZQCM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jan 2021 11:02:12 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DCB7C061A2E
        for <git@vger.kernel.org>; Tue, 26 Jan 2021 08:01:31 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id 7so17030095wrz.0
        for <git@vger.kernel.org>; Tue, 26 Jan 2021 08:01:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=siZEtXbSOFXW3yL7TfR3RspVNwEahKzFKF1375HAfPw=;
        b=LY3nDHcmbUIdVlHmvjM4X2VnXOX/3IRYVtZfzL6HVDZkIq33iXdKFLifzbjKbupY59
         UodG3QhrpB491jC/89lNbYRFUXUCfKxZNBuYMZ9VsgQj5cpUEU7v1XHTxItK8wUxFLAb
         DtPkBe/7IifytCjygYZHml7CcTg+Fdnecca+p86jBbQhqfd26TYJM3HsOOq7cItjODid
         IClL1Cl7U+UYn7mSfH2VJT6WiXE9ZPBqolg5cmtoRklvE1sGNyzkvJTlI4yZ2RVcxDOa
         U/s0f1cz+2I/tYCoABWDEs/5kFCVkHgpgw/+ZmOeNFjuqVW+F7+5P5QEMZ9MfgVj02Tw
         XuaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=siZEtXbSOFXW3yL7TfR3RspVNwEahKzFKF1375HAfPw=;
        b=ADQSqhufo79uemL+j/ysuhFwUHmDBrh/TuuUS6R/o4NJjlbic07SiT9EdY4a0CdLNu
         n/mFSBr1GWbh6ThuGBM86XhEaw1KFyhmX9KjmJIwn4MqjxWcqjPKxxl8SGM5bkkVWHdG
         xccCBohoDEhg11Cb6PC/9cYimWfLfyJa0gC++9OPu5SfTC7Aa3yDOtavYSY0/bHS3x0c
         F4PmzV23vpQYelLL9YVaGnOSlQBr1owgPhzeVWpktd4daBxTTze3tA1KGPuNGjcssBzB
         rUwkS7I1FjJfkR0qnaauPyGW12pdN0qVBIhKAqhGDStZKpdpY4dOzcLSsU0ptkuRYOhe
         m9NQ==
X-Gm-Message-State: AOAM530+r+jhEmdgcVZ0sLHpVzLjRhhPn5vSOnV2qyGmpPluVIYHOOhg
        bZbRkoRgYIcLFbUCyQvgLcB+iN2GRUg=
X-Google-Smtp-Source: ABdhPJwiNxVIn+8G8fy9752END+z+BBXmOYo0qMOOs7yd5sYmkxjStHZqpnJTt5gSMfaSKQx3dGQyQ==
X-Received: by 2002:adf:dd45:: with SMTP id u5mr6767241wrm.392.1611676889965;
        Tue, 26 Jan 2021 08:01:29 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a184sm3968026wme.35.2021.01.26.08.01.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jan 2021 08:01:29 -0800 (PST)
Message-Id: <9bd273f8c94fdb0c3adf8aedef3480ff5f4232b8.1611676886.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.848.git.1611676886.gitgitgadget@gmail.com>
References: <pull.848.git.1611676886.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 26 Jan 2021 16:01:11 +0000
Subject: [PATCH 02/17] chunk-format: create chunk format write API
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     me@ttaylorr.com, gitster@pobox.com, l.s.r@web.de,
        szeder.dev@gmail.com, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

In anticipation of combining the logic from the commit-graph and
multi-pack-index file formats, create a new chunk-format API. Use a
'struct chunkfile' pointer to keep track of data that has been
registered for writes. This struct is anonymous outside of
chunk-format.c to ensure no user attempts to interfere with the data.

The next change will use this API in commit-graph.c, but the general
approach is:

 1. initialize the chunkfile with init_chunkfile(f).
 2. add chunks in the intended writing order with add_chunk().
 3. write any header information to the hashfile f.
 4. write the chunkfile data using write_chunkfile().
 5. free the chunkfile struct using free_chunkfile().

Helped-by: Taylor Blau <me@ttaylorr.com>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Makefile       |  1 +
 chunk-format.c | 91 ++++++++++++++++++++++++++++++++++++++++++++++++++
 chunk-format.h | 20 +++++++++++
 3 files changed, 112 insertions(+)
 create mode 100644 chunk-format.c
 create mode 100644 chunk-format.h

diff --git a/Makefile b/Makefile
index 7b64106930a..50a7663841e 100644
--- a/Makefile
+++ b/Makefile
@@ -854,6 +854,7 @@ LIB_OBJS += bundle.o
 LIB_OBJS += cache-tree.o
 LIB_OBJS += chdir-notify.o
 LIB_OBJS += checkout.o
+LIB_OBJS += chunk-format.o
 LIB_OBJS += color.o
 LIB_OBJS += column.o
 LIB_OBJS += combine-diff.o
diff --git a/chunk-format.c b/chunk-format.c
new file mode 100644
index 00000000000..2ce37ecc6bb
--- /dev/null
+++ b/chunk-format.c
@@ -0,0 +1,91 @@
+#include "cache.h"
+#include "chunk-format.h"
+#include "csum-file.h"
+#define CHUNK_LOOKUP_WIDTH 12
+
+/*
+ * When writing a chunk-based file format, collect the chunks in
+ * an array of chunk_info structs. The size stores the _expected_
+ * amount of data that will be written by write_fn.
+ */
+struct chunk_info {
+	uint32_t id;
+	uint64_t size;
+	chunk_write_fn write_fn;
+};
+
+struct chunkfile {
+	struct hashfile *f;
+
+	struct chunk_info *chunks;
+	size_t chunks_nr;
+	size_t chunks_alloc;
+};
+
+struct chunkfile *init_chunkfile(struct hashfile *f)
+{
+	struct chunkfile *cf = xcalloc(1, sizeof(*cf));
+	cf->f = f;
+	return cf;
+}
+
+void free_chunkfile(struct chunkfile *cf)
+{
+	if (!cf)
+		return;
+	free(cf->chunks);
+	free(cf);
+}
+
+int get_num_chunks(struct chunkfile *cf)
+{
+	return cf->chunks_nr;
+}
+
+void add_chunk(struct chunkfile *cf,
+	       uint64_t id,
+	       chunk_write_fn fn,
+	       size_t size)
+{
+	ALLOC_GROW(cf->chunks, cf->chunks_nr + 1, cf->chunks_alloc);
+
+	cf->chunks[cf->chunks_nr].id = id;
+	cf->chunks[cf->chunks_nr].write_fn = fn;
+	cf->chunks[cf->chunks_nr].size = size;
+	cf->chunks_nr++;
+}
+
+int write_chunkfile(struct chunkfile *cf, void *data)
+{
+	int i;
+	size_t cur_offset = cf->f->offset + cf->f->total;
+
+	/* Add the table of contents to the current offset */
+	cur_offset += (cf->chunks_nr + 1) * CHUNK_LOOKUP_WIDTH;
+
+	for (i = 0; i < cf->chunks_nr; i++) {
+		hashwrite_be32(cf->f, cf->chunks[i].id);
+		hashwrite_be64(cf->f, cur_offset);
+
+		cur_offset += cf->chunks[i].size;
+	}
+
+	/* Trailing entry marks the end of the chunks */
+	hashwrite_be32(cf->f, 0);
+	hashwrite_be64(cf->f, cur_offset);
+
+	for (i = 0; i < cf->chunks_nr; i++) {
+		uint64_t start_offset = cf->f->total + cf->f->offset;
+		int result = cf->chunks[i].write_fn(cf->f, data);
+
+		if (result)
+			return result;
+
+		if (cf->f->total + cf->f->offset != start_offset + cf->chunks[i].size)
+			BUG("expected to write %"PRId64" bytes to chunk %"PRIx32", but wrote %"PRId64" instead",
+			    cf->chunks[i].size, cf->chunks[i].id,
+			    cf->f->total + cf->f->offset - start_offset);
+	}
+
+	return 0;
+}
diff --git a/chunk-format.h b/chunk-format.h
new file mode 100644
index 00000000000..bfaed672813
--- /dev/null
+++ b/chunk-format.h
@@ -0,0 +1,20 @@
+#ifndef CHUNK_FORMAT_H
+#define CHUNK_FORMAT_H
+
+#include "git-compat-util.h"
+
+struct hashfile;
+struct chunkfile;
+
+struct chunkfile *init_chunkfile(struct hashfile *f);
+void free_chunkfile(struct chunkfile *cf);
+int get_num_chunks(struct chunkfile *cf);
+typedef int (*chunk_write_fn)(struct hashfile *f,
+			      void *data);
+void add_chunk(struct chunkfile *cf,
+	       uint64_t id,
+	       chunk_write_fn fn,
+	       size_t size);
+int write_chunkfile(struct chunkfile *cf, void *data);
+
+#endif
-- 
gitgitgadget

