X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andy Parkins <andyparkins@gmail.com>
Subject: [PATCH] Comment diff_tree
Date: Mon, 11 Dec 2006 22:13:06 +0000
Message-ID: <200612112213.06547.andyparkins@gmail.com>
References: <f323e83a37efd3b913004666f2fc104578a92833.1165875140.git.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Mon, 11 Dec 2006 22:16:17 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:in-reply-to:references:from:date:subject:to:x-tuid:x-uid:x-length:mime-version:content-transfer-encoding:content-disposition;
        b=SfaNZLYEG96aYUDftLbeYeaSMtIj1cKQc1z12NctX0AtxvfBAA89URqWL2ndq98JZR84YOI6w8bMSX6U1weTxnqJui0ghWz3Pbqqy31kc9TSy4+sD48ZugtkBqSRWpvaUB+MasT+/kCTsF7KtdzXGJiJdSxcy5mXj+ndcVWYjCo=
In-Reply-To: <f323e83a37efd3b913004666f2fc104578a92833.1165875140.git.andyparkins@gmail.com>
X-TUID: ddca45d095b42a2b
X-UID: 186
X-Length: 2432
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34044>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GttRP-0000XO-4M for gcvg-git@gmane.org; Mon, 11 Dec
 2006 23:16:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1763166AbWLKWQD (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 11 Dec 2006
 17:16:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763169AbWLKWQD
 (ORCPT <rfc822;git-outgoing>); Mon, 11 Dec 2006 17:16:03 -0500
Received: from ug-out-1314.google.com ([66.249.92.172]:15250 "EHLO
 ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S1763165AbWLKWQA (ORCPT <rfc822;git@vger.kernel.org>); Mon, 11 Dec
 2006 17:16:00 -0500
Received: by ug-out-1314.google.com with SMTP id 44so1471083uga for
 <git@vger.kernel.org>; Mon, 11 Dec 2006 14:15:59 -0800 (PST)
Received: by 10.78.158.11 with SMTP id g11mr1716453hue.1165875359040; Mon, 11
 Dec 2006 14:15:59 -0800 (PST)
Received: from grissom.internal.parkins.org.uk ( [84.201.153.164]) by
 mx.google.com with ESMTP id 28sm2918526hua.2006.12.11.14.15.58; Mon, 11 Dec
 2006 14:15:58 -0800 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Signed-off-by: Andy Parkins <andyparkins@gmail.com>
---
 tree-diff.c |   17 ++++++++++++++---
 1 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/tree-diff.c b/tree-diff.c
index 37d235e..009dd17 100644
--- a/tree-diff.c
+++ b/tree-diff.c
@@ -160,33 +160,44 @@ static void show_entry(struct diff_options *opt, const char *prefix, struct tree
 
 int diff_tree(struct tree_desc *t1, struct tree_desc *t2, const char *base, struct diff_options *opt)
 {
+	/* While there are entries left in t1 or t2... */
 	while (t1->size | t2->size) {
 		if (opt->nr_paths && t1->size && !interesting(t1, base, opt)) {
+			/* If there are paths left in t1, and the current path is
+			 * not interesting, skip it and try the next path in t1 */
 			update_tree_entry(t1);
 			continue;
 		}
 		if (opt->nr_paths && t2->size && !interesting(t2, base, opt)) {
+			/* If there are paths left in t2, and the current path is
+			 * not interesting, skip it and try the next path in t2 */
 			update_tree_entry(t2);
 			continue;
 		}
+		/* Here if either
+		 *  - Either t1 or t2 path is available and interesting
+		 *  - No paths available */
 		if (!t1->size) {
+			/* If there is no path left in t1, then t2 is a new path */
 			show_entry(opt, "+", t2, base);
 			update_tree_entry(t2);
 			continue;
 		}
 		if (!t2->size) {
+			/* If there is no path left in t2, then t1 is a remed path */
 			show_entry(opt, "-", t1, base);
 			update_tree_entry(t1);
 			continue;
 		}
+		/* If both paths are available and interesting then it is a change */
 		switch (compare_tree_entry(t1, t2, base, opt)) {
-		case -1:
+		case -1: /* Finished with the path in t1 */
 			update_tree_entry(t1);
 			continue;
-		case 0:
+		case 0:  /* Finished with both paths */
 			update_tree_entry(t1);
 			/* Fallthrough */
-		case 1:
+		case 1: /* Finished with the path in t2 */
 			update_tree_entry(t2);
 			continue;
 		}
-- 
1.4.4.1.geeee8

