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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B280AC432BE
	for <git@archiver.kernel.org>; Sat, 31 Jul 2021 17:27:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96ACF61050
	for <git@archiver.kernel.org>; Sat, 31 Jul 2021 17:27:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231404AbhGaR16 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 31 Jul 2021 13:27:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230479AbhGaR1x (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 31 Jul 2021 13:27:53 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83984C0613D5
        for <git@vger.kernel.org>; Sat, 31 Jul 2021 10:27:46 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id h13so2238564wrp.1
        for <git@vger.kernel.org>; Sat, 31 Jul 2021 10:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Mxs78hw82mLcuiyukDBRKAlZGx7o8hUECUOhrCJvi0E=;
        b=QSmsZVabMUiI72ttU9COIwDKxURZGYEpkcIzSaE0GhQsWSMvPAkmSmUYTRQMu7q4x1
         YIEmetzxvyj1OGRIUGx1c+Oa9kOd39qUvDohABQwbV5TI1hdcyoGATdkaMOOccNxVLtj
         s4wOoDcHCgCiMJMdQU9qGXl5dmHTu62uVK2b6/x4Mpm1E9lKeXiiqNxxGfa5ZNDlbCTf
         wsqqCVyK+vDI4eOz4mjfVEGsD3Xd9ultGj25BESZAocK9yBsozY3gn8BBaOLDQ0uzHTr
         0EklhvK0NL/w4OAC2dEIDVwl6EdNXot0L+hHr6+OTyTPFdDyZ0ykCXwZLsfwDSp6ipLr
         G/eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Mxs78hw82mLcuiyukDBRKAlZGx7o8hUECUOhrCJvi0E=;
        b=sqqwvrqS5YPFv1dFCXAnSJUXZ5yfTtm8XXB2ZIbA+D3QEaxs4AULpQCk72faup1tOP
         HJshJDJZ2NIUt82dOVW9WEHjLVPMO/teknR0LWUvV629VL49OfZmVGgVKcOWWoJ0eoKH
         FmqyQ6rFYlswOwY3j31R2YhsTHppTbH9ORMJXXFzjp56xMFih2TcEFYZfR/FxigOMFK4
         Lj4BUD56gnvKZGKHTQd3vOoyk+bx9qAW2guz9u2CBvAfuhGxz0GzNe45v/JDHZyuH3e2
         BSFdDrBtMJwsmnXoEnpNkPSwBXxQAa6iPg7mtF7Z1G1r8FUOTnNk2ORdPYC/Jdz0V8eS
         yltA==
X-Gm-Message-State: AOAM533oAyXZEcivlsJmaCaPg1/CIiuJttyfbCHRFtBiVDKzn0g2VJXe
        I0dn4dhlPZV4UK7UsrtflayMzwxyed4=
X-Google-Smtp-Source: ABdhPJw/wYDkrnDZqrQ9REzNSYMQkmw00guEUJoNpIet2x49/fpAvfrLSGbuT1QNmO75p5Lau5MYkg==
X-Received: by 2002:adf:f1c6:: with SMTP id z6mr9193613wro.207.1627752465185;
        Sat, 31 Jul 2021 10:27:45 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t8sm5974864wmj.5.2021.07.31.10.27.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Jul 2021 10:27:44 -0700 (PDT)
Message-Id: <08cf2498f96759a94543d61b9a05e02280ab19d2.1627752458.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.990.v4.git.1627752458.gitgitgadget@gmail.com>
References: <pull.990.v3.git.1627645664.gitgitgadget@gmail.com>
        <pull.990.v4.git.1627752458.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 31 Jul 2021 17:27:35 +0000
Subject: [PATCH v4 6/9] diffcore-rename, merge-ort: add wrapper functions for
 filepair alloc/dealloc
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Eric Sunshine <sunshine@sunshineco.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
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

