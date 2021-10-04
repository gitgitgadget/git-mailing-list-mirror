Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A68E5C4167E
	for <git@archiver.kernel.org>; Mon,  4 Oct 2021 00:46:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8FF22610CC
	for <git@archiver.kernel.org>; Mon,  4 Oct 2021 00:46:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232068AbhJDAsU (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 3 Oct 2021 20:48:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232017AbhJDAsO (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Oct 2021 20:48:14 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2E4EC061786
        for <git@vger.kernel.org>; Sun,  3 Oct 2021 17:46:23 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id m22so22089094wrb.0
        for <git@vger.kernel.org>; Sun, 03 Oct 2021 17:46:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9nVZBfOfRQxVn39jyMFXapk1NHhUOqWXQYsM8w3j/SE=;
        b=mzZUNGrJj/dP6dJugq+Hffx/vY6XrQT0EwJD7ucc6ahrzLJU+NYw0PB8fCRlAZloRa
         UyV+yEjavpg1rxc+73Vvg5LE6leT5XUFwMGSJU6nsuja7lkrtXj/desvygJvbIienUHC
         xD89eA/H+5TJVPxq7WmLbZFbcwlkFTdp8kpz1mi0fT+sUG1uHpDqWmEsbZ2lQV8JqgCT
         CfSw54a7qMqyRIy3D+iMIVPcQ7EpT49hUBqrMqFTu60Po+dlBqR5oGbPXjVLl64rwln5
         yMMPSivSoJTS5TpzO7mXYABIRJ1jy98EUGvBNYxHhcfgFsRe2MrEaH1zZw9OQB7Yp11G
         KGRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9nVZBfOfRQxVn39jyMFXapk1NHhUOqWXQYsM8w3j/SE=;
        b=76u4Hg64zLJWFHVSWJampapsyRYYILmdx4m4mRXyxGLRoqvMVbm1PTMKHKp40ikOmz
         /07qwDpbOchFlZoKQxH21VF+BcB2A2WKh8PoD8FqbPazOR9J4Xzx4YJoK/XX1zMcou/Q
         fzL63DQZAJXBZRg+ko0WM38dXibkyD9EHYtydyK+LO5MSXk28Nz5+vP/SLVLtPC0ABjX
         SHtZHKi4cMNRnYrVkI2XQxJ/fs6e3mRn4rc4pC3Dn2CaIs77KSoUFP3q/i2cIK9qqqbe
         dq2lGNGfUNlU8jIy6D8s3x88X18LxISD953X5eBrFZ/VcuyBaysya/crdHqRBxwdmpKn
         x+og==
X-Gm-Message-State: AOAM5337Ed7UkTqemc3tadXP/8LNSUp6TmVgkFJZM/pqO2JjwzoUPZQt
        R/ExZZDNrwe3V9V+//F3KgQGc6Xmv9f+zA==
X-Google-Smtp-Source: ABdhPJwcHJnddbcotu8PSp6t3bCVU6v7HqMq+HjoOOqc0IJCTduA0itETTXpSfo47wiNMb/xCu9CXQ==
X-Received: by 2002:adf:d0cc:: with SMTP id z12mr10808438wrh.72.1633308381357;
        Sun, 03 Oct 2021 17:46:21 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id q7sm13526773wrc.55.2021.10.03.17.46.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Oct 2021 17:46:20 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Andrzej Hunt <ajrhunt@google.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 07/10] unpack-trees API: rename clear_unpack_trees_porcelain()
Date:   Mon,  4 Oct 2021 02:46:08 +0200
Message-Id: <patch-07.10-646e610d8dd-20211004T002226Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1404.g83021034c5d
In-Reply-To: <cover-00.10-00000000000-20211004T002226Z-avarab@gmail.com>
References: <cover-00.10-00000000000-20211004T002226Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since a preceding commit we've been using
clear_unpack_trees_porcelain() to call dir_clear(). So it's no longer
a function that corresponds to setup_unpack_trees_porcelain(), as it
was when it was added in 1c41d2805e4 (unpack_trees_options: free
messages when done, 2018-05-21).

Instead it's similar to strbuf_release() and other similar generic
"free" functions. Let's rename it to avoid any future confusion on the
topic.

Let's also update the API documentation for it to note this, and to
cover e.g. the code added around update_sparsity() in
4ee5d50fc39 (sparse-checkout: use improved unpack_trees porcelain
messages, 2020-03-27).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/checkout.c        | 2 +-
 builtin/sparse-checkout.c | 2 +-
 merge-ort.c               | 2 +-
 merge-recursive.c         | 2 +-
 merge.c                   | 4 ++--
 reset.c                   | 2 +-
 unpack-trees.c            | 2 +-
 unpack-trees.h            | 8 +++++---
 8 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index d4b88affba7..482d17676a0 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -757,7 +757,7 @@ static int merge_working_tree(const struct checkout_opts *opts,
 		init_tree_desc(&trees[1], tree->buffer, tree->size);
 
 		ret = unpack_trees(2, trees, &topts);
-		clear_unpack_trees_porcelain(&topts);
+		unpack_trees_options_release(&topts);
 		if (ret == -1) {
 			/*
 			 * Unpack couldn't do a trivial merge; either
diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index 4c3c29fb580..b1221fd01d3 100644
--- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -219,7 +219,7 @@ static int update_working_directory(struct pattern_list *pl)
 
 	setup_unpack_trees_porcelain(&o, "sparse-checkout");
 	result = update_sparsity(&o);
-	clear_unpack_trees_porcelain(&o);
+	unpack_trees_options_release(&o);
 
 	if (result == UPDATE_SPARSITY_WARNINGS)
 		/*
diff --git a/merge-ort.c b/merge-ort.c
index e526b78b88d..0a5937364c9 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -4054,7 +4054,7 @@ static int checkout(struct merge_options *opt,
 	init_tree_desc(&trees[1], next->buffer, next->size);
 
 	ret = unpack_trees(2, trees, &unpack_opts);
-	clear_unpack_trees_porcelain(&unpack_opts);
+	unpack_trees_options_release(&unpack_opts);
 	return ret;
 }
 
diff --git a/merge-recursive.c b/merge-recursive.c
index a77f66b006c..316cb2ca907 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -441,7 +441,7 @@ static int unpack_trees_start(struct merge_options *opt,
 static void unpack_trees_finish(struct merge_options *opt)
 {
 	discard_index(&opt->priv->orig_index);
-	clear_unpack_trees_porcelain(&opt->priv->unpack_opts);
+	unpack_trees_options_release(&opt->priv->unpack_opts);
 	unpack_trees_options_init(&opt->priv->unpack_opts);
 }
 
diff --git a/merge.c b/merge.c
index 9cb32990dd9..2f618425aff 100644
--- a/merge.c
+++ b/merge.c
@@ -95,10 +95,10 @@ int checkout_fast_forward(struct repository *r,
 
 	if (unpack_trees(nr_trees, t, &opts)) {
 		rollback_lock_file(&lock_file);
-		clear_unpack_trees_porcelain(&opts);
+		unpack_trees_options_release(&opts);
 		return -1;
 	}
-	clear_unpack_trees_porcelain(&opts);
+	unpack_trees_options_release(&opts);
 
 	if (write_locked_index(r->index, &lock_file, COMMIT_LOCK))
 		return error(_("unable to write new index file"));
diff --git a/reset.c b/reset.c
index d13984ab781..f4bf3fbfac0 100644
--- a/reset.c
+++ b/reset.c
@@ -133,7 +133,7 @@ int reset_head(struct repository *r, struct object_id *oid, const char *action,
 leave_reset_head:
 	strbuf_release(&msg);
 	rollback_lock_file(&lock);
-	clear_unpack_trees_porcelain(&unpack_tree_opts);
+	unpack_trees_options_release(&unpack_tree_opts);
 	while (nr)
 		free((void *)desc[--nr].buffer);
 	return ret;
diff --git a/unpack-trees.c b/unpack-trees.c
index e7365322e82..bea598c9ece 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -193,7 +193,7 @@ void unpack_trees_options_init(struct unpack_trees_options *o)
 	memcpy(o, &blank, sizeof(*o));
 }
 
-void clear_unpack_trees_porcelain(struct unpack_trees_options *opts)
+void unpack_trees_options_release(struct unpack_trees_options *opts)
 {
 	strvec_clear(&opts->msgs_to_free);
 	dir_clear(&opts->dir);
diff --git a/unpack-trees.h b/unpack-trees.h
index 40c4841748d..a8d1f083b33 100644
--- a/unpack-trees.h
+++ b/unpack-trees.h
@@ -41,10 +41,12 @@ enum unpack_trees_error_types {
 void setup_unpack_trees_porcelain(struct unpack_trees_options *opts,
 				  const char *cmd);
 
-/*
- * Frees resources allocated by setup_unpack_trees_porcelain().
+/**
+ * Frees resources allocated by function that take the "struct
+ * unpack_trees_options". Always call this after using unpack_trees(),
+ * update_sparsity() etc.
  */
-void clear_unpack_trees_porcelain(struct unpack_trees_options *opts);
+void unpack_trees_options_release(struct unpack_trees_options *opts);
 
 struct unpack_trees_options {
 	unsigned int reset,
-- 
2.33.0.1404.g83021034c5d

