Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D604EC4338F
	for <git@archiver.kernel.org>; Sat, 24 Jul 2021 14:01:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A758D60E97
	for <git@archiver.kernel.org>; Sat, 24 Jul 2021 14:01:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230449AbhGXNUz (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 24 Jul 2021 09:20:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbhGXNUy (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Jul 2021 09:20:54 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B563C061575
        for <git@vger.kernel.org>; Sat, 24 Jul 2021 07:01:25 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id j2so5353266wrx.9
        for <git@vger.kernel.org>; Sat, 24 Jul 2021 07:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=JRcE1l4vKmYVLMzo1FnqNOrbnG1bQc5EcKGcSGZ49Ss=;
        b=PAb+O4B/mykycSdWyKQEkv7YbUXyFtnrFhPGBAhBg7dvCfrlfMAh84RCh6e4iVFvto
         okhqu1yR9tabJ4ue/tvEjsTqMFtitjM5nVirYPVj90BJILvazeBJdVekv9RfxNYdDlz3
         7Cnbm8aaWFRsfrGLf9JhGN8loYCC2mbaulTzWtrc2rJ+2IfeF8rrsp5pKBbugxlqCqW3
         aRiC5fkEiFjd5Srw+sGDNB0z1gw/m1BQDZFVU1SObZqy5EaxcW1JnzjG1kQkjUjaTcOy
         65dfciMmZhRwxF9+wFCtxt/qu8TtU2PLGUkd8S0p3F9fj6lHTz+zMQm+iOxYjsxlATkf
         6/kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=JRcE1l4vKmYVLMzo1FnqNOrbnG1bQc5EcKGcSGZ49Ss=;
        b=tUIqkB+55LFvWaY5RO89p78VV9Yvy4byByIsiRJD9u55VJmNd0l0Ut1yitLY+IpyjQ
         /TpM1xRd7mGjxsKV8QzJb9P4ND6MIru6EltctBKw34MaP7dfSNf75cWkz2VGrFycHwvR
         uHDCvUBQGm1EcH8t2rvIqYn7ojMWwYtzL7K6eJD2AMhLhhE5dSBqhHbJx8yGDsVlc539
         YScyQRmlCik3S6cAMgX6UsJYjCIUTYg6ajIAA2W8PhvtOCGF884DtZtBP4mt9izkFmg5
         NTu6nMQ5g82x8B4adBynwaV4S4/SlTL1TFf8Al1HOGcC4osqT6jWDFl2GEw6kEuWxK5E
         kT/g==
X-Gm-Message-State: AOAM5334m4a6wtCnxiATsSomiQXymM19ZGaXeenc2J7fx44ahZMIvWXH
        ivMHGAz2c1hKda8GWGQETnR+VS78qHE=
X-Google-Smtp-Source: ABdhPJyROQRurubDdEHix4vM+7dHo702KjAxW0pu3H7VkydvtFrRxVH+QaXQ04S27sDXpZamW7bBcQ==
X-Received: by 2002:a05:6000:11c5:: with SMTP id i5mr10435592wrx.268.1627135283556;
        Sat, 24 Jul 2021 07:01:23 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r6sm1267378wmq.12.2021.07.24.07.01.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Jul 2021 07:01:22 -0700 (PDT)
Message-Id: <pull.1001.v2.git.1627135281887.gitgitgadget@gmail.com>
In-Reply-To: <pull.1001.git.1626962763373.gitgitgadget@gmail.com>
References: <pull.1001.git.1626962763373.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 24 Jul 2021 14:01:21 +0000
Subject: [PATCH v2] [GSOC] cherry-pick: fix bug when used with
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
        Felipe Contreras <felipe.contreras@gmail.com>,
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

So unsetenv(GIT_CHERRY_PICK_HELP) in cmd_cherry_pick(), to avoid
deleting CHERRY_PICK_HEAD when we are truly cherry-picking, which can
fix this breakage.

Signed-off-by: ZheNing Hu <adlternative@gmail.com>
Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by Hariom Verma <hariom18599@gmail.com>:
---
    [GSOC] cherry-pick: fix bug when used with GIT_CHERRY_PICK_HELP
    
    This patch fixes the bug when git cherry-pick is used with environment
    variable GIT_CHERRY_PICK_HELP.
    
    Change from last version:
    
     1. Only unsetenv(GIT_CHERRY_PICK_HELP) without touching anything in
        sequencer.c. Now git cherry-pick will ignore GIT_CHERRY_PICK_HELP,
    
    $ GIT_CHERRY_PICK_HELP="213" git cherry-pick dev~3..dev
    
    will only output default advice:
    
    hint: after resolving the conflicts, mark the corrected paths hint: with
    'git add ' or 'git rm ' hint: and commit the result with 'git commit'
    
    This may still not be good enough, hope that cherry-pick will not advice
    anything related to "git commit". Maybe we should make --no-commit as
    cherry-pick default behavior?

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1001%2Fadlternative%2Fcherry-pick-help-fix-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1001/adlternative/cherry-pick-help-fix-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1001

Range-diff vs v1:

 1:  c2a6a625ac8 ! 1:  fbb9c166502 [GSOC] cherry-pick: fix bug when used with GIT_CHERRY_PICK_HELP
     @@ Commit message
          we will get an error when we try to use `git cherry-pick --continue`
          or other cherr-pick command.
      
     -    So add option action check in print_advice(), we will not remove
     -    CHERRY_PICK_HEAD if we are indeed cherry-picking instead of rebasing.
     +    So unsetenv(GIT_CHERRY_PICK_HELP) in cmd_cherry_pick(), to avoid
     +    deleting CHERRY_PICK_HEAD when we are truly cherry-picking, which can
     +    fix this breakage.
      
          Signed-off-by: ZheNing Hu <adlternative@gmail.com>
     +    Mentored-by: Christian Couder <christian.couder@gmail.com>
     +    Mentored-by Hariom Verma <hariom18599@gmail.com>:
      
     - ## sequencer.c ##
     -@@ sequencer.c: static void print_advice(struct repository *r, int show_hint,
     - 		 * (typically rebase --interactive) wants to take care
     - 		 * of the commit itself so remove CHERRY_PICK_HEAD
     - 		 */
     --		refs_delete_ref(get_main_ref_store(r), "", "CHERRY_PICK_HEAD",
     --				NULL, 0);
     -+		if (opts->action != REPLAY_PICK)
     -+			refs_delete_ref(get_main_ref_store(r), "", "CHERRY_PICK_HEAD",
     -+					NULL, 0);
     - 		return;
     - 	}
     + ## builtin/revert.c ##
     +@@ builtin/revert.c: int cmd_cherry_pick(int argc, const char **argv, const char *prefix)
       
     + 	opts.action = REPLAY_PICK;
     + 	sequencer_init_config(&opts);
     ++	unsetenv("GIT_CHERRY_PICK_HELP");
     + 	res = run_sequencer(argc, argv, &opts);
     + 	if (res < 0)
     + 		die(_("cherry-pick failed"));
      
       ## t/t3507-cherry-pick-conflict.sh ##
     +@@ t/t3507-cherry-pick-conflict.sh: test_expect_success 'advice from failed cherry-pick --no-commit' "
     + 	test_cmp expected actual
     + "
     + 
     ++test_expect_success 'advice from failed cherry-pick with GIT_CHERRY_PICK_HELP' "
     ++	pristine_detach initial &&
     ++	(
     ++		picked=\$(git rev-parse --short picked) &&
     ++		cat <<-EOF >expected &&
     ++		error: could not apply \$picked... picked
     ++		hint: after resolving the conflicts, mark the corrected paths
     ++		hint: with 'git add <paths>' or 'git rm <paths>'
     ++		hint: and commit the result with 'git commit'
     ++		EOF
     ++		GIT_CHERRY_PICK_HELP='and then do something else' &&
     ++		export GIT_CHERRY_PICK_HELP &&
     ++		test_must_fail git cherry-pick picked 2>actual &&
     ++		test_cmp expected actual
     ++	)
     ++"
     ++
     + test_expect_success 'failed cherry-pick sets CHERRY_PICK_HEAD' '
     + 	pristine_detach initial &&
     + 	test_must_fail git cherry-pick picked &&
      @@ t/t3507-cherry-pick-conflict.sh: test_expect_success \
       	test_must_fail git rev-parse --verify CHERRY_PICK_HEAD
       '
       
      -test_expect_success 'GIT_CHERRY_PICK_HELP suppresses CHERRY_PICK_HEAD' '
      -	pristine_detach initial &&
     -+test_expect_success 'GIT_CHERRY_PICK_HELP respects CHERRY_PICK_HEAD' '
     -+	git init repo &&
     - 	(
     -+		cd repo &&
     -+		git branch -M main &&
     -+		echo 1 >file &&
     -+		git add file &&
     -+		git commit -m 1 &&
     -+		echo 2 >file &&
     -+		git add file &&
     -+		git commit -m 2 &&
     -+		git checkout HEAD~ &&
     -+		echo 3 >file &&
     -+		git add file &&
     -+		git commit -m 3 &&
     - 		GIT_CHERRY_PICK_HELP="and then do something else" &&
     - 		export GIT_CHERRY_PICK_HELP &&
     +-	(
     +-		GIT_CHERRY_PICK_HELP="and then do something else" &&
     +-		export GIT_CHERRY_PICK_HELP &&
      -		test_must_fail git cherry-pick picked
      -	) &&
      -	test_must_fail git rev-parse --verify CHERRY_PICK_HEAD
     -+		test_must_fail git cherry-pick main &&
     -+		git rev-parse --verify CHERRY_PICK_HEAD >actual &&
     -+		git rev-parse --verify main >expect &&
     -+		test_cmp expect actual &&
     -+		git cherry-pick --abort
     -+	)
     - '
     - 
     +-'
     +-
       test_expect_success 'git reset clears CHERRY_PICK_HEAD' '
     + 	pristine_detach initial &&
     + 


 builtin/revert.c                |  1 +
 t/t3507-cherry-pick-conflict.sh | 27 +++++++++++++++++----------
 2 files changed, 18 insertions(+), 10 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index 237f2f18d4c..ec0abe7db73 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -245,6 +245,7 @@ int cmd_cherry_pick(int argc, const char **argv, const char *prefix)
 
 	opts.action = REPLAY_PICK;
 	sequencer_init_config(&opts);
+	unsetenv("GIT_CHERRY_PICK_HELP");
 	res = run_sequencer(argc, argv, &opts);
 	if (res < 0)
 		die(_("cherry-pick failed"));
diff --git a/t/t3507-cherry-pick-conflict.sh b/t/t3507-cherry-pick-conflict.sh
index 014001b8f32..6f8035399d9 100755
--- a/t/t3507-cherry-pick-conflict.sh
+++ b/t/t3507-cherry-pick-conflict.sh
@@ -76,6 +76,23 @@ test_expect_success 'advice from failed cherry-pick --no-commit' "
 	test_cmp expected actual
 "
 
+test_expect_success 'advice from failed cherry-pick with GIT_CHERRY_PICK_HELP' "
+	pristine_detach initial &&
+	(
+		picked=\$(git rev-parse --short picked) &&
+		cat <<-EOF >expected &&
+		error: could not apply \$picked... picked
+		hint: after resolving the conflicts, mark the corrected paths
+		hint: with 'git add <paths>' or 'git rm <paths>'
+		hint: and commit the result with 'git commit'
+		EOF
+		GIT_CHERRY_PICK_HELP='and then do something else' &&
+		export GIT_CHERRY_PICK_HELP &&
+		test_must_fail git cherry-pick picked 2>actual &&
+		test_cmp expected actual
+	)
+"
+
 test_expect_success 'failed cherry-pick sets CHERRY_PICK_HEAD' '
 	pristine_detach initial &&
 	test_must_fail git cherry-pick picked &&
@@ -109,16 +126,6 @@ test_expect_success \
 	test_must_fail git rev-parse --verify CHERRY_PICK_HEAD
 '
 
-test_expect_success 'GIT_CHERRY_PICK_HELP suppresses CHERRY_PICK_HEAD' '
-	pristine_detach initial &&
-	(
-		GIT_CHERRY_PICK_HELP="and then do something else" &&
-		export GIT_CHERRY_PICK_HELP &&
-		test_must_fail git cherry-pick picked
-	) &&
-	test_must_fail git rev-parse --verify CHERRY_PICK_HEAD
-'
-
 test_expect_success 'git reset clears CHERRY_PICK_HEAD' '
 	pristine_detach initial &&
 

base-commit: daab8a564f8bbac55f70f8bf86c070e001a9b006
-- 
gitgitgadget
