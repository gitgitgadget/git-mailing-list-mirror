From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH 4/5] Move commit_list_count() to commit.c
Date: Sat, 24 May 2008 02:01:07 +0200
Message-ID: <b2314d0b07976d106e9ac9a9eebceb465f0ec46b.1211586801.git.vmiklos@frugalware.org>
References: <cover.1211586801.git.vmiklos@frugalware.org>
 <40d6845554a032ef66a20289aea6c7b2f157fed3.1211586801.git.vmiklos@frugalware.org>
 <28874c24faf45e6e4499c9692cc1de1e93cd4dcf.1211586801.git.vmiklos@frugalware.org>
 <dace39a3a72957bec9a7f4b8528b08fc7fbe3341.1211586801.git.vmiklos@frugalware.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 24 02:02:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JzhD4-00012y-Po
	for gcvg-git-2@gmane.org; Sat, 24 May 2008 02:02:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758908AbYEXABR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 May 2008 20:01:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759057AbYEXABR
	(ORCPT <rfc822;git-outgoing>); Fri, 23 May 2008 20:01:17 -0400
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:36663 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756275AbYEXABH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 May 2008 20:01:07 -0400
Received: from vmobile.example.net (catv-5062e605.catv.broadband.hu [80.98.230.5])
	by yugo.frugalware.org (Postfix) with ESMTP id 93AFF1DDC5F
	for <git@vger.kernel.org>; Sat, 24 May 2008 02:01:04 +0200 (CEST)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id C3955185E1C; Sat, 24 May 2008 02:01:08 +0200 (CEST)
X-Mailer: git-send-email 1.5.5.1.357.g1af8b.dirty
In-Reply-To: <dace39a3a72957bec9a7f4b8528b08fc7fbe3341.1211586801.git.vmiklos@frugalware.org>
In-Reply-To: <cover.1211586801.git.vmiklos@frugalware.org>
References: <cover.1211586801.git.vmiklos@frugalware.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82777>

This function is useful outside builtin-merge-recursive, for example in
builtin-merge.

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---
 builtin-merge-recursive.c |    8 --------
 commit.c                  |    8 ++++++++
 commit.h                  |    1 +
 3 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/builtin-merge-recursive.c b/builtin-merge-recursive.c
index 46e636f..7aaa215 100644
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
index 94d5b3d..b45ec9b 100644
--- a/commit.c
+++ b/commit.c
@@ -331,6 +331,14 @@ struct commit_list *commit_list_insert(struct commit *item, struct commit_list *
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
1.5.5.1.357.g1af8b.dirty
