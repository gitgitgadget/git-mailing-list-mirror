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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 357CBC433E0
	for <git@archiver.kernel.org>; Wed, 30 Dec 2020 23:30:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE48D207A9
	for <git@archiver.kernel.org>; Wed, 30 Dec 2020 23:30:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726337AbgL3Xaf (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Dec 2020 18:30:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726302AbgL3Xae (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Dec 2020 18:30:34 -0500
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F215C061575
        for <git@vger.kernel.org>; Wed, 30 Dec 2020 15:29:54 -0800 (PST)
Received: by mail-ot1-x329.google.com with SMTP id q25so16777880otn.10
        for <git@vger.kernel.org>; Wed, 30 Dec 2020 15:29:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LYMFb60oj1ozuA3IBJgnIIJ4JjKCmOzQUHPrcHLsidA=;
        b=tPDB8Dg7acMpAsFdB0++PMprhaRnYqC+bxAV4OO9F7u9qZxpohRLD6AQi8qWwIMg9x
         TD3b3lD1TaLt9k5wbClNw3TX+NOLrWc4TmewTrjBuQziWXAraHn99y8AzVTfJ4N5ddYK
         DK58coZ5Sq5a8TpsBq8HfvRLnvnxeHLjEpr5mLYY5DqTY+haLN0ZG0PtPz39unXfFcZk
         UQAF6g/U699Xy9TH3KBzqBCLXqiBq8YhiYEIJBR1/gitcMG4f9GHKfVRmG8xMwIiYDor
         8cGi76R7+ETiCN4Vnopscs6hNP27XB2RVi1wY52NDB6dkMuOfyouU3rnbkFB0l9pimbK
         7aEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LYMFb60oj1ozuA3IBJgnIIJ4JjKCmOzQUHPrcHLsidA=;
        b=DAIm6K6SJcioD/CWskji94cc88P7VCQ0sFZ6lQwnP39HswAYyNfeVnS1EhbVJzxq3z
         K95g0UO9veRSFA8w4zeYRU/lNkmDloEUIacnok1GVcmOq2tSZ/e1ssxM+V7s6YjiIUc+
         lEacddExoBUt9ubsaNV9mS3fADlnIvXs+40pIoGlb6ecIqKyWwBmF+LS5nao/RkCnGe4
         tyCuJVVHvRN89Z/r+dp0FazIC8muj6a5ASS1+g4Vwkcx41Jig1kic+mHM4cgT7tv5hzL
         RXwrFlN/5R78yivUaTRtmZz2fc18lGnCDtKzZlkHxENdzBxCC84h37e93VaexOzReUvZ
         5b3A==
X-Gm-Message-State: AOAM531FqgbGRhyuK3OqyM2AkRdmJ0LFVdTbCbI/YaVojR1QSCJFkkTy
        HEm1+LOL83VoUSGXYLTL79gptNK/dm3NLw==
X-Google-Smtp-Source: ABdhPJwLyNzrB4nRwHnc1jCihK5jfwj9VwypyxCsdpWQzmbKKpW+GLXr+oiT2h6XkWXbOQwKTJ8f8w==
X-Received: by 2002:a05:6830:10d1:: with SMTP id z17mr39693544oto.156.1609370993735;
        Wed, 30 Dec 2020 15:29:53 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id t24sm9640258oij.7.2020.12.30.15.29.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Dec 2020 15:29:53 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Denton Liu <liu.denton@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 1/4] completion: bash: add __git_have_func helper
Date:   Wed, 30 Dec 2020 17:29:47 -0600
Message-Id: <20201230232950.582152-2-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20201230232950.582152-1-felipe.contreras@gmail.com>
References: <20201230232950.582152-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This makes the code more readable, and also will help when new code
wants to do similar checks.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.bash | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 463a3124da..869c73ee2c 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -3358,15 +3358,19 @@ __git_support_parseopt_helper () {
 	esac
 }
 
+__git_have_func () {
+	declare -f $1 >/dev/null 2>/dev/null
+}
+
 __git_complete_command () {
 	local command="$1"
 	local completion_func="_git_${command//-/_}"
-	if ! declare -f $completion_func >/dev/null 2>/dev/null &&
-		declare -f _completion_loader >/dev/null 2>/dev/null
+	if ! __git_have_func $completion_func &&
+		__git_have_func _completion_loader
 	then
 		_completion_loader "git-$command"
 	fi
-	if declare -f $completion_func >/dev/null 2>/dev/null
+	if __git_have_func $completion_func
 	then
 		$completion_func
 		return 0
-- 
2.30.0

