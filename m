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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 537F1C11F66
	for <git@archiver.kernel.org>; Tue, 29 Jun 2021 01:51:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3CAE861CD7
	for <git@archiver.kernel.org>; Tue, 29 Jun 2021 01:51:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231133AbhF2ByP (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Jun 2021 21:54:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229936AbhF2ByN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Jun 2021 21:54:13 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CACDC061760
        for <git@vger.kernel.org>; Mon, 28 Jun 2021 18:51:46 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id u11so23618187wrw.11
        for <git@vger.kernel.org>; Mon, 28 Jun 2021 18:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=cO98IPJ5A+rusUCsSXexJohE9wZWdkoHGqzHKeEQ398=;
        b=YcBzHoRBsFr3k6chpG+8uP5GuuhrZlagFipIRZvJu/4q/PJG1cYVIPtnGJQvIxH0DO
         6RI7jfUYaFLzVnHqXi0RV9mq9p0pz5qy+WSlJBdhvyDqk58e5ZRFm3moY2JAjGJI9MUQ
         nc7dlgPIyPZWO82DtJMCYXllxnPNrqwEiFpY8vnQYaU3yCXjg/vmnPRm2KNH3dX9cB9o
         eBeRgY+z6nGH9yhOefknL9SEPxTQjjN4Wr6D2nGl8RVsi1eqgMgBel9NtYtTm2303zK1
         s2ecb61cOVeMjwWxMz5AjnBIk+BiPaQSiufyjizHASyosGuSo/lYQ4eIf78IGAudOkyI
         UC5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=cO98IPJ5A+rusUCsSXexJohE9wZWdkoHGqzHKeEQ398=;
        b=XMKK+wjKXxalbaqN6ZUyNQMa6fJko5j31XpZUbhjGRP2VT4zNKkcLJSwXh+efI/tt7
         GiUMYYvyMiZwjn6HK4zfO/dqTfNcm3FvUU7ZM7Ot4n1FClZoutC91vNvtnZjaITJRy9+
         FezdrXS+Mgyzv5HGwzgoE5GJWVXNuPRt0kzjy0Zy2SiqXGiObpnfzwOUa3HETLAUigqd
         NZFNAll25W33rguKjUvJiG0phdvRdiR5xx/wCkaUt/JilcgauqUAbHLTaZtFIYcTlTt/
         wpyNqL3oA0/+JxQaSlX3dEN+d8Pm6qQi4JLwoKVVXHhhJ1/WNOwesLOhtrE3z3tCpv2h
         p9DQ==
X-Gm-Message-State: AOAM530SgEDdejB4jnSop8FYECciBRzOp2NQx+qosT4f2z+0cPAxUnPY
        52hMEBdgwO9h3IRFEjHkRJ6jjrtdU8Q=
X-Google-Smtp-Source: ABdhPJzOG4ZO7XVNAaun0se3YjUyI0bGRtx4xWKMFvUb7PrErenBdkGhT/3gcPPNi34l76DKDwlX+g==
X-Received: by 2002:a5d:6a51:: with SMTP id t17mr5550912wrw.255.1624931504621;
        Mon, 28 Jun 2021 18:51:44 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t9sm15479143wmq.14.2021.06.28.18.51.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jun 2021 18:51:44 -0700 (PDT)
Message-Id: <2a4a7256304c44f168baf54ff1bdc191be67408f.1624931502.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.932.v6.git.1624931502.gitgitgadget@gmail.com>
References: <pull.932.v5.git.1623069252.gitgitgadget@gmail.com>
        <pull.932.v6.git.1624931502.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 29 Jun 2021 01:51:29 +0000
Subject: [PATCH v6 01/14] sparse-index: skip indexes with unmerged entries
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

The sparse-index format is designed to be compatible with merge
conflicts, even those outside the sparse-checkout definition. The reason
is that when converting a full index to a sparse one, a cache entry with
nonzero stage will not be collapsed into a sparse directory entry.

However, this behavior was not tested, and a different behavior within
convert_to_sparse() fails in this scenario. Specifically,
cache_tree_update() will fail when unmerged entries exist.
convert_to_sparse_rec() uses the cache-tree data to recursively walk the
tree structure, but also to compute the OIDs used in the
sparse-directory entries.

Add an index scan to convert_to_sparse() that will detect if these merge
conflict entries exist and skip the conversion before trying to update
the cache-tree. This is marked as NEEDSWORK because this can be removed
with a suitable update to cache_tree_update() or a similar method that
can construct a cache-tree with invalid nodes, but still allow creating
the nodes necessary for creating sparse directory entries.

It is possible that in the future we will not need to make such an
update, since if we do not expand a sparse-index into a full one, this
conversion does not need to happen. Thus, this can be deferred until the
merge machinery is made to integrate with the sparse-index.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 sparse-index.c                           | 18 ++++++++++++++++++
 t/t1092-sparse-checkout-compatibility.sh | 22 ++++++++++++++++++++++
 2 files changed, 40 insertions(+)

diff --git a/sparse-index.c b/sparse-index.c
index affc4048f27..2c695930275 100644
--- a/sparse-index.c
+++ b/sparse-index.c
@@ -116,6 +116,17 @@ int set_sparse_index_config(struct repository *repo, int enable)
 	return res;
 }
 
+static int index_has_unmerged_entries(struct index_state *istate)
+{
+	int i;
+	for (i = 0; i < istate->cache_nr; i++) {
+		if (ce_stage(istate->cache[i]))
+			return 1;
+	}
+
+	return 0;
+}
+
 int convert_to_sparse(struct index_state *istate)
 {
 	int test_env;
@@ -152,6 +163,13 @@ int convert_to_sparse(struct index_state *istate)
 		return -1;
 	}
 
+	/*
+	 * NEEDSWORK: If we have unmerged entries, then stay full.
+	 * Unmerged entries prevent the cache-tree extension from working.
+	 */
+	if (index_has_unmerged_entries(istate))
+		return 0;
+
 	if (cache_tree_update(istate, 0)) {
 		warning(_("unable to update cache-tree, staying full"));
 		return -1;
diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index e9a815ca7aa..ba2fd94adaf 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -352,6 +352,28 @@ test_expect_success 'merge with outside renames' '
 	done
 '
 
+# Sparse-index fails to convert the index in the
+# final 'git cherry-pick' command.
+test_expect_success 'cherry-pick with conflicts' '
+	init_repos &&
+
+	write_script edit-conflict <<-\EOF &&
+	echo $1 >conflict
+	EOF
+
+	test_all_match git checkout -b to-cherry-pick &&
+	run_on_all ../edit-conflict ABC &&
+	test_all_match git add conflict &&
+	test_all_match git commit -m "conflict to pick" &&
+
+	test_all_match git checkout -B base HEAD~1 &&
+	run_on_all ../edit-conflict DEF &&
+	test_all_match git add conflict &&
+	test_all_match git commit -m "conflict in base" &&
+
+	test_all_match test_must_fail git cherry-pick to-cherry-pick
+'
+
 test_expect_success 'clean' '
 	init_repos &&
 
-- 
gitgitgadget

