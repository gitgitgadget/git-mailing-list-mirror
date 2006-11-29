X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 2/4] xdl_merge(): do return number of conflicts
Date: Thu, 30 Nov 2006 00:24:04 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0611300023330.30004@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Wed, 29 Nov 2006 23:24:23 +0000 (UTC)
Cc: junkio@cox.net
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32675>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GpYmi-0004Qz-QI for gcvg-git@gmane.org; Thu, 30 Nov
 2006 00:24:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1758973AbWK2XYJ (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 29 Nov 2006
 18:24:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758976AbWK2XYJ
 (ORCPT <rfc822;git-outgoing>); Wed, 29 Nov 2006 18:24:09 -0500
Received: from mail.gmx.net ([213.165.64.20]:60603 "HELO mail.gmx.net") by
 vger.kernel.org with SMTP id S1758973AbWK2XYH (ORCPT
 <rfc822;git@vger.kernel.org>); Wed, 29 Nov 2006 18:24:07 -0500
Received: (qmail invoked by alias); 29 Nov 2006 23:24:05 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp032) with SMTP; 30 Nov 2006 00:24:05 +0100
To: Davide Libenzi <davidel@xmailserver.org>, git@vger.kernel.org
Sender: git-owner@vger.kernel.org


If no error occurred during merge, xdl_merge() is supposed to return
the number of conflicts.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>

---
 xdiff/xmerge.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/xdiff/xmerge.c b/xdiff/xmerge.c
index 7b85aa5..6b6fbb8 100644
--- a/xdiff/xmerge.c
+++ b/xdiff/xmerge.c
@@ -384,6 +384,7 @@ int xdl_merge(mmfile_t *orig, mmfile_t *
 		xpparam_t const *xpp, int level, mmbuffer_t *result) {
 	xdchange_t *xscr1, *xscr2;
 	xdfenv_t xe1, xe2;
+	int ret = 0;
 
 	result->ptr = NULL;
 	result->size = 0;
@@ -413,9 +414,9 @@ int xdl_merge(mmfile_t *orig, mmfile_t *
 			result->ptr = xdl_malloc(mf1->size);
 			memcpy(result->ptr, mf1->ptr, mf1->size);
 			result->size = mf1->size;
-		} else if (xdl_do_merge(&xe1, xscr1, name1,
+		} else if ((ret = xdl_do_merge(&xe1, xscr1, name1,
 					&xe2, xscr2, name2,
-					level, xpp, result) < 0) {
+					level, xpp, result)) < 0) {
 			xdl_free_script(xscr1);
 			xdl_free_script(xscr2);
 			xdl_free_env(&xe1);
@@ -428,6 +429,6 @@ int xdl_merge(mmfile_t *orig, mmfile_t *
 	xdl_free_env(&xe1);
 	xdl_free_env(&xe2);
 
-	return 0;
+	return ret;
 }
 
-- 
1.4.4.g5aac-dirty
