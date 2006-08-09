From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] merge-recur: do not die unnecessarily
Date: Wed, 9 Aug 2006 22:31:49 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0608092231260.13885@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Wed Aug 09 22:32:04 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GAuiY-0002NV-Tr
	for gcvg-git@gmane.org; Wed, 09 Aug 2006 22:31:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751147AbWHIUbw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 9 Aug 2006 16:31:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751315AbWHIUbw
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Aug 2006 16:31:52 -0400
Received: from mail.gmx.net ([213.165.64.20]:38029 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751147AbWHIUbv (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 9 Aug 2006 16:31:51 -0400
Received: (qmail invoked by alias); 09 Aug 2006 20:31:49 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp008) with SMTP; 09 Aug 2006 22:31:49 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org, junkio@cox.net
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25144>


When the cache is dirty, and we switch the index file from temporary
to final, we want to discard the cache without complaint.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 merge-recursive.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 2d3ab4f..be97752 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -139,8 +139,10 @@ static int flush_cache(void)
 static void setup_index(int temp)
 {
 	current_index_file = temp ? temporary_index_file: original_index_file;
-	if (cache_dirty)
-		die("fatal: cache changed flush_cache();");
+	if (cache_dirty) {
+		discard_cache();
+		cache_dirty = 0;
+	}
 	unlink(temporary_index_file);
 	discard_cache();
 }
-- 
1.4.2.rc3.g29d0-dirty
