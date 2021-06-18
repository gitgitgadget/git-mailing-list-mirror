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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CB2FC49EA2
	for <git@archiver.kernel.org>; Fri, 18 Jun 2021 18:26:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 87318613F2
	for <git@archiver.kernel.org>; Fri, 18 Jun 2021 18:26:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236364AbhFRS2v (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Jun 2021 14:28:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236381AbhFRS2d (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Jun 2021 14:28:33 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 167ECC0611C3
        for <git@vger.kernel.org>; Fri, 18 Jun 2021 11:26:23 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id w22-20020a0568304116b02904060c6415c7so10613340ott.1
        for <git@vger.kernel.org>; Fri, 18 Jun 2021 11:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=74wmMndoRRJg3xMKh4g50ca2DD/m8DEKi9iYUiJ0NE0=;
        b=np9klRzoEUz5ZlZhdtIFiPhms1/V5tMYTOXV2hJVy2yKjM0cplyzTYNwZujw+LLqQb
         Ds6m3vjv7++/OZslTi1JlNlDnTA7N2pMyS+qoJFv16Ni1M86XCLVznvyeLTDurYE/SKX
         hxIfkFNXHd0LdWzX+zHrPFZQj6nWnA7ZEdWSBUP9h/mFP8zSeqXZEkj4rCxadFNN5V6o
         8GxGgeshT57uT8c52nIjKwELq4HIzENyOsKCunEegbTi1SMx7wS5Nu2OUHhJVtbvfxFS
         Sa/vKStAwIgYJj8dIRb5FkTRJG0JGTRe2+66WqeKdGQrxbHeXxP5anBkfIJ+BfHIeA8p
         GE8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=74wmMndoRRJg3xMKh4g50ca2DD/m8DEKi9iYUiJ0NE0=;
        b=SB/jt52iiK6UE35lFCx8TJP7bMIj6NKqfSS/u4avoD6knmSJLpwmx6Gzjmuz+19Rx1
         lmOuafqIJqdnbA+Od15yHEHrh902cDQhcB9KHkw6oTLKMQfdBccIfWn/Big0qB3rRFiP
         4PumtfEjMrfyaqRNu3Amu0PVhB3C4X8fn5+pe9Q5aftDHOmt1oL0FAAVgaVHX8bduRSR
         X5o8PvcP6c3ynIZZtA4f/IR0HOgartjKgJVSG1QLwLiz1RxCW5rH0QbKk415OpTpR3CG
         JG1pQo1fuz6wSGBJVLlI4klSz+OgPvu+/2aeSvuvbmOiyUTUO02Qo1J2HP5f8Ffq1HG2
         mmDQ==
X-Gm-Message-State: AOAM530dAOO1OefJDG37dBg0DNgyg5Y6aAcs/bKRgw07HraDDdN5leNr
        QO6MtnCkuwiM99KIVcW8uet7C6o3bhSmrQ==
X-Google-Smtp-Source: ABdhPJwIiTRVr84JrBYVdMNn4VijA/ziN9L4IOfJloPZvFwNPf1gTCFEcHuh3QgtPtyBUSqQfZczeQ==
X-Received: by 2002:a05:6830:20cf:: with SMTP id z15mr5552707otq.221.1624040782266;
        Fri, 18 Jun 2021 11:26:22 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id y9sm350104oos.14.2021.06.18.11.26.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jun 2021 11:26:21 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 33/45] completion: bash: cleanup __gitcomp* invocations
Date:   Fri, 18 Jun 2021 13:25:06 -0500
Message-Id: <20210618182518.697912-34-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210618182518.697912-1-felipe.contreras@gmail.com>
References: <20210618182518.697912-1-felipe.contreras@gmail.com>
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
index 8836eab884..7a27347d56 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1369,7 +1369,7 @@ _git_archive ()
 {
 	case "$cur" in
 	--format=*)
-		__gitcomp "$(git archive --list)" "" "${cur##--format=}"
+		__gitcomp_nl "$(git archive --list)" "" "${cur##--format=}"
 		return
 		;;
 	--remote=*)
@@ -1782,9 +1782,7 @@ _git_format_patch ()
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
@@ -2290,7 +2288,7 @@ _git_send_email ()
 {
 	case "$prev" in
 	--to|--cc|--bcc|--from)
-		__gitcomp "$(__git send-email --dump-aliases)"
+		__gitcomp_nl "$(__git send-email --dump-aliases)"
 		return
 		;;
 	esac
@@ -2314,9 +2312,7 @@ _git_send_email ()
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
@@ -2618,7 +2614,7 @@ __git_complete_config_variable_name ()
 		local pfx="${cur_%.*}."
 		cur_="${cur_#*.}"
 		__gitcomp_direct "$(__git_heads "$pfx" "$cur_" ".")"
-		__gitcomp_nl $'autoSetupMerge\nautoSetupRebase\n' "$pfx" "$cur_" "$sfx"
+		__gitcomp "autoSetupMerge autoSetupRebase" "$pfx" "$cur_" "$sfx"
 		return
 		;;
 	guitool.*.*)
@@ -2668,7 +2664,7 @@ __git_complete_config_variable_name ()
 		local pfx="${cur_%.*}."
 		cur_="${cur_#*.}"
 		__gitcomp_nl "$(__git_remotes)" "$pfx" "$cur_" "."
-		__gitcomp_nl "pushDefault" "$pfx" "$cur_" "$sfx"
+		__gitcomp "pushDefault" "$pfx" "$cur_" "$sfx"
 		return
 		;;
 	url.*.*)
@@ -2683,7 +2679,7 @@ __git_complete_config_variable_name ()
 		;;
 	*)
 		__git_compute_config_vars
-		__gitcomp "$(echo "$__git_config_vars" |
+		__gitcomp_nl "$(echo "$__git_config_vars" |
 				awk -F . '{
 					sections[$1] = 1
 				}
@@ -2785,7 +2781,7 @@ _git_remote ()
 		__gitcomp_builtin remote_update
 		;;
 	update,*)
-		__gitcomp "$(__git_remotes) $(__git_get_config_variables "remotes")"
+		__gitcomp_nl "$(__git_remotes) $(__git_get_config_variables "remotes")"
 		;;
 	set-url,--*)
 		__gitcomp_builtin remote_set-url
@@ -3430,7 +3426,7 @@ __git_main ()
 			then
 				__gitcomp "$GIT_TESTING_PORCELAIN_COMMAND_LIST"
 			else
-				__gitcomp "$(__git --list-cmds=list-mainporcelain,others,nohelpers,alias,list-complete,config)"
+				__gitcomp_nl "$(__git --list-cmds=list-mainporcelain,others,nohelpers,alias,list-complete,config)"
 			fi
 			;;
 		esac
-- 
2.32.0

