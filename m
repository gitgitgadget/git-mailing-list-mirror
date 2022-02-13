Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9F7BC433F5
	for <git@archiver.kernel.org>; Sun, 13 Feb 2022 00:40:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232723AbiBMAkH (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 12 Feb 2022 19:40:07 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232696AbiBMAkG (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 Feb 2022 19:40:06 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0F6F60056
        for <git@vger.kernel.org>; Sat, 12 Feb 2022 16:40:01 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id q7so21062494wrc.13
        for <git@vger.kernel.org>; Sat, 12 Feb 2022 16:40:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Vtq8XORj/hxx6nCc44oK4fdOBAXFCtRiqMrYaxSzNHk=;
        b=T8Tk4waw0GvI+fBwIq/BmlVJVvQpouJe2tQtTb0jpupXmExCzEwCK1sJSvjz3JMC4B
         ATiwCkbsUWLFb5h89ii3hkkxKuJzEQMCtZJK1QLKw/yEPRm5D+4NSX5v7xDsWEICMZKT
         GYTo31Wq4/u64wRFFw6GkfjQQvBmGZWcD3fBJkjtPJftupBx8/9wq3D78Z1qXWPFH1dl
         DlzYjKBcKv6AF4eO709A/FHcbO82QmGAMXa5IXM1unfv5ZLlgNSRmbGeC4YU4KcKH9Hl
         Qfi4wg4m/DS1oJTEjLyWxw3uha/KI+TX+LXPvsDLTslDxZKq3cBwnBOzFcqYCcV5nUk+
         55hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Vtq8XORj/hxx6nCc44oK4fdOBAXFCtRiqMrYaxSzNHk=;
        b=2yrKqepo2S93bNC8vyxe1RofAuIkBAAzkoKNS3Of6dDUGGRjz31lQz+phNaIKxkPGS
         UfAzqiIAkigd7Bo7EGgoTQYCdbbbwSPpIH5KllEjLPq7SmnRJ4uIlJeTogXMDbmGgPFB
         Kz1ifvkQBFVVNY+Y6oa7QEiL5XEOnx4UujXTsR5PrVkz3/RblaAgv9UWwoFBFfIG3ZIA
         bfsBaBm74EQchOzayZR32LtcC67vuw7r3YPB20tVqdm98Yknjzq0wRxQnDIblxwa+Q8B
         xWR3GiqdE91xG40mQ3MTUX8POP+gj1MvCoBH0K4fANQy7JBnxGSbg1QprCpfWz5MZLFh
         9EhA==
X-Gm-Message-State: AOAM531TZ3ibEcUQwC4wXYZnuCKL/9DlAAYr3eHfb8YhBCM6c61J100N
        F0825/0mLhrAiECmaXs4FRSxXb2CGec=
X-Google-Smtp-Source: ABdhPJxwOymwGSWbvc338q2z/4tlHyaGR8vKTuUTqSJO08WH7MEEMKbzJCSCT/fk2ntCweijE6VgXw==
X-Received: by 2002:a05:6000:1242:: with SMTP id j2mr6262402wrx.39.1644712800219;
        Sat, 12 Feb 2022 16:40:00 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z2sm7368446wrn.60.2022.02.12.16.39.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Feb 2022 16:39:59 -0800 (PST)
Message-Id: <00777e77118c2479c9dd3cede87b0690602dbc7b.1644712798.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1118.git.1644712797.gitgitgadget@gmail.com>
References: <pull.1118.git.1644712797.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 13 Feb 2022 00:39:51 +0000
Subject: [PATCH 1/7] sparse-checkout: correct reapply's handling of options
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Victoria Dye <vdye@github.com>, Derrick Stolee <stolee@gmail.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Commit 4e256731d6 ("sparse-checkout: enable reapply to take
--[no-]{cone,sparse-index}", 2021-12-14) made it so that reapply could
take additional options but added no tests.  Tests would have shown that
the feature doesn't work because the initial values are set AFTER
parsing the command line options instead of before.  Add a test and set
the initial value at the appropriate time.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/sparse-checkout.c          |  6 +++---
 t/t1091-sparse-checkout-builtin.sh | 31 ++++++++++++++++++++++++++++++
 2 files changed, 34 insertions(+), 3 deletions(-)

diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index b9f79e74969..510cb89b544 100644
--- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -785,15 +785,15 @@ static int sparse_checkout_reapply(int argc, const char **argv)
 	if (!core_apply_sparse_checkout)
 		die(_("must be in a sparse-checkout to reapply sparsity patterns"));
 
+	reapply_opts.cone_mode = -1;
+	reapply_opts.sparse_index = -1;
+
 	argc = parse_options(argc, argv, NULL,
 			     builtin_sparse_checkout_reapply_options,
 			     builtin_sparse_checkout_reapply_usage, 0);
 
 	repo_read_index(the_repository);
 
-	reapply_opts.cone_mode = -1;
-	reapply_opts.sparse_index = -1;
-
 	if (update_modes(&reapply_opts.cone_mode, &reapply_opts.sparse_index))
 		return 1;
 
diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
index 502d42d183a..4a7394f7a58 100755
--- a/t/t1091-sparse-checkout-builtin.sh
+++ b/t/t1091-sparse-checkout-builtin.sh
@@ -510,6 +510,37 @@ test_expect_failure 'sparse-checkout reapply' '
 	git -C tweak sparse-checkout disable
 '
 
+test_expect_success 'reapply can handle config options' '
+	git -C repo sparse-checkout init --cone --no-sparse-index &&
+	git -C repo config --worktree --list >actual &&
+	cat >expect <<-\EOF &&
+	core.sparsecheckout=true
+	core.sparsecheckoutcone=true
+	index.sparse=false
+	EOF
+	test_cmp expect actual &&
+
+	git -C repo sparse-checkout reapply --no-cone --no-sparse-index &&
+	git -C repo config --worktree --list >actual &&
+	cat >expect <<-\EOF &&
+	core.sparsecheckout=true
+	core.sparsecheckoutcone=false
+	index.sparse=false
+	EOF
+	test_cmp expect actual &&
+
+	git -C repo sparse-checkout reapply --cone --sparse-index &&
+	git -C repo config --worktree --list >actual &&
+	cat >expect <<-\EOF &&
+	core.sparsecheckout=true
+	core.sparsecheckoutcone=true
+	index.sparse=true
+	EOF
+	test_cmp expect actual &&
+
+	git -C repo sparse-checkout disable
+'
+
 test_expect_success 'cone mode: set with core.ignoreCase=true' '
 	rm repo/.git/info/sparse-checkout &&
 	git -C repo sparse-checkout init --cone &&
-- 
gitgitgadget

