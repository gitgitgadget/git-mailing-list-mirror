From: Fredrik Kuivinen <freku045@student.liu.se>
Subject: [PATCH] blame: Fix path pruning
Date: Wed, 03 May 2006 23:28:46 +0200
Message-ID: <20060503212846.19769.18688.stgit@c165>
Cc: junkio@cox.net
X-From: git-owner@vger.kernel.org Wed May 03 23:28:57 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FbOtw-00078N-AB
	for gcvg-git@gmane.org; Wed, 03 May 2006 23:28:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751356AbWECV2t (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 3 May 2006 17:28:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751357AbWECV2s
	(ORCPT <rfc822;git-outgoing>); Wed, 3 May 2006 17:28:48 -0400
Received: from 85.8.31.11.se.wasadata.net ([85.8.31.11]:22764 "EHLO
	mail6.wasadata.com") by vger.kernel.org with ESMTP id S1751356AbWECV2s
	(ORCPT <rfc822;git@vger.kernel.org>); Wed, 3 May 2006 17:28:48 -0400
Received: from c165 (85.8.2.189.se.wasadata.net [85.8.2.189])
	by mail6.wasadata.com (Postfix) with ESMTP
	id 1184840FD; Wed,  3 May 2006 23:47:37 +0200 (CEST)
Received: from c165 ([127.0.0.1])
	by c165 with esmtp (Exim 3.36 #1 (Debian))
	id 1FbOtq-00058y-00; Wed, 03 May 2006 23:28:46 +0200
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19522>


This makes git-blame useable again, it has been totally broken for
some time on larger repositories.

Signed-off-by: Fredrik Kuivinen <freku045@student.liu.se>

---

 blame.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/blame.c b/blame.c
index 07d2d27..99ceea8 100644
--- a/blame.c
+++ b/blame.c
@@ -515,9 +515,9 @@ static int compare_tree_path(struct rev_
 	paths[1] = NULL;
 
 	diff_tree_setup_paths(get_pathspec(revs->prefix, paths),
-			      &revs->diffopt);
+			      &revs->pruning);
 	ret = rev_compare_tree(revs, c1->tree, c2->tree);
-	diff_tree_release_paths(&revs->diffopt);
+	diff_tree_release_paths(&revs->pruning);
 	return ret;
 }
 
@@ -531,9 +531,9 @@ static int same_tree_as_empty_path(struc
 	paths[1] = NULL;
 
 	diff_tree_setup_paths(get_pathspec(revs->prefix, paths),
-			      &revs->diffopt);
+			      &revs->pruning);
 	ret = rev_same_tree_as_empty(revs, t1);
-	diff_tree_release_paths(&revs->diffopt);
+	diff_tree_release_paths(&revs->pruning);
 	return ret;
 }
 
@@ -834,7 +834,7 @@ int main(int argc, const char **argv)
 
 	args[0] = filename;
 	args[1] = NULL;
-	diff_tree_setup_paths(args, &rev.diffopt);
+	diff_tree_setup_paths(args, &rev.pruning);
 	prepare_revision_walk(&rev);
 	process_commits(&rev, filename, &initial);
 
