Return-Path: <SRS0=QgeI=7Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF077C433E0
	for <git@archiver.kernel.org>; Thu, 11 Jun 2020 13:50:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C65E52083E
	for <git@archiver.kernel.org>; Thu, 11 Jun 2020 13:50:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gP7u/NIu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726475AbgFKNuc (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Jun 2020 09:50:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726109AbgFKNuc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Jun 2020 09:50:32 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 033BEC03E96F
        for <git@vger.kernel.org>; Thu, 11 Jun 2020 06:50:32 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id x16so2647641qvr.3
        for <git@vger.kernel.org>; Thu, 11 Jun 2020 06:50:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WY6YGNHrmkl1ZYAQzff7g2sU46d+TSMQkozO0mitWaU=;
        b=gP7u/NIuKbtsJcw1rYfA5COxHRUAxLSa/5Q69OEltT88JQ2A58JqxgFvSYyWh7UCsv
         PeUgDvxUSnETKMKJ+3UfbtVszx0ZiZA9hp7RO5JQGL5w9CKelW8OKNI5UZC3kVmz/fC9
         UrNyumSwXtNPXZesEnhmIqBo7/M1Mu9AdahrjCJ3puBlKJJGETfRjzSOpDRiZizadRUl
         faHWdpo62O8Y8vNBph0+lGGBza+Uza0dllR9twwzzqK7syRFdG7BvWzicsaW9CpzXytV
         aGQdsIDAzldBS5DcrxeCUPFIo9EvolPOrL51XdAK33sPi2uWht9UJLuYwcS85HfBUQe1
         yp3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WY6YGNHrmkl1ZYAQzff7g2sU46d+TSMQkozO0mitWaU=;
        b=dMJMcv2/+Q1P7A4m+RArD2FIbgyx1+ITUghG+76JoU5GRlWjViSTP38Bx7Oy9aZqYk
         xvud3lMjg852Sq3H0Fa+0YOAwhrE87bx2njZbPqXL1coDLvnjHHDuqZUgOlnbxPDIOe5
         u9/BHk5NrSiO63e3SaKSb/ZrHNJMOWgyY9n4JV5mEoxxa2pAGyXACxmO1ofilosmKd7C
         K4/9h58UnGVxU9Ey9cfJrtK+CeHf2Gz4KJRMT3RZkUYsC8n+bECEx94Cja0u9iDqAeCk
         ieg3G1Xj8MgESAn9VcLyH22Qwo22mZEn2yQo3T3Lvtm72eKqkgH2cOqTq9wt/PA3qPb2
         JDAw==
X-Gm-Message-State: AOAM532a1H4Jj/e91zEOSHTGBJbYDbdwrU0VHcV+O0wlHrrLBdTHSKar
        j0JDtkTRQbJ29zRpK8GQwj6zxC8wX+o=
X-Google-Smtp-Source: ABdhPJyJHkGwpDTVahSO67c2l1KkYEA4SYXx4aGOjOCgujT9bre8NCQTNbDeO/azdFSp8p34ykajQA==
X-Received: by 2002:a0c:eb11:: with SMTP id j17mr7444787qvp.193.1591883430970;
        Thu, 11 Jun 2020 06:50:30 -0700 (PDT)
Received: from archbookpro.localdomain (CPE18593399858a-CM185933998587.cpe.net.cable.rogers.com. [174.112.65.113])
        by smtp.gmail.com with ESMTPSA id 10sm2149461qkv.136.2020.06.11.06.50.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2020 06:50:30 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] GIT-VERSION-GEN: update for the post 2.27 cycle
Date:   Thu, 11 Jun 2020 09:50:20 -0400
Message-Id: <4946cf3650b95191455630f85f59e5f93156d0ac.1591883410.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.27.0.132.g321788e831
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 GIT-VERSION-GEN | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/GIT-VERSION-GEN b/GIT-VERSION-GEN
index 06a5333ee6..7b0cfeb92e 100755
--- a/GIT-VERSION-GEN
+++ b/GIT-VERSION-GEN
@@ -1,7 +1,7 @@
 #!/bin/sh
 
 GVF=GIT-VERSION-FILE
-DEF_VER=v2.27.0
+DEF_VER=v2.27.GIT
 
 LF='
 '
-- 
2.27.0.132.g321788e831

