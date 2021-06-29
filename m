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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 003C6C11F64
	for <git@archiver.kernel.org>; Tue, 29 Jun 2021 01:52:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DAFF361CA3
	for <git@archiver.kernel.org>; Tue, 29 Jun 2021 01:52:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230461AbhF2Byn (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Jun 2021 21:54:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231438AbhF2ByX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Jun 2021 21:54:23 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0680C0617AE
        for <git@vger.kernel.org>; Mon, 28 Jun 2021 18:51:52 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id u11so23618455wrw.11
        for <git@vger.kernel.org>; Mon, 28 Jun 2021 18:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=WX6vm+pB/oRDYTBvwe01sJEK6/dnRyi7uGURBFpaEWs=;
        b=cv7etHr/6u/Ight8gZuM5enqj1FzPY7guJYcYUMwL+R4Ahndq6izVfJ6I2PamHcOxJ
         UZ3lDhHe0dF1j2yes8WivneDafOFGH93IOL5HpC0NEXNaaPEqcZXOoRCnsJEQCWAEaJX
         xrjC1noqv5XsswB5mao3v77COq6o6RslvhcB4BCcOr2UPxL79UgyF5ANRvxQXA29KrHu
         JeVoUBLWvc5rsAo3x2UP/fh4FtW0OKAh1ESASSRPVLBpjvs6mrt5O11AJsypSoiY/moI
         OfRCI5F2jcjhiu2ZVlyPM65EMAPAw3cjPrA2pFW8Gu9comDdv9Psaz1KyFaIX+C5081P
         Efng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=WX6vm+pB/oRDYTBvwe01sJEK6/dnRyi7uGURBFpaEWs=;
        b=WbHq+QFFkkOWhi5CnQuaOOyjcEaV5u91BIDf17flRJYd6lNe3RP5S6donNoAahjWFf
         ZMbpJrAT1gi6jQYS7vSYTIUekvbZc4nr6lNAmbEE2GOcPLbRCO/AKboAj+Cq5+WdPBCg
         afs7GO4QQddXsiPZyjQESX2L+XOaqf7ST8iRtdvI4UjyYZ94zWXWkfD4Gv5drZkFHb+q
         Y/xFvIWqbII4nzO0sa3xth/u0CYzpZzSg5c6spGNFnIht5DmU/FRxwb5jAkWTL55SI2B
         oHb9Bw+yI3G+ETqH8vG1Hd4Gfa73y+xM/wFcxIXhDrVYHGZRSfPp9gmucnGXX4UdEzes
         VPWA==
X-Gm-Message-State: AOAM531a26ra3gUtbZoCEt884UWRyT9mEjznuOpKE7DDBxKK4OfUi1xp
        hJ4JFuOHJOvfj0PdtW+hzvCtuGNSuA0=
X-Google-Smtp-Source: ABdhPJw7OsJtV0m9mLyWp3QPn5aNzZ5wsZbXyq0OeLEkNB9Qv7RQwC5Zd8i12hmxFAfR+nMgfnbjkA==
X-Received: by 2002:a5d:46cc:: with SMTP id g12mr13888164wrs.136.1624931511523;
        Mon, 28 Jun 2021 18:51:51 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o11sm1531108wmc.2.2021.06.28.18.51.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jun 2021 18:51:51 -0700 (PDT)
Message-Id: <08225483d699514426d4ddaf268338e09ea4e8bb.1624931503.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.932.v6.git.1624931502.gitgitgadget@gmail.com>
References: <pull.932.v5.git.1623069252.gitgitgadget@gmail.com>
        <pull.932.v6.git.1624931502.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 29 Jun 2021 01:51:41 +0000
Subject: [PATCH v6 13/14] wt-status: expand added sparse directory entries
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, newren@gmail.com,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Derrick Stolee <stolee@gmail.com>, git@jeffhostetler.com,
        johannes.schindelin@gmx.de,
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

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 t/t1092-sparse-checkout-compatibility.sh | 33 ++++++++++++++++
 wt-status.c                              | 49 ++++++++++++++++++++++++
 2 files changed, 82 insertions(+)

diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index 1e9737cb4b7..ef918437908 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -521,4 +521,37 @@ test_expect_success 'sparse-index is not expanded' '
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
index 96db3e74962..a90c7b6aa8a 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -657,6 +657,34 @@ static void wt_status_collect_changes_index(struct wt_status *s)
 	clear_pathspec(&rev.prune_data);
 }
 
+static int add_file_to_list(const struct object_id *oid,
+			    struct strbuf *base, const char *path,
+			    unsigned int mode, void *context)
+{
+	struct string_list_item *it;
+	struct wt_status_change_data *d;
+	struct wt_status *s = context;
+	char *full_name;
+
+	if (S_ISDIR(mode))
+		return READ_TREE_RECURSIVE;
+
+	full_name = xstrfmt("%s%s", base->buf, path);
+	it = string_list_insert(&s->change, full_name);
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
+	return 0;
+}
+
 static void wt_status_collect_changes_initial(struct wt_status *s)
 {
 	struct index_state *istate = s->repo->index;
@@ -671,6 +699,27 @@ static void wt_status_collect_changes_initial(struct wt_status *s)
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

