Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA4E4C07E9A
	for <git@archiver.kernel.org>; Mon, 12 Jul 2021 17:56:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AEECB611C1
	for <git@archiver.kernel.org>; Mon, 12 Jul 2021 17:56:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235767AbhGLR6t (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Jul 2021 13:58:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233424AbhGLR6s (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jul 2021 13:58:48 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D8D9C0613DD
        for <git@vger.kernel.org>; Mon, 12 Jul 2021 10:56:00 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id k4so20482005wrc.8
        for <git@vger.kernel.org>; Mon, 12 Jul 2021 10:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=yFW7dZNC+/YWclWUbvDxvwl7KQSIbPaIV7bQgc6a3ok=;
        b=V+LLhsatwZD02Yh1hzTH92yEWXm38OnD0clMgNDCyXqJl446yAM3fRCVufEiR+LkEC
         COJB7vcc8UEcBzUkCiFvc5nQ3h3tXKmhQSEylDopoUiQq8eQVeik1ahKx4aDJPG3N0JC
         5Rwqq4CTpqRP3dUONy4vLEXD3/upXCi08B4DdXbPZYDwHjTlfjGoUjMzj0jtfnnqhhPA
         BAX0iC6+9PDkZajA/5LGKsJDZbR/2nc7zJdE6WFKXwAUQxG9aStvDEfFphZbm44pQxpX
         Q1xCgrlB8BVZZh1n23MPQdzJGZU5fu7LkkQug7H/ruVF12E3ljSM3xdr1fDTQtQFVaC8
         zbpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=yFW7dZNC+/YWclWUbvDxvwl7KQSIbPaIV7bQgc6a3ok=;
        b=LiyI9YmkawRyp00pAhDWWQZ0qqqrXzmcjZfqepDq7SQgF2J9kxDYxDkyk/qhXdF3pG
         3hLYuaffhuHguXIOGb650jPMdC+WCORxTU9Q1i4rr8yh25cWgnvyT7rTw47lWgVibVs4
         TqIHTmlu1bMbRbw2dGueWw+id/CLoC/hmAeSoT9PBeeKVW0NNPe5Ahgae57CgfAYs0xg
         ZqeSLCW4/YFwNBA9f4XLvlS6tF+f3RvngRgfIP6M0GtuhTOqhn80Y3QUu7lT6OcJ4GM9
         tio9pwTle06buGLI7QqKx0/lA0EFK7TGqm0JxRDZrX3bPVDu3VmTLJA+fuPH19s2pdxF
         7TYg==
X-Gm-Message-State: AOAM532tamQfdgfMYjhU8Lj19w/rCZE9eSM91aFVxn2RF4CvQvxO1d/i
        s11NKNRo3yCKUKbilAAJKyXKgxdGWms=
X-Google-Smtp-Source: ABdhPJzOkyGwxYaEU1R3FZgpzKcBr1J45KRsZ5u4ifLdqhcOfRf1abAMy8Qac0dyupAjAn9kmQDJNQ==
X-Received: by 2002:adf:ed07:: with SMTP id a7mr288702wro.70.1626112558771;
        Mon, 12 Jul 2021 10:55:58 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v21sm142989wml.5.2021.07.12.10.55.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jul 2021 10:55:58 -0700 (PDT)
Message-Id: <1815c148e8c36d86de2ac5f27986f5f8d850f6c4.1626112556.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.932.v8.git.1626112556.gitgitgadget@gmail.com>
References: <pull.932.v7.git.1624932293.gitgitgadget@gmail.com>
        <pull.932.v8.git.1626112556.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 12 Jul 2021 17:55:42 +0000
Subject: [PATCH v8 01/15] sparse-index: skip indexes with unmerged entries
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
index d028b73eba1..b8617ceef71 100755
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

