Return-Path: <SRS0=g1uB=DW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,LOTS_OF_MONEY,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E97BFC433DF
	for <git@archiver.kernel.org>; Thu, 15 Oct 2020 17:08:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6BC7622254
	for <git@archiver.kernel.org>; Thu, 15 Oct 2020 17:08:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z/6hu1Mu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390048AbgJORIs (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Oct 2020 13:08:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389725AbgJORIs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Oct 2020 13:08:48 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C505AC061755
        for <git@vger.kernel.org>; Thu, 15 Oct 2020 10:08:47 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id f21so3934049wml.3
        for <git@vger.kernel.org>; Thu, 15 Oct 2020 10:08:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=kkHEu9TSXaVmi+Qt2mPG3KccLFvYgrNrJwSl0G4dj0s=;
        b=Z/6hu1MuxMEhpdVPkJzcotrF1wq0OXYoq13iHEANfPaXPIs9X63V1HzcI8Lhgulbmh
         fUzLhuEhmFAcfIQpceorKoV0sopZP01BTWmN3h2Qvdiv8AxN90p2y4oVnZdzauy0MtSU
         Q9Fw5RWXsIxtYmGiy/BTN1i0MqFLRa6aWuZsYOHSseoN8zAd7j6GbkVjOEQLjKZZvDtF
         ju3hLjMEQAK3vWhFkVwNQcHhzDlfORC9aTUM+hgkS1FPy9mlBPM+izFU24hVxVZ5Ffbm
         ghrKhDg30UOHfjmG6o0/FJKC7Tm2AcpQ/tPKOl01Srn08endUORKL0P5goPD56f85iSQ
         KMJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=kkHEu9TSXaVmi+Qt2mPG3KccLFvYgrNrJwSl0G4dj0s=;
        b=dytgLvdzfXh+c+gX+OViLaJkiZHRiqyi9ATHl2cR+jiE/T0VkPD3QQlnpiCP7cx0GW
         uwI3Pm3WcsZ/t+r1OLz7k7E4NV7IIEjwSqQKxN9/VsM0kCyJHCv0bscvKanYoyA+9WYZ
         Bun9Jh4JF86zvAH2zuYqRxPKt1Vj2Z+yeXaNSaDWk7o/hUcj1IyjeDMwCUmYR+XkYSX2
         7fxW97aL7kRdYcpELauSBCWtbtxMFAR3FrxwMrMHKeFzxqNUM+qevmJc3idAv5a0jGFM
         NB4wNCGdVdmoe/gbxSHHyFXlmKOcUUXaJM3OMMcb6tC1lUidKZglb8pDfG3zfHxaqF/a
         DFeA==
X-Gm-Message-State: AOAM5303YDd6dR+lg9IeIdBcmtsdPamhBIZFWr3R9qbprDkGBbNHHBgi
        8SdqapBAz/72IqgKAqcGhTgHAHtXeQo=
X-Google-Smtp-Source: ABdhPJzeQ8QDF7SVTr8n/EaGBqFymVKWkwxNgaOnshJbSqCMBXXL1qB+12zu7PetO5ItIo5K6OnuVQ==
X-Received: by 2002:a7b:c20e:: with SMTP id x14mr4851831wmi.76.1602781725588;
        Thu, 15 Oct 2020 10:08:45 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t7sm5429975wrx.42.2020.10.15.10.08.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2020 10:08:44 -0700 (PDT)
Message-Id: <pull.751.git.1602781723670.gitgitgadget@gmail.com>
From:   "Sangeeta via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 15 Oct 2020 17:08:43 +0000
Subject: [PATCH] diff: do not show submodule with untracked files as "-dirty"
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Sangeeta <sangunb09@gmail.com>, sangu09 <sangunb09@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: sangu09 <sangunb09@gmail.com>

Git diff reports a submodule directory as -dirty even when there are only untracked files in the submodule directory.
This is inconsistent with what `git describe --dirty` says when run in the submodule directory in that state.

So this patch makes `git diff HEAD` consistent with `git describe --dirty` in case of untracked files. This can be solved by including the "--ignore-submodules=untracked" feature in git diff by default. So in order to make this as default behaviour I have added the behaviour of `ignore-submodules` in `repo_diff_setup()` function. Also, to avoid `ignoreSubmodules` in user config being overwritten, I have made a  global variable `diff_ignore_submodule_config` to keep a track whether `handle_ignore_submodules_arg` is called before or not.

Signed-off-by: Sangeeta Jain <sangunb09@gmail.com>
---
    [Outreachy] diff: do not show submodule with untracked files as "-dirty"
    
    Git diff reports a submodule directory as -dirty even when there are
    only untracked files in the submodule directory. This is inconsistent
    with what git describe --dirty says when run in the submodule directory
    in that state.
    
    So this patch makes git diff HEAD consistent with git describe --dirty 
    in case of untracked files. This can be solved by including the
    "--ignore-submodules=untracked" feature in git diff by default. So in
    order to make this as default behaviour I have added the behaviour of 
    ignore-submodules in repo_diff_setup() function. Also, to avoid 
    ignoreSubmodules in user config being overwritten, I have made a global
    variable diff_ignore_submodule_config to keep a track whether 
    handle_ignore_submodules_arg is called before or not.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-751%2Fsangu09%2Fhandle_untracked-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-751/sangu09/handle_untracked-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/751

 diff.c                                       |  1 +
 submodule.c                                  |  2 ++
 t/t3701-add-interactive.sh                   |  2 +-
 t/t4027-diff-submodule.sh                    |  6 ++--
 t/t4041-diff-submodule-option.sh             | 16 ++++-----
 t/t4060-diff-submodule-option-diff-format.sh | 16 ++++-----
 t/t7064-wtstatus-pv2.sh                      |  8 ++---
 t/t7506-status-submodule.sh                  | 38 +++++---------------
 8 files changed, 36 insertions(+), 53 deletions(-)

diff --git a/diff.c b/diff.c
index 2bb2f8f57e..07d89e3e2b 100644
--- a/diff.c
+++ b/diff.c
@@ -4585,6 +4585,7 @@ void repo_diff_setup(struct repository *r, struct diff_options *options)
 		DIFF_XDL_SET(options, INDENT_HEURISTIC);
 
 	options->orderfile = diff_order_file_cfg;
+	options->flags.ignore_untracked_in_submodules = 1;
 
 	if (diff_no_prefix) {
 		options->a_prefix = options->b_prefix = "";
diff --git a/submodule.c b/submodule.c
index b3bb59f066..762298c010 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1678,6 +1678,8 @@ unsigned is_submodule_modified(const char *path, int ignore_untracked)
 	strvec_pushl(&cp.args, "status", "--porcelain=2", NULL);
 	if (ignore_untracked)
 		strvec_push(&cp.args, "-uno");
+	else
+        strvec_push (&cp.args, "--ignore-submodules=none");
 
 	prepare_submodule_repo_env(&cp.env_array);
 	cp.git_cmd = 1;
diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
index ca04fac417..98e46ad1ae 100755
--- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -761,7 +761,7 @@ test_expect_success 'setup different kinds of dirty submodules' '
 		echo dirty >>initial &&
 		: >untracked
 	) &&
-	git -C for-submodules diff-files --name-only >actual &&
+	git -C for-submodules diff-files --name-only --ignore-submodules=none >actual &&
 	cat >expected <<-\EOF &&
 	dirty-both-ways
 	dirty-head
diff --git a/t/t4027-diff-submodule.sh b/t/t4027-diff-submodule.sh
index d7145ccca4..7bf2cb9c88 100755
--- a/t/t4027-diff-submodule.sh
+++ b/t/t4027-diff-submodule.sh
@@ -93,7 +93,7 @@ test_expect_success 'git diff HEAD with dirty submodule (untracked)' '
 	) &&
 	git diff HEAD >actual &&
 	sed -e "1,/^@@/d" actual >actual.body &&
