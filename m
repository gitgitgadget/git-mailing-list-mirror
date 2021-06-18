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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6524C49361
	for <git@archiver.kernel.org>; Fri, 18 Jun 2021 18:26:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1737611AC
	for <git@archiver.kernel.org>; Fri, 18 Jun 2021 18:26:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236368AbhFRS23 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Jun 2021 14:28:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236342AbhFRS2V (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Jun 2021 14:28:21 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C77DC061760
        for <git@vger.kernel.org>; Fri, 18 Jun 2021 11:26:11 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id 5-20020a9d01050000b02903c700c45721so10583854otu.6
        for <git@vger.kernel.org>; Fri, 18 Jun 2021 11:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=q/OXb2rTEpjHV5GGoPu9u3B8HTDEI05r3wIZLjVDxQg=;
        b=sXeP6S7T8PjLSoECvDXlmh5rK9ilKSu8PPDNec+snxlJLFB01k8rgdp+pu1+UV6tDQ
         uxlPhiDDqVu9qNFUdfLRKkLgO50wC0Yi+BfOWlk6fznj9+0ot4sbNltgD0HYDtI9+uSn
         m25l9hfOu8Abc7o62q4lL62HbLnAnqU7eTUQwhcAPWnq1vy9RpvOsYBf4cSCgtg+ILaS
         WqE+lFmX88hLgdYaQ2j14Zck50MdshvRoyutRTMCyDGrvsdSqHqH6jBwyCEYIx0iMN19
         FjEJUnhSq/nXiq88irVrszdN/JLa/PEyH4ROzdjhS9p/HOIm53UU090Z28o1j7s+RZqE
         2A+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=q/OXb2rTEpjHV5GGoPu9u3B8HTDEI05r3wIZLjVDxQg=;
        b=DGrDV5pNsTx3/bPMF4proinsVF/GTSMJororY++V+18T9JI1WigINLzgwC/wancAoy
         XqMnK0YexyO8K0+vpqJouJmiv8OCpdpVQDwx23qH8Z/jgAMlCxUy+gxYnGLAc4Aa2PDS
         Fso2Qo+ovzKLkKMA0U3vLBWhjzi8Gn/b3zZiAcY9jrzRBxVrmRbuKvDili9X1bIlkdtT
         UfZtGyhPc6F+WSPeBPRkAkyiIgK/flw2ZdS5soXPyAsihgF2PPZe8kDEJdiniFnCGrtF
         1TAmhqXYl3tU/+38+hdYnJKVO6QyHH7wM3I+0mRB0Zkf5dqMrQdME5Mg16AWcpoaN/40
         8D0w==
X-Gm-Message-State: AOAM533orJ3sVhBwknWhGJB5ctDFdXJ6hwrA9QcgfGrpHs8bNWEWQQLz
        X8ouDTjSZwuyBN66ZYvRkgZoqFcMQos3uA==
X-Google-Smtp-Source: ABdhPJzhXAt+2bnTcyP6C2K39IaB5z8rfXooilUQdriKXtM/myOcxDznidN9mQ8PcKQhnRVUVJ3lCQ==
X-Received: by 2002:a05:6830:402d:: with SMTP id i13mr10292867ots.46.1624040770624;
        Fri, 18 Jun 2021 11:26:10 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id w20sm2183799otl.51.2021.06.18.11.26.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jun 2021 11:26:10 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 26/45] completion: simplify __gitcomp
Date:   Fri, 18 Jun 2021 13:24:59 -0500
Message-Id: <20210618182518.697912-27-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210618182518.697912-1-felipe.contreras@gmail.com>
References: <20210618182518.697912-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It's not possible for $cur_ to have anything more than --no- at this
point, so there's no need to add a suffix, nor check anything else.

All we are doing is checking that $cur_ matches --no, and adding a
completion if so.

This way the code reflects what we are doing.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.bash | 5 ++---
 contrib/completion/git-completion.zsh  | 2 +-
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index b4b778da0b..ebf8df94e8 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -341,9 +341,8 @@ __gitcomp ()
 				continue
 			fi
 
-			c="--no-...${4-}"
-			if [[ $c == "$cur_"* ]]; then
-				COMPREPLY[i++]="${2-}$c "
+			if [[ --no == "$cur_"* ]]; then
+				COMPREPLY[i++]="--no-... "
 			fi
 			break
 		fi
diff --git a/contrib/completion/git-completion.zsh b/contrib/completion/git-completion.zsh
index c7e4de15c6..6008a73816 100644
--- a/contrib/completion/git-completion.zsh
+++ b/contrib/completion/git-completion.zsh
@@ -63,7 +63,7 @@ __gitcomp ()
 	for c in ${=1}; do
 		if [[ $c == "--" ]]; then
 			[[ "$cur_" == --no-* ]] && continue
-			array+=("--no-...${4-} ")
+			array+=("--no-... ")
 			break
 		fi
 		c="$c${4-}"
-- 
2.32.0

