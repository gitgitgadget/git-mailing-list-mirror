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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88A0EC433DB
	for <git@archiver.kernel.org>; Thu, 18 Feb 2021 16:46:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4748B6146D
	for <git@archiver.kernel.org>; Thu, 18 Feb 2021 16:46:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232929AbhBRQq1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Feb 2021 11:46:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233550AbhBROI3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Feb 2021 09:08:29 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3349C061788
        for <git@vger.kernel.org>; Thu, 18 Feb 2021 06:07:44 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id o10so2856282wmc.1
        for <git@vger.kernel.org>; Thu, 18 Feb 2021 06:07:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=eVXJhiJktjVMhH9E9QDbeeZ0spv2V4GDVPN9nLs5T2c=;
        b=uXal/FHBlp1xXfV70FZV9A/d/dmbSEvrTQa/JjOsZgcb1S+6//Cd+vcr7VeOmotzCt
         DVwkrutOyP6VNvLXPazVw/KNwmxUr8Kzj+AXUTFyul/IOlX2Dwi3Nb3Z+kwY8dhKq6Qp
         5Q5StIWhpOzEQOEo8lTubnyHd4WIKebJX78De8qhPMDOZ8iUUIbNdYd5AcYIOKoAiN3X
         Q3u+rpnHoUAMaUcalXtYDBhC6OL695wuEJfd68RKVHWhssvMhQ7egPImXb5P7FqcYrjs
         uOCnrw/5EHaz5FA4V1lyBDTVYIvK+zdVEpQ70ECqnFBMFh5ADr3cdVFDsWecDJ4SmeMz
         5dmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=eVXJhiJktjVMhH9E9QDbeeZ0spv2V4GDVPN9nLs5T2c=;
        b=VxILc0MhfnnKQlBWPNypB2rXlBHmSlT9B3Nmoxvyrht+kkUxeA2EBg+SfmODp1uG7H
         Hjaycf9Mkh+IVrP9h798Ii/dFWliT7uq7rvY3bwR0t53hGXHYjPwvUVVfkkvHxyTnZot
         dIxXjqx4TQqhu5bAydKekR1EdJyorOhoehzRR6Wda1bI8XJIPzyY0bXnHvyYBe1+8U1O
         TRa3nx7PiFpFmuFZsuSNfdLTsSwJR64b7isLSjQKOwVQ24pivDxifnwFO+VSI/SskqFQ
         VHQ/I8F6QUC9Ps36PtT4fVD4nN4tpKs+O5NJchJGrNDdDJXwQJhMWd5ydM7DH+gWm7kT
         uweg==
X-Gm-Message-State: AOAM533TjKv3NSCsm4LQCg/dYoU/xrYmCJFYc9G1g60w6488kRi026Ui
        rPf1Za76DlSQMDZ1UXeL6cnlIZFe2tg=
X-Google-Smtp-Source: ABdhPJyP5cEQZKT+JFXMGerqG5r86GnGFhUEmbA1rkQK/Vs2tcvhQyfzDoKY6wioYFM4YK3cYk9DXQ==
X-Received: by 2002:a7b:ce12:: with SMTP id m18mr3881999wmc.148.1613657263708;
        Thu, 18 Feb 2021 06:07:43 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r17sm9395146wrx.82.2021.02.18.06.07.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Feb 2021 06:07:43 -0800 (PST)
Message-Id: <da1fcc68357609cfb379a2487c139665efbba59f.1613657259.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.848.v4.git.1613657259.gitgitgadget@gmail.com>
References: <pull.848.v3.git.1612535452.gitgitgadget@gmail.com>
        <pull.848.v4.git.1613657259.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 18 Feb 2021 14:07:24 +0000
Subject: [PATCH v4 02/17] chunk-format: create chunk format write API
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     me@ttaylorr.com, gitster@pobox.com, l.s.r@web.de,
        szeder.dev@gmail.com, Chris Torek <chris.torek@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
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
Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Makefile       |  1 +
 chunk-format.c | 90 ++++++++++++++++++++++++++++++++++++++++++++++++++
 chunk-format.h | 21 ++++++++++++
 3 files changed, 112 insertions(+)
 create mode 100644 chunk-format.c
 create mode 100644 chunk-format.h

diff --git a/Makefile b/Makefile
index 7b64106930a6..50a7663841e9 100644
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
index 000000000000..6c9b52b70c10
--- /dev/null
+++ b/chunk-format.c
@@ -0,0 +1,90 @@
+#include "cache.h"
+#include "chunk-format.h"
+#include "csum-file.h"
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
+	       uint32_t id,
+	       size_t size,
+	       chunk_write_fn fn)
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
+	uint64_t cur_offset = hashfile_total(cf->f);
+
+	/* Add the table of contents to the current offset */
+	cur_offset += (cf->chunks_nr + 1) * CHUNK_TOC_ENTRY_SIZE;
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
+		off_t start_offset = hashfile_total(cf->f);
+		int result = cf->chunks[i].write_fn(cf->f, data);
+
+		if (result)
+			return result;
+
+		if (hashfile_total(cf->f) - start_offset != cf->chunks[i].size)
+			BUG("expected to write %"PRId64" bytes to chunk %"PRIx32", but wrote %"PRId64" instead",
+			    cf->chunks[i].size, cf->chunks[i].id,
+			    hashfile_total(cf->f) - start_offset);
+	}
+
+	return 0;
+}
diff --git a/chunk-format.h b/chunk-format.h
new file mode 100644
index 000000000000..ce598b66d9f8
--- /dev/null
+++ b/chunk-format.h
@@ -0,0 +1,21 @@
+#ifndef CHUNK_FORMAT_H
+#define CHUNK_FORMAT_H
+
+#include "git-compat-util.h"
+
+struct hashfile;
+struct chunkfile;
+
+#define CHUNK_TOC_ENTRY_SIZE (sizeof(uint32_t) + sizeof(uint64_t))
+
+struct chunkfile *init_chunkfile(struct hashfile *f);
+void free_chunkfile(struct chunkfile *cf);
+int get_num_chunks(struct chunkfile *cf);
+typedef int (*chunk_write_fn)(struct hashfile *f, void *data);
+void add_chunk(struct chunkfile *cf,
+	       uint32_t id,
+	       size_t size,
+	       chunk_write_fn fn);
+int write_chunkfile(struct chunkfile *cf, void *data);
+
+#endif
-- 
gitgitgadget

