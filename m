Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A00D6C63793
	for <git@archiver.kernel.org>; Thu, 22 Jul 2021 14:06:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E4776128C
	for <git@archiver.kernel.org>; Thu, 22 Jul 2021 14:06:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232105AbhGVNZh (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Jul 2021 09:25:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232341AbhGVNZc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jul 2021 09:25:32 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82F56C061760
        for <git@vger.kernel.org>; Thu, 22 Jul 2021 07:06:06 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id i94so6084306wri.4
        for <git@vger.kernel.org>; Thu, 22 Jul 2021 07:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=NqXOqDEiBWkXHYetPfYx9Ce68nLPBGUrR/+5Xl0VZIA=;
        b=jmZ4KQM+trbECUCQ04ZNK109rJFKtpGKXiTjYnXzXUHmZyg+7dDG7EHrOuKL9zSra+
         ypi61OtbA3zkEvHd+ASEqJtA401DC4jf/9sE9omFTpP6JLFFG3DOS67V5GrI7cyObank
         1ZBSxVjuGhKRJpdRXps/OY5OGH0N5BLo6DXQ4H29RLfhTL0qpmO9v74AfB/cCPdqVv6c
         mgWhFA5H2TXJc5EFYse9FMIBu5F0OruFgviuwvCTtg2CJUsUAo84JVlVIqFCJeQFIYIL
         /U+3EhuWrjGiP9W0i1bVHmYRXtxDzYtFKmXKEnl5H3mQFftQ/BtuB7D83NDq3qkhkI1O
         YZUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=NqXOqDEiBWkXHYetPfYx9Ce68nLPBGUrR/+5Xl0VZIA=;
        b=JaKc39sLxaJPlDST8bQS/EDbOMl5F1rNFgpIAmFV6a/z4tcIEsFeQ/Owalxnm9yaTf
         UwYylSTGpGLKX0kc+hVRwPUrqsfVxyKjzk2pKY2hcvlI4RenW/jxuA/YSkdYtE0kVna8
         I/s9A0PKUSZNURFcNIk3zgy2wdYePeA2jPrmUoC38iyTaJXlW+h6/awpH4cfryOgxgPl
         nSVaJ5vuFFslXAqHGlT4pEt40DmI2OrT4Ko+DJ/TOYiHACcMqNqDfgovrY8/N8tNdrFg
         oB4C5kXNePDt1RamiUzBcULw0mxnuJ+i6s/PjTkri4DlU+6IUyzD0xGVCHvq6CAaeTUd
         5oAg==
X-Gm-Message-State: AOAM53052sDb0DO6Q85Bzuk4KYUJf8DYla0phrzDEHAWkxYXYjn7Te+Q
        Q9DKQN3VD+JozAN+TT5yIoPfSM+x624=
X-Google-Smtp-Source: ABdhPJzx+Gyen7aekXDJEer6uFNNh5lRwQGrnEB1uQ0bDRglesyadUS1LyyGiXF/8t87aBZXhABA+w==
X-Received: by 2002:a5d:4a44:: with SMTP id v4mr64583wrs.219.1626962765135;
        Thu, 22 Jul 2021 07:06:05 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j23sm2513300wmo.26.2021.07.22.07.06.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jul 2021 07:06:04 -0700 (PDT)
Message-Id: <pull.1001.git.1626962763373.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 22 Jul 2021 14:06:03 +0000
Subject: [PATCH] [GSOC] cherry-pick: fix bug when used with
 GIT_CHERRY_PICK_HELP
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Han-Wen Nienhuys <hanwen@google.com>,
        Ramkumar Ramachandra <artagnon@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: ZheNing Hu <adlternative@gmail.com>

If we set the value of the environment variable GIT_CHERRY_PICK_HELP
when using `git cherry-pick`, CHERRY_PICK_HEAD will be deleted, then
we will get an error when we try to use `git cherry-pick --continue`
or other cherr-pick command.

So add option action check in print_advice(), we will not remove
CHERRY_PICK_HEAD if we are indeed cherry-picking instead of rebasing.

Signed-off-by: ZheNing Hu <adlternative@gmail.com>
---
    [GSOC] cherry-pick: fix bug when used with GIT_CHERRY_PICK_HELP
    
    E.g. We are now in the branch main, we want to cherry-pick commit
    ac346df, then we want to use GIT_CHERRY_PICK_HELP to use customized
    advice:
    
    GIT_CHERRY_PICK_HELP="you should use git cherry-pick --continue after
    resloving the conflict!" git cherry-pick ac346df
    
    then we can see the correct advice message, but after that, if we want
    to use "git cherry-pick --continue" or other cherry-pick commands, an
    error will appear.
    
    So this patch fixes this bug when git cherry-pick is used with
    environment variable GIT_CHERRY_PICK_HELP.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1001%2Fadlternative%2Fcherry-pick-help-fix-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1001/adlternative/cherry-pick-help-fix-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1001

 sequencer.c                     |  5 +++--
 t/t3507-cherry-pick-conflict.sh | 25 ++++++++++++++++++++-----
 2 files changed, 23 insertions(+), 7 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 0bec01cf38e..c01b0b9e9c9 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -409,8 +409,9 @@ static void print_advice(struct repository *r, int show_hint,
 		 * (typically rebase --interactive) wants to take care
 		 * of the commit itself so remove CHERRY_PICK_HEAD
 		 */
-		refs_delete_ref(get_main_ref_store(r), "", "CHERRY_PICK_HEAD",
-				NULL, 0);
+		if (opts->action != REPLAY_PICK)
+			refs_delete_ref(get_main_ref_store(r), "", "CHERRY_PICK_HEAD",
+					NULL, 0);
 		return;
 	}
 
diff --git a/t/t3507-cherry-pick-conflict.sh b/t/t3507-cherry-pick-conflict.sh
index 014001b8f32..70becaf27aa 100755
--- a/t/t3507-cherry-pick-conflict.sh
+++ b/t/t3507-cherry-pick-conflict.sh
@@ -109,14 +109,29 @@ test_expect_success \
 	test_must_fail git rev-parse --verify CHERRY_PICK_HEAD
 '
 
-test_expect_success 'GIT_CHERRY_PICK_HELP suppresses CHERRY_PICK_HEAD' '
-	pristine_detach initial &&
+test_expect_success 'GIT_CHERRY_PICK_HELP respects CHERRY_PICK_HEAD' '
+	git init repo &&
 	(
+		cd repo &&
+		git branch -M main &&
+		echo 1 >file &&
+		git add file &&
+		git commit -m 1 &&
+		echo 2 >file &&
+		git add file &&
+		git commit -m 2 &&
+		git checkout HEAD~ &&
+		echo 3 >file &&
+		git add file &&
+		git commit -m 3 &&
 		GIT_CHERRY_PICK_HELP="and then do something else" &&
 		export GIT_CHERRY_PICK_HELP &&
-		test_must_fail git cherry-pick picked
-	) &&
-	test_must_fail git rev-parse --verify CHERRY_PICK_HEAD
+		test_must_fail git cherry-pick main &&
+		git rev-parse --verify CHERRY_PICK_HEAD >actual &&
+		git rev-parse --verify main >expect &&
+		test_cmp expect actual &&
+		git cherry-pick --abort
+	)
 '
 
 test_expect_success 'git reset clears CHERRY_PICK_HEAD' '

base-commit: daab8a564f8bbac55f70f8bf86c070e001a9b006
-- 
gitgitgadget
