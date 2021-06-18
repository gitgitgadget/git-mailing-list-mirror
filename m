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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D196C48BE8
	for <git@archiver.kernel.org>; Fri, 18 Jun 2021 18:25:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56243611CC
	for <git@archiver.kernel.org>; Fri, 18 Jun 2021 18:25:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235400AbhFRS1f (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Jun 2021 14:27:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235291AbhFRS1e (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Jun 2021 14:27:34 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40AD4C061574
        for <git@vger.kernel.org>; Fri, 18 Jun 2021 11:25:24 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id m137so11510280oig.6
        for <git@vger.kernel.org>; Fri, 18 Jun 2021 11:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NXvZEFQ5vNwDyNTJA7wlb/08fcKoPo2L8hb6fPqpoXI=;
        b=VwNRXYdA5w5d6llxN33CtzOBk7iqtyr+2tjNwLfRRUtIr//D0Kwq7Cei3PppdSI+cz
         ZT8zL8YH1phpB2uplZktGUMqccLmq481lJTKhegDGbVUcLfNbQ5doSaiidHX65sLeZA9
         P9RcEpm8pVj25i1gJRSYHLfwHW0cfsQFr7Lk8zqQOaB0JF5sEb0XhLunj2NlZKyXFtjY
         Df4CwH2hgI3853/Zh6v8myfAtuEBzC1NrcQ65/ypSMDBFjae/gXvgGcFSpD/M+U8sSt5
         6vxyC8toR58IwboyT6T0P1kEzKMZmrhS2R962YMVeLxyG2ykVPqCdwqJkRCD2WrmBPMv
         Ifnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NXvZEFQ5vNwDyNTJA7wlb/08fcKoPo2L8hb6fPqpoXI=;
        b=LQKzXVciVFBJY3qXUSfoR/mcuS5boOk+VTr2E0CMw+X6JnLpZDQLw7Y2U/npG+IeLZ
         lsPLz83eS01ikEuV6unMQNfdHWiY037H2pAu/BBLIQqAOnQ/wFLgvJAYo+JZSi7TJCb7
         hCjIz9pmvlqOUKaBWxR79vYeUIRG9TkhD6tZOFv00cpXIjctWGE0LW1Z/0PxmR2cM2jT
         To7Zd41r7Sx0EMhZIYGhOm6yJqi3Luz/MwDLqjoMcQJQ5k3Fj2VknCHBwzkZBRjlsmEh
         GU0NurcNpov+ywQR6Xgp4O+Pg9X/vpA+/UU4oEc4Mlz15H6W1p0Y9lGR0miTZCFK7Eli
         CeCw==
X-Gm-Message-State: AOAM530IhA8Ib9V/kTieTwgJO8gdSpj01CQ2DXWjdXt5INAGOvOGcCIl
        iWFnGKgmi9TBjNZR80jIFVERyGdvTJ0exQ==
X-Google-Smtp-Source: ABdhPJyh1jSIagOgNFatlCxTCiB4b7avaDrelTymeSSyEnqRW7pPog9Bu4vRmeF4tfyd1RxJd+ye+Q==
X-Received: by 2002:a05:6808:2091:: with SMTP id s17mr14655302oiw.168.1624040723443;
        Fri, 18 Jun 2021 11:25:23 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id r2sm2164135otd.54.2021.06.18.11.25.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jun 2021 11:25:22 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 02/45] completion: bash: fix prefix detection in branch.*
Date:   Fri, 18 Jun 2021 13:24:35 -0500
Message-Id: <20210618182518.697912-3-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210618182518.697912-1-felipe.contreras@gmail.com>
References: <20210618182518.697912-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Otherwise we are completely ignoring the --cur argument.

The issue can be tested with:

  git clone --config=branch.<tab>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.bash | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 52a2d283cd..f8a751c4ec 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2649,8 +2649,8 @@ __git_complete_config_variable_name ()
 		return
 		;;
 	branch.*)
-		local pfx="${cur%.*}."
-		cur_="${cur#*.}"
+		local pfx="${cur_%.*}."
+		cur_="${cur_#*.}"
 		__gitcomp_direct "$(__git_heads "$pfx" "$cur_" ".")"
 		__gitcomp_nl_append $'autoSetupMerge\nautoSetupRebase\n' "$pfx" "$cur_" "$sfx"
 		return
-- 
2.32.0

