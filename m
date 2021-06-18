Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FA9DC49361
	for <git@archiver.kernel.org>; Fri, 18 Jun 2021 18:26:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 07FCE613ED
	for <git@archiver.kernel.org>; Fri, 18 Jun 2021 18:26:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236346AbhFRS2g (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Jun 2021 14:28:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236360AbhFRS20 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Jun 2021 14:28:26 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7E01C0617AF
        for <git@vger.kernel.org>; Fri, 18 Jun 2021 11:26:16 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id 66-20020a9d02c80000b02903615edf7c1aso10529107otl.13
        for <git@vger.kernel.org>; Fri, 18 Jun 2021 11:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ySJSiNT4qBvSxuWCbFPtxFVboJ8GrxxtyeLQECaRETI=;
        b=eb0YDZzPg352r3tJNuGRNcVpBU35ZTvPQXCVwcOUOFdgjRgvv45F0UXRskn7Oi0E2b
         QVWaj9QBohXAHPg7rUoX1ExDgw2hf66XiZmrvpPXske5lE+TVLsKlwM5QOCAB1AFxIRm
         jNB9HHnlYb3pU9lB7L1yYk22nGNgBfNzBX57idcPq7LnbWbKZ9bs/yzkIC+6TfGF9cZu
         9QcpFW8+TktZkGdLeGqbV2tTuXz7PgZPurfY8A0ZREuYAPzWbpVM2Mz9lpHx3yCmuLcV
         YyvUAn8g4cZOK/uSNrbVug5dTXn+pHHk4d7uHsPQX2evUZNrY/FWWudgSS2B5PLuSD03
         oPMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ySJSiNT4qBvSxuWCbFPtxFVboJ8GrxxtyeLQECaRETI=;
        b=rh04umIIM6SqhXm5a35GpEa+iukFNKS28X5VNFHajOhZOOYrXjNrqBcAGF/wabXfEt
         DGxfFUemZOEzTLD47pl/GbWEj4tpXZ1T3g/yitV4xpca3YyN8R6yDnY2gAHXVuMWuqsT
         vjmKMV0Y5AGvtlFQ4EwHRmgD7g6Gz7MG/411oVL2JMzL8EccKppD0uFvi2AJ5FKqXgAx
         e9iZI6sHbCIxMFpvAb5Gn606AQ3MShTUUE/PLjrYT+4tt5LF//Btanc1YxrAPCmOHaT1
         x+ALi8Qvk4Zm51d7y+RMRCglPRh9829u7bV/Tq+PAiHfyTmm9lBqDv5IQECWy/ORyRxU
         JXVg==
X-Gm-Message-State: AOAM533KlxhhqT+faDZiB35pc9J55Pb/essaEPnEHqg76GBytiVy/mWB
        MxnVzhk8txjxaQWzA8PqdrsPCKV4i9ZFRQ==
X-Google-Smtp-Source: ABdhPJxUiKDSu+JbwNG6TwkTbt8Av7V2b4l4WSEJ0B1UbOT1ETv19v5xJvtsCqVLfA55+tkFvuPe3w==
X-Received: by 2002:a9d:589:: with SMTP id 9mr10615008otd.65.1624040775883;
        Fri, 18 Jun 2021 11:26:15 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id 16sm2152185otm.57.2021.06.18.11.26.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jun 2021 11:26:15 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 29/45] completion: bash: simplify config_variable_name
Date:   Fri, 18 Jun 2021 13:25:02 -0500
Message-Id: <20210618182518.697912-30-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210618182518.697912-1-felipe.contreras@gmail.com>
References: <20210618182518.697912-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Now that we can actually pass a suffix to __gitcomp function, and it
does the right thing, all the functions can receive the same suffix.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.bash | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index c246d664c3..cb25916f65 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2585,7 +2585,7 @@ __git_complete_config_variable_value ()
 #                 subsections) instead of the default space.
 __git_complete_config_variable_name ()
 {
-	local cur_="$cur" sfx
+	local cur_="$cur" sfx=" "
 
 	while test $# != 0; do
 		case "$1" in
@@ -2607,7 +2607,7 @@ __git_complete_config_variable_name ()
 		local pfx="${cur_%.*}."
 		cur_="${cur_#*.}"
 		__gitcomp_direct "$(__git_heads "$pfx" "$cur_" ".")"
-		__gitcomp_nl $'autoSetupMerge\nautoSetupRebase\n' "$pfx" "$cur_" "${sfx- }"
+		__gitcomp_nl $'autoSetupMerge\nautoSetupRebase\n' "$pfx" "$cur_" "$sfx"
 		return
 		;;
 	guitool.*.*)
@@ -2641,7 +2641,7 @@ __git_complete_config_variable_name ()
 		local pfx="${cur_%.*}."
 		cur_="${cur_#*.}"
 		__git_compute_all_commands
-		__gitcomp_nl "$__git_all_commands" "$pfx" "$cur_" "${sfx- }"
+		__gitcomp_nl "$__git_all_commands" "$pfx" "$cur_" "$sfx"
 		return
 		;;
 	remote.*.*)
@@ -2657,7 +2657,7 @@ __git_complete_config_variable_name ()
 		local pfx="${cur_%.*}."
 		cur_="${cur_#*.}"
 		__gitcomp_nl "$(__git_remotes)" "$pfx" "$cur_" "."
-		__gitcomp_nl "pushDefault" "$pfx" "$cur_" "${sfx- }"
+		__gitcomp_nl "pushDefault" "$pfx" "$cur_" "$sfx"
 		return
 		;;
 	url.*.*)
-- 
2.32.0

