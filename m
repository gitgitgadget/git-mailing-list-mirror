From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 6/6] merge-recur: Explain why sha_eq() and struct stage_data
 cannot go
Date: Thu, 27 Jul 2006 19:14:17 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0607271913550.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Thu Jul 27 19:14:52 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G69RP-0002a6-Vo
	for gcvg-git@gmane.org; Thu, 27 Jul 2006 19:14:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751821AbWG0ROV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 27 Jul 2006 13:14:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751804AbWG0ROU
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Jul 2006 13:14:20 -0400
Received: from mail.gmx.net ([213.165.64.21]:2472 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751826AbWG0ROT (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 Jul 2006 13:14:19 -0400
Received: (qmail invoked by alias); 27 Jul 2006 17:14:18 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp042) with SMTP; 27 Jul 2006 19:14:18 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org, junkio@cox.net
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24314>


There were two TODOs to remove sha_eq() and to convert users of
struct stage_data to active_cache users, but this is not possible.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 merge-recursive.c |    9 ++++-----
 1 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index b0f2ecc..cb21bc5 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -47,8 +47,8 @@ static struct commit *make_virtual_commi
 }
 
 /*
- * TODO: we should not have to copy the SHA1s around, but rather reference
- * them. That way, sha_eq() is just sha1 == sha2.
+ * Since we use get_tree_entry(), which does not put the read object into
+ * the object pool, we cannot rely on a == b.
  */
 static int sha_eq(const unsigned char *a, const unsigned char *b)
 {
@@ -58,9 +58,8 @@ static int sha_eq(const unsigned char *a
 }
 
 /*
- * TODO: check if we can just reuse the active_cache structure: it is already
- * sorted (by name, stage).
- * Only problem: do not write it when flushing the cache.
+ * Since we want to write the index eventually, we cannot reuse the index
+ * for these (temporary) data.
  */
 struct stage_data
 {
-- 
1.4.2.rc2.g6a4e
