From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH 02/10] Move commit_list_count() to commit.c
Date: Thu,  5 Jun 2008 22:44:28 +0200
Message-ID: <9867fa302ce1c28f4bd8534a70bda19786c75971.1212698317.git.vmiklos@frugalware.org>
References: <cover.1212698317.git.vmiklos@frugalware.org>
 <0a2c2130f9fd87e98192ab0fe0d23e16c902997c.1212698317.git.vmiklos@frugalware.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 05 22:46:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4MLh-0006Hd-Ck
	for gcvg-git-2@gmane.org; Thu, 05 Jun 2008 22:46:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754396AbYFEUow (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Jun 2008 16:44:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754062AbYFEUov
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Jun 2008 16:44:51 -0400
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:46516 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752502AbYFEUof (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jun 2008 16:44:35 -0400
Received: from vmobile.example.net (dsl5401CC68.pool.t-online.hu [84.1.204.104])
	by yugo.frugalware.org (Postfix) with ESMTP id 103E51DDC5B
	for <git@vger.kernel.org>; Thu,  5 Jun 2008 22:44:34 +0200 (CEST)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id 52FEA18E2A4; Thu,  5 Jun 2008 22:44:37 +0200 (CEST)
X-Mailer: git-send-email 1.5.6.rc0.dirty
In-Reply-To: <0a2c2130f9fd87e98192ab0fe0d23e16c902997c.1212698317.git.vmiklos@frugalware.org>
In-Reply-To: <cover.1212698317.git.vmiklos@frugalware.org>
References: <cover.1212698317.git.vmiklos@frugalware.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83977>

This function is useful outside builtin-merge-recursive, for example in
builtin-merge.

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---
 builtin-merge-recursive.c |    8 --------
 commit.c                  |    8 ++++++++
 commit.h                  |    1 +
 3 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/builtin-merge-recursive.c b/builtin-merge-recursive.c
index 362c290..0afd4a4 100644
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
1.5.6.rc0.dirty
