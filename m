From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH 02/15] Move commit_list_count() to commit.c
Date: Fri, 27 Jun 2008 18:21:55 +0200
Message-ID: <4a9a3a34d8c42b60f002acb20083cb9e187c262f.1214581610.git.vmiklos@frugalware.org>
References: <cover.1214581610.git.vmiklos@frugalware.org>
 <58b2c36de6a6f51a562da303695482bea567f4bf.1214581610.git.vmiklos@frugalware.org>
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Olivier Marin <dkr@freesurf.fr>,
	Junio C Hamano <gitster@pobox.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 27 18:24:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KCGk4-0004E3-Lz
	for gcvg-git-2@gmane.org; Fri, 27 Jun 2008 18:24:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754865AbYF0QW0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jun 2008 12:22:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756183AbYF0QWW
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jun 2008 12:22:22 -0400
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:45328 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759748AbYF0QWJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jun 2008 12:22:09 -0400
Received: from vmobile.example.net (dsl5401C209.pool.t-online.hu [84.1.194.9])
	by yugo.frugalware.org (Postfix) with ESMTP id CF4A81DDC5F;
	Fri, 27 Jun 2008 18:22:05 +0200 (CEST)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id F165C18E826; Fri, 27 Jun 2008 18:22:08 +0200 (CEST)
X-Mailer: git-send-email 1.5.6
In-Reply-To: <58b2c36de6a6f51a562da303695482bea567f4bf.1214581610.git.vmiklos@frugalware.org>
In-Reply-To: <cover.1214581610.git.vmiklos@frugalware.org>
References: <cover.1214581610.git.vmiklos@frugalware.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86588>

This function is useful outside builtin-merge-recursive, for example in
builtin-merge.

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin-merge-recursive.c |    8 --------
 commit.c                  |    8 ++++++++
 commit.h                  |    1 +
 3 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/builtin-merge-recursive.c b/builtin-merge-recursive.c
index 43bf6aa..3731853 100644
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
