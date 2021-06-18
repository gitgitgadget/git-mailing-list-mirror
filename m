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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DE9FC48BDF
	for <git@archiver.kernel.org>; Fri, 18 Jun 2021 18:25:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33BDA611CC
	for <git@archiver.kernel.org>; Fri, 18 Jun 2021 18:25:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236315AbhFRS15 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Jun 2021 14:27:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236300AbhFRS14 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Jun 2021 14:27:56 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADDE2C061574
        for <git@vger.kernel.org>; Fri, 18 Jun 2021 11:25:45 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id o17-20020a9d76510000b02903eabfc221a9so10637284otl.0
        for <git@vger.kernel.org>; Fri, 18 Jun 2021 11:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+zL1t85DgllGMe13ZGN/bPVSfiUU2yAv1dpqoo3ssjk=;
        b=bQPsrdkhgP2sT5OTA8XIFXI2u3lMwTT4DifmBynStEikTto2ia63hQCNOM0/cs6zGd
         8qzSYsV7JUr3rmitG6eX22/i1jvJRsrxmILF6F4ryV1La1Pdw3L2/4Ax4PbFU7Li0rMO
         NQYulJt0zkbVlsGqiSjIIEq3upEBK/865FDwI+2pa489wQqpioaKV7lL4vqsrH3ruhGU
         Rmy5jelYk1gSX/9KNSCSGxa1v6Y555eHWbsj7RQIvYpyyYicPoOBVbgoXpmqC28byudT
         LthzR5h1MdV0xA2/PYBVV7flnwDgchw4DmrDzfT41+wrAPX1MfUlrHQPHq4jVWKypddD
         jllA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+zL1t85DgllGMe13ZGN/bPVSfiUU2yAv1dpqoo3ssjk=;
        b=LqYLUxqzwGzal2ASt9paTWDLdMauWOX1qXEQZx+U9Jz9K57WeM0nZvyJpVTDA3ibWh
         rXIVepmbHHCvzLd3UWTUob5omT24k8UFcbcCzWC1eznttkQqee32sHd/2OumAn6CXesg
         x+JlkW1eLtTDI6c0BlHioZUeFC1dON8vNcmA+mb1LKFrypvTVSn1cwC0/AUPvUCdLwWk
         sFZASXcMBbjNrGZP7U4UC+ViyLcgn043A/1mqVaoCcTJKPCL3BBfCilJMabHIVbFLbpL
         Xzqp4k/cDaw0+4vApFk+PZWovry9tFvrYGSBUmPHpuuG/BEF+HKLMMqJE1cmS8NqBd3C
         mlhw==
X-Gm-Message-State: AOAM531X0jZCyN63K2OVUHg98pSFoiNnTqHRuDvxA5VEOxBIin6kyQ55
        UfOpIm139hBd5jc39JSc1gy3dEVdn9e6lQ==
X-Google-Smtp-Source: ABdhPJxSFZSZioK6F9JQaS4EhRAanAz0PuqjTJlKUP0rgB8yH+UTPIPC5c7UTHGBPUUa514ggidwIA==
X-Received: by 2002:a9d:62ce:: with SMTP id z14mr10855208otk.255.1624040744841;
        Fri, 18 Jun 2021 11:25:44 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id k7sm2020090otf.72.2021.06.18.11.25.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jun 2021 11:25:44 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 13/45] completion: bash: get rid of _append() functions
Date:   Fri, 18 Jun 2021 13:24:46 -0500
Message-Id: <20210618182518.697912-14-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210618182518.697912-1-felipe.contreras@gmail.com>
References: <20210618182518.697912-1-felipe.contreras@gmail.com>
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
index 8f72e0f66b..c3ea5261fb 100644
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
 
@@ -2646,7 +2625,7 @@ __git_complete_config_variable_name ()
 		local pfx="${cur_%.*}."
 		cur_="${cur_#*.}"
 		__gitcomp_direct "$(__git_heads "$pfx" "$cur_" ".")"
-		__gitcomp_nl_append $'autoSetupMerge\nautoSetupRebase\n' "$pfx" "$cur_" "${sfx- }"
+		__gitcomp_nl $'autoSetupMerge\nautoSetupRebase\n' "$pfx" "$cur_" "${sfx- }"
 		return
 		;;
 	guitool.*.*)
@@ -2696,7 +2675,7 @@ __git_complete_config_variable_name ()
 		local pfx="${cur_%.*}."
 		cur_="${cur_#*.}"
 		__gitcomp_nl "$(__git_remotes)" "$pfx" "$cur_" "."
-		__gitcomp_nl_append "pushDefault" "$pfx" "$cur_" "${sfx- }"
+		__gitcomp_nl "pushDefault" "$pfx" "$cur_" "${sfx- }"
 		return
 		;;
 	url.*.*)
diff --git a/contrib/completion/git-completion.zsh b/contrib/completion/git-completion.zsh
index 5ddd2d6771..8cbf4f83f5 100644
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
2.32.0

