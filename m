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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CA7EC4338F
	for <git@archiver.kernel.org>; Thu, 19 Aug 2021 05:51:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B84660F39
	for <git@archiver.kernel.org>; Thu, 19 Aug 2021 05:51:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230168AbhHSFv4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Aug 2021 01:51:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229981AbhHSFvz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Aug 2021 01:51:55 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC262C061756
        for <git@vger.kernel.org>; Wed, 18 Aug 2021 22:51:19 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id o1-20020a05600c5101b02902e676fe1f04so4700021wms.1
        for <git@vger.kernel.org>; Wed, 18 Aug 2021 22:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=/Z/nIEMHXEd13TIrO/+wOxDKuRM/s5mmoRBVyhBqm9g=;
        b=TOW5Di+cdWHS7MKaxzs7tUIiKtbMP7fmPcHxAztv+I/lZdfSRoHwk9ZqKYsi2+kNo/
         97Guwkkk+S87+E3t5oxvn0Ompl65Osr7iOZtf2ZaGeXmQlCRVDZVwhNFJ3moGlxJGxrM
         cJGvLdPX6Xu2mo4lVfj+SxkwXW4Pf/ozKU5ycD+EV6Tktyyg9X0Z0eshWXfxqAY5eCOF
         l+RPdPDcHaqOUw+qr0HtLxPku+OB0+nA/iSjc2/6w8e0BtDX2nA96p7aX9UFozSRzoAF
         eYjk9tv58Tc4Uo/Iy2Yl0TBoGVjKNNLDlnInGwXIIWveO60S9R0gltiF3+sxjeZsskU4
         o2uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=/Z/nIEMHXEd13TIrO/+wOxDKuRM/s5mmoRBVyhBqm9g=;
        b=RorHJIOsl4jTWRxqhv+E+5vlIEQOUNm167Nk4fInpRVtB+hMSsp7wfwcwrLMcRU5d9
         MT0iyD3weFkIBRlzfgJ1iZ3sNXdgSVdhfpPFK5kODyAx/x+LkqCgcJyUCVJkn/o+2fq8
         duy+kEjQc4Pa8TMJ1z6ttCDtfg6iLgPDa1TjMZqr4sNninKKEYsbUjiY1bC/x7QkXFnq
         8i9g0jXcFEx1SqWfkAjN/QMHzMWIGV6/5rLLAFveO5W2OEMAZ3gjaYiaPP1z7pQfN5ID
         lpUvhRzj7mQ6LfLahL/Tv5aYqxrNAP116GbqSxFgHlzZalpFJCCWk8G++Zz39l6AboH3
         GDQA==
X-Gm-Message-State: AOAM530HaJJD65nC9+orS4vi8gzKqIdooFCcdgu/i9i14vKj8Z40Z68v
        c0FTkh+nnRaK31AcA/rQr58clcNxx60=
X-Google-Smtp-Source: ABdhPJzxN04XRbUZDCd+t6XL0S8GnSiJWTsee+YHN8RfpLa1aTkyR5p1qudYqDheyp/M1KIqqY+ZCg==
X-Received: by 2002:a7b:c2f0:: with SMTP id e16mr11967339wmk.144.1629352278504;
        Wed, 18 Aug 2021 22:51:18 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k1sm1917691wrz.61.2021.08.18.22.51.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Aug 2021 22:51:17 -0700 (PDT)
Message-Id: <pull.1010.v6.git.1629352277151.gitgitgadget@gmail.com>
In-Reply-To: <pull.1010.v5.git.1629075306706.gitgitgadget@gmail.com>
References: <pull.1010.v5.git.1629075306706.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 19 Aug 2021 05:51:16 +0000
Subject: [PATCH v6] [GSOC] cherry-pick: use better advice message
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
Mentored-by Hariom Verma <hariom18599@gmail.com>
Helped-by: Phillip Wood <phillip.wood@dunelm.org.uk>
Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: ZheNing Hu <adlternative@gmail.com>
---
    [GSOC] cherry-pick: use better advice message
    
    The cherry-pick and revert advice message are only suitable for picking
    one commit or reverting one commit, but not for multiple commits. So
    correct the advice message to have the rest of the range dealt with.
    
    v8:
    https://lore.kernel.org/git/pull.1010.v5.git.1629075306706.gitgitgadget@gmail.com/
    
    v8-->v9:
    
     1. Use the test_commit function in the test.
     2. Treat these commands which are not using cherry-pick or revert and
        without setting GIT_CHERRY_PICK_HELP as a BUG.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1010%2Fadlternative%2Fcherry-pick-help-fix-3-v6
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1010/adlternative/cherry-pick-help-fix-3-v6
Pull-Request: https://github.com/gitgitgadget/git/pull/1010

