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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D28DBC4338F
	for <git@archiver.kernel.org>; Thu, 29 Jul 2021 03:58:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B77A86101C
	for <git@archiver.kernel.org>; Thu, 29 Jul 2021 03:58:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233647AbhG2D66 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Jul 2021 23:58:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233607AbhG2D6u (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Jul 2021 23:58:50 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03F74C061765
        for <git@vger.kernel.org>; Wed, 28 Jul 2021 20:58:47 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id n12so5033429wrr.2
        for <git@vger.kernel.org>; Wed, 28 Jul 2021 20:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=UkILLCzdF13HkLWrleY0LnmTdUR833gkBbCCCXg27Jo=;
        b=mGuNv7rPg8jj16rp7uB323IAwW7710mGUSxol/b3luwpL2AE2ZqEInosPefXJAA+g4
         EkOhB94OVMe0CUG05lG6o/jGACROGrD/sMoNS7XZR1aCjWbWOBaN5ZYsH5MEJOspkIV6
         9NqEMWZ0fUhwoMOpbXC/H6c1KP9ahNSqtL1ultGUxIcPL1WKYC1aMifT4Mis4LE79ej3
         zH/1GEYiiuHc4FWDWtdPVnHsJmb7uQvmLfDD9NKEz6xAHddvwWdPB3+Ixn89BJtArvhW
         +bR1gp564IoFazeJ9gghRnB+cXXyZK1GTZ+/u5DpGIzJ2pD9EVj+PfhggWPKeceyNv/b
         0yVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=UkILLCzdF13HkLWrleY0LnmTdUR833gkBbCCCXg27Jo=;
        b=Wno8dCoBtKeb13MFSPwhqfYAW91D2ForqYqbO+xrfl6JRVdehDT1z1jAIKFgA7CESK
         /j1GjjuprzC2wRwv+MWEcv9ygXP5JxtF+co4s9oYN+TvC3USRtNqiMSiaj5zwtflw4+Y
         isYmy1AsAH9XM/Tv/3oK0U0M+5nEAo6/3+5qoAg5fqIaj/0kBwxpZ3FnmoAOmHksRviv
         qU5LTB1kSs+c1TqaDnwZeNYCTT816jCREF1MqrKrQsDzFbLCAWgJ9+yo3+QIIFhlC0oY
         Dd9WKhN+e4wz1zhHmKUvxUvJpMltgsFX0z2/KYLzv1a+YNGb+6yPqIp+diYZ07mlDGmy
         B1tA==
X-Gm-Message-State: AOAM532FmDO0OjJ/1YaYt+3rHU5FrzpdVY4A3WRtIeAU1olzdcxwWrrk
        HOEzWmCVKjdv7jjSpcJHGY7bLUh7z1o=
X-Google-Smtp-Source: ABdhPJzBnaEt8Mwh9jy8KnSFqLLzUkFaSnivqGwuoMR6y7EceNt0cHxiwMpsDVXcEPG0qefgrHPrRw==
X-Received: by 2002:a5d:4348:: with SMTP id u8mr2535317wrr.28.1627531125697;
        Wed, 28 Jul 2021 20:58:45 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i7sm1739508wre.64.2021.07.28.20.58.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jul 2021 20:58:45 -0700 (PDT)
Message-Id: <560800a80efe9506e567c09916102aa999932c50.1627531121.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.990.v2.git.1627531121.gitgitgadget@gmail.com>
References: <pull.990.git.1627044897.gitgitgadget@gmail.com>
        <pull.990.v2.git.1627531121.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 29 Jul 2021 03:58:39 +0000
Subject: [PATCH v2 5/7] diffcore-rename, merge-ort: add wrapper functions for
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
index 5fd2a4ccd35..59428e45884 100644
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

