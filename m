Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1E80F207D6
	for <e@80x24.org>; Thu,  4 May 2017 13:59:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755411AbdEDN5T (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 May 2017 09:57:19 -0400
Received: from mout.gmx.net ([212.227.17.22]:65089 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751333AbdEDN5Q (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 May 2017 09:57:16 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Mc8Pz-1dODmF3oAh-00Jc7e; Thu, 04
 May 2017 15:57:09 +0200
Date:   Thu, 4 May 2017 15:56:54 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH v4 15/25] pack-redundant: plug memory leak
In-Reply-To: <cover.1493906084.git.johannes.schindelin@gmx.de>
Message-ID: <1589b496a91522e13150179a885bf64c139178cf.1493906085.git.johannes.schindelin@gmx.de>
References: <cover.1493740497.git.johannes.schindelin@gmx.de> <cover.1493906084.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:Y+ISAPu4213SOeN2C21kHV1x98F5M7GNTRzDTvjdMfAnjPc3ZQL
 Vkc8KbkvypN45CNY908iGSxd0EQfCKkYWce0wf+YTJv7oBR1xmRYW3hieMqXaUH1CUzQ/qL
 UcrwUj4uY2pfbnR8Wlb1FOFhZ4H8yHbd9ztK3pkjl9OfhtnIcs828gEzAV78hEOT6BtvIUW
 h/P6LahNH7LY/Hci4aayw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ngdo27BKjTI=:NBmzewpTn2phdzEqcOEX0L
 TLaB2JIOnGoxyZCe9nv+vDpSBjUBYCTw7eAHwY4rX6bxFYyEFnmjAa2ZLZvuSEXSTjdZapKtO
 zXe4dz0PSng+SqENN0B+RxfAeoWkzJ1hUvL9F2QqpoZMwNBQTJl/4WTDYUqhdKtO3ptUhDPRw
 6ai7vuXJpOuWd0VJg5r08YivEQFgeIbJdtW61W2qLbeGNutBjMxUB+BKor+iI40NPFNDgwJx+
 TDMJ6EFkfx5rIDqsOdaLUvrnDZBJv48Isk5VkVp7LmCofRj2pjRFrZISedlw0tYV+IG6yGu47
 apuuA4FW81CTN68M4reXa9r2ysa54xmPpcWqqRSGc6IEOYYPb1Eu9UUDWiLDkbcwKqWCkRikY
 Tiroj1rTHkdrdV50u3CclMxdCezyoqpXo6MhO6sLlHsIFylyfpykqoX27CoqlPB8jmcn8seAF
 Comac1jiKJBJisxaXW5x/WvY/0VCpSvX+zGT1I4mo+w8BblkU6Q2IMYncnIWw1S3lkuaNDqbS
 Y0UV15NrkOI3lO06XUstn4BsMIp7RuSF7ZpFWmmH6PLwAK6tlMn1K4lZd2Xk2rz4/pR7h7Xpo
 7UBPowWwtkgrtJKlq85cZFB/Ew6qAENCrKyLrneeBpz+Mv8wg2l2aOQsE0a3pt7Tk0WZJhBN6
 j/lxqudvdBWkEzjfYCT0hkDXvcMnMf/5zLj4KGxIcupbBZ4QnxkIGVkh/cQKes7e30AVYNh70
 oQbpM0ZRE2+dlgMhZ5roPiscCIKFsmDkoxMd4rdTN9MtCinbC5QCNCloViIiYJHFTfPsrgEm7
 SBQeXF4
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


