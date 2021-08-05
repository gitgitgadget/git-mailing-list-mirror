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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1541C4338F
	for <git@archiver.kernel.org>; Thu,  5 Aug 2021 05:48:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7DBF460F42
	for <git@archiver.kernel.org>; Thu,  5 Aug 2021 05:48:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230411AbhHEFsW (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Aug 2021 01:48:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbhHEFsT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Aug 2021 01:48:19 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9627FC061765
        for <git@vger.kernel.org>; Wed,  4 Aug 2021 22:48:05 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id h14so4872299wrx.10
        for <git@vger.kernel.org>; Wed, 04 Aug 2021 22:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=8I93SN+7ZsoV12H8F0dLulJvcZ4brwxvpp3ecKqCB1I=;
        b=lQdgNXFj1VffK0KUaTisi5koIeYlJ60cmo68JBZwcv60VfnnIM7aMOSWk/RwIyvDIA
         P2RbvnP0XkxxseKpNM0ZlOx89dwkBAi4mpiJojcIrhjRJkmjAiMwtFFUxNi8UeWX6UxF
         QsUlpeStibl/ibF6XhURIzp+p+1nTTmEH3Sb7deP5CGl1l7PcLkc+p5epBwyB4R6eOlw
         yKHyWbgXq6b3Ss0iE2Pabn2mpNgq7mGscBexUUtWUyXaX48vMHutSmqxT8IyJWUtghjq
         GbKKP8ZcNmcN++n5Fhv02CQdtp/SrwOHlCXC8kwTKTcIWAQRngTwPCa/Xtgp+Ci4YWCw
         wT7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=8I93SN+7ZsoV12H8F0dLulJvcZ4brwxvpp3ecKqCB1I=;
        b=gHAPbEPsAlVQy68Ppm05HtsllGFTf9haPRPOKkYMIjvsfAVDjy9NUTgA7dFS5gBbDG
         /Jx1mSqFdrIt3jcNhaNnnu6mPlENkKoirjGw4RGxkWcRDN5NhgTmt2BDcN48yZiLaw18
         k13gV9tnkc2UDFItFBoR2RbVtIp2Y19L8+4FBaQkub4obd+0uS7wbyzX8z0AkqX7tQYy
         5il7r7QmGA5K+t1DcICPZyBMpz473/dtDKsmC4BhSGc1vDS4gQjLMGwdplaHBR6JKeLJ
         sF1+AJf/wYcuN0x3k8bI96tskVZeRdF2VlRTt5fENB/GpiBejGT6LFwB356Mu4uhXeF9
         i7cw==
X-Gm-Message-State: AOAM533rPX0YYCVOTGV1bPryqp7hMBSpOkvzm9KrIzFTcJIHijAsFiow
        wR69/yOVkU7VKqEQZWuDO2yF9IhVZXQ=
X-Google-Smtp-Source: ABdhPJzH4LTB4htL8odo5q2+jx9fmRLcrymqUCpEqyk9twYOWYVr0ySWXGcTt4G/aHOVN8yFhGFCzQ==
X-Received: by 2002:a5d:5147:: with SMTP id u7mr3023545wrt.181.1628142484085;
        Wed, 04 Aug 2021 22:48:04 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n3sm4295002wmi.0.2021.08.04.22.48.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Aug 2021 22:48:03 -0700 (PDT)
Message-Id: <pull.1010.v3.git.1628142482640.gitgitgadget@gmail.com>
In-Reply-To: <pull.1010.v2.git.1627953383.gitgitgadget@gmail.com>
References: <pull.1010.v2.git.1627953383.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 05 Aug 2021 05:48:02 +0000
Subject: [PATCH v3] [GSOC] cherry-pick: use better advice message
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
    
    v5:
    https://lore.kernel.org/git/pull.1010.git.1627714877.gitgitgadget@gmail.com/
    
    v5-->v6:
    
     1. Deleted the first patch, which could have made git cherry-pick not
        delete CHERRY_PICK_HEAD when using GIT_CHERRY_PICK_HELP, but both
        Junio and Phillip believe that this design does not need to be
        changed.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1010%2Fadlternative%2Fcherry-pick-help-fix-3-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1010/adlternative/cherry-pick-help-fix-3-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/1010

Range-diff vs v2:

 1:  5d2fd55c580 < -:  ----------- [GSOC] cherry-pick: fix bug when used with GIT_CHERRY_PICK_HELP
 2:  5279bca7a79 ! 1:  701645dde17 [GSOC] cherry-pick: use better advice message
     @@ Commit message
          hint: To abort and get back to the state before "git cherry-pick",
          hint: run "git cherry-pick --abort".
      
     +    It is worth mentioning that now we use advice() to print the content
     +    of GIT_CHERRY_PICK_HELP in print_advice(), each line of output will
     +    start with "hint: ".
     +
          Mentored-by: Christian Couder <christian.couder@gmail.com>
          Mentored-by Hariom Verma <hariom18599@gmail.com>:
          Helped-by: Phillip Wood <phillip.wood@dunelm.org.uk>
     @@ Commit message
          Signed-off-by: ZheNing Hu <adlternative@gmail.com>
      
       ## sequencer.c ##
     -@@ sequencer.c: static void print_advice(struct replay_opts *opts, int show_hint)
     +@@ sequencer.c: static void print_advice(struct repository *r, int show_hint,
     + 	char *msg = getenv("GIT_CHERRY_PICK_HELP");
     + 
       	if (msg) {
     - 		advise("%s\n", msg);
     - 	} else if (show_hint) {
     +-		fprintf(stderr, "%s\n", msg);
     ++		advise("%s\n", msg);
     + 		/*
     + 		 * A conflict has occurred but the porcelain
     + 		 * (typically rebase --interactive) wants to take care
     +@@ sequencer.c: static void print_advice(struct repository *r, int show_hint,
     + 	}
     + 
     + 	if (show_hint) {
      -		if (opts->no_commit)
      +		if (opts->action == REPLAY_PICK) {
      +			advise(_("Resolve all conflicts manually, mark them as resolved with\n"
     @@ sequencer.c: static void print_advice(struct replay_opts *opts, int show_hint)
      +				 "You can instead skip this commit: run \"git cherry-pick --skip\".\n"
      +				 "To abort and get back to the state before \"git cherry-pick\",\n"
      +				 "run \"git cherry-pick --abort\"."));
     -+
      +		} else if (opts->no_commit)
       			advise(_("after resolving the conflicts, mark the corrected paths\n"
       				 "with 'git add <paths>' or 'git rm <paths>'"));


 sequencer.c                     | 11 +++++++++--
 t/t3507-cherry-pick-conflict.sh | 17 ++++++++++++-----
 2 files changed, 21 insertions(+), 7 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 0bec01cf38e..7fa91b99870 100644
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
@@ -415,7 +415,14 @@ static void print_advice(struct repository *r, int show_hint,
 	}
 
 	if (show_hint) {
-		if (opts->no_commit)
+		if (opts->action == REPLAY_PICK) {
+			advise(_("Resolve all conflicts manually, mark them as resolved with\n"
+				 "\"git add/rm <conflicted_files>\", then run\n"
+				 "\"git cherry-pick --continue\".\n"
+				 "You can instead skip this commit: run \"git cherry-pick --skip\".\n"
+				 "To abort and get back to the state before \"git cherry-pick\",\n"
+				 "run \"git cherry-pick --abort\"."));
+		} else if (opts->no_commit)
 			advise(_("after resolving the conflicts, mark the corrected paths\n"
 				 "with 'git add <paths>' or 'git rm <paths>'"));
 		else
diff --git a/t/t3507-cherry-pick-conflict.sh b/t/t3507-cherry-pick-conflict.sh
index 014001b8f32..d3ed9d7ce0d 100755
--- a/t/t3507-cherry-pick-conflict.sh
+++ b/t/t3507-cherry-pick-conflict.sh
@@ -53,9 +53,12 @@ test_expect_success 'advice from failed cherry-pick' "
 	picked=\$(git rev-parse --short picked) &&
 	cat <<-EOF >expected &&
 	error: could not apply \$picked... picked
-	hint: after resolving the conflicts, mark the corrected paths
-	hint: with 'git add <paths>' or 'git rm <paths>'
-	hint: and commit the result with 'git commit'
+	hint: Resolve all conflicts manually, mark them as resolved with
+	hint: \"git add/rm <conflicted_files>\", then run
+	hint: \"git cherry-pick --continue\".
+	hint: You can instead skip this commit: run \"git cherry-pick --skip\".
+	hint: To abort and get back to the state before \"git cherry-pick\",
+	hint: run \"git cherry-pick --abort\".
 	EOF
 	test_must_fail git cherry-pick picked 2>actual &&
 
@@ -68,8 +71,12 @@ test_expect_success 'advice from failed cherry-pick --no-commit' "
 	picked=\$(git rev-parse --short picked) &&
 	cat <<-EOF >expected &&
 	error: could not apply \$picked... picked
-	hint: after resolving the conflicts, mark the corrected paths
-	hint: with 'git add <paths>' or 'git rm <paths>'
+	hint: Resolve all conflicts manually, mark them as resolved with
+	hint: \"git add/rm <conflicted_files>\", then run
+	hint: \"git cherry-pick --continue\".
+	hint: You can instead skip this commit: run \"git cherry-pick --skip\".
+	hint: To abort and get back to the state before \"git cherry-pick\",
+	hint: run \"git cherry-pick --abort\".
 	EOF
 	test_must_fail git cherry-pick --no-commit picked 2>actual &&
 

base-commit: daab8a564f8bbac55f70f8bf86c070e001a9b006
-- 
gitgitgadget
