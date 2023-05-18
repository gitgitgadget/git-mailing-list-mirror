Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 054AFC77B7A
	for <git@archiver.kernel.org>; Thu, 18 May 2023 15:45:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231560AbjERPpX (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 May 2023 11:45:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230257AbjERPpV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 May 2023 11:45:21 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F32CE119
        for <git@vger.kernel.org>; Thu, 18 May 2023 08:45:19 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id ca18e2360f4ac-76c64da0e46so56134639f.0
        for <git@vger.kernel.org>; Thu, 18 May 2023 08:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684424719; x=1687016719;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QLMjzLgNgtdp5FFMXnlY0dlM7YMKdvzUSXmgR8Lzlm8=;
        b=OkMUF/nL4a6mT+CKBC+uy3U1hSezAfd5OpWGC3H7FA+18Xi537tV9Ib414e2Gnqc7b
         A70v9PYXIw+kmrBZekItLxP8R2ocCqyOXfm/8dy1cxwiv38NemRtYkOQO22CGptn8SrJ
         WnGR1XbfKqmsrEvPuo7Bh7dN6hApAneZL3WHXtgsijilOXB7Tvp3sQslnvaFJAjr31Ey
         JohJyxhbM4+hGQ5LskLeYdGjjR2YG9qIqodghncFBzAYUHXd5v+PjlTS1FgQdofmHbUu
         f/3AwyUSzAJkAN/LHOsplOBiSLk1VpxAMwUOIRHTuMK/MaxO81KRCGM0Ip5+VsTxODUp
         xW0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684424719; x=1687016719;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QLMjzLgNgtdp5FFMXnlY0dlM7YMKdvzUSXmgR8Lzlm8=;
        b=XkgFJwvLNQUp/+wHE8xrbT6U4bEVa+kHFLaRo8IJvuhBeCvUZm6RDaxQGcJPZkJLDs
         KOGs2vp60HQtSyvUvvYRh/fhFKgsuWVONdWjN0L1dNsj3uF53OfC9Vls113UyXJ6/fd2
         madsUVHMtgHx6Dqi6Ch9fH16Z9qLL3Xp8KXG9PqaztWUNmBQB8JhXczbWSfhwrYNriJt
         yD0D3tCPAG7FYnmMmXqM8SaDC0uddKxclxUjMPrDeGxZjBoxKZStNL2/YWj5FOyWRaN7
         Us2uxN0OmcTLySAGClAhMY86BoGmUUXaRdNFhsJDr9FKAPFe5hyyMS9UCc5x147lpjdG
         i9tg==
X-Gm-Message-State: AC+VfDw2JgTqVGqUXD2PDekW8ReZrcXMRTbkKzI6omFW1WAi6ToGFZLV
        Nz8K4/uVyA5Ae3+qWiU7HItLJERLFqhi/Q==
X-Google-Smtp-Source: ACHHUZ6+Jp1ZftWabrY4bui5W6TPbZD7DlZHMz2Qbh37nnkGKZL93fq5J0Vp3NjdcRC6aSpROWmUGw==
X-Received: by 2002:a5d:9954:0:b0:76c:6469:bb20 with SMTP id v20-20020a5d9954000000b0076c6469bb20mr6463046ios.7.1684424718813;
        Thu, 18 May 2023 08:45:18 -0700 (PDT)
Received: from localhost.localdomain (bras-base-london142cw-grc-20-69-158-191-243.dsl.bell.ca. [69.158.191.243])
        by smtp.googlemail.com with ESMTPSA id i10-20020a5e9e0a000000b007701a36e4c0sm468876ioq.27.2023.05.18.08.45.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 08:45:18 -0700 (PDT)
From:   Shuqi Liang <cheskaqiqi@gmail.com>
To:     git@vger.kernel.org
Cc:     Shuqi Liang <cheskaqiqi@gmail.com>, vdye@github.com,
        gitster@pobox.com, derrickstolee@github.com
Subject: [PATCH v2] diff-tree: integrate with sparse index
Date:   Thu, 18 May 2023 11:44:54 -0400
Message-Id: <20230518154454.475487-1-cheskaqiqi@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230515191836.674234-1-cheskaqiqi@gmail.com>
References: <20230515191836.674234-1-cheskaqiqi@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The index is read in 'cmd_diff_tree' at two points:

1. The first index read was added in fd66bcc31ff (diff-tree: read the
index so attribute checks work in bare repositories, 2017-12-06) to deal
with reading '.gitattributes' content. 77efbb366ab (attr: be careful
about sparse directories, 2021-09-08) established that, in a sparse
index, we do _not_ try to load a '.gitattributes' file from within a
sparse directory.

2. The second index access point is involved in rename detection,
specifically when reading from stdin.This was initially added in
f0c6b2a2fd9 ([PATCH] Optimize diff-tree -[CM]--stdin, 2005-05-27), where
'setup' was set to 'DIFF_SETUP_USE_SIZE_CACHE |DIFF_SETUP_USE_CACHE'.
That assignment was later modified to drop the'DIFF_SETUP_USE_CACHE' in
ff7fe37b053 (diff.c: move read_index() code back to the caller,
2018-08-13).However, 'DIFF_SETUP_USE_SIZE_CACHE' seems to be unused as
of 6e0b8ed6d35 (diff.c: do not use a separate "size cache"., 2007-05-07)
and nothing about 'detect_rename' otherwise indicates index usage.

Hence we can just set the requires-full-index to false for "diff-tree".

Add tests that verify that 'git diff-tree' behaves correctly when the
sparse index is enabled and test to ensure the index is not expanded.

The `p2000` tests demonstrate a ~98% execution time reduction for
'git diff-tree' using a sparse index:

Test                                                before  after
-----------------------------------------------------------------------
2000.94: git diff-tree HEAD (full-v3)                0.05   0.04 -20.0%
2000.95: git diff-tree HEAD (full-v4)                0.06   0.05 -16.7%
2000.96: git diff-tree HEAD (sparse-v3)              0.59   0.01 -98.3%
2000.97: git diff-tree HEAD (sparse-v4)              0.61   0.01 -98.4%
2000.98: git diff-tree HEAD -- f2/f4/a (full-v3)     0.05   0.05 +0.0%
2000.99: git diff-tree HEAD -- f2/f4/a (full-v4)     0.05   0.04 -20.0%
2000.100: git diff-tree HEAD -- f2/f4/a (sparse-v3)  0.58   0.01 -98.3%
2000.101: git diff-tree HEAD -- f2/f4/a (sparse-v4)  0.55   0.01 -98.2%

Helped-by: Victoria Dye <vdye@github.com>
Signed-off-by: Shuqi Liang <cheskaqiqi@gmail.com>
---
Change since v1:

* Update commit message.
* Use existing test repo to simplify the test.
* Add test to ensure index won't expand regardless of 'diff-tree' a file
inside or outside the cone


Range-diff against v1:
1:  47049834d1 < -:  ---------- diff-tree: integrate with sparse index
-:  ---------- > 1:  a24605f579 diff-tree: integrate with sparse index

 builtin/diff-tree.c                      |  4 +++
 t/perf/p2000-sparse-operations.sh        |  2 ++
 t/t1092-sparse-checkout-compatibility.sh | 42 ++++++++++++++++++++++++
 3 files changed, 48 insertions(+)

diff --git a/builtin/diff-tree.c b/builtin/diff-tree.c
index 0b02c62b85..c0540317fb 100644
--- a/builtin/diff-tree.c
+++ b/builtin/diff-tree.c
@@ -122,6 +122,10 @@ int cmd_diff_tree(int argc, const char **argv, const char *prefix)
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
index 901cc493ef..5a11910189 100755
--- a/t/perf/p2000-sparse-operations.sh
+++ b/t/perf/p2000-sparse-operations.sh
@@ -131,5 +131,7 @@ test_perf_on_all git describe --dirty
 test_perf_on_all 'echo >>new && git describe --dirty'
 test_perf_on_all git diff-files
 test_perf_on_all git diff-files -- $SPARSE_CONE/a
+test_perf_on_all git diff-tree HEAD
+test_perf_on_all git diff-tree HEAD -- $SPARSE_CONE/a
 
 test_done
diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index e58bfbfcb4..90f827ffe9 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -2170,4 +2170,46 @@ test_expect_success 'sparse index is not expanded: diff-files' '
 	ensure_not_expanded diff-files -- "deep/*"
 '
 
+test_expect_success 'diff-tree' '
+	init_repos &&
+
+	# Test change inside sparse cone
+	tree1=$(git -C sparse-index rev-parse HEAD^{tree}) &&
+	tree2=$(git -C sparse-index rev-parse update-deep^{tree}) &&
+	test_all_match git diff-tree $tree1 $tree2 &&
+	test_all_match git diff-tree $tree1 $tree2 -- deep/a &&
+	test_all_match git diff-tree HEAD update-deep &&
+	test_all_match git diff-tree HEAD update-deep -- deep/a &&
+
+	# Test change outside sparse cone
+	tree3=$(git -C sparse-index rev-parse update-folder1^{tree}) &&
+	test_all_match git diff-tree $tree1 $tree3 &&
+	test_all_match git diff-tree $tree1 $tree3 -- folder1/a &&
+	test_all_match git diff-tree HEAD update-folder1 &&
+	test_all_match git diff-tree HEAD update-folder1 -- folder1/a &&
+
+	# Check that SKIP_WORKTREE files are not materialized
+	test_path_is_missing sparse-checkout/folder1/a &&
+	test_path_is_missing sparse-index/folder1/a &&
+	test_path_is_missing sparse-checkout/folder2/a &&
+	test_path_is_missing sparse-index/folder2/a
+'
+
+test_expect_success 'sparse-index is not expanded: diff-tree' '
+	init_repos &&
+
+	tree1=$(git -C sparse-index rev-parse HEAD^{tree}) &&
+	tree2=$(git -C sparse-index rev-parse update-deep^{tree}) &&
+	tree3=$(git -C sparse-index rev-parse update-folder1^{tree}) &&
+
+	ensure_not_expanded diff-tree $tree1 $tree2 &&
+	ensure_not_expanded diff-tree $tree1 $tree2 -- deep/a &&
+	ensure_not_expanded diff-tree HEAD update-deep &&
+	ensure_not_expanded diff-tree HEAD update-deep -- deep/a &&
+	ensure_not_expanded diff-tree $tree1 $tree3 &&
+	ensure_not_expanded diff-tree $tree1 $tree3 -- folder1/a &&
+	ensure_not_expanded diff-tree HEAD update-folder1 &&
+	ensure_not_expanded diff-tree HEAD update-folder1 -- folder1/a
+'
+
 test_done
-- 
2.39.0

