Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61B53C388F7
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 21:22:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1984220781
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 21:22:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nsSA7z4y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731862AbgKJVWA (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Nov 2020 16:22:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731818AbgKJVV4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Nov 2020 16:21:56 -0500
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 721DDC0613D1
        for <git@vger.kernel.org>; Tue, 10 Nov 2020 13:21:56 -0800 (PST)
Received: by mail-ot1-x336.google.com with SMTP id z16so118000otq.6
        for <git@vger.kernel.org>; Tue, 10 Nov 2020 13:21:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=t0td7i0rPVUi9PRW9OzwO6saxJyhmAoaYR/VCmaNn9c=;
        b=nsSA7z4yu9ODvJLVJJqK16CEN86LZGoTBs9pYlAYyDnQZvtYIMzT6iotxK9SDXOWLa
         ZGmtX6piCPwk5ALCd6HpvYt7/FoMH71LQ0u5yx2MHPBqh1SduFsNC1JA43m0DJn+3f3H
         zSGpf6XTeOFznVUR+Bms22s1B7Q7tkNP0vBrIktiH+6TQaGORn766E8Ul5xNPYWMnJ6o
         SIscrLk5jzlngm8ct2qCHdRFHNA+ud89tzrnMVHIl030IiDIreuoLrfbedoAvFkvKgKD
         ZWhdC698DYvN2wioQK9O4U8rdx8c45HEzYXBtTboYJI04rSArXWQNLwR9s1DTwPv0TmZ
         zsqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=t0td7i0rPVUi9PRW9OzwO6saxJyhmAoaYR/VCmaNn9c=;
        b=sOrHCaDUAQJqYAdw3V3hor/0yOuD9/M/R5UcDgf0O6evS4OQopQmiPmyxIuf6P20hr
         KSb/efJnxyzXjNAcIpUxv/cE84Y/6chiz28w3AfeNrP0J0kYefVpuksOpubZCgDDJfFA
         +zvNc7NJzX5JWIj0BBmyub7N6/NXNpKKhLelAJC2HdNvDTuXNEDm1xUmKFMxyPLr/vmy
         +UBGl+3yJK578pvqcNaqfAQ6x8PJF2md8pUJ+9tzk3T0yeYjppl0paJnzh3e+R5Twwdk
         ecgx6qi4hU46P7Og5bnc8xcaX9g27ZG4i+ukUpuak/tRv/UWJMXJc3k5Oj4Olf4p+7a7
         rjUw==
X-Gm-Message-State: AOAM5337NohHilVoEbzu+md4bPXOFcTr5PnOlOZw+Fx2c3Bd+j8s49G+
        fseichKknYvVsc3CLDcSQv4Wu5Nb4VVvKA==
X-Google-Smtp-Source: ABdhPJw2Jd0LjoqCgSx0OSsfGmFK4sDwcy6lfZQAMho8Ht+qA/gMlqe3oGZ8TXtDNgA8BmlgLeRW9g==
X-Received: by 2002:a05:6830:1210:: with SMTP id r16mr14473794otp.57.1605043315578;
        Tue, 10 Nov 2020 13:21:55 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id j8sm1915468oif.55.2020.11.10.13.21.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2020 13:21:55 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 08/26] completion: bash: get rid of _append() functions
Date:   Tue, 10 Nov 2020 15:21:18 -0600
Message-Id: <20201110212136.870769-9-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201110212136.870769-1-felipe.contreras@gmail.com>
References: <20201110212136.870769-1-felipe.contreras@gmail.com>
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
index 6a1106f17d..7ecec00624 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -287,8 +287,7 @@ _get_comp_words_by_ref ()
 }
 fi
 
-# Fills the COMPREPLY array with prefiltered words without any additional
-# processing.
+# Appends prefiltered words to COMPREPLY without any additional processing.
 # Callers must take care of providing only words that match the current word
 # to be completed and adding any prefix and/or suffix (trailing space!), if
 # necessary.
@@ -301,19 +300,6 @@ __gitcomp_direct ()
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
@@ -431,16 +417,8 @@ __gitcomp_builtin ()
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
@@ -450,7 +428,8 @@ __gitcomp_nl_append ()
 #    appended.
 __gitcomp_nl ()
 {
-	__gitcomp_nl_append "$@"
+	local IFS=$'\n'
+	__gitcompappend "$1" "${2-}" "${3-$cur}" "${4- }"
 }
 
 # Fills the COMPREPLY array with prefiltered paths without any additional
@@ -837,7 +816,7 @@ __git_complete_refs ()
 
 	# Append DWIM remote branch names if requested
 	if [ "$dwim" = "yes" ]; then
-		__gitcomp_direct_append "$(__git_dwim_remote_heads "$pfx" "$cur_" "$sfx")"
+		__gitcomp_direct "$(__git_dwim_remote_heads "$pfx" "$cur_" "$sfx")"
 	fi
 }
 
@@ -2612,7 +2591,7 @@ __git_complete_config_variable_name ()
 		local pfx="${cur_%.*}."
 		cur_="${cur_#*.}"
 		__gitcomp_direct "$(__git_heads "$pfx" "$cur_" ".")"
-		__gitcomp_nl_append $'autoSetupMerge\nautoSetupRebase\n' "$pfx" "$cur_" "${sfx- }"
+		__gitcomp_nl $'autoSetupMerge\nautoSetupRebase\n' "$pfx" "$cur_" "${sfx- }"
 		return
 		;;
 	guitool.*.*)
@@ -2662,7 +2641,7 @@ __git_complete_config_variable_name ()
 		local pfx="${cur_%.*}."
 		cur_="${cur_#*.}"
 		__gitcomp_nl "$(__git_remotes)" "$pfx" "$cur_" "."
-		__gitcomp_nl_append "pushDefault" "$pfx" "$cur_" "${sfx- }"
+		__gitcomp_nl "pushDefault" "$pfx" "$cur_" "${sfx- }"
 		return
 		;;
 	url.*.*)
diff --git a/contrib/completion/git-completion.zsh b/contrib/completion/git-completion.zsh
index fa7f88bbb3..1781401f5d 100644
--- a/contrib/completion/git-completion.zsh
+++ b/contrib/completion/git-completion.zsh
@@ -120,16 +120,6 @@ __gitcomp_file ()
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
2.29.2

