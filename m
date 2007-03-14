From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 4/5] revision.c: explain what tree_difference does
Date: Wed, 14 Mar 2007 14:26:51 -0700
Message-ID: <7vd53b7bz8.fsf@assigned-by-dhcp.cox.net>
References: <7vwt1j8z0e.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 14 22:27:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HRb06-0002bm-PZ
	for gcvg-git@gmane.org; Wed, 14 Mar 2007 22:27:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751623AbXCNV1D (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Mar 2007 17:27:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751658AbXCNV1B
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Mar 2007 17:27:01 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:48514 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751625AbXCNV1A (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Mar 2007 17:27:00 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070314212653.VQTU321.fed1rmmtao107.cox.net@fed1rmimpo02.cox.net>;
          Wed, 14 Mar 2007 17:26:53 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id alSr1W00Z1kojtg0000000; Wed, 14 Mar 2007 17:26:51 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42233>

This explains how tree_difference variable is used, and updates two
places where the code knows symbolic constant REV_TREE_SAME is 0.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 revision.c |   11 +++++++++--
 1 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/revision.c b/revision.c
index 3c2eb12..129d197 100644
--- a/revision.c
+++ b/revision.c
@@ -213,6 +213,13 @@ static int everybody_uninteresting(struct commit_list *orig)
 	return 1;
 }
 
+/*
+ * The goal is to get REV_TREE_NEW as the result only if the
+ * diff consists of all '+' (and no other changes), and
+ * REV_TREE_DIFFERENT otherwise (of course if the trees are
+ * the same we want REV_TREE_SAME).  That means that once we
+ * get to REV_TREE_DIFFERENT, we do not have to look any further.
+ */
 static int tree_difference = REV_TREE_SAME;
 
 static void file_add_remove(struct diff_options *options,
@@ -277,11 +284,11 @@ int rev_same_tree_as_empty(struct rev_info *revs, struct tree *t1)
 	empty.buf = "";
 	empty.size = 0;
 
-	tree_difference = 0;
+	tree_difference = REV_TREE_SAME;
 	retval = diff_tree(&empty, &real, "", &revs->pruning);
 	free(tree);
 
-	return retval >= 0 && !tree_difference;
+	return retval >= 0 && (tree_difference == REV_TREE_SAME);
 }
 
 static void try_to_simplify_commit(struct rev_info *revs, struct commit *commit)
-- 
1.5.0.3.1036.g6baf1
