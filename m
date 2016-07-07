Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5DF1F2070D
	for <e@80x24.org>; Thu,  7 Jul 2016 14:36:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752587AbcGGOfy (ORCPT <rfc822;e@80x24.org>);
	Thu, 7 Jul 2016 10:35:54 -0400
Received: from mout.gmx.net ([212.227.17.20]:58619 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752528AbcGGOfw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jul 2016 10:35:52 -0400
Received: from virtualbox ([37.24.141.253]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0MOfQw-1bF8mg3pp8-0065bk; Thu, 07 Jul 2016 16:35:33
 +0200
Date:	Thu, 7 Jul 2016 16:35:31 +0200 (CEST)
From:	Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	git@vger.kernel.org
cc:	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
	Duy Nguyen <pclouds@gmail.com>,
	=?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Subject: [PATCH v3 04/16] merge-recursive: clarify code in was_tracked()
In-Reply-To: <cover.1467902082.git.johannes.schindelin@gmx.de>
Message-ID: <e4b7334e4623e9b654ab1c18c4c9d95a75ddb59b.1467902083.git.johannes.schindelin@gmx.de>
References: <cover.1467717729.git.johannes.schindelin@gmx.de> <cover.1467902082.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:jDcOMUbRbLoXNgzxdfqTNgnyJ7aUtv/m5UK0ekEvgIaGtL6FNjZ
 TLVQcdayBaKMNgT5MMoS5i45tO30r2qgnFw9I7PwdbJxxVVa4ZbAa0OGVgeU8tjg9hdzvvJ
 F7lggr2481LPTHuukh+1/Y7tvBCMZwV8uVTRXx4XKaygSd/CUEFt1Szsft5JQ4KBMiOf1W+
 QHv+KvXEPxZAspHDPNX/A==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:WIPDX9UpjUs=:uDax671s3m/zfM2xNMCssF
 YHWKDe3SRDL54GL0QnxGspT3si9MIg2GDlScaPbh+HmL6tmd0NAiqcuCpZ23YdmA5oDoKwq8s
 +4SimUxpw8ICIjPVm0kDoDBoMkyl59OvoIXgq63cXRZH2LvprkJ/TLhIjtnkRLSBuSg1uVCnT
 VZDFwV+AiDY8BUYbp24zp9vAI+pgqgWT6t88rCfwTjdAyCOtGuAKdnVuU83rmYoMGQuSaiO5X
 8egKoJJShbI/kfv6vFGDCS9hchgJ65UI4M9kk6Jka7SkhEcebFXrRsh9pQp2wMzVMM2uRZr9y
 PqAChJoBCqzFER6oVTek/BMniEYnrLNOc9ikVHk6IquRLI5/Iqp7JkCYmuVIfzGnDJJASBMZ/
 bKguTiS0t0pVCISRL+6HPoTT2yrsC4DTI41UoU9ULCteg87aZBAupF5rW4Y09GJXp2qBkF33W
 TN2bVCvOtRr+D6czafQPRAcJwKunU2wEIQdgldXroEVWS7wc2l0IFfUjKp068vmG2gVBeSeU/
 xJcQGt85DYKGvUr3zJCysLnxmSdtQKZ3X6Ue0n3xrC12GL9ykfG1slOHkK6TGAtrkQtD4sRIQ
 fiUQUNcjrUU1y9szQqS3/IbtUORUxr93u/77esWhaU6l5EgX8QMn9n6rtgyt++gTytbIxm6Fh
 fUm5gbgYqwhYF9+FpUV0424nRUebYKXgMRG6QOYe4/zjh0XX4H3ZrVdJ/52sGlbt41SqhEK6p
 DTvjWRALZKbvRk60mQjvsJpul8JMCwZtQuNzn3Lc/F/Nzrbl6QWTCklhlcscZzy4QpIvxlbgr
 kltFIwY
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

It can be puzzling to see that was_tracked() asks to get an index entry
by name, but does not take a negative return value for an answer.

The reason we have to do this is that cache_name_pos() only looks for
entries in stage 0, even if nobody asked for any stage in particular.

Let's rewrite the logic a little bit, to handle the easy case early: if
cache_name_pos() returned a non-negative position, we know it is a match,
and we do not even have to compare the name again (cache_name_pos() did
that for us already). We can say right away: yes, this file was tracked.

Only if there was no exact match do we need to look harder for any
matching entry in stage 2.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 merge-recursive.c | 30 ++++++++++++++----------------
 1 file changed, 14 insertions(+), 16 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index ea0df22..469741d 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -658,23 +658,21 @@ static int was_tracked(const char *path)
 {
 	int pos = cache_name_pos(path, strlen(path));
 
-	if (pos < 0)
-		pos = -1 - pos;
-	while (pos < active_nr &&
-	       !strcmp(path, active_cache[pos]->name)) {
-		/*
-		 * If stage #0, it is definitely tracked.
-		 * If it has stage #2 then it was tracked
-		 * before this merge started.  All other
-		 * cases the path was not tracked.
-		 */
-		switch (ce_stage(active_cache[pos])) {
-		case 0:
-		case 2:
+	if (0 <= pos)
+		/* we have been tracking this path */
+		return 1;
+
+	/*
+	 * Look for an unmerged entry for the path,
+	 * specifically stage #2, which would indicate
+	 * that "our" side before the merge started
+	 * had the path tracked (and resulted in a conflict).
+	 */
+	for (pos = -1 - pos;
+	     pos < active_nr && !strcmp(path, active_cache[pos]->name);
+	     pos++)
+		if (ce_stage(active_cache[pos]) == 2)
 			return 1;
-		}
-		pos++;
-	}
 	return 0;
 }
 
-- 
2.9.0.278.g1caae67


