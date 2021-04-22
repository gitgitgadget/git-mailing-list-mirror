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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 998C0C433ED
	for <git@archiver.kernel.org>; Thu, 22 Apr 2021 10:01:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59C486145B
	for <git@archiver.kernel.org>; Thu, 22 Apr 2021 10:01:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235754AbhDVKBr (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Apr 2021 06:01:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235729AbhDVKBp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Apr 2021 06:01:45 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A8CEC06174A
        for <git@vger.kernel.org>; Thu, 22 Apr 2021 03:01:10 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id u15so14712786plf.10
        for <git@vger.kernel.org>; Thu, 22 Apr 2021 03:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GQHcTnOm+lMh6jNj1vqZGtq66tcB/Q1K3XMjEcn6/eo=;
        b=k0FBadVQpkeV8BIrZ8PK+/YctOd5RlklRtfTbLgEPKmH+EP5DZNwQL7wKxMDyfrpVD
         sJgpFuM8uuYFjUhF4LmkJWJjpJk0l8NaLKDjbVXu8QadCLe+8+1iIOiRNX6Fd5mE0mGt
         iADewqBQ5RnkQx63+AxOzA/Ue4CvGqUCSOMQoA8GURh9Qjx+qp5oWsJckw58oHSok1ni
         EF07DmhJFaGoK8g2CwfyoZ1KgWEj1ghNyteWLu1l3eCIulHA76CgfUqr1fjn32HXOKWn
         TQNhuDZECeRBslEaHIx2EF9ROo2RTdeD9UsRbpZCoRl0T7dPzkNLSoUjwuO4cs/9V/t9
         1nSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GQHcTnOm+lMh6jNj1vqZGtq66tcB/Q1K3XMjEcn6/eo=;
        b=qh8Vt6+C5dTrnqsdWwFk0kK7NuM5ekkD+tmqQ1pHcm8OAD8kp07ySrWudo85GTNKBv
         9AzxaJNklVCrJBaBWCV4k744cXFPpZtuZAGiO85kRGoIqxowxZmrXX+RQJwii/TeQDXL
         Tp45TmXJNPYHy+/KZyyEnZp+zfaDoRXSrlQiVohPejb4vyTzMgmDqsC8eoyZpIGdSHCr
         YT7OOlDSUc0+2vbSa0mN4tAPj9wjjI7olfwd9Z+PiVtoWPqKJdY9CVD+bLFCqvv+iv1Y
         x5WdVsVgO2GcYddECCgh0H1HSsFxe4Te/1d1ASLzOzj324ggsxbPZmRTy+oWiTAXnjpC
         m9Rg==
X-Gm-Message-State: AOAM532utHkIm+B+FmWZtFVoDsjJn4Ww8oT1965TbbhdJzN4eUqNyvh7
        uUqJYH0WNXoz/UhBdFeD4UTNnd24uWM=
X-Google-Smtp-Source: ABdhPJz0T5MqrpQRnCJV48lqDGP9J8R3dIJur8noRs+104mNjIItTs0cuDYTH92qbXy+Zr15cp553w==
X-Received: by 2002:a17:90a:ce8d:: with SMTP id g13mr3076922pju.85.1619085669422;
        Thu, 22 Apr 2021 03:01:09 -0700 (PDT)
Received: from archbookpro.localdomain ([172.92.165.181])
        by smtp.gmail.com with ESMTPSA id r3sm1741314pfl.159.2021.04.22.03.01.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Apr 2021 03:01:08 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 4/4] git-completion.bash: consolidate cases in _git_stash()
Date:   Thu, 22 Apr 2021 03:00:52 -0700
Message-Id: <103d38e29394d7e4d1bf01817795aed5be568673.1619085387.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.31.1.499.g90b4fd31cd
In-Reply-To: <cover.1619085387.git.liu.denton@gmail.com>
References: <cover.1618910364.git.liu.denton@gmail.com> <cover.1619085387.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The $subcommand case statement in _git_stash() is quite repetitive.
Consolidate the cases together into one catch-all case to reduce the
repetition.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 contrib/completion/git-completion.bash | 21 ++-------------------
 1 file changed, 2 insertions(+), 19 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 30c9a97616..7bce9a0112 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -3032,21 +3032,6 @@ _git_stash ()
 	fi
 
 	case "$subcommand,$cur" in
-	push,--*)
-		__gitcomp_builtin stash_push
-		;;
-	save,--*)
-		__gitcomp_builtin stash_save
-		;;
-	pop,--*)
-		__gitcomp_builtin stash_pop
-		;;
-	apply,--*)
-		__gitcomp_builtin stash_apply
-		;;
-	drop,--*)
-		__gitcomp_builtin stash_drop
-		;;
 	list,--*)
 		# NEEDSWORK: can we somehow unify this with the options in _git_log() and _git_show()
 		__gitcomp_builtin stash_list "$__git_log_common_options $__git_diff_common_options"
@@ -3054,8 +3039,8 @@ _git_stash ()
 	show,--*)
 		__gitcomp_builtin stash_show "$__git_diff_common_options"
 		;;
-	branch,--*)
-		__gitcomp_builtin stash_branch
+	*,--*)
+		__gitcomp_builtin "stash_$subcommand"
 		;;
 	branch,*)
 		if [ $cword -eq $((__git_cmd_idx+2)) ]; then
@@ -3069,8 +3054,6 @@ _git_stash ()
 		__gitcomp_nl "$(__git stash list \
 				| sed -n -e 's/:.*//p')"
 		;;
-	*)
-		;;
 	esac
 }
 
-- 
2.31.1.499.g90b4fd31cd

