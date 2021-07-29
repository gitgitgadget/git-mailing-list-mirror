Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD824C4338F
	for <git@archiver.kernel.org>; Thu, 29 Jul 2021 12:27:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B78B260EFF
	for <git@archiver.kernel.org>; Thu, 29 Jul 2021 12:27:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237020AbhG2M1y (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Jul 2021 08:27:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236686AbhG2M1x (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Jul 2021 08:27:53 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3985C061765
        for <git@vger.kernel.org>; Thu, 29 Jul 2021 05:27:50 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id d8so6721746wrm.4
        for <git@vger.kernel.org>; Thu, 29 Jul 2021 05:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=XbFIb/HNpUYt2gByj/kJiuljgSZ7J8/hIS50CWmSIdw=;
        b=KCvc4SslR1rxELKLjkZEA2hLWRCWO84SAo02FdLCA+2+NK0vPXo9HUs/+iybJOosJk
         LlQBxfkvdDGSXZ4/nbiQOvUaMUph6Ka74lb30rY3TBa3o6QVTUtvU/VdyibEL8gkgPkj
         LIFx9iTDQBLJ7m16mNNnCfJ4X8rPytA35JwePidiMvIMUtVV9+MvE+Uzm+gTehrcIVJq
         b4/x+e7/Sykk1m0RJN24GshRHrHuAvyDbuG4yfcmEeAmmJ/Z7R5zCngzbt/w9AvCEj36
         J4OkcCyo7+eyeNdekUDagoFmIyAZfqw9NHKTeaO09OJUczrnzpgE9TvQQC8PUPh55ywf
         F0MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=XbFIb/HNpUYt2gByj/kJiuljgSZ7J8/hIS50CWmSIdw=;
        b=cgRxN2cWMJOu3zIdgGXq4203XyE3G/rfIldYt+goS08XnuJq60cp8zm4OIQFywyPNJ
         rIEXMie4ZFeUrq0pDcthibv88e0xs18NV4p92EzqpBVCNcmXkuIAF1mJ+tVcpCUOBvN1
         Z3IQlN3c1np7aeKqVh5DtoAlQM73pIp+Gy7jOlCeLUEC7algQ4iE9DPmLxOAk3mfvmN6
         xcXQyMat0j5X4fx8d41briJmNg6LNIabfjfU+BDziFOrlAUXXBqn/OrdMZcDE3uuNEI9
         pxsNBP+3WiWcLVuVTfNHd+wGNFlt3Xf8u/F3eOwscrUi5EfeWfWjnXBbMpnmiBLTBSop
         sdLg==
X-Gm-Message-State: AOAM530Wz0eG2FX8wLpFIQ3WYvzDkBLVKqLjZabhj6w25MRB/mxUldAn
        DHgveYNem2Au4U6+ToBCwd4vBp5agMQ=
X-Google-Smtp-Source: ABdhPJx1y7RvfZNRB9sZ3bf7KvMWMOah8fhKDE5vUNMBqUrBbIyUPNi0M3t47k4fFUBduGrVo9yqqA==
X-Received: by 2002:adf:e601:: with SMTP id p1mr4803982wrm.14.1627561669311;
        Thu, 29 Jul 2021 05:27:49 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u11sm3082009wrp.26.2021.07.29.05.27.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jul 2021 05:27:48 -0700 (PDT)
Message-Id: <5f08f4dc1180ffd6f7fae7419a4c7214fe770b0a.1627561665.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1007.git.1627561665.gitgitgadget@gmail.com>
References: <pull.1007.git.1627561665.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 29 Jul 2021 12:27:44 +0000
Subject: [PATCH 2/2] [GSOC] cherry-pick: use better advice message
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
hint: "git add/rm <conflicted_files>", then run "git cherry-pick \
--continue".
hint: You can instead skip this commit: run "git cherry-pick --skip".
hint: To abort and get back to the state before "git cherry-pick",
hint: run "git cherry-pick --abort".

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by Hariom Verma <hariom18599@gmail.com>:
Helped-by: Phillip Wood <phillip.wood@dunelm.org.uk>
Hepled-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: ZheNing Hu <adlternative@gmail.com>
---
 sequencer.c                     | 19 ++++++++++++++-----
 t/t3507-cherry-pick-conflict.sh | 23 +++++++++++++++--------
 2 files changed, 29 insertions(+), 13 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index ceaf73a34df..b9adeb7e5f5 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -39,6 +39,16 @@
 
 static const char sign_off_header[] = "Signed-off-by: ";
 static const char cherry_picked_prefix[] = "(cherry picked from commit ";
+static const char *no_commit_advice = N_("after resolving the conflicts, mark the corrected paths\n"
+				"with 'git add <paths>' or 'git rm <paths>'");
+static const char *commit_advice = N_("after resolving the conflicts, mark the corrected paths\n"
+			    "with 'git add <paths>' or 'git rm <paths>'\n"
+			    "and commit the result with 'git commit'");
+static const char *cherry_pick_advice = N_("Resolve all conflicts manually, mark them as resolved with\n"
+					"\"git add/rm <conflicted_files>\", then run \"git cherry-pick --continue\".\n"
+					"You can instead skip this commit: run \"git cherry-pick --skip\".\n"
+					"To abort and get back to the state before \"git cherry-pick\",\n"
+					"run \"git cherry-pick --abort\".");
 
 GIT_PATH_FUNC(git_path_commit_editmsg, "COMMIT_EDITMSG")
 
@@ -419,12 +429,9 @@ static void print_advice(struct replay_opts *opts, const char *help_msgs)
 	if (help_msgs)
 		advise("%s\n", help_msgs);
 	else if (opts->no_commit)
-		advise(_("after resolving the conflicts, mark the corrected paths\n"
-			 "with 'git add <paths>' or 'git rm <paths>'"));
+		advise("%s\n", _(no_commit_advice));
 	else
-		advise(_("after resolving the conflicts, mark the corrected paths\n"
-			 "with 'git add <paths>' or 'git rm <paths>'\n"
-			 "and commit the result with 'git commit'"));
+		advise("%s\n", _(commit_advice));
 }
 
 static int write_message(const void *buf, size_t len, const char *filename,
@@ -2269,6 +2276,8 @@ static int do_pick_commit(struct repository *r,
 		      ? _("could not revert %s... %s")
 		      : _("could not apply %s... %s"),
 		      short_commit_name(commit), msg.subject);
+		if (opts->action == REPLAY_PICK)
+			help_msgs = _(cherry_pick_advice);
 		if (((opts->action == REPLAY_PICK &&
 		      !opts->rebase_preserve_merges_mode) ||
 		      (help_msgs = check_need_delete_cherry_pick_head(r))) &&
diff --git a/t/t3507-cherry-pick-conflict.sh b/t/t3507-cherry-pick-conflict.sh
index 6f8035399d9..bf77bb0bd50 100755
--- a/t/t3507-cherry-pick-conflict.sh
+++ b/t/t3507-cherry-pick-conflict.sh
@@ -53,9 +53,11 @@ test_expect_success 'advice from failed cherry-pick' "
 	picked=\$(git rev-parse --short picked) &&
 	cat <<-EOF >expected &&
 	error: could not apply \$picked... picked
-	hint: after resolving the conflicts, mark the corrected paths
-	hint: with 'git add <paths>' or 'git rm <paths>'
-	hint: and commit the result with 'git commit'
+	hint: Resolve all conflicts manually, mark them as resolved with
+	hint: \"git add/rm <conflicted_files>\", then run \"git cherry-pick --continue\".
+	hint: You can instead skip this commit: run \"git cherry-pick --skip\".
+	hint: To abort and get back to the state before \"git cherry-pick\",
+	hint: run \"git cherry-pick --abort\".
 	EOF
 	test_must_fail git cherry-pick picked 2>actual &&
 
@@ -68,8 +70,11 @@ test_expect_success 'advice from failed cherry-pick --no-commit' "
 	picked=\$(git rev-parse --short picked) &&
 	cat <<-EOF >expected &&
 	error: could not apply \$picked... picked
-	hint: after resolving the conflicts, mark the corrected paths
-	hint: with 'git add <paths>' or 'git rm <paths>'
+	hint: Resolve all conflicts manually, mark them as resolved with
+	hint: \"git add/rm <conflicted_files>\", then run \"git cherry-pick --continue\".
+	hint: You can instead skip this commit: run \"git cherry-pick --skip\".
+	hint: To abort and get back to the state before \"git cherry-pick\",
+	hint: run \"git cherry-pick --abort\".
 	EOF
 	test_must_fail git cherry-pick --no-commit picked 2>actual &&
 
@@ -82,9 +87,11 @@ test_expect_success 'advice from failed cherry-pick with GIT_CHERRY_PICK_HELP' "
 		picked=\$(git rev-parse --short picked) &&
 		cat <<-EOF >expected &&
 		error: could not apply \$picked... picked
-		hint: after resolving the conflicts, mark the corrected paths
-		hint: with 'git add <paths>' or 'git rm <paths>'
-		hint: and commit the result with 'git commit'
+		hint: Resolve all conflicts manually, mark them as resolved with
+		hint: \"git add/rm <conflicted_files>\", then run \"git cherry-pick --continue\".
+		hint: You can instead skip this commit: run \"git cherry-pick --skip\".
+		hint: To abort and get back to the state before \"git cherry-pick\",
+		hint: run \"git cherry-pick --abort\".
 		EOF
 		GIT_CHERRY_PICK_HELP='and then do something else' &&
 		export GIT_CHERRY_PICK_HELP &&
-- 
gitgitgadget
