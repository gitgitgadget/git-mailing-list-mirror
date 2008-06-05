From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH 08/10] Introduce commit_list_append() in commit.c
Date: Thu,  5 Jun 2008 22:44:34 +0200
Message-ID: <cbafb7e632b176658fe84e1eb9926f0a8d3c96b4.1212698317.git.vmiklos@frugalware.org>
References: <cover.1212698317.git.vmiklos@frugalware.org>
 <0a2c2130f9fd87e98192ab0fe0d23e16c902997c.1212698317.git.vmiklos@frugalware.org>
 <9867fa302ce1c28f4bd8534a70bda19786c75971.1212698317.git.vmiklos@frugalware.org>
 <5aca216074b88d68f97b8223ebf6272dfe6bddeb.1212698317.git.vmiklos@frugalware.org>
 <3168647573b1325f47ab16f9ee3cae5abaaee473.1212698317.git.vmiklos@frugalware.org>
 <01dd116d05eedba51578935e39f679a8747380d6.1212698317.git.vmiklos@frugalware.org>
 <514d4184569ab033cad97be9afbd88c767bfb484.1212698317.git.vmiklos@frugalware.org>
 <2e4b20178405cf993ce9e0f1ffe4ac402a96fd03.1212698317.git.vmiklos@frugalware.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 05 22:46:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4MLe-0006Hd-3Z
	for gcvg-git-2@gmane.org; Thu, 05 Jun 2008 22:46:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753771AbYFEUon (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Jun 2008 16:44:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752411AbYFEUol
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Jun 2008 16:44:41 -0400
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:46516 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752747AbYFEUod (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jun 2008 16:44:33 -0400
Received: from vmobile.example.net (dsl5401CC68.pool.t-online.hu [84.1.204.104])
	by yugo.frugalware.org (Postfix) with ESMTP id DA35C1DDC62
	for <git@vger.kernel.org>; Thu,  5 Jun 2008 22:44:29 +0200 (CEST)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id CF01618E2BD; Thu,  5 Jun 2008 22:44:37 +0200 (CEST)
X-Mailer: git-send-email 1.5.6.rc0.dirty
In-Reply-To: <2e4b20178405cf993ce9e0f1ffe4ac402a96fd03.1212698317.git.vmiklos@frugalware.org>
In-Reply-To: <cover.1212698317.git.vmiklos@frugalware.org>
References: <cover.1212698317.git.vmiklos@frugalware.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83976>

This is like commit_list_insert() but it appends the new commit to the
end of the list, rather than insert to the start of it.

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---
 commit.c |   19 +++++++++++++++++++
 commit.h |    1 +
 2 files changed, 20 insertions(+), 0 deletions(-)

diff --git a/commit.c b/commit.c
index b45ec9b..6ba5acb 100644
--- a/commit.c
+++ b/commit.c
@@ -331,6 +331,25 @@ struct commit_list *commit_list_insert(struct commit *item, struct commit_list *
 	return new_list;
 }
 
+struct commit_list *commit_list_append(struct commit *item,
+	struct commit_list **list_p)
+{
+	struct commit_list *i, *prev = NULL, *list = *list_p;
+	struct commit_list *new_list = xmalloc(sizeof(struct commit_list));
+
+	new_list->item = item;
+	new_list->next = NULL;
+
+	if (!list)
+		*list_p = new_list;
+	else {
+		for (i = list; i; i = i->next)
+			prev = i;
+		prev->next = new_list;
+	}
+	return list;
+}
+
 unsigned commit_list_count(const struct commit_list *l)
 {
 	unsigned c = 0;
diff --git a/commit.h b/commit.h
index 7f8c5ee..5d9ac43 100644
--- a/commit.h
+++ b/commit.h
@@ -41,6 +41,7 @@ int parse_commit_buffer(struct commit *item, void *buffer, unsigned long size);
 int parse_commit(struct commit *item);
 
 struct commit_list * commit_list_insert(struct commit *item, struct commit_list **list_p);
+struct commit_list *commit_list_append(struct commit *item, struct commit_list **list_p);
 unsigned commit_list_count(const struct commit_list *l);
 struct commit_list * insert_by_date(struct commit *item, struct commit_list **list);
 
-- 
1.5.6.rc0.dirty
