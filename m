Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 892E1ECAAA1
	for <git@archiver.kernel.org>; Tue, 30 Aug 2022 09:32:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231927AbiH3Jcq (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Aug 2022 05:32:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231888AbiH3Jc1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Aug 2022 05:32:27 -0400
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF542A8322
        for <git@vger.kernel.org>; Tue, 30 Aug 2022 02:32:12 -0700 (PDT)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-11c4d7d4683so15349775fac.8
        for <git@vger.kernel.org>; Tue, 30 Aug 2022 02:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=SLJEDnLQfpSiBmexI1aeGP+0l58FPjkw4kNppwp6ZWg=;
        b=BMsd0lJ1ZO9UJehVuvvvus1pdTPjmKaFZTP8irj0mK38MCkMH+1egMjr/2hassWwSs
         HhwL60O/Jv9YxHUmYd6LxFJTN8x/BUO2VtYRHS6ymqtrETwTdBcDugWKH1ih5+UBJkxv
         NLJ0Hgt3I1031VMCYGAvoGLenGh5+LcF5GvyYKd73rVxzIRCX1UoqkUOZ6VNU/d2lNyH
         Se1W4gNVgucYZn3PmtgVmONIhGL73sNU8e5gvXaq2tpjTRq8DZA9v3bDr2F8aTUE/Csw
         pII3IvdJ2BNzLHeN0nXdtx34IjjdrI6HxXaMtWI+jCvTy0sYXYOW/V8PNwNCo9ZOXW67
         oGbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=SLJEDnLQfpSiBmexI1aeGP+0l58FPjkw4kNppwp6ZWg=;
        b=UTe0yzjGfo9+PYflsKv0vzslsFSjXiO3G5vk9OlGbO7L2U4BvE2hEm3dtOlN6UHv3H
         2GRQtE09aWzV+xLwrUUUTMEwiiXWiYvqh3nOb4FHiylxSlNVyzO/Pj35c7i7hUMz3t3h
         tdMF1mrMiSP3gs/ehRBQUFVPbJbIPFpEhmixxx5vYcfZsSvYauQlvT2/MXG2m9NAHR9a
         VutxQKqVnes6zqthAatMjBd0Dkd35ROMAycvlQ1uulpiwkxIxykWEMK9M0S2jrRmbWt5
         HEbQP6ttnzXxOD19NTETsF8X6wXfSuDRj9A9q3HYvoWDXOiB0meGFxUNw2xDiC7EB38Q
         MOAg==
X-Gm-Message-State: ACgBeo1REPN95JSmFxZcOoeTefqJE5sxpAAkwIOW4cGuDcByU/6xNgJ6
        X+qPhoPNuKt8uiHnC3ozWuPsnAU4NpU=
X-Google-Smtp-Source: AA6agR7r0cAMIhOPrXzF4wpTmfZ6XLKbl+72RVSqElAvyaRYoVz9EsvptnCbSCVCA6mabsL8KHppFg==
X-Received: by 2002:a05:6870:e997:b0:10c:6f42:b05e with SMTP id r23-20020a056870e99700b0010c6f42b05emr9295755oao.89.1661851928428;
        Tue, 30 Aug 2022 02:32:08 -0700 (PDT)
Received: from localhost ([2806:2f0:4000:eec:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id bi5-20020a056808188500b00344afa2b08bsm6002641oib.26.2022.08.30.02.32.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 02:32:07 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     git-fc@googlegroups.com,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 17/51] completion: bash: get rid of _append() functions
Date:   Tue, 30 Aug 2022 04:31:04 -0500
Message-Id: <20220830093138.1581538-18-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.37.2.351.g9bf691b78c.dirty
In-Reply-To: <20220830093138.1581538-1-felipe.contreras@gmail.com>
References: <20220830093138.1581538-1-felipe.contreras@gmail.com>
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
index 6571dc1b2d..4a7e75b48d 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -301,8 +301,7 @@ _get_comp_words_by_ref ()
 }
 fi
 
-# Fills the COMPREPLY array with prefiltered words without any additional
-# processing.
+# Appends prefiltered words to COMPREPLY without any additional processing.
 # Callers must take care of providing only words that match the current word
 # to be completed and adding any prefix and/or suffix (trailing space!), if
 # necessary.
@@ -315,19 +314,6 @@ __gitcomp_direct ()
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
@@ -445,16 +431,8 @@ __gitcomp_builtin ()
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
@@ -464,7 +442,8 @@ __gitcomp_nl_append ()
 #    appended.
 __gitcomp_nl ()
 {
-	__gitcomp_nl_append "$@"
+	local IFS=$'\n'
+	__gitcompappend "$1" "${2-}" "${3-$cur}" "${4- }"
 }
 
 # Fills the COMPREPLY array with prefiltered paths without any additional
@@ -851,7 +830,7 @@ __git_complete_refs ()
 
 	# Append DWIM remote branch names if requested
 	if [ "$dwim" = "yes" ]; then
-		__gitcomp_direct_append "$(__git_dwim_remote_heads "$pfx" "$cur_" "$sfx")"
+		__gitcomp_direct "$(__git_dwim_remote_heads "$pfx" "$cur_" "$sfx")"
 	fi
 }
 
@@ -2650,7 +2629,7 @@ __git_complete_config_variable_name ()
 		local pfx="${cur_%.*}."
 		cur_="${cur_#*.}"
 		__gitcomp_direct "$(__git_heads "$pfx" "$cur_" ".")"
-		__gitcomp_nl_append $'autoSetupMerge\nautoSetupRebase\n' "$pfx" "$cur_" "${sfx- }"
+		__gitcomp_nl $'autoSetupMerge\nautoSetupRebase\n' "$pfx" "$cur_" "${sfx- }"
 		return
 		;;
 	guitool.*.*)
@@ -2700,7 +2679,7 @@ __git_complete_config_variable_name ()
 		local pfx="${cur_%.*}."
 		cur_="${cur_#*.}"
 		__gitcomp_nl "$(__git_remotes)" "$pfx" "$cur_" "."
-		__gitcomp_nl_append "pushDefault" "$pfx" "$cur_" "${sfx- }"
+		__gitcomp_nl "pushDefault" "$pfx" "$cur_" "${sfx- }"
 		return
 		;;
 	url.*.*)
diff --git a/contrib/completion/git-completion.zsh b/contrib/completion/git-completion.zsh
index 2de1a72c09..35300a08cd 100644
--- a/contrib/completion/git-completion.zsh
+++ b/contrib/completion/git-completion.zsh
@@ -122,16 +122,6 @@ __gitcomp_file ()
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
2.37.2.351.g9bf691b78c.dirty

