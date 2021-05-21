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
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1E23C43462
	for <git@archiver.kernel.org>; Fri, 21 May 2021 12:00:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE08A613DB
	for <git@archiver.kernel.org>; Fri, 21 May 2021 12:00:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235148AbhEUMBx (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 May 2021 08:01:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233238AbhEUMBR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 May 2021 08:01:17 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28706C061342
        for <git@vger.kernel.org>; Fri, 21 May 2021 04:59:51 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id i17so20791458wrq.11
        for <git@vger.kernel.org>; Fri, 21 May 2021 04:59:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=jWoJaiihOFErJJTdCshSCWDCsuIYLvVcwyV8zTPU6cQ=;
        b=ahpSKqFhwH+/YCU5veGzQFl8AphRvvD07KvI0RbgjQy4kJ9iMkV3E+3/HFpzzma7Jo
         DTvzN8cbAHrL+hFe5UMhuemsml7bw/7llLdH5zVVoeZsriQHqjZkxKNj8iTUsIKPtrTp
         a7dSeCFTcjhytiws1BlNlBwaZaM9uj/l1TysQ/q6iVi+xvSdqGUDLD4nYxYvCp9mRtf5
         tLANLCbsnAOCJuk+fOKg1SMUjHsnEhwtjwwhFIHvgrg/DgCxRJ3fHzhekUnPEptgc6C/
         88HoMoC7g5ZnQpKlNoz0ei6GNmAD1V654Sx4uXvKERG8OL/OsK+1tIuqJQoi9sRUsrsI
         bd2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=jWoJaiihOFErJJTdCshSCWDCsuIYLvVcwyV8zTPU6cQ=;
        b=tT6pUExSiyJMaxGIJZdn4L4f0NOn7j0XSG3Fa8mdpWiYanh1UwdViDleACdd81MO1V
         pTaXzaUTZYejMEJUHkmj7YYEpWaGI1e4idGnkMTrn/ybN8qFBf1BvdAM5lDYSWe8CEsF
         0WoegziaHusFuqBPnFHWJvkaSgHUlj2ET3Vg5npliTTcLSbJsPj3aLIqdYuLVvPRHhYO
         ZbkxMTwjELZpzkx3UTLt+BvDZIOV66kU1qStgfJOT4ehrh4Xy/FUuX6DW612+4Q9pbhU
         RIhrC+ZNV1HgXjnjAO4nqZcbNwIQAInlKllWjhxvJZU5NXhXfKzwzgXcWCcH4Ohvdj58
         MQtA==
X-Gm-Message-State: AOAM5304X2jflklLAy1El19317iUcOidvoQMMML96jByxz2HirT/yBMZ
        abVSqRMK0bX8JHOztW/gA87pFC5mfuA=
X-Google-Smtp-Source: ABdhPJx5wKValg3Mg583+gkxriQxwWkkGr1Y8R9kFJd4m4vRJMg4DUMx1PVE8a/mgWsXeSoBI4/2qQ==
X-Received: by 2002:adf:e987:: with SMTP id h7mr2062751wrm.347.1621598389737;
        Fri, 21 May 2021 04:59:49 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y2sm14084974wmq.45.2021.05.21.04.59.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 May 2021 04:59:49 -0700 (PDT)
Message-Id: <24417e095243979b13acde785a5bbd79145b050d.1621598382.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.932.v4.git.1621598382.gitgitgadget@gmail.com>
References: <pull.932.v3.git.1621017072.gitgitgadget@gmail.com>
        <pull.932.v4.git.1621598382.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 21 May 2021 11:59:40 +0000
Subject: [PATCH v4 11/12] wt-status: expand added sparse directory entries
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, newren@gmail.com,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Derrick Stolee <stolee@gmail.com>,
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
 t/t1092-sparse-checkout-compatibility.sh | 28 +++++++++++++
 wt-status.c                              | 50 ++++++++++++++++++++++++
 2 files changed, 78 insertions(+)

diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index 59faf7381093..cd3669d36b53 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -492,4 +492,32 @@ test_expect_success 'sparse-index is not expanded' '
 	test_region ! index ensure_full_index trace2.txt
 '
 
+test_expect_success 'reset mixed and checkout orphan' '
+	init_repos &&
+
+	test_all_match git checkout rename-out-to-in &&
+	test_all_match git reset --mixed HEAD~1 &&
+	test_sparse_match test-tool read-cache --table --expand &&
+	test_all_match git status --porcelain=v2 &&
+	test_all_match git status --porcelain=v2 &&
+
+	# At this point, sparse-checkouts behave differently
+	# from the full-checkout.
+	test_sparse_match git checkout --orphan new-branch &&
+	test_sparse_match test-tool read-cache --table --expand &&
+	test_sparse_match git status --porcelain=v2 &&
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
+	test_all_match git status --porcelain=v2 &&
+	test_all_match git status --porcelain=v2
+'
+
 test_done
diff --git a/wt-status.c b/wt-status.c
index 0425169c1895..90db8bd659fa 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -654,6 +654,34 @@ static void wt_status_collect_changes_index(struct wt_status *s)
 	run_diff_index(&rev, 1);
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
@@ -668,6 +696,28 @@ static void wt_status_collect_changes_initial(struct wt_status *s)
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
+			struct pathspec ps;
+			struct tree *tree = lookup_tree(istate->repo, &ce->oid);
+
+			memset(&ps, 0, sizeof(ps));
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

