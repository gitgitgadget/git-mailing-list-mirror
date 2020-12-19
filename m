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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D3F8C3526E
	for <git@archiver.kernel.org>; Sat, 19 Dec 2020 00:23:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E021B23BCA
	for <git@archiver.kernel.org>; Sat, 19 Dec 2020 00:23:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726351AbgLSAXC (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Dec 2020 19:23:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726004AbgLSAXC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Dec 2020 19:23:02 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1C33C0617B0
        for <git@vger.kernel.org>; Fri, 18 Dec 2020 16:22:21 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id v14so4101785wml.1
        for <git@vger.kernel.org>; Fri, 18 Dec 2020 16:22:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:mime-version:content-transfer-encoding
         :fcc:to:cc;
        bh=/7NfLBnvfbI0YQSKC/h9kgQi+p2GtPGFZ2m1ve1QIUc=;
        b=kDIJg8ao75mfH4pdi22/XPlfCm64TOSiBcPbVydpH/Fpa2EfD2Xoe6ymlcZ2QBN7Qe
         ViyywUZ0rAiW77tCJQp3mQmEpnkx/wt6PxExLbxRxIyeEc9iy7dYpjX5MI7XGoLtjRFk
         Zaq1E8FF+dKVCFalvPEX50dv8rkXy/W/4gm6/kfijtIzJ/fiWvYXiKEXi+n6EnFtUmDd
         9hH1nHsOQcTb5oZRXsI1Ja4LksSooA98dVwpKNMqCK5iGtffsX1TkgtRGNTc/g99SKgL
         vhfMjQI4QhLkLtaaGClwDrsTweHIMn0zn3lou5QO3Rfza/xyvBRytiRnCJLbUoo6nIcF
         2pww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=/7NfLBnvfbI0YQSKC/h9kgQi+p2GtPGFZ2m1ve1QIUc=;
        b=CWMywJyqP3FyrZb/6Hka2Dqchrd2poAB1mqhX9VHTM20Uv1dmSH5WitU5h6vL2EDVa
         KBHgUglpitNDo3pJex24zSbKt4xZTS6/Wb6cJxE0+C9f8dQzy+685JaUVNPbhLfKK/nA
         qhGD14kG0IUBE/0UWqayObn7D2+stmj3h46DFF2FYNY4Yvyf03Ww3W/a+mCXFrAjRDRa
         UZOp1Ox4f3GWQNbZmwxHL7YpwEyQvkqW6rCKYRFZGUVK0QVmjZUwrin5giHqSqMIKRZ1
         pSsS0CNef1rBX5jDLWZ4Xofe2zMQxoXO4PZRBf3HTqXHSRZ1Vnd3gK1kkWXEt704oXDF
         0PvA==
X-Gm-Message-State: AOAM531WjqASSE/L88f7TAoCemMBsgRqPtS2wFlRy3EdcTsdNPDWQrkb
        +cnvVOlcM5zTz9iu3x0zws3An6kp2jQ=
X-Google-Smtp-Source: ABdhPJzlAo/A94XYACX1uCNE3C6crxUeU/JndurdpWi+3Lm5dyUrVhs+6f/1tdTjpebGBjArwGT5FQ==
X-Received: by 2002:a1c:7f8c:: with SMTP id a134mr4309911wmd.184.1608337340293;
        Fri, 18 Dec 2020 16:22:20 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t13sm16227615wrs.26.2020.12.18.16.22.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Dec 2020 16:22:19 -0800 (PST)
Message-Id: <pull.818.git.1608337339246.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 19 Dec 2020 00:22:18 +0000
Subject: [PATCH] rebase -i: do leave commit message intact in fixup! chains
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?Vojt=C4=9Bch?= Knyttl <vojtech@knyt.tl>,
        SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

In 6e98de72c03 (sequencer (rebase -i): add support for the 'fixup' and
'squash' commands, 2017-01-02), this developer introduced a change of
behavior by mistake: when encountering a `fixup!` commit (or multiple
`fixup!` commits) without any `squash!` commit thrown in, the final `git
commit` was invoked with `--cleanup=strip`. Prior to that commit, the
commit command had been called without that `--cleanup` option.

Since we explicitly read the original commit message from a file in that
case, there is really no sense in forcing that clean-up.

Reported-by: Vojtěch Knyttl <vojtech@knyt.tl>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
    Fix bug in interactive rebases where fixup! cleans up the commit message

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-818%2Fdscho%2Fautosquash-without-scissors-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-818/dscho/autosquash-without-scissors-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/818

 sequencer.c                  | 5 ++---
 t/t3415-rebase-autosquash.sh | 8 ++++++++
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 8909a467700..749bddd7a1f 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2001,10 +2001,9 @@ static int do_pick_commit(struct repository *r,
 		flags |= AMEND_MSG;
 		if (!final_fixup)
 			msg_file = rebase_path_squash_msg();
-		else if (file_exists(rebase_path_fixup_msg())) {
-			flags |= CLEANUP_MSG;
+		else if (file_exists(rebase_path_fixup_msg()))
 			msg_file = rebase_path_fixup_msg();
-		} else {
+		else {
 			const char *dest = git_path_squash_msg(r);
 			unlink(dest);
 			if (copy_file(dest, rebase_path_squash_msg(), 0666))
diff --git a/t/t3415-rebase-autosquash.sh b/t/t3415-rebase-autosquash.sh
index 7bab6000dc7..4c83c98b3fc 100755
--- a/t/t3415-rebase-autosquash.sh
+++ b/t/t3415-rebase-autosquash.sh
@@ -440,4 +440,12 @@ test_expect_success 'fixup a fixup' '
 	test XZWY = $(git show | tr -cd W-Z)
 '
 
+test_expect_success 'fixup does not clean up commit message' '
+	oneline="#818" &&
+	git commit --allow-empty -m "$oneline" &&
+	git commit --fixup HEAD --allow-empty &&
+	git rebase -ki --autosquash HEAD~2 &&
+	test "$oneline" = "$(git show -s --format=%s)"
+'
+
 test_done

base-commit: ba2aa15129e59f248d8cdd30404bc78b5178f61d
-- 
gitgitgadget
