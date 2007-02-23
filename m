From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] git-diff: fix combined diff
Date: Fri, 23 Feb 2007 05:20:32 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702230517480.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, junkio@cox.net
X-From: git-owner@vger.kernel.org Fri Feb 23 05:20:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HKRvK-0000eZ-OZ
	for gcvg-git@gmane.org; Fri, 23 Feb 2007 05:20:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750855AbXBWEUf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Feb 2007 23:20:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750861AbXBWEUf
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Feb 2007 23:20:35 -0500
Received: from mail.gmx.net ([213.165.64.20]:38773 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750855AbXBWEUe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Feb 2007 23:20:34 -0500
Received: (qmail invoked by alias); 23 Feb 2007 04:20:32 -0000
X-Provags-ID: V01U2FsdGVkX1+TqZddr/ST6X1f0JIV5OLidb1NyfiLEtGEipb4Q2
	ZzNQ==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40412>


With "const unsigned (*parent)[20]", "parent + 1" is not the
same as "&parent[1]"...

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
---

	I triggered this bug by "git diff a...b", where a and b
	have 4 merge bases. I am really too tired to add a test
	case, though...

 builtin-diff.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/builtin-diff.c b/builtin-diff.c
index 9334589..846cafb 100644
--- a/builtin-diff.c
+++ b/builtin-diff.c
@@ -158,7 +158,8 @@ static int builtin_diff_combined(struct rev_info *revs,
 	parent = xmalloc(ents * sizeof(*parent));
 	/* Again, the revs are all reverse */
 	for (i = 0; i < ents; i++)
-		hashcpy((unsigned char*)parent + i, ent[ents - 1 - i].item->sha1);
+		hashcpy((unsigned char*)&parent[i],
+				ent[ents - 1 - i].item->sha1);
 	diff_tree_combined(parent[0], parent + 1, ents - 1,
 			   revs->dense_combined_merges, revs);
 	return 0;
-- 
1.5.0.1.2218.g2de79
