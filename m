Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MALFORMED_FREEMAIL,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9E2521F71B
	for <e@80x24.org>; Mon,  1 Aug 2016 11:45:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753318AbcHALpN (ORCPT <rfc822;e@80x24.org>);
	Mon, 1 Aug 2016 07:45:13 -0400
Received: from mout.gmx.net ([212.227.17.22]:52081 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753087AbcHALpI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Aug 2016 07:45:08 -0400
Received: from virtualbox ([37.24.142.100]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0MBFBB-1bbZdQ39Gv-00ACM1; Mon, 01 Aug 2016 13:44:05
 +0200
Date:	Mon, 1 Aug 2016 13:44:04 +0200 (CEST)
From:	Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	git@vger.kernel.org
cc:	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
	Duy Nguyen <pclouds@gmail.com>,
	=?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Subject: [PATCH v6 04/16] merge-recursive: clarify code in was_tracked()
In-Reply-To: <cover.1470051326.git.johannes.schindelin@gmx.de>
Message-ID: <5b581313f33ed2b924ad996c285509f9014bb863.1470051326.git.johannes.schindelin@gmx.de>
References: <cover.1469547160.git.johannes.schindelin@gmx.de> <cover.1470051326.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:Ue9A7sk70lEZ/jlviqTyw12oh+E3UIGC1nkIA9SZicybOCW68sO
 jC95GczNYUOG5ztCGIwIAsG3pm12KGrI64nboCgC52gDyhpB2scJlc7IwTyGGcRMImy84vt
 CqlGdRET9QOSgLIig3r3E+CXSZ5gVwAKWLfo/1wOApwvxrysO1E5067/qczU6PI942EtDER
 Kfcuh8BEr9tAdjrdTPCiw==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:jINO84XaLGs=:vdWilGPhiJDfgh/QOh77zH
 NwY0HSJeCm++VWmAHHUOCfZAMwluY8zPF5AHB63b0Y/AVaQ1kciF3E+F9w4vWyfRLMEg54Ilt
 S7K1OBuFQlIM0irhaTXCXep9g3jXmSBSGR5S8XI5UjuSNGK+DJSbzpzRdeMBF6E/G24W7390v
 hnPfdoXqYg1EITDVxR7ICPrUTL7qVffNZE0s2LXUDzxRuO/vZVe3vjkWT0gVKw7kE+hzyEgnf
 i2EtkvEaw46iZx5nNphA/kyryWRORUmuy5wUl6CWB1UnOjHhF3lnoqf6T9KOGlsbJzP0Nn/8K
 WMP7VEOoTi902AOCjOsz9BZ/QNTlzyPFOEW1bgm7p54w+wVnqknSwFTxqqpX7qeMeFPMoDq/y
 SFbEV6rHFVB2DJEWK9Kh6/ZSyqy05p28yXwg3G+ODc/c4LAhaUEdTYdqwgLURQ6xjRyqv3zAo
 FDx8woQUhypoFVgL4LSxZ5vWQWXIvXsBFB/m1vB3bAmQssVVtbEYQWCEFCiK9/NKiR1P2OpZ3
 2NutuOPoc1AMKQgnr9mzoSawlsPFH75X+8UW7htHfizTyah2d9ehVOrtPirilyA2+wak5rN8j
 uDkFpJmrfgs/2QDDcR4PNbrFW1+1iB4qANerlTph6DkS8g9A8O0dIDm/uDp6O1UirVRtQ5TUp
 683PUcs+iHLnweuPxXAN+AqWrdQKCcXm/SEYoOUlDswaBXWHhdxJVYsEfkGYc/hJ+3r1vt74e
 2YKh+hRNlvYMHtTXnf67mwB8zYon8l6UCymrYTDvk2QZbPrB2wwoltKLhzAxnWgU7hEfImpoB
 6QGt0kv
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
index 1b6db87..3a652b7 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -667,23 +667,21 @@ static int was_tracked(const char *path)
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


