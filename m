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
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC843C433B4
	for <git@archiver.kernel.org>; Mon, 26 Apr 2021 16:15:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A356F6115C
	for <git@archiver.kernel.org>; Mon, 26 Apr 2021 16:15:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234347AbhDZQQd (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Apr 2021 12:16:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234310AbhDZQQd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Apr 2021 12:16:33 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E0B1C061756
        for <git@vger.kernel.org>; Mon, 26 Apr 2021 09:15:50 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id x20so23196875oix.10
        for <git@vger.kernel.org>; Mon, 26 Apr 2021 09:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kEtt5x6Ev7zM72wyLZFvyyz7aXR6Q8l3yiChgxYkvTM=;
        b=BSxZuNGajIH2Zj8LcMMz4GDbqbDtjjCSueDjF1JrhUdV1dhcKp5MHnRoBTLgQ0861M
         gNEU55cOqJOOzT5Ibr8wbyqitEzgiUa7DXOzsPdTEh6i4RG85nG7jp4l31ZYcqqUd8Ob
         Cp7FQA5kmjXtpm51xkghWon1bkXCumxCGiKhok1+/NG3M5YhbWl9EwoMZHg+W5fdA5y7
         XJpGJUb6jjyd1xg2H3DvVifwIfnI/tPnOVjq3Pw7Dbn25dMW8Dc2iAjcr4K7heF2ij5m
         Tmh83o20P02s8JPTlButuw4iNy+SKL0RekKDI2dJauh7t4gLvxgc1HTqkkW76CKHhbYD
         bolQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kEtt5x6Ev7zM72wyLZFvyyz7aXR6Q8l3yiChgxYkvTM=;
        b=sKV1LaoC/F8DuYlnsJPCqnsA10Uj+NEb/n7fsGuyAGCEBmsTgdimMgtvCAcOdXK4VJ
         i/wqudGCFRlqUp9CaX9op2MSEFWwvQROJDN9viA31jhqvbPLuZMYuc5C8pg8kAb0Wivr
         YqGhHJN/VuezSVcpupssu7fkvYWUP66aQVR2lsF32KrAGdfOfG81+nq98/5P9rIhaf1K
         BIFuUy2JXYG44282HW9gAbgtiF4V0Psz9qV4mQYG6NQDaN000t1U96brhmutLBuopRnp
         y3YKaHDA762ndZ2V2DSeLWbicY7W3WSMvxW09pNDsPQPYOlB+qqqc/ONFO4my3X+pOoY
         f0gw==
X-Gm-Message-State: AOAM531aCbCJbl9l++f0YFsAlZII7YLIVaX9ohfnkilRPTgnl+sF2vXQ
        kHB9ovE3Xn+binboge6mumr0C3vq3ldhVg==
X-Google-Smtp-Source: ABdhPJylx5h46uJstRZnrldeXe4rVu5mS+7Xe71ACYMRYUBETHAcfwUr59rck6uObCU+Lh2/50t0Uw==
X-Received: by 2002:a05:6808:b10:: with SMTP id s16mr12916920oij.4.1619453749487;
        Mon, 26 Apr 2021 09:15:49 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id l17sm595391oig.20.2021.04.26.09.15.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Apr 2021 09:15:49 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v1 10/43] completion: bash: get rid of _append() functions
Date:   Mon, 26 Apr 2021 11:14:25 -0500
Message-Id: <20210426161458.49860-11-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210426161458.49860-1-felipe.contreras@gmail.com>
References: <20210426161458.49860-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There's no need to have duplicated functionality.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.bash | 35 ++++++--------------------
 contrib/completion/git-completion.zsh  | 10 --------
 2 files changed, 7 insertions(+), 38 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 162c8a89a2..d87d1ad12a 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -296,8 +296,7 @@ _get_comp_words_by_ref ()
 }
 fi
 
-# Fills the COMPREPLY array with prefiltered words without any additional
-# processing.
+# Appends prefiltered words to COMPREPLY without any additional processing.
 # Callers must take care of providing only words that match the current word
 # to be completed and adding any prefix and/or suffix (trailing space!), if
 # necessary.
