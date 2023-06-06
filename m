Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1019C7EE24
	for <git@archiver.kernel.org>; Tue,  6 Jun 2023 17:26:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237339AbjFFR0w (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Jun 2023 13:26:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231470AbjFFR0v (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Jun 2023 13:26:51 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18E79119
        for <git@vger.kernel.org>; Tue,  6 Jun 2023 10:26:47 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id 6a1803df08f44-6261d4ea5f0so45442856d6.0
        for <git@vger.kernel.org>; Tue, 06 Jun 2023 10:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686072406; x=1688664406;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=haWNbJYyfuSJFdFAlQ4H05g5OdYqlwTfPlg3ujg32V8=;
        b=AOEAkbz9FgiVgh41X1YtsoPG7+T+OyMnwrfoqGJ/filBrsY4CqShFvTf6Yh5B10GD2
         iDMZ14V0lTlBHIGHzCsvO0NE2B3k67OXkEgZChsi/bw83FoXgTXT3jwxqhRGh+M4qksC
         ZoZMWBHuDuGDj9jv51d8AJF6uBsQQ6Vs9f+I5vQjTLpXsigPNrpyX8+N/pRqeQQqArR4
         Viy/NCb35YUpt5kilqcRHg/RXbJ1TSD8u2poabBY+d5e/wViFKoJ3HHVe0Z4RUWPFfa4
         352mRKA8QmfR0VGznLIScgvENbJqLSCQRgJXjUjVQZTsmXI3Fd//M4rjyYFBt3MIxvNY
         TTfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686072406; x=1688664406;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=haWNbJYyfuSJFdFAlQ4H05g5OdYqlwTfPlg3ujg32V8=;
        b=IIgoqek/PThav7mwNnSG7Q9QtwM/Ps78L6HjtSfxAwHySzGzJsCjbY44wIGoqdrvW+
         31xh2Wxvo5nAO59yu1zxquxL0kXD02NzbuMmLTRda/rFUnAnJ1uTiWALcXfD7VVyxZLf
         UUaOgRAgePvaGHG8Bk0PgHKyif36itquXmolKpChjyArNc7O8dmgWwHAGu2Vh8wB5mki
         EeDGKsnTkCq9sUhBaXR20NOxT0nSXDS6OnJk8i23l9I+Qvk1kWCIqmBJwYD4tbIArGic
         Gr1r0p5oBspFVOb+I5+MdQtrAtmv545UW7OuAGqCzH7xdZQB1jpVoDhwZIMOqzbWH6Au
         bhWw==
X-Gm-Message-State: AC+VfDy5y+Ass8QI+dXFPKKRxVQQBGzst4cBAWZF2oM1P8VMDCJLBF7n
        vfGPUlb0HlEVuh+zmYWMsq3g0pzfPXvwZw==
X-Google-Smtp-Source: ACHHUZ7+8xZuSd5Qet5KHQD+CAojhGTzKRZKjZHi6C2wJvqGPQU765MYdgO01n5u7mQFnEVLscY71w==
X-Received: by 2002:a05:6214:20ec:b0:623:86a9:7696 with SMTP id 12-20020a05621420ec00b0062386a97696mr352178qvk.5.1686072405667;
        Tue, 06 Jun 2023 10:26:45 -0700 (PDT)
Received: from cheska.uwo-x-22.wireless.uwo.pri (eclipse-22.wireless.uwo.ca. [129.100.255.37])
        by smtp.googlemail.com with ESMTPSA id d21-20020a0caa15000000b0061b2a2f949bsm5479212qvb.61.2023.06.06.10.26.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jun 2023 10:26:45 -0700 (PDT)
From:   Shuqi Liang <cheskaqiqi@gmail.com>
To:     git@vger.kernel.org
Cc:     Shuqi Liang <cheskaqiqi@gmail.com>, vdye@github.com,
        gitster@pobox.com
Subject: [PATCH v2] worktree: integrate with sparse-index
Date:   Tue,  6 Jun 2023 13:26:33 -0400
Message-Id: <20230606172633.669916-1-cheskaqiqi@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230605161644.491424-1-cheskaqiqi@gmail.com>
References: <20230605161644.491424-1-cheskaqiqi@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The index is read in 'worktree.c' at two points:

1.The 'validate_no_submodules' function, which checks if there are any
submodules present in the worktree.

2.The 'check_clean_worktree' function, which verifies if a worktree is
'clean', i.e., there are no untracked or modified but uncommitted files.
This is done by running the 'git status' command, and an error message
is thrown if the worktree is not clean. Given that 'git status' is
already sparse-aware, the function is also sparse-aware.

Hence we can just set the requires-full-index to false for
"git worktree".

Add tests that verify that 'git worktree' behaves correctly when the
sparse index is enabled and test to ensure the index is not expanded.

The `p2000` tests demonstrate a ~20% execution time reduction for
'git worktree' using a sparse index:

(Note:the p2000 test results didn't reflect the huge speedup because of
the index reading time is minuscule comparing to the filesystem
operations.)

Test                                       before  after
-----------------------------------------------------------------------
2000.102: git worktree add....(full-v3)    3.15    2.82  -10.5%
2000.103: git worktree add....(full-v4)    3.14    2.84  -9.6%
2000.104: git worktree add....(sparse-v3)  2.59    2.14  -16.4%
2000.105: git worktree add....(sparse-v4)  2.10    1.57  -25.2%

Helped-by: Victoria Dye <vdye@github.com>
Signed-off-by: Shuqi Liang <cheskaqiqi@gmail.com>
---

Range-diff against v1:

* Fix did't to didn't.

* Add ensure_not_expanded for "git worktree add".

* Add a section that compares each test repo's default worktree to
a new worktree.


Range-diff against v1:
1:  aa772f998b ! 1:  d082c85fec worktree: integrate with sparse-index
    @@ Commit message
         The `p2000` tests demonstrate a ~20% execution time reduction for
         'git worktree' using a sparse index:
     
    -    (Note:the p2000 test results did't reflect the huge speedup because of
    +    (Note:the p2000 test results didn't reflect the huge speedup because of
         the index reading time is minuscule comparing to the filesystem
         operations.)
     
    @@ t/t1092-sparse-checkout-compatibility.sh: test_expect_success 'sparse index is n
     +	echo text >>"$1"
     +	EOF
     +
    -+	test_all_match git worktree add .worktrees/hotfix &&
    -+	test_sparse_match ls .worktrees/hotfix &&
    -+	test_all_match git worktree remove .worktrees/hotfix &&
    ++	for repo in full-checkout sparse-checkout sparse-index
    ++	do
    ++		worktree=${repo}-wt &&
    ++		git -C $repo worktree add ../$worktree &&
    ++
    ++		# Compare worktree content with "ls"
    ++		(cd $repo && ls) >worktree_contents &&
    ++		(cd $worktree && ls) >new_worktree_contents &&
    ++		test_cmp worktree_contents new_worktree_contents &&
    ++
    ++		# Compare index content with "ls-files --sparse"
    ++		git -C $repo ls-files --sparse >index_contents &&
    ++		git -C $worktree ls-files --sparse >new_index_contents &&
    ++		test_cmp index_contents new_index_contents &&
    ++
    ++		git -C $repo worktree remove ../$worktree || return 1
    ++	done &&
     +
     +	test_all_match git worktree add .worktrees/hotfix &&
     +	run_on_all ../edit-contents .worktrees/hotfix/deep/a &&
    @@ t/t1092-sparse-checkout-compatibility.sh: test_expect_success 'sparse index is n
     +test_expect_success 'worktree is not expanded' '
     +	init_repos &&
     +
    -+	test_all_match git worktree add .worktrees/hotfix &&
    ++	ensure_not_expanded worktree add .worktrees/hotfix &&
     +	ensure_not_expanded worktree remove .worktrees/hotfix
     +'
     +
-- 
2.39.0


 builtin/worktree.c                       |  4 +++
 t/perf/p2000-sparse-operations.sh        |  1 +
 t/t1092-sparse-checkout-compatibility.sh | 37 ++++++++++++++++++++++++
 3 files changed, 42 insertions(+)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index f3180463be..db14bff1a3 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -1200,5 +1200,9 @@ int cmd_worktree(int ac, const char **av, const char *prefix)
 		prefix = "";
 
 	ac = parse_options(ac, av, prefix, options, git_worktree_usage, 0);
+
+	prepare_repo_settings(the_repository);
+	the_repository->settings.command_requires_full_index = 0;
+
 	return fn(ac, av, prefix);
 }
diff --git a/t/perf/p2000-sparse-operations.sh b/t/perf/p2000-sparse-operations.sh
index 901cc493ef..1422136c73 100755
--- a/t/perf/p2000-sparse-operations.sh
+++ b/t/perf/p2000-sparse-operations.sh
@@ -131,5 +131,6 @@ test_perf_on_all git describe --dirty
 test_perf_on_all 'echo >>new && git describe --dirty'
 test_perf_on_all git diff-files
 test_perf_on_all git diff-files -- $SPARSE_CONE/a
+test_perf_on_all "git worktree add ../temp && git worktree remove ../temp"
 
 test_done
diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index a63d0cc222..746203d375 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -2180,4 +2180,41 @@ test_expect_success 'sparse index is not expanded: diff-files' '
 	ensure_not_expanded diff-files -- "deep/*"
 '
 
+test_expect_success 'worktree' '
+	init_repos &&
+
+	write_script edit-contents <<-\EOF &&
+	echo text >>"$1"
+	EOF
+
+	for repo in full-checkout sparse-checkout sparse-index
+	do
+		worktree=${repo}-wt &&
+		git -C $repo worktree add ../$worktree &&
+
+		# Compare worktree content with "ls"
+		(cd $repo && ls) >worktree_contents &&
+		(cd $worktree && ls) >new_worktree_contents &&
+		test_cmp worktree_contents new_worktree_contents &&
+
+		# Compare index content with "ls-files --sparse"
+		git -C $repo ls-files --sparse >index_contents &&
+		git -C $worktree ls-files --sparse >new_index_contents &&
+		test_cmp index_contents new_index_contents &&
+
+		git -C $repo worktree remove ../$worktree || return 1
+	done &&
+
+	test_all_match git worktree add .worktrees/hotfix &&
+	run_on_all ../edit-contents .worktrees/hotfix/deep/a &&
+	test_all_match test_must_fail git worktree remove .worktrees/hotfix
+'
+
+test_expect_success 'worktree is not expanded' '
+	init_repos &&
+
+	ensure_not_expanded worktree add .worktrees/hotfix &&
+	ensure_not_expanded worktree remove .worktrees/hotfix
+'
+
 test_done
-- 
2.39.0

