Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 645B0C43381
	for <git@archiver.kernel.org>; Wed, 23 Dec 2020 14:49:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4BD542333B
	for <git@archiver.kernel.org>; Wed, 23 Dec 2020 14:49:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728280AbgLWOtg (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Dec 2020 09:49:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726419AbgLWOtg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Dec 2020 09:49:36 -0500
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B72B9C06179C
        for <git@vger.kernel.org>; Wed, 23 Dec 2020 06:48:55 -0800 (PST)
Received: by mail-ot1-x334.google.com with SMTP id 11so15166665oty.9
        for <git@vger.kernel.org>; Wed, 23 Dec 2020 06:48:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dCnqKx5xU0TmL3ov36P1ihb2ldMl1bapdBSxq3KpjnQ=;
        b=QiufhfLfIUoKpf1WjEwg8S5AlxcKxBd2Wwzet1Chn4667czseaXw+HvmPqB8bfT1HG
         IgcSje4RQPZKggfUb7nyOunLLos3aDMJ+eot7S4J70mQV8v7XfP4+FQWQ/XE67z3KMzi
         fMMS8sjgrod126WASK5AhNoObB4xMKnZkOwPaEzLRmkjF+uTxblJ0jTXXSXYiWrQyHBZ
         5Otiqvfb853sOFlPUrhTe3l/1culkH9M8/JGoUNRrReohFK3DCV4/aAcIeVc3GXHALLy
         Gku6F5eK2X4YXYn15fvfoRwS4eTRzVV0B+0geV2jucDSwCm3wIetyZEjgEcwojznR65i
         GZFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dCnqKx5xU0TmL3ov36P1ihb2ldMl1bapdBSxq3KpjnQ=;
        b=Yx0EheUvk+vS8LqCUQdy08rPARAZ6HfXifGC7Y0lGhouP3vVuHLzm8sZr8aK66kRqI
         rUHONrS8fkIVZtXqOe8P/CCGqJanFIPQk07wvxuDwCJQRnduR+qk+F4wt9dsiPaXyVq7
         KdUsLjF3JK807z7b/HpWjqjeU/EXWdmmn+bwJYbi43IbqNzIiZhIlq69p1fiwvAgU2G8
         yUGjILvaH5QB7MU6l/ahiWNrrQPRv0rWXRC7AQLxS89R6ThQRNtSYem8Ig2nXOpaJ7w9
         KpNm8QgXtK1J58DQlwyu1zv15wEiQZQ7u9hReRwXm4wCcCIgk8MBJw+iGJB6fHC1LYk5
         xKfA==
X-Gm-Message-State: AOAM530kmSbxyAJ3xlsOPaREUMeF0YQK1KFopHSPrAppjWOx8pZz9vCU
        QH2eDrJhbtPqATZ2nAI/pPuzf9Aq2MbiOw==
X-Google-Smtp-Source: ABdhPJwyDdiyD5wc0e9FTr5zh3nujyyD3RmV5vvJIpRlvv4+8yfgQhQUiC4F6nEk3LrNhO2GYTDEMQ==
X-Received: by 2002:a9d:6e0e:: with SMTP id e14mr20256644otr.30.1608734934954;
        Wed, 23 Dec 2020 06:48:54 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id q1sm5533010oij.9.2020.12.23.06.48.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Dec 2020 06:48:54 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 4/4] completion: bash: add correct suffix in variables
Date:   Wed, 23 Dec 2020 08:48:45 -0600
Message-Id: <20201223144845.143039-5-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.30.0.rc1
In-Reply-To: <20201223144845.143039-1-felipe.contreras@gmail.com>
References: <20201223144845.143039-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

__gitcomp automatically adds a suffix, but __gitcomp_nl and others
don't, we need to specify a space by default.

Can be tested with:

  git config branch.autoSetupMe<tab>

This fix only works for versions of bash greater than 4.0, before that
"local sfx" creates an empty string, therefore the unset expansion
doesn't work. The same happens in zsh.

Therefore we don't add the test for that for now.

The correct fix for all shells requires semantic changes in __gitcomp,
but that can be done later.

Cc: SZEDER Gábor <szeder.dev@gmail.com>
Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.bash | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 64cf35ba04..926e9ceb56 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2636,7 +2636,7 @@ __git_complete_config_variable_name ()
 		local pfx="${cur_%.*}."
 		cur_="${cur_#*.}"
 		__gitcomp_direct "$(__git_heads "$pfx" "$cur_" ".")"
-		__gitcomp_nl_append $'autoSetupMerge\nautoSetupRebase\n' "$pfx" "$cur_" "$sfx"
+		__gitcomp_nl_append $'autoSetupMerge\nautoSetupRebase\n' "$pfx" "$cur_" "${sfx- }"
 		return
 		;;
 	guitool.*.*)
@@ -2670,7 +2670,7 @@ __git_complete_config_variable_name ()
 		local pfx="${cur_%.*}."
 		cur_="${cur_#*.}"
 		__git_compute_all_commands
-		__gitcomp_nl "$__git_all_commands" "$pfx" "$cur_" "$sfx"
+		__gitcomp_nl "$__git_all_commands" "$pfx" "$cur_" "${sfx- }"
 		return
 		;;
 	remote.*.*)
@@ -2686,7 +2686,7 @@ __git_complete_config_variable_name ()
 		local pfx="${cur_%.*}."
 		cur_="${cur_#*.}"
 		__gitcomp_nl "$(__git_remotes)" "$pfx" "$cur_" "."
-		__gitcomp_nl_append "pushDefault" "$pfx" "$cur_" "$sfx"
+		__gitcomp_nl_append "pushDefault" "$pfx" "$cur_" "${sfx- }"
 		return
 		;;
 	url.*.*)
-- 
2.30.0.rc1