-	expect_from_to >expect.body $subtip $subprev-dirty &&
+	expect_from_to >expect.body $subtip $subprev &&
 	test_cmp expect.body actual.body
 '
 
@@ -168,13 +168,13 @@ test_expect_success 'git diff HEAD with dirty submodule (untracked, refs match)'
 		git clean -qfdx &&
 		>cruft
 	) &&
-	git diff HEAD >actual &&
+	git diff --ignore-submodules=none HEAD >actual &&
 	sed -e "1,/^@@/d" actual >actual.body &&
 	expect_from_to >expect.body $subprev $subprev-dirty &&
 	test_cmp expect.body actual.body &&
 	git diff --ignore-submodules=all HEAD >actual2 &&
 	test_must_be_empty actual2 &&
-	git diff --ignore-submodules=untracked HEAD >actual3 &&
+	git diff HEAD >actual3 &&
 	test_must_be_empty actual3 &&
 	git diff --ignore-submodules=dirty HEAD >actual4 &&
 	test_must_be_empty actual4
diff --git a/t/t4041-diff-submodule-option.sh b/t/t4041-diff-submodule-option.sh
index f852136585..bb368b685d 100755
--- a/t/t4041-diff-submodule-option.sh
+++ b/t/t4041-diff-submodule-option.sh
@@ -262,7 +262,7 @@ test_expect_success 'submodule is up to date' '
 
 test_expect_success 'submodule contains untracked content' '
 	echo new > sm1/new-file &&
