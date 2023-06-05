Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 403B0C77B73
	for <git@archiver.kernel.org>; Mon,  5 Jun 2023 16:17:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231309AbjFEQRV (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Jun 2023 12:17:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230259AbjFEQRT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Jun 2023 12:17:19 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B62A198
        for <git@vger.kernel.org>; Mon,  5 Jun 2023 09:17:18 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id d75a77b69052e-3f80cd74c63so55498021cf.3
        for <git@vger.kernel.org>; Mon, 05 Jun 2023 09:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685981837; x=1688573837;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9HGT0VPeKF13Hwi4AYE8t6n4mAZhg7LEMKTe3KsAXA0=;
        b=TaxdjG9XrU4LrbPTKqFG+tlo/lDiiig5s0LBrHwTfyngMQE6r0nhmRcymr7C9JEqYT
         SZPZvadYK5bsg6zKv/t3BiPicACZeQ9zGZKVTpHvrYCzCTzrzRN+Rln+XuFrH3w5rfpF
         TwrJvL4QzrXhyLEDc/m/Xy2xJuWWbNhRidiUvOk/c05K5VGpgI7+BU0CRSLBQ+R7y5OB
         8zV2sPd8fsvrGqnDiZzGT/IeZ+tFZLcBrTm4ZPCfpBlWu9by5yre7J3DQvP2kABipdmw
         lAqvM6ZHKBY0v3kJYRcRUJ0eq9fQ9fKEZs3Vic5mUYE+DAPzFLZvdTT9JpOeUNOtt8pa
         1zpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685981837; x=1688573837;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9HGT0VPeKF13Hwi4AYE8t6n4mAZhg7LEMKTe3KsAXA0=;
        b=Mnv0w9HKI8l3wp+sQt0TKaty0001mpQQR58OYyBJ9De80EaSp9gI7PKSo5k+lEKiaN
         N/UXQE+kvEVU5RfW58Y+axAo/PhktnxGhCHVDUSfQb1VyRvw4OFwAIymPv7K85Ym7j9k
         NBT0XPAObMRJBe2CoKhSRD1YqTwfShq/cOJq5Q9830Ym7fJhOqelLosQbviM+Qpm43Uf
         QTuVQr+RPMbWPSIgEVAZGebAymEebHiu1zAn43XNr5hRadh1hLLrztAtZ1FA8b2SVmwT
         nA2OaYRP8vznyMxHBlOMSoNaFDSNB3tI4zzRJd2af8EvJJ8WJAJ14Q0JOc5dH/uBbte+
         fOsg==
X-Gm-Message-State: AC+VfDzJg4TiJp2LG/zuGx/x3ebnIMTxRFtbW+A3E82J5XJxNL0r5m2a
        udK6CNaWq3Jrexax61r6VEOTyaww+iUK2w==
X-Google-Smtp-Source: ACHHUZ6E9cusx2uG57dW65So4ISWHPZ25jeilHWWWKvioZJHNZfvxqNN7//mw/7WavOUELKd0/Fi4g==
X-Received: by 2002:a05:622a:387:b0:3f7:fe04:bf30 with SMTP id j7-20020a05622a038700b003f7fe04bf30mr9505656qtx.28.1685981837384;
        Mon, 05 Jun 2023 09:17:17 -0700 (PDT)
Received: from cheska.uwo-x-22.wireless.uwo.pri (eclipse-22.wireless.uwo.ca. [129.100.255.37])
        by smtp.googlemail.com with ESMTPSA id p11-20020ac8740b000000b003f81ae50c90sm4832011qtq.12.2023.06.05.09.17.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 09:17:16 -0700 (PDT)
From:   Shuqi Liang <cheskaqiqi@gmail.com>
To:     git@vger.kernel.org
Cc:     Shuqi Liang <cheskaqiqi@gmail.com>, vdye@github.com,
        gitster@pobox.com, derrickstolee@github.com
Subject: [PATCH v1] worktree: integrate with sparse-index
Date:   Mon,  5 Jun 2023 12:16:44 -0400
Message-Id: <20230605161644.491424-1-cheskaqiqi@gmail.com>
X-Mailer: git-send-email 2.39.0
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

(Note:the p2000 test results did't reflect the huge speedup because of
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
 builtin/worktree.c                       |  4 ++++
 t/perf/p2000-sparse-operations.sh        |  1 +
 t/t1092-sparse-checkout-compatibility.sh | 23 +++++++++++++++++++++++
 3 files changed, 28 insertions(+)

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
index a63d0cc222..6ed691d338 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -2180,4 +2180,27 @@ test_expect_success 'sparse index is not expanded: diff-files' '
 	ensure_not_expanded diff-files -- "deep/*"
 '
 
+test_expect_success 'worktree' '
+	init_repos &&
+
+	write_script edit-contents <<-\EOF &&
+	echo text >>"$1"
+	EOF
+
+	test_all_match git worktree add .worktrees/hotfix &&
+	test_sparse_match ls .worktrees/hotfix &&
+	test_all_match git worktree remove .worktrees/hotfix &&
+
+	test_all_match git worktree add .worktrees/hotfix &&
+	run_on_all ../edit-contents .worktrees/hotfix/deep/a &&
+	test_all_match test_must_fail git worktree remove .worktrees/hotfix
+'
+
+test_expect_success 'worktree is not expanded' '
+	init_repos &&
+
+	test_all_match git worktree add .worktrees/hotfix &&
+	ensure_not_expanded worktree remove .worktrees/hotfix
+'
+
 test_done
-- 
2.39.0

