Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9CEAD1F424
	for <e@80x24.org>; Fri, 30 Mar 2018 07:08:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751203AbeC3HIA (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Mar 2018 03:08:00 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:46768 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751163AbeC3HH7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Mar 2018 03:07:59 -0400
Received: by mail-lf0-f67.google.com with SMTP id j68-v6so11403581lfg.13
        for <git@vger.kernel.org>; Fri, 30 Mar 2018 00:07:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LvqLjGQGegBEgjR2pdHUK32fTngFb60IkrM0n+inc+U=;
        b=joBhCtZ6eAOaW2v10IvL0aux8G2W3dulu1ufHZBC7CtwrQKb5mbdQ0AkzuiE8aMyxu
         W68RGf0DTMcTCiMGfhz6Rfq1YrOVxF1omK/e4DgLPjyTHWZCwSVC/A3s9QLnFEXGIaxr
         8afY97UcRNTkifRAibbGNA1SNXNp0Pa8hBen1dxfLwGUZ8bmkw9f2EIGOwOxb/i5faIF
         7Xphag0MP05ANsUewoSpye+I9wNMcmDD+QclKaMXYodCE7ajl9BVSf5wHu4a4ahEKAzg
         ZvPPCC7v1Kdb1Xu13tfLXB2ctP53KzTCrKL7JBh308OA/PZ+KVon6Yv5Ddig0bf1WVKY
         XprQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LvqLjGQGegBEgjR2pdHUK32fTngFb60IkrM0n+inc+U=;
        b=IjVXNtKWLoouG9pWr1DKnGWx9TJMTUiI4ccJ4YbAVknBoTKjkRFBip3rRImT5FOYDW
         8/XsVTIQKxFsyckV7QO3cLIpRStSjHS75tzYStuy+eflbArMbybhGV1GPXXtHP/67BO1
         a8zFiz9YdaopUm6ohuuBqzjF3bnW6U0mwivxRzirqodk4KPT2oFk0zFB+sjRIuhwJgOZ
         7GGS1GGi4WRcUEUBuGxDWVNJneowRVzZIIQ5tvZCpUgdwOGgBQ1H1P8X4ohGGo3a2Ap/
         19Xsh5Frr+qDqsheshyb/Pgts0P5pdlm2QkQUIMMTYhz0NdP7lHRvYDRMhMBeddZrn3z
         dCbw==
X-Gm-Message-State: ALQs6tC0yq9sLGrL2coCB5P8DHbceViAGEvox+B1gK4g3iDUyUXAB+O6
        eXA9BYTYsoKtVOgnwy67e+7PbQ==
X-Google-Smtp-Source: AIpwx48WYyxNSrE22ABQL8f1nmzCNxeC1665I/j/7bRk1jfMrIk6KcseZk2GXcnFpwn6Mql/BnDEaQ==
X-Received: by 2002:a19:e342:: with SMTP id c2-v6mr3787009lfk.146.1522393677892;
        Fri, 30 Mar 2018 00:07:57 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id b4-v6sm1509023lfg.70.2018.03.30.00.07.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Mar 2018 00:07:57 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH] setup.c: reset candidate->work_tree after freeing it
Date:   Fri, 30 Mar 2018 09:07:44 +0200
Message-Id: <20180330070744.22466-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.rc2.408.g9d2a3d914e
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dangling pointers are usually bad news. Reset it back to NULL.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 setup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/setup.c b/setup.c
index 7287779642..d193bee192 100644
--- a/setup.c
+++ b/setup.c
@@ -482,7 +482,7 @@ static int check_repository_format_gently(const char *gitdir, struct repository_
 			inside_work_tree = -1;
 		}
 	} else {
-		free(candidate->work_tree);
+		FREE_AND_NULL(candidate->work_tree);
 	}
 
 	return 0;
-- 
2.17.0.rc2.408.g9d2a3d914e

