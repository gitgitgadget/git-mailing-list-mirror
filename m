Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63CBEC433DB
	for <git@archiver.kernel.org>; Mon, 21 Dec 2020 21:27:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 134DA22AAA
	for <git@archiver.kernel.org>; Mon, 21 Dec 2020 21:27:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726066AbgLUV1k (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Dec 2020 16:27:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725857AbgLUV1j (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Dec 2020 16:27:39 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB537C0613D6
        for <git@vger.kernel.org>; Mon, 21 Dec 2020 13:26:58 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id o19so27162342lfo.1
        for <git@vger.kernel.org>; Mon, 21 Dec 2020 13:26:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FGFNJzWdXrwuZ/xEb9bjN2sFPJwhwmBM4cuzcL5x+C8=;
        b=QRYqkmlvF3MgD8YgHCanVQgB02KO7ymXvulMP5VbKQmioipT0iyqzOUGt2z45nCSMK
         oYmJk1oRzWoHy8M/oZ2HY+h72unfXINWvgLw93PQIteb4pfTtCogUgH4CMpU5MfAFZ6Q
         g+qZhyZ92mb6sxklg7TNwS2D9/co+ZT7XqvtcNW5cffde27JAcx2h0nfQXVTMY4YiK5A
         /RAwShoSPvp8BZP0X8ZhnrJnI5UO9FqNpHFbEb6aRjQRV+w71BkYJx1OpnyEFzabANLj
         HPSQ3CD/sO2AsATXce0FtIPiWmD6wHrafBNeubI3AMrPNWtGPwGw76VJ2gP+cBlwRFiy
         cSUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FGFNJzWdXrwuZ/xEb9bjN2sFPJwhwmBM4cuzcL5x+C8=;
        b=MEq5v/iEv7whR/i1FbPyzl6jzolu3DbYfqrqugXsm6wReQJSyGHISloZhb854q6M7C
         su7I3rkAbtIIBxxtC0rHjVBew+VJcF8QD+bDkqeJroSsukGnnSWQ/+kzgiCd+jOPT8dg
         Ndh99ysouSAo4ZHir4uT4jsV3jOv9lkuAvBrvrqGGhmOMtiw0eMVx+nFGVL5D/YfJ2f4
         M28o8izj4tg2yRRBGHHq1OmtfutP/AToMjces/QLztqh7jFe1ENkZWI3rl62Tu3eDqlX
         twjRfJpMCGRuXQCLeQmWaPfHC+9t4eiGImH61CfWk1BdsfIPlXtahjWdskKNvXFjK/PB
         M8xQ==
X-Gm-Message-State: AOAM532sIWEacXiCsyU8i/DVPWW3o62ckVTltDIoYkcKpJnMIIa49rc8
        Bc17OmUnOCXhPLmz+l6lHOGOz8vovw0=
X-Google-Smtp-Source: ABdhPJw81PQXWTsBiHfudcd+GoFmqAWGIYWRD2Eui8pl9beG4sVmrztFja7ym4/G9UEBxCLDt/NH2w==
X-Received: by 2002:a2e:8059:: with SMTP id p25mr8305589ljg.155.1608586017242;
        Mon, 21 Dec 2020 13:26:57 -0800 (PST)
Received: from localhost.localdomain (78-66-223-148-no2204.tbcn.telia.com. [78.66.223.148])
        by smtp.gmail.com with ESMTPSA id t14sm2236100lfl.216.2020.12.21.13.26.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Dec 2020 13:26:56 -0800 (PST)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH 1/3] git-maintenance.txt: add missing word
Date:   Mon, 21 Dec 2020 22:26:31 +0100
Message-Id: <7bd059244087016d2af47c6329e46191bebb168e.1608585497.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.30.0.rc1
In-Reply-To: <cover.1608585497.git.martin.agren@gmail.com>
References: <cover.1608585497.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a missing "a" before "bunch".

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 Documentation/git-maintenance.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-maintenance.txt b/Documentation/git-maintenance.txt
index 6fec1eb8dc..d1f9b5172d 100644
--- a/Documentation/git-maintenance.txt
+++ b/Documentation/git-maintenance.txt
@@ -101,7 +101,7 @@ This is done to avoid disrupting the remote-tracking branches. The end users
 expect these refs to stay unmoved unless they initiate a fetch.  With prefetch
 task, however, the objects necessary to complete a later real fetch would
 already be obtained, so the real fetch would go faster.  In the ideal case,
-it will just become an update to bunch of remote-tracking branches without
+it will just become an update to a bunch of remote-tracking branches without
 any object transfer.
 
 gc::
-- 
2.30.0.rc1

