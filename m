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
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF87AC43461
	for <git@archiver.kernel.org>; Fri, 14 May 2021 18:31:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B5648613EB
	for <git@archiver.kernel.org>; Fri, 14 May 2021 18:31:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235340AbhENScs (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 May 2021 14:32:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233808AbhENSch (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 May 2021 14:32:37 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91DBFC06138E
        for <git@vger.kernel.org>; Fri, 14 May 2021 11:31:24 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id x8so152174wrq.9
        for <git@vger.kernel.org>; Fri, 14 May 2021 11:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=jWoJaiihOFErJJTdCshSCWDCsuIYLvVcwyV8zTPU6cQ=;
        b=Fa+HDuoypsoLHPg44OH2Jq18lfl+J6qXC9ukFH2QPYOsJu4WBP6hRiUYH76XQJf4nR
         GAyqtJnVfRlLrslwp8nUJTgJ/Vglf/bP/MvAAzzKuyAm2Z+qmu9gMrsKTAvrec/0Ndav
         gzI6h0C5kyfpx6wY8NbiTI9rBJMOM0VaI+ZUQLHaoLCyLu+S1Y4OgpLzyRqzf/1qXQzB
         7TbKz4Dn6y5CExS37MFKuOEibZ6qwvS9NZdBM+qblqlUvtT89r9CvkWmklR0UdAm/YRR
         /q7dom5G5hSqIJGZYpkjoigVnH34FNpx+0OiSdYfItJm0oj7HorN1VGjRVWThHngaoLB
         zSVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=jWoJaiihOFErJJTdCshSCWDCsuIYLvVcwyV8zTPU6cQ=;
        b=ejxrBJZqp9BD1p11wvgl663MfvtkpJDcp+xxOg7xU0GraW7e0DmrVJ+jFhqbZZtdjZ
         7MezBK9w+Kgd2S6pOWXcFT57DdKb7YvkPdUlDMKFs44zgTx9gMLN5xY+MIvYvYIFkq1q
         eO/qe2A5lAEWhHkCQIig37JacLhE4GBu0fLIFl2uaBmxjM5HzBDcuWXCpQWIZzkllv1Y
         t0dNldTLFmKuP10I3+JsHS1uWd+QL3AzuF3XVq+8OkLCHdPjf1pukF3z9TKo0RULw17S
         BL8IwSCQ+VU7ScSWc6nxMO1rrKXfzTnPaSXm6heTPgq9GKhHDeTdhTL996ngPDsJjHXt
         KKLw==
X-Gm-Message-State: AOAM532cOagflENaNXgkMkGVSs+pmOeoIxKPwwIf0kDSyYHY/sS2zw2X
        jO1n3oXuLNROkIzu9ESKC9YQj2qCcjQ=
X-Google-Smtp-Source: ABdhPJxUdzwIO6FgT9ULz/IT7X0aIu4KkiHuN/FgrBOTKj5HQ3knub6cFvnTaZo3kOo8/XAmTVKF4Q==
X-Received: by 2002:a05:6000:186a:: with SMTP id d10mr61355685wri.41.1621017083323;
        Fri, 14 May 2021 11:31:23 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s7sm12009490wmh.35.2021.05.14.11.31.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 May 2021 11:31:22 -0700 (PDT)
Message-Id: <3b42783d4a86473420480b2789d61d8103e6e7d4.1621017072.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.932.v3.git.1621017072.gitgitgadget@gmail.com>
References: <pull.932.v2.git.1619213665.gitgitgadget@gmail.com>
        <pull.932.v3.git.1621017072.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 14 May 2021 18:31:10 +0000
Subject: [PATCH v3 11/12] wt-status: expand added sparse directory entries
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

