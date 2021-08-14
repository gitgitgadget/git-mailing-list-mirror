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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EEC3C4338F
	for <git@archiver.kernel.org>; Sat, 14 Aug 2021 10:27:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7902060F21
	for <git@archiver.kernel.org>; Sat, 14 Aug 2021 10:27:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237697AbhHNK2X (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 14 Aug 2021 06:28:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237454AbhHNK2O (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 Aug 2021 06:28:14 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53F7FC061764
        for <git@vger.kernel.org>; Sat, 14 Aug 2021 03:27:46 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id r7so16747350wrs.0
        for <git@vger.kernel.org>; Sat, 14 Aug 2021 03:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=4NvtmSZpHJu5mSbaeExNEnsFO6UwD6TTm6492COgV5E=;
        b=kh5s5bi/gPORndG3UC1xyZxnSpOR0qK2DjPZ+97fbN2lmw5yC5ugRCfyvQ+/LkoXNT
         t4ydeRjfV9vAlxocfjtxUvp3kodp66RL6oVSpVrZM5Af8YJpOyl7Pb/NGszWSXFX5sWl
         CArE1qKftyUu7uO23pOc+0O1iPjleBIOkU66nX3f4Ztj5Db6j8w/VbLp9he86TZZZxrV
         EuGuiiplQyFa9CHI7I76wMUpGQLLRxbqQghR3piZpduF97IO6Es+1L4ZXV+gg135v6qw
         LKNRWJ5pIx+xh2toLq6eyc3+fwqv1va8/XVIgScPWtOVtHcowZ/hX/sMZiF5iOs5bzOR
         zPMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=4NvtmSZpHJu5mSbaeExNEnsFO6UwD6TTm6492COgV5E=;
        b=g3UX5JyP9wumhd+Na++xt6Bci4eyKikNW3VZKG1I7vPnyIRxXVIbcTEPRdjp/dvAf6
         1zRIrtRBAuklGZ3W9ZrRooY3PhEjils5+ZFqLs+gcmiR9FXvoSsoTfcKpFtS4mlQ829F
         e+y+OPpkZUiWHAh4KHq2XfXl7eVJCsyDrFIqqJ2iJAob0UJjRSfn4DHzTQ1+D5cIe6fF
         bn63tiWg5EtahxsMBb7Agzwoz7YYnPqWUJvS+DIA8MI7p+qdKkx4q590ix5j9jcR+l6b
         jiyvdS+36YzxYjETTkOgcNqUcoM0tnibcSeKkVKBvduaSe/j55HcuXSuwt7nWAWXFoOi
         Mr3g==
X-Gm-Message-State: AOAM530Say76poPrtqPnI10vUBfIyjROcWJrdeAuUQiZJrIi2B6EPmwJ
        UwxU/r5zeF3YOqqPrnVMMBxJbVE0GMA=
X-Google-Smtp-Source: ABdhPJzb3DlUNooPFx4kMcU0bhmi7QASfiZrhtwHcnCp9LpfiDHPBo+dwMGu+r/ZBNXIJiqcA78zJQ==
X-Received: by 2002:adf:dbd0:: with SMTP id e16mr7797770wrj.65.1628936864785;
        Sat, 14 Aug 2021 03:27:44 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a9sm4427481wrv.37.2021.08.14.03.27.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Aug 2021 03:27:44 -0700 (PDT)
Message-Id: <pull.1010.v4.git.1628936863733.gitgitgadget@gmail.com>
In-Reply-To: <pull.1010.v3.git.1628142482640.gitgitgadget@gmail.com>
References: <pull.1010.v3.git.1628142482640.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 14 Aug 2021 10:27:43 +0000
Subject: [PATCH v4] [GSOC] cherry-pick: use better advice message
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

In the past, git cherry-pick would print such advice when
there was a conflict:

hint: after resolving the conflicts, mark the corrected paths
hint: with 'git add <paths>' or 'git rm <paths>'
hint: and commit the result with 'git commit'

But in fact, when we want to cherry-pick multiple commits,
we should not use "git commit" after resolving conflicts, which
will make Git generate some errors. We should recommend users to
use `git cherry-pick --continue`, `git cherry-pick --abort`, just
like git rebase does.

This is the improved advice:

hint: Resolve all conflicts manually, mark them as resolved with
hint: "git add/rm <conflicted_files>", then run
hint: "git cherry-pick --continue".
hint: You can instead skip this commit: run "git cherry-pick --skip".
hint: To abort and get back to the state before "git cherry-pick",
hint: run "git cherry-pick --abort".

Similarly, this optimization can be applied to git revert:

hint: Resolve all conflicts manually, mark them as resolved with
hint: "git add/rm <conflicted_files>", then run
hint: "git revert --continue".
hint: You can instead skip this commit: run "git revert --skip".
hint: To abort and get back to the state before "git revert",
hint: run "git revert --abort".

It is worth mentioning that now we use advice() to print the content
of GIT_CHERRY_PICK_HELP in print_advice(), each line of output will
start with "hint: ".

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by Hariom Verma <hariom18599@gmail.com>:
Helped-by: Phillip Wood <phillip.wood@dunelm.org.uk>
Hepled-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: ZheNing Hu <adlternative@gmail.com>
---
    [GSOC] cherry-pick: use better advice message
    
    Because git cherry-pick's past advice message is not good enough, it
    often misleads new users of Git, so this patch makes git chery-pick
    advice message better.
    
    v6:
    https://lore.kernel.org/git/pull.1010.v3.git.1628142482640.gitgitgadget@gmail.com/
    
    v6-->v7:
    
     1. Modify the advice order, respect git cherry-pick --no-commit advice.
     2. Let git revert also use better message.
     3. Use double quotes instead of single quotes for the test body.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1010%2Fadlternative%2Fcherry-pick-help-fix-3-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1010/adlternative/cherry-pick-help-fix-3-v4
Pull-Request: https://github.com/gitgitgadget/git/pull/1010

Range-diff vs v3:

 1:  701645dde17 ! 1:  dc51c0b8c2b [GSOC] cherry-pick: use better advice message
     @@ Commit message
          hint: To abort and get back to the state before "git cherry-pick",
          hint: run "git cherry-pick --abort".
      
     +    Similarly, this optimization can be applied to git revert:
     +
     +    hint: Resolve all conflicts manually, mark them as resolved with
     +    hint: "git add/rm <conflicted_files>", then run
     +    hint: "git revert --continue".
     +    hint: You can instead skip this commit: run "git revert --skip".
     +    hint: To abort and get back to the state before "git revert",
     +    hint: run "git revert --abort".
     +
          It is worth mentioning that now we use advice() to print the content
          of GIT_CHERRY_PICK_HELP in print_advice(), each line of output will
          start with "hint: ".
     @@ sequencer.c: static void print_advice(struct repository *r, int show_hint,
       		 * A conflict has occurred but the porcelain
       		 * (typically rebase --interactive) wants to take care
      @@ sequencer.c: static void print_advice(struct repository *r, int show_hint,
     - 	}
     - 
     - 	if (show_hint) {
     --		if (opts->no_commit)
     -+		if (opts->action == REPLAY_PICK) {
     + 		if (opts->no_commit)
     + 			advise(_("after resolving the conflicts, mark the corrected paths\n"
     + 				 "with 'git add <paths>' or 'git rm <paths>'"));
     ++		else if (opts->action == REPLAY_PICK)
      +			advise(_("Resolve all conflicts manually, mark them as resolved with\n"
      +				 "\"git add/rm <conflicted_files>\", then run\n"
      +				 "\"git cherry-pick --continue\".\n"
      +				 "You can instead skip this commit: run \"git cherry-pick --skip\".\n"
      +				 "To abort and get back to the state before \"git cherry-pick\",\n"
      +				 "run \"git cherry-pick --abort\"."));
     -+		} else if (opts->no_commit)
     - 			advise(_("after resolving the conflicts, mark the corrected paths\n"
     - 				 "with 'git add <paths>' or 'git rm <paths>'"));
     ++		else if (opts->action == REPLAY_REVERT)
     ++			advise(_("Resolve all conflicts manually, mark them as resolved with\n"
     ++				 "\"git add/rm <conflicted_files>\", then run\n"
     ++				 "\"git revert --continue\".\n"
     ++				 "You can instead skip this commit: run \"git revert --skip\".\n"
     ++				 "To abort and get back to the state before \"git revert\",\n"
     ++				 "run \"git revert --abort\"."));
       		else
     + 			advise(_("after resolving the conflicts, mark the corrected paths\n"
     + 				 "with 'git add <paths>' or 'git rm <paths>'\n"
     +
     + ## t/t3501-revert-cherry-pick.sh ##
     +@@ t/t3501-revert-cherry-pick.sh: test_expect_success 'cherry-pick works with dirty renamed file' '
     + 	grep -q "^modified$" renamed
     + '
     + 
     ++test_expect_success 'advice from failed revert' '
     ++	echo dream >dream &&
     ++	git add dream &&
     ++	git commit -m "add dream" &&
     ++	dream_oid=$(git rev-parse --short HEAD) &&
     ++	cat <<-EOF >expected &&
     ++	error: could not revert $dream_oid... add dream
     ++	hint: Resolve all conflicts manually, mark them as resolved with
     ++	hint: "git add/rm <conflicted_files>", then run
     ++	hint: "git revert --continue".
     ++	hint: You can instead skip this commit: run "git revert --skip".
     ++	hint: To abort and get back to the state before "git revert",
     ++	hint: run "git revert --abort".
     ++	EOF
     ++	echo dream >>dream &&
     ++	git add dream &&
     ++	git commit -m "double-add dream" &&
     ++	test_must_fail git revert HEAD^ 2>actual &&
     ++	test_cmp expected actual
     ++'
     + test_done
      
       ## t/t3507-cherry-pick-conflict.sh ##
     -@@ t/t3507-cherry-pick-conflict.sh: test_expect_success 'advice from failed cherry-pick' "
     - 	picked=\$(git rev-parse --short picked) &&
     +@@ t/t3507-cherry-pick-conflict.sh: test_expect_success 'failed cherry-pick does not advance HEAD' '
     + 	test "$head" = "$newhead"
     + '
     + 
     +-test_expect_success 'advice from failed cherry-pick' "
     ++test_expect_success 'advice from failed cherry-pick' '
     + 	pristine_detach initial &&
     + 
     +-	picked=\$(git rev-parse --short picked) &&
     ++	picked=$(git rev-parse --short picked) &&
       	cat <<-EOF >expected &&
     - 	error: could not apply \$picked... picked
     +-	error: could not apply \$picked... picked
      -	hint: after resolving the conflicts, mark the corrected paths
      -	hint: with 'git add <paths>' or 'git rm <paths>'
      -	hint: and commit the result with 'git commit'
     ++	error: could not apply $picked... picked
      +	hint: Resolve all conflicts manually, mark them as resolved with
     -+	hint: \"git add/rm <conflicted_files>\", then run
     -+	hint: \"git cherry-pick --continue\".
     -+	hint: You can instead skip this commit: run \"git cherry-pick --skip\".
     -+	hint: To abort and get back to the state before \"git cherry-pick\",
     -+	hint: run \"git cherry-pick --abort\".
     ++	hint: "git add/rm <conflicted_files>", then run
     ++	hint: "git cherry-pick --continue".
     ++	hint: You can instead skip this commit: run "git cherry-pick --skip".
     ++	hint: To abort and get back to the state before "git cherry-pick",
     ++	hint: run "git cherry-pick --abort".
       	EOF
       	test_must_fail git cherry-pick picked 2>actual &&
       
     -@@ t/t3507-cherry-pick-conflict.sh: test_expect_success 'advice from failed cherry-pick --no-commit' "
     - 	picked=\$(git rev-parse --short picked) &&
     - 	cat <<-EOF >expected &&
     - 	error: could not apply \$picked... picked
     --	hint: after resolving the conflicts, mark the corrected paths
     --	hint: with 'git add <paths>' or 'git rm <paths>'
     -+	hint: Resolve all conflicts manually, mark them as resolved with
     -+	hint: \"git add/rm <conflicted_files>\", then run
     -+	hint: \"git cherry-pick --continue\".
     -+	hint: You can instead skip this commit: run \"git cherry-pick --skip\".
     -+	hint: To abort and get back to the state before \"git cherry-pick\",
     -+	hint: run \"git cherry-pick --abort\".
     - 	EOF
     - 	test_must_fail git cherry-pick --no-commit picked 2>actual &&
     + 	test_cmp expected actual
     +-"
     ++'
       
     + test_expect_success 'advice from failed cherry-pick --no-commit' "
     + 	pristine_detach initial &&


 sequencer.c                     | 16 +++++++++++++++-
 t/t3501-revert-cherry-pick.sh   | 20 ++++++++++++++++++++
 t/t3507-cherry-pick-conflict.sh | 17 ++++++++++-------
 3 files changed, 45 insertions(+), 8 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 0bec01cf38e..2dd73d24a87 100644
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
@@ -418,6 +418,20 @@ static void print_advice(struct repository *r, int show_hint,
 		if (opts->no_commit)
 			advise(_("after resolving the conflicts, mark the corrected paths\n"
 				 "with 'git add <paths>' or 'git rm <paths>'"));
+		else if (opts->action == REPLAY_PICK)
+			advise(_("Resolve all conflicts manually, mark them as resolved with\n"
+				 "\"git add/rm <conflicted_files>\", then run\n"
+				 "\"git cherry-pick --continue\".\n"
+				 "You can instead skip this commit: run \"git cherry-pick --skip\".\n"
+				 "To abort and get back to the state before \"git cherry-pick\",\n"
+				 "run \"git cherry-pick --abort\"."));
+		else if (opts->action == REPLAY_REVERT)
+			advise(_("Resolve all conflicts manually, mark them as resolved with\n"
+				 "\"git add/rm <conflicted_files>\", then run\n"
+				 "\"git revert --continue\".\n"
+				 "You can instead skip this commit: run \"git revert --skip\".\n"
+				 "To abort and get back to the state before \"git revert\",\n"
+				 "run \"git revert --abort\"."));
 		else
 			advise(_("after resolving the conflicts, mark the corrected paths\n"
 				 "with 'git add <paths>' or 'git rm <paths>'\n"
diff --git a/t/t3501-revert-cherry-pick.sh b/t/t3501-revert-cherry-pick.sh
index 9d100cd1884..6766aed7282 100755
--- a/t/t3501-revert-cherry-pick.sh
+++ b/t/t3501-revert-cherry-pick.sh
@@ -158,4 +158,24 @@ test_expect_success 'cherry-pick works with dirty renamed file' '
 	grep -q "^modified$" renamed
 '
 
+test_expect_success 'advice from failed revert' '
+	echo dream >dream &&
+	git add dream &&
+	git commit -m "add dream" &&
+	dream_oid=$(git rev-parse --short HEAD) &&
+	cat <<-EOF >expected &&
+	error: could not revert $dream_oid... add dream
+	hint: Resolve all conflicts manually, mark them as resolved with
+	hint: "git add/rm <conflicted_files>", then run
+	hint: "git revert --continue".
+	hint: You can instead skip this commit: run "git revert --skip".
+	hint: To abort and get back to the state before "git revert",
+	hint: run "git revert --abort".
+	EOF
+	echo dream >>dream &&
+	git add dream &&
+	git commit -m "double-add dream" &&
+	test_must_fail git revert HEAD^ 2>actual &&
+	test_cmp expected actual
+'
 test_done
diff --git a/t/t3507-cherry-pick-conflict.sh b/t/t3507-cherry-pick-conflict.sh
index 014001b8f32..cb2ebea9ad3 100755
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
+	hint: Resolve all conflicts manually, mark them as resolved with
+	hint: "git add/rm <conflicted_files>", then run
+	hint: "git cherry-pick --continue".
+	hint: You can instead skip this commit: run "git cherry-pick --skip".
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
