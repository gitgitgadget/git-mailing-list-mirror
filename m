From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH] Remove unused code in parse_commit_buffer()
Date: Sat,  7 Jun 2008 22:38:37 +0200
Message-ID: <1212871117-1509-1-git-send-email-vmiklos@frugalware.org>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 07 22:39:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K55CF-0007Wv-GG
	for gcvg-git-2@gmane.org; Sat, 07 Jun 2008 22:39:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753502AbYFGUii (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Jun 2008 16:38:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753400AbYFGUii
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Jun 2008 16:38:38 -0400
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:49113 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752779AbYFGUih (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Jun 2008 16:38:37 -0400
Received: from vmobile.example.net (dsl5401CF9A.pool.t-online.hu [84.1.207.154])
	by yugo.frugalware.org (Postfix) with ESMTP id 3F7F71DDC5B;
	Sat,  7 Jun 2008 22:38:36 +0200 (CEST)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id B447B18E2A7; Sat,  7 Jun 2008 22:38:37 +0200 (CEST)
X-Mailer: git-send-email 1.5.6.rc0.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84226>

The n_refs variable is no longer really used in this function, so there
is no reason to keep it.

It was introduced in 27dedf0c and the code that really used it was
removed in 7914053.

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---
 commit.c |    8 +-------
 1 files changed, 1 insertions(+), 7 deletions(-)

diff --git a/commit.c b/commit.c
index 94d5b3d..e2d8624 100644
--- a/commit.c
+++ b/commit.c
@@ -243,7 +243,6 @@ int parse_commit_buffer(struct commit *item, void *buffer, unsigned long size)
 	unsigned char parent[20];
 	struct commit_list **pptr;
 	struct commit_graft *graft;
-	unsigned n_refs = 0;
 
 	if (item->object.parsed)
 		return 0;
@@ -255,8 +254,6 @@ int parse_commit_buffer(struct commit *item, void *buffer, unsigned long size)
 		return error("bad tree pointer in commit %s",
 			     sha1_to_hex(item->object.sha1));
 	item->tree = lookup_tree(parent);
-	if (item->tree)
-		n_refs++;
 	bufptr += 46; /* "tree " + "hex sha1" + "\n" */
 	pptr = &item->parents;
 
@@ -272,10 +269,8 @@ int parse_commit_buffer(struct commit *item, void *buffer, unsigned long size)
 		if (graft)
 			continue;
 		new_parent = lookup_commit(parent);
-		if (new_parent) {
+		if (new_parent)
 			pptr = &commit_list_insert(new_parent, pptr)->next;
-			n_refs++;
-		}
 	}
 	if (graft) {
 		int i;
@@ -285,7 +280,6 @@ int parse_commit_buffer(struct commit *item, void *buffer, unsigned long size)
 			if (!new_parent)
 				continue;
 			pptr = &commit_list_insert(new_parent, pptr)->next;
-			n_refs++;
 		}
 	}
 	item->date = parse_commit_date(bufptr, tail);
-- 
1.5.6.rc0.dirty
