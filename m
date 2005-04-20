From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 3/4] Use tree_from_tree_or_commit() in diff-tree.
Date: Tue, 19 Apr 2005 23:10:26 -0700
Message-ID: <7v8y3ekmgd.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 20 08:07:07 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DO8MC-0006Tq-Tw
	for gcvg-git@gmane.org; Wed, 20 Apr 2005 08:06:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261431AbVDTGKs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Apr 2005 02:10:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261433AbVDTGKs
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Apr 2005 02:10:48 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:61333 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S261431AbVDTGK3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Apr 2005 02:10:29 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050420061026.MSLT15592.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 20 Apr 2005 02:10:26 -0400
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This patch makes diff-tree accept either tree or commit.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 diff-tree.c |   12 +++++++-----
 1 files changed, 7 insertions(+), 5 deletions(-)

--- a/diff-tree.c
+++ b/diff-tree.c
@@ -160,18 +160,20 @@ static int diff_tree(void *tree1, unsign
 	return 0;
 }
 
-static int diff_tree_sha1(const unsigned char *old, const unsigned char *new, const char *base)
+static int diff_tree_sha1(const unsigned char *old,
+			  const unsigned char *new,
+			  const char *base)
 {
 	void *tree1, *tree2;
 	unsigned long size1, size2;
 	char type[20];
 	int retval;
 
-	tree1 = read_sha1_file(old, type, &size1);
-	if (!tree1 || strcmp(type, "tree"))
+	tree1 = tree_from_tree_or_commit(old, type, &size1);
+	if (!tree1)
 		die("unable to read source tree (%s)", sha1_to_hex(old));
-	tree2 = read_sha1_file(new, type, &size2);
-	if (!tree2 || strcmp(type, "tree"))
+	tree2 = tree_from_tree_or_commit(new, type, &size2);
+	if (!tree2)
 		die("unable to read destination tree (%s)", sha1_to_hex(new));
 	retval = diff_tree(tree1, size1, tree2, size2, base);
 	free(tree1);

