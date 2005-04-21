From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Usage-string fixes.
Date: Wed, 20 Apr 2005 19:38:33 -0700
Message-ID: <7v1x94hn12.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 21 04:34:33 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DORWI-0007OH-KU
	for gcvg-git@gmane.org; Thu, 21 Apr 2005 04:34:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261188AbVDUCin (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Apr 2005 22:38:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261182AbVDUCin
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Apr 2005 22:38:43 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:20620 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S261188AbVDUCif (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Apr 2005 22:38:35 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050421023832.LRJ2123.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 20 Apr 2005 22:38:32 -0400
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Usage string fixes to make maintenance easier (only one instance
of a string to update not multiple copies).  I've spotted and
corrected inconsistent usage text in diff-tree while doing this.

Also diff-cache and read-tree usage text have been corrected to
match their up-to-date features.  Earlier, neither "--cached"
form of diff-cache nor "-m single-merge" form of read-tree were
described. 

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 commit-tree.c |   14 ++++++--------
 diff-cache.c  |    6 ++++--
 diff-tree.c   |    6 ++++--
 read-tree.c   |   10 ++++++----
 4 files changed, 20 insertions(+), 16 deletions(-)


--- ../git.linus/commit-tree.c	2005-04-20 19:00:38.000000000 -0700
+++ ../git.junio/commit-tree.c	2005-04-20 11:41:45.000000000 -0700
@@ -268,15 +268,13 @@
 }
 
 /*
- * Having more than two parents may be strange, but hey, there's
- * no conceptual reason why the file format couldn't accept multi-way
- * merges. It might be the "union" of several packages, for example.
- *
- * I don't really expect that to happen, but this is here to make
- * it clear that _conceptually_ it's ok..
+ * Having more than two parents is not strange at all, and this is
+ * how multi-way merges are represented.
  */
 #define MAXPARENT (16)
 
+static char *commit_tree_usage = "commit-tree <sha1> [-p <sha1>]* < changelog";
+
 int main(int argc, char **argv)
 {
 	int i, len;
@@ -296,14 +294,14 @@
 	unsigned int size;
 
 	if (argc < 2 || get_sha1_hex(argv[1], tree_sha1) < 0)
-		usage("commit-tree <sha1> [-p <sha1>]* < changelog");
+		usage(commit_tree_usage);
 
 	check_valid(tree_sha1, "tree");
 	for (i = 2; i < argc; i += 2) {
 		char *a, *b;
 		a = argv[i]; b = argv[i+1];
 		if (!b || strcmp(a, "-p") || get_sha1_hex(b, parent_sha1[parents]))
-			usage("commit-tree <sha1> [-p <sha1>]* < changelog");
+			usage(commit_tree_usage);
 		check_valid(parent_sha1[parents], "commit");
 		parents++;
 	}


--- ../git.linus/diff-cache.c	2005-04-20 19:00:38.000000000 -0700
+++ ../git.junio/diff-cache.c	2005-04-20 19:14:25.000000000 -0700
@@ -215,6 +215,8 @@
 	return 0;
 }
 
+static char *diff_cache_usage = "diff-cache [-r] [-z] [--cached] <tree sha1>";
+
 int main(int argc, char **argv)
 {
 	unsigned char tree_sha1[20];
@@ -238,11 +240,11 @@
 			cached_only = 1;
 			continue;
 		}
-		usage("diff-cache [-r] [-z] <tree sha1>");
+		usage(diff_cache_usage);
 	}
 
 	if (argc != 2 || get_sha1_hex(argv[1], tree_sha1))
-		usage("diff-cache [-r] [-z] <tree sha1>");
+		usage(diff_cache_usage);
 
 	tree = read_tree_with_tree_or_commit_sha1(tree_sha1, &size, 0);
 	if (!tree)


--- ../git.linus/diff-tree.c	2005-04-20 19:00:38.000000000 -0700
+++ ../git.junio/diff-tree.c	2005-04-20 19:14:55.000000000 -0700
@@ -178,6 +178,8 @@
 	return retval;
 }
 
+static char *diff_tree_usage = "diff-tree [-r] [-z] <tree sha1> <tree sha1>";
+
 int main(int argc, char **argv)
 {
 	unsigned char old[20], new[20];
@@ -194,10 +196,10 @@
 			line_termination = '\0';
 			continue;
 		}
-		usage("diff-tree [-r] [-z] <tree sha1> <tree sha1>");
+		usage(diff_tree_usage);
 	}
 
 	if (argc != 3 || get_sha1_hex(argv[1], old) || get_sha1_hex(argv[2], new))
-		usage("diff-tree <tree sha1> <tree sha1>");
+		usage(diff_tree_usage);
 	return diff_tree_sha1(old, new, "");
 }



--- ../git.linus/read-tree.c	2005-04-20 19:00:38.000000000 -0700
+++ ../git.junio/read-tree.c	2005-04-20 19:15:33.000000000 -0700
@@ -217,6 +217,8 @@
 	}
 }
 
+static char *read_tree_usage = "read-tree (<sha> | -m <sha1> [<sha2> <sha3>])";
+
 int main(int argc, char **argv)
 {
 	int i, newfd, merge;
@@ -236,20 +238,20 @@
 		if (!strcmp(arg, "-m")) {
 			int i;
 			if (stage)
-				usage("-m needs to come first");
+				die("-m needs to come first");
 			read_cache();
 			for (i = 0; i < active_nr; i++) {
 				if (ce_stage(active_cache[i]))
-					usage("you need to resolve your current index first");
+					die("you need to resolve your current index first");
 			}
 			stage = 1;
 			merge = 1;
 			continue;
 		}
 		if (get_sha1_hex(arg, sha1) < 0)
-			usage("read-tree [-m] <sha1>");
+			usage(read_tree_usage);
 		if (stage > 3)
-			usage("can't merge more than two trees");
+			usage(read_tree_usage);
 		if (read_tree(sha1, "", 0) < 0)
 			die("failed to unpack tree object %s", arg);
 		stage++;
 

