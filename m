From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH 3/6] match-trees: convert shift_tree and shift_tree_by to object_id
Date: Sun, 17 Apr 2016 23:10:38 +0000
Message-ID: <1460934641-435791-4-git-send-email-sandals@crustytoothpaste.net>
References: <1460934641-435791-1-git-send-email-sandals@crustytoothpaste.net>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 18 04:20:34 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aryng-0004I2-Al
	for gcvg-git-2@plane.gmane.org; Mon, 18 Apr 2016 04:20:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751447AbcDRCUZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Apr 2016 22:20:25 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:52822 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751092AbcDRCT4 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 17 Apr 2016 22:19:56 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:6680:99ff:fe4f:73a0])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 94216282AE;
	Sun, 17 Apr 2016 23:11:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
	s=default; t=1460934674;
	bh=P7Dc/L4lGrIXDJbgVvDklhw249bM+/Eabow6Dl6chjQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ChPnnEjC69tu+1q31gtyRcyFd5IpUPdRavPFQd1O/2wC4rkSI6HBmLzt15eRnqsLa
	 lIbK5hg3czzssje6PvxZx3+UCn7oUUn4mSBZy+HhKxRJC/8UoU2YF+gY/4dj+S+3V8
	 CG4WXgLqVMa5eFOPBrIVJOETBBCPcWkF+hWrFtASVV+Pyb4G/uJykb4CPaa8mh5sRJ
	 e9rFc4DfrS+yvsnGrfS5l76DdA+nP+/u/DrGaZ7mi5NN5WzoJKd5rMLKN9CtjgxXXa
	 ylBeurq4SCgS4usBho6ziNZrmGJu1dXrUNboTud/e+zw6Ej+oeQC3B9CHnqciX9lBT
	 t/ywTMDsLjNLlYe/TAQ3WNPLUQ2NrQnx1aRK+6uUiAhlOJMRxX/vmjeCvtoQ3zbx0o
	 lwKyJEsI9/BXq3Nu8bIXz0UXK6saVes/80uGi3ue/5KqdMmKQFrZNfxNRoIkbFqO4U
	 PrC1ZnpiyCgb8SH6LKMkJvMId81aoNnd+SxJqmMDH4AnamnoJyN
X-Mailer: git-send-email 2.8.0.rc3.226.g39d4020
In-Reply-To: <1460934641-435791-1-git-send-email-sandals@crustytoothpaste.net>
X-Spam-Score: -0.262 BAYES_00,RDNS_NONE,T_DKIM_INVALID
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291794>

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 cache.h            |  4 ++--
 match-trees.c      | 44 ++++++++++++++++++++++----------------------
 merge-recursive.c  |  4 ++--
 test-match-trees.c |  2 +-
 4 files changed, 27 insertions(+), 27 deletions(-)

