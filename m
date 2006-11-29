X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 3/4] xdl_merge(): fix an off-by-one bug
Date: Thu, 30 Nov 2006 00:24:32 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0611300024100.30004@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Wed, 29 Nov 2006 23:24:50 +0000 (UTC)
Cc: junkio@cox.net
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32676>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GpYn7-0004Wg-W7 for gcvg-git@gmane.org; Thu, 30 Nov
 2006 00:24:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1758980AbWK2XYf (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 29 Nov 2006
 18:24:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758981AbWK2XYe
 (ORCPT <rfc822;git-outgoing>); Wed, 29 Nov 2006 18:24:34 -0500
Received: from mail.gmx.net ([213.165.64.20]:61137 "HELO mail.gmx.net") by
 vger.kernel.org with SMTP id S1758976AbWK2XYe (ORCPT
 <rfc822;git@vger.kernel.org>); Wed, 29 Nov 2006 18:24:34 -0500
Received: (qmail invoked by alias); 29 Nov 2006 23:24:32 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp038) with SMTP; 30 Nov 2006 00:24:32 +0100
To: Davide Libenzi <davidel@xmailserver.org>, git@vger.kernel.org
Sender: git-owner@vger.kernel.org


The line range is i1 .. (i1 + chg1 - 1), not i1 .. (i1 + chg1).

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 xdiff/xmerge.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/xdiff/xmerge.c b/xdiff/xmerge.c
index 6b6fbb8..9fe2059 100644
--- a/xdiff/xmerge.c
+++ b/xdiff/xmerge.c
@@ -194,11 +194,11 @@ static int xdl_refine_conflicts(xdfenv_t
 		 * we have a very simple mmfile structure.
 		 */
 		t1.ptr = (char *)xe1->xdf2.recs[m->i1]->ptr;
-		t1.size = xe1->xdf2.recs[m->i1 + m->chg1]->ptr
-			+ xe1->xdf2.recs[m->i1 + m->chg1]->size - t1.ptr;
-		t2.ptr = (char *)xe2->xdf2.recs[m->i1]->ptr;
-		t2.size = xe2->xdf2.recs[m->i1 + m->chg1]->ptr
-			+ xe2->xdf2.recs[m->i1 + m->chg1]->size - t2.ptr;
+		t1.size = xe1->xdf2.recs[m->i1 + m->chg1 - 1]->ptr
+			+ xe1->xdf2.recs[m->i1 + m->chg1 - 1]->size - t1.ptr;
+		t2.ptr = (char *)xe2->xdf2.recs[m->i2]->ptr;
+		t2.size = xe2->xdf2.recs[m->i2 + m->chg2 - 1]->ptr
+			+ xe2->xdf2.recs[m->i2 + m->chg2 - 1]->size - t2.ptr;
 		if (xdl_do_diff(&t1, &t2, xpp, &xe) < 0)
 			return -1;
 		if (xdl_change_compact(&xe.xdf1, &xe.xdf2, xpp->flags) < 0 ||
-- 
1.4.4.g5aac-dirty
