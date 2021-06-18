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
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB8E5C49361
	for <git@archiver.kernel.org>; Fri, 18 Jun 2021 18:25:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 976F161205
	for <git@archiver.kernel.org>; Fri, 18 Jun 2021 18:25:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235295AbhFRS1d (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Jun 2021 14:27:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235291AbhFRS1d (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Jun 2021 14:27:33 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F3ADC061574
        for <git@vger.kernel.org>; Fri, 18 Jun 2021 11:25:22 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id 102-20020a9d0eef0000b02903fccc5b733fso10576106otj.4
        for <git@vger.kernel.org>; Fri, 18 Jun 2021 11:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LqhGhJ3dwbZy2ZYi1T3oIsD/xWQ5m9t5eU0uf2uOB4w=;
        b=l0YukYYT259odO+SSssczAEV2JJE14LgTd7J5aAjbKdMTUHjzNWQapN+UbFgYOxSbA
         vKEPYJyPrOK8nHvFtCRkIRTINsujKiWJBmpTuoykaEr0A75ms2Ix3BSpNOcYjGtfpsdu
         kgjD3X1ZmINCB/+r+IoXV5LYpXHG6JgsuNEC2RbNW2JjmVMxCL4eESidY2hvTaR5ggg9
         0zsQBetzf8b6gkc+iILeXBtjCsH1mjzSVQR9E06UduzJ7CQuRHYWmoynl8nrBUrh/CTO
         WDbqa9b53XA6z6Tzn0Dvh78i0AnkhuMNY7L5Lq0DTIiQtmq+8I+RLZeK/u7+nPRkGAg1
         DL0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LqhGhJ3dwbZy2ZYi1T3oIsD/xWQ5m9t5eU0uf2uOB4w=;
        b=gjCcNAl3PqVsazNTVZYw/LL8OU14QmX8i1DqOcfo1ZYnjwG1HUvJjMZRB3IYWG3GVJ
         dj1LYrERlp4zoQNNmKwa6aQM5L5gONXn0Rp3dm5qc4zlD2YXNvFAa5FGgmiqnJ+ZXKv/
         HuzY70WMkGDzbm+Wh1A52/xocnKHnGbFLMGNExZKIg5w9F1NvWHYULO5x0Ma2oeiCaID
         DNtcXbgz3H74ZEdBDaPFysNZ2vkAbbhFg47cOXHp2qoe0wAIbbgxvq2qeqwVZuaSBxrf
         Mho7OphYd479QX5ZddfgblRiI/gkyxXwc0djio8qCOanChbTG/giLGrXUihAV3fU1g46
         +BQw==
X-Gm-Message-State: AOAM530m5RXKZlOZrQSSfew34bAI8P8CIIUaDslowRQn3LPIHFc8JP/7
        tNGOPZtz9y40wFiyFv8aFt8lRHe2QLSgLw==
X-Google-Smtp-Source: ABdhPJxEGWf1f4+OGed4tamGrrBdtunG60vc63LuVMMxBqZYL/cOLfi2kXphZrhWMD9wpq0vrREb6w==
X-Received: by 2002:a9d:730a:: with SMTP id e10mr10471102otk.97.1624040721764;
        Fri, 18 Jun 2021 11:25:21 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id u17sm1072705otk.15.2021.06.18.11.25.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jun 2021 11:25:21 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Felipe Contreras <felipe.contreras@gmail.com>,
        Harrison McCullough <mccullough.harrison@gmail.com>
Subject: [PATCH v2 01/45] completion: fix __git_cmd_idx regression
Date:   Fri, 18 Jun 2021 13:24:34 -0500
Message-Id: <20210618182518.697912-2-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210618182518.697912-1-felipe.contreras@gmail.com>
References: <20210618182518.697912-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The commit 59d85a2a05 (git-completion.bash: use $__git_cmd_idx in more
places, 2021-04-22) caused a regression when using __git_complete and a
command relies on __git_cmd_idx.

We need the function wrapper to define __git_cmd_idx.

If the function wrapper defines __git_cmd_idx, then it's not necessary
for __git_zsh_main to do so.

Reported-by: Harrison McCullough <mccullough.harrison@gmail.com>
Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.bash | 2 +-
 contrib/completion/git-completion.zsh  | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index b50c5d0ea3..52a2d283cd 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -3511,7 +3511,7 @@ fi
 
 __git_func_wrap ()
 {
-	local cur words cword prev
+	local cur words cword prev __git_cmd_idx=1
 	_get_comp_words_by_ref -n =: cur words cword prev
 	$1
 }
diff --git a/contrib/completion/git-completion.zsh b/contrib/completion/git-completion.zsh
index cac6f61881..02ffeae768 100644
--- a/contrib/completion/git-completion.zsh
+++ b/contrib/completion/git-completion.zsh
@@ -251,7 +251,7 @@ __git_zsh_main ()
 		done
 		;;
 	(arg)
-		local command="${words[1]}" __git_dir __git_cmd_idx=1
+		local command="${words[1]}" __git_dir
 
 		if (( $+opt_args[--bare] )); then
 			__git_dir='.'
@@ -271,7 +271,7 @@ __git_zsh_main ()
 _git ()
 {
 	local _ret=1
-	local cur cword prev
+	local cur cword prev __git_cmd_idx=1
 
 	cur=${words[CURRENT]}
 	prev=${words[CURRENT-1]}
-- 
2.32.0

