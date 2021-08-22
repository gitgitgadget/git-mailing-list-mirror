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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4C90C4338F
	for <git@archiver.kernel.org>; Sun, 22 Aug 2021 13:09:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B22F061206
	for <git@archiver.kernel.org>; Sun, 22 Aug 2021 13:09:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232120AbhHVNJ0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 22 Aug 2021 09:09:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230495AbhHVNJZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Aug 2021 09:09:25 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EA08C061575
        for <git@vger.kernel.org>; Sun, 22 Aug 2021 06:08:44 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id q10so21862529wro.2
        for <git@vger.kernel.org>; Sun, 22 Aug 2021 06:08:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=xCAsOZe8SZ1bHR8Wq7SqUgirlxsQ2CvKtQ0bCRWUy2E=;
        b=ZY8y38tlf5fKAfvggiy5dbV/y84L60QMtdw/Ys2oTjAKfVux79iSTzkJtimRF70hbh
         koLbLl60Ts+nvmGrJXUnnwTHwKf/0Hs6G3TGEv0OVPcdxjZ/+tNXIUE6L5Qv+arq2zku
         d+Ul0FF1zXw2eCOjd+8KV+cJixacUvFvRo4PCiH/pz1iqSn9aph97WuhdpGrIYXaxD9L
         I5v9lz/qnx79YApKLSkeBu3AECC/MMuPP7fQSlcLNWwuC0laqg1aayX1KONc9GBqcPLi
         2/XAi6JL1rsIKNP18sJBLBsev7WBg6jwi7l+/cMs8ZHLR+gGcO5SL55lFdUxZXnjFYJ1
         l3Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=xCAsOZe8SZ1bHR8Wq7SqUgirlxsQ2CvKtQ0bCRWUy2E=;
        b=ZL7SiDYNnFHiwlI/9yyBkCJwQyRqlA1egb0OqHHmwa2K6xcIO+KFaecK6LFYFiAbj/
         hKu9gNqH0soJy4WM80CNVxwlH4Ra76/4NsxdcHnR1fL27prJFk2aIIKjfciuZXqxb94V
         zosB7OSD3nJdTCYQVLQcPV8uGSyZXic5ufKsymdeWhUUZ82gWmq4sbHGgvBZEj8db6V0
         ZWbfFdEr/BOBwNFbMI5MZLkfs46Mbe0Jrt4tZZqPuRMm790pWaFCkRxpGD4E6Hc0zdGM
         Kii2Hho9KIXw2w9qzjXrcEIxQdRnj3e4iWWcLnw6qBMMd8FAXoRA275x4Hu9s8J2u32P
         lngw==
X-Gm-Message-State: AOAM533oGOF0YAiJN513WeP7Wz7762tWgThWbBYW4GbHf4HqZtdXDAtQ
        1Br9UmtmnQy6hWCtoyb+j5UrEAvSf/Q=
X-Google-Smtp-Source: ABdhPJyLU4cF16g/H927Lm3T8fyax0c0tfBQ3kZjP+yjkP5sYlg18CP4Imq2n4aPQtU2JFUaLhI42g==
X-Received: by 2002:a5d:474d:: with SMTP id o13mr8542991wrs.256.1629637722807;
        Sun, 22 Aug 2021 06:08:42 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c25sm10434782wmr.15.2021.08.22.06.08.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Aug 2021 06:08:42 -0700 (PDT)
Message-Id: <pull.1010.v7.git.1629637721426.gitgitgadget@gmail.com>
In-Reply-To: <pull.1010.v6.git.1629352277151.gitgitgadget@gmail.com>
References: <pull.1010.v6.git.1629352277151.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 22 Aug 2021 13:08:41 +0000
Subject: [PATCH v7] [GSOC] cherry-pick: use better advice message
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
        Phillip Wood <phillip.wood123@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: ZheNing Hu <adlternative@gmail.com>

"git cherry-pick", upon seeing a conflict, says:

hint: after resolving the conflicts, mark the corrected paths
hint: with 'git add <paths>' or 'git rm <paths>'
hint: and commit the result with 'git commit'

as if running "git commit" to conclude the resolution of
this single step were the end of the story.  This stems from
the fact that the command originally was to pick a single
commit and not a range of commits, and the message was
written back then and has not been adjusted.

When picking a range of commits and the command stops with a
conflict in the middle of the range, however, after
resolving the conflict and (optionally) recording the result
with "git commit", the user has to run "git cherry-pick
--continue" to have the rest of the range dealt with,
"--skip" to drop the current commit, or "--abort" to discard
the series.

Suggest use of "git cherry-pick --continue/--skip/--abort"
so that the message also covers the case where a range of
commits are being picked.

Similarly, this optimization can be applied to git revert,
suggest use of "git revert --continue/--skip/--abort" so
that the message also covers the case where a range of
commits are being reverted.

