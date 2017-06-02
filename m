Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9A46220D13
	for <e@80x24.org>; Fri,  2 Jun 2017 19:10:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751159AbdFBTKT (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Jun 2017 15:10:19 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36577 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750971AbdFBTKR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Jun 2017 15:10:17 -0400
Received: by mail-wm0-f66.google.com with SMTP id k15so20407440wmh.3
        for <git@vger.kernel.org>; Fri, 02 Jun 2017 12:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1O5KsDH8OH7U39uLw6wm54k1P5ioV5geAaGbsVDtgPA=;
        b=io9I+vpTbWEBhngUaRCJE7d1DEGxc/wBfpHfkXVga6zopogcAp22+Hi0PXtVq1fi7s
         7dNBDoF0Mlz1O+6Ca5fcnG14uKmjmTUgbl/p+Md/Hl4Dwdq3/KYLTpWC76pcNhqot+rr
         OMQwSXNqkUiOcyZIZukDncPqBnsP4LflKdKUVc/u58gB8Yy8FX7zcPNSPnmzDMqPytf9
         VXqZv+w99o/stxXY0YwsJnpCvceSB3JVMdJBkhhHfYKcXvAhVXcDeixZDwWniU9mORjO
         m8k55Xb5aaHuRDZfDiPHOcNNc5hXYFwSwHDmQwjYxTvqkhbd4F2x2BIZX+Qg1r+QEr6m
         G4uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1O5KsDH8OH7U39uLw6wm54k1P5ioV5geAaGbsVDtgPA=;
        b=PzKpzpWXfN3g9DjIcBctqQeHXGxXzdLN17VYNdWIv91lblO+uhLt57arXsWY2klDfr
         WYntfztM+4OlwrD52i7yafTLZqbbajEwGk+/n/pWC8MGEsrzH8j68QT8CajqWgqwbpxL
         2n6IaWO6Vd0iEp9f4FMgBkduVy4Yp8PGg2Ok/BgNdcqdN4CtQK+OvpfokzYTisDzIRQ+
         dP3rf0wfJfnF41D/PaceDiKnOWblxvWMAdo0KJoSY4KCEOPVnL/89QRL5aN6R77GvTTB
         yxbPQnN/dnR52RvzfseAhIVBTktUAu8PsEyKvgnlBKtaIne0A3Ow7coJ0na48+ZS+Xmf
         NOtw==
X-Gm-Message-State: AODbwcC6P8hb8FH9u5xSWvHMxv4mibIGoMoXZEpeKb/DFiRqH4ZNRGq5
        YhcgBaFfjlY3vw==
X-Received: by 10.80.213.29 with SMTP id u29mr7081816edi.47.1496430616229;
        Fri, 02 Jun 2017 12:10:16 -0700 (PDT)
Received: from localhost.localdomain (x4db0e5ea.dyn.telefonica.de. [77.176.229.234])
        by smtp.gmail.com with ESMTPSA id j50sm8552465eda.44.2017.06.02.12.10.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 02 Jun 2017 12:10:15 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 1/3] revision.c: stricter parsing of '--no-{min,max}-parents'
Date:   Fri,  2 Jun 2017 21:10:08 +0200
Message-Id: <20170602191010.16834-2-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.13.0.420.g54001f015
In-Reply-To: <20170602191010.16834-1-szeder.dev@gmail.com>
References: <20170602191010.16834-1-szeder.dev@gmail.com>
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

