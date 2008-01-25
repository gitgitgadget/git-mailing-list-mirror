From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH 3/9] Send unpack-trees debugging output to stderr
Date: Fri, 25 Jan 2008 18:24:47 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0801251820140.13593@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat Jan 26 00:26:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JIXw1-0006nZ-Kp
	for gcvg-git-2@gmane.org; Sat, 26 Jan 2008 00:26:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752484AbYAYXYu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jan 2008 18:24:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753106AbYAYXYu
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Jan 2008 18:24:50 -0500
Received: from iabervon.org ([66.92.72.58]:45109 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752454AbYAYXYt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jan 2008 18:24:49 -0500
Received: (qmail 4436 invoked by uid 1000); 25 Jan 2008 23:24:47 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 25 Jan 2008 23:24:47 -0000
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71753>

This is to keep git-stash from getting confused if you're debugging
unpack-trees.

Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
---
 unpack-trees.c |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/unpack-trees.c b/unpack-trees.c
index fc0d2c7..d6bae1b 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -122,13 +122,13 @@ static int unpack_trees_rec(struct tree_entry_list **posns, int len,
 
 #if DBRT_DEBUG > 1
 		if (first)
-			printf("index %s\n", first);
+			fprintf(stderr, "index %s\n", first);
 #endif
 		for (i = 0; i < len; i++) {
 			if (!posns[i] || posns[i] == df_conflict_list)
 				continue;
 #if DBRT_DEBUG > 1
-			printf("%d %s\n", i + 1, posns[i]->name);
+			fprintf(stderr, "%d %s\n", i + 1, posns[i]->name);
 #endif
 			if (!first || entcmp(first, firstdir,
 					     posns[i]->name,
@@ -209,13 +209,13 @@ static int unpack_trees_rec(struct tree_entry_list **posns, int len,
 				int ret;
 
 #if DBRT_DEBUG > 1
-				printf("%s:\n", first);
+				fprintf(stderr, "%s:\n", first);
 				for (i = 0; i < src_size; i++) {
-					printf(" %d ", i);
+					fprintf(stderr, " %d ", i);
 					if (src[i])
-						printf("%s\n", sha1_to_hex(src[i]->sha1));
+						fprintf(stderr, "%06x %s\n", src[i]->ce_mode, sha1_to_hex(src[i]->sha1));
 					else
-						printf("\n");
+						fprintf(stderr, "\n");
 				}
 #endif
 				ret = o->fn(src, o, remove);
@@ -223,7 +223,7 @@ static int unpack_trees_rec(struct tree_entry_list **posns, int len,
 					return ret;
 
 #if DBRT_DEBUG > 1
-				printf("Added %d entries\n", ret);
+				fprintf(stderr, "Added %d entries\n", ret);
 #endif
 				o->pos += ret;
 			} else {
-- 
1.5.4.rc3.4.g16335