-	git diff-index -p --submodule=log HEAD >actual &&
+	git diff-index -p --submodule=log HEAD --ignore-submodules=none >actual &&
 	cat >expected <<-EOF &&
 	Submodule sm1 contains untracked content
 	EOF
@@ -270,7 +270,7 @@ test_expect_success 'submodule contains untracked content' '
 '
 
 test_expect_success 'submodule contains untracked content (untracked ignored)' '
-	git diff-index -p --ignore-submodules=untracked --submodule=log HEAD >actual &&
+	git diff-index -p --submodule=log HEAD >actual &&
 	test_must_be_empty actual
 '
 
@@ -286,7 +286,7 @@ test_expect_success 'submodule contains untracked content (all ignored)' '
 
 test_expect_success 'submodule contains untracked and modified content' '
 	echo new > sm1/foo6 &&
-	git diff-index -p --submodule=log HEAD >actual &&
+	git diff-index -p --submodule=log HEAD --ignore-submodules=none >actual &&
 	cat >expected <<-EOF &&
 	Submodule sm1 contains untracked content
 	Submodule sm1 contains modified content
@@ -296,7 +296,7 @@ test_expect_success 'submodule contains untracked and modified content' '
 
 test_expect_success 'submodule contains untracked and modified content (untracked ignored)' '
 	echo new > sm1/foo6 &&
-	git diff-index -p --ignore-submodules=untracked --submodule=log HEAD >actual &&
+	git diff-index -p --submodule=log HEAD >actual &&
 	cat >expected <<-EOF &&
 	Submodule sm1 contains modified content
 	EOF
@@ -337,7 +337,7 @@ test_expect_success 'submodule is modified' '
 
 test_expect_success 'modified submodule contains untracked content' '
 	echo new > sm1/new-file &&
-	git diff-index -p --submodule=log HEAD >actual &&
+	git diff-index -p  --ignore-submodules=none --submodule=log HEAD >actual &&
 	cat >expected <<-EOF &&
 	Submodule sm1 contains untracked content
 	Submodule sm1 $head6..$head8:
@@ -347,7 +347,7 @@ test_expect_success 'modified submodule contains untracked content' '
 '
 
 test_expect_success 'modified submodule contains untracked content (untracked ignored)' '
-	git diff-index -p --ignore-submodules=untracked --submodule=log HEAD >actual &&
+	git diff-index -p --submodule=log HEAD >actual &&
 	cat >expected <<-EOF &&
 	Submodule sm1 $head6..$head8:
 	  > change
