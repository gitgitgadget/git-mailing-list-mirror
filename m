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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D14EC4338F
	for <git@archiver.kernel.org>; Mon, 16 Aug 2021 00:55:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 007FD6138F
	for <git@archiver.kernel.org>; Mon, 16 Aug 2021 00:55:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231916AbhHPAzm (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 15 Aug 2021 20:55:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230124AbhHPAzl (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 15 Aug 2021 20:55:41 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0144C061764
        for <git@vger.kernel.org>; Sun, 15 Aug 2021 17:55:09 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id h13so21325692wrp.1
        for <git@vger.kernel.org>; Sun, 15 Aug 2021 17:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=iJU7HRRRmtg+k1r3otT8SfU4XXW2SsBK0f6+S2MiJ/k=;
        b=Lcfi6YkM4OvNA5fXTHpA1TjGIPYVcHXSSsNsnlYQBKGFwz1zdgbvLZQneTXLyY8NdH
         GYpGMD2GUY2zQi0BhwtSTYmO8k6AUoKxbW/4qRa1vfWn/6MrGylIy6Q5LzUeZXJZS6nB
         +mAk7strbjjRrW4jgSeEeTARpNiWr6C6mcTgAJ52ehCU8Rgc0mmiIXKB65z/M9PZcJJN
         qfkLr4D4OARmOUqeHPyEa3ypeR+N7gMnaU+EERhpWVnNwGKCbY3hfM0BgOeWQfDSF8pi
         pNOjCJTxlWKmHb2yEGfIpZzhehA8O1jFcqpHenTdJbK+Dh4/ktILSeY7nWDuSP9h5jSI
         p/MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=iJU7HRRRmtg+k1r3otT8SfU4XXW2SsBK0f6+S2MiJ/k=;
        b=NeSJva/+90Zqk2a5+j4SXInBFNbpV56PlU/ZjdMu6wT/88nxkWqMEs496/hkgaTVeM
         hpo25xY3HQE5ad2bXryA2WE6cuRgi7zJmEEYub5SL9p/L/1n9K4heRQ+JPUqqPu15T65
         Gk8N0vWrkeXhIEG8M2HzY9tQpi3cbofWYE1UuG2ODONQ5WViuWKMfeV5ep7aXbGMnOLc
         9OTicXS5bXx5Qe2FKBTT7JyiSixFufZIC+v7/LsHxEbhCrmIjV74xtPyP2jeJi8po1dX
         OjmLeehNr7cbR7bTq/XnuIDk9eLcww8rBa943hKbWc7Vpd6niUYQgVjq+OFLBNBQiveE
         2MXA==
X-Gm-Message-State: AOAM5311CMfKovUQaj0Mk3dCkjcQN5DGRZzik23hKGK3WPavRTqb0Oc+
        cuUcjzKlhvx/F5mIXAavTAQ0Za+jx0Q=
X-Google-Smtp-Source: ABdhPJwHe1Um5Huf2h/XXeBqzuPIykTdpuNnNHxWNSOy8fptLQ29mzGjkd1Vk8g3NneBn0jCBGn+5w==
X-Received: by 2002:adf:dc05:: with SMTP id t5mr15405625wri.326.1629075308271;
        Sun, 15 Aug 2021 17:55:08 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n13sm2217257wmc.18.2021.08.15.17.55.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Aug 2021 17:55:07 -0700 (PDT)
Message-Id: <pull.1010.v5.git.1629075306706.gitgitgadget@gmail.com>
In-Reply-To: <pull.1010.v4.git.1628936863733.gitgitgadget@gmail.com>
References: <pull.1010.v4.git.1628936863733.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 16 Aug 2021 00:55:06 +0000
Subject: [PATCH v5] [GSOC] cherry-pick: use better advice message
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
Mentored-by Hariom Verma <hariom18599@gmail.com>:
Helped-by: Phillip Wood <phillip.wood@dunelm.org.uk>
Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: ZheNing Hu <adlternative@gmail.com>
---
    [GSOC] cherry-pick: use better advice message
    
    The cherry-pick and revert advice message are only suitable for picking
    one commit or reverting one commit, but not for multiple commits. So
    correct the advice message to have the rest of the range dealt with.
    
    v7:
    https://lore.kernel.org/git/pull.1010.v4.git.1628936863733.gitgitgadget@gmail.com/
    
    v7-->v8:
    
     1. Modify the commit message to make it more in line with the
        specification.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1010%2Fadlternative%2Fcherry-pick-help-fix-3-v5
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1010/adlternative/cherry-pick-help-fix-3-v5
Pull-Request: https://github.com/gitgitgadget/git/pull/1010

Range-diff vs v4:

 1:  dc51c0b8c2b ! 1:  6cf78ffd088 [GSOC] cherry-pick: use better advice message
     @@ Metadata
       ## Commit message ##
          [GSOC] cherry-pick: use better advice message
      
     -    In the past, git cherry-pick would print such advice when
     -    there was a conflict:
     +    "git cherry-pick", upon seeing a conflict, says:
      
          hint: after resolving the conflicts, mark the corrected paths
          hint: with 'git add <paths>' or 'git rm <paths>'
          hint: and commit the result with 'git commit'
      
     -    But in fact, when we want to cherry-pick multiple commits,
     -    we should not use "git commit" after resolving conflicts, which
     -    will make Git generate some errors. We should recommend users to
     -    use `git cherry-pick --continue`, `git cherry-pick --abort`, just
     -    like git rebase does.
     +    as if running "git commit" to conclude the resolution of
     +    this single step were the end of the story.  This stems from
     +    the fact that the command originally was to pick a single
     +    commit and not a range of commits, and the message was
     +    written back then and has not been adjusted.
      
     -    This is the improved advice:
     +    When picking a range of commits and the command stops with a
     +    conflict in the middle of the range, however, after
     +    resolving the conflict and (optionally) recording the result
     +    with "git commit", the user has to run "git cherry-pick
     +    --continue" to have the rest of the range dealt with,
     +    "--skip" to drop the current commit, or "--abort" to discard
     +    the series.
      
     -    hint: Resolve all conflicts manually, mark them as resolved with
     -    hint: "git add/rm <conflicted_files>", then run
     -    hint: "git cherry-pick --continue".
     -    hint: You can instead skip this commit: run "git cherry-pick --skip".
     -    hint: To abort and get back to the state before "git cherry-pick",
     -    hint: run "git cherry-pick --abort".
     +    Suggest use of "git cherry-pick --continue/--skip/--abort"
     +    so that the message also covers the case where a range of
     +    commits are being picked.
      
     -    Similarly, this optimization can be applied to git revert:
     +    Similarly, this optimization can be applied to git revert,
     +    suggest use of "git revert --continue/--skip/--abort" so
     +    that the message also covers the case where a range of
     +    commits are being reverted.
      
     -    hint: Resolve all conflicts manually, mark them as resolved with
     -    hint: "git add/rm <conflicted_files>", then run
     -    hint: "git revert --continue".
     -    hint: You can instead skip this commit: run "git revert --skip".
     -    hint: To abort and get back to the state before "git revert",
     -    hint: run "git revert --abort".
     -
     -    It is worth mentioning that now we use advice() to print the content
     -    of GIT_CHERRY_PICK_HELP in print_advice(), each line of output will
     -    start with "hint: ".
     +    It is worth mentioning that now we use advice() to print
     +    the content of GIT_CHERRY_PICK_HELP in print_advice(), each
     +    line of output will start with "hint: ".
      
          Mentored-by: Christian Couder <christian.couder@gmail.com>
          Mentored-by Hariom Verma <hariom18599@gmail.com>:
          Helped-by: Phillip Wood <phillip.wood@dunelm.org.uk>
     -    Hepled-by: Junio C Hamano <gitster@pobox.com>
     +    Helped-by: Junio C Hamano <gitster@pobox.com>
          Signed-off-by: ZheNing Hu <adlternative@gmail.com>
      
       ## sequencer.c ##


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
