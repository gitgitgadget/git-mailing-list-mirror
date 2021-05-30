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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 151E3C47089
	for <git@archiver.kernel.org>; Sun, 30 May 2021 06:24:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CFC4C60C40
	for <git@archiver.kernel.org>; Sun, 30 May 2021 06:24:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229580AbhE3G0V (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 30 May 2021 02:26:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbhE3G0U (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 May 2021 02:26:20 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B31FCC061574
        for <git@vger.kernel.org>; Sat, 29 May 2021 23:24:41 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id y15so6526067pfn.13
        for <git@vger.kernel.org>; Sat, 29 May 2021 23:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=o47YYxOeoeLM3mpA6v10LFHHwMAngvkTvVAdr52dMiI=;
        b=LxrjgtMXYOwZaWrCZRJ+wAUR5DowQEb0HckF9WW3GUbNVIMOaIPSn34+qM3T65ERrf
         dwOjlsncG/hhbny4HybAR419kL0sVouvlZKIE9lMAh+oQDKHAGuhYQ7xmal7+APal8fZ
         Cfieo1necmecQ5e+BeWUYoV7CrB+C9rJ2CBAHS2tjwlwUIVS3y/1jtX7ciIooledDbW9
         bsDZwEcNT37u6DjDVAODRqmBFyLaQUTN84IdYMNyjI00hlvLIQ0uya4eEM6N6QOBp3IC
         B1CidEx5PRSoc7AXy6cXoaPxsBO2PRrXgwOa7Xs7NbDz1k4E8SzZ1SqRds+IKWOigv7a
         MfrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=o47YYxOeoeLM3mpA6v10LFHHwMAngvkTvVAdr52dMiI=;
        b=bbin90tDO+Pgz/0LV9eOEwcE1+0Z1eLmn1TPN7YWYfqibd5wqr5kqqHUu8KXBzfr4c
         PNbM8sW9cNXSs/uU0Swh+UWLx/TZ0NuyDe0tJ45EJ9+V2cO6SaQ3ZEJ53+2gr1mvH1KC
         G+0Igg/E/x5hiDFCwNs9jp6+ZMOtPO67ArnMS8PQlAb8T+JLv97+SXb9l733ha5BpVA6
         cfX08VZVPIy/pyt56Ounm7RFFxVW349qEo9uVj17/B1HBMJV9J5yYSC+o21N1yc3IGfE
         Xx0YIQHD4NhbW7bKuX8jCI8mmYWmutdcp5j0WmRLJz9+iRd0aa485bPyLY08wWwCaoAP
         ns8g==
X-Gm-Message-State: AOAM530IBJpqc5+BiSPskfmRIDVmSXxRLJbpMKDIxNUfrcA7U/C2r/B1
        V77CqcrzCv7eoB6NAYlAebfqjOQ8G61YS2zQ
X-Google-Smtp-Source: ABdhPJxyh60myMs62qHyLh+DFPZCHLiOfmErJf8ZysQ4V3l2QxRRW7j6SAezFzSgkAPG70vF4eUNGw==
X-Received: by 2002:a63:4c66:: with SMTP id m38mr16952043pgl.157.1622355881093;
        Sat, 29 May 2021 23:24:41 -0700 (PDT)
Received: from sarawiggum.attlocal.net (99-121-213-74.lightspeed.irvnca.sbcglobal.net. [99.121.213.74])
        by smtp.gmail.com with ESMTPSA id x13sm7823164pfn.43.2021.05.29.23.24.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 29 May 2021 23:24:40 -0700 (PDT)
From:   David Aguilar <davvid@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Felipe Contreras <felipe.contreras@gmail.com>,
        Denton Liu <liu.denton@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v2] contrib/completion: fix zsh completion regression from 59d85a2a05
Date:   Sat, 29 May 2021 23:24:38 -0700
Message-Id: <20210530062438.53527-1-davvid@gmail.com>
X-Mailer: git-send-email 2.32.0.rc2.1.gffeee53afa
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

Helped-by: Felipe Contreras <felipe.contreras@gmail.com>
Signed-off-by: David Aguilar <davvid@gmail.com>
---
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
2.32.0.rc2.1.gffeee53afa

