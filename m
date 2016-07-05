Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 545092023C
	for <e@80x24.org>; Tue,  5 Jul 2016 11:23:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932846AbcGELXo (ORCPT <rfc822;e@80x24.org>);
	Tue, 5 Jul 2016 07:23:44 -0400
Received: from mout.gmx.net ([212.227.15.19]:54457 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755001AbcGELXc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jul 2016 07:23:32 -0400
Received: from virtualbox ([37.24.141.253]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0LlDb4-1bu0eD3O58-00b3xE; Tue, 05 Jul 2016 13:23:23
 +0200
Date:	Tue, 5 Jul 2016 13:23:22 +0200 (CEST)
From:	Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	git@vger.kernel.org
cc:	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
	Duy Nguyen <pclouds@gmail.com>
Subject: [PATCH v2 04/17] merge-recursive: clarify code in was_tracked()
In-Reply-To: <cover.1467717729.git.johannes.schindelin@gmx.de>
Message-ID: <69fc0a26854c89f35c1fb0e61d15f1fce82bef1c.1467717730.git.johannes.schindelin@gmx.de>
References: <cover.1467199553.git.johannes.schindelin@gmx.de> <cover.1467717729.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:55FQ05/oiK4YHoZ98JeFSHXBTkZZfNzpxGZ0k2hAuVmSvnKteFl
 KLerLywsX24sBFvSR8be659id401Ht2WthK6LqTIGylVviAs0DAGy1Nw0AHkkRg3kiQ+pWn
 JgqIaHRcc8lHf5ZXcLdibUyovJc/EGOuJ/+A4aHwTfv0rpa6DQPq4Xzckdg0sIPXxguoRb2
 FRtMOEW5yV9jW3D7MVSxA==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:SdS7OepkCw8=:M+aspM8EDwe2w1L0UU3Rus
 Xg6k0cIlhdmOB/W79a0hRb62r2k9QN0njimqUsoIK5dnwNNYvrzFMYrnr3bHLn0iySxkTypN5
 U7Yj2ndR29fd9SczXbbQdjbB6DonHaGrm3HvQ9Z+4a07sTu77g32aN3tztZ5Fd0T1TvMAs7Rj
 7xuhouZjIvV13gE0LuZ7hQnDSzEgnN1Ykl9RwGUapo/sHh7NN43YU9G5ehcfPP8OOZWIb6gSo
 V5FfTYzlzZSn1LBdRSCMUEfyw2hT6tk2oL1Mh2C5woRFSiJ2ty4hFTsWbt5j1XQhGpgJJlv3Y
 eM2bhDBR1oQ75SF7g/iIAgLwVSNwm2lUAwIk4YPdfhaVZ1HrcPgB/34zfIzUdgJ1x9kzluAZv
 vOtBaJqUhPL5qBiOoTfPCq24urL8+SN+yeh0FBXOacUuDlafuuPRmvA5TYirHTCISBO6boIWV
 M+gwXXGTcG7ibu4DAgF4x+pVO4q2C+Ty4nYqNcrWAj9wtRdXFR1Y4fZ4PNohMY8/3sYnFs9jx
 HhNQbt69FLSTnqsU1Uw36198XliMVXUOkqbrZpmhlmDRWSJkwoCZAmDCTg4bDlct+XEG9glzl
 b0zXD9wvanGCUlpxI7DDX7OA36hanoDSeuJEU1prZC4E0ia3LRtIKeMlJbgBYkASggXcdu1Ow
 TGrCXXk5cG58nARZVFuK4v//7GD32aNI29KyDNowv3q+NtzQ1+n1Lygd2Gp4VFohll4oj51Hx
 SvzrSrCGmbY3+1CaXa5oXyNPmzyZ4LxnEHPfvIlbMHnqAe015YoexGaVDrmtfFDm/EBujkN4v
 eRMFMLo
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
 merge-recursive.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index e51f8fc..66ce27c 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -658,23 +658,22 @@ static int was_tracked(const char *path)
 {
 	int pos = cache_name_pos(path, strlen(path));
 
-	if (pos < 0)
-		pos = -1 - pos;
-	while (pos < active_nr &&
-	       !strcmp(path, active_cache[pos]->name)) {
+	if (pos >= 0)
+		return pos < active_nr;
+	/*
+	 * cache_name_pos() looks for stage == 0, even if we did not ask for
+	 * it. Let's look for stage == 2 now.
+	 */
+	for (pos = -1 - pos; pos < active_nr &&
+	     !strcmp(path, active_cache[pos]->name); pos++)
 		/*
 		 * If stage #0, it is definitely tracked.
 		 * If it has stage #2 then it was tracked
 		 * before this merge started.  All other
 		 * cases the path was not tracked.
 		 */
-		switch (ce_stage(active_cache[pos])) {
-		case 0:
-		case 2:
+		if (ce_stage(active_cache[pos]) == 2)
 			return 1;
-		}
-		pos++;
-	}
 	return 0;
 }
 
-- 
2.9.0.280.g32e2a70


