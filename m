Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE73BC47080
	for <git@archiver.kernel.org>; Tue,  1 Jun 2021 20:52:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF908613AB
	for <git@archiver.kernel.org>; Tue,  1 Jun 2021 20:52:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234747AbhFAUyP (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Jun 2021 16:54:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234638AbhFAUyO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Jun 2021 16:54:14 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17398C061574
        for <git@vger.kernel.org>; Tue,  1 Jun 2021 13:52:32 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id g6so478961pfq.1
        for <git@vger.kernel.org>; Tue, 01 Jun 2021 13:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=95fhtR4Neo6TWu247i82FgCev5FROzMYEC2cji/qd18=;
        b=aUbxVgzYWA5GHbXVOm6UD4/Fas+bkb34c5LE1Czxn1oh3nce8Iu1Gy1ZHPRwlS0hrQ
         SuVuazQSG1CNiO88BUAU0hkSDLHPlOvgwNzKdQa43gl/8FkYFoZzTx9YpeTk7wkVIHpS
         ZpvsRhTVtnWrhVFS1Gk3/geBxYCme/0x3KDi9y1T/GKEcyvcH1wl3dUxXeIF0Vqe7B+b
         Webkku8Czjj/PaOK/PPdwhOXLHuzwlrsBW1PFh/92EfndZ+hyGIuin3tIXcDmplHTmnT
         fODxoqL+xDqW7B0aq69f4d6e+h94kqs8hgx/uI8LAHZ63b47Xlhem69gss+IuOBlitkD
         fZPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=95fhtR4Neo6TWu247i82FgCev5FROzMYEC2cji/qd18=;
        b=rBJJY/lYnOhd8PJ0EOrHSNAxnmfNhZuVTQzgBE3nH1rTdIC2Z0zBDaPHlden3nCAYT
         4DL4bDbqx3cmSF6zPKvHuekJChGo3/7HnMS69C9NLYrnJMALCmhJHBCiG/xfnDw0oeFX
         wz1GwCOv/9iwXrFlCbeupCxfm59l8WDgYYBsd12kaN6YpAoiL95xXDal8Zm9Vd22o1GW
         ooHmYkC78T4+NSFxz6A1N+CC4+jg1mHjS9wh0FY2+efXuC/QUa/ptOgzr1wt+Xs0K2Cf
         rWC8uLs4hgBVpNUyHVVgVQm5Ej8kIrY+2jzLaNCTST/DtKEvZ8WJD04A4cf5gAtBwxq5
         +bWA==
X-Gm-Message-State: AOAM530X7tQCXkc3iKAuqUTGIU9507E0/KqH63TOXelqMCb/zCnMF5ww
        MOY7fn5hjPIsT4bK5j7n/Ik=
X-Google-Smtp-Source: ABdhPJzb32ZAz517PD/P/y6C8BvSdIm8FGXj06Ml+prWArW5ig8F0FeeS7nPAMS+zR4+OvuryaD14w==
X-Received: by 2002:a63:5641:: with SMTP id g1mr29999328pgm.351.1622580751515;
        Tue, 01 Jun 2021 13:52:31 -0700 (PDT)
Received: from sarawiggum.fas.fa.disney.com ([198.187.190.10])
        by smtp.gmail.com with ESMTPSA id mp21sm2955287pjb.50.2021.06.01.13.52.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 Jun 2021 13:52:31 -0700 (PDT)
From:   David Aguilar <davvid@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Felipe Contreras <felipe.contreras@gmail.com>,
        Denton Liu <liu.denton@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v4] contrib/completion: fix zsh completion regression from 59d85a2a05
Date:   Tue,  1 Jun 2021 13:52:29 -0700
Message-Id: <20210601205229.46974-1-davvid@gmail.com>
X-Mailer: git-send-email 2.32.0.rc2.1.gf67de2b3ac
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A recent change to make git-completion.bash use $__git_cmd_idx
in more places broke a number of completions on zsh because it
modified __git_main but did not update __git_zsh_main.

Notably, completions for "add", "branch", "mv" and "push" were
broken as a result of this change.

In addition to the undefined variable usage, "git mv <tab>" also
prints the following error:

	__git_count_arguments:7: bad math expression:
	operand expected at `"1"'

	_git_mv:[:7: unknown condition: -gt

Remove the quotes around $__git_cmd_idx in __git_count_arguments
and set __git_cmd_idx=1 early in __git_zsh_main to fix the
regressions from 59d85a2a05.

This was tested on zsh 5.7.1 (x86_64-apple-darwin19.0).

Suggested-by: Felipe Contreras <felipe.contreras@gmail.com>
Signed-off-by: David Aguilar <davvid@gmail.com>
---
Changes since v3:

- Dropped the addition of "git" in the words array.
- This is effectively the as the v2 patch after Felipe's suggestsions.
- The difference between this patch and v2 is the Suggested-by trailer.

 contrib/completion/git-completion.bash | 2 +-
 contrib/completion/git-completion.zsh  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 3c5739b905..b50c5d0ea3 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1306,7 +1306,7 @@ __git_count_arguments ()
 	local word i c=0
 
 	# Skip "git" (first argument)
-	for ((i="$__git_cmd_idx"; i < ${#words[@]}; i++)); do
+	for ((i=$__git_cmd_idx; i < ${#words[@]}; i++)); do
 		word="${words[i]}"
 
 		case "$word" in
diff --git a/contrib/completion/git-completion.zsh b/contrib/completion/git-completion.zsh
index 6c56296997..cac6f61881 100644
--- a/contrib/completion/git-completion.zsh
+++ b/contrib/completion/git-completion.zsh
@@ -251,7 +251,7 @@ __git_zsh_main ()
 		done
 		;;
 	(arg)
-		local command="${words[1]}" __git_dir
+		local command="${words[1]}" __git_dir __git_cmd_idx=1
 
 		if (( $+opt_args[--bare] )); then
 			__git_dir='.'
-- 
2.32.0.rc2.1.gf67de2b3ac

