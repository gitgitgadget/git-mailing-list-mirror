Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD626C43462
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 09:20:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 97AA561363
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 09:20:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231410AbhDTJUj (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Apr 2021 05:20:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230090AbhDTJUf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Apr 2021 05:20:35 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43864C06138C
        for <git@vger.kernel.org>; Tue, 20 Apr 2021 02:20:04 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id 20so15393594pll.7
        for <git@vger.kernel.org>; Tue, 20 Apr 2021 02:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bMr5RwWvz1Wjmmk/xiGkhzAWg4eR4Q1W8mE6K97pmjg=;
        b=N3t4j7PC9U44dhvlYHfWsJgbpTou9i4JprRZiOEPxDv3c8vVjiQNO7A9cvfNRqFZSg
         R5zksPGDV2HoP+eMqTePdDq+4w2g8K7YTZNQkg0V1ROsDtjEi/WbZaRNB/iimlXtqhKq
         olZkBjqd7gaujiTXvNmwHiN/FBU8uA+GpOJMKesWzeOKwCrREkXc2ogIR1twcM6+Netq
         lFvg/fTHBVjgSirmo/bYfkcHORlRIOkCY3gJfAPehDbYlMrTzGsOhieCp+f+G29Kw1AE
         8mYAvRvZWkZwg2nLKalxDjbRucctHo/SqqCV+sBYdI+rFf4xJ1PbeB6T9H49IrDYeDcq
         k/OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bMr5RwWvz1Wjmmk/xiGkhzAWg4eR4Q1W8mE6K97pmjg=;
        b=Fpb2Duxbcs1T2mqppLB7RzH8xOlaJmiSSS7j0ebgPLpCosLMUQPf2vKBUzYo+bUHmY
         fuNSWCKnj1h0zMwjbUJVzxkP7NzcL7eCMNBwvXPiorSPGjg4T2mNHFlF8olZLLmrEp7q
         +uBhbtwESRO7TX7QSpk75HlRCONOjZSfQmxuUWCmYfXUWKQuB34mq/BPSVyXOkiom5wb
         FRD/VLgUnzWCEDNMjYjARkeDoy0aPtwfjd3w8dqUcMuYs4LbNDXooquafQ/ELoOy9OV9
         xQSLnU8M1T1tgdXfrDBD/1oFFMWaaMU1DLkE97SsCYPdzuuwXrlvLTyr3bMkgUdFUyc1
         UzcA==
X-Gm-Message-State: AOAM532OVxoh8jv+w3Uw/I3rvHAFlfzPcaTfIzIaIuKqHCiBM70kOb2u
        fMA5aw8mKD9s6ZPFsLyxJNCnoq7nNVs=
X-Google-Smtp-Source: ABdhPJxExJ6glxHJM/gKXWIRJ0OxQ5H4IKmk+B7V2jSBIYRCJnDjj/YV2lS2y7RmR+biQxNf7acH2Q==
X-Received: by 2002:a17:902:ac89:b029:e6:d199:29ac with SMTP id h9-20020a170902ac89b02900e6d19929acmr27864120plr.46.1618910403626;
        Tue, 20 Apr 2021 02:20:03 -0700 (PDT)
Received: from archbookpro.localdomain ([172.92.165.181])
        by smtp.gmail.com with ESMTPSA id k15sm15247630pfi.0.2021.04.20.02.20.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Apr 2021 02:20:03 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 4/5] git-completion.bash: consolidate cases in _git_stash()
Date:   Tue, 20 Apr 2021 02:19:50 -0700
Message-Id: <4f8d015d54376af277883f57e8b4cf2c63ed8a03.1618910364.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.31.1.424.g95a8dafae5
In-Reply-To: <cover.1618910364.git.liu.denton@gmail.com>
References: <cover.1618910364.git.liu.denton@gmail.com>
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
2.31.1.424.g95a8dafae5

