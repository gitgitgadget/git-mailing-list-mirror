Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EBD2ECAAA1
	for <git@archiver.kernel.org>; Tue, 30 Aug 2022 09:34:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230482AbiH3JeI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Aug 2022 05:34:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231751AbiH3JdI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Aug 2022 05:33:08 -0400
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43164A896E
        for <git@vger.kernel.org>; Tue, 30 Aug 2022 02:32:44 -0700 (PDT)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-11f11d932a8so6970096fac.3
        for <git@vger.kernel.org>; Tue, 30 Aug 2022 02:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=TWKgmqMPhVEcP7ybhsAz+OTCIFigxtGhzHsAzZ0iTxw=;
        b=YXmSrn7mkmtAheJja5e3VGkYXHbEGyvs5YAk0Mdqj8Iy3zuvDcxSJG1XT6gtT64h1H
         XDGpHEIQDM/lT/vOuXlxhJNOD9mciJKTHuJvsnOeep1+7mddKaSZJ3MiT8l0QmckuUVn
         SbfYN/eIR8G9dV1clk8Kmbg1/yFXBMElWh+EgHN9R1yIPVGZ0RawXyZyi39jnSLMCrrT
         MO67fAF4BSIbxvIi/SRVzstrNT31cF7dd5tgQtsHveyu4MZb844zxeG6rNjSZJWpyk2H
         xQfTclI0kMz8JtbmbCLFVIR1m5+YezHKVm4Z700ZWQuCi1ov2jLGhrBUNhX7anRVw2n0
         +2eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=TWKgmqMPhVEcP7ybhsAz+OTCIFigxtGhzHsAzZ0iTxw=;
        b=wbmNeL4PBVrDA+tqjsj1DsmeYRh6oCrEPKndc0NtJQI/tuqyTQ3qkEDesp1gC9ydIt
         uc6E46qRhBEruRs6XU4cbTkKBF/OuK2VvGoZOxlrRT0xvLoSFkTGgU+4K39kgOnQcMGQ
         QVSyLZSR2FmrybP8XmSEXlgTYgSv1jTviW0G+kpwK63pFfbJUfOXC+lnHAunmiDvaTVx
         YQGklo2y2gFyS5GVaEvA6UusrBAfvWNRrY0NH/63DHeOyETPSMbtlU3qCJXp65BpSRBU
         Z6QU4YMETCa+siRjpxdjmJHoxYvTo3jJLpwg+yPvn9NasczRcKRCqp7IGK2Kg6i6wsvQ
         5cyg==
X-Gm-Message-State: ACgBeo0aQlUwPWWcYcV8y0EFKc+THZfIsrOP4bEiRBUgMvzVqyVFJxC7
        vk7yZTrwfHD7UJ2FK37x4gvbngNm9W4=
X-Google-Smtp-Source: AA6agR55aTKivPIKYF0OdjqbyRaZDb6WX2eaRyTlJU4j1ynJrOO2RBkfidow850EYqTR/012wCn+5Q==
X-Received: by 2002:a05:6870:3042:b0:11d:d1d:a29d with SMTP id u2-20020a056870304200b0011d0d1da29dmr9421936oau.79.1661851963362;
        Tue, 30 Aug 2022 02:32:43 -0700 (PDT)
Received: from localhost ([2806:2f0:4000:eec:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id e6-20020a05683013c600b00638ac7ddb77sm6876390otq.10.2022.08.30.02.32.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 02:32:42 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     git-fc@googlegroups.com,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 37/51] completion: bash: cleanup __gitcomp* invocations
Date:   Tue, 30 Aug 2022 04:31:24 -0500
Message-Id: <20220830093138.1581538-38-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.37.2.351.g9bf691b78c.dirty
In-Reply-To: <20220830093138.1581538-1-felipe.contreras@gmail.com>
References: <20220830093138.1581538-1-felipe.contreras@gmail.com>
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
index 2cedbd6cc8..499ccd3a93 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1374,7 +1374,7 @@ _git_archive ()
 {
 	case "$cur" in
 	--format=*)
-		__gitcomp "$(git archive --list)" "" "${cur##--format=}"
+		__gitcomp_nl "$(git archive --list)" "" "${cur##--format=}"
 		return
 		;;
 	--remote=*)
@@ -1788,9 +1788,7 @@ _git_format_patch ()
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
@@ -2296,7 +2294,7 @@ _git_send_email ()
 {
 	case "$prev" in
 	--to|--cc|--bcc|--from)
-		__gitcomp "$(__git send-email --dump-aliases)"
+		__gitcomp_nl "$(__git send-email --dump-aliases)"
 		return
 		;;
 	esac
@@ -2320,9 +2318,7 @@ _git_send_email ()
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
@@ -2622,7 +2618,7 @@ __git_complete_config_variable_name ()
 		local pfx="${cur_%.*}."
 		cur_="${cur_#*.}"
 		__gitcomp_direct "$(__git_heads "$pfx" "$cur_" ".")"
-		__gitcomp_nl $'autoSetupMerge\nautoSetupRebase\n' "$pfx" "$cur_" "$sfx"
+		__gitcomp "autoSetupMerge autoSetupRebase" "$pfx" "$cur_" "$sfx"
 		return
 		;;
 	guitool.*.*)
@@ -2672,7 +2668,7 @@ __git_complete_config_variable_name ()
 		local pfx="${cur_%.*}."
 		cur_="${cur_#*.}"
 		__gitcomp_nl "$(__git_remotes)" "$pfx" "$cur_" "."
-		__gitcomp_nl "pushDefault" "$pfx" "$cur_" "$sfx"
+		__gitcomp "pushDefault" "$pfx" "$cur_" "$sfx"
 		return
 		;;
 	url.*.*)
@@ -2687,7 +2683,7 @@ __git_complete_config_variable_name ()
 		;;
 	*)
 		__git_compute_config_sections
-		__gitcomp "$__git_config_sections" "" "$cur_" "."
+		__gitcomp_nl "$__git_config_sections" "" "$cur_" "."
 		;;
 	esac
 }
@@ -2781,7 +2777,7 @@ _git_remote ()
 		__gitcomp_builtin remote_update
 		;;
 	update,*)
-		__gitcomp "$(__git_remotes) $(__git_get_config_variables "remotes")"
+		__gitcomp_nl "$(__git_remotes) $(__git_get_config_variables "remotes")"
 		;;
 	set-url,--*)
 		__gitcomp_builtin remote_set-url
@@ -3464,7 +3460,7 @@ __git_main ()
 				then
 					list_cmds=builtins,$list_cmds
 				fi
-				__gitcomp "$(__git --list-cmds=$list_cmds)"
+				__gitcomp_nl "$(__git --list-cmds=$list_cmds)"
 			fi
 			;;
 		esac
-- 
2.37.2.351.g9bf691b78c.dirty

