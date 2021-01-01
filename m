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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 550D3C432C3
	for <git@archiver.kernel.org>; Fri,  1 Jan 2021 02:17:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2470B20798
	for <git@archiver.kernel.org>; Fri,  1 Jan 2021 02:17:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727230AbhAACRX (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 31 Dec 2020 21:17:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727211AbhAACRW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Dec 2020 21:17:22 -0500
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7CD0C0617A1
        for <git@vger.kernel.org>; Thu, 31 Dec 2020 18:16:41 -0800 (PST)
Received: by mail-oi1-x22b.google.com with SMTP id q205so23403565oig.13
        for <git@vger.kernel.org>; Thu, 31 Dec 2020 18:16:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qPNrJAR2eFKyE7AvGCmqyqOJIkQqD80b+BpKqpvYXbk=;
        b=Pekq/E3PoCHg1Ik0VfRGiqhK2amtgMW4c2jt5eN4fJY1b01I6et2gQgwLyblxbONxE
         TaDs2f2gD5+rchk+TNqHfkRClhbt/chZ8HGbcvClbg3sCqKtr1Ysa3c6oghPtt2R6xQQ
         R4sFDM10WMTdPRSqB3ZoduU0SzGtFObI0+hXWOY5rD9+kU0QCMnkfe3vJoh+YxbIojnq
         I5cbZiMhlis+ML8PyX7xndEYZXWnGHZg1sNtzJ3fJ+Mm4y7HQPuIBhd7Bvpa/n4XLtiz
         NajAeErKmmdc5L+dzHHGPu+L7u5yONl91eCuxW1KdCbdJX89iJIyrowX0vH8vPvPVGD6
         m5kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qPNrJAR2eFKyE7AvGCmqyqOJIkQqD80b+BpKqpvYXbk=;
        b=H8xdYT2eJ6AiraKY9ROkZ/f7O5XgIsmaKwQ2xlABkDylU2mPGd5NrKDjNRPg/1PBFe
         Ud8fv6LQWzrOu6myzSNtxHor9AGGwCWPnA6ORXAsJ9dBcaRPRnBKEhnIxScgWFiLfXHD
         NTwYBllAK098ZFX9qoVCNtzu2NbPghIJ9RnIcu2v1i8QxELVjNgd61rrQDObttgn/ThO
         QS2WA/9zw/1wiKlm5hysZunlditq5JVj/hEfgTREL1j2awNrqeMiqGFtNDmpCOK/pvcS
         M71uRQfqF3e8kxx4wuOXDm0/LX3x7qBvdtwdmLcYjOKgGUWLDsXgn5f/+t70EaXngFZU
         I16Q==
X-Gm-Message-State: AOAM530SFkgoM+tFRcLBHbM5lFx2wncLilEyrgisIWgEbHuaDjyFio0/
        I5BRqtCLoMTUoGOPAgDwYsIXZl/4F9J8DQ==
X-Google-Smtp-Source: ABdhPJyVHOOwDGlBDMqzPpQGu4O+OZem5jC4czEOZykW98Df/7k6mYsGjk7tFHQB/jyKwp9gPnZEmA==
X-Received: by 2002:a54:4489:: with SMTP id v9mr9999322oiv.154.1609467401048;
        Thu, 31 Dec 2020 18:16:41 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id e10sm10736922otr.73.2020.12.31.18.16.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Dec 2020 18:16:40 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 10/47] completion: bash: get rid of _append() functions
Date:   Thu, 31 Dec 2020 20:15:45 -0600
Message-Id: <20210101021622.798041-11-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210101021622.798041-1-felipe.contreras@gmail.com>
References: <20210101021622.798041-1-felipe.contreras@gmail.com>
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
index 92d0f91df9..b15d9d9d3c 100644
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
 
@@ -2630,7 +2609,7 @@ __git_complete_config_variable_name ()
 		local pfx="${cur_%.*}."
 		cur_="${cur_#*.}"
 		__gitcomp_direct "$(__git_heads "$pfx" "$cur_" ".")"
-		__gitcomp_nl_append $'autoSetupMerge\nautoSetupRebase\n' "$pfx" "$cur_" "${sfx- }"
+		__gitcomp_nl $'autoSetupMerge\nautoSetupRebase\n' "$pfx" "$cur_" "${sfx- }"
 		return
 		;;
 	guitool.*.*)
@@ -2680,7 +2659,7 @@ __git_complete_config_variable_name ()
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
2.30.0

