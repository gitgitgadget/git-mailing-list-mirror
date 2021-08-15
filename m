Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13DD7C4338F
	for <git@archiver.kernel.org>; Sun, 15 Aug 2021 17:18:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D91FB61208
	for <git@archiver.kernel.org>; Sun, 15 Aug 2021 17:18:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbhHORSd (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 15 Aug 2021 13:18:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbhHORSc (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 15 Aug 2021 13:18:32 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73B97C061764
        for <git@vger.kernel.org>; Sun, 15 Aug 2021 10:18:02 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id q11so20390315wrr.9
        for <git@vger.kernel.org>; Sun, 15 Aug 2021 10:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fangyi-io.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RB3vuV2z3HzKRQcGq2Rz4Y/X1AhWblDfaOjMa1ipMmQ=;
        b=JI4w6mrDbRUYyqGI6zav4r9Xva0uMBtIiBN3Ws5kg35RWMvsD3zw9PAxKNy8abaOOF
         3xbPyvXlvkYAJrR6skGQ3jYVOBpad1hIUYLAsr/gEb/ZtuWHxxvXn1QPjRJNPAzXdjFr
         Av/3j6nPZvEtH9Az/IoHvukQzyuvQC2vcU2xtpLZjJ0fqlmuBT0OQHBl/7O+hQLhocvT
         JJEeDSYwjKyrN4O42XOiWujAfoOknK/kg6cc466mal99AEAQ/rkdk27x+sBbJXfo14ak
         5/cEyEy92/vxQz6nZj8RXSK/M8IetcLDS6ldJZPRPMzb0RKMg54l31CEJctcQTD+26dj
         uwBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RB3vuV2z3HzKRQcGq2Rz4Y/X1AhWblDfaOjMa1ipMmQ=;
        b=jz9oGU/FPfmZLq0pOyk1D6BN1BudrXSF8sQWnPmFghqm7BFpYflazqnCcFYDdWFU6d
         qN+HlEnM8eu0EpeizuO3bBS15zK8wjWp4WK3HRBsMGkq0d0us2ZsI8LN/HTVmWnbwa0k
         quTg4DTvsmuv9AMRm3NluE17RiM/p2jTg2zHK8Oo7kp81A2mMS1qq8obOcKlizJ3A6HV
         gt+gCgkeHM+L6gAiP4zuqieDcJYamQSBy793EB/LFRQGOiQ0omaDDtOG5wQFDn3Kch2u
         os4KG1tFBBQw6OCB4XyMVfUn8lVwVZZJPGjEi0AQC3D+X94jOnithydmiYh4jEvn+h1l
         WF8g==
X-Gm-Message-State: AOAM532YvfLetfcL5hllUeSOVT10TvqMyFYBgwncn0LzUunQVEXvsDKl
        /8fG5scp33oW5+sRi+rcwaTuDIb/XqomRDbq
X-Google-Smtp-Source: ABdhPJzmxdz+ZQSNVB+r4zL9Dr/N1IKBHsX7tTct0a3miUfiTM1ECv0VOOytkCfOkRJ4auMU5G/vJQ==
X-Received: by 2002:a5d:4010:: with SMTP id n16mr3626261wrp.205.1629047880497;
        Sun, 15 Aug 2021 10:18:00 -0700 (PDT)
Received: from localhost.localdomain (cpc157871-brnt5-2-0-cust279.4-2.cable.virginm.net. [86.4.97.24])
        by smtp.googlemail.com with ESMTPSA id j36sm7340172wms.16.2021.08.15.10.17.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 15 Aug 2021 10:18:00 -0700 (PDT)
From:   Fangyi Zhou <me@fangyi.io>
To:     git@vger.kernel.org
Cc:     Fangyi Zhou <me@fangyi.io>
Subject: [PATCH] l10n: zh_CN: update mailmap entry for Fangyi Zhou
Date:   Sun, 15 Aug 2021 18:17:43 +0100
Message-Id: <20210815171743.8731-1-me@fangyi.io>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Fangyi Zhou <me@fangyi.io>
---
 .mailmap | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/.mailmap b/.mailmap
index 9c6a446bdf..5701af75a5 100644
--- a/.mailmap
+++ b/.mailmap
@@ -70,7 +70,8 @@ Eric S. Raymond <esr@thyrsus.com>
 Eric Wong <e@80x24.org> <normalperson@yhbt.net>
 Erik Faye-Lund <kusmabite@gmail.com> <kusmabite@googlemail.com>
 Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com> <eyvind-git@orakel.ntnu.no>
-Fangyi Zhou <fangyi.zhou@yuriko.moe> Zhou Fangyi
+Fangyi Zhou <me@fangyi.io> <fangyi.zhou@yuriko.moe>
+Fangyi Zhou <me@fangyi.io> Zhou Fangyi <fangyi.zhou@yuriko.moe>
 Florian Achleitner <florian.achleitner.2.6.31@gmail.com> <florian.achleitner2.6.31@gmail.com>
 Franck Bui-Huu <vagabon.xyz@gmail.com> <fbuihuu@gmail.com>
 Frank Lichtenheld <frank@lichtenheld.de> <djpig@debian.org>
-- 
2.32.0

