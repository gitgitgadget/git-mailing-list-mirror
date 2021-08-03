Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BD96C432BE
	for <git@archiver.kernel.org>; Tue,  3 Aug 2021 01:16:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6DD0860FA0
	for <git@archiver.kernel.org>; Tue,  3 Aug 2021 01:16:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233567AbhHCBQl (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Aug 2021 21:16:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233536AbhHCBQi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Aug 2021 21:16:38 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FA3CC061764
        for <git@vger.kernel.org>; Mon,  2 Aug 2021 18:16:27 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id i10-20020a05600c354ab029025a0f317abfso600057wmq.3
        for <git@vger.kernel.org>; Mon, 02 Aug 2021 18:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=gT+0Bav2pyf+PZ8Ana1Q2CtXdMvVf+FGuFgjR6fNJxg=;
        b=l4YemT+C1eZOvIw5eR4FsTOIT/8d1nKCoI3SiUHTHh9jviBEvIeh0eMA/Rgc1d7nbk
         +aVLz/FYKhklleKDZLCOaQY3iowJib9VQm5KuHKqOiXyeyvZ163FA9dI8+cRsgn6QjVT
         SDFJ4TfhJlTLxeql8+9+/45QUua0Lo4bbhBIWeR9EKQlR64sAYKFya9OrKrP5hX7SEd+
         TWAf+w1qc5yp8IE1DsYN/uzVT8eW+Lj4guGDZETnmQu3vAHWnFZaYcMd45xFxLj37TYm
         FmouVs/sYiE9ryqIWSSp1DihSvdROuOt+7MXAV1K4fNcVlbmjfEhsBM1ZLbgj7hwbj0r
         TJrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=gT+0Bav2pyf+PZ8Ana1Q2CtXdMvVf+FGuFgjR6fNJxg=;
        b=FCPJluRky41zEImrlN8/rJtxGEB7l2Vsauj0mLsrP5FKUQ3/kAnva5+a8MpKTwzMqA
         IX3eerKPuNHfsE8E9qYFqwKi7m1c4u1yRxCIEOLhrpF5KJln+v/J7Fv7E5T1MsIaw9Af
         Ddzb4dZJBS02XFtRVO0N1mBjzje+MIs4DAXMhYyikm0iAuw53kuThqbblqEhi7EOEPqD
         D65O16KJUd6JyFOG2h9iS4df0wzRluMIzTZeBLvJPVzX3gaj4KlC16CVWs1il62jqV87
         2rfRQbxjpbDmn8CnZV/U+pJftpx5zCESFpxY8Y0b+x9fbLHgAtKghSMLM3ICF6SG45h6
         K4Ew==
X-Gm-Message-State: AOAM530CGxYhjJB8E+b4x7nBU6tCblc/770v5XQWKpeTpGM6BMGiqD2W
        grkMBx6T9hN6LPz1z25PloAy5ynNMNM=
X-Google-Smtp-Source: ABdhPJwrVm4oUSREDOGFVRRatp8d6sQr8TuPU6zAc/p0J7L9pTRoBhb5pZjQ92V98a4Gk1Ylvl5k0w==
X-Received: by 2002:a05:600c:2306:: with SMTP id 6mr19306178wmo.115.1627953385993;
        Mon, 02 Aug 2021 18:16:25 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p8sm12913126wrn.79.2021.08.02.18.16.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Aug 2021 18:16:25 -0700 (PDT)
Message-Id: <5279bca7a794bd66681d420147e193d2b5415860.1627953383.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1010.v2.git.1627953383.gitgitgadget@gmail.com>
References: <pull.1010.git.1627714877.gitgitgadget@gmail.com>
        <pull.1010.v2.git.1627953383.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 03 Aug 2021 01:16:22 +0000
Subject: [PATCH v2 2/2] [GSOC] cherry-pick: use better advice message
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

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by Hariom Verma <hariom18599@gmail.com>:
Helped-by: Phillip Wood <phillip.wood@dunelm.org.uk>
Hepled-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: ZheNing Hu <adlternative@gmail.com>
---
 sequencer.c                     | 10 +++++++++-
 t/t3507-cherry-pick-conflict.sh | 17 ++++++++++++-----
 2 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 83cf6a5da3c..bf7dbea81dd 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -404,7 +404,15 @@ static void print_advice(struct replay_opts *opts, int show_hint)
 	if (msg) {
 		advise("%s\n", msg);
 	} else if (show_hint) {
-		if (opts->no_commit)
+		if (opts->action == REPLAY_PICK) {
+			advise(_("Resolve all conflicts manually, mark them as resolved with\n"
+				 "\"git add/rm <conflicted_files>\", then run\n"
+				 "\"git cherry-pick --continue\".\n"
+				 "You can instead skip this commit: run \"git cherry-pick --skip\".\n"
+				 "To abort and get back to the state before \"git cherry-pick\",\n"
+				 "run \"git cherry-pick --abort\"."));
+
+		} else if (opts->no_commit)
 			advise(_("after resolving the conflicts, mark the corrected paths\n"
 				 "with 'git add <paths>' or 'git rm <paths>'"));
 		else
diff --git a/t/t3507-cherry-pick-conflict.sh b/t/t3507-cherry-pick-conflict.sh
index af5678d981a..e953b54e54d 100755
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
 
-- 
gitgitgadget
