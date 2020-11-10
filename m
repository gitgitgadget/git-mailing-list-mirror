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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19BECC388F7
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 21:22:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B7A2420781
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 21:22:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T+enHlns"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732048AbgKJVWc (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Nov 2020 16:22:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732011AbgKJVW2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Nov 2020 16:22:28 -0500
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 578B6C0613D3
        for <git@vger.kernel.org>; Tue, 10 Nov 2020 13:22:28 -0800 (PST)
Received: by mail-oi1-x22c.google.com with SMTP id j7so16095753oie.12
        for <git@vger.kernel.org>; Tue, 10 Nov 2020 13:22:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+CnwyocRf4rS0+/UoR53YzU+cVA0Tigl5erPb+Z7BE0=;
        b=T+enHlnsQxzMq9d4CMNvgPtg6tvU+M/C72Mum6OoOnsQQsg88mGte5MBULyFuGKTxM
         yovO3d+YJ8WteA2a62CNJHL0ZYqGdbcfyokCdf/Iwap3h9x3l4pr9MV05KbBsV6bvXgq
         g7t35evtEGlFJjM4BiuXcI2TKNjkT/j8JsSMB2OHO31vzv9VNPaGeWBReqQZQUXnEPl3
         jq05469G04/9OWGzf9ZDCx/vCNOb4UhWCvkdswqWCBWCWkWg2jGZGzjyMtkRIMPo4fYU
         ooSemqGdZ1lrsXdVymrn6lIvp6cIYKijdo5NI5dzqHSeCAKpZERNub3jYg55TqiYgVz6
         0WLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+CnwyocRf4rS0+/UoR53YzU+cVA0Tigl5erPb+Z7BE0=;
        b=gvqExtjRTvS/TcMi/X0CnBLs0LVHRnHIOxO1Bo6IXl/EtSMtApDHztfuo9fwvUCDHn
         Ilmsjm+uIqknES7LLV3k6YjT/75/ogOhehwgYVzleluZ6BnB0cMvxUdRX6w1m66MAxWm
         +lnm1K2uWnMrc0SsU5I+xowrtByv4TEBFuLYlEn3QVfQvz9vF5Y4iji4fMVIu0s2kDz1
         mrwnZhPFAJNt66QPzOn632Ukn0uA+nVOniCHwKVXPv5yVDQE7Jbxv9Wo/GIftjc48lrI
         7U3dV/Id72pVJigQyWdTAhJch3MXGnQ0HYUlHQ+SkDyuJij4wbKqOf7Jd5YPuY2PJ3TW
         eR0Q==
X-Gm-Message-State: AOAM531h4oIPuDLahLW1U0L4K2X0krdofNaNo3y1HYVo4/CdAkauEk7W
        obXZ4japDF3nHzstONYKf68rBQv+TCbSVg==
X-Google-Smtp-Source: ABdhPJyLQ8fqFwdWFZ8BONerqeUs3BfCfbnCz5GBOEZ65t+Fwxltd4HNayNzpfN2jao3mV1zEeBVGA==
X-Received: by 2002:aca:d583:: with SMTP id m125mr45525oig.47.1605043347479;
        Tue, 10 Nov 2020 13:22:27 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id w21sm28384otq.20.2020.11.10.13.22.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2020 13:22:27 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 25/26] completion: bash: cleanup __gitcomp* invocations
Date:   Tue, 10 Nov 2020 15:21:35 -0600
Message-Id: <20201110212136.870769-26-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201110212136.870769-1-felipe.contreras@gmail.com>
References: <20201110212136.870769-1-felipe.contreras@gmail.com>
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
index 324793368d..d73cdb7096 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1205,7 +1205,7 @@ _git_archive ()
 {
 	case "$cur" in
 	--format=*)
-		__gitcomp "$(git archive --list)" "" "${cur##--format=}"
+		__gitcomp_nl "$(git archive --list)" "" "${cur##--format=}"
 		return
 		;;
 	--remote=*)
@@ -1616,9 +1616,7 @@ _git_format_patch ()
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
@@ -2124,7 +2122,7 @@ _git_send_email ()
 {
 	case "$prev" in
 	--to|--cc|--bcc|--from)
-		__gitcomp "$(__git send-email --dump-aliases)"
+		__gitcomp_nl "$(__git send-email --dump-aliases)"
 		return
 		;;
 	esac
@@ -2148,9 +2146,7 @@ _git_send_email ()
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
@@ -2452,7 +2448,7 @@ __git_complete_config_variable_name ()
 		local pfx="${cur_%.*}."
 		cur_="${cur_#*.}"
 		__gitcomp_direct "$(__git_heads "$pfx" "$cur_" ".")"
-		__gitcomp_nl $'autoSetupMerge\nautoSetupRebase\n' "$pfx" "$cur_" "$sfx"
+		__gitcomp "autoSetupMerge autoSetupRebase" "$pfx" "$cur_" "$sfx"
 		return
 		;;
 	guitool.*.*)
@@ -2502,7 +2498,7 @@ __git_complete_config_variable_name ()
 		local pfx="${cur_%.*}."
 		cur_="${cur_#*.}"
 		__gitcomp_nl "$(__git_remotes)" "$pfx" "$cur_" "."
-		__gitcomp_nl "pushDefault" "$pfx" "$cur_" "$sfx"
+		__gitcomp "pushDefault" "$pfx" "$cur_" "$sfx"
 		return
 		;;
 	url.*.*)
@@ -2517,7 +2513,7 @@ __git_complete_config_variable_name ()
 		;;
 	*)
 		__git_compute_config_vars
-		__gitcomp "$(echo "$__git_config_vars" |
+		__gitcomp_nl "$(echo "$__git_config_vars" |
 				awk -F . '{
 					sections[$1] = 1
 				}
@@ -2619,7 +2615,7 @@ _git_remote ()
 		__gitcomp_builtin remote_update
 		;;
 	update,*)
-		__gitcomp "$(__git_remotes) $(__git_get_config_variables "remotes")"
+		__gitcomp_nl "$(__git_remotes) $(__git_get_config_variables "remotes")"
 		;;
 	set-url,--*)
 		__gitcomp_builtin remote_set-url
@@ -3257,7 +3253,7 @@ __git_main ()
 			then
 				__gitcomp "$GIT_TESTING_PORCELAIN_COMMAND_LIST"
 			else
-				__gitcomp "$(__git --list-cmds=list-mainporcelain,others,nohelpers,alias,list-complete,config)"
+				__gitcomp_nl "$(__git --list-cmds=list-mainporcelain,others,nohelpers,alias,list-complete,config)"
 			fi
 			;;
 		esac
-- 
2.29.2

