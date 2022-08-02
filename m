Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42D8EC19F2B
	for <git@archiver.kernel.org>; Tue,  2 Aug 2022 21:41:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234785AbiHBVln (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Aug 2022 17:41:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234211AbiHBVlk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Aug 2022 17:41:40 -0400
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com [IPv6:2001:4860:4864:20::33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC21C140F3
        for <git@vger.kernel.org>; Tue,  2 Aug 2022 14:41:39 -0700 (PDT)
Received: by mail-oa1-x33.google.com with SMTP id 586e51a60fabf-10ea7d8fbf7so13506473fac.7
        for <git@vger.kernel.org>; Tue, 02 Aug 2022 14:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=IhCWye945A4XmVVuVAk2VgYttRGu4+5PKrVE94+/IDo=;
        b=CUiDHr3RT5CWwJgi4p1qXkTeRULfp8hHQdhXPag68PkVbLlM76yMWK2osvFiVgMoZQ
         GVn1GQhlEd2/63+6xz11ZEzgY1UW7kebpXE4Oczow62VD1VmipJms22v3qdpNnMTKUZQ
         s8zCvRHwfaWAN374DUp6qF2Fj7J6XRhY4EuwzcFOUalm7rRULUHiIfKuBplZIZhOeznU
         ZW2dR9e6PyabdprpeXtTmS23uL3rmh4n66K6dm3Y/RXOGbj6XM1gWWbOCTGMj/O0YeWb
         AnhVMOIJMa2SHkqk0qlHe/eVJ8Ml1GXVxK8W30DEwq1RrFTrAI3jKt44s2iMtF0+RUAb
         Ml0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=IhCWye945A4XmVVuVAk2VgYttRGu4+5PKrVE94+/IDo=;
        b=ht11E4vlneP6THoC8CqluN6VSFgiSx9DruI74tc0MaSw3MoB2L+W5MsY5mJpZwgwwU
         /GqbnfIu57ZlikXvSL9pKI+/85KL7hQNsldxkmnGfCA3hauAIoKUBlWmmgWZjepbhhHU
         09KGlkXd0D8uGyg4ThgwTeGueEB60uuc3fO7fyYhQU0QW+NgvxBoMhjYebEH1ipKT08z
         CIfph3V82/Fz1Ksn5E/uE2UwhsRv11s9fiKgrqJ7WLSzS1YNwAH1YAZ9w7HUOcG87Z49
         FtSRMUDERcutNLxQWCZ/86aBrx9ace5PKK8/yc6Qn6lwHB6RGN+AfHG1Q8JpvIvU0zR8
         kFBw==
X-Gm-Message-State: ACgBeo2cknex1Kci+7wEqow3gUZvGirEB9Nrft8m1LCYyqEcTeDI+FDR
        naYxg2zcX7mjYeBo2Bn6Xvt26x2gumU=
X-Google-Smtp-Source: AA6agR4HXjiM4uG4O7jy45K5Gh+Ozg3eSDLr0xj7x7lSa4AFkYosdy3W+Tm5kdQ+davMEZJrB9cAQg==
X-Received: by 2002:a05:6870:32cb:b0:10c:289b:76ba with SMTP id r11-20020a05687032cb00b0010c289b76bamr661781oac.72.1659476498794;
        Tue, 02 Aug 2022 14:41:38 -0700 (PDT)
Received: from localhost ([2806:2f0:4000:5c95:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id z9-20020a05687041c900b001048f70e03dsm4073330oac.15.2022.08.02.14.41.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Aug 2022 14:41:38 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Fernando Ramos <greenfoo@u92.eu>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 2/2] mergetools: vimdiff3: fix diffopt options
Date:   Tue,  2 Aug 2022 16:41:34 -0500
Message-Id: <20220802214134.681300-3-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.37.1.313.ge269dbcbc5
In-Reply-To: <20220802214134.681300-1-felipe.contreras@gmail.com>
References: <20220802214134.681300-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If either closeoff or hiddenoff are enabled, vimdiff3 doesn't work as
intended, so turn them off.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 mergetools/vimdiff | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mergetools/vimdiff b/mergetools/vimdiff
index f4c3bf6d11..baccabc403 100644
--- a/mergetools/vimdiff
+++ b/mergetools/vimdiff
@@ -395,7 +395,7 @@ merge_cmd () {
 		else
 			CMD='hid | hid'
 		fi
-		FINAL_CMD="-d -c '$CMD'"
+		FINAL_CMD="-d -c 'setl diffopt-=closeoff diffopt-=hiddenoff | $CMD'"
 		;;
 	*)
 		case "$1" in
-- 
2.37.1.313.ge269dbcbc5