@@ -310,19 +309,6 @@ __gitcomp_direct ()
 	COMPREPLY+=($1)
 }
 
-# Similar to __gitcomp_direct, but appends to COMPREPLY instead.
-# Callers must take care of providing only words that match the current word
-# to be completed and adding any prefix and/or suffix (trailing space!), if
-# necessary.
-# 1: List of newline-separated matching completion words, complete with
-#    prefix and suffix.
-__gitcomp_direct_append ()
-{
-	local IFS=$'\n'
-
-	COMPREPLY+=($1)
-}
-
 __gitcompappend ()
 {
 	local x i=${#COMPREPLY[@]}
@@ -440,16 +426,8 @@ __gitcomp_builtin ()
 	__gitcomp "$options"
 }
 
-# Variation of __gitcomp_nl () that appends to the existing list of
-# completion candidates, COMPREPLY.
-__gitcomp_nl_append ()
-{
-	local IFS=$'\n'
-	__gitcompappend "$1" "${2-}" "${3-$cur}" "${4- }"
-}
-
 # Generates completion reply from newline-separated possible completion words
-# by appending a space to all of them.
+# by appending a space to all of them. The result is appended to COMPREPLY.
 # It accepts 1 to 4 arguments:
 # 1: List of possible completion words, separated by a single newline.
 # 2: A prefix to be added to each possible completion word (optional).
@@ -459,7 +437,8 @@ __gitcomp_nl_append ()
 #    appended.
 __gitcomp_nl ()
 {
-	__gitcomp_nl_append "$@"
+	local IFS=$'\n'
+	__gitcompappend "$1" "${2-}" "${3-$cur}" "${4- }"
 }
 
 # Fills the COMPREPLY array with prefiltered paths without any additional
@@ -846,7 +825,7 @@ __git_complete_refs ()
 
 	# Append DWIM remote branch names if requested
 	if [ "$dwim" = "yes" ]; then
-		__gitcomp_direct_append "$(__git_dwim_remote_heads "$pfx" "$cur_" "$sfx")"
+		__gitcomp_direct "$(__git_dwim_remote_heads "$pfx" "$cur_" "$sfx")"
 	fi
 }
 
@@ -2641,7 +2620,7 @@ __git_complete_config_variable_name ()
 		local pfx="${cur_%.*}."
 		cur_="${cur_#*.}"
 		__gitcomp_direct "$(__git_heads "$pfx" "$cur_" ".")"
-		__gitcomp_nl_append $'autoSetupMerge\nautoSetupRebase\n' "$pfx" "$cur_" "${sfx- }"
+		__gitcomp_nl $'autoSetupMerge\nautoSetupRebase\n' "$pfx" "$cur_" "${sfx- }"
 		return
 		;;
 	guitool.*.*)
@@ -2691,7 +2670,7 @@ __git_complete_config_variable_name ()
 		local pfx="${cur_%.*}."
 		cur_="${cur_#*.}"
 		__gitcomp_nl "$(__git_remotes)" "$pfx" "$cur_" "."
-		__gitcomp_nl_append "pushDefault" "$pfx" "$cur_" "${sfx- }"
+		__gitcomp_nl "pushDefault" "$pfx" "$cur_" "${sfx- }"
 		return
 		;;
 	url.*.*)
diff --git a/contrib/completion/git-completion.zsh b/contrib/completion/git-completion.zsh
index e2ea14fb33..97d2bcadd6 100644
--- a/contrib/completion/git-completion.zsh
+++ b/contrib/completion/git-completion.zsh
@@ -121,16 +121,6 @@ __gitcomp_file ()
 	compadd -f -p "${2-}" -- ${(f)1} && _ret=0
 }
 
-__gitcomp_direct_append ()
-{
-	__gitcomp_direct "$@"
-}
-
-__gitcomp_nl_append ()
-{
-	__gitcomp_nl "$@"
-}
-
 __gitcomp_file_direct ()
 {
 	__gitcomp_file "$1" ""
-- 
2.31.0