diff --git a/cache.h b/cache.h
index 22b73646..70091e73 100644
--- a/cache.h
+++ b/cache.h
@@ -1768,8 +1768,8 @@ int add_files_to_cache(const char *prefix, const struct pathspec *pathspec, int
 extern int diff_auto_refresh_index;
 
 /* match-trees.c */
-void shift_tree(const unsigned char *, const unsigned char *, unsigned char *, int);
-void shift_tree_by(const unsigned char *, const unsigned char *, unsigned char *, const char *);
+void shift_tree(const struct object_id *, const struct object_id *, struct object_id *, int);
+void shift_tree_by(const struct object_id *, const struct object_id *, struct object_id *, const char *);
 
 /*
  * whitespace rules.
diff --git a/match-trees.c b/match-trees.c
index 1ce0954a..9977752a 100644
--- a/match-trees.c
+++ b/match-trees.c
@@ -229,9 +229,9 @@ static int splice_tree(const unsigned char *hash1,
  * other hand, it could cover tree one and we might need to pick a
  * subtree of it.
  */
-void shift_tree(const unsigned char *hash1,
-		const unsigned char *hash2,
-		unsigned char *shifted,
+void shift_tree(const struct object_id *hash1,
+		const struct object_id *hash2,
+		struct object_id *shifted,
 		int depth_limit)
 {
 	char *add_prefix;
@@ -245,7 +245,7 @@ void shift_tree(const unsigned char *hash1,
 	if (!depth_limit)
 		depth_limit = 2;
 
-	add_score = del_score = score_trees(hash1, hash2);
+	add_score = del_score = score_trees(hash1->hash, hash2->hash);
 	add_prefix = xcalloc(1, 1);
 	del_prefix = xcalloc(1, 1);
 
@@ -253,16 +253,16 @@ void shift_tree(const unsigned char *hash1,
 	 * See if one's subtree resembles two; if so we need to prefix
 	 * two with a few fake trees to match the prefix.
 	 */
-	match_trees(hash1, hash2, &add_score, &add_prefix, "", depth_limit);
+	match_trees(hash1->hash, hash2->hash, &add_score, &add_prefix, "", depth_limit);
 
 	/*
 	 * See if two's subtree resembles one; if so we need to
 	 * pick only subtree of two.
 	 */
-	match_trees(hash2, hash1, &del_score, &del_prefix, "", depth_limit);
+	match_trees(hash2->hash, hash1->hash, &del_score, &del_prefix, "", depth_limit);
 
 	/* Assume we do not have to do any shifting */
-	hashcpy(shifted, hash2);
+	oidcpy(shifted, hash2);
 
 	if (add_score < del_score) {
 		/* We need to pick a subtree of two */
@@ -271,16 +271,16 @@ void shift_tree(const unsigned char *hash1,
 		if (!*del_prefix)
 			return;
 
-		if (get_tree_entry(hash2, del_prefix, shifted, &mode))
+		if (get_tree_entry(hash2->hash, del_prefix, shifted->hash, &mode))
 			die("cannot find path %s in tree %s",
-			    del_prefix, sha1_to_hex(hash2));
+			    del_prefix, oid_to_hex(hash2));
 		return;
 	}
 
 	if (!*add_prefix)
 		return;
 
-	splice_tree(hash1, add_prefix, hash2, shifted);
+	splice_tree(hash1->hash, add_prefix, hash2->hash, shifted->hash);
 }
 
 /*
@@ -288,44 +288,44 @@ void shift_tree(const unsigned char *hash1,
  * Unfortunately we cannot fundamentally tell which one to
  * be prefixed, as recursive merge can work in either direction.
  */
-void shift_tree_by(const unsigned char *hash1,
-		   const unsigned char *hash2,
-		   unsigned char *shifted,
+void shift_tree_by(const struct object_id *hash1,
+		   const struct object_id *hash2,
+		   struct object_id *shifted,
 		   const char *shift_prefix)
 {
-	unsigned char sub1[20], sub2[20];
+	struct object_id sub1, sub2;
 	unsigned mode1, mode2;
 	unsigned candidate = 0;
 
 	/* Can hash2 be a tree at shift_prefix in tree hash1? */
-	if (!get_tree_entry(hash1, shift_prefix, sub1, &mode1) &&
+	if (!get_tree_entry(hash1->hash, shift_prefix, sub1.hash, &mode1) &&
 	    S_ISDIR(mode1))
 		candidate |= 1;
 
 	/* Can hash1 be a tree at shift_prefix in tree hash2? */
-	if (!get_tree_entry(hash2, shift_prefix, sub2, &mode2) &&
+	if (!get_tree_entry(hash2->hash, shift_prefix, sub2.hash, &mode2) &&
 	    S_ISDIR(mode2))
 		candidate |= 2;
 
 	if (candidate == 3) {
 		/* Both are plausible -- we need to evaluate the score */
-		int best_score = score_trees(hash1, hash2);
+		int best_score = score_trees(hash1->hash, hash2->hash);
 		int score;
 
 		candidate = 0;
-		score = score_trees(sub1, hash2);
+		score = score_trees(sub1.hash, hash2->hash);
 		if (score > best_score) {
 			candidate = 1;
 			best_score = score;
 		}
-		score = score_trees(sub2, hash1);
+		score = score_trees(sub2.hash, hash1->hash);
 		if (score > best_score)
 			candidate = 2;
 	}
 
 	if (!candidate) {
 		/* Neither is plausible -- do not shift */
-		hashcpy(shifted, hash2);
+		oidcpy(shifted, hash2);
 		return;
 	}
 
@@ -334,11 +334,11 @@ void shift_tree_by(const unsigned char *hash1,
 		 * shift tree2 down by adding shift_prefix above it
 		 * to match tree1.
 		 */
-		splice_tree(hash1, shift_prefix, hash2, shifted);
+		splice_tree(hash1->hash, shift_prefix, hash2->hash, shifted->hash);
 	else
 		/*
 		 * shift tree2 up by removing shift_prefix from it
 		 * to match tree1.
 		 */
-		hashcpy(shifted, sub2);
+		oidcpy(shifted, &sub2);
 }
diff --git a/merge-recursive.c b/merge-recursive.c
index b880ae50..a47c80f8 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -29,9 +29,9 @@ static struct tree *shift_tree_object(struct tree *one, struct tree *two,
 	struct object_id shifted;
 
 	if (!*subtree_shift) {
-		shift_tree(one->object.oid.hash, two->object.oid.hash, shifted.hash, 0);
+		shift_tree(&one->object.oid, &two->object.oid, &shifted, 0);
 	} else {
-		shift_tree_by(one->object.oid.hash, two->object.oid.hash, shifted.hash,
+		shift_tree_by(&one->object.oid, &two->object.oid, &shifted,
 			      subtree_shift);
 	}
 	if (!oidcmp(&two->object.oid, &shifted))
diff --git a/test-match-trees.c b/test-match-trees.c
index 41aff841..d446b8ea 100644
--- a/test-match-trees.c
+++ b/test-match-trees.c
@@ -19,7 +19,7 @@ int main(int ac, char **av)
 	if (!two)
 		die("not a tree-ish %s", av[2]);
 
-	shift_tree(one->object.oid.hash, two->object.oid.hash, shifted.hash, -1);
+	shift_tree(&one->object.oid, &two->object.oid, &shifted, -1);
 	printf("shifted: %s\n", oid_to_hex(&shifted));
 
 	exit(0);
-- 
2.8.0.rc3.226.g39d4020
