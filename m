Return-Path: <SRS0=6EDX=DO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CEA8C4363D
	for <git@archiver.kernel.org>; Wed,  7 Oct 2020 12:55:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A7CB720789
	for <git@archiver.kernel.org>; Wed,  7 Oct 2020 12:55:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZEusl/3r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728300AbgJGMzV (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Oct 2020 08:55:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727253AbgJGMzV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Oct 2020 08:55:21 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD1FDC061755
        for <git@vger.kernel.org>; Wed,  7 Oct 2020 05:55:20 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id h7so2043037wre.4
        for <git@vger.kernel.org>; Wed, 07 Oct 2020 05:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=KDbWRhJKv2Cp517XP2Y0vfrECh5XjAVVL8QeRX8eG6k=;
        b=ZEusl/3riUGEqpN99R1oLDEuIvpG8Zftl6yrmOEiipE8pYaPjLPA31G69DLylo2y1x
         41Q3YFFE+4RihM0AXB/tqPzCHfD2/Pvnv0U1A9zO+MSutRP39Hc83UAqwjzS3AWGdox0
         GD/8KQMNCjey47/JBn39Ip9kolubaF4l9cRxLSCAX3Bb8+z6dGN3eGgvQLd1v1AfQZBL
         OyrTe6IAq94q0q+KDcIGZ4khxHNmWdHxLMWtgejJgjbdXvUCTDIXrU/t/p3CenrWIi8Q
         7x6GvB4negi6gZUIvLKmDt3QGxmdo88sANHhtTvSPRRWR86kgQRI+AoXjUtQKDKl7UrT
         uhsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=KDbWRhJKv2Cp517XP2Y0vfrECh5XjAVVL8QeRX8eG6k=;
        b=Xc2EFHqekRaNiPW49PA16D91KUuHuK1yy8jTRCNMK7YveKb6jlsWv3mM0tWl06ExKR
         c8XCTY8K1jtmP1WLTQwx6iX+dsV1WGXVugap+nbwCjVK2AfcYHFwaaO12Ir3RitLEL4d
         bHbI2hSQ88HMcyCLXbcjvW2KvcAv0r1l3CDuraDV9sznWQnBAf4KWSM2VfAkMEH97hpg
         buxCJNfjJGucRH1ukCMgliOKuIdk/vo3rJU/fpCbUeqbPsPWoiKw0WVfrlxR2yuq80DD
         xgqLduspZ6oRM3Cp+XyZVhPZyHkJ1XWRVCZt+2rnUDJZeC5cfp1cqlP6BoCv7NS1ULWX
         OZAg==
X-Gm-Message-State: AOAM530jlq0wuvs8fWtayEqYsX97qwUw0D1MNy8hCoANES65cx5PKO+a
        puVFdCiM/aZxtiCxB3WgPcOqyjdrlyQ=
X-Google-Smtp-Source: ABdhPJwl8euJyrdsPiHcSh0PB0PludYScJnf9y9aB6SnXCAQTE4XEl1iWh1eougmN2HaQqyNinRezA==
X-Received: by 2002:adf:f6cd:: with SMTP id y13mr3330875wrp.161.1602075319182;
        Wed, 07 Oct 2020 05:55:19 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v17sm2868821wrc.23.2020.10.07.05.55.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2020 05:55:18 -0700 (PDT)
Message-Id: <pull.746.git.1602075317625.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 07 Oct 2020 12:55:17 +0000
Subject: [PATCH] maintenance: test commit-graph auto condition
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>,
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
    
    Thanks, -Stolee
    
    [1] 
    https://lore.kernel.org/git/cfc8a8e9-f812-2cb1-f6d8-57ef585346d1@gmail.com/

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-746%2Fderrickstolee%2Fmaintenance%2Fcg-auto-test-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-746/derrickstolee/maintenance/cg-auto-test-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/746

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
index 53c883531e..3e16439bf6 100755
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
+	test_commit one &&
+
+	GIT_TRACE2_EVENT="$(pwd)/cg-zero-means-no.txt" \
+		git -c maintenance.commit-graph.auto=0 $COMMAND &&
+	GIT_TRACE2_EVENT="$(pwd)/cg-one-satisfied.txt" \
+		git -c maintenance.commit-graph.auto=1 $COMMAND &&
+
+	git commit --allow-empty -m "two" &&
+	git commit --allow-empty -m "three" &&
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