@@ -371,7 +371,7 @@ test_expect_success 'modified submodule contains untracked content (all ignored)
 
 test_expect_success 'modified submodule contains untracked and modified content' '
 	echo modification >> sm1/foo6 &&
-	git diff-index -p --submodule=log HEAD >actual &&
+	git diff-index -p --ignore-submodules=none --submodule=log HEAD >actual &&
 	cat >expected <<-EOF &&
 	Submodule sm1 contains untracked content
 	Submodule sm1 contains modified content
@@ -383,7 +383,7 @@ test_expect_success 'modified submodule contains untracked and modified content'
 
 test_expect_success 'modified submodule contains untracked and modified content (untracked ignored)' '
 	echo modification >> sm1/foo6 &&
-	git diff-index -p --ignore-submodules=untracked --submodule=log HEAD >actual &&
+	git diff-index -p --submodule=log HEAD >actual &&
 	cat >expected <<-EOF &&
 	Submodule sm1 contains modified content
 	Submodule sm1 $head6..$head8:
diff --git a/t/t4060-diff-submodule-option-diff-format.sh b/t/t4060-diff-submodule-option-diff-format.sh
index fc8229c726..dc7b242697 100755
--- a/t/t4060-diff-submodule-option-diff-format.sh
+++ b/t/t4060-diff-submodule-option-diff-format.sh
@@ -409,7 +409,7 @@ test_expect_success 'submodule is up to date' '
 
 test_expect_success 'submodule contains untracked content' '
 	echo new > sm1/new-file &&
-	git diff-index -p --submodule=diff HEAD >actual &&
+	git diff-index -p --ignore-submodules=none --submodule=diff HEAD >actual &&
 	cat >expected <<-EOF &&
 	Submodule sm1 contains untracked content
 	EOF
@@ -417,7 +417,7 @@ test_expect_success 'submodule contains untracked content' '
 '
 
 test_expect_success 'submodule contains untracked content (untracked ignored)' '
-	git diff-index -p --ignore-submodules=untracked --submodule=diff HEAD >actual &&
+	git diff-index -p --submodule=diff HEAD >actual &&
 	test_must_be_empty actual
 '
 
@@ -433,7 +433,7 @@ test_expect_success 'submodule contains untracked content (all ignored)' '
 
 test_expect_success 'submodule contains untracked and modified content' '
 	echo new > sm1/foo6 &&
-	git diff-index -p --submodule=diff HEAD >actual &&
+	git diff-index -p --ignore-submodules=none --submodule=diff HEAD >actual &&
 	cat >expected <<-EOF &&
 	Submodule sm1 contains untracked content
 	Submodule sm1 contains modified content
@@ -451,7 +451,7 @@ test_expect_success 'submodule contains untracked and modified content' '
 # NOT OK
 test_expect_success 'submodule contains untracked and modified content (untracked ignored)' '
 	echo new > sm1/foo6 &&
-	git diff-index -p --ignore-submodules=untracked --submodule=diff HEAD >actual &&
+	git diff-index -p --submodule=diff HEAD >actual &&
 	cat >expected <<-EOF &&
 	Submodule sm1 contains modified content
 	diff --git a/sm1/foo6 b/sm1/foo6
@@ -512,7 +512,7 @@ test_expect_success 'submodule is modified' '
 
 test_expect_success 'modified submodule contains untracked content' '
 	echo new > sm1/new-file &&
-	git diff-index -p --submodule=diff HEAD >actual &&
+	git diff-index -p --ignore-submodules=none --submodule=diff HEAD >actual &&
 	cat >expected <<-EOF &&
 	Submodule sm1 contains untracked content
 	Submodule sm1 $head7..$head8:
@@ -528,7 +528,7 @@ test_expect_success 'modified submodule contains untracked content' '
 '
 
 test_expect_success 'modified submodule contains untracked content (untracked ignored)' '
-	git diff-index -p --ignore-submodules=untracked --submodule=diff HEAD >actual &&
+	git diff-index -p --submodule=diff HEAD >actual &&
 	cat >expected <<-EOF &&
 	Submodule sm1 $head7..$head8:
 	diff --git a/sm1/foo6 b/sm1/foo6
