Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87C3EC76196
	for <git@archiver.kernel.org>; Sat,  1 Apr 2023 08:49:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbjDAItN (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 1 Apr 2023 04:49:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbjDAIsC (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Apr 2023 04:48:02 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E0F51D864
        for <git@vger.kernel.org>; Sat,  1 Apr 2023 01:47:19 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id bj20so18419635oib.3
        for <git@vger.kernel.org>; Sat, 01 Apr 2023 01:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680338838;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ursDb8Z6Vu/2xeLTutiZZ/4vgH4Ns6oQzaNFPy4/Ctc=;
        b=gtK7Alsrz283zkMkCECqeEzYieX0OPxbvLIjXP2e0ujnRHhdGXu3jC6BC80Xmw7Tz2
         j29AfHHR2fuOAjEehlU6jxEoZR2dgrM6pBJwcA0Cjf+EF1t+1bWTkrQp1gTRLeYHaiat
         JEjQhdOsZv94i1W9BI0MTZC3euUVxpYHHiMLSxG2sFPuFtw0YszH0HVgV6yeSmWb7RnF
         F700EyqcBbDN2+te9srj4s+1WnOXm5xICM0fP6xBJUJucZAqxN4f2QcJ4tSguilXrnDp
         l/Xao6NZlOkDd+TWb0DVsOckWLf+aI9Xl+yPfeOLF7FPTRQEhHroqcLaO6Z1LMtwXUsB
         WcJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680338838;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ursDb8Z6Vu/2xeLTutiZZ/4vgH4Ns6oQzaNFPy4/Ctc=;
        b=vQbe9hp1hVLXgbdyayMnz9vxIJulr4ZH2i1FiAHpj48/5iLKCF+O6kRIh7lCRPfC3k
         7SHZkvhwQ6fPNoly7R97n5PZnIpZbiFybUauy1AmKUOfowfw3zbSo2gV/6KNnZN7p2Bj
         hUomMATvLASgk2M0NIcFRCkkd4mJpZ2/MseRKNbbejnCqg0os70vBl0nHd610MR8Fgt0
         +TRsY5j4UoHNyvhxvnlWECIVQCrrI7K9cd3plMoZVhqnhJCYzVHWsXdtYKd9C2iPXm1k
         Oa4GN8Mkf5NPVjMjxceSp1i7d+Na0C+fKio6K+niWBBloIwXvKDplm7bfL78oJKerxiT
         X0NQ==
X-Gm-Message-State: AAQBX9fiQg854k0e5ha5Q4CYM6KZ2bLMGvoowxeobOb1qhfV2g/41F96
        3QmVelSL5tkYlr7S+B4mcrIL74pkUNo=
X-Google-Smtp-Source: AKy350ZOBN6FnLSaHebyuWoRMSbRTEBL86zrvaosaTOtT7wOzWifNrEUjm23PLTRQO6k5hRxuL8pxw==
X-Received: by 2002:a54:478a:0:b0:388:c626:a32c with SMTP id o10-20020a54478a000000b00388c626a32cmr12295188oic.9.1680338838650;
        Sat, 01 Apr 2023 01:47:18 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:fff1:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id i2-20020a4aab02000000b005251e3f92ecsm1710152oon.47.2023.04.01.01.47.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Apr 2023 01:47:18 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v7 37/49] completion: bash: cleanup __gitcomp* invocations
Date:   Sat,  1 Apr 2023 02:46:14 -0600
Message-Id: <20230401084626.304356-38-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20230401084626.304356-1-felipe.contreras@gmail.com>
References: <20230401084626.304356-1-felipe.contreras@gmail.com>
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
index ba225e999a..bc6f83adce 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1394,7 +1394,7 @@ _git_archive ()
 {
 	case "$cur" in
 	--format=*)
-		__gitcomp "$(git archive --list)" "" "${cur##--format=}"
+		__gitcomp_nl "$(git archive --list)" "" "${cur##--format=}"
 		return
 		;;
 	--remote=*)
@@ -1808,9 +1808,7 @@ _git_format_patch ()
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
@@ -2316,7 +2314,7 @@ _git_send_email ()
 {
 	case "$prev" in
 	--to|--cc|--bcc|--from)
-		__gitcomp "$(__git send-email --dump-aliases)"
+		__gitcomp_nl "$(__git send-email --dump-aliases)"
 		return
 		;;
 	esac
@@ -2340,9 +2338,7 @@ _git_send_email ()
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
@@ -2642,7 +2638,7 @@ __git_complete_config_variable_name ()
 		local pfx="${cur_%.*}."
 		cur_="${cur_#*.}"
 		__gitcomp_direct "$(__git_heads "$pfx" "$cur_" ".")"
-		__gitcomp_nl $'autoSetupMerge\nautoSetupRebase\n' "$pfx" "$cur_" "$sfx"
+		__gitcomp "autoSetupMerge autoSetupRebase" "$pfx" "$cur_" "$sfx"
 		return
 		;;
 	guitool.*.*)
@@ -2692,7 +2688,7 @@ __git_complete_config_variable_name ()
 		local pfx="${cur_%.*}."
 		cur_="${cur_#*.}"
 		__gitcomp_nl "$(__git_remotes)" "$pfx" "$cur_" "."
-		__gitcomp_nl "pushDefault" "$pfx" "$cur_" "$sfx"
+		__gitcomp "pushDefault" "$pfx" "$cur_" "$sfx"
 		return
 		;;
 	url.*.*)
@@ -2707,7 +2703,7 @@ __git_complete_config_variable_name ()
 		;;
 	*)
 		__git_compute_config_sections
-		__gitcomp "$__git_config_sections" "" "$cur_" "."
+		__gitcomp_nl "$__git_config_sections" "" "$cur_" "."
 		;;
 	esac
 }
@@ -2801,7 +2797,7 @@ _git_remote ()
 		__gitcomp_builtin remote_update
 		;;
 	update,*)
-		__gitcomp "$(__git_remotes) $(__git_get_config_variables "remotes")"
+		__gitcomp_nl "$(__git_remotes) $(__git_get_config_variables "remotes")"
 		;;
 	set-url,--*)
 		__gitcomp_builtin remote_set-url
@@ -3484,7 +3480,7 @@ __git_main ()
 				then
 					list_cmds=builtins,$list_cmds
 				fi
-				__gitcomp "$(__git --list-cmds=$list_cmds)"
+				__gitcomp_nl "$(__git --list-cmds=$list_cmds)"
 			fi
 			;;
 		esac
-- 
2.33.0

