Return-Path: <SRS0=tbmj=EA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0339C4363A
	for <git@archiver.kernel.org>; Sun, 25 Oct 2020 03:14:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A04AA20936
	for <git@archiver.kernel.org>; Sun, 25 Oct 2020 03:14:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QYjafKpJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1766848AbgJYDOG (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 24 Oct 2020 23:14:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1766837AbgJYDOG (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Oct 2020 23:14:06 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8F88C0613D2
        for <git@vger.kernel.org>; Sat, 24 Oct 2020 20:14:05 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id k3so4535434otp.1
        for <git@vger.kernel.org>; Sat, 24 Oct 2020 20:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DXiYcWh3hiY/S4WM7hZoTPrcumnh/IZyKZfCrgKGXBg=;
        b=QYjafKpJwCm0Dym5H/q8adWPUIvpOgJukaNEidZU4Qn45di1j9ozOdadYbgs+MztEs
         pQwB0+d2rFXcBvEkxlLriweVnQFzRFqX+ZTAseVz8Z0+gej4Izes5z8BMCIZZGn3qfUi
         HQQuHQ/+2hdoDfT+w9no6dLstvmeU4i+mj29O7eNT6r+W+sQZFwKD+QcGHhTp7+V6TPn
         +yVM1htC0Q1xDEUJP8Y1/dH4nmPomOMH/BNcjpF7BOm5Yovi0UDSRiF17HPRmgvALu6/
         cvbSomtqKAggtTIoc8+sZ0aCmVlBPBR91R0A8/UPWpMkeAIXwE5zWiEF7mEj030qnF96
         YH+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DXiYcWh3hiY/S4WM7hZoTPrcumnh/IZyKZfCrgKGXBg=;
        b=BR/04LVvRUR9QmJM/HJB6oPHUNHiRGbGmeAlujWaZ5guzGSfx+dpLEXr9fnsG/c0f6
         fyq6Ef+wbclsll1qgwuTTCjMWpOfm8jnrJgVwDuF/juBe3Qh5ReZq+H/pYKGqphpr0pF
         7oKuVs/8FEMv+qa5iI2QZcQaFTIRP8CF/8MokgF06ReDVEb2myhKQq1aTwpqejMBeFEk
         NcRMqsu//kxK4jd5dEMgTP8yBUB07iRivv/yJZnMGv/eD1ITN46r2rMUd0sjek5ZN61M
         IVW9hzaYLGVTB1bGtHO2IDVBV4ZwwcIEDVBXWKgg2AE2Yk6GiF5P7O4Gg3PzyDay6Fwd
         oRLA==
X-Gm-Message-State: AOAM5304rr4tM8ltCZJ0ppR9sky0q2raAVwv5KhS7knJUNT2exnbYPbp
        74vNjXVmOmoc0PnK86MCRvOzCcQalduZyg==
X-Google-Smtp-Source: ABdhPJzyG+KrnMucCngNnKH5gSCIDq5qZr0rV6EQ7a6ycAmwl46Jr/Mp6d7fRN8FeQotIGK9Qm8SnA==
X-Received: by 2002:a9d:5cc:: with SMTP id 70mr8916604otd.34.1603595645090;
        Sat, 24 Oct 2020 20:14:05 -0700 (PDT)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id b7sm1840328oic.36.2020.10.24.20.14.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2020 20:14:04 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 13/29] completion: zsh: add missing direct_append
Date:   Sat, 24 Oct 2020 22:13:27 -0500
Message-Id: <20201025031343.346913-14-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20201025031343.346913-1-felipe.contreras@gmail.com>
References: <20201025031343.346913-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Commit 688077910b forgot to add the corresponding zsh function.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.zsh | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/contrib/completion/git-completion.zsh b/contrib/completion/git-completion.zsh
index 1de9b9c80d..13c6bd5c12 100644
--- a/contrib/completion/git-completion.zsh
+++ b/contrib/completion/git-completion.zsh
@@ -98,6 +98,11 @@ __gitcomp_direct ()
 	compadd -Q -- ${${=1}% } && _ret=0
 }
 
+__gitcomp_direct_append ()
+{
+	__gitcomp_direct "$@"
+}
+
 __gitcomp_nl ()
 {
 	emulate -L zsh
-- 
2.29.0

