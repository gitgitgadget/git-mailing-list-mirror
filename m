From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v2 6/6] match-trees: convert several leaf functions to struct object_id
Date: Fri, 22 Apr 2016 22:02:53 +0000
Message-ID: <20160422220253.839970-7-sandals@crustytoothpaste.net>
References: <20160422220253.839970-1-sandals@crustytoothpaste.net>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 23 00:03:35 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1atjAl-0000rb-CE
	for gcvg-git-2@plane.gmane.org; Sat, 23 Apr 2016 00:03:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752978AbcDVWD0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Apr 2016 18:03:26 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:56150 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752386AbcDVWDX (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 22 Apr 2016 18:03:23 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:6680:99ff:fe4f:73a0])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id B9815282AE;
	Fri, 22 Apr 2016 22:03:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
	s=default; t=1461362600;
	bh=gWWQLluEFU0G/lzOYbEuqow/g5yLI3AIN3LcPMijj2s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gFyZ/JKWKpFOXxAztXG+sYAIOJsOPJEufUi4K6jbSsxFwxF7R0FT7ltwMHkEdum1f
	 1cYQ1d4LAIwqlZ4DT/mBggsqL+onsgxizic0YamkWUbaRrQu/CloowcERrAVCF0Fe/
	 f3Gzk+/tGgjw8KtBu2v1f4nt5D3t4Qd45MKZduXz4+H5pwy1FQ3g2UsPyDyx+roLO8
	 2Je8OqBHndWBpQ99YAqEUVL8byCOMaSYxP67PyyHaMX0L07jooq0zOKBv7jMHWAIFO
	 Y6buBZ4ANSxEhf/uKeAoa4tUjNwPFanuPJLEQvLm4mk5TVaLcD6Qlgycs5crZjJ5mm
	 HNE1Ny87NtkL3cxN7N/qCMdvt5dBqlJA9m/RmfUXO14T3Edtv1N/6+x8FlfIwOIYby
	 gcGJupbK953WScdmk5rdmRa12sFBRuAur3RkZhCsFX5Gc6X0DBULoOytwEvlozRPLP
	 sYNzppemAmk0f9El5QbO/NxtytjNxC+QcXL+MswMSbd93Y/xgf7
X-Mailer: git-send-email 2.8.1.369.geae769a
In-Reply-To: <20160422220253.839970-1-sandals@crustytoothpaste.net>
X-Spam-Score: -0.262 BAYES_00,RDNS_NONE,T_DKIM_INVALID
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292279>

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 match-trees.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/match-trees.c b/match-trees.c
index 8ca7c68f..396b7338 100644
--- a/match-trees.c
+++ b/match-trees.c
@@ -48,17 +48,17 @@ static int score_matches(unsigned mode1, unsigned mode2, const char *path)
 }
 
 static void *fill_tree_desc_strict(struct tree_desc *desc,
-				   const unsigned char *hash)
+				   const struct object_id *hash)
 {
 	void *buffer;
 	enum object_type type;
 	unsigned long size;
 
-	buffer = read_sha1_file(hash, &type, &size);
+	buffer = read_sha1_file(hash->hash, &type, &size);
 	if (!buffer)
-		die("unable to read tree (%s)", sha1_to_hex(hash));
+		die("unable to read tree (%s)", oid_to_hex(hash));
 	if (type != OBJ_TREE)
-		die("%s is not a tree", sha1_to_hex(hash));
+		die("%s is not a tree", oid_to_hex(hash));
 	init_tree_desc(desc, buffer, size);
 	return buffer;
 }
@@ -73,7 +73,7 @@ static int base_name_entries_compare(const struct name_entry *a,
 /*
  * Inspect two trees, and give a score that tells how similar they are.
  */
-static int score_trees(const unsigned char *hash1, const unsigned char *hash2)
+static int score_trees(const struct object_id *hash1, const struct object_id *hash2)
 {
 	struct tree_desc one;
 	struct tree_desc two;
@@ -119,8 +119,8 @@ static int score_trees(const unsigned char *hash1, const unsigned char *hash2)
 /*
  * Match one itself and its subtrees with two and pick the best match.
  */
-static void match_trees(const unsigned char *hash1,
-			const unsigned char *hash2,
+static void match_trees(const struct object_id *hash1,
+			const struct object_id *hash2,
 			int *best_score,
 			char **best_match,
 			const char *base,
@@ -138,7 +138,7 @@ static void match_trees(const unsigned char *hash1,
 		elem = tree_entry_extract(&one, &path, &mode);
 		if (!S_ISDIR(mode))
 			goto next;
-		score = score_trees(elem->hash, hash2);
+		score = score_trees(elem, hash2);
 		if (*best_score < score) {
 			free(*best_match);
 			*best_match = xstrfmt("%s%s", base, path);
@@ -146,7 +146,7 @@ static void match_trees(const unsigned char *hash1,
 		}
 		if (recurse_limit) {
 			char *newbase = xstrfmt("%s%s/", base, path);
-			match_trees(elem->hash, hash2, best_score, best_match,
+			match_trees(elem, hash2, best_score, best_match,
 				    newbase, recurse_limit - 1);
 			free(newbase);
 		}
@@ -245,7 +245,7 @@ void shift_tree(const struct object_id *hash1,
 	if (!depth_limit)
 		depth_limit = 2;
 
-	add_score = del_score = score_trees(hash1->hash, hash2->hash);
+	add_score = del_score = score_trees(hash1, hash2);
 	add_prefix = xcalloc(1, 1);
 	del_prefix = xcalloc(1, 1);
 
@@ -253,13 +253,13 @@ void shift_tree(const struct object_id *hash1,
 	 * See if one's subtree resembles two; if so we need to prefix
 	 * two with a few fake trees to match the prefix.
 	 */
-	match_trees(hash1->hash, hash2->hash, &add_score, &add_prefix, "", depth_limit);
+	match_trees(hash1, hash2, &add_score, &add_prefix, "", depth_limit);
 
 	/*
 	 * See if two's subtree resembles one; if so we need to
 	 * pick only subtree of two.
 	 */
-	match_trees(hash2->hash, hash1->hash, &del_score, &del_prefix, "", depth_limit);
+	match_trees(hash2, hash1, &del_score, &del_prefix, "", depth_limit);
 
 	/* Assume we do not have to do any shifting */
 	oidcpy(shifted, hash2);
@@ -309,16 +309,16 @@ void shift_tree_by(const struct object_id *hash1,
 
 	if (candidate == 3) {
 		/* Both are plausible -- we need to evaluate the score */
-		int best_score = score_trees(hash1->hash, hash2->hash);
+		int best_score = score_trees(hash1, hash2);
 		int score;
 
 		candidate = 0;
-		score = score_trees(sub1.hash, hash2->hash);
+		score = score_trees(&sub1, hash2);
 		if (score > best_score) {
 			candidate = 1;
 			best_score = score;
 		}
-		score = score_trees(sub2.hash, hash1->hash);
+		score = score_trees(&sub2, hash1);
 		if (score > best_score)
 			candidate = 2;
 	}
-- 
2.8.1.369.geae769a
