Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6A2CC4338F
	for <git@archiver.kernel.org>; Sat, 31 Jul 2021 07:01:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8516661040
	for <git@archiver.kernel.org>; Sat, 31 Jul 2021 07:01:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230168AbhGaHBb (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 31 Jul 2021 03:01:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229871AbhGaHBa (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 31 Jul 2021 03:01:30 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F00E2C0613CF
        for <git@vger.kernel.org>; Sat, 31 Jul 2021 00:01:23 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id l34-20020a05600c1d22b02902573c214807so5103019wms.2
        for <git@vger.kernel.org>; Sat, 31 Jul 2021 00:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=byRvV6KAfQVRt8pZr3FGhW7WXKq8Zz/pnfHvZywt40Y=;
        b=cmgkuxnfeAMhu5nsc63lyIdmVe7iU4ypKnIUJ3LsD2AbiAcgz/fUhrH3ydOPEhe80A
         o98hc4yUJCKTfFtLSPPruTuDeh+6Epx0RFsn3N8dGkuuXJ0RPv3UJtn1//AXqJduNfmJ
         P0QXmWbiiWrFxNc4Dze5EIfUgHSyVwkgCIkpR0sXHQ/sQMin+gb1nSYsoYubrUMxTcVr
         dIVyVsfXuCMU4/pDUj5b63bPlPYA1Ps/ZuZbsbqQKi9aK9+RHEKKC+1BOuW0bMeXYgyI
         5AP0bWZyEaJf1rfuPJq3GtEMMF6QhU02hemXWAL8Px6Z7GNiwipTtWKuTg0mYw15Bwpp
         HBqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=byRvV6KAfQVRt8pZr3FGhW7WXKq8Zz/pnfHvZywt40Y=;
        b=KPcYthoEdRAUwDrEV//DctlskxrAMN3WEKCWtHhUGu9BzLhSmvAFuZPTG9D01trclG
         GKnNGyvSEzyAwj6X4E55WKtw+utcUu3UWn4Qp8BNGacZMvqYcull6LhP1+72+lZvCznR
         KZ7hFsOU0MxI1iTiVqsd9/ieJDJIteq5MF6zrlH/gDl8Hsr18f5bmtCHZuLICT9cScez
         UQjh5nOpTu1bJ7V207hD/I3/goppX6blxzIKEefWRQjrKdn+m1sUYsEPe+EnqNodyQJp
         ATAESwe9Vtb53afd1AMrhZuSPUL8v8c4yHVUeKSRAaOUNUOoAp/KYXfke0dm9JA+vxrI
         k5uw==
X-Gm-Message-State: AOAM532dYjA60LUJM0RFDLnpNr50p2DdJhDB+iwRW6WuOo9bmyEJyhKV
        0be8cLkU+zGv/EZBnBGGp63Ptclphp8=
X-Google-Smtp-Source: ABdhPJxms6SFsD8x6rjkXufHWsf/CFEcMHP7HkFlwJwKrXsDQtYS0Ie0VIOFy3BcqeXb4opmLz3/Uw==
X-Received: by 2002:a7b:c5d8:: with SMTP id n24mr6741203wmk.51.1627714882605;
        Sat, 31 Jul 2021 00:01:22 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t1sm3872797wrm.42.2021.07.31.00.01.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Jul 2021 00:01:22 -0700 (PDT)
Message-Id: <7e1ed49728df8dab771d77f1a076f0fa30975718.1627714878.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1010.git.1627714877.gitgitgadget@gmail.com>
References: <pull.1010.git.1627714877.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 31 Jul 2021 07:01:17 +0000
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
 sequencer.c                     |  9 ++++++++-
 t/t3507-cherry-pick-conflict.sh | 15 ++++++++++-----
 2 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 83cf6a5da3c..f6e9d1fddd8 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -404,7 +404,14 @@ static void print_advice(struct replay_opts *opts, int show_hint)
 	if (msg) {
 		advise("%s\n", msg);
 	} else if (show_hint) {
-		if (opts->no_commit)
+		if (opts->action == REPLAY_PICK) {
+			advise(_("Resolve all conflicts manually, mark them as resolved with\n"
+				 "\"git add/rm <conflicted_files>\", then run \"git cherry-pick --continue\".\n"
+				 "You can instead skip this commit: run \"git cherry-pick --skip\".\n"
+				 "To abort and get back to the state before \"git cherry-pick\",\n"
+				 "run \"git cherry-pick --abort\"."));
+
+		} else if (opts->no_commit)
 			advise(_("after resolving the conflicts, mark the corrected paths\n"
 				 "with 'git add <paths>' or 'git rm <paths>'"));
 		else
diff --git a/t/t3507-cherry-pick-conflict.sh b/t/t3507-cherry-pick-conflict.sh
index f17621d1915..2cc3977f5a6 100755
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
 
-- 
gitgitgadget
