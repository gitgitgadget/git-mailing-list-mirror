Return-Path: <SRS0=Rj9+=DP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC50BC4363D
	for <git@archiver.kernel.org>; Thu,  8 Oct 2020 00:50:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 956F620882
	for <git@archiver.kernel.org>; Thu,  8 Oct 2020 00:50:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LHHhRmpa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727080AbgJHAun (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Oct 2020 20:50:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726323AbgJHAun (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Oct 2020 20:50:43 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2352C061755
        for <git@vger.kernel.org>; Wed,  7 Oct 2020 17:50:42 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id t10so4458476wrv.1
        for <git@vger.kernel.org>; Wed, 07 Oct 2020 17:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=r1BOVA1RWxcpoCPBiyiMLgjcCVOBW60RdFFO6sUf1oA=;
        b=LHHhRmpaEVcXhr61A+/wLt1s2PaEtsWFrbuBx0zotOBe2c7Zyuw9aW18IB1CllRQnG
         TamMZv03T4yl55rxwuaFFOLejd4KrbI1w+ORMJpWw2KRtugjJ9orPuEdLQOEvmHlcEa6
         qxR7OibM2cOC7q9z2syXY3lKdXVyvTfGv1Qn4CKdjNmOZTDrWYls5WCaS9Y6Mg4gEVn5
         ZcA175R34ICxmAM7C++1PPjZKF8J2eBqsHS7tzoO4jEPUX2HaHN518hMBNrUKBSP1YwV
         E4eFBePIGutqLGTNgedMmDh1N6uHLzIw4L4c5j0zBOl/XMtrf2WJG8afile5olJi4BRp
         rIDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=r1BOVA1RWxcpoCPBiyiMLgjcCVOBW60RdFFO6sUf1oA=;
        b=Cer6T97jOv4+JYOXSM8Fe0+OCtHFwpt9CQrzzRr/j1N6YloPzioJqGPn4UjrQaQ4df
         tgC/bmwRVYb+uZUFyXvy6hlDPtcMBc9CPAbY+Tg6tYsa8o22AnzsSJaL6LPRjq99uXzF
         LjZhrn3igo0Pi9+5huBcezjvTDMdJVt3CEkLJX6kA7lQ8/3egY52oPO55kUQn+NYEa1I
         EArTnEDFQ/e0PXrEvxffwfuShJRV+tf5xZmAtdOxWIkxHK8nzWO4BBcC15YHs91kuZwg
         3AjngYypq3WmAWNpyLT/PeNZi4dKzBlV/Dh8IaOpA5EUzew6VFNIqn3+/82VWd2DGnJj
         accQ==
X-Gm-Message-State: AOAM533TO9sJUvA94XOQ1rRUkUaJ5qOP6XUuG1GYq0zyDwE8lyBX+ZJB
        7YLD5WUHTXFJpERlvfg00OQNeW6rr1M=
X-Google-Smtp-Source: ABdhPJwVCOwyx215N8RGjM3qIRG3JbrCQbANbKInsXwkqbpeJtzyNSk5F1gsZQDFyV5Z6FNaIqI/8A==
X-Received: by 2002:a5d:6ca6:: with SMTP id a6mr6272747wra.348.1602118241376;
        Wed, 07 Oct 2020 17:50:41 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n65sm4756761wmb.12.2020.10.07.17.50.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2020 17:50:40 -0700 (PDT)
Message-Id: <pull.746.v2.git.1602118239782.gitgitgadget@gmail.com>
In-Reply-To: <pull.746.git.1602075317625.gitgitgadget@gmail.com>
References: <pull.746.git.1602075317625.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 08 Oct 2020 00:50:39 +0000
Subject: [PATCH v2] maintenance: test commit-graph auto condition
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The auto condition for the commit-graph maintenance task walks refs
looking for commits that are not in the commit-graph file. This was
added in 4ddc79b2 (maintenance: add auto condition for commit-graph
task, 2020-09-17) but was left untested.

The initial goal of this change was to demonstrate the feature works
properly by adding tests. However, there was an off-by-one error that
caused the basic tests around maintenance.commit-graph.auto=1 to fail
when it should work.

The subtlety is that if a ref tip is not in the commit-graph, then we
were not adding that to the total count. In the test, we see that we
have only added one commit since our last commit-graph write, so the
auto condition would say there is nothing to do.

The fix is simple: add the check for the commit-graph position to see
that the tip is not in the commit-graph file before starting our walk.
Since this happens before adding to the DFS stack, we do not need to
clear our (currently empty) commit list.

This does add some extra complexity for the test, because we also want
to verify that the walk along the parents actually does some work. This
means we need to add at least two commits in a row without writing the
commit-graph. However, we also need to make sure no additional refs are
pointing to the middle of this list or else the for_each_ref() in
should_write_commit_graph() might visit these commits as tips instead of
doing a DFS walk. Hence, the last two commits are added with "git
commit" instead of "test_commit".

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
    maintenance: test commit-graph auto condition
    
    As promised [1], here is a test to check that
    maintenance.commit-graph.auto behaves correctly. In the process, I found
    a small off-by-one error that is not super-critical, but worth fixing.
    
    This is based on ds/maintenance-part-1, but my GGG pull request targets
    ds/maintenance-part-3 to make sure it merges cleanly and the result
    builds & tests cleanly.
    
    Thanks, -Stolee
    
    [1] 
    https://lore.kernel.org/git/cfc8a8e9-f812-2cb1-f6d8-57ef585346d1@gmail.com/

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-746%2Fderrickstolee%2Fmaintenance%2Fcg-auto-test-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-746/derrickstolee/maintenance/cg-auto-test-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/746

Range-diff vs v1:

 1:  39223f21fb ! 1:  984ee2d9c0 maintenance: test commit-graph auto condition
     @@ t/t7900-maintenance.sh: test_expect_success 'run --task=<task>' '
      +	GIT_TRACE2_EVENT="$(pwd)/cg-negative-means-yes.txt" \
      +		git -c maintenance.commit-graph.auto="-1" $COMMAND &&
      +
     -+	test_commit one &&
     ++	test_commit first &&
      +
      +	GIT_TRACE2_EVENT="$(pwd)/cg-zero-means-no.txt" \
      +		git -c maintenance.commit-graph.auto=0 $COMMAND &&
      +	GIT_TRACE2_EVENT="$(pwd)/cg-one-satisfied.txt" \
      +		git -c maintenance.commit-graph.auto=1 $COMMAND &&
      +
     -+	git commit --allow-empty -m "two" &&
     -+	git commit --allow-empty -m "three" &&
     ++	git commit --allow-empty -m "second" &&
     ++	git commit --allow-empty -m "third" &&
      +
      +	GIT_TRACE2_EVENT="$(pwd)/cg-two-satisfied.txt" \
      +		git -c maintenance.commit-graph.auto=2 $COMMAND &&


 builtin/gc.c           |  8 +++++++-
 t/t7900-maintenance.sh | 29 +++++++++++++++++++++++++++++
 2 files changed, 36 insertions(+), 1 deletion(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index 090959350e..12ddb68bba 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -737,9 +737,15 @@ static int dfs_on_ref(const char *refname,
 	commit = lookup_commit(the_repository, oid);
 	if (!commit)
 		return 0;
-	if (parse_commit(commit))
+	if (parse_commit(commit) ||
+	    commit_graph_position(commit) != COMMIT_NOT_FROM_GRAPH)
 		return 0;
 
+	data->num_not_in_graph++;
+
+	if (data->num_not_in_graph >= data->limit)
+		return 1;
+
 	commit_list_append(commit, &stack);
 
 	while (!result && stack) {
diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
index 53c883531e..ee1f4a7ae4 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -52,6 +52,35 @@ test_expect_success 'run --task=<task>' '
 	test_subcommand git commit-graph write --split --reachable --no-progress <run-both.txt
 '
 
+test_expect_success 'commit-graph auto condition' '
+	COMMAND="maintenance run --task=commit-graph --auto --quiet" &&
+
+	GIT_TRACE2_EVENT="$(pwd)/cg-no.txt" \
+		git -c maintenance.commit-graph.auto=1 $COMMAND &&
+	GIT_TRACE2_EVENT="$(pwd)/cg-negative-means-yes.txt" \
+		git -c maintenance.commit-graph.auto="-1" $COMMAND &&
+
+	test_commit first &&
+
+	GIT_TRACE2_EVENT="$(pwd)/cg-zero-means-no.txt" \
+		git -c maintenance.commit-graph.auto=0 $COMMAND &&
+	GIT_TRACE2_EVENT="$(pwd)/cg-one-satisfied.txt" \
+		git -c maintenance.commit-graph.auto=1 $COMMAND &&
+
+	git commit --allow-empty -m "second" &&
+	git commit --allow-empty -m "third" &&
+
+	GIT_TRACE2_EVENT="$(pwd)/cg-two-satisfied.txt" \
+		git -c maintenance.commit-graph.auto=2 $COMMAND &&
+
+	COMMIT_GRAPH_WRITE="git commit-graph write --split --reachable --no-progress" &&
+	test_subcommand ! $COMMIT_GRAPH_WRITE <cg-no.txt &&
+	test_subcommand $COMMIT_GRAPH_WRITE <cg-negative-means-yes.txt &&
+	test_subcommand ! $COMMIT_GRAPH_WRITE <cg-zero-means-no.txt &&
+	test_subcommand $COMMIT_GRAPH_WRITE <cg-one-satisfied.txt &&
+	test_subcommand $COMMIT_GRAPH_WRITE <cg-two-satisfied.txt
+'
+
 test_expect_success 'run --task=bogus' '
 	test_must_fail git maintenance run --task=bogus 2>err &&
 	test_i18ngrep "is not a valid task" err

base-commit: 25914c4fdeefd99b06e134496dfb9bbb58a5c417
-- 
gitgitgadget
