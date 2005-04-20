From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Unify usage() strings.
Date: Wed, 20 Apr 2005 00:46:21 -0700
Message-ID: <7vvf6hki0i.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 20 09:44:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DO9sM-00088B-Ew
	for gcvg-git@gmane.org; Wed, 20 Apr 2005 09:43:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261328AbVDTHsJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Apr 2005 03:48:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261338AbVDTHsJ
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Apr 2005 03:48:09 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:12018 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S261328AbVDTHr4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Apr 2005 03:47:56 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050420074756.BIHU1282.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 20 Apr 2005 03:47:56 -0400
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This patch changes identical cut-and-paste usage strings into a
single instance of static string, to make maintenance easier.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 commit-tree.c |   14 ++++++--------
 diff-cache.c  |    6 ++++--
 diff-tree.c   |    6 ++++--
 read-tree.c   |   10 ++++++----
 4 files changed, 20 insertions(+), 16 deletions(-)



commit-tree.c: 2eee2fe5b14f1f2d86b8d41b501a879b190bf08f
--- a/commit-tree.c
+++ b/commit-tree.c
@@ -268,15 +268,13 @@ static void check_valid(unsigned char *s
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
@@ -296,14 +294,14 @@ int main(int argc, char **argv)
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


diff-cache.c: 48bcec1230365e12b9fb6df65c15540caea24029
--- a/diff-cache.c
+++ b/diff-cache.c
@@ -215,6 +215,8 @@ static int diff_cache(void *tree, unsign
 	return 0;
 }
 
+static char *diff_cache_usage = "diff-cache [-r] [-z] [--cached] <tree sha1>";
+
 int main(int argc, char **argv)
 {
 	unsigned char tree_sha1[20];
@@ -239,11 +241,11 @@ int main(int argc, char **argv)
 			cached_only = 1;
 			continue;
 		}
-		usage("diff-cache [-r] [-z] <tree sha1>");
+		usage(diff_cache_usage);
 	}
 
 	if (argc != 2 || get_sha1_hex(argv[1], tree_sha1))
-		usage("diff-cache [-r] [-z] <tree sha1>");
+		usage(diff_cache_usage);
 
 	tree = tree_from_tree_or_commit(tree_sha1, type, &size);
 	if (!tree)
diff-tree.c: 8720ce75b72cdf9c8d189f9edf41e0920bd72767
--- a/diff-tree.c
+++ b/diff-tree.c
@@ -193,6 +193,8 @@ static void commit_to_tree(unsigned char
 	}
 }
 
+static char *diff_tree_usage = "diff-tree [-r] [-z] <tree sha1> <tree sha1>";
+
 int main(int argc, char **argv)
 {
 	unsigned char old[20], new[20];
@@ -209,11 +211,11 @@ int main(int argc, char **argv)
 			line_termination = '\0';
 			continue;
 		}
-		usage("diff-tree [-r] [-z] <tree sha1> <tree sha1>");
+		usage(diff_tree_usage);
 	}
 
 	if (argc != 3 || get_sha1_hex(argv[1], old) || get_sha1_hex(argv[2], new))
-		usage("diff-tree <tree sha1> <tree sha1>");
+		usage(diff_tree_usage);
 	commit_to_tree(old);
 	commit_to_tree(new);
 	return diff_tree_sha1(old, new, "");


read-tree.c: e438579d63fb090209eaf4c864586afaeb52ae0f
--- a/read-tree.c
+++ b/read-tree.c
@@ -201,6 +201,8 @@ static void merge_stat_info(struct cache
 	}
 }
 
+static char *read_tree_usage = "read-tree (<sha> | -m <sha1> [<sha2> <sha3>])";
+
 int main(int argc, char **argv)
 {
 	int i, newfd, merge;
@@ -220,20 +222,20 @@ int main(int argc, char **argv)
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