@@ -564,7 +564,7 @@ test_expect_success 'modified submodule contains untracked content (all ignored)
 
 test_expect_success 'modified submodule contains untracked and modified content' '
 	echo modification >> sm1/foo6 &&
-	git diff-index -p --submodule=diff HEAD >actual &&
+	git diff-index -p --ignore-submodules=none --submodule=diff HEAD >actual &&
 	cat >expected <<-EOF &&
 	Submodule sm1 contains untracked content
 	Submodule sm1 contains modified content
@@ -583,7 +583,7 @@ test_expect_success 'modified submodule contains untracked and modified content'
 
 test_expect_success 'modified submodule contains untracked and modified content (untracked ignored)' '
 	echo modification >> sm1/foo6 &&
-	git diff-index -p --ignore-submodules=untracked --submodule=diff HEAD >actual &&
+	git diff-index -p --submodule=diff HEAD >actual &&
 	cat >expected <<-EOF &&
 	Submodule sm1 contains modified content
 	Submodule sm1 $head7..$head8:
diff --git a/t/t7064-wtstatus-pv2.sh b/t/t7064-wtstatus-pv2.sh
index 537787e598..200626251e 100755
--- a/t/t7064-wtstatus-pv2.sh
+++ b/t/t7064-wtstatus-pv2.sh
@@ -483,7 +483,7 @@ test_expect_success 'create and add submodule, submodule appears clean (A. S...)
 	)
 '
 
