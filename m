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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1DADC07E9A
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 13:12:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 89E89613B7
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 13:12:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239466AbhGNNPu (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Jul 2021 09:15:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239454AbhGNNPr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jul 2021 09:15:47 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4293C061765
        for <git@vger.kernel.org>; Wed, 14 Jul 2021 06:12:55 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id u5-20020a7bc0450000b02901480e40338bso3402099wmc.1
        for <git@vger.kernel.org>; Wed, 14 Jul 2021 06:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=OgbaHkl0gQIn/FFjaJHWrqbGaai3c+lYp+Excn1WmS0=;
        b=IikVF2VYnqjNV9WsGxzKBcHR/8MjrXaxztqL6Qtv1PKoTX12BsM6XFuk5l40hCWjXc
         h/6z45mBA+ROqPI70iPwD5YfYHm6guCujyUHFOUlonkFpogHaFwQZZTYtXQBl/BJCOSx
         FW/Q0XpFjBt/KPhLIOx3IN5yAd42cDbzz54cgjhW/9I3MCutM/JfVnw39od9dR4lTlCW
         s3mfCyMkOTodayIU9SxKUvCLprv6e+lw70GVULnUt4rhC6hY9rJrc9eB14XKiLnuPYe3
         zq4k51bjFCyBnR/PcQq3d0AfvPZUCpnji4gt7Z2Z9kRBZk0OBXT60U2xwCE0Fmo56Xh1
         3eWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=OgbaHkl0gQIn/FFjaJHWrqbGaai3c+lYp+Excn1WmS0=;
        b=j0o8IEKc6CJSgRexk5zd1wu13BCZ7N6JB84BMecasupQgANGne3JgysJ8y2C2XJxNB
         USOycv52Rl2x1UWvtrLYbH+9zt9mSEjqunOtinawbAXFFS/yYkhIRhorcOHUH4zYjTKU
         i8Styrh/N9gIHPbJ0xy1+vURIHiboz7QiqvCOq5ibGD8djH749wqWwoRypFR/Erwr8lb
         5x1F+rk8H7Yw6VPEg9nk62yrkSobeTgpswsA9Zic1M8DqdQc+gVKEG10XRrtw47eJg61
         p0hmylBd0eQOjR0afEcBi2Nlix5PFtpjivdjJalpx7QNbVhqPQ6u+iV4XpzEOlssanbf
         Rwnw==
X-Gm-Message-State: AOAM5332ShQaOx/UdtCptDIagDi6lAU0tKis1jVuqgbY4FkFhRnvb6nk
        ofsmBQvxaD4iErDcxmYn/UQ51fSITW8=
X-Google-Smtp-Source: ABdhPJyF2SGugLA1Gy0Jhgu9vD3YJmXP8kA5QjdjldgIELJ8BDoVTSxIND4CsOTBHS62vCrKVW/u2g==
X-Received: by 2002:a05:600c:2907:: with SMTP id i7mr4002510wmd.184.1626268374303;
        Wed, 14 Jul 2021 06:12:54 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y16sm2734807wrw.42.2021.07.14.06.12.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 06:12:53 -0700 (PDT)
Message-Id: <aa2258be302fc42763c2da2e3aeb7f66123ca5b9.1626268360.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.932.v9.git.1626268360.gitgitgadget@gmail.com>
References: <pull.932.v8.git.1626112556.gitgitgadget@gmail.com>
        <pull.932.v9.git.1626268360.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 14 Jul 2021 13:12:38 +0000
Subject: [PATCH v9 14/16] wt-status: expand added sparse directory entries
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, newren@gmail.com,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Derrick Stolee <stolee@gmail.com>, git@jeffhostetler.com,
        johannes.schindelin@gmx.de, Bagas Sanjaya <bagasdotme@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

It is difficult, but possible, to get into a state where we intend to
add a directory that is outside of the sparse-checkout definition. Add a
test to t1092-sparse-checkout-compatibility.sh that demonstrates this
using a combination of 'git reset --mixed' and 'git checkout --orphan'.

This test failed before because the output of 'git status
--porcelain=v2' would not match on the lines for folder1/:

* The sparse-checkout repo (with a full index) would output each path
  name that is intended to be added.

* The sparse-index repo would only output that "folder1/" is staged for
  addition.

The status should report the full list of files to be added, and so this
sparse-directory entry should be expanded to a full list when reaching
it inside the wt_status_collect_changes_initial() method. Use
read_tree_at() to assist.

Somehow, this loop over the cache entries was not guarded by
ensure_full_index() as intended.

Reviewed-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 t/t1092-sparse-checkout-compatibility.sh | 33 +++++++++++++++
 wt-status.c                              | 51 ++++++++++++++++++++++++
 2 files changed, 84 insertions(+)

diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index 751f397cc7f..2394c36d881 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -524,4 +524,37 @@ test_expect_success 'sparse-index is not expanded' '
 	test_region ! index ensure_full_index trace2.txt
 '
 
+test_expect_success 'reset mixed and checkout orphan' '
+	init_repos &&
+
+	test_all_match git checkout rename-out-to-in &&
+
+	# Sparse checkouts do not agree with full checkouts about
+	# how to report a directory/file conflict during a reset.
+	# This command would fail with test_all_match because the
+	# full checkout reports "T folder1/0/1" while a sparse
+	# checkout reports "D folder1/0/1". This matches because
+	# the sparse checkouts skip "adding" the other side of
+	# the conflict.
+	test_sparse_match git reset --mixed HEAD~1 &&
+	test_sparse_match test-tool read-cache --table --expand &&
+	test_sparse_match git status --porcelain=v2 &&
+
+	# At this point, sparse-checkouts behave differently
+	# from the full-checkout.
+	test_sparse_match git checkout --orphan new-branch &&
+	test_sparse_match test-tool read-cache --table --expand &&
+	test_sparse_match git status --porcelain=v2
+'
+
+test_expect_success 'add everything with deep new file' '
+	init_repos &&
+
+	run_on_sparse git sparse-checkout set deep/deeper1/deepest &&
+
+	run_on_all touch deep/deeper1/x &&
+	test_all_match git add . &&
+	test_all_match git status --porcelain=v2
+'
+
 test_done
diff --git a/wt-status.c b/wt-status.c
index 96db3e74962..0317baef87e 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -657,6 +657,36 @@ static void wt_status_collect_changes_index(struct wt_status *s)
 	clear_pathspec(&rev.prune_data);
 }
 
