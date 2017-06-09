Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 740161F8CF
	for <e@80x24.org>; Fri,  9 Jun 2017 18:18:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751726AbdFISSH (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Jun 2017 14:18:07 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:34525 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751680AbdFISSD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Jun 2017 14:18:03 -0400
Received: by mail-wr0-f193.google.com with SMTP id u101so8436907wrc.1
        for <git@vger.kernel.org>; Fri, 09 Jun 2017 11:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1O5KsDH8OH7U39uLw6wm54k1P5ioV5geAaGbsVDtgPA=;
        b=o1AlNSXSSRsVCa0lWom+ixiBxLW9CvpUcxaoHtiMaRtvh2IC6fMT+rOGYz/E0taAzT
         9MNPSvrfJNLmsuyGOI2hiC9DO83pUH6ZWDB95IEBBBJLrWAXSS0anX0SBm6373Lb9+Xn
         igqyQzVvUTfpqlj1R2xArlBAw/FHeGhoj2ylnVYz2FefEF+hZ5wRmD7r0E6Pltp/Tmo/
         SWTgdvmXftvSTZyJuKrjvFIGqCxxd1WGevv0LfKeepGLvG49xPMrdQm1LD01BffLNQg2
         E/6o8dka1FoGwjyBw6k/A435YZXpDfndaxaRE8n3pIuQiFMRFqWkoFw5FHyYb9Yg/vLB
         2H1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1O5KsDH8OH7U39uLw6wm54k1P5ioV5geAaGbsVDtgPA=;
        b=O3xW3vIQQ6/+l11ZhQY+Nhl7xMiyC5wOQu/RXZfzPQMRkShr1+PULnxlVpPPA9XSK4
         nmTUjGYziclcmI6OFA5jIlNFXi8CFIAd05Lwm6F4cTXlhNuQvKEVym5fDDZ42chsDqnC
         dEVIS3kBngckA8PRnb8/sJvXOUE7emTOvAen/tziTztALQ0VkZT4AtbPnrdB9QGSJcdF
         5qDykv5N93B4G0Bb6mquKiSflWHYEA/MFPzr39pzdXYexgHs5cwDz+Kplu/bnlI8SO4z
         yjoBdXD8ZpDrwOLD06gBKleRMHFBUDxqMn7K7jkSAozKSo+p0lsdPI6URNyxI9h/8Uye
         qvSA==
X-Gm-Message-State: AKS2vOzpEhmve6O6ymeoBJ8g7n5IMUlbj7k5fvaEraDmvjyRr0O7vsTO
        LxAw1cgX665aCCHY
X-Received: by 10.223.146.129 with SMTP id 1mr16265wrn.164.1497032282274;
        Fri, 09 Jun 2017 11:18:02 -0700 (PDT)
Received: from localhost.localdomain (x590e0f24.dyn.telefonica.de. [89.14.15.36])
        by smtp.gmail.com with ESMTPSA id g46sm3485851wrg.69.2017.06.09.11.18.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 09 Jun 2017 11:18:01 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCHv2 2/5] revision.c: stricter parsing of '--no-{min,max}-parents'
Date:   Fri,  9 Jun 2017 20:17:30 +0200
Message-Id: <20170609181733.6793-3-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.13.0.420.g54001f015
In-Reply-To: <20170609181733.6793-1-szeder.dev@gmail.com>
References: <20170602201143.6avkhp224no3dukb@sigill.intra.peff.net>
 <20170609181733.6793-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These two options are parsed using starts_with(), allowing things like
'git log --no-min-parents-foobarbaz' to succeed.

Use strcmp() instead.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 revision.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/revision.c b/revision.c
index f88c14bab..2f37e1e3a 100644
--- a/revision.c
+++ b/revision.c
@@ -1812,11 +1812,11 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 		revs->max_parents = 1;
 	} else if (starts_with(arg, "--min-parents=")) {
 		revs->min_parents = atoi(arg+14);
-	} else if (starts_with(arg, "--no-min-parents")) {
+	} else if (!strcmp(arg, "--no-min-parents")) {
 		revs->min_parents = 0;
 	} else if (starts_with(arg, "--max-parents=")) {
 		revs->max_parents = atoi(arg+14);
-	} else if (starts_with(arg, "--no-max-parents")) {
+	} else if (!strcmp(arg, "--no-max-parents")) {
 		revs->max_parents = -1;
 	} else if (!strcmp(arg, "--boundary")) {
 		revs->boundary = 1;
-- 
2.13.0.420.g54001f015

