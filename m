X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Michael <barra_cuda@katamail.com>
Subject: [PATCH] Remove unneeded parameters in diff_unmerge() and diff_get_patch_id()
Date: Sat, 11 Nov 2006 18:55:17 +0100
Message-ID: <200611111855.17579.barra_cuda@katamail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Sat, 11 Nov 2006 17:53:24 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: KMail/1.9.4
Content-Disposition: inline
Original-Message-ID: <20061111175303.401526@dial-up-mi-301.lombardiacom.it>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gix2X-0002op-HS for gcvg-git@gmane.org; Sat, 11 Nov
 2006 18:53:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1753402AbWKKRxG (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 11 Nov 2006
 12:53:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753534AbWKKRxG
 (ORCPT <rfc822;git-outgoing>); Sat, 11 Nov 2006 12:53:06 -0500
Received: from fe-3c.inet.it ([213.92.5.106]:56739 "EHLO fe-3c.inet.it") by
 vger.kernel.org with ESMTP id S1753402AbWKKRxF (ORCPT
 <rfc822;git@vger.kernel.org>); Sat, 11 Nov 2006 12:53:05 -0500
Received: from dial-up-mi-301.lombardiacom.it ([::ffff:212.34.226.47]) by
 fe-3c.inet.it via I-SMTP-5.4.4-546 id ::ffff:212.34.226.47+Ti8rUNtp6xH; Sat,
 11 Nov 2006 18:53:01 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Signed-off-by: Michael <barra_cuda@katamail.com>
---
 diff-lib.c |    4 ++--
 diff.c     |    7 +++----
 diff.h     |    3 +--
 3 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/diff-lib.c b/diff-lib.c
index fc69fb9..df5c793 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -97,7 +97,7 @@ int run_diff_files(struct rev_info *revs
 			 * Show the diff for the 'ce' if we found the one
 			 * from the desired stage.
 			 */
-			diff_unmerge(&revs->diffopt, ce->name);
+			diff_unmerge(ce->name);
 			if (ce_stage(ce) != diff_unmerged_stage)
 				continue;
 		}
@@ -299,7 +299,7 @@ static int diff_cache(struct rev_info *r
 				break;
 			/* fallthru */
 		case 3:
-			diff_unmerge(&revs->diffopt, ce->name);
+			diff_unmerge(ce->name);
 			break;
 
 		default:
diff --git a/diff.c b/diff.c
index fb82432..6fda65b 100644
--- a/diff.c
+++ b/diff.c
@@ -2448,7 +2448,7 @@ static void patch_id_consume(void *priv,
 }
 
 /* returns 0 upon success, and writes result into sha1 */
-static int diff_get_patch_id(struct diff_options *options, unsigned char 
*sha1)
+static int diff_get_patch_id(unsigned char *sha1)
 {
 	struct diff_queue_struct *q = &diff_queued_diff;
 	int i;
@@ -2540,7 +2540,7 @@ int diff_flush_patch_id(struct diff_opti
 {
 	struct diff_queue_struct *q = &diff_queued_diff;
 	int i;
-	int result = diff_get_patch_id(options, sha1);
+	int result = diff_get_patch_id(sha1);
 
 	for (i = 0; i < q->nr; i++)
 		diff_free_filepair(q->queue[i]);
@@ -2794,8 +2794,7 @@ void diff_change(struct diff_options *op
 	diff_queue(&diff_queued_diff, one, two);
 }
 
-void diff_unmerge(struct diff_options *options,
-		  const char *path)
+void diff_unmerge(const char *path)
 {
 	struct diff_filespec *one, *two;
 	one = alloc_filespec(path);
diff --git a/diff.h b/diff.h
index b48c991..65a14e6 100644
--- a/diff.h
+++ b/diff.h
@@ -138,8 +138,7 @@ extern void diff_change(struct diff_opti
 			const unsigned char *sha2,
 			const char *base, const char *path);
 
-extern void diff_unmerge(struct diff_options *,
-			 const char *path);
+extern void diff_unmerge(const char *path);
 
 extern int diff_scoreopt_parse(const char *opt);
 
-- 
1.4.3.3