+static int add_file_to_list(const struct object_id *oid,
+			    struct strbuf *base, const char *path,
+			    unsigned int mode, void *context)
+{
+	struct string_list_item *it;
+	struct wt_status_change_data *d;
+	struct wt_status *s = context;
+	struct strbuf full_name = STRBUF_INIT;
+
+	if (S_ISDIR(mode))
+		return READ_TREE_RECURSIVE;
+
+	strbuf_add(&full_name, base->buf, base->len);
+	strbuf_addstr(&full_name, path);
+	it = string_list_insert(&s->change, full_name.buf);
+	d = it->util;
+	if (!d) {
+		CALLOC_ARRAY(d, 1);
+		it->util = d;
+	}
+
+	d->index_status = DIFF_STATUS_ADDED;
+	/* Leave {mode,oid}_head zero for adds. */
+	d->mode_index = mode;
+	oidcpy(&d->oid_index, oid);
+	s->committable = 1;
+	strbuf_release(&full_name);
+	return 0;
+}
+
 static void wt_status_collect_changes_initial(struct wt_status *s)
 {
 	struct index_state *istate = s->repo->index;
@@ -671,6 +701,27 @@ static void wt_status_collect_changes_initial(struct wt_status *s)
 			continue;
 		if (ce_intent_to_add(ce))
 			continue;
+		if (S_ISSPARSEDIR(ce->ce_mode)) {
+			/*
+			 * This is a sparse directory entry, so we want to collect all
+			 * of the added files within the tree. This requires recursively
+			 * expanding the trees to find the elements that are new in this
+			 * tree and marking them with DIFF_STATUS_ADDED.
+			 */
+			struct strbuf base = STRBUF_INIT;
+			struct pathspec ps = { 0 };
+			struct tree *tree = lookup_tree(istate->repo, &ce->oid);
+
+			ps.recursive = 1;
+			ps.has_wildcard = 1;
+			ps.max_depth = -1;
+
+			strbuf_add(&base, ce->name, ce->ce_namelen);
+			read_tree_at(istate->repo, tree, &base, &ps,
+				     add_file_to_list, s);
+			continue;
+		}
+
 		it = string_list_insert(&s->change, ce->name);
 		d = it->util;
 		if (!d) {
-- 
gitgitgadget

