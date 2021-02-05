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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8628DC433DB
	for <git@archiver.kernel.org>; Fri,  5 Feb 2021 22:01:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F85B64E4E
	for <git@archiver.kernel.org>; Fri,  5 Feb 2021 22:01:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233002AbhBEWBL (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Feb 2021 17:01:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232970AbhBEO5n (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Feb 2021 09:57:43 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72909C06121E
        for <git@vger.kernel.org>; Fri,  5 Feb 2021 08:28:40 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id u14so6353519wmq.4
        for <git@vger.kernel.org>; Fri, 05 Feb 2021 08:28:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=FESohs3eVG/Vtak1cJSjlpSe3VyQTAQuJDbcHz3Ibp8=;
        b=pLwXNUiq8fNt7rjt7OrDo1fI3amhyhC49xPMMIH2XoKREnVg2AZ1cABK7ztRWAVq3k
         5JGNNu/ZF3lrH1T9G0sb7s/1gPC0BksgDZS7gCgLLMO1XihYGWcGyjImaMsUeSYJglKw
         o/95mVT5DTHRFv0VHDS6big6qc0I5UG32gHf0RaMFdm/ryPFRjc2o2wZw0QF7pWik1s5
         lu42JN2EixLKTxnxw3FkMD00GDw4+JPY5zzk3+K/2H8F0jeyVXAt853kNs7zVDl/btZA
         kdk5tRhKVi7TDU/w94TT/gBbzk7XKKL6LNOacR7wV9tcMzCblYxXaQ7GPw0oeikbI0lg
         Pvwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=FESohs3eVG/Vtak1cJSjlpSe3VyQTAQuJDbcHz3Ibp8=;
        b=awJe0lMoboDgf90TEaMRnMYxz7Yy04uS7ua6lmb0nOaSBeE18LdCgdMygJk6LZ8M90
         6ApcEfedMXvGO03ueu7ePHVCIpmAfzu/WY4B+g0x2sez5aX+2cZslAbC/Umm4w3wqXkX
         6JfDI4fZe/bAFfRv/He9BG0fcxRd8ul1ycV8nR9bDHGQrDE7d3+ab/p8Muymy/drj17G
         8iy3LFdfmenEUhCjRuCAvl2Oei5SkY7KaWQ040IQoee2o/EYIUul85iixTjW7g+xG/rN
         8iN45vld5GK3RLitkQ+clrEQHBtRJwuxsTPYcGljIU8B7/Ju36Y0t//m/d2tg3ANBm3v
         dSSw==
X-Gm-Message-State: AOAM530EF11OgW6Sg0k422CqUz6aOSqF4E9wxi4EFhqPBFq16QoxYsJf
        ZrxPzF+VISZTGOXJWIo/vsHOvWAp8oA=
X-Google-Smtp-Source: ABdhPJxkh4nyD5a9ia2nvNDegEdgfBJcqXm3IHeYtl4FG1GB+I3of7kiezL/Jc0brtsqtyLoLd+Wyg==
X-Received: by 2002:a05:600c:20f:: with SMTP id 15mr3883348wmi.148.1612535456551;
        Fri, 05 Feb 2021 06:30:56 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i6sm11491851wrs.71.2021.02.05.06.30.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Feb 2021 06:30:55 -0800 (PST)
Message-Id: <16c37d2370cf4fd5fc309ac6dc8aa6443ffcf3d7.1612535453.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.848.v3.git.1612535452.gitgitgadget@gmail.com>
References: <pull.848.v2.git.1611759716.gitgitgadget@gmail.com>
        <pull.848.v3.git.1612535452.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 05 Feb 2021 14:30:37 +0000
Subject: [PATCH v3 02/17] chunk-format: create chunk format write API
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
 chunk-format.c | 91 ++++++++++++++++++++++++++++++++++++++++++++++++++
 chunk-format.h | 19 +++++++++++
 3 files changed, 111 insertions(+)
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
index 000000000000..6e0f1900213e
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
index 000000000000..9a1d770accec
--- /dev/null
+++ b/chunk-format.h
@@ -0,0 +1,19 @@
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

