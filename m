Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C3F7F1F790
	for <e@80x24.org>; Tue,  2 May 2017 16:02:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751203AbdEBQCe (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 May 2017 12:02:34 -0400
Received: from mout.gmx.net ([212.227.15.15]:57575 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751199AbdEBQCc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 May 2017 12:02:32 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LyEJp-1eArZR24zl-015aLo; Tue, 02
 May 2017 18:02:20 +0200
Date:   Tue, 2 May 2017 18:02:19 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>
Subject: [PATCH v3 15/25] pack-redundant: plug memory leak
In-Reply-To: <cover.1493740497.git.johannes.schindelin@gmx.de>
Message-ID: <afd43bcc0fe14498ce27cf776579aa931cd1be4c.1493740497.git.johannes.schindelin@gmx.de>
References: <cover.1493387231.git.johannes.schindelin@gmx.de> <cover.1493740497.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:7kISWAryGpADkuPASNjsLgzPXKosapoie0PwC6UP9pRgsGaVD6K
 Tq7X6LZXD4KJbmIaC8fLIFSbqaXI0n8jD75D6XGdfkde5BwUx/MMUMXAqURQXFB+7s8BnRO
 MjW0kxLK+UUbT/QujENcLhVGzRkQWnO0HrSH3do2ulGvx4KQBjurO9k5Hh/JPNOfRxUsaER
 75twV3RM6zHHAQQ/4uP/w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:qSmZ6emTHoM=:iGS8oXAp3gKHLGkQVsY0D1
 Q9DhIp/Xg7A+OTMk+OC/5dLK/gMp9Vt54+D2SU4ASVQUViZOmowKD/7dZahkBfxrwFTQLQcRo
 R7fcf4oE3FKeciu2pG3EIpyY7nsFRA8w+yy3u0GWoBvfG8jS/oii4fAX07Uk4e2QK2BXSn0is
 peHsw9+jTduQ4944HO08/TX9nI2IPKUIgzWPdbTSnc9bPGfAD3Cp7XPitNtgMsA3D4qQE39Us
 3vzpUyClzl/1nf/RJEaLjCQHk/tPZyHPuBkNYjc8TFfHo38Pr6S6VINeCXQG5Q2AwJD2FNdG6
 kmYWY1uRAr2xtRYHnjym7x1+DHklTpSLAujeEwAlT0baR5rJPCKvnaCpkzlhOhwfKGSArMKg1
 ZJhaTml78F7fJxgV+SUmXzVy5gdYfj33I+jBkFEw+Xi9cU35QbCMoGZsf6FtkOM6Ht+Vt3B2v
 yjZbSFvfpaJieXPRp8uBCyAKRbIQnXDOpeoNSfuK353jk3/Ubcufy7yo6A/3AgcD+k41xFKVt
 oS9/3vB0PiHmLvaf7V3e4kuwqoZ+SSLrI9UpMIPF3uucLoN3JRNHjeR4TLG96YOLDd9gIMkKO
 96Pck1Ow80kx+67samBgH0B6vElVl5NkOpUD47mJwM+Po2GFAASJNmfLEGlwznmGWkBI5yvOs
 jri5Pdu1Pdr6lME+sJeQJBpkOs88f6wNcVop4nOJLqLI8Wx7aHv87Cl1tbnAyNjrsPSVZ8dDQ
 Xg2H+4gNG4GEIfQyN63lyxh63zqC25DXZ/U3b4PfDRR04bybHcHKRkUS6sLgu2o0pCa6lesYD
 4LaSCsg
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