Range-diff vs v5:

 1:  6cf78ffd088 ! 1:  84676c475ee [GSOC] cherry-pick: use better advice message
     @@ Commit message
          line of output will start with "hint: ".
      
          Mentored-by: Christian Couder <christian.couder@gmail.com>
     -    Mentored-by Hariom Verma <hariom18599@gmail.com>:
     +    Mentored-by Hariom Verma <hariom18599@gmail.com>
          Helped-by: Phillip Wood <phillip.wood@dunelm.org.uk>
          Helped-by: Junio C Hamano <gitster@pobox.com>
          Signed-off-by: ZheNing Hu <adlternative@gmail.com>
     @@ sequencer.c: static void print_advice(struct repository *r, int show_hint,
      +				 "To abort and get back to the state before \"git revert\",\n"
      +				 "run \"git revert --abort\"."));
       		else
     - 			advise(_("after resolving the conflicts, mark the corrected paths\n"
     - 				 "with 'git add <paths>' or 'git rm <paths>'\n"
     +-			advise(_("after resolving the conflicts, mark the corrected paths\n"
     +-				 "with 'git add <paths>' or 'git rm <paths>'\n"
     +-				 "and commit the result with 'git commit'"));
     ++			BUG("unexpected pick action in print_advice()");
     + 	}
     + }
     + 
      
       ## t/t3501-revert-cherry-pick.sh ##
      @@ t/t3501-revert-cherry-pick.sh: test_expect_success 'cherry-pick works with dirty renamed file' '
     @@ t/t3501-revert-cherry-pick.sh: test_expect_success 'cherry-pick works with dirty
       '
       
      +test_expect_success 'advice from failed revert' '
     -+	echo dream >dream &&
     -+	git add dream &&
     -+	git commit -m "add dream" &&
     ++	test_commit --no-tag "add dream" dream dream &&
      +	dream_oid=$(git rev-parse --short HEAD) &&
      +	cat <<-EOF >expected &&
      +	error: could not revert $dream_oid... add dream
     @@ t/t3501-revert-cherry-pick.sh: test_expect_success 'cherry-pick works with dirty
      +	hint: To abort and get back to the state before "git revert",
      +	hint: run "git revert --abort".
      +	EOF
     -+	echo dream >>dream &&
     -+	git add dream &&
     -+	git commit -m "double-add dream" &&
     ++	test_commit --append --no-tag "double-add dream" dream dream &&
      +	test_must_fail git revert HEAD^ 2>actual &&
      +	test_cmp expected actual
      +'


 sequencer.c                     | 20 ++++++++++++++++----
 t/t3501-revert-cherry-pick.sh   | 16 ++++++++++++++++
 t/t3507-cherry-pick-conflict.sh | 17 ++++++++++-------
 3 files changed, 42 insertions(+), 11 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 0bec01cf38e..f114b4ba80e 100644
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
-			advise(_("after resolving the conflicts, mark the corrected paths\n"
-				 "with 'git add <paths>' or 'git rm <paths>'\n"
-				 "and commit the result with 'git commit'"));
+			BUG("unexpected pick action in print_advice()");
 	}
 }
 
diff --git a/t/t3501-revert-cherry-pick.sh b/t/t3501-revert-cherry-pick.sh
index 9d100cd1884..e70a33f3e60 100755
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
+	hint: Resolve all conflicts manually, mark them as resolved with
+	hint: "git add/rm <conflicted_files>", then run
+	hint: "git revert --continue".
+	hint: You can instead skip this commit: run "git revert --skip".
+	hint: To abort and get back to the state before "git revert",
+	hint: run "git revert --abort".
+	EOF
+	test_commit --append --no-tag "double-add dream" dream dream &&
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
