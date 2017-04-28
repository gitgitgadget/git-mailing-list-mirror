Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9A4AF207EB
	for <e@80x24.org>; Fri, 28 Apr 2017 14:03:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1035039AbdD1ODg (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Apr 2017 10:03:36 -0400
Received: from mout.gmx.net ([212.227.17.21]:61472 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1034206AbdD1ODe (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Apr 2017 10:03:34 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MNw0t-1d9sqz2DrX-007Qy6; Fri, 28
 Apr 2017 16:03:26 +0200
Date:   Fri, 28 Apr 2017 16:03:25 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>
Subject: [PATCH v2 15/25] pack-redundant: plug memory leak
In-Reply-To: <cover.1493387231.git.johannes.schindelin@gmx.de>
Message-ID: <7f627e2d67c165fcd2e3ef8642df468efd69224c.1493387231.git.johannes.schindelin@gmx.de>
References: <cover.1493237937.git.johannes.schindelin@gmx.de> <cover.1493387231.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:1j10EkpDnHP3GpKMGuttn8kvYN8JUvjECp7YFMKb3iH80ZztVEc
 AQEKCHvqH0kNeD0F82zpKqr+U4JGuZ9RcdkNwLcIBmc7FrGvjHsLd9hV4lQIPgwiHn1tg6t
 htfWTswrwbCzGZRR0OGZ/T0PK2O4TTDnURfp0NLiVnD5NK2TE1Up/jNprDIp4iEStPSsYup
 Qq2MIPq67IJqJUQhIERdA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:7xq9MCwnN4A=:PkCFDvRBRK1gJX6MPk2css
 ubOa20i7rSTwAbvmwSiprm88AtWxxTg6u5CwxFdZ/RBYkkfTnQaAAj41yBR2qEq6IcOS3Y7Ig
 SNF0PP4yRECDJprs7qY6UAVBoN0KsHkNoMFV8Vacg/PwXMMVHLbnHXqdljeXeXy8EWPAdGqkI
 k/GXv7ypJt2TIp83SYJ37fotjuOkVNLOr5HUWQXvuT02mmpqNuBTioOOJMBzg8/iw/+ZoJ2zW
 XTjh+AmbgdextY5QYtVk5ZC948jFYFq4cO97uXZRNtLFfUduX4xh+rrjDdXij3Ki2XZFNZcws
 xuLmFm0o0onCnaYHNUID8ZB4vDt5+ru633msdMcMIgOcAOwXzBqfRaWf7Npv7v0DO9OS8z7jB
 bIFC9AA7pNZSBHZR0rFVNstWfmGcAB2CaentfZ93llKxEiRpeEy9APSNC9p8v+d2ueS3zyY+Y
 Dc8QoU37K6PigvJogsnzVIiBSH/nEqeOYl1f/SJ83roHNHSxyetxz2mEeQW07hqG6tNSP6WmC
 GbBJAyXdxXcX1UJmDgVBm98XBW5RpAKC6/gY4BgS2PG7PRJKFvW8g7+naGwgIy0iJEnwXLM/l
 nc3nG7kED0kvbVM46lSoX2RmjOEBs1zxNNEMjFFW9Jogyi8M82myvPBRr8C1HRF+RsjTHcusE
 TzVI90NI+faHeNYSAvZaNU1Ipzl237dgdjyGSV49SeuWOpdqLveerWMnxZXxDMLrDraaMaARp
 xw50HZye+MsPr0EoJibB2mqhMf8Z7tot9/sU8CAcRDtLYFUPVriHTNrfYHv7lAoo8DqRdPk3x
 F/nTou2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Identified via Coverity.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/pack-redundant.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/builtin/pack-redundant.c b/builtin/pack-redundant.c
index 72c815844dd..cb1df1c7614 100644
--- a/builtin/pack-redundant.c
+++ b/builtin/pack-redundant.c
@@ -442,6 +442,7 @@ static void minimize(struct pack_list **min)
 	/* return if there are no objects missing from the unique set */
 	if (missing->size == 0) {
 		*min = unique;
+		free(missing);
 		return;
 	}
 
-- 
2.12.2.windows.2.800.gede8f145e06


