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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 098B1C433E9
	for <git@archiver.kernel.org>; Fri,  1 Jan 2021 02:17:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D80D8221ED
	for <git@archiver.kernel.org>; Fri,  1 Jan 2021 02:17:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727182AbhAACRU (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 31 Dec 2020 21:17:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727173AbhAACRU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Dec 2020 21:17:20 -0500
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D56CC0617A0
        for <git@vger.kernel.org>; Thu, 31 Dec 2020 18:16:40 -0800 (PST)
Received: by mail-oi1-x22c.google.com with SMTP id l200so23408277oig.9
        for <git@vger.kernel.org>; Thu, 31 Dec 2020 18:16:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ymY2Rlte0771dXNrKZXN+QeOTQ7fo5QS011tFWGotv8=;
        b=PcU6z+NR+7fGQCTY1HxZcj2hF97S0tBgauhIFUuOoJv3nO219xzzOXX+RcC+joYCME
         BWYZHdQ3BED6CxiLPGvJpQPXHkkNy2in4/YPWS/O9b8HLOQ50wUgsHUWyTIVjtvmeTvP
         +cK3JWhofAuKuCQTFVn0xh7zXLCkHJCjSb0GBQIvNb9QefaF31+zvUbDuycqicXEx9xc
         wWRP3UyanxALgqnnmyxAILWvK5bFsKWALtiRoq/LHsWr4JB01ToO3WnsGJ5dbQ8QFG4C
         PrQuqhJobYfE8s9gnOK4UYNvli24zx02Q0ebLHNxcQxrdmw+9FsvKDZgfKvGhmy37Nzg
         EYHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ymY2Rlte0771dXNrKZXN+QeOTQ7fo5QS011tFWGotv8=;
        b=Tv/yHQsVcDQmMedbyiDtKQMMyVyLbZ+b/Phv02++1iuqXgA7bGcai9SZ686wo7hqeE
         reWr3vxhzp8zjowwENV07s7FAKUOSfOEXxRMcvYKW7+GfJ3Xuij6WKzVTgnqXfmlRHV7
         3VOtJhUSJTO6Wp2qd9bO4TZRuPUuIwB1fO4nLzCTzJtPedOi4PCSZoCaCnanUMVHzwr1
         1EKIjqbxzkpineSTP7lDJ8fARhjVEtdxxlwhD3a6P9lg/Fsrsm9N9XULDIM/9HcaGzDu
         5XS/dioFGjE3CDGuKJc6VV4ExiISCmuLq5WpzAl9Vgyi0zvT/YIvWGR01lBk6hjRx3fT
         ONuw==
X-Gm-Message-State: AOAM530IztUEoqcb+5N35ritYCIR25uoL5oRLWPjkyXQLGK3qT6BMj2/
        hbefIRuaO0BrLeRexAapuyFs4r7IDar4CQ==
X-Google-Smtp-Source: ABdhPJxvQC/mhAXldV/kbw5EcU3eWJmCO1J1CY8qDQ/A67T7Wkm9auYaTHEvj6iwimBRuItiRrYYsQ==
X-Received: by 2002:a05:6808:617:: with SMTP id y23mr9603134oih.84.1609467399421;
        Thu, 31 Dec 2020 18:16:39 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id s17sm11511449otg.16.2020.12.31.18.16.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Dec 2020 18:16:38 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 09/47] completion: bash: remove non-append functionality
Date:   Thu, 31 Dec 2020 20:15:44 -0600
Message-Id: <20210101021622.798041-10-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210101021622.798041-1-felipe.contreras@gmail.com>
References: <20210101021622.798041-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There's no point in setting COMPREPLY only to override it later, and in
fact; we don't do that.

Therefore there's no functional difference between __gitcomp_direct()
and __gitcomp_direct_append(), since __gitcomp_direct() *always*
operates on empty COMPREPLY.

The same goes for __gitcomp_nl().

This patch makes the functionality of append and non-append functions
the same.

There should be no functional changes.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.bash | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 9ea31f7d4d..92d0f91df9 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -298,7 +298,7 @@ __gitcomp_direct ()
 {
 	local IFS=$'\n'
 
-	COMPREPLY=($1)
+	COMPREPLY+=($1)
 }
 
 # Similar to __gitcomp_direct, but appends to COMPREPLY instead.
@@ -450,7 +450,6 @@ __gitcomp_nl_append ()
 #    appended.
 __gitcomp_nl ()
 {
-	COMPREPLY=()
 	__gitcomp_nl_append "$@"
 }
 
-- 
2.30.0

