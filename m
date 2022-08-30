Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66E77ECAAA1
	for <git@archiver.kernel.org>; Tue, 30 Aug 2022 09:34:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230000AbiH3Jeq (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Aug 2022 05:34:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231971AbiH3Jdl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Aug 2022 05:33:41 -0400
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06F12E343B
        for <git@vger.kernel.org>; Tue, 30 Aug 2022 02:32:48 -0700 (PDT)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-11eb44f520dso11116972fac.10
        for <git@vger.kernel.org>; Tue, 30 Aug 2022 02:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=ZzPrzCgtMa+zxt2GO2FhyxlV1r0KEBZJC0JeSY0yM4I=;
        b=GAHhGFc+rf5HSngJx89X55pviVm8K89eQhHCw4l6Sx+S0uiqGiouEAmgmQ0dFilLMq
         A3AlozS2zaD2aTTLAKVYvd2l2rBNowV8CezG1tKNYGV4BZgpWRRpo6SXNIE2W269epiJ
         nzAahYI3A7dEAV5nxYD6RFHfSKxlWUa6GHN1lrPCE7ltjnVVtIdTYi/gRVs7twbYQkTH
         r+Q/KRDRpC9xTpq6FLojgTi0b22JP0k1ElnyljQJ9EMQJ398oi2c4b19/eToOmjzsrLW
         jH+sqkErytosKLvodWmpgSKa5acVWjSe0THihFNr1Y35zA98el5Kq+m92/Hfo0njOVuJ
         1hjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=ZzPrzCgtMa+zxt2GO2FhyxlV1r0KEBZJC0JeSY0yM4I=;
        b=akRXKDXmrYUrKRJzsPkU82gA/k3fqVCYJCKoxwNu/1ueBlYi94bng6tLScqv6eF9wS
         WdQrRrGPnxlqJyso/DZc959E3MsVSHnpy9eEVkhgnOp9y/etJxEEvsqfRZXBKjo0NHLA
         Syistsx4gKjr4cWdy22ke2ea+FB7t7g8LnUV4xls4Bgnf8bROJMIWQMHu8c5830qytgR
         jPcVDl1teFhh/vQoNJ6n2qfBPv2d7xSl3aixf++GrnJL1KexXrthRQgm+0DNNrdHpyOx
         TO0f7qStXlTPAJ1Wcni11Cm9/SoPbDv99GgDk+jK3w+7aFUB95RA9vNvydmsMuQraeK7
         z++A==
X-Gm-Message-State: ACgBeo3kWYZUQ4jNn6/ugKEqCTjR64CSBXBYX5XCSukhvZSjsqQrRRoO
        eB3bGYfPiwNL7mjZuf/5BEwW3FHiD4Y=
X-Google-Smtp-Source: AA6agR5GbGeZDwDF8jkaIvSH9k6EOUG30kH2pjs2syXGKKYkiztcefML68s0S+dGPeRwQrXAlxOTqw==
X-Received: by 2002:aca:1901:0:b0:344:d4b5:9a1f with SMTP id l1-20020aca1901000000b00344d4b59a1fmr8722184oii.170.1661851966714;
        Tue, 30 Aug 2022 02:32:46 -0700 (PDT)
Received: from localhost ([2806:2f0:4000:eec:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id n6-20020a9d4d06000000b00636c81d4109sm7319586otf.46.2022.08.30.02.32.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 02:32:46 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     git-fc@googlegroups.com,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 39/51] completion: zsh: simplify __gitcomp_direct
Date:   Tue, 30 Aug 2022 04:31:26 -0500
Message-Id: <20220830093138.1581538-40-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.37.2.351.g9bf691b78c.dirty
In-Reply-To: <20220830093138.1581538-1-felipe.contreras@gmail.com>
References: <20220830093138.1581538-1-felipe.contreras@gmail.com>
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
index 2ad24f1510..3619c93ea9 100644
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
2.37.2.351.g9bf691b78c.dirty