-test_expect_success 'untracked changes in added submodule (AM S..U)' '
+test_expect_success 'untracked changes in added submodule (A. S...))' '
 	(	cd super_repo &&
 		## create untracked file in the submodule.
 		(	cd sub1 &&
@@ -500,7 +500,7 @@ test_expect_success 'untracked changes in added submodule (AM S..U)' '
 		# branch.upstream origin/master
 		# branch.ab +0 -0
 		1 A. N... 000000 100644 100644 $ZERO_OID $HMOD .gitmodules
-		1 AM S..U 000000 160000 160000 $ZERO_OID $HSUB sub1
+		1 A. S... 000000 160000 160000 $ZERO_OID $HSUB sub1
 		EOF
 
 		git status --porcelain=v2 --branch --untracked-files=all >actual &&
@@ -560,7 +560,7 @@ test_expect_success 'staged and unstaged changes in added (AM S.M.)' '
 	)
 '
 
-test_expect_success 'staged and untracked changes in added submodule (AM S.MU)' '
+test_expect_success 'staged and untracked changes in added submodule (AM S.M.)' '
 	(	cd super_repo &&
 		(	cd sub1 &&
 			## stage new changes in tracked file.
@@ -579,7 +579,7 @@ test_expect_success 'staged and untracked changes in added submodule (AM S.MU)'
 		# branch.upstream origin/master
 		# branch.ab +0 -0
 		1 A. N... 000000 100644 100644 $ZERO_OID $HMOD .gitmodules
-		1 AM S.MU 000000 160000 160000 $ZERO_OID $HSUB sub1
+		1 AM S.M. 000000 160000 160000 $ZERO_OID $HSUB sub1
 		EOF
 
 		git status --porcelain=v2 --branch --untracked-files=all >actual &&
diff --git a/t/t7506-status-submodule.sh b/t/t7506-status-submodule.sh
index 3fcb44767f..b7ff7928fb 100755
--- a/t/t7506-status-submodule.sh
+++ b/t/t7506-status-submodule.sh
@@ -95,7 +95,7 @@ test_expect_success 'status with untracked file in submodule' '
 	(cd sub && git reset --hard) &&
 	echo "content" >sub/new-file &&
 	git status >output &&
-	test_i18ngrep "modified:   sub (untracked content)" output
+	test_i18ngrep "^nothing to commit" output
 '
 
 test_expect_success 'status -uno with untracked file in submodule' '
@@ -105,23 +105,19 @@ test_expect_success 'status -uno with untracked file in submodule' '
 
 test_expect_success 'status with untracked file in submodule (porcelain)' '
 	git status --porcelain >output &&
-	diff output - <<-\EOF
-	 M sub
-	EOF
+	test_must_be_empty output
 '
 
 test_expect_success 'status with untracked file in submodule (short)' '
 	git status --short >output &&
-	diff output - <<-\EOF
-	 ? sub
-	EOF
+	test_must_be_empty output
 '
 
 test_expect_success 'status with added and untracked file in submodule' '
 	(cd sub && git reset --hard && echo >foo && git add foo) &&
 	echo "content" >sub/new-file &&
 	git status >output &&
-	test_i18ngrep "modified:   sub (modified content, untracked content)" output
+	test_i18ngrep "modified:   sub (modified content)" output
 '
 
 test_expect_success 'status with added and untracked file in submodule (porcelain)' '
@@ -169,7 +165,7 @@ test_expect_success 'status with untracked file in modified submodule' '
 	(cd sub && git reset --hard) &&
 	echo "content" >sub/new-file &&
 	git status >output &&
-	test_i18ngrep "modified:   sub (new commits, untracked content)" output
+	test_i18ngrep "modified:   sub (new commits)" output
 '
 
 test_expect_success 'status with untracked file in modified submodule (porcelain)' '
@@ -183,7 +179,7 @@ test_expect_success 'status with added and untracked file in modified submodule'
 	(cd sub && git reset --hard && echo >foo && git add foo) &&
 	echo "content" >sub/new-file &&
 	git status >output &&
-	test_i18ngrep "modified:   sub (new commits, modified content, untracked content)" output
+	test_i18ngrep "modified:   sub (new commits, modified content)" output
 '
 
 test_expect_success 'status with added and untracked file in modified submodule (porcelain)' '
@@ -350,30 +346,17 @@ test_expect_success 'setup superproject with untracked file in nested submodule'
 
 test_expect_success 'status with untracked file in nested submodule (porcelain)' '
 	git -C super status --porcelain >output &&
-	diff output - <<-\EOF
-	 M sub1
-	 M sub2
-	 M sub3
-	EOF
+	test_must_be_empty output
 '
 
 test_expect_success 'status with untracked file in nested submodule (porcelain=2)' '
 	git -C super status --porcelain=2 >output &&
-	sanitize_output output &&
-	diff output - <<-\EOF
-	1 .M S..U 160000 160000 160000 HASH HASH sub1
-	1 .M S..U 160000 160000 160000 HASH HASH sub2
-	1 .M S..U 160000 160000 160000 HASH HASH sub3
-	EOF
+	test_must_be_empty output
 '
 
 test_expect_success 'status with untracked file in nested submodule (short)' '
 	git -C super status --short >output &&
-	diff output - <<-\EOF
-	 ? sub1
-	 ? sub2
-	 ? sub3
-	EOF
+	test_must_be_empty output
 '
 
 test_expect_success 'setup superproject with modified file in nested submodule' '
@@ -386,7 +369,6 @@ test_expect_success 'status with added file in nested submodule (porcelain)' '
 	diff output - <<-\EOF
 	 M sub1
 	 M sub2
-	 M sub3
 	EOF
 '
 
@@ -396,7 +378,6 @@ test_expect_success 'status with added file in nested submodule (porcelain=2)' '
 	diff output - <<-\EOF
 	1 .M S.M. 160000 160000 160000 HASH HASH sub1
 	1 .M S.M. 160000 160000 160000 HASH HASH sub2
-	1 .M S..U 160000 160000 160000 HASH HASH sub3
 	EOF
 '
 
@@ -405,7 +386,6 @@ test_expect_success 'status with added file in nested submodule (short)' '
 	diff output - <<-\EOF
 	 m sub1
 	 m sub2
-	 ? sub3
 	EOF
 '
 

base-commit: d98273ba77e1ab9ec755576bc86c716a97bf59d7
-- 
gitgitgadget
