Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7697920193
	for <e@80x24.org>; Tue,  1 Nov 2016 08:49:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1168052AbcKAItm (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 Nov 2016 04:49:42 -0400
Received: from mout.web.de ([212.227.15.4]:61166 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1168035AbcKAItj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Nov 2016 04:49:39 -0400
Received: from [192.168.178.36] ([79.197.211.11]) by smtp.web.de (mrweb003)
 with ESMTPSA (Nemesis) id 0MAMkU-1c8gZB2sgs-00Bb7T; Tue, 01 Nov 2016 09:49:11
 +0100
X-Mozilla-News-Host: news://news.gmane.org:119
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] sha1_name: make wraparound of the index into ring-buffer
 explicit
Message-ID: <a1e2c4a4-4720-fc26-c866-6ab959543c3b@web.de>
Date:   Tue, 1 Nov 2016 09:49:07 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:aErxYbhohGN14z1xj25pScveiejX806OS+tForGCscr2IvbAPMP
 q1hQqcDy1De4qTovh6lkI3B78CwhPcv3V9Nt0J7A75gGHhTZK3IeRo4+xHJReY2cIRHX4o7
 j20LXwxzp6p+cn+FQInXVgBvU/myqQzfGx9rjtESQ+UlC42RVJn0QCxuLmKvIiyrE2u1TR+
 bFhPrhZb4KuKL60AO3TAg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:NWZsMrAsvys=:lpJq/m8EIhBXSN3JYWZyAo
 G0rr8XMO94mJZO62sEHLHP9WJYEP3WaFRoD/HgHzhkoZzlHPwfftCDSay8GoM2Vz/p+m1a85o
 ZZsaHwHUc54h/zGAkdFFCTw4jhsD8gn/O3DDqa8RLAcnCxqvxK/B8DtHFEyuaL5bpPZnOROgO
 Ih8Ehfxrcq5bV1W6DYejq/VvzgXmWQnGaNlNoYAxYPVG4L94/vwEjurdFlwD/ZMbCKjVcPIKB
 EAxH9sRKhwmvdgkcbzvi3Vaf1A2fp2Rzq4YQwk0gQo4VKIUNRlBq3I+PnE+Kou8pAfnhUEM8k
 W4651Ul5ZMM0i0X0Xup3dtMRwTzreFHZyhTbdgEpWjfMPcRa1Xnk8LGhl88YjuigabfR3Gps6
 yWgXKiqsrfscg2WBckQLE4p1nw1sw5eljpF/zWFHQXjMAtAe+Ltap5nA/tChFQoh6QxyBftiI
 3sY+UldYOGeVy1s71WGrenaVZiPvFZ37ehLTAqx5xTWIIpy54hbBnaStsbm6p/2SrRy5EkFEc
 8BxidyiN0Bxia9zNJFrEweD9H7CELDeHYhSMx+n9T0QVtqscNINbcTBISJfX/Qu04TSQLG/tA
 3LJdTW7JwJ97yhiu6jeObYcJ6DIVYY+uYDj8KVsNTAQu8U38ANCzz5elboUpb0kHexUp7AfxR
 037tOkVUVhgkg+S0oQ6BKqWMzrPILQqe3t5jR3UuLkh0/ItUEwZdZgvUoCuuwUrDeIk+MR1GM
 yM7U3uSHRpf3+qZ804OjWvBdxrn/P058xYcTqZTrWl/HYOeW3pDLhW9doWZrMJfJz3s4t4132
 n4gafCI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Overflow is defined for unsigned integers, but not for signed ones.
Wrap around explicitly for the new ring-buffer in find_unique_abbrev()
as we did in bb84735c for the ones in sha1_to_hex() and get_pathname(),
thus avoiding signed overflows and getting rid of the magic number 3.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 sha1_name.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sha1_name.c b/sha1_name.c
index 06409a3..73a915f 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -510,7 +510,8 @@ const char *find_unique_abbrev(const unsigned char *sha1, int len)
 {
 	static int bufno;
 	static char hexbuffer[4][GIT_SHA1_HEXSZ + 1];
-	char *hex = hexbuffer[3 & ++bufno];
+	char *hex = hexbuffer[bufno];
+	bufno = (bufno + 1) % ARRAY_SIZE(hexbuffer);
 	find_unique_abbrev_r(hex, sha1, len);
 	return hex;
 }
-- 
2.10.2

