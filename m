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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DCF4C47080
	for <git@archiver.kernel.org>; Tue,  1 Jun 2021 16:53:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 04562610C9
	for <git@archiver.kernel.org>; Tue,  1 Jun 2021 16:52:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233301AbhFAQyk (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Jun 2021 12:54:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230288AbhFAQyk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Jun 2021 12:54:40 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F6BDC061574
        for <git@vger.kernel.org>; Tue,  1 Jun 2021 09:52:57 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id g24so13407pji.4
        for <git@vger.kernel.org>; Tue, 01 Jun 2021 09:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TbCk8dFPmyamv0fX5nIqiGgtjx5VrI1Qo3o7m5ZPqE0=;
        b=REAWwFFKQ3oDl7knUaJV7PoV6sikVpLRB8NqyaculO6ejo30rfDNEqzt5E+0cSFSFC
         x0Tfk1zEIjXU1YrlQSP/JGkULgRKlZz4slGOZ33PH6O7P256YZy4LFGJ/TcSwS5uXBtg
         LeB+Lm9S0c+OYWR9OmhKwAAXRdG59l5e4+Q3fhz/GDJFgo+ZkQTW1E0EKSUDE5w0bl1a
         lv2t/uBDG/02Y5bUQmwpZqu5YkTFIKgPLXNWT/dG6LMg5yMK/OKPAhiIze6gRkf+wLeL
         JZUgCcrSjCIIigfHYsRWIeJp/3wPP95HSDoJv2WwAJAfZbGQhJ8o3IDz0oJuc5gjho56
         ay4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TbCk8dFPmyamv0fX5nIqiGgtjx5VrI1Qo3o7m5ZPqE0=;
        b=lq/Z8qfe0pQJIsdf06XGLi9qJh9YhdN8xAYf6W7JC9av9Vq3wyDuyyPJhScnk5LA76
         R02SAevaUtuY0k6nmKbVQFTWuYTpMjD1IHKVz7fPRNGn9dPWw0TwpvYGAWdTCKbSyUgY
         zJAfdtMZ/c5zASriNd17lNEDnNoJGmANo709kUTAOUoH7SGDz30Qy2yWSPXx5gHWc8jJ
         DRcCa/30/E04l4BwzDpFJkKvo9gc0q2S4rxSAKUoM8EyVL4TirwrIrCStyZbH5S+xJYX
         6tQCneNw/+8pzKWSikSxnE1EViZh5qNU1ixyd0EpZODkTIADgIZSp2klVlyPyV93yyu3
         +mVA==
X-Gm-Message-State: AOAM530hr0vZs8zoCle/ecUtZJJDQXz3XgfRZi58CCKLcWZz5K3xr+TZ
        olqWaqogPBlvWtXCp1NhGo0=
X-Google-Smtp-Source: ABdhPJyJlx1c8V+aFi5Dgpyh1YXDUmG+CGxuh0X9Qtpj/Vh+IqoXTso31pVtv74HNd752lO7h4wDvg==
X-Received: by 2002:a17:90a:db51:: with SMTP id u17mr26165192pjx.222.1622566377075;
        Tue, 01 Jun 2021 09:52:57 -0700 (PDT)
Received: from sarawiggum.fas.fa.disney.com ([198.187.190.10])
        by smtp.gmail.com with ESMTPSA id t13sm6942187pfh.97.2021.06.01.09.52.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 Jun 2021 09:52:56 -0700 (PDT)
From:   David Aguilar <davvid@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Felipe Contreras <felipe.contreras@gmail.com>,
        Denton Liu <liu.denton@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v3] contrib/completion: fix zsh completion regression from 59d85a2a05
Date:   Tue,  1 Jun 2021 09:52:54 -0700
Message-Id: <20210601165254.18136-1-davvid@gmail.com>
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

Add "git" to the "words" array in _git_zsh_main to guarantee
that "git" is at least always in the completion list. It may not
be completely correct because __git_cmd_idx is not always 1,
but it is enough to fix the regression.

This was tested on zsh 5.7.1 (x86_64-apple-darwin19.0).

Helped-by: Felipe Contreras <felipe.contreras@gmail.com>
Signed-off-by: David Aguilar <davvid@gmail.com>
---
 contrib/completion/git-completion.bash | 2 +-
 contrib/completion/git-completion.zsh  | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

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
index 6c56296997..6405d7ba30 100644
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
@@ -261,7 +261,7 @@ __git_zsh_main ()
 
 		(( $+opt_args[--help] )) && command='help'
 
-		words=( ${orig_words[@]} )
+		words=( git ${orig_words[@]} )
 
 		__git_zsh_bash_func $command
 		;;
-- 
2.32.0.rc2.1.gf67de2b3ac

