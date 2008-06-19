From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH 02/11] Move commit_list_count() to commit.c
Date: Fri, 20 Jun 2008 01:22:27 +0200
Message-ID: <45f73cd0355a5375dcd8a123dd0facf5cad99061.1213917600.git.vmiklos@frugalware.org>
References: <cover.1213917600.git.vmiklos@frugalware.org>
 <b9fc7f1cc6c36ba197ed2c0394a6b89ed33c4b96.1213917600.git.vmiklos@frugalware.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 20 01:24:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K9TUU-0006Vg-0w
	for gcvg-git-2@gmane.org; Fri, 20 Jun 2008 01:24:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753702AbYFSXXC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jun 2008 19:23:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754044AbYFSXW7
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jun 2008 19:22:59 -0400
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:46953 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753676AbYFSXWu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jun 2008 19:22:50 -0400
Received: from vmobile.example.net (catv-5062e651.catv.broadband.hu [80.98.230.81])
	by yugo.frugalware.org (Postfix) with ESMTP id 0572A1DDC5C
	for <git@vger.kernel.org>; Fri, 20 Jun 2008 01:22:48 +0200 (CEST)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id A5D1718E0E8; Fri, 20 Jun 2008 01:22:36 +0200 (CEST)
X-Mailer: git-send-email 1.5.6
In-Reply-To: <b9fc7f1cc6c36ba197ed2c0394a6b89ed33c4b96.1213917600.git.vmiklos@frugalware.org>
In-Reply-To: <cover.1213917600.git.vmiklos@frugalware.org>
References: <cover.1213917600.git.vmiklos@frugalware.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85573>

This function is useful outside builtin-merge-recursive, for example in
builtin-merge.

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---
 builtin-merge-recursive.c |    8 --------
 commit.c                  |    8 ++++++++
 commit.h                  |    1 +
 3 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/builtin-merge-recursive.c b/builtin-merge-recursive.c
index 4aa28a1..98b09fb 100644
--- a/builtin-merge-recursive.c
+++ b/builtin-merge-recursive.c
@@ -42,14 +42,6 @@ static struct tree *shift_tree_object(struct tree *one, struct tree *two)
  * - *(int *)commit->object.sha1 set to the virtual id.
  */
 
-static unsigned commit_list_count(const struct commit_list *l)
-{
-	unsigned c = 0;
-	for (; l; l = l->next )
-		c++;
-	return c;
-}
-
 static struct commit *make_virtual_commit(struct tree *tree, const char *comment)
 {
 	struct commit *commit = xcalloc(1, sizeof(struct commit));
diff --git a/commit.c b/commit.c
index e2d8624..bbf9c75 100644
--- a/commit.c
+++ b/commit.c
@@ -325,6 +325,14 @@ struct commit_list *commit_list_insert(struct commit *item, struct commit_list *
 	return new_list;
 }
 
+unsigned commit_list_count(const struct commit_list *l)
+{
+	unsigned c = 0;
+	for (; l; l = l->next )
+		c++;
+	return c;
+}
+
 void free_commit_list(struct commit_list *list)
 {
 	while (list) {
diff --git a/commit.h b/commit.h
index 2d94d41..7f8c5ee 100644
--- a/commit.h
+++ b/commit.h
@@ -41,6 +41,7 @@ int parse_commit_buffer(struct commit *item, void *buffer, unsigned long size);
 int parse_commit(struct commit *item);
 
 struct commit_list * commit_list_insert(struct commit *item, struct commit_list **list_p);
+unsigned commit_list_count(const struct commit_list *l);
 struct commit_list * insert_by_date(struct commit *item, struct commit_list **list);
 
 void free_commit_list(struct commit_list *list);
-- 
1.5.6
