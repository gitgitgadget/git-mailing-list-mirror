Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12C70C28CF5
	for <git@archiver.kernel.org>; Wed, 26 Jan 2022 13:06:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235514AbiAZNGC (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Jan 2022 08:06:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234710AbiAZNF5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jan 2022 08:05:57 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6D79C06161C
        for <git@vger.kernel.org>; Wed, 26 Jan 2022 05:05:56 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id i187-20020a1c3bc4000000b0034d2ed1be2aso3717030wma.1
        for <git@vger.kernel.org>; Wed, 26 Jan 2022 05:05:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=bcCGT7qWydoUuj2E6FQ1QbDM97Qqw7k8VFpmNeRqJyQ=;
        b=BuTp1aYP0sr18TXcn+oJ/TrJX/WZ9Uc0O+kBuchkvvymlOTpvLfxbjtTuft420ClxN
         /smn9CD6CAgx5zavQ5WN/su3+HxSB98bIip+2kWyP06v6X7mPhW/n2tnpUWnwZseentI
         u28SZwsteojxO63u1sDRTbTE1CBDlB4HlmSQIXRj/4Wb+oxki2ntZP2UeV2qBgddij8s
         UCJ5fGlAffyJNJIssX3mvDWkGnAAnhJQKhvIffVMSwByuVHi+vDQZDQ8kpw7Iodu58oB
         AK9Q+dgSkRHsSzPZ4LAdOWm9PxhZ1iO61cA9iR0yzS7rrMPn8pA88fg9bHQN4pg1cdaO
         Tm+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=bcCGT7qWydoUuj2E6FQ1QbDM97Qqw7k8VFpmNeRqJyQ=;
        b=xqphkTTLBkXdI0eBsRaqUeqfjxjhguNT2UwEUMzKw4k+1vTEykySEkDS8BpZQrXSLN
         D0RRrQJU+u168Z2jcoqyQzmhDyI0T72qlrwjT6VUO5srcdIi1M16krrPe0OcD/k++aGD
         WSDfKq7fOjBiTbCF5o2rNoSLIwE2RwD3YwwiJIPvYvLWm5Q1ea3Q4v4MECghYhai8ouh
         Gr9QgA4HHZ5nTbWHWZh48P+4Z7bVRhxD46YHdEe5O3aO6VtWvyqs5r3KAhfDsHIgLMMA
         wk/3LfWV1tVJKZu/NVZO9VtnghSAmcVzO5jl0LN9rxBLBOJqXtqpU6Crm3p40H1t7fW8
         bjrA==
X-Gm-Message-State: AOAM533/NK7NaluK2m7f+/Blgz82ggjubC9PI7lt1rhqQ6pzjpw6W4oH
        ithoM/CusG2+YF0Q4bxV+uiUZSerTWI=
X-Google-Smtp-Source: ABdhPJzIKzULh6ZGhdLBfIREoAoEn+8KdEhYb2EzlpELaXsGdj81MaY3CeA5MhfCJcH7ShR7tWORiw==
X-Received: by 2002:a7b:c441:: with SMTP id l1mr7385777wmi.140.1643202355369;
        Wed, 26 Jan 2022 05:05:55 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u3sm9825194wrs.55.2022.01.26.05.05.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 05:05:55 -0800 (PST)
Message-Id: <4de5104d22d2ddd9c0cdf0e2173667c4796d3322.1643202349.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1049.v3.git.1643202349.gitgitgadget@gmail.com>
References: <pull.1049.v2.git.1638975481.gitgitgadget@gmail.com>
        <pull.1049.v3.git.1643202349.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 26 Jan 2022 13:05:40 +0000
Subject: [PATCH v3 05/14] rebase --apply: don't run post-checkout hook if
 there is an error
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

The hook should only be run if the worktree and refs were successfully
updated. This primarily affects "rebase --apply" but also "rebase
--merge" when it fast-forwards.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 reset.c                       | 2 +-
 t/t5403-post-checkout-hook.sh | 6 +++++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/reset.c b/reset.c
index 3e7b9e2e131..3537de91f65 100644
--- a/reset.c
+++ b/reset.c
@@ -126,7 +126,7 @@ reset_head_refs:
 			ret = create_symref("HEAD", switch_to_branch,
 					    reflog_head);
 	}
-	if (run_hook)
+	if (!ret && run_hook)
 		run_hook_le(NULL, "post-checkout",
 			    oid_to_hex(head ? head : null_oid()),
 			    oid_to_hex(oid), "1", NULL);
diff --git a/t/t5403-post-checkout-hook.sh b/t/t5403-post-checkout-hook.sh
index fd2817b4068..d1181816906 100755
--- a/t/t5403-post-checkout-hook.sh
+++ b/t/t5403-post-checkout-hook.sh
@@ -88,12 +88,16 @@ test_rebase () {
 
 	test_expect_success "rebase $args checkout does not remove untracked files" '
 		test_when_finished "test_might_fail git rebase --abort" &&
+		test_when_finished "rm -f .git/post-checkout.args" &&
 		git update-ref refs/heads/rebase-fast-forward three &&
 		git checkout two &&
+		rm -f .git/post-checkout.args &&
 		echo untracked >three.t &&
 		test_when_finished "rm three.t" &&
 		test_must_fail git rebase $args HEAD rebase-fast-forward 2>err &&
-		grep "untracked working tree files would be overwritten by checkout" err
+		grep "untracked working tree files would be overwritten by checkout" err &&
+		test_path_is_missing .git/post-checkout.args
+
 '
 }
 
-- 
gitgitgadget

