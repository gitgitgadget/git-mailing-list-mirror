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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31D3AC433DB
	for <git@archiver.kernel.org>; Fri,  1 Jan 2021 02:17:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08AB6207A3
	for <git@archiver.kernel.org>; Fri,  1 Jan 2021 02:17:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727459AbhAACRw (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 31 Dec 2020 21:17:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727454AbhAACRt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Dec 2020 21:17:49 -0500
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com [IPv6:2607:f8b0:4864:20::c34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C335C061799
        for <git@vger.kernel.org>; Thu, 31 Dec 2020 18:17:34 -0800 (PST)
Received: by mail-oo1-xc34.google.com with SMTP id j8so4618892oon.3
        for <git@vger.kernel.org>; Thu, 31 Dec 2020 18:17:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=B1FYoRpFcoF33bKgRLyqkfp+Jx45zTJpsKSLgqZ44Ag=;
        b=Gp/CMQGWAN2dK+vSN6x3njGUlOA381F9MepDMv4WogB8J0emtFvg9yycmXtvMbtyyI
         1DDWVDMYsNybiU1TUSChg3sNorMhdpAdVVMPNYyzDi8ybcT/wGBCeMB3xRdWuiYGnoOC
         agHD4HLFhNjsc5sZDJR6Y6CMCZYzqP+nPKCyMamO/reJJ9aLeyiVXPjG8skJ7gcaiVKl
         IrmfftWdPbfQaQwezvAdmK7w7GjqEOgSUYaNKnwrM3LAr21CLMVSCEx3qEJWYCfDYsab
         fwABuEgtMKvS2vnHnu/JvKWAuCSckWVLgSnaNdXhosafzru+uOfxKo+7+6xvoc3/BHkK
         r6tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=B1FYoRpFcoF33bKgRLyqkfp+Jx45zTJpsKSLgqZ44Ag=;
        b=ErE/mxyZt7DHcrlyDGl7gpxQIWrmI/IY5YwMJZ3O3GlElkwk69FY/tEXO50IZO2Frv
         F6r2rWL/G+lLSTrN5fsUrtJr4E98lfo8hgQZhFExS7Zdna42vsGLUdcx0AWSb/PQmR2q
         Z4OKqxcrIpUKvXYisGyHeWOOTg4yEp4HsjYOqMI3x656kCUi/G3hwAsdD6A+pZdAlvKn
         tpc8QHwGPrGZyySIVryyBmK6ZvSRFoqKlH98rIMLOf2Lr5MWCpx7EIz2J4VX3TGBnCQ1
         FAQTsbuB4qIjzK7VpILpD+gL+3Qd1ES79Tl+R5E4AaN1Ql+1Ir2M4SG4OQhN52F6E006
         40pQ==
X-Gm-Message-State: AOAM531QqHjLhDbWGSqarQFQ0ZLC5oR8FxMxY+8BQ8gSPVI51KougZuc
        yQOkDBMGJcoETIhy9DRa1uKae+jACZfOAQ==
X-Google-Smtp-Source: ABdhPJxqyRbN51VQbhpxmRNG0MyeDRvyD2sJyzCeBbr5ZzrRMLMyxsciIXSk9CSroAmWi5OKxRUYxQ==
X-Received: by 2002:a4a:646:: with SMTP id 67mr23857214ooj.33.1609467453775;
        Thu, 31 Dec 2020 18:17:33 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id p18sm11241693ood.48.2020.12.31.18.17.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Dec 2020 18:17:33 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Felipe Contreras <felipe.contreras@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>
Subject: [PATCH 44/47] completion: bash: improve function detection
Date:   Thu, 31 Dec 2020 20:16:19 -0600
Message-Id: <20210101021622.798041-45-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210101021622.798041-1-felipe.contreras@gmail.com>
References: <20210101021622.798041-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

 1. We should quote the argument
 2. We don't need two redirections
 3. A safeguard for arguments (-a) would be good

Suggested-by: René Scharfe <l.s.r@web.de>
Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.bash | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 4bd3e706ac..11a9433363 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -3201,7 +3201,7 @@ __git_support_parseopt_helper () {
 }
 
 __git_have_func () {
-	declare -f $1 >/dev/null 2>/dev/null
+	declare -f -- "$1" >/dev/null 2>&1
 }
 
 __git_complete_command () {
-- 
2.30.0

