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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42D8EC433DB
	for <git@archiver.kernel.org>; Wed, 30 Dec 2020 23:30:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0EC93207AB
	for <git@archiver.kernel.org>; Wed, 30 Dec 2020 23:30:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726390AbgL3Xah (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Dec 2020 18:30:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726356AbgL3Xah (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Dec 2020 18:30:37 -0500
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 101B1C061799
        for <git@vger.kernel.org>; Wed, 30 Dec 2020 15:29:57 -0800 (PST)
Received: by mail-ot1-x332.google.com with SMTP id w3so16792661otp.13
        for <git@vger.kernel.org>; Wed, 30 Dec 2020 15:29:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aCMgXY3vpMqUcC3T7M7K4A9kovLqoa1ejdPojoT23z8=;
        b=A128VblPAZm/Sb1wvtYye7bXzVlzzPMdIWvS11nK+kTww7D79M+xKwbbVcueJ68dLg
         ceLSav+dA+9P5XD8/Amo3636pXDH1o0qS3Vn5VCAXT2nKBG3Ywz9+UCRaBKIASBlTq1V
         0VEcDy6o1JUIpWBL3B3NRvZlZIWdL1M6BuROBp7wVviYQX8Q+VPBHJaPSP5NwwX1PPus
         G5IMI9rOMgomxWeerUarSHqEpm2LvDkbS8ZXTVe02nSDrQqMSXo0kwx3bxGf3q1BQ5UV
         0YVTKzrIOQT6+1lz/w0JwWkoffIDmkE9sCqcjFCJjok56d7HmwZ6AQDF0huq4dCc+HeS
         n/kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aCMgXY3vpMqUcC3T7M7K4A9kovLqoa1ejdPojoT23z8=;
        b=MV9WuCx5cwu7bdKG91htrj0T/BIpZbCzQ2Xf0GBgCUOI2OSLLIeNP+V/v/zfAiKOfN
         4dn1LnATZYqoKq37E3lG3FZnv6cXbYLuC/PN/rk0EjSgN3NKc4+K08Cq4n0A2lfp6mJp
         Um2Ci02PYeW66TWWA3sw0oyBNzd1SdkoTCfuPDcjtEh4cEoyTPYR2kO0kKswZrtyF4hF
         9K3l/e2+YutWHTZl9LcZ8C9QxsGRUaqDni4khBHqlGh5HzCeniK0tg88wXg1Jda86PUn
         /YfplgDVN8gNtRlBuKDIxbHUzWrFeixOqJL+e8MtdA/+IVy0ele1agWG+Ym2/4UHCKYv
         KE6w==
X-Gm-Message-State: AOAM533nQINAB8+BJfYPR87Haa7m5hraN280PpspSwO+jIueNLvoYq/r
        6NyuF55jHPynaUBlus/wWmbENPLLGx7zhA==
X-Google-Smtp-Source: ABdhPJyEiC7Z8B8hshvw9HB+lZLgU3+qvN8wyQxW9I4iynfFMD+5M7yQ6vkEc3/pWhmE0Ape5asQzw==
X-Received: by 2002:a05:6830:19ca:: with SMTP id p10mr40738516otp.233.1609370995581;
        Wed, 30 Dec 2020 15:29:55 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id h7sm10907457otq.21.2020.12.30.15.29.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Dec 2020 15:29:55 -0800 (PST)
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
Subject: [PATCH v3 2/4] completion: bash: improve function detection
Date:   Wed, 30 Dec 2020 17:29:48 -0600
Message-Id: <20201230232950.582152-3-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20201230232950.582152-1-felipe.contreras@gmail.com>
References: <20201230232950.582152-1-felipe.contreras@gmail.com>
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
index 869c73ee2c..1150d4bf44 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -3359,7 +3359,7 @@ __git_support_parseopt_helper () {
 }
 
 __git_have_func () {
-	declare -f $1 >/dev/null 2>/dev/null
+	declare -f -- "$1" >/dev/null 2>&1
 }
 
 __git_complete_command () {
-- 
2.30.0

