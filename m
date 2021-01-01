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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5244C4332D
	for <git@archiver.kernel.org>; Fri,  1 Jan 2021 02:17:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B4D020798
	for <git@archiver.kernel.org>; Fri,  1 Jan 2021 02:17:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727134AbhAACRL (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 31 Dec 2020 21:17:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726991AbhAACRK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Dec 2020 21:17:10 -0500
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45F8CC061799
        for <git@vger.kernel.org>; Thu, 31 Dec 2020 18:16:30 -0800 (PST)
Received: by mail-oi1-x22b.google.com with SMTP id p5so23417829oif.7
        for <git@vger.kernel.org>; Thu, 31 Dec 2020 18:16:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XV66PYLAoYbo9SQT/Bl93HeJm88nu+fl3OIN/+cOdmY=;
        b=tllh19GAdExcP+Bsu6jzAXYfo/T9R5j00L/eoknW6DQWk4qh6gwSXRQKTlReUpmlaw
         dVFD/TbopiMNYlyJuoEqOlyPWuhRiUF4nCxKWIeVAUQV3+VPIifkTKOwzCPU4s9oFunb
         VS+4+a9xeQReSf0/jcvHL039h+aFPZLoVfSk9t09X+nSQsIManBMKTzzHLAR55MTMApn
         GCCpzqXSBjtSSCMIaMwzdbMbBTUd19vZ58OmsLizS3jvx9o0AWUZ6/1XSIj1Vp1Fx1RM
         KICZMy0USuJFumlhQL1HcnwpsiGUoy3j0HcgrCRHvkY84/QbsTcPb+hTUS/Dqs/H9dtg
         tv6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XV66PYLAoYbo9SQT/Bl93HeJm88nu+fl3OIN/+cOdmY=;
        b=qSGP+o2sPstEjzcyVumPYzzV7PLbbpfrWe2DAmDjbEL20LLAyEp2ti1MCPxhqxViWr
         /dUgdiMVHAWmXqV1UY0D3pR2oZAn52Isv2denxQnCq6QDjCxYGCeqWzbSQzznlahBXIF
         YxnGKrrOF8KsUiADZvypR7LbHOqXlFernmMgrcra2yJA1f/fPAMKuaROzm6wyWKT1y3A
         5aN6SENKEV0gk9TFnNGQf6qYrjHZVXNLidzJUUVzdkacTnMG8AZ14RUVUvXD2j5PlziK
         CAiuwUCZCbaUZkQccJQIK+eLREePHS9H5RdJ3B/VNUcHJ8Oz7Cqtg78XLmPb8ydL2IdI
         Kjlw==
X-Gm-Message-State: AOAM532TMtLAkmUM7J9EtQnbOMCftLsgK1sJr8NjSC5+M7juV1EyfpVm
        gX9WraMaauTd7qPpRxz6rHFVbmuJiHqmLQ==
X-Google-Smtp-Source: ABdhPJwB3HDy8jK4nOw+9h4wY5Eax7OzurYufPIhdcnBcS5CRAYaltAjgr4kMJQ8mF2UACRKTjBXFQ==
X-Received: by 2002:aca:c5c8:: with SMTP id v191mr9438715oif.67.1609467389541;
        Thu, 31 Dec 2020 18:16:29 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id r14sm11764214ote.28.2020.12.31.18.16.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Dec 2020 18:16:29 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 03/47] completion: bash: fix for multiple dash commands
Date:   Thu, 31 Dec 2020 20:15:38 -0600
Message-Id: <20210101021622.798041-4-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210101021622.798041-1-felipe.contreras@gmail.com>
References: <20210101021622.798041-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Otherwise commands like 'for-each-ref' are not completed.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.bash | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 10e69af9ed..64cf35ba04 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -412,7 +412,7 @@ __gitcomp_builtin ()
 	local incl="${2-}"
 	local excl="${3-}"
 
-	local var=__gitcomp_builtin_"${cmd/-/_}"
+	local var=__gitcomp_builtin_"${cmd//-/_}"
 	local options
 	eval "options=\${$var-}"
 
-- 
2.30.0

