From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH 02/10] Move commit_list_count() to commit.c
Date: Wed, 11 Jun 2008 22:50:26 +0200
Message-ID: <dedcc8309fed3282df455bec7fbc9d0f8275b74b.1213217187.git.vmiklos@frugalware.org>
References: <cover.1213217187.git.vmiklos@frugalware.org>
 <4818a0b71b7f6b44ef49621045a5871458ba5c38.1213217187.git.vmiklos@frugalware.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 11 22:52:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6XI5-00007M-25
	for gcvg-git-2@gmane.org; Wed, 11 Jun 2008 22:51:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752587AbYFKUum (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Jun 2008 16:50:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752325AbYFKUuk
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Jun 2008 16:50:40 -0400
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:32877 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752197AbYFKUuf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jun 2008 16:50:35 -0400
Received: from vmobile.example.net (dsl5401C482.pool.t-online.hu [84.1.196.130])
	by yugo.frugalware.org (Postfix) with ESMTP id 47B871DDC5E
	for <git@vger.kernel.org>; Wed, 11 Jun 2008 22:50:32 +0200 (CEST)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id 3EF6118DFDF; Wed, 11 Jun 2008 22:50:35 +0200 (CEST)
X-Mailer: git-send-email 1.5.6.rc2.dirty
In-Reply-To: <4818a0b71b7f6b44ef49621045a5871458ba5c38.1213217187.git.vmiklos@frugalware.org>
In-Reply-To: <cover.1213217187.git.vmiklos@frugalware.org>
References: <cover.1213217187.git.vmiklos@frugalware.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84652>

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
1.5.6.rc2.dirty
