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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E12E6C07E96
	for <git@archiver.kernel.org>; Tue,  6 Jul 2021 18:25:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B871361C3A
	for <git@archiver.kernel.org>; Tue,  6 Jul 2021 18:25:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231244AbhGFS2L (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Jul 2021 14:28:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231223AbhGFS2K (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Jul 2021 14:28:10 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8D47C061574
        for <git@vger.kernel.org>; Tue,  6 Jul 2021 11:25:30 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id 37so3463202pgq.0
        for <git@vger.kernel.org>; Tue, 06 Jul 2021 11:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DPq8jrW5qOoJfVnUsllSDMfXklrhf9W20cwLqGGqJZE=;
        b=KL1ns4zCXFzP4z1UruaZJBrNjeNQzjDpGyFqTcCy0L7bCXIDZ9q7UYnxXM+NSizobs
         HfTAb5Q3ssDSQWBdz5CjoThxbFfLU1Ns3CYrvOa94tS4lKaVgiOJFw5RYTc8t+0mlh+7
         VNCi1ZP1+fczKdXtnSUjDytaJQZ/2ge/Dqlmk1ysO7D37R8Ll11VMl+6FsQQTvwlH/KX
         tgxRMJWzWvtGw9pcf3h/VGF/9dVTVPhvKXPBVX3vtC6nyVjG8VrK59jc09WG+CafoLco
         0jfSVu1lD2o1dKDzCV/NnkEXEy/b2unkF7xDlIjRWhUM9VaR80nHD2ZnL1Hx92ScGuim
         chgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DPq8jrW5qOoJfVnUsllSDMfXklrhf9W20cwLqGGqJZE=;
        b=AqP/uou7T/iPUPwkW9icmiBdItEQOcX6f//Rc6roHNT53HkxbHOcd1UO2POuzNT3Sk
         8bYbnaPLig0WUzZyGDW6ZOMjEjGNKhArH7zpPLj5NVGmy9KDo9I8agWu/QIX5hR03cuZ
         Z00n1jRBIEo3XYvZj5nm3abG8lm8hWcBhyg/npjKYVEFup+Zp9+QaIobKjOOWbl7dfhH
         PtQdrXKoRP1K+iCGOlpQvedBqc3GzD1rDBrpi1frawBeo48cwSVB/1Mnqme41/FGNFPy
         aQ6d+EfpQqAXlVDi9KbdCOg3wPKnRT2/iKs5zNu0fwfOXIEB8yGvATyI90Tk2hvzDpLP
         peQQ==
X-Gm-Message-State: AOAM5335oHe8uXMyqnSH1Vp7BBBp2uV3CIz9aNpGnOniBjQMg9nJS6mu
        5Y8jVsAF4BVVB33OjlOYDDb4xH2DoCgukNfh
X-Google-Smtp-Source: ABdhPJzN1vifH3SzquNpuu4qwVzl5a/Cuq8rVFOFZVw7E85nJehM3pXuizgt67BnmcOtpjOSFYjhaw==
X-Received: by 2002:a62:dd83:0:b029:2e8:e511:c32f with SMTP id w125-20020a62dd830000b02902e8e511c32fmr21565018pff.49.1625595930088;
        Tue, 06 Jul 2021 11:25:30 -0700 (PDT)
Received: from atharva-on-air.Dlink ([119.82.121.47])
        by smtp.gmail.com with ESMTPSA id a23sm16168845pff.43.2021.07.06.11.25.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Jul 2021 11:25:29 -0700 (PDT)
From:   Atharva Raykar <raykar.ath@gmail.com>
To:     git@vger.kernel.org
Cc:     Atharva Raykar <raykar.ath@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Shourya Shukla <periperidip@gmail.com>
Subject: [PATCH] submodule--helper: remove redundant include
Date:   Tue,  6 Jul 2021 23:54:08 +0530
Message-Id: <20210706182408.34179-1-raykar.ath@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"dir.h" should have been included only once.

Signed-off-by: Atharva Raykar <raykar.ath@gmail.com>
Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Shourya Shukla <periperidip@gmail.com>
---
 builtin/submodule--helper.c | 1 -
 1 file changed, 1 deletion(-)

This is just something I found while working on my submodule series.

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index d55f6262e9..3e2023fc3d 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -19,7 +19,6 @@
 #include "diffcore.h"
 #include "diff.h"
 #include "object-store.h"
-#include "dir.h"
 #include "advice.h"
 
 #define OPT_QUIET (1 << 0)
-- 
2.31.1

