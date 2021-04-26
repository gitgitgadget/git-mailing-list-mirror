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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BBABC433B4
	for <git@archiver.kernel.org>; Mon, 26 Apr 2021 16:19:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F19DF6109E
	for <git@archiver.kernel.org>; Mon, 26 Apr 2021 16:19:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234397AbhDZQUF (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Apr 2021 12:20:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234227AbhDZQUF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Apr 2021 12:20:05 -0400
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com [IPv6:2607:f8b0:4864:20::c2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A23ECC061574
        for <git@vger.kernel.org>; Mon, 26 Apr 2021 09:19:23 -0700 (PDT)
Received: by mail-oo1-xc2b.google.com with SMTP id g9-20020a4ad3090000b02901ec6daba49aso5587308oos.6
        for <git@vger.kernel.org>; Mon, 26 Apr 2021 09:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RAXdm3HDE373LbfGMjVwSevhnkkSYJ9glzm4V2KycEU=;
        b=I53KHORbTIeaihyXbatrEIbJBf0r1eX3YQP3SFTbMnTxRGlHJKa3jcMIUKgcsk5Hin
         FT66TX+bB2P88+vwhwmCyO4FwOZSuwa/5bC/tFkS0X7aZr4UMJz6sIyWKEJGnOS/EqlA
         OQz7dUNL/9wxpPMT7+dOOHkAk7KP8ElnnJr+zBbDmwnUpvJ+IvhfcYzR4+cBdiwP0F/D
         QjmFwyf1xjTx0W3giGJRUlSBl7IDqN+HNnSsnKOLXFC5fTLuNIvBwWU23KZlT8M+X9RX
         LoyBo5NE1JfGp6Kp9HZQqa+W/wOXz+Lxx7Wnyer8BGwX2NPc6sRONbdyUD+/ZzxZjhhr
         MdRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RAXdm3HDE373LbfGMjVwSevhnkkSYJ9glzm4V2KycEU=;
        b=G+sDQ4IlTNuSjFyqKl8r17ulmSZB6reNkr6i3FsvM9E2PlvTWUpumM8yR8ST47zY8Q
         j8lmCJlPU2kQxkL1AjLXI2dmkKsOuZLp96xsJ3jq8+K9T1U3QBSAWCTQ1rmy7QAfaA0F
         xOwQIS4XLsJfX8YUYYx2YPIqNskQemWHT3foJ5bbb8Wk8fbr0aDoa+L8F61rriSRq8BS
         uM6PJr3uDZOwtMgIDTQp+eTEG4tGN4ekSBgaGwsJgUS5IipcI+DRvu1fj+eLZbFLy1la
         yiE/vStHwSErFb4PAlvn5rCXBSX3+IdJvZwXATIRBSSGioL/rCH6o51B9rAS22mERQUF
         DfUA==
X-Gm-Message-State: AOAM5300UcTViaL0zpwrUF3ovlTruw+ufkdMzHFb3xdPd22ojE61cl1I
        B3kDmPXBfl6rLH5aURZgtTMLpgsxOYz5ww==
X-Google-Smtp-Source: ABdhPJxyB5FKFRizVgTBdPHuhMosqzdrJIUt7RYrPycAsvawjXvcvTuUjI8Bj9tOcrOO6KhgRhkGWw==
X-Received: by 2002:a4a:9f45:: with SMTP id d5mr14043258ool.91.1619453962860;
        Mon, 26 Apr 2021 09:19:22 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id y6sm3696157otk.42.2021.04.26.09.19.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Apr 2021 09:19:22 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v1 30/43] completion: bash: cleanup __gitcomp* invocations
Date:   Mon, 26 Apr 2021 11:14:45 -0500
Message-Id: <20210426161458.49860-31-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210426161458.49860-1-felipe.contreras@gmail.com>
References: <20210426161458.49860-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Some __gitcomp calls should be __gitcomp_nl, and vice versa.

No functional changes.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.bash | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 00fd782e57..44cf70daa4 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1364,7 +1364,7 @@ _git_archive ()
 {
 	case "$cur" in
 	--format=*)
-		__gitcomp "$(git archive --list)" "" "${cur##--format=}"
+		__gitcomp_nl "$(git archive --list)" "" "${cur##--format=}"
 		return
 		;;
 	--remote=*)
@@ -1777,9 +1777,7 @@ _git_format_patch ()
 {
 	case "$cur" in
 	--thread=*)
-		__gitcomp "
-			deep shallow
-			" "" "${cur##--thread=}"
+		__gitcomp "deep shallow" "" "${cur##--thread=}"
 		return
 		;;
 	--base=*|--interdiff=*|--range-diff=*)
@@ -2285,7 +2283,7 @@ _git_send_email ()
 {
 	case "$prev" in
 	--to|--cc|--bcc|--from)
-		__gitcomp "$(__git send-email --dump-aliases)"
+		__gitcomp_nl "$(__git send-email --dump-aliases)"
 		return
 		;;
 	esac
@@ -2309,9 +2307,7 @@ _git_send_email ()
 		return
 		;;
 	--thread=*)
-		__gitcomp "
-			deep shallow
-			" "" "${cur##--thread=}"
+		__gitcomp "deep shallow" "" "${cur##--thread=}"
 		return
 		;;
 	--to=*|--cc=*|--bcc=*|--from=*)
@@ -2613,7 +2609,7 @@ __git_complete_config_variable_name ()
 		local pfx="${cur_%.*}."
 		cur_="${cur_#*.}"
 		__gitcomp_direct "$(__git_heads "$pfx" "$cur_" ".")"
-		__gitcomp_nl $'autoSetupMerge\nautoSetupRebase\n' "$pfx" "$cur_" "$sfx"
+		__gitcomp "autoSetupMerge autoSetupRebase" "$pfx" "$cur_" "$sfx"
 		return
 		;;
 	guitool.*.*)
@@ -2663,7 +2659,7 @@ __git_complete_config_variable_name ()
 		local pfx="${cur_%.*}."
 		cur_="${cur_#*.}"
 		__gitcomp_nl "$(__git_remotes)" "$pfx" "$cur_" "."
-		__gitcomp_nl "pushDefault" "$pfx" "$cur_" "$sfx"
+		__gitcomp "pushDefault" "$pfx" "$cur_" "$sfx"
 		return
 		;;
 	url.*.*)
@@ -2678,7 +2674,7 @@ __git_complete_config_variable_name ()
 		;;
 	*)
 		__git_compute_config_vars
-		__gitcomp "$(echo "$__git_config_vars" |
+		__gitcomp_nl "$(echo "$__git_config_vars" |
 				awk -F . '{
 					sections[$1] = 1
 				}
@@ -2780,7 +2776,7 @@ _git_remote ()
 		__gitcomp_builtin remote_update
 		;;
 	update,*)
-		__gitcomp "$(__git_remotes) $(__git_get_config_variables "remotes")"
+		__gitcomp_nl "$(__git_remotes) $(__git_get_config_variables "remotes")"
 		;;
 	set-url,--*)
 		__gitcomp_builtin remote_set-url
@@ -3422,7 +3418,7 @@ __git_main ()
 			then
 				__gitcomp "$GIT_TESTING_PORCELAIN_COMMAND_LIST"
 			else
-				__gitcomp "$(__git --list-cmds=list-mainporcelain,others,nohelpers,alias,list-complete,config)"
+				__gitcomp_nl "$(__git --list-cmds=list-mainporcelain,others,nohelpers,alias,list-complete,config)"
 			fi
 			;;
 		esac
-- 
2.31.0

