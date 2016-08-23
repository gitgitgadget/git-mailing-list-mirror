Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B25571FD99
	for <e@80x24.org>; Tue, 23 Aug 2016 16:09:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753405AbcHWQJC (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Aug 2016 12:09:02 -0400
Received: from mout.gmx.net ([212.227.17.20]:63350 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751198AbcHWQI6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Aug 2016 12:08:58 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0MLS74-1bcmTM0T2I-000fod; Tue, 23 Aug 2016 18:07:58
 +0200
Date:   Tue, 23 Aug 2016 18:07:57 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 15/15] sequencer: do not die() in fast_forward_to()
In-Reply-To: <cover.1471968378.git.johannes.schindelin@gmx.de>
Message-ID: <ba172fe9ce41b2430b9f123aba8019e0dbb634dd.1471968378.git.johannes.schindelin@gmx.de>
References: <cover.1471968378.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:jv4u31/y5j52BSnDQqnwHXF4BMNXNfD0d8+V/nXPK7UKGRWGBOi
 ZkpvTV/Ycx3aCtQZXwIBLMAvEXIBtRyUY0DkLvbSEUY0pnfpWh6yFzWlJlYpknsn6ju3aWW
 hbzlDS6GYydZfq9t7jyh5va/h+eyxgtpQA2tUod0h1NP371wbzF0l/F58QGywsibeBSZRky
 E8nArrIXkZPr5pR/GPq5Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:lazrpmKCnvA=:kzRfu/Pe714rDaPFE4e7FI
 HVlQt28in69eQ+syI4AyiYzW7eMVMC0e1rPWMaBCpfrLzgYup3raST0FEgNHr2yYIAKqwXFIj
 jXnLeT46mmZ6aZCfxp1t613HyC9kQs3QVKoq+shAy3Nc6qexzV8mF/BP3gDDjUNLqnO1rFUfd
 LfyyzcESJGMW+na7aV/bPqW6xAzpXE2INooucVlGH5J/LjepeuomgSB9XhGUJDRmLg6U9YlDW
 DfZqGHC3rtTpClDihoSXAOEBzejw+rmDVlLtQiggIFs7eL2t8nBWMVhCNFYArjNyX/4sqPeMb
 vw7KKob2vI1IWl9QxyugyyN9SAdQQHGTkMWOGGj6qiE+NFVWfNqhOTqVfaxGNJPOXRijb9p+F
 1aAhOORcKv9QRoVRJ1PAL+TAmtbhPVPzKfZX92Mw2FU7Io3DMNHfNVfoNF2eSAMrl/+en/7sb
 zMQingZjfXwdV8uBfFHIob0ut3VP32dOknURq+O5TJLi2vjPqmh2X+XftYcxistDO8bPbMshl
 s248RcKaHUF4NnLF28YNjfA818hbjdGfBlONW27TXlaKchdVyd4kGl3fGtnCOsQRgHNwp3ArT
 LigY3649QeceQMRKo2QYrRhOVq+R2wmjoIlc/ph+ShoIZOuXeGDR6VuteBz9Om64n8jyoAHjj
 RQ1SITvS4TJuJy5DZjbMZOf8Bi95wxnfqSTvqRMruzmbmvAyxnHhNwyZs1Qhmuuxxg4IS9qV0
 XY+qmLiX9/h8oNUplwA2DkA5tGROBdHeXV4tzDH8Vx7MbZm3yEJlK3oFjTraKhrRNwAIU60mN
 WI5u0sK
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A fast-forward may fail e.g. when it would overwrite an untracked
file. We still must not exit() in that case: the sequencer is
supposedly providing a library function.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sequencer.c b/sequencer.c
index c29de64..9ddd054 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -226,7 +226,7 @@ static int fast_forward_to(const unsigned char *to, const unsigned char *from,
 
 	read_cache();
 	if (checkout_fast_forward(from, to, 1))
-		exit(128); /* the callee should have complained already */
+		return -1; /* the callee should have complained already */
 
 	strbuf_addf(&sb, _("%s: fast-forward"), action_name(opts));
 
-- 
2.10.0.rc1.99.gcd66998
