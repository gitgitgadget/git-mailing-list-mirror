Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0381C1F790
	for <e@80x24.org>; Tue,  2 May 2017 16:03:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751271AbdEBQDO (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 May 2017 12:03:14 -0400
Received: from mout.gmx.net ([212.227.17.21]:64544 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750929AbdEBQDN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 May 2017 12:03:13 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0McEDD-1dPAoQ2Zux-00JaCq; Tue, 02
 May 2017 18:02:41 +0200
Date:   Tue, 2 May 2017 18:02:35 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>
Subject: [PATCH v3 19/25] line-log: avoid memory leak
In-Reply-To: <cover.1493740497.git.johannes.schindelin@gmx.de>
Message-ID: <e0a836073648c9ea2cc1784d61780b806a81dfc0.1493740497.git.johannes.schindelin@gmx.de>
References: <cover.1493387231.git.johannes.schindelin@gmx.de> <cover.1493740497.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:eAZOTqxKAB/j1cnsmQQNxCK9rny8/Rj+p23vk9OSArFpSXZ7PdF
 vm0bivpWIhvyvs0rcmXRIwTiihL849CCBnqqthciaPanYmi8Msip8afcgvYWeYE+Qi3+hLD
 VWqs4Yvg3mnbG4tQyk69WmhC+M7DLFjwbeajWg4aqRTZ2AQSDVdT2+GPpiNqWKcC8Wid4q9
 st6+zzYkpKXJswfxlzHJA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ZBbJ/TtXJCU=:3HfMjK+wgGk9Xn+W/UjWr5
 EkdHTutRzMqoDxSGCnuaEvZ/sDHiif/AqQ9wbrWwaLppkjkbX4Uo5a79NuPBmENTFMLe74GYE
 bnGXG0jBh3x0xLAhUf1xQVG+GIRbp/PdUtn6zpWMVAG5YoIsN/0wS6NZl7+xgNbgXk99C5fC5
 we368Adhl8nN07YIj7zaKcdz09ewZ1/eGVf1ngD+2YG0AB+LMiHUlpSYav558Ar2lGukCqyr0
 SbgYq48Ozyc6tie1iXZhTS+18iQYUDTIewOJYy0s46D6QGq906dc5HXjXkbTuFWlce2aBjgap
 9RxILhfS862mGDwAQu8OISamlhaLxg4CkZczEgkoDgwjXvpPOTm78/ZBFjw59OFeTaBWcvlX7
 +R6tZvS32WoizBLn2bXv0m56aHyYco17Ax/OqHJBIWyBHLPqGnBkYVFRVFBuczst62P6LCgfM
 wBUukGuojPcpm3BiqxnuA601bUOToH54juTFj3adcByosXDYaOOAX/t1IdOCrVWO47wbuy6hD
 sPEU/r1XzQ3r0zAYOrpVHAQIsqB/oGxh2Te0NFmHQiGBQMPNb0I3Ex2vr7u3gyDTaGkb5bG3u
 nYC0rwbeqvE3OgX7Laz7cVewcQG8a3KLpYdV6v0pYqHvUKax7vfRk+4dBTGQB83ZFo3gkbVdP
 Higg7xlF8112of1K90cCDPzm7n2fe2oDsLiDk6mRVT/NNqDDrmyJGxZasze2oj0k4rnEKhf7r
 Nwk8PMmaJsTGvQCw0jJGTNV4XKZRU8dfuG5SFvsX5gqPeezjHyLwRreOJS5krtU92gFs/k4Bq
 birJy3c
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Discovered by Coverity.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 line-log.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/line-log.c b/line-log.c
index a23b910471b..b9087814b8c 100644
--- a/line-log.c
+++ b/line-log.c
@@ -1125,6 +1125,7 @@ static int process_ranges_ordinary_commit(struct rev_info *rev, struct commit *c
 	changed = process_all_files(&parent_range, rev, &queue, range);
 	if (parent)
 		add_line_range(rev, parent, parent_range);
+	free_line_log_data(parent_range);
 	return changed;
 }
 
-- 
2.12.2.windows.2.800.gede8f145e06


