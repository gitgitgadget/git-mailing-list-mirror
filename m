Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CCF8C433F5
	for <git@archiver.kernel.org>; Fri, 11 Mar 2022 05:05:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234239AbiCKFGw (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Mar 2022 00:06:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233316AbiCKFGt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Mar 2022 00:06:49 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5C6E1AC28C
        for <git@vger.kernel.org>; Thu, 10 Mar 2022 21:05:46 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id j17so11289008wrc.0
        for <git@vger.kernel.org>; Thu, 10 Mar 2022 21:05:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=cQMY8eBJv03m0zTELUWcg3dDbwHQb7hiymMn9kPePNU=;
        b=peF2fD54cBd2i7k5R0lkMLlFAGnKKpgAv8F7RgRPwjKZXirwBv0RB5lBOfwvNSpL8o
         L+M5+48lGCRA+BaIN/HoMYvVO5xxGFjEPCpDoWJ0tIepetc2zr5WcIJu7BeIWn4bD7nX
         CcihMsOyKH3KCRDax0Xfq0Q217FfbBCiBmA0VIbDspDAOyigYns1tTzdkowm+nzmU5RR
         TzkjS0Po+irxGHMSrIuEn5bne71+myHpGulM5w9O3dfHaKFx7g68YiiMVJHOy54PL7Y5
         9Qx3E/OHWHYDKd+MYuAhZuw0fx1uhvOb2Dw+J8zgLndNOooTDJm3WtX8lvNOfCuhufTQ
         lG8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=cQMY8eBJv03m0zTELUWcg3dDbwHQb7hiymMn9kPePNU=;
        b=H0Jhukd1yqVuyCKmeLEiRngrJUj43CuFroQJYari9eXxl6P9cPOj3MvVQMyhHC2nGa
         EwfJrQpV57dAUPUry7AwEdh09L4oNssu8ocaVqq0oomJMDOijEBtZNkFgiFF002+I5nA
         yH+hgXP+58D9DUaY5LwqxDmkgw0Ov9UzfaL6gz+yXZqR/cKYXlBf3iwqKqi5gZMHbnZJ
         07Pz0kdoZot3u6oeYQKWpqXlBWo/BA8Bi1Q5ipOVPFc83hJVzt/KLaX76vzR2jJuzS60
         O9lhI7bamZFo1+Iv5MrJxRxJB1PujeUjGuyeM3Fy1u/0Eg1Q/hCwUX1LjcmL1xdSIbpJ
         +9BQ==
X-Gm-Message-State: AOAM533QMohXDy6EY6dvOG8HUwBzTfSZFZN59EwmMUryIgMUdVA3BMzs
        HfZYhX6Xzh6qlJhrMDSGB1hgFF1jht4=
X-Google-Smtp-Source: ABdhPJyiSto3o47wU0swpMeh/gNNO5xGrcxRX/vbEMHaS/WVoeDHj2xO9q1Y6+9cG9WEfNUSlGCVaA==
X-Received: by 2002:a05:6000:23a:b0:1f0:2359:9cd5 with SMTP id l26-20020a056000023a00b001f023599cd5mr5742561wrz.335.1646975144991;
        Thu, 10 Mar 2022 21:05:44 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i74-20020adf90d0000000b0020373ba7beesm8595466wri.0.2022.03.10.21.05.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Mar 2022 21:05:44 -0800 (PST)
Message-Id: <pull.1226.git.git.1646975144178.gitgitgadget@gmail.com>
From:   "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 11 Mar 2022 05:05:44 +0000
Subject: [PATCH] rebase: set REF_HEAD_DETACH in checkout_up_to_date()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     John Cai <johncai86@gmail.com>, John Cai <johncai86@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: John Cai <johncai86@gmail.com>

Fixes a bug whereby rebase updates the deferenced reference HEAD points
to instead of HEAD directly.

If HEAD is on main and if the following is a fast-forward operation,

git rebase $(git rev-parse main) $(git rev-parse topic)

Instead of HEAD being set to $(git rev-parse topic), rebase erroneously
dereferences HEAD and sets main to $(git rev-parse topic). This bug was
reported by Michael McClimon. See [1].

This is happening because on a fast foward with an oid as a <branch>,
update_refs() will only call update_ref() with REF_NO_DEREF if
RESET_HEAD_DETACH is set. This change was made in 176f5d96 (built-in rebase
--autostash: leave the current branch alone if possible,
2018-11-07). In rebase, we are not setting the RESET_HEAD_DETACH flag,
which means that the update_ref() call ends up dereferencing
HEAD and updating it to the oid used as <branch>.

The correct behavior is that git rebase should update HEAD to $(git
rev-parse topic) without dereferencing it.

Fix this bug by adding the RESET_HEAD_DETACH flag in checkout_up_to_date
so that once reset_head() calls update_refs(), it calls update_ref() with
REF_NO_DEREF which updates HEAD directly intead of deferencing it and
updating the branch that HEAD points to.

Also add a test to ensure this behavior.

1. https://lore.kernel.org/git/xmqqsfrpbepd.fsf@gitster.g/

Signed-off-by: John Cai <johncai86@gmail.com>
---
    rebase: update HEAD when is an oid
    
    Fixes a bug [1] reported by Michael McClimon where rebase with oids will
    erroneously update the branch HEAD points to.
    
     1. https://lore.kernel.org/git/xmqqsfrpbepd.fsf@gitster.g/

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1226%2Fjohn-cai%2Fjc%2Ffix-rebase-oids-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1226/john-cai/jc/fix-rebase-oids-v1
Pull-Request: https://github.com/git/git/pull/1226

 builtin/rebase.c  |  2 +-
 t/t3400-rebase.sh | 21 +++++++++++++++++++++
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index b29ad2b65e7..52afeffcc2e 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -828,7 +828,7 @@ static int checkout_up_to_date(struct rebase_options *options)
 		    options->switch_to);
 	ropts.oid = &options->orig_head;
 	ropts.branch = options->head_name;
-	ropts.flags = RESET_HEAD_RUN_POST_CHECKOUT_HOOK;
+	ropts.flags = RESET_HEAD_RUN_POST_CHECKOUT_HOOK | RESET_HEAD_DETACH;
 	ropts.head_msg = buf.buf;
 	if (reset_head(the_repository, &ropts) < 0)
 		ret = error(_("could not switch to %s"), options->switch_to);
diff --git a/t/t3400-rebase.sh b/t/t3400-rebase.sh
index 71b1735e1dd..0b92e78976c 100755
--- a/t/t3400-rebase.sh
+++ b/t/t3400-rebase.sh
@@ -437,4 +437,25 @@ test_expect_success 'rebase when inside worktree subdirectory' '
 	)
 '
 
+test_expect_success 'rebase with oids' '
+	git init main-wt &&
+	(
+		cd main-wt &&
+		>file &&
+		git add file &&
+		git commit -m initial &&
+		git checkout -b side &&
+		echo >>file &&
+		git commit -a -m side &&
+		git checkout main &&
+		git tag hold &&
+		git checkout -B main hold &&
+		git rev-parse main >pre &&
+		git rebase $(git rev-parse main) $(git rev-parse side) &&
+		git rev-parse main >post &&
+		test "$(git rev-parse side)" = "$(cat .git/HEAD)" &&
+		test_cmp pre post
+	)
+'
+
 test_done

base-commit: 1a4874565fa3b6668042216189551b98b4dc0b1b
-- 
gitgitgadget
