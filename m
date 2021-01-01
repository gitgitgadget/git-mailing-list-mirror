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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D665DC433E6
	for <git@archiver.kernel.org>; Fri,  1 Jan 2021 02:17:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B166A207A3
	for <git@archiver.kernel.org>; Fri,  1 Jan 2021 02:17:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727347AbhAACRe (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 31 Dec 2020 21:17:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727302AbhAACRe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Dec 2020 21:17:34 -0500
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4F2AC06179B
        for <git@vger.kernel.org>; Thu, 31 Dec 2020 18:17:12 -0800 (PST)
Received: by mail-ot1-x32f.google.com with SMTP id b24so19329043otj.0
        for <git@vger.kernel.org>; Thu, 31 Dec 2020 18:17:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=E0zbIFf0j8CyUESHr+J7Dc6k2T4M87qBcvw5xchQRUg=;
        b=Y5g8wbub9Oe0G1GyllTM245Hb+9JUWBgYvMkXtWHNZ/CA0LUTFWrC8C0TIsXjZsLOP
         7NmRZ4zDmoMHKDEGtvyDw5Cdetwx7ket3BvaVH0i1dLA+0KejHnD3vwhwq2+VIqQEQ07
         yxw7aiT/l7tVZPRPA+rmPVxH/XwpuXIssCJQsw2rW94xZjOgaktukhxVLGJhbyE4ehDF
         OcTueIhbs/N/HQXPQjwDb0uQ6WC6A8pjyNmXhZHPJzW3dKH3Mu9mBQlLLz3opVVoJuZi
         LgmOQPXfLsy6pcUqrEGMtDVPMgSilJ3eFxpzGZb9JWoC1mpdJ/Fzezt2SCpEK4j5/1pu
         BasQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=E0zbIFf0j8CyUESHr+J7Dc6k2T4M87qBcvw5xchQRUg=;
        b=SbsxY7q7g0MsBlLJIVT2yJ7haG8Ul/lK/xRFdbpTt0vHv5zuyvX3W13uZq7K3UduoN
         ygpmoJEwZWGA8DxFqi2PgXXDmJHNYGVH4xONqsczhdIupDTs1qFt41q4zsKYrrWErNXU
         U2A8XTKKZCH0ug7iwCWzvLZrPwcpPyg/E2RCFvVEnb0MgQ2UA7NaiXBW9v89HxEFvBPx
         sbqySslrL9iGleGTRjPM/KSeushBshPAqGi7jqerVuA0wiu6IbNTZOtww9TCGVWYixex
         7rSvUawF+C40L0jN63B7pzP3cZ9YZYoAs+6Zy9E8TPhvqsAL0xKMgNAWi6hpspiOCecp
         754A==
X-Gm-Message-State: AOAM532Y2Qr/oio8gDd2fFrQi2+0SOCdlXMLQ1WLSe4oR3/CkMZIM2W3
        Y9NvHWtCWA8ZRfR0j1vaU/uHBkk5PfRkqQ==
X-Google-Smtp-Source: ABdhPJwP/E9DFpSG/zTluuFeRhrHjX8wdnNW5pHHbo+UaMT2yQklfUSz+QNo5BW/wqPmXtwLumsv8w==
X-Received: by 2002:a9d:3e2:: with SMTP id f89mr43535145otf.278.1609467432072;
        Thu, 31 Dec 2020 18:17:12 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id p28sm11570570ota.14.2020.12.31.18.17.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Dec 2020 18:17:11 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 30/47] completion: bash: cleanup __gitcomp* invocations
Date:   Thu, 31 Dec 2020 20:16:05 -0600
Message-Id: <20210101021622.798041-31-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210101021622.798041-1-felipe.contreras@gmail.com>
References: <20210101021622.798041-1-felipe.contreras@gmail.com>
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
index faf563b783..9bcb484656 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1355,7 +1355,7 @@ _git_archive ()
 {
 	case "$cur" in
 	--format=*)
-		__gitcomp "$(git archive --list)" "" "${cur##--format=}"
+		__gitcomp_nl "$(git archive --list)" "" "${cur##--format=}"
 		return
 		;;
 	--remote=*)
@@ -1766,9 +1766,7 @@ _git_format_patch ()
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
@@ -2274,7 +2272,7 @@ _git_send_email ()
 {
 	case "$prev" in
 	--to|--cc|--bcc|--from)
-		__gitcomp "$(__git send-email --dump-aliases)"
+		__gitcomp_nl "$(__git send-email --dump-aliases)"
 		return
 		;;
 	esac
@@ -2298,9 +2296,7 @@ _git_send_email ()
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
@@ -2602,7 +2598,7 @@ __git_complete_config_variable_name ()
 		local pfx="${cur_%.*}."
 		cur_="${cur_#*.}"
 		__gitcomp_direct "$(__git_heads "$pfx" "$cur_" ".")"
-		__gitcomp_nl $'autoSetupMerge\nautoSetupRebase\n' "$pfx" "$cur_" "$sfx"
+		__gitcomp "autoSetupMerge autoSetupRebase" "$pfx" "$cur_" "$sfx"
 		return
 		;;
 	guitool.*.*)
@@ -2652,7 +2648,7 @@ __git_complete_config_variable_name ()
 		local pfx="${cur_%.*}."
 		cur_="${cur_#*.}"
 		__gitcomp_nl "$(__git_remotes)" "$pfx" "$cur_" "."
-		__gitcomp_nl "pushDefault" "$pfx" "$cur_" "$sfx"
+		__gitcomp "pushDefault" "$pfx" "$cur_" "$sfx"
 		return
 		;;
 	url.*.*)
@@ -2667,7 +2663,7 @@ __git_complete_config_variable_name ()
 		;;
 	*)
 		__git_compute_config_vars
-		__gitcomp "$(echo "$__git_config_vars" |
+		__gitcomp_nl "$(echo "$__git_config_vars" |
 				awk -F . '{
 					sections[$1] = 1
 				}
@@ -2769,7 +2765,7 @@ _git_remote ()
 		__gitcomp_builtin remote_update
 		;;
 	update,*)
-		__gitcomp "$(__git_remotes) $(__git_get_config_variables "remotes")"
+		__gitcomp_nl "$(__git_remotes) $(__git_get_config_variables "remotes")"
 		;;
 	set-url,--*)
 		__gitcomp_builtin remote_set-url
@@ -3407,7 +3403,7 @@ __git_main ()
 			then
 				__gitcomp "$GIT_TESTING_PORCELAIN_COMMAND_LIST"
 			else
-				__gitcomp "$(__git --list-cmds=list-mainporcelain,others,nohelpers,alias,list-complete,config)"
+				__gitcomp_nl "$(__git --list-cmds=list-mainporcelain,others,nohelpers,alias,list-complete,config)"
 			fi
 			;;
 		esac
-- 
2.30.0

