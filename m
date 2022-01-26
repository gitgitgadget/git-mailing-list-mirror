Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A79FCC2BA4C
	for <git@archiver.kernel.org>; Wed, 26 Jan 2022 13:05:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234808AbiAZNF6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Jan 2022 08:05:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234564AbiAZNF4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jan 2022 08:05:56 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BE53C06161C
        for <git@vger.kernel.org>; Wed, 26 Jan 2022 05:05:56 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id o1-20020a1c4d01000000b0034d95625e1fso3695992wmh.4
        for <git@vger.kernel.org>; Wed, 26 Jan 2022 05:05:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=RgfWbH8EkP3v03X6GBBCAn+4toSNQMTsaLcf8uyGGA8=;
        b=oWlqjREdXO19lYndOyEGUWze4LFDtX0jRB37Rjkw4RmAuourMKlUzOGQonESkVxMiQ
         8e+Qbfqb/wAdE1Yy4a44XYYjEeBeuG8Twzy5lKgr5LflRW5U1FSvoPYeCqAcYrRsMcRc
         4EvK+UbM8vKN7bulaWPxIajJMAU0h30onw7pOBVPnWljCi9OkdTW+MNRWFm/tHDEnXAb
         j1jcS/MXlnzniAVTRzG1NdPAKAuYry9g8JQoR/yamt+0wkyMCBOlf5iKDDlUIzCnVEtq
         Z+WOud0w1pOH2MB7JNEIijqLswpSZmxDDPvg1H/1BBnp6kw9F0hyvtPdXNd+go7NOPgo
         8Yrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=RgfWbH8EkP3v03X6GBBCAn+4toSNQMTsaLcf8uyGGA8=;
        b=6caPGHGUz+Q2VdcvHUvbIzszCPSzrOoY0xdyyljpRV3A53y8Eht8C2YKHNmuEoiT7P
         R5ScL9gvavhDCxlaR5wp72e2Dc2mm2W/in+aPgkoPruZZYEtuG7NyB8ohPIBZr3k0xMt
         gdYm+GWMHVFqDyJl7/se/4ORzSVQPVZ3sCSZ3IAW72PaGgOMuJhhZ9JyzySt0LvR32rx
         plOAzgWPN8Nqtj8qPRMxFZT7mNP8BLKRrlLiJUWRycZG73ffLuvNhdzXi4cOF/tT5KSG
         BiAQ4MYcwtKXv9L1P11J8pkuuxkA33x9OSjkE7eRyT2E/9KE4+GeyftydxRy+pzCEyso
         /myA==
X-Gm-Message-State: AOAM532Rxm8VC5pqAnX52vOe09bk5YZ86w3EemI9msxc4aeqRXyzPk2d
        dRSxWNQ051gC8y2Xkw5bBzAEXUiBQ8M=
X-Google-Smtp-Source: ABdhPJxzhNLNQ1iljiOv/wRe00U+R1t6i69htFowvdfNd2P1gHqbuNRz7EtvjJ+nGTgyQkB2wIfLXA==
X-Received: by 2002:a1c:f310:: with SMTP id q16mr7316108wmq.148.1643202354595;
        Wed, 26 Jan 2022 05:05:54 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b1sm3758560wrd.12.2022.01.26.05.05.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 05:05:53 -0800 (PST)
Message-Id: <f4b925508e77573bc4c4783f82c1a4385a68fcde.1643202349.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1049.v3.git.1643202349.gitgitgadget@gmail.com>
References: <pull.1049.v2.git.1638975481.gitgitgadget@gmail.com>
        <pull.1049.v3.git.1643202349.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 26 Jan 2022 13:05:39 +0000
Subject: [PATCH v3 04/14] rebase: do not remove untracked files on checkout
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Philippe Blain <levraiphilippeblain@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Phillip Wood <phillip.wood@dunelm.org.uk>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

If "git rebase [--apply|--merge] <upstream> <branch>" detects that
<upstream> is an ancestor of <branch> then it will fast-forward and
checkout <branch>. Normally a checkout or picking a commit during a
rebase will refuse to overwrite untracked files, however rebase does
overwrite untracked files when checking out <branch>.

The fix is to only set reset in `unpack_tree_opts` if flags contains
`RESET_HEAD_HARD`. t5403 may seem like an odd home for the new test
but it will be extended in the next commit to check that the
post-checkout hook is not run when the checkout fails.

The test for `!detach_head` dates back to the
original implementation of reset_head() in
ac7f467fef ("builtin/rebase: support running "git rebase <upstream>"",
2018-08-07) and was correct until e65123a71d
("builtin rebase: support `git rebase <upstream> <switch-to>`",
2018-09-04) started using reset_head() to checkout <switch-to> when
fast-forwarding.

Note that 480d3d6bf9 ("Change unpack_trees' 'reset' flag into an
enum", 2021-09-27) also fixes this bug as it changes reset_head() to
never remove untracked files. I think this fix is still worthwhile as
it makes it clear that the same settings are used for detached and
non-detached checkouts.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 reset.c                       |  2 +-
 t/t5403-post-checkout-hook.sh | 10 ++++++++++
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/reset.c b/reset.c
index 315fef91d33..3e7b9e2e131 100644
--- a/reset.c
+++ b/reset.c
@@ -59,7 +59,7 @@ int reset_head(struct repository *r, struct object_id *oid, const char *action,
 	unpack_tree_opts.merge = 1;
 	unpack_tree_opts.preserve_ignored = 0; /* FIXME: !overwrite_ignore */
 	init_checkout_metadata(&unpack_tree_opts.meta, switch_to_branch, oid, NULL);
-	if (!detach_head)
+	if (reset_hard)
 		unpack_tree_opts.reset = UNPACK_RESET_PROTECT_UNTRACKED;
 
 	if (repo_read_index_unmerged(r) < 0) {
diff --git a/t/t5403-post-checkout-hook.sh b/t/t5403-post-checkout-hook.sh
index 17ab518f268..fd2817b4068 100755
--- a/t/t5403-post-checkout-hook.sh
+++ b/t/t5403-post-checkout-hook.sh
@@ -85,6 +85,16 @@ test_rebase () {
 		test_cmp_rev three $new &&
 		test $flag = 1
 	'
+
+	test_expect_success "rebase $args checkout does not remove untracked files" '
+		test_when_finished "test_might_fail git rebase --abort" &&
+		git update-ref refs/heads/rebase-fast-forward three &&
+		git checkout two &&
+		echo untracked >three.t &&
+		test_when_finished "rm three.t" &&
+		test_must_fail git rebase $args HEAD rebase-fast-forward 2>err &&
+		grep "untracked working tree files would be overwritten by checkout" err
+'
 }
 
 test_rebase --apply &&
-- 
gitgitgadget

