Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 23EF520195
	for <e@80x24.org>; Fri, 22 Jul 2016 12:25:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754042AbcGVMZk (ORCPT <rfc822;e@80x24.org>);
	Fri, 22 Jul 2016 08:25:40 -0400
Received: from mout.gmx.net ([212.227.15.18]:54758 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753981AbcGVMZj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jul 2016 08:25:39 -0400
Received: from virtualbox ([37.24.142.100]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0MC4R6-1bZPCr3kIa-008uwm; Fri, 22 Jul 2016 14:25:30
 +0200
Date:	Fri, 22 Jul 2016 14:25:28 +0200 (CEST)
From:	Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	git@vger.kernel.org
cc:	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
	Duy Nguyen <pclouds@gmail.com>,
	=?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Subject: [PATCH v4 08/16] merge-recursive: allow write_tree_from_memory() to
 error out
In-Reply-To: <cover.1469187652.git.johannes.schindelin@gmx.de>
Message-ID: <2d80e8c9fce38821fa95646951f7d8351fec7db8.1469187653.git.johannes.schindelin@gmx.de>
References: <cover.1467902082.git.johannes.schindelin@gmx.de> <cover.1469187652.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:mcPD5emOPrq80+TRULBAxWHyK1Sjo4TfFXz6QxaYTbPi6kKoH42
 n2vwecFX8mLSogIt8zTjRRJGQJEF2HKzXkvwMIDSSNIPch6P00hmB6qiSlgCxSsNjJJDVy/
 LmSa3qMWIY21FuMdntpR3s+aEpOM2DJaFL8OeGQsTiKt/YPImPEpoDRs5xr2ZW4aovvAN6i
 Q3LB/g/xsL+F18b2SPYYQ==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:poafG+aMduk=:uld9HevwzS357Xb34wFeOw
 ++F+k//tqcBgNIT8Eja+e8Cz+EYGrgat0UAcU08IwBe6+QurIKJNL4k35iX/+pkerZChaQIWG
 yFAKfs0D+v12f6lZm8RCOygfDJiQ+w+lu4hxLL3oifJreie0whHPMBiA78EvRKtTdmLpnI+cD
 WaHsYKMExxqoghCG4vXpxIPizLlXN2Wv0SG3+LkHp6duXBuBOKGW4Pw9zvrCaXFx37/dZCJa+
 WCXrrEOe+slrZs/UkZIrFCjoJ5a7I6BUPL0MBA7lOpv1ToSmvNSIDFDSBkqms61yAkNF2ggZV
 WyYN8kgdktymeRChpoGKnD+gVXJdZdnv2s5hOr715ta0HNhnzfeFSdd43WYmOUDsh0jfGqqDQ
 8alSPGz7DCaT2u+bdL2mkjpw4pxX0JPSRFvG2rauhuZrJ2mkGYbjIM2UbhxBkHNiEXc50b1Eb
 KYXxl34Dkf6CxmDX62NCWDE8trpt36dcqY7ADbdxbcx0VEwMr7DqkKNeOTJP4F3z0MXUiOQi+
 6qCaW6POEt8zeb7VQDfSclcz3vF8C6gteS6Nw8m9eICj++adh1lDczHekQP6Zddx1T89N9tnc
 K4I5qDUdxQp1Kcsj4dWM3f/tAZ1kaOaxQPUnnMyQ7H7FiTQP43geM5uQbFLfRuAHAMrCmX+Ym
 cMCOsaoqeNRhqZOx3WRYzqhFrsy33as6zhJNuzRvnKnmyeeuevk9Hw3hSdtVpZdzeJw+LKHh7
 65cDKh6LzZlDECKivw4CpkhmDoBaMc9cV24BeykSv/ddIqvoglFI65n/v1KXEhxuDIaIiCGIA
 cyCIsGI
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

It is possible that a tree cannot be written (think: disk full). We
will want to give the caller a chance to clean up instead of letting
the program die() in such a case.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 merge-recursive.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index e1cea96..d5b9b1c 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1879,8 +1879,8 @@ int merge_trees(struct merge_options *o,
 	else
 		clean = 1;
 
-	if (o->call_depth)
-		*result = write_tree_from_memory(o);
+	if (o->call_depth && !(*result = write_tree_from_memory(o)))
+		return -1;
 
 	return clean;
 }
-- 
2.9.0.281.g286a8d9


