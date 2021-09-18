Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98B52C433FE
	for <git@archiver.kernel.org>; Sat, 18 Sep 2021 23:15:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6DEFE610A6
	for <git@archiver.kernel.org>; Sat, 18 Sep 2021 23:15:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240673AbhIRXQx (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 18 Sep 2021 19:16:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239641AbhIRXQv (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Sep 2021 19:16:51 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5816FC061757
        for <git@vger.kernel.org>; Sat, 18 Sep 2021 16:15:27 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id t8so21528462wrq.4
        for <git@vger.kernel.org>; Sat, 18 Sep 2021 16:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=KkNxmtteEZDd/DPFVopftVZzyLOL6If+eKZ7WucQR0I=;
        b=dDtW0uqOZRTdLQbACPn80d+6QQPmPWLUTVu04iwbsc/20lfiFgyKTsQIUnIMTJ9eVW
         Hiu8W7PrXUarx7ZqqgNyjEymImamumaLYvy7qi4wdDF0Z+a36con11K2v7eaUztIjXxX
         K50RQH9UtSU7VWp7FnctNrZoYXOIGa3DasQX8zvVbKrMkBsAEDXONJDw3YcBREwZYmp+
         jjsSWRs2aTxqN0Nydoide89YirXh7vuDBeIMCUhqKas/lxBsZSLQvkV4ri76rxR1BOG7
         GdYVexOvTI/p6xG5mqo4+aFETsh3IG03TGWmkFrF6P9skHJUEkveIBTrlW2B4q4wL2DK
         w0kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=KkNxmtteEZDd/DPFVopftVZzyLOL6If+eKZ7WucQR0I=;
        b=ioz8wTi9TOy1/iyz6dzMWurfQse0W2hkgL6zZLgfPCtnTWa19AsCgakBPCl68+rHbj
         hacpNeBfDkUgVsSfKSypM3A8a3ck9ppDYlhC8YI5Sm5R8WSq/EbVvHQ6ndFXN/n8poTU
         NAUkLm+LU6hdRFoqCSd/ejxHMyLFz03TyinInYcaemktyFo5dUnzMqrytOv6Caa+7Rrs
         b0gSZ75CXuk8JVpJKtSAGgtf/Mw0X9B6cX17n2JQa+Jco5dwY74QKgr8ZbF7JLaVXJGr
         1NhUvjeIr0lU2WlIWVk8Y1Gn8nDCYMT1Idqqtdw7hFHUAVPGE+lW3VRnFBHAlDykGC30
         abmw==
X-Gm-Message-State: AOAM532TsMsmaOp+FYQDohQhI/8Xzk2bQvKNU8Gx/tr5PdF3bgxLB/xG
        iI+J93XOxZus9c4H9MAwCLQsI04YG9s=
X-Google-Smtp-Source: ABdhPJwWICy0xHW/OxmX4kH873v1WawMaP/6LjJhu93sQpIdPExbo44o3L789PF8FwoTBrMOcNrheQ==
X-Received: by 2002:a5d:4c4c:: with SMTP id n12mr19700583wrt.19.1632006925853;
        Sat, 18 Sep 2021 16:15:25 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n17sm11044847wrp.17.2021.09.18.16.15.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Sep 2021 16:15:25 -0700 (PDT)
Message-Id: <b634136a74b37a6f73bc3038f79031e040423883.1632006923.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1036.git.1632006923.gitgitgadget@gmail.com>
References: <pull.1036.git.1632006923.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 18 Sep 2021 23:15:18 +0000
Subject: [PATCH 1/6] t2500: add various tests for nuking untracked files
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Fedor Biryukov <fedor.birjukov@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Noting that unpack_trees treats reset=1 & update=1 as license to nuke
untracked files, I looked for code paths that use this combination and
tried to generate testcases which demonstrated unintentional loss of
untracked files and directories.  I found several.

I also include testcases for `git reset --{hard,merge,keep}`.  A hard
reset is perhaps the most direct test of unpack_tree's reset=1 behavior,
but we cannot make `git reset --hard` preserve untracked files without
some migration work.

Also, the two commands `checkout --force` (because of the --force) and
`read-tree --reset` (because it's plumbing and we need to keep it
backward compatible) were left out as we expect those to continue
removing untracked files and directories.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t2500-untracked-overwriting.sh | 244 +++++++++++++++++++++++++++++++
 1 file changed, 244 insertions(+)
 create mode 100755 t/t2500-untracked-overwriting.sh

diff --git a/t/t2500-untracked-overwriting.sh b/t/t2500-untracked-overwriting.sh
new file mode 100755
index 00000000000..a1a6dfa671e
--- /dev/null
+++ b/t/t2500-untracked-overwriting.sh
@@ -0,0 +1,244 @@
+#!/bin/sh
+
+test_description='Test handling of overwriting untracked files'
+
+. ./test-lib.sh
+
+test_setup_reset () {
+	test_create_repo reset_$1 &&
+	(
+		cd reset_$1 &&
+		test_commit init &&
+
+		git branch stable &&
+		git branch work &&
+
+		git checkout work &&
+		test_commit foo &&
+
+		git checkout stable
+	)
+}
+
+test_expect_success 'reset --hard will nuke untracked files/dirs' '
+	test_setup_reset hard &&
+	(
+		cd reset_hard &&
+		git ls-tree -r stable &&
+		git log --all --name-status --oneline &&
+		git ls-tree -r work &&
+
+		mkdir foo.t &&
+		echo precious >foo.t/file &&
+		echo foo >expect &&
+
+		git reset --hard work &&
+
+		# check that untracked directory foo.t/ was nuked
+		test_path_is_file foo.t &&
+		test_cmp expect foo.t
+	)
+'
+
+test_expect_success 'reset --merge will preserve untracked files/dirs' '
+	test_setup_reset merge &&
+	(
+		cd reset_merge &&
+
+		mkdir foo.t &&
+		echo precious >foo.t/file &&
+		cp foo.t/file expect &&
+
+		test_must_fail git reset --merge work 2>error &&
+		test_cmp expect foo.t/file &&
+		grep "Updating.*foo.t.*would lose untracked files" error
+	)
+'
+
+test_expect_success 'reset --keep will preserve untracked files/dirs' '
+	test_setup_reset keep &&
+	(
+		cd reset_keep &&
+
+		mkdir foo.t &&
+		echo precious >foo.t/file &&
+		cp foo.t/file expect &&
+
+		test_must_fail git reset --merge work 2>error &&
+		test_cmp expect foo.t/file &&
+		grep "Updating.*foo.t.*would lose untracked files" error
+	)
+'
+
+test_setup_checkout_m () {
+	test_create_repo checkout &&
+	(
+		cd checkout &&
+		test_commit init &&
+
+		test_write_lines file has some >filler &&
+		git add filler &&
+		git commit -m filler &&
+
+		git branch stable &&
+
+		git switch -c work &&
+		echo stuff >notes.txt &&
+		test_write_lines file has some words >filler &&
+		git add notes.txt filler &&
+		git commit -m filler &&
+
+		git checkout stable
+	)
+}
+
+test_expect_failure 'checkout -m does not nuke untracked file' '
+	test_setup_checkout_m &&
+	(
+		cd checkout &&
+
+		# Tweak filler
+		test_write_lines this file has some >filler &&
+		# Make an untracked file, save its contents in "expect"
+		echo precious >notes.txt &&
+		cp notes.txt expect &&
+
+		test_must_fail git checkout -m work &&
+		test_cmp expect notes.txt
+	)
+'
+
+test_setup_sequencing () {
+	test_create_repo sequencing_$1 &&
+	(
+		cd sequencing_$1 &&
+		test_commit init &&
+
+		test_write_lines this file has some words >filler &&
+		git add filler &&
+		git commit -m filler &&
+
+		mkdir -p foo/bar &&
+		test_commit foo/bar/baz &&
+
+		git branch simple &&
+		git branch fooey &&
+
+		git checkout fooey &&
+		git rm foo/bar/baz.t &&
+		echo stuff >>filler &&
+		git add -u &&
+		git commit -m "changes" &&
+
+		git checkout simple &&
+		echo items >>filler &&
+		echo newstuff >>newfile &&
+		git add filler newfile &&
+		git commit -m another
+	)
+}
+
+test_expect_failure 'git rebase --abort and untracked files' '
+	test_setup_sequencing rebase_abort_and_untracked &&
+	(
+		cd sequencing_rebase_abort_and_untracked &&
+		git checkout fooey &&
+		test_must_fail git rebase simple &&
+
+		cat init.t &&
+		git rm init.t &&
+		echo precious >init.t &&
+		cp init.t expect &&
+		git status --porcelain &&
+		test_must_fail git rebase --abort &&
+		test_cmp expect init.t
+	)
+'
+
+test_expect_failure 'git rebase fast forwarding and untracked files' '
+	test_setup_sequencing rebase_fast_forward_and_untracked &&
+	(
+		cd sequencing_rebase_fast_forward_and_untracked &&
+		git checkout init &&
+		echo precious >filler &&
+		cp filler expect &&
+		test_must_fail git rebase init simple &&
+		test_cmp expect filler
+	)
+'
+
+test_expect_failure 'git rebase --autostash and untracked files' '
+	test_setup_sequencing rebase_autostash_and_untracked &&
+	(
+		cd sequencing_rebase_autostash_and_untracked &&
+		git checkout simple &&
+		git rm filler &&
+		mkdir filler &&
+		echo precious >filler/file &&
+		cp filler/file expect &&
+		git rebase --autostash init &&
+		test_path_is_file filler/file
+	)
+'
+
+test_expect_failure 'git stash and untracked files' '
+	test_setup_sequencing stash_and_untracked_files &&
+	(
+		cd sequencing_stash_and_untracked_files &&
+		git checkout simple &&
+		git rm filler &&
+		mkdir filler &&
+		echo precious >filler/file &&
+		cp filler/file expect &&
+		git status --porcelain &&
+		git stash push &&
+		git status --porcelain &&
+		test_path_is_file filler/file
+	)
+'
+
+test_expect_failure 'git am --abort and untracked dir vs. unmerged file' '
+	test_setup_sequencing am_abort_and_untracked &&
+	(
+		cd sequencing_am_abort_and_untracked &&
+		git format-patch -1 --stdout fooey >changes.mbox &&
+		test_must_fail git am --3way changes.mbox &&
+
+		# Delete the conflicted file; we will stage and commit it later
+		rm filler &&
+
+		# Put an unrelated untracked directory there
+		mkdir filler &&
+		echo foo >filler/file1 &&
+		echo bar >filler/file2 &&
+
+		test_must_fail git am --abort 2>errors &&
+		test_path_is_dir filler &&
+		grep "Updating .filler. would lose untracked files in it" errors
+	)
+'
+
+test_expect_failure 'git am --skip and untracked dir vs deleted file' '
+	test_setup_sequencing am_skip_and_untracked &&
+	(
+		cd sequencing_am_skip_and_untracked &&
+		git checkout fooey &&
+		git format-patch -1 --stdout simple >changes.mbox &&
+		test_must_fail git am --3way changes.mbox &&
+
+		# Delete newfile
+		rm newfile &&
+
+		# Put an unrelated untracked directory there
+		mkdir newfile &&
+		echo foo >newfile/file1 &&
+		echo bar >newfile/file2 &&
+
+		# Change our mind about resolutions, just skip this patch
+		test_must_fail git am --skip 2>errors &&
+		test_path_is_dir newfile &&
+		grep "Updating .newfile. would lose untracked files in it" errors
+	)
+'
+
+test_done
-- 
gitgitgadget

