Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B81C4C7EE24
	for <git@archiver.kernel.org>; Mon, 15 May 2023 19:19:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244752AbjEOTTV (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 May 2023 15:19:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244262AbjEOTTU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 May 2023 15:19:20 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCC0BB8
        for <git@vger.kernel.org>; Mon, 15 May 2023 12:19:18 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id e9e14a558f8ab-334f64c91aeso23453635ab.2
        for <git@vger.kernel.org>; Mon, 15 May 2023 12:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684178358; x=1686770358;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Jf241MmniCdb/eHyIXTK+bi41wqhOhBgq1fF/wvYKq0=;
        b=Q9NEP2EM47K53EcU+i5eFMuvLdzN3QJwt0nZyTQn5ETkRT/co7vQhTanMYO3x5pDf1
         bOl+6EMq5ljuDTBQhzwJwfQEwQhjY7vHsYluozI9Qv8AiCPCbPhhZfbTBjNmPCEFG2fr
         OYy2/ExEdBlyCNu0lSd45etPFaFR9+Rvp8FvwYsn6Vsicy/SlqaihB7Y+SgbaGJz4fv4
         yBORfB7uWgS88GDhtghSpOuBap1Jn661eoWCimiLWvcQW/ir4mdLjbkKytRZMAW0a3n1
         5y860a6wFQYyH4NhRFkHv/1ZJAAT6dOU3Yr09gh7nIfS0nw9AcxQt6lJxlKRqn+IRrZs
         79Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684178358; x=1686770358;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Jf241MmniCdb/eHyIXTK+bi41wqhOhBgq1fF/wvYKq0=;
        b=c2qLVH3tKrSCIwcSASCt17tctI8CP8UYQG4isolIX8GiJFVtYTY8fxbmKFd/ZXcXGN
         o8iI2ydphqy1+WUtv+j7hJ8miZ18u9O+cOWAbpdDUi5gqzur+ej/UdljmdlTKQo0CpJl
         ozOYryNbJaJdpLUqovXjsysQphL+Z+rfIIo2hfsagL3S+2VWVpHvZQr9NV6tqGzOX/m5
         lKGOpSyuPoPgGYcC4aVcfmI3vDMDrQH0I3wdTeV6pWIPbD08GMpr0xWejOCD7MffhIKV
         bqvmJ42NnZSQuxvEr8fOOG3ril44oZTRy8ZqK9wSyQd0bJAN27BLPCst/m9d3WRu6qph
         FGaw==
X-Gm-Message-State: AC+VfDyC06eOlx5OWbSjqxyB7gCxhoXd4PltzNFwwhTBeHF42EYGvaOK
        LDPzuRrVdFb6WhBahHkf5xunUwRaiQBobw==
X-Google-Smtp-Source: ACHHUZ65K8JXs3aui+9iKIeTdxU46Ozf8SG9yzMZpvarE+Nvg53dtmoxnjJfLcAGsKAIpYHeKdoC3Q==
X-Received: by 2002:a92:ce05:0:b0:331:cd3:90a7 with SMTP id b5-20020a92ce05000000b003310cd390a7mr25712935ilo.17.1684178357803;
        Mon, 15 May 2023 12:19:17 -0700 (PDT)
Received: from localhost.localdomain (bras-base-london142cw-grc-20-69-158-191-243.dsl.bell.ca. [69.158.191.243])
        by smtp.googlemail.com with ESMTPSA id w184-20020a025dc1000000b0040fdd2a623dsm6764026jaa.138.2023.05.15.12.19.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 May 2023 12:19:17 -0700 (PDT)
From:   Shuqi Liang <cheskaqiqi@gmail.com>
To:     git@vger.kernel.org
Cc:     Shuqi Liang <cheskaqiqi@gmail.com>, vdye@github.com,
        gitster@pobox.com, derrickstolee@github.com
Subject: [RFC][PATCH V1] diff-tree: integrate with sparse index
Date:   Mon, 15 May 2023 15:18:36 -0400
Message-Id: <20230515191836.674234-1-cheskaqiqi@gmail.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove full index requirement for `git diff-tree`. Add tests that verify
that 'git diff-tree' behaves correctly when the sparse index is enabled
and test to ensure the index is not expanded.

The `p2000` tests demonstrate a ~98% execution time reduction for
'git diff-tree' using a sparse index:

Test                                                before  after
------------------------------------------------------------------------
2000.94: git diff-tree HEAD (full-v3)                0.05   0.04 -20.0%
2000.95: git diff-tree HEAD (full-v4)                0.06   0.05 -16.7%
2000.96: git diff-tree HEAD (sparse-v3)              0.59   0.01 -98.3%
2000.97: git diff-tree HEAD (sparse-v4)              0.61   0.01 -98.4%
2000.98: git diff-tree HEAD -- f2/f4/a (full-v3)     0.05   0.05 +0.0%
2000.99: git diff-tree HEAD -- f2/f4/a (full-v4)     0.05   0.04 -20.0%
2000.100: git diff-tree HEAD -- f2/f4/a (sparse-v3)  0.58   0.01 -98.3%
2000.101: git diff-tree HEAD -- f2/f4/a (sparse-v4)  0.55   0.01 -98.2%

Signed-off-by: Shuqi Liang <cheskaqiqi@gmail.com>
---
 builtin/diff-tree.c                      |  4 ++
 t/perf/p2000-sparse-operations.sh        |  2 +
 t/t1092-sparse-checkout-compatibility.sh | 62 ++++++++++++++++++++++++
 3 files changed, 68 insertions(+)

diff --git a/builtin/diff-tree.c b/builtin/diff-tree.c
index 385c2d0230..c5d5730ebf 100644
--- a/builtin/diff-tree.c
+++ b/builtin/diff-tree.c
@@ -121,6 +121,10 @@ int cmd_diff_tree(int argc, const char **argv, const char *prefix)
 		usage(diff_tree_usage);
 
 	git_config(git_diff_basic_config, NULL); /* no "diff" UI options */
+
+	prepare_repo_settings(the_repository);
+	the_repository->settings.command_requires_full_index = 0;
+
 	repo_init_revisions(the_repository, opt, prefix);
 	if (repo_read_index(the_repository) < 0)
 		die(_("index file corrupt"));
diff --git a/t/perf/p2000-sparse-operations.sh b/t/perf/p2000-sparse-operations.sh
index 60d1de0662..14caf01718 100755
--- a/t/perf/p2000-sparse-operations.sh
+++ b/t/perf/p2000-sparse-operations.sh
@@ -129,5 +129,7 @@ test_perf_on_all git grep --cached bogus -- "f2/f1/f1/*"
 test_perf_on_all git write-tree
 test_perf_on_all git describe --dirty
 test_perf_on_all 'echo >>new && git describe --dirty'
+test_perf_on_all git diff-tree HEAD
+test_perf_on_all git diff-tree HEAD -- $SPARSE_CONE/a
 
 test_done
diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index 0c784813f1..f08edcbf8e 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -2108,4 +2108,66 @@ test_expect_success 'sparse-index is not expanded: write-tree' '
 	ensure_not_expanded write-tree
 '
 
+test_expect_success 'diff-tree' '
+	init_repos &&
+
+	write_script edit-contents <<-\EOF &&
+	echo text >>"$1"
+	EOF
+
+	# Get the tree SHA for the current HEAD
+	tree1=$(git -C sparse-index rev-parse HEAD^{tree}) &&
+
+	# make a change inside the sparse cone
+	run_on_all ../edit-contents deep/a &&
+	test_all_match git add deep/a &&
+	test_all_match git commit -m "Change deep/a" &&
+
+	# Get the tree SHA for the new HEAD
+	tree2=$(git -C sparse-index rev-parse HEAD^{tree}) &&
+
+
+	test_all_match git diff-tree $tree1 $tree2 &&
+	test_all_match git diff-tree HEAD &&
+	test_all_match git diff-tree HEAD -- deep/a &&
+
+	# make a change outside the sparse cone
+	run_on_all mkdir -p folder1 &&
+	run_on_all cp a folder1/a &&
+	run_on_all ../edit-contents folder1/a &&
+	test_all_match git update-index folder1/a &&
+	test_all_match git commit -m "Change folder1/a" &&
+
+	# Get the tree SHA for the new HEAD
+	tree3=$(git -C sparse-index rev-parse HEAD^{tree}) &&
+
+	test_all_match git diff-tree $tree1 $tree3 &&
+	test_all_match git diff-tree $tree1 $tree3 -- folder1/a &&
+	test_all_match git diff-tree HEAD &&
+	test_all_match git diff-tree HEAD -- folder1/a &&
+
+	# check that SKIP_WORKTREE files are not materialized
+	test_path_is_missing sparse-checkout/folder2/a &&
+	test_path_is_missing sparse-index/folder2/a
+'
+
+test_expect_success 'sparse-index is not expanded: diff-tree' '
+	init_repos &&
+
+	# Get the tree SHA for the current HEAD
+	tree1=$(git -C sparse-index rev-parse HEAD^{tree}) &&
+
+	echo "test1" >>sparse-index/deep/a &&
+	git -C sparse-index add deep/a &&
+	git -C sparse-index commit -m "Change deep/a" &&
+
+	# Get the tree SHA for the new HEAD
+	tree2=$(git -C sparse-index rev-parse HEAD^{tree}) &&
+
+	ensure_not_expanded diff-tree $tree1 $tree2 &&
+	ensure_not_expanded diff-tree $tree1 $tree2 -- deep/a &&
+	ensure_not_expanded diff-tree HEAD &&
+	ensure_not_expanded diff-tree HEAD -- deep/a
+'
+
 test_done
-- 
2.39.0

