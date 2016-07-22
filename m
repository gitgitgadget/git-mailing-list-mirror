Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AD33920195
	for <e@80x24.org>; Fri, 22 Jul 2016 12:25:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754011AbcGVMZT (ORCPT <rfc822;e@80x24.org>);
	Fri, 22 Jul 2016 08:25:19 -0400
Received: from mout.gmx.net ([212.227.15.19]:62893 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753981AbcGVMZQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jul 2016 08:25:16 -0400
Received: from virtualbox ([37.24.142.100]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0LaFmY-1b36r73VcM-00m2pT; Fri, 22 Jul 2016 14:25:07
 +0200
Date:	Fri, 22 Jul 2016 14:25:05 +0200 (CEST)
From:	Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	git@vger.kernel.org
cc:	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
	Duy Nguyen <pclouds@gmail.com>,
	=?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Subject: [PATCH v4 04/16] merge-recursive: clarify code in was_tracked()
In-Reply-To: <cover.1469187652.git.johannes.schindelin@gmx.de>
Message-ID: <79c0cf5a5d842b31f7393e335c52cd3c061381c2.1469187653.git.johannes.schindelin@gmx.de>
References: <cover.1467902082.git.johannes.schindelin@gmx.de> <cover.1469187652.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:R6/C698Jd5m6/q7u2sMIaV5PbuwJNTv7bA9z2au7V/SjvalukT8
 zwNhS51u9vXVir+v0rhs0wwJ7dmeGfkgJ1u0RCPluoOC0Qly9CVKH8cw4HDlG4vMpCkdsTU
 qd1HRXzRM0//tK3BPkaTHkS4ydv8DNsfNGy7vvbqvj5s477JQMHSMnVa5u6tbmzo0mAaJM+
 cIAZq+r/dkU2xpjGARC+A==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:dMvrFm6XP0E=:67j9/fnnenstXnMFZ8gQXE
 dP3HvSW3uzqpCaQQ71xR4QQiJ2/kaqU8fJCFpCp8egaDZZe+Mq3MGvEMlI+0osYjCshyMBZLw
 9d3FpoYmLctZpwYf8Ff7UqNV0hRHhx5CzIKXCxUUH6lZB16m49BBCJ+KaKfUtc9lcxkCMJiC/
 ku9IlSXawmE4XsWoV85SG7Ah3o/G32Gq77VVO90GwgIwKpVdL0hftPAxTkFE1/gcVGyAYUpEX
 yW5a/4aRwOz5wdnonAox70medz2s91p9UzXzvmnL2yMTBokSAujAL6vuDREsgbd3klXvI+2qf
 xIdh4vj/7RblOFGxKiCyoW6gzs3YANP5DBl2QU4bTj1gY35wsYGFEHkQ8gJMia6NuWBlRoxpa
 i43f2uEL9PCpWFqrA41SoHLAi/wzZFYxiF19IHpxSQhzphr0gcGc3vNJth+x8VtZNXUOREQQ8
 6k+TotxAnjpsmM2WVOL7PV1ta6u5mt1hgiWd7+gaGnJTklknsIrGWpTKjZS5GUHqE6v65dyCU
 k5fQXd16SO/8PwDhghObR0LVnH+XzuAouUXdToii4o7GbBgfqlPaK01l/ejqmKVjuJ4sGVraD
 OdmNYxLqJ1yBIHQEK4XBGSvIGzX2UpIdy/H5J8EtmewttSQ5uWFaU4MD4C8TO4ypDhlGGDHfX
 r785LqBBJGRqz75l9EgsdAsju6z/50FTQsGctKTnX2RN/W6eq1CDnSXxIYDtmHToDteK59J8V
 pDotED2taynyvfK+YtE8aMI9OmtplSwiyKb2JbSVatXCyZ1qu9ABZxsIZHv4YdSzcHztIP3/Q
 qbUsase
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
index e0d5a57..dc3182b 100644
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
2.9.0.281.g286a8d9


