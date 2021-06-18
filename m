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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6170BC49361
	for <git@archiver.kernel.org>; Fri, 18 Jun 2021 18:26:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C47B613F2
	for <git@archiver.kernel.org>; Fri, 18 Jun 2021 18:26:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236402AbhFRS2z (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Jun 2021 14:28:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236361AbhFRS2h (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Jun 2021 14:28:37 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CFDDC06175F
        for <git@vger.kernel.org>; Fri, 18 Jun 2021 11:26:27 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id 5-20020a9d01050000b02903c700c45721so10584641otu.6
        for <git@vger.kernel.org>; Fri, 18 Jun 2021 11:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hMQbZWO74UAehI1PYSRscHwSL7VdobUcxTzqxMSnjYE=;
        b=XIh0LFCxXekEncmNLvOeTHDqODZDlU7KO0xMOo29/xVuCh4f62/AIboLXD3nIXx+AH
         YeMddwZIANpF309mI9srSMT/iUYhtXscd25fv8SsOXIVRcdV8uRvtVqfuH3oXHaWQsH8
         OUF1f8MZpLX8ftT/lhleRPlN+pSGXKjT5hBz/3u16riy2ieyfjz/s3c57sLAD65NEmtC
         6mMHI3ubJVaIfH3gvLOiH4JxDUq8lib0ZznDTyVcPmukifNKFH8ol+Np/zf9y2jEpuH8
         BjGLvhqwoyK79RJXeuF0hG4AL8Hij9IQrnqoklxTkqp3FOGrlJvTItWlkbQZzKB5rzrr
         /yaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hMQbZWO74UAehI1PYSRscHwSL7VdobUcxTzqxMSnjYE=;
        b=ghe0QXjZo+IV7fesYM2bG23tpXlnFoVM3dBrtFvncetqQu5R1pClaja3/5JZ+gdBi8
         vOjgpLHuRDp3JXJaVWkxlmcY1K7ke3rjag47zqWncjfbD9kPjpXIZ8c138ikGe/pku7e
         8YybQRhs5hMcoCrzh4ozOE177p8IZVsyOOoHbZPrF1eRl9iF90LQMAOp8RsfKJrAbBut
         3DRm0s5MaFdfJ9MTF7pu6FPf7D3HF2gY8DWvZqJh8OQFBe2WypdvAzSaTbJ1W4NQuRSW
         5MSjPw2wi/hKiDgPIytyhjmkY1m4U1Sz29vcF+UObt5LCCN1PNqQFKhr81Xf2y6hulLK
         2yZw==
X-Gm-Message-State: AOAM532dW59vG+JMPj4DIziSovv0skQW81+lJ2NONoqklL0H6nQ3YfyG
        /cLO6e8EHG+v21hpVgu874MEw+pgiIasSg==
X-Google-Smtp-Source: ABdhPJw7XFiwOdhU/92RxJug9G9M6pEnhlnzS7kIVtyE9ynZ5O4NwDAes8y/7O3BEvx/WojjluRmyQ==
X-Received: by 2002:a05:6830:181:: with SMTP id q1mr10708032ota.360.1624040786588;
        Fri, 18 Jun 2021 11:26:26 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id e29sm1982127oiy.53.2021.06.18.11.26.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jun 2021 11:26:26 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 35/45] completion: zsh: simplify __gitcomp_direct
Date:   Fri, 18 Jun 2021 13:25:08 -0500
Message-Id: <20210618182518.697912-36-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210618182518.697912-1-felipe.contreras@gmail.com>
References: <20210618182518.697912-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Not much different from __gitcomp_nl.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.zsh | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/contrib/completion/git-completion.zsh b/contrib/completion/git-completion.zsh
index e515f464ab..bfb5c38a3c 100644
--- a/contrib/completion/git-completion.zsh
+++ b/contrib/completion/git-completion.zsh
@@ -90,9 +90,7 @@ __gitcomp_opts ()
 
 __gitcomp_direct ()
 {
-	emulate -L zsh
-
-	compadd -Q -S '' -- ${(f)1} && _ret=0
+	__gitcomp_nl "$1" "" "" ""
 }
 
 __gitcomp_nl ()
-- 
2.32.0

