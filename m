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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1457DC48BE8
	for <git@archiver.kernel.org>; Fri, 18 Jun 2021 18:26:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F3831613C2
	for <git@archiver.kernel.org>; Fri, 18 Jun 2021 18:26:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236411AbhFRS3F (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Jun 2021 14:29:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236387AbhFRS2p (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Jun 2021 14:28:45 -0400
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com [IPv6:2607:f8b0:4864:20::c30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0831C061280
        for <git@vger.kernel.org>; Fri, 18 Jun 2021 11:26:32 -0700 (PDT)
Received: by mail-oo1-xc30.google.com with SMTP id x22-20020a4a62160000b0290245cf6b7feeso2670354ooc.13
        for <git@vger.kernel.org>; Fri, 18 Jun 2021 11:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dYRYdsZ2hbeblvImBFJ8F8DCsk7IRZLMqL7lag1gqps=;
        b=dUtxw1LKPkhlD/tT0gGW08QN/too2PtgVp6LoxYH/4jkG52woVG+RcbBxKvDGAeb2f
         pa7cA49ThFtIVhr2Ns92Srfhwa/R2NASx7PKdjSnP9jMjITJs8AxIG9Rk0RkC4zWXIU/
         xmIVuimfdyeqDjW/wuASVGTdR2wyATAZlaSHjkbzjsaJ7VQLyIw6Je6G2t0+WfPoYFWb
         gH/wXcR341wD7wUNiLavpSUDDzemutKTO1f1kH7/gKKmfzC2u2t1fAj6/Pe/jwmSjzwp
         S9NF4/lEC6m6/GYOvdmR6fYLXL1No28IdAvm8xnM32UnSnu8WSUQLxk9ZNZfGuC9xSAr
         ylnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dYRYdsZ2hbeblvImBFJ8F8DCsk7IRZLMqL7lag1gqps=;
        b=ZS1XydZRowR6cPTN7EDF5372lCeJUP+DCDcOG/P7IvnsrRHng47+vzn1Qo6vAvxOlh
         9BCQXgo+VeKLfGZ0OcQ+Xbog52BC9XC41JdyYnsK/qGSzMYkcJ/+xADiAy7qAi0yYvv2
         MIsSVT2wha8xyOWT1tpTXeluXmq6PEiOGeDHAQz+E6m+1pJWWCydGhwti/YMfqSwvB3s
         BRxZ1OKgsVfR0PwgLfFhfWJ2ShGGhH+3DrbdvHJ/U3EzEY2SozV2w145YxIm2szePG1m
         HYKIFiPy10yHyWeg9yQ8T0fcuk8/3WIsQp0E9QwHHMYHnjtNU1wWNI+3qvoEzVGRkvjJ
         4RLA==
X-Gm-Message-State: AOAM531N/f4N6wqSobhliLvUTJfwzjvzbgfcic0acWtpLcTw0zFmzVAx
        sCEjSt+SXn6HFopyEPJU1sqTNpZDHvXaQw==
X-Google-Smtp-Source: ABdhPJzeOWhm376iJfu08xXUOvS5L91rf4+/u/f3MVex5h5trFBSaCXcY3P8tdVqc+hQpL8NEPzd6g==
X-Received: by 2002:a4a:3904:: with SMTP id m4mr10282623ooa.61.1624040791870;
        Fri, 18 Jun 2021 11:26:31 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id q9sm1862414ots.1.2021.06.18.11.26.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jun 2021 11:26:31 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 38/45] completion: zsh: add elements individually in __gitcomp_opts
Date:   Fri, 18 Jun 2021 13:25:11 -0500
Message-Id: <20210618182518.697912-39-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210618182518.697912-1-felipe.contreras@gmail.com>
References: <20210618182518.697912-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It's useful to specify specific suffixes for specific words.

This will be useful later on.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.zsh | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/contrib/completion/git-completion.zsh b/contrib/completion/git-completion.zsh
index 3818291950..a4b5e7dcc4 100644
--- a/contrib/completion/git-completion.zsh
+++ b/contrib/completion/git-completion.zsh
@@ -67,11 +67,10 @@ __gitcomp_opts ()
 	[[ "$cur_" == *= ]] && return
 
 	local c IFS=$' \t\n' sfx
-	local -a array
 	for c in ${=1}; do
 		if [[ $c == "--" ]]; then
 			[[ "$cur_" == --no-* ]] && continue
-			array+=("--no-... ")
+			compadd -S " " -- "--no-..." && _ret=0
 			break
 		fi
 
@@ -83,9 +82,8 @@ __gitcomp_opts ()
 		else
 			sfx="$4"
 		fi
-		array+=("$c$sfx")
+		compadd -S "$sfx" -p "${2-}" -- "$c" && _ret=0
 	done
-	compadd -S '' -p "${2-}" -a -- array && _ret=0
 }
 
 __gitcomp_nl ()
-- 
2.32.0

