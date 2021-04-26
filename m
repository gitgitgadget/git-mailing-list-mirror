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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30A70C433ED
	for <git@archiver.kernel.org>; Mon, 26 Apr 2021 16:20:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ECEAD61166
	for <git@archiver.kernel.org>; Mon, 26 Apr 2021 16:20:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234136AbhDZQVA (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Apr 2021 12:21:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234546AbhDZQUo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Apr 2021 12:20:44 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10A04C061574
        for <git@vger.kernel.org>; Mon, 26 Apr 2021 09:20:02 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id d25so19445970oij.5
        for <git@vger.kernel.org>; Mon, 26 Apr 2021 09:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=658dBV+rQOBB7RM26X6T1MZ7Pdt89BJgSwB8/raGX7Y=;
        b=rceG2/NGzuRG8gSc5yySSd0Nqf86U3oOqxxrDbFl0y3ljklauXU+5oQRBRU6Zn+VVQ
         0682mMo08X3qfqtQXerK/J0qk9RZQ0DjAD1bx6+MjT+gjeu2N+A7aLXTpRMFP1wdUU1D
         O9k+XZ5K4MJRgVNPWH9aJgQ1W0s8xm7XLONlxOwXE/H2+rkmAPVoRvbbAkDl88jTH/X3
         LhmKxghGDSH2aZRc9oQPLTFDiMIiF3b8yX507cX5q2Y83YSX/YFBPvraNdm1Oxp/xKPr
         pMHubIOsAaKF/rXzk14reXDiQLakigHOPfxfL4aM8NlWsUEpAIg+h36X0uxTIkFcAxzM
         8Jow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=658dBV+rQOBB7RM26X6T1MZ7Pdt89BJgSwB8/raGX7Y=;
        b=lE5mYp4nAwak1oZQWpHmL+QYz5vZpHV6cZFFmSWQTA1syW5jltp006zn4JNu0SMGz6
         OL71gjJvm23smItqP1seY0QbM3mdWnF1NOqC5JLWMMTskpnfveR4F9R6OPV/k7lFd9gW
         AodQjYbN1MW95jt/JR4yHv/KWIX98y5UtANd7cYHOqI+8h6x/rux6c+W1kaF74ZLV3fd
         t1AtbuoCMzeZHYaf8NO7EPxcSlPZEFSXFBecTWKrIbGbbm44Tn5C9VEJPiWAbfOUtvBB
         PAFVbsBPthAbKbncqENHf0mio6FiE3sc4YZU8iP4XG+M+v7LdiO5KZmcu4wwezXcqe2a
         79Iw==
X-Gm-Message-State: AOAM530xdY4KY7y0QAalZyGH8Xn0XOrfLrV5NKc4BA6ObCVjtgTAnRxI
        +Qb+UDZ+M0BCkoa6ZG55HyPB2fJyAmgw/w==
X-Google-Smtp-Source: ABdhPJxeY/gltBSDbEcYbbATR9sR4RM4f26LPpWouhYThfm2BpI8O4ct+bw2roWzl4xnGOq1y2ZHWA==
X-Received: by 2002:aca:f553:: with SMTP id t80mr13726692oih.149.1619454001264;
        Mon, 26 Apr 2021 09:20:01 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id f17sm3606617otf.11.2021.04.26.09.20.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Apr 2021 09:20:00 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v1 36/43] completion: zsh: add __gitcompadd helper
Date:   Mon, 26 Apr 2021 11:14:51 -0500
Message-Id: <20210426161458.49860-37-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210426161458.49860-1-felipe.contreras@gmail.com>
References: <20210426161458.49860-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

So we don't have to do the same over and over.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.zsh | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/contrib/completion/git-completion.zsh b/contrib/completion/git-completion.zsh
index 82a4d6f470..4e9699f542 100644
--- a/contrib/completion/git-completion.zsh
+++ b/contrib/completion/git-completion.zsh
@@ -49,12 +49,16 @@ COMP_WORDBREAKS=':'
 GIT_SOURCING_ZSH_COMPLETION=y . "$script"
 functions[complete]="$old_complete"
 
+__gitcompadd ()
+{
+	compadd -p "${2-}" -S "${3- }" -- ${=1} && _ret=0
+}
+
 __gitcomp ()
 {
 	emulate -L zsh
 
-	local IFS=$' \t\n'
-	compadd -S "${4- }" -p "${2-}" -- ${=1} && _ret=0
+	IFS=$' \t\n' __gitcompadd "$1" "${2-}" "${4- }"
 }
 
 __gitcomp_opts ()
@@ -69,7 +73,7 @@ __gitcomp_opts ()
 	for c in ${=1}; do
 		if [[ $c == "--" ]]; then
 			[[ "$cur_" == --no-* ]] && continue
-			compadd -S " " -- "--no-..." && _ret=0
+			__gitcompadd "--no-..."
 			break
 		fi
 
@@ -81,7 +85,7 @@ __gitcomp_opts ()
 		else
 			sfx="$4"
 		fi
-		compadd -S "$sfx" -p "${2-}" -- "$c" && _ret=0
+		__gitcompadd "$c" "${2-}" "$sfx"
 	done
 }
 
-- 
2.31.0

