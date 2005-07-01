From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH] Removes DEBUG code from rev-list.c and -DDEBUG from Makefile
Date: Fri, 01 Jul 2005 16:31:16 +1000
Message-ID: <20050701063116.1119.qmail@blackcubes.dyndns.org>
Cc: torvalds@osdl.org, jon.seymour@gmail.com
X-From: git-owner@vger.kernel.org Fri Jul 01 08:24:26 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DoEwd-0002Oq-Th
	for gcvg-git@gmane.org; Fri, 01 Jul 2005 08:24:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263237AbVGAGbl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 1 Jul 2005 02:31:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263240AbVGAGbl
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Jul 2005 02:31:41 -0400
Received: from 203-173-52-158.dyn.iinet.net.au ([203.173.52.158]:44419 "HELO
	blackcubes.dyndns.org") by vger.kernel.org with SMTP
	id S263237AbVGAGbS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Jul 2005 02:31:18 -0400
Received: (qmail 1129 invoked by uid 500); 1 Jul 2005 06:31:16 -0000
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


This patch removes DEBUG code and -DDEBUG flag from Makefile.

Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
---

 Makefile   |    2 +-
 rev-list.c |   30 ------------------------------
 2 files changed, 1 insertions(+), 31 deletions(-)

be52c026e003b9774acc3d0f53ae5ed67d878b03
diff --git a/Makefile b/Makefile
--- a/Makefile
+++ b/Makefile
@@ -10,7 +10,7 @@
 # break unless your underlying filesystem supports those sub-second times
 # (my ext3 doesn't).
 COPTS=-O2
-CFLAGS=-DDEBUG -g $(COPTS) -Wall
+CFLAGS=-g $(COPTS) -Wall
 
 prefix=$(HOME)
 bin=$(prefix)/bin
diff --git a/rev-list.c b/rev-list.c
--- a/rev-list.c
+++ b/rev-list.c
@@ -44,10 +44,6 @@ static int merge_order = 0;
 static int show_breaks = 0;
 static int stop_traversal = 0;
 static int bisect_by_cut_option = 0;
-#ifdef DEBUG
-static int debug = 0;
-static unsigned int complexity = 0;
-#endif
 
 static void show_commit(struct commit *commit)
 {
@@ -283,9 +279,6 @@ static int count_distance(struct commit_
 
 static void clear_distance(struct commit_list *list)
 {
-#ifdef DEBUG
-	complexity++;
-#endif
 	while (list) {
 		struct commit *commit = list->item;
 		commit->object.flags &= ~COUNTED;
@@ -422,14 +415,6 @@ static inline struct bisect_by_cut_node 
 	return (struct bisect_by_cut_node *)commit->object.util;
 }
 
-#ifdef DEBUG
-static void print_bisect_by_cut_node(struct commit * commit, const char * prefix)
-{
-	struct bisect_by_cut_node * node = get_bisect_by_cut_node(commit);
-	fprintf(stderr, "%s%s %u %d\n", prefix, sha1_to_hex(commit->object.sha1), node->flags, node->count);
-}
-#endif
-
 /*
  * Find the best bisection point by cutting a topological order in two then
  * identifying a set of boundary nodes with a reachability known to be 
@@ -558,11 +543,6 @@ struct commit * bisect_by_cut(struct com
 			best = work_item;
 			fittest = fitness;
 		}
-#ifdef DEBUG
-		if (debug) {
-			print_bisect_by_cut_node(work_item, "work ");
-		}
-#endif
 		if (goal_test < goal) {
 			while (children) {
 				struct bisect_by_cut_node * cn 
@@ -666,12 +646,6 @@ int main(int argc, char **argv)
 			show_breaks = 1;
 			continue;
 		}
-#ifdef DEBUG
-		if (!strcmp(arg, "--debug")) {
-			debug = 1;
-			continue;
-		}
-#endif
 		flags = 0;
 		if (*arg == '^') {
 			flags = UNINTERESTING;
@@ -700,9 +674,5 @@ int main(int argc, char **argv)
 			  die("merge order sort failed\n");
 		}
 	}
-#ifdef DEBUG
-	if (debug) 
-		fprintf(stderr, "complexity=%d\n", complexity);
-#endif
 	return 0;
 }
------------
