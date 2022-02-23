Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CDA9C4332F
	for <git@archiver.kernel.org>; Wed, 23 Feb 2022 18:25:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243855AbiBWS0L (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Feb 2022 13:26:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243848AbiBWSZw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Feb 2022 13:25:52 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 249C54AE08
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 10:25:24 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id c192so14297565wma.4
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 10:25:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=fqoCza8Vg8xn4hC9kZQfbeXf7/jb1S/78yAQODWVUcE=;
        b=hYnmJ+a0xz0UI47hGxwcJU/gV7ZOwQVUQL+tl2TnuZCznUrXzlOZ8J66Cviur9kh0E
         k1duvLgpNEunA4DVJGkNgjE6JNNltERM8NSAGnoP6VrKSuOinvhzkl2ebhgZj0MrUGpo
         Qd5qBUJcoj1A6PvvI9zrcuCXP7bM4es+6X+gQECVjzzRBEI/6rCyeFwZ+rayCRSAZwkV
         jP87ciqnozhSOXWk0y2tMVmGJKMsytqkWNDMSI46/8lPjWOKMv4rrrJLsEUFlfHzUNCb
         VIgdmcAKpH8exazdPvN6Iu3eiRXs874n338WK0DmiLTFT9UIhJGU4FndBBatqNxtLqx1
         5OLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=fqoCza8Vg8xn4hC9kZQfbeXf7/jb1S/78yAQODWVUcE=;
        b=hD/RUfovzBjhhjflSv9LNHwtkUi1t3umC1+bq6UaEIQhIql28/WVqF/xvkA3yqwjcM
         gLL0H/g7vZzhTO43lcZyelXPqyAcZ4S78CYu0a1+lw2NJwpYYTEjEBcPEOy9AjstZrvt
         d7MBhvY+azC2QroPNYqCW5N7NJOfRMDD2Mz1zZUMoKpdi/+avNweuRrqdaeruYlFCyDv
         V9Fgm/1kefzZ8iytnqvsd/+35DiMi/HFhwgREmGuftnjONjsYV1+xx+RVLPGiVPxRU5/
         2Zsh9RMx/oPDwiX71ph05gqarCektBHT7xqwJdWzSYGF7t++nRU9PykoF5S+dsacjEb7
         JCgA==
X-Gm-Message-State: AOAM532LLV+nxCy6o87cTs3WR7KtkEvDmCz9gYHxLGwi0NZ7KDYpadXO
        zDkf27ziG6XXzmyMWAk9/uOKtdqOfa8=
X-Google-Smtp-Source: ABdhPJwvRIEeks35POBQSOFXwUodpfwgqkwnRKgCOW68JHjFEaEvzDL8Qn1Io000J7wYB7Gj41gWfg==
X-Received: by 2002:a1c:1907:0:b0:380:f6ec:4daa with SMTP id 7-20020a1c1907000000b00380f6ec4daamr3298013wmz.50.1645640722581;
        Wed, 23 Feb 2022 10:25:22 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b16sm261461wmj.32.2022.02.23.10.25.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 10:25:22 -0800 (PST)
Message-Id: <bea482b6b28df8522aa64ab757616bbcdb84bbec.1645640717.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1157.git.1645640717.gitgitgadget@gmail.com>
References: <pull.1157.git.1645640717.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 23 Feb 2022 18:25:14 +0000
Subject: [PATCH 5/7] read-tree: narrow scope of index expansion for '--prefix'
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     "mailto:stolee@gmail.com" <[stolee@gmail.com]@vger.kernel.org>,
        "mailto:newren@gmail.com" <[newren@gmail.com]@vger.kernel.org>,
        "mailto:gitster@pobox.com" <[gitster@pobox.com]@vger.kernel.org>,
        Victoria Dye <vdye@github.com>, Victoria Dye <vdye@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Victoria Dye <vdye@github.com>

When 'git read-tree' is provided with a prefix, expand the index only if the
prefix is equivalent to a sparse directory or contained within one. If the
index is not expanded in these cases, 'ce_in_traverse_path' will indicate
that the relevant sparse directory is not in the prefix/traverse path,
skipping past it and not unpacking the appropriate tree(s).

If the prefix is in-cone, its sparse subdirectories (if any) will be
traversed correctly without index expansion.

Signed-off-by: Victoria Dye <vdye@github.com>
---
 builtin/read-tree.c                      |  3 +--
 t/t1092-sparse-checkout-compatibility.sh |  8 ++++++-
 unpack-trees.c                           | 30 ++++++++++++++++++++++++
 3 files changed, 38 insertions(+), 3 deletions(-)

diff --git a/builtin/read-tree.c b/builtin/read-tree.c
index c2fdbc2657f..a7b7f822281 100644
--- a/builtin/read-tree.c
+++ b/builtin/read-tree.c
@@ -213,8 +213,7 @@ int cmd_read_tree(int argc, const char **argv, const char *cmd_prefix)
 	if (opts.merge && !opts.index_only)
 		setup_work_tree();
 
-	/* TODO: audit sparse index behavior in unpack_trees */
-	if (opts.skip_sparse_checkout || opts.prefix)
+	if (opts.skip_sparse_checkout)
 		ensure_full_index(&the_index);
 
 	if (opts.merge) {
diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index ae44451a0a9..a404be0a10f 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -1415,7 +1415,13 @@ test_expect_success 'sparse index is not expanded: read-tree' '
 	do
 		ensure_not_expanded read-tree -mu $MERGE_TREES &&
 		ensure_not_expanded reset --hard HEAD || return 1
-	done
+	done &&
+
+	rm -rf sparse-index/deep/deeper2 &&
+	ensure_not_expanded add . &&
+	ensure_not_expanded commit -m "test" &&
+
+	ensure_not_expanded read-tree --prefix=deep/deeper2 -u deepest
 '
 
 test_expect_success 'ls-files' '
diff --git a/unpack-trees.c b/unpack-trees.c
index 360844bda3a..dba122a02bb 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1739,6 +1739,36 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 		setup_standard_excludes(o->dir);
 	}
 
+	/*
+	 * If the prefix is equal to or contained within a sparse directory, the
+	 * index needs to be expanded to traverse with the specified prefix.
+	 */
+	if (o->prefix && o->src_index->sparse_index) {
+		int prefix_len = strlen(o->prefix);
+
+		while (prefix_len > 0 && o->prefix[prefix_len - 1] == '/')
+			prefix_len--;
+
+		if (prefix_len > 0) {
+			struct strbuf ce_prefix = STRBUF_INIT;
+			strbuf_grow(&ce_prefix, prefix_len + 1);
+			strbuf_add(&ce_prefix, o->prefix, prefix_len);
+			strbuf_addch(&ce_prefix, '/');
+
+			/*
+			 * If the prefix is not inside the sparse cone, then the
+			 * index is explicitly expanded if it is found as a sparse
+			 * directory, or implicitly expanded (by 'index_name_pos')
+			 * if the path is inside a sparse directory.
+			 */
+			if (!path_in_cone_mode_sparse_checkout(ce_prefix.buf, o->src_index) &&
+			    index_name_pos(o->src_index, ce_prefix.buf, ce_prefix.len) >= 0)
+				ensure_full_index(o->src_index);
+
+			strbuf_release(&ce_prefix);
+		}
+	}
+
 	if (!core_apply_sparse_checkout || !o->update)
 		o->skip_sparse_checkout = 1;
 	if (!o->skip_sparse_checkout && !o->pl) {
-- 
gitgitgadget

