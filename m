Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BB3BC4338F
	for <git@archiver.kernel.org>; Fri, 30 Jul 2021 11:48:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 18A7D60EE6
	for <git@archiver.kernel.org>; Fri, 30 Jul 2021 11:48:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238709AbhG3LsF (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Jul 2021 07:48:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238738AbhG3Lr5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Jul 2021 07:47:57 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 337C5C0613C1
        for <git@vger.kernel.org>; Fri, 30 Jul 2021 04:47:52 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id u15-20020a05600c19cfb02902501bdb23cdso9031980wmq.0
        for <git@vger.kernel.org>; Fri, 30 Jul 2021 04:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Mxs78hw82mLcuiyukDBRKAlZGx7o8hUECUOhrCJvi0E=;
        b=VTK1RcPrDXuXN63lFbVWV6/OKvf643hjC6VKpqOa5O4mUH27fL41mydYTO6If5LL4A
         xQJuqwYVaqV4OJj6A6MHOYEA0KL4k/onE2v1KQBHSayKietbNCOt8mdtIrgUhNEX6P4P
         1Z6dH3av7HTsrh2Xgff9/58mWsX89TOuwWnLyjpx9EH6XN21WCqURs7RHDdAvjyXYTTi
         VDe4dckHmD7m8cJU4vMWv+StVUPj6+lViaSNiTIpmKuk+T5dm069sfEIm1c+MzWmqnAf
         lUPbJQjiAxvM2YDDIiAsCm8G12J97AlZTPUfJ+M4VwVnjxAWFZUgP0HSUWphr+MQgUVF
         HlMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Mxs78hw82mLcuiyukDBRKAlZGx7o8hUECUOhrCJvi0E=;
        b=hGDfIo7gbG8eiWq07bN2RiyapAURhZVKI5OzYKiRTQgVgBthVH3zS6t5B3NRORdd14
         /gz1wFzyKQmKkB9J82nC7jAG41hUtk4EwfO4vEN/Cinlpal31ViuLmej7KfRVYNbms9A
         okPSMsN8zP3k9Il9dXFXFfX18yrR/o53T1z5JJEsLb7pGBYABXNVLoCxcacOBVHignN6
         A0Inf+KpH2iQj2QdzWvl7xyiYC1yeubyPUkX2dPpQ74gb0g86as8Jg9ZAYF4evT4E8EK
         +eoQ3SKCApQH7jZBH3cDWGck0q0GZAGnOF1aJPDCPHMLDKa1jgRcUBJ6w8WbiTyzBdhj
         piHQ==
X-Gm-Message-State: AOAM5334oapkLHEdj8CcAjGlr8rVuZscq6WIMWxS9Ukvod4af/56JBWZ
        HeBQ0jih/p2sB8+LbYiBkTyo7whj9FM=
X-Google-Smtp-Source: ABdhPJz79vUPOHGKfcVj55YGLzmlKILNaPmVIJAONj6TywsIQbrTi01DkEQUwbdCdT3nijDiV9HJqg==
X-Received: by 2002:a1c:a4c1:: with SMTP id n184mr2497454wme.8.1627645670772;
        Fri, 30 Jul 2021 04:47:50 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j2sm1484206wrd.14.2021.07.30.04.47.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jul 2021 04:47:50 -0700 (PDT)
Message-Id: <08cf2498f96759a94543d61b9a05e02280ab19d2.1627645664.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.990.v3.git.1627645664.gitgitgadget@gmail.com>
References: <pull.990.v2.git.1627531121.gitgitgadget@gmail.com>
        <pull.990.v3.git.1627645664.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 30 Jul 2021 11:47:41 +0000
Subject: [PATCH v3 6/9] diffcore-rename, merge-ort: add wrapper functions for
 filepair alloc/dealloc
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Eric Sunshine <sunshine@sunshineco.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

We want to be able to allocate filespecs and filepairs using a mem_pool.
However, filespec data will still remain outside the pool (perhaps in
the future we could plumb the pool through the various diff APIs to
allocate the filespec data too, but for now we are limiting the scope).
Add some extra functions to allocate these appropriately based on the
non-NULL-ness of opt->priv->pool, as well as some extra functions to
handle correctly deallocating the relevant parts of them.  A future
commit will make use of these new functions.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 diffcore-rename.c | 41 +++++++++++++++++++++++++++++++++++++++++
 diffcore.h        |  2 ++
 merge-ort.c       | 42 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 85 insertions(+)

diff --git a/diffcore-rename.c b/diffcore-rename.c
index 73d884099eb..5bc559f79e9 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -1328,6 +1328,47 @@ static void handle_early_known_dir_renames(struct dir_rename_info *info,
 	rename_src_nr = new_num_src;
 }
 
+static void free_filespec_data(struct diff_filespec *spec)
+{
+	if (!--spec->count)
+		diff_free_filespec_data(spec);
+}
+
+MAYBE_UNUSED
+static void pool_free_filespec(struct mem_pool *pool,
+			       struct diff_filespec *spec)
+{
+	if (!pool) {
+		free_filespec(spec);
+		return;
+	}
+
+	/*
+	 * Similar to free_filespec(), but only frees the data.  The spec
+	 * itself was allocated in the pool and should not be individually
+	 * freed.
+	 */
+	free_filespec_data(spec);
+}
+
+MAYBE_UNUSED
+void pool_diff_free_filepair(struct mem_pool *pool,
+			     struct diff_filepair *p)
+{
+	if (!pool) {
+		diff_free_filepair(p);
+		return;
+	}
+
+	/*
+	 * Similar to diff_free_filepair() but only frees the data from the
+	 * filespecs; not the filespecs or the filepair which were
+	 * allocated from the pool.
+	 */
+	free_filespec_data(p->one);
+	free_filespec_data(p->two);
+}
+
 void diffcore_rename_extended(struct diff_options *options,
 			      struct strintmap *relevant_sources,
 			      struct strintmap *dirs_removed,
diff --git a/diffcore.h b/diffcore.h
index 533b30e21e7..b58ee6b1934 100644
--- a/diffcore.h
+++ b/diffcore.h
@@ -127,6 +127,8 @@ struct diff_filepair {
 #define DIFF_PAIR_MODE_CHANGED(p) ((p)->one->mode != (p)->two->mode)
 
 void diff_free_filepair(struct diff_filepair *);
+void pool_diff_free_filepair(struct mem_pool *pool,
+			     struct diff_filepair *p);
 
 int diff_unmodified_pair(struct diff_filepair *);
 
diff --git a/merge-ort.c b/merge-ort.c
index 99c75690855..e79830f9181 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -690,6 +690,48 @@ static void path_msg(struct merge_options *opt,
 	strbuf_addch(sb, '\n');
 }
 
+MAYBE_UNUSED
+static struct diff_filespec *pool_alloc_filespec(struct mem_pool *pool,
+						 const char *path)
+{
+	struct diff_filespec *spec;
+	size_t len;
+
+	if (!pool)
+		return alloc_filespec(path);
+
+	/* Same code as alloc_filespec, except allocate from pool */
+	len = strlen(path);
+
+	spec = mem_pool_calloc(pool, 1, st_add3(sizeof(*spec), len, 1));
+	memcpy(spec+1, path, len);
+	spec->path = (void*)(spec+1);
+
+	spec->count = 1;
+	spec->is_binary = -1;
+	return spec;
+}
+
+MAYBE_UNUSED
+static struct diff_filepair *pool_diff_queue(struct mem_pool *pool,
+					     struct diff_queue_struct *queue,
+					     struct diff_filespec *one,
+					     struct diff_filespec *two)
+{
+	struct diff_filepair *dp;
+
+	if (!pool)
+		return diff_queue(queue, one, two);
+
+	/* Same code as diff_queue, except allocate from pool */
+	dp = mem_pool_calloc(pool, 1, sizeof(*dp));
+	dp->one = one;
+	dp->two = two;
+	if (queue)
+		diff_q(queue, dp);
+	return dp;
+}
+
 static void *pool_calloc(struct mem_pool *pool, size_t count, size_t size)
 {
 	if (!pool)
-- 
gitgitgadget

