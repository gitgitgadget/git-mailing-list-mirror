Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB542C76196
	for <git@archiver.kernel.org>; Sat,  1 Apr 2023 08:47:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbjDAIry (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 1 Apr 2023 04:47:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbjDAIrR (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Apr 2023 04:47:17 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DF1121AA4
        for <git@vger.kernel.org>; Sat,  1 Apr 2023 01:46:52 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id q27so17676876oiw.0
        for <git@vger.kernel.org>; Sat, 01 Apr 2023 01:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680338811;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eLw3XIa4ivYcbOW7gAJJgm20Ajzxyvgv1ffaBeSDHyA=;
        b=geBJz5Qw80IPWljov8ch++eKb2VZ6XOcYRIsH85qTPeDuzoQIu+kVpckH+QFXAyaLt
         uM5df/OIpacOmqw4WvFuXmQKO6lLuCVOofIVsAUjCZrshRVMX5GiZRBZkW2+LEn4zhL8
         58IzBgr0jlkDH2nyxTonPgfzS0WtdHeha0jJxF+FjIZtBbtKwUd3nshF17MTGztrg3IP
         xWjrRCk805rHzo4S9B+EkSNNoikpbFBPO7zR/aFlVdeTLbSwqNdplfwnZL63O3XI66+S
         IRpe/0tWdMKQcHbwm01JNLvxikaxuWMbqJr95am0PAAswhXmo+19Cpb+6dfOKdfZojAI
         wXyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680338811;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eLw3XIa4ivYcbOW7gAJJgm20Ajzxyvgv1ffaBeSDHyA=;
        b=rNa+eL2u+vYTwpP5pa9nVJa/nqukVARSJBXvucq5J9oDleNzfHZU47r8XltS5mzqBt
         jJAk8oMTbjTBgFscY0S0OMBBr9KcelrdXz9ycuk67PBIAafUHUAED0Ovy8cCNH73FsCp
         0agqm6z16zMbIxkPiVkCPsJMJ9jEPFWwnb7SbkVAvsj4jC2sruDQYiq5IsQtmHGMAYj9
         vDUa6jH2RWwuJbqympjdIXTszSHVGHpDxuBsD+DCorQ3PFI+ieXlTVXuA5eFkjf66Uwj
         35tGPFZi+p9blHvLxTunelQUc4ciVTv8b4chsA/cLEif1YbUPlOYiGvFuIqTir86Doav
         0ywg==
X-Gm-Message-State: AAQBX9fkdnwOwM4Z1QiOE6RN4s7Irmk5vTXpd3KsnClkZBGBE3snVVZ5
        cY4xqyI4PaIZSP/7dVfaq851eOeM0VQ=
X-Google-Smtp-Source: AKy350aifZMKdJCi+Irl/oj2DJ+hsYOzGNOjwUFBaPC/Yz5CY6MG2bycguH+upuyT0RIV1al8pzALw==
X-Received: by 2002:a54:4411:0:b0:389:8232:e215 with SMTP id k17-20020a544411000000b003898232e215mr3289549oiw.8.1680338811499;
        Sat, 01 Apr 2023 01:46:51 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:fff1:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id bd1-20020a056808220100b0038755008179sm1831156oib.26.2023.04.01.01.46.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Apr 2023 01:46:51 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v7 17/49] completion: bash: get rid of _append() functions
Date:   Sat,  1 Apr 2023 02:45:54 -0600
Message-Id: <20230401084626.304356-18-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20230401084626.304356-1-felipe.contreras@gmail.com>
References: <20230401084626.304356-1-felipe.contreras@gmail.com>
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
index 7554c3aeb3..3c8f907d45 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -307,8 +307,7 @@ _get_comp_words_by_ref ()
 }
 fi
 
-# Fills the COMPREPLY array with prefiltered words without any additional
-# processing.
+# Appends prefiltered words to COMPREPLY without any additional processing.
 # Callers must take care of providing only words that match the current word
 # to be completed and adding any prefix and/or suffix (trailing space!), if
 # necessary.
@@ -321,19 +320,6 @@ __gitcomp_direct ()
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
@@ -451,16 +437,8 @@ __gitcomp_builtin ()
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
@@ -470,7 +448,8 @@ __gitcomp_nl_append ()
 #    appended.
 __gitcomp_nl ()
 {
-	__gitcomp_nl_append "$@"
+	local IFS=$'\n'
+	__gitcompappend "$1" "${2-}" "${3-$cur}" "${4- }"
 }
 
 # Fills the COMPREPLY array with prefiltered paths without any additional
@@ -871,7 +850,7 @@ __git_complete_refs ()
 
 	# Append DWIM remote branch names if requested
 	if [ "$dwim" = "yes" ]; then
-		__gitcomp_direct_append "$(__git_dwim_remote_heads "$pfx" "$cur_" "$sfx")"
+		__gitcomp_direct "$(__git_dwim_remote_heads "$pfx" "$cur_" "$sfx")"
 	fi
 }
 
@@ -2670,7 +2649,7 @@ __git_complete_config_variable_name ()
 		local pfx="${cur_%.*}."
 		cur_="${cur_#*.}"
 		__gitcomp_direct "$(__git_heads "$pfx" "$cur_" ".")"
-		__gitcomp_nl_append $'autoSetupMerge\nautoSetupRebase\n' "$pfx" "$cur_" "${sfx- }"
+		__gitcomp_nl $'autoSetupMerge\nautoSetupRebase\n' "$pfx" "$cur_" "${sfx- }"
 		return
 		;;
 	guitool.*.*)
@@ -2720,7 +2699,7 @@ __git_complete_config_variable_name ()
 		local pfx="${cur_%.*}."
 		cur_="${cur_#*.}"
 		__gitcomp_nl "$(__git_remotes)" "$pfx" "$cur_" "."
-		__gitcomp_nl_append "pushDefault" "$pfx" "$cur_" "${sfx- }"
+		__gitcomp_nl "pushDefault" "$pfx" "$cur_" "${sfx- }"
 		return
 		;;
 	url.*.*)
diff --git a/contrib/completion/git-completion.zsh b/contrib/completion/git-completion.zsh
index 186c49195b..b31c9894e4 100644
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
2.33.0

