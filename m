X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-2.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD,UNWANTED_LANGUAGE_BODY shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 4/4] xdl_merge(): fix thinko
Date: Thu, 30 Nov 2006 00:25:11 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0611300024350.30004@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Wed, 29 Nov 2006 23:25:42 +0000 (UTC)
Cc: junkio@cox.net
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32677>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GpYnm-0004iM-AM for gcvg-git@gmane.org; Thu, 30 Nov
 2006 00:25:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1758981AbWK2XZO (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 29 Nov 2006
 18:25:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758982AbWK2XZO
 (ORCPT <rfc822;git-outgoing>); Wed, 29 Nov 2006 18:25:14 -0500
Received: from mail.gmx.net ([213.165.64.20]:61830 "HELO mail.gmx.net") by
 vger.kernel.org with SMTP id S1758981AbWK2XZN (ORCPT
 <rfc822;git@vger.kernel.org>); Wed, 29 Nov 2006 18:25:13 -0500
Received: (qmail invoked by alias); 29 Nov 2006 23:25:11 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp028) with SMTP; 30 Nov 2006 00:25:11 +0100
To: Davide Libenzi <davidel@xmailserver.org>, git@vger.kernel.org
Sender: git-owner@vger.kernel.org


If one side's block (of changed lines) ends later than the other
side's block, the former should be tested against the next block
of the other side, not vice versa.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 xdiff/xmerge.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/xdiff/xmerge.c b/xdiff/xmerge.c
index 9fe2059..6d4f9b6 100644
--- a/xdiff/xmerge.c
+++ b/xdiff/xmerge.c
@@ -318,13 +318,13 @@ static int xdl_do_merge(xdfenv_t *xe1, x
 			xscr1->i1 = i2;
 			xscr1->i2 += xscr1->chg2;
 			xscr1->chg2 = 0;
-			xscr1 = xscr1->next;
+			xscr2 = xscr2->next;
 		} else if (i2 > i1) {
 			xscr2->chg1 -= i2 - i1;
 			xscr2->i1 = i1;
 			xscr2->i2 += xscr2->chg2;
 			xscr2->chg2 = 0;
-			xscr2 = xscr2->next;
+			xscr1 = xscr1->next;
 		} else {
 			xscr1 = xscr1->next;
 			xscr2 = xscr2->next;
-- 
1.4.4.g5aac-dirty
