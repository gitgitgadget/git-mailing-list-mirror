From: Kirill Smelkov <kirr@mns.spb.ru>
Subject: [PATCH 2/4] tree-diff: convert diff_root_tree_sha1() to just call diff_tree_sha1 with old=NULL
Date: Wed,  5 Feb 2014 20:57:10 +0400
Message-ID: <bac523d0d3c0b8d91450cc08c859f214bc97e59a.1391619218.git.kirr@mns.spb.ru>
References: <cover.1391619218.git.kirr@mns.spb.ru>
Cc: git@vger.kernel.org, Kirill Smelkov <kirr@mns.spb.ru>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 05 17:55:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WB5lL-0000Qd-4s
	for gcvg-git-2@plane.gmane.org; Wed, 05 Feb 2014 17:55:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753129AbaBEQzn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Feb 2014 11:55:43 -0500
Received: from mail.mnsspb.ru ([84.204.75.2]:60074 "EHLO mail.mnsspb.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752969AbaBEQzl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Feb 2014 11:55:41 -0500
Received: from [192.168.0.127] (helo=tugrik.mns.mnsspb.ru)
	by mail.mnsspb.ru with esmtps id 1WB5lE-0004Cm-Dh; Wed, 05 Feb 2014 20:55:40 +0400
Received: from kirr by tugrik.mns.mnsspb.ru with local (Exim 4.72)
	(envelope-from <kirr@tugrik.mns.mnsspb.ru>)
	id 1WB5n1-0004zK-4n; Wed, 05 Feb 2014 20:57:31 +0400
X-Mailer: git-send-email 1.9.rc1.181.g641f458
In-Reply-To: <cover.1391619218.git.kirr@mns.spb.ru>
In-Reply-To: <cover.1391619218.git.kirr@mns.spb.ru>
References: <cover.1391619218.git.kirr@mns.spb.ru>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241608>

Now since diff_tree_sha1 understands NULL for both old and new, we could
indicate an empty tree for root commit by providing just NULL for old
sha1.

Signed-off-by: Kirill Smelkov <kirr@mns.spb.ru>
---
 tree-diff.c | 15 +--------------
 1 file changed, 1 insertion(+), 14 deletions(-)

diff --git a/tree-diff.c b/tree-diff.c
index f438478..6d82a3f 100644
--- a/tree-diff.c
+++ b/tree-diff.c
@@ -304,18 +304,5 @@ int diff_tree_sha1(const unsigned char *old, const unsigned char *new, const cha
 
 int diff_root_tree_sha1(const unsigned char *new, const char *base, struct diff_options *opt)
 {
-	int retval;
-	void *tree;
-	unsigned long size;
-	struct tree_desc empty, real;
-
-	tree = read_object_with_reference(new, tree_type, &size, NULL);
-	if (!tree)
-		die("unable to read root tree (%s)", sha1_to_hex(new));
-	init_tree_desc(&real, tree, size);
-
-	init_tree_desc(&empty, "", 0);
-	retval = diff_tree(&empty, &real, base, opt);
-	free(tree);
-	return retval;
+	return diff_tree_sha1(NULL, new, base, opt);
 }
-- 
1.9.rc1.181.g641f458
