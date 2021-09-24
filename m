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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A165C433F5
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 06:37:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4BCD360F48
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 06:37:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244200AbhIXGit (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Sep 2021 02:38:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244191AbhIXGiq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Sep 2021 02:38:46 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38296C061756
        for <git@vger.kernel.org>; Thu, 23 Sep 2021 23:37:13 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id i23so24158470wrb.2
        for <git@vger.kernel.org>; Thu, 23 Sep 2021 23:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=2ME/dZ4fzArIJqmFKq/Lz334GlShsg34B/tWiC3aR9w=;
        b=PlrF1fHTprbJasZFhtS4tG1cL6TC51IR+7maQ6uKWN6HB6xrDQYA/fjxNS3YX0Qnin
         5xUiPFLd/LJ5IeDdMVnxZHbl20X7yWA6ebjmItNvaiYaYSDoF/V2YCsjZbydBrpzsqD5
         sgnx60PuIERM6ro2qjVm8gVE12Fhg2T4ascYJkn+4ysJRefX+Hh1fuAoy+42Xj/4tvrW
         MEvQ7Txwz7iczERQ7DMvLZBrgScEFYzn1WEUvvmH+MZ7D5Xe/YdsKhRXmybhzGh960Dh
         dlITYIPgZ0NDlLeMNoIPVVhDM53egrmeAvt8a6Txtyx6bhqZemxQFQdX25DrIFqb/uOC
         TiQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=2ME/dZ4fzArIJqmFKq/Lz334GlShsg34B/tWiC3aR9w=;
        b=p/Q5e5ds0sfnuqMR5DL/+dH+9fX6ZgzMue1mFm9y7Pr4GoLAMH+5iQZ176nh22RWg9
         9AO/d7tXBhg5vjRIqQTWiIWOK5a+6Kwd/asQWiY/KD6BHBYPOkNiqZCOGraiyZpQHo+6
         jZbR/maqOsjHdy+d9mwMejgSxjAAdo/ewpDpuEuSswwRtp1mi/bBDbEkWwyKTLfyivDT
         BHA2Y2tWtWivOMVeYEw7XwNO6ftqaNXDCZGDWLq/EwWgB86JQEkpr+8aSYCFJZVEzj8/
         Qkc63267YbFmCIqwdMHRBp6lknX1n0SdjZhEOko0AIaK5MGUfKgOHkjMS8nRzzGUZBrD
         Ym7w==
X-Gm-Message-State: AOAM530wQUaIFE7VYQUICEKhk8Hm05/RAJBJFstrAI0xqJjUBKXvrjEm
        ohmZiaPSHZkI5PJ7C8+42+qxusWA1Ts=
X-Google-Smtp-Source: ABdhPJyd+kKZKecisSGN9abP+fGjBGtEDDu6g3sLgDUM4B4Lpbq41hMstOI29QmDi+HiQ/rmdc7cLA==
X-Received: by 2002:a1c:3584:: with SMTP id c126mr318719wma.0.1632465431789;
        Thu, 23 Sep 2021 23:37:11 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y18sm7067864wrq.6.2021.09.23.23.37.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Sep 2021 23:37:11 -0700 (PDT)
Message-Id: <9460a49c7edfd4ebcace2ef66b265dc1bef67769.1632465429.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1036.v2.git.1632465429.gitgitgadget@gmail.com>
References: <pull.1036.git.1632006923.gitgitgadget@gmail.com>
        <pull.1036.v2.git.1632465429.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 24 Sep 2021 06:37:04 +0000
Subject: [PATCH v2 1/6] t2500: add various tests for nuking untracked files
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Fedor Biryukov <fedor.birjukov@gmail.com>,
        Philip Oakley <philipoakley@iee.email>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Elijah Newren <newren@gmail.com>,
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
index 00000000000..2412d121ea8
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
+	git init reset_$1 &&
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
+		grep "Updating .foo.t. would lose untracked files" error
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
+	git init checkout &&
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
+	git init sequencing_$1 &&
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

