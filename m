Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA457C433FE
	for <git@archiver.kernel.org>; Wed,  8 Dec 2021 14:58:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235602AbhLHPBm (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Dec 2021 10:01:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235579AbhLHPBj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Dec 2021 10:01:39 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDA72C061746
        for <git@vger.kernel.org>; Wed,  8 Dec 2021 06:58:07 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id c4so4516395wrd.9
        for <git@vger.kernel.org>; Wed, 08 Dec 2021 06:58:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=g18gxowLGlOAHdHgd0AVy0n2vqA1nu30Ytr4gA/Pvm4=;
        b=qhh6dOywKGDqrVW4DTEqzBg9bZ+HsiShcI68/P3/PE5HAJkvSXwuL5oj49QqpZSJIs
         XFmX0etRkY2URTohv0zDEUbIRqfNKPGiSoTcn3quTZEBDoGUL3YMgXOTfRqn6vOFz3NL
         q9u9Z6ivwIm7TPsfskkSzhtBhXKG3pimIXgy/jVuhr+o1/BpGyjIE/79exuDesl5zTPn
         iwhG/jfVkfaFgBxxoggfHtKcEDf7V5YpoN4lwIs4926b70Wo10Wxwkcr53m7S0uD8YoX
         NrPJqm67UM1/XBH/rzsqrwaCX1vOMK0cDP0qgl0Oa5wE3+yfGbrkQ4GVU2kiS1VBishH
         T5dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=g18gxowLGlOAHdHgd0AVy0n2vqA1nu30Ytr4gA/Pvm4=;
        b=oaHtM1nNA9ewBPbOWa9V3qLLO2CWWbT4X7ehTmXUUkemrAdKkEdrJmDyiaDFqH37Mq
         zQmi1VtBRJ98oWsTF7jdR2lVj4EOsFYOrufAVOIWhMUqoFToToDkmNEA8bmMaAtmDZAJ
         vxFQWGBFFeIrQOmvgFZXcIpBJiKxHsVNAPwuRRDsPHBzq0fSq1PfyBX2z7DW+T87CbeN
         9pAYUjdo/iKhj4LnT/50sf8JyvWGxwTkHVeTjQpDtFECFO6OBIhS03fTUQhr4jc25P8C
         Fz/xBoJ352aZSpmRr/zI1WfEVKkHsg1yGvRC5+4inQEy3ZCsifwrUNBhoP4FXQIb/K74
         YLiQ==
X-Gm-Message-State: AOAM533ebjDqGVZXpk4rEfFfNPr3/lUrcmTS1oqDYXFyhsvvHNEyTA64
        C+vBfeJ31HOrrby/vKVud0txnhgGru0=
X-Google-Smtp-Source: ABdhPJzoEhaGEqeV3yUdh6+F7Gl30mIjn/5b5LRPbTNDeFp64f8ldSuGjun4ZfSUYXdkqlU89RP2fg==
X-Received: by 2002:a5d:64cc:: with SMTP id f12mr59308800wri.322.1638975486270;
        Wed, 08 Dec 2021 06:58:06 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g13sm2882534wmk.37.2021.12.08.06.58.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Dec 2021 06:58:06 -0800 (PST)
Message-Id: <2b499704c8f132f173c7328d5f020330481b24dc.1638975482.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1049.v2.git.1638975481.gitgitgadget@gmail.com>
References: <pull.1049.git.1633082702.gitgitgadget@gmail.com>
        <pull.1049.v2.git.1638975481.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 08 Dec 2021 14:57:51 +0000
Subject: [PATCH v2 04/14] rebase: do not remove untracked files on checkout
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
overwrite untracked files when checking <branch>.

The fix is to only set reset in `unpack_tree_opts` if flags contains
`RESET_HEAD_HARD`. t5403 may seem like an odd home for the new test
but it will be extended in the next commit to check that the
post-checkout hook is not run when the checkout fails.

The test for `!deatch_head` dates back to the
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

