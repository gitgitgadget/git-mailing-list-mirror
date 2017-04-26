Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 30C83207BD
	for <e@80x24.org>; Wed, 26 Apr 2017 20:19:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967193AbdDZUT3 (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Apr 2017 16:19:29 -0400
Received: from mout.gmx.net ([212.227.17.20]:50196 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S967185AbdDZUT0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Apr 2017 16:19:26 -0400
Received: from virtualbox ([95.208.59.152]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LyS5K-1e9Nme2P6k-015tJi; Wed, 26
 Apr 2017 22:19:22 +0200
Date:   Wed, 26 Apr 2017 22:19:21 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 02/26] winansi: avoid use of uninitialized value
In-Reply-To: <cover.1493237937.git.johannes.schindelin@gmx.de>
Message-ID: <ead7050c37093820e3fd097dc31bc56204eee59a.1493237937.git.johannes.schindelin@gmx.de>
References: <cover.1493237937.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:hZp0dwoOGXc7DzUcy4UcvtpoSrnFtmezVmCsiM/vatsoxfAkDQP
 svwtxdLQwgih9qWLgbyXKwSvAhpoaDOnp3s/pkbqhuDm2Dk1e3nw+5RXs2oASXTKxb1oaq8
 1n6oTnjd4hfMgHNdxgONn44WypZKmtagIap+sWKUWuJ9i5xjiHjru4VsBtiT/QGhF3kUYwO
 J9z05vU2SaAK1hkkGsjDg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:OnCO54hli8o=:+7c43LcRd2bgRB8jTjDcK9
 aMheI7K6n33A/mWks4aBEDzXSO0azadLTh70uu3hpgULu2UixkG2yhtSmtoJTN9D/6oGc3xVK
 DgY2wqsp30qq0ihlEE6dN6Waw/nhDLskarSXABKBrEvHmEfqMEfWvT6gZKuuVged38tGOF6/G
 PJOU7+9sw/ljZbBbrjuuAPG/DIlLd7JMwlqTFLzvf+LRSOVC29VJ4E/I469y7NDFkMuMZZYfF
 PjnTyC1bBm6WFlhObV1Z3jOXsKEOSTDqWTk82m3de/RIyxxGhIdxtPsw3UZQ9mE2teIW1ifWZ
 jfrw/etOaud8GawmBB9y9Jc8Sl96Z0QRsZ3bUb1V7Y/VpHotKvNGFcmOF1wAfjj6YFmo7sv37
 jP6DboBYkl7O0Bv04Z2bwaAp6LgwYgwDUDCMQcNpNtXKdEaxEz8jYJVtFF7kwnKOINpfOinJ5
 k09OZcKol291ObeD4TOx0UHsilCJQ/e6FRcyjrzo0BvnYA9BmTvw52zWjd7dkcj/XAb0aEmAh
 fF7bGkDPRL1Jgx58MT9UzmzNgHp0i2DM4kVsqUZVYP2UG+8V51X9e4hI5pRMWR9bblUrJzixa
 N5LKHw3d0uX0+ODdOKsKulOA5iFrg7CjnPUNksUueRq4w35v0ZYw+Uj97HdyUCsgESxhZlFzH
 QxKM6uMSMKXY5hXewGxlnCvl78a8R4whfj7TMzILs/I2OoHFOW/2VUvD83dAIikl6CuvqlDum
 rts4PVwO7w70w7dRGr1CK+n0bpuDvCe3hmLRJGGUlZQjFX9bQoZdGl+njz0VLs6n4tengdRXb
 cNIcQes
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When stdout is not connected to a Win32 console, we incorrectly used an
uninitialized value for the "plain" character attributes.

Detected by Coverity.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 compat/winansi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/compat/winansi.c b/compat/winansi.c
index 793420f9d0d..fd6910746c8 100644
--- a/compat/winansi.c
+++ b/compat/winansi.c
@@ -105,6 +105,8 @@ static int is_console(int fd)
 	if (!fd) {
 		if (!GetConsoleMode(hcon, &mode))
 			return 0;
+		sbi.wAttributes = FOREGROUND_BLUE | FOREGROUND_GREEN |
+			FOREGROUND_RED;
 	} else if (!GetConsoleScreenBufferInfo(hcon, &sbi))
 		return 0;
 
-- 
2.12.2.windows.2.800.gede8f145e06