It is worth mentioning that now we use advice() to print
the content of GIT_CHERRY_PICK_HELP in print_advice(), each
line of output will start with "hint: ".

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Hariom Verma <hariom18599@gmail.com>
Helped-by: Phillip Wood <phillip.wood@dunelm.org.uk>
Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: ZheNing Hu <adlternative@gmail.com>
---
    [GSOC] cherry-pick: use better advice message
    
    The cherry-pick and revert advice message are only suitable for picking
    one commit or reverting one commit, but not for multiple commits. So
    correct the advice message to have the rest of the range dealt with.
    
    v9:
    https://lore.kernel.org/git/pull.1010.v6.git.1629352277151.gitgitgadget@gmail.com/
    
    v9-->v10:
    
     1. Correct the wording of the advice message.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1010%2Fadlternative%2Fcherry-pick-help-fix-3-v7
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1010/adlternative/cherry-pick-help-fix-3-v7
Pull-Request: https://github.com/gitgitgadget/git/pull/1010

Range-diff vs v6:

 1:  84676c475ee ! 1:  07440ea5ffe [GSOC] cherry-pick: use better advice message
     @@ Commit message
          line of output will start with "hint: ".
      
          Mentored-by: Christian Couder <christian.couder@gmail.com>
     -    Mentored-by Hariom Verma <hariom18599@gmail.com>
     +    Mentored-by: Hariom Verma <hariom18599@gmail.com>
          Helped-by: Phillip Wood <phillip.wood@dunelm.org.uk>
          Helped-by: Junio C Hamano <gitster@pobox.com>
          Signed-off-by: ZheNing Hu <adlternative@gmail.com>
     @@ sequencer.c: static void print_advice(struct repository *r, int show_hint,
       			advise(_("after resolving the conflicts, mark the corrected paths\n"
       				 "with 'git add <paths>' or 'git rm <paths>'"));
      +		else if (opts->action == REPLAY_PICK)
     -+			advise(_("Resolve all conflicts manually, mark them as resolved with\n"
     -+				 "\"git add/rm <conflicted_files>\", then run\n"
     ++			advise(_("After resolving the conflicts, mark them with\n"
     ++				 "\"git add/rm <pathspec>\", then run\n"
      +				 "\"git cherry-pick --continue\".\n"
     -+				 "You can instead skip this commit: run \"git cherry-pick --skip\".\n"
     ++				 "You can instead skip this commit with \"git cherry-pick --skip\".\n"
      +				 "To abort and get back to the state before \"git cherry-pick\",\n"
      +				 "run \"git cherry-pick --abort\"."));
      +		else if (opts->action == REPLAY_REVERT)
     -+			advise(_("Resolve all conflicts manually, mark them as resolved with\n"
     -+				 "\"git add/rm <conflicted_files>\", then run\n"
     ++			advise(_("After resolving the conflicts, mark them with\n"
     ++				 "\"git add/rm <pathspec>\", then run\n"
      +				 "\"git revert --continue\".\n"
     -+				 "You can instead skip this commit: run \"git revert --skip\".\n"
     ++				 "You can instead skip this commit with \"git revert --skip\".\n"
      +				 "To abort and get back to the state before \"git revert\",\n"
      +				 "run \"git revert --abort\"."));
       		else
     @@ t/t3501-revert-cherry-pick.sh: test_expect_success 'cherry-pick works with dirty
      +	dream_oid=$(git rev-parse --short HEAD) &&
      +	cat <<-EOF >expected &&
      +	error: could not revert $dream_oid... add dream
     -+	hint: Resolve all conflicts manually, mark them as resolved with
     -+	hint: "git add/rm <conflicted_files>", then run
     ++	hint: After resolving the conflicts, mark them with
     ++	hint: "git add/rm <pathspec>", then run
      +	hint: "git revert --continue".
     -+	hint: You can instead skip this commit: run "git revert --skip".
     ++	hint: You can instead skip this commit with "git revert --skip".
      +	hint: To abort and get back to the state before "git revert",
      +	hint: run "git revert --abort".
      +	EOF
     @@ t/t3507-cherry-pick-conflict.sh: test_expect_success 'failed cherry-pick does no
      -	hint: with 'git add <paths>' or 'git rm <paths>'
      -	hint: and commit the result with 'git commit'
      +	error: could not apply $picked... picked
     -+	hint: Resolve all conflicts manually, mark them as resolved with
     -+	hint: "git add/rm <conflicted_files>", then run
     ++	hint: After resolving the conflicts, mark them with
     ++	hint: "git add/rm <pathspec>", then run
      +	hint: "git cherry-pick --continue".
     -+	hint: You can instead skip this commit: run "git cherry-pick --skip".
     ++	hint: You can instead skip this commit with "git cherry-pick --skip".
      +	hint: To abort and get back to the state before "git cherry-pick",
      +	hint: run "git cherry-pick --abort".
       	EOF


 sequencer.c                     | 20 ++++++++++++++++----
 t/t3501-revert-cherry-pick.sh   | 16 ++++++++++++++++
 t/t3507-cherry-pick-conflict.sh | 17 ++++++++++-------
 3 files changed, 42 insertions(+), 11 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 0bec01cf38e..03c7b3dcadc 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -403,7 +403,7 @@ static void print_advice(struct repository *r, int show_hint,
 	char *msg = getenv("GIT_CHERRY_PICK_HELP");
 
 	if (msg) {
-		fprintf(stderr, "%s\n", msg);
+		advise("%s\n", msg);
 		/*
 		 * A conflict has occurred but the porcelain
 		 * (typically rebase --interactive) wants to take care
@@ -418,10 +418,22 @@ static void print_advice(struct repository *r, int show_hint,
 		if (opts->no_commit)
 			advise(_("after resolving the conflicts, mark the corrected paths\n"
 				 "with 'git add <paths>' or 'git rm <paths>'"));
+		else if (opts->action == REPLAY_PICK)
+			advise(_("After resolving the conflicts, mark them with\n"
+				 "\"git add/rm <pathspec>\", then run\n"
+				 "\"git cherry-pick --continue\".\n"
+				 "You can instead skip this commit with \"git cherry-pick --skip\".\n"
+				 "To abort and get back to the state before \"git cherry-pick\",\n"
+				 "run \"git cherry-pick --abort\"."));
+		else if (opts->action == REPLAY_REVERT)
+			advise(_("After resolving the conflicts, mark them with\n"
+				 "\"git add/rm <pathspec>\", then run\n"
+				 "\"git revert --continue\".\n"
+				 "You can instead skip this commit with \"git revert --skip\".\n"
+				 "To abort and get back to the state before \"git revert\",\n"
+				 "run \"git revert --abort\"."));
 		else
-			advise(_("after resolving the conflicts, mark the corrected paths\n"
-				 "with 'git add <paths>' or 'git rm <paths>'\n"
-				 "and commit the result with 'git commit'"));
+			BUG("unexpected pick action in print_advice()");
 	}
 }
 
diff --git a/t/t3501-revert-cherry-pick.sh b/t/t3501-revert-cherry-pick.sh
index 9d100cd1884..4b5b6076733 100755
--- a/t/t3501-revert-cherry-pick.sh
+++ b/t/t3501-revert-cherry-pick.sh
@@ -158,4 +158,20 @@ test_expect_success 'cherry-pick works with dirty renamed file' '
 	grep -q "^modified$" renamed
 '
 
+test_expect_success 'advice from failed revert' '
+	test_commit --no-tag "add dream" dream dream &&
+	dream_oid=$(git rev-parse --short HEAD) &&
+	cat <<-EOF >expected &&
+	error: could not revert $dream_oid... add dream
+	hint: After resolving the conflicts, mark them with
+	hint: "git add/rm <pathspec>", then run
+	hint: "git revert --continue".
+	hint: You can instead skip this commit with "git revert --skip".
+	hint: To abort and get back to the state before "git revert",
+	hint: run "git revert --abort".
+	EOF
+	test_commit --append --no-tag "double-add dream" dream dream &&
+	test_must_fail git revert HEAD^ 2>actual &&
+	test_cmp expected actual
+'
 test_done
diff --git a/t/t3507-cherry-pick-conflict.sh b/t/t3507-cherry-pick-conflict.sh
index 014001b8f32..979e843c65a 100755
--- a/t/t3507-cherry-pick-conflict.sh
+++ b/t/t3507-cherry-pick-conflict.sh
@@ -47,20 +47,23 @@ test_expect_success 'failed cherry-pick does not advance HEAD' '
 	test "$head" = "$newhead"
 '
 
-test_expect_success 'advice from failed cherry-pick' "
+test_expect_success 'advice from failed cherry-pick' '
 	pristine_detach initial &&
 
-	picked=\$(git rev-parse --short picked) &&
+	picked=$(git rev-parse --short picked) &&
 	cat <<-EOF >expected &&
-	error: could not apply \$picked... picked
-	hint: after resolving the conflicts, mark the corrected paths
-	hint: with 'git add <paths>' or 'git rm <paths>'
-	hint: and commit the result with 'git commit'
+	error: could not apply $picked... picked
+	hint: After resolving the conflicts, mark them with
+	hint: "git add/rm <pathspec>", then run
+	hint: "git cherry-pick --continue".
+	hint: You can instead skip this commit with "git cherry-pick --skip".
+	hint: To abort and get back to the state before "git cherry-pick",
+	hint: run "git cherry-pick --abort".
 	EOF
 	test_must_fail git cherry-pick picked 2>actual &&
 
 	test_cmp expected actual
-"
+'
 
 test_expect_success 'advice from failed cherry-pick --no-commit' "
 	pristine_detach initial &&

base-commit: daab8a564f8bbac55f70f8bf86c070e001a9b006
-- 
gitgitgadget
