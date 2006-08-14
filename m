From: David Rientjes <rientjes@google.com>
Subject: [PATCH 04/28] builtin-diff.c cleanup
Date: Mon, 14 Aug 2006 13:21:24 -0700 (PDT)
Message-ID: <Pine.LNX.4.63.0608141320140.19383@chino.corp.google.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Mon Aug 14 22:21:45 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GCiwO-0006Xh-7i
	for gcvg-git@gmane.org; Mon, 14 Aug 2006 22:21:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932711AbWHNUVh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 Aug 2006 16:21:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932713AbWHNUVh
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Aug 2006 16:21:37 -0400
Received: from smtp-out.google.com ([216.239.45.12]:23695 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP id S932711AbWHNUVg
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Aug 2006 16:21:36 -0400
Received: from zps75.corp.google.com (zps75.corp.google.com [172.25.146.75])
	by smtp-out.google.com with ESMTP id k7EKLSVd004629
	for <git@vger.kernel.org>; Mon, 14 Aug 2006 13:21:28 -0700
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:date:from:x-x-sender:to:subject:message-id:
	mime-version:content-type;
	b=PrAXTJwpvPvhKRbsKepMuKdUBqgTjH2FN9haHJab0yttpxzSEsu7K9kxQh6J2roby
	mOF7l7fUmrbveTlXvB2CQ==
Received: from localhost (chino.corp.google.com [172.24.88.221])
	by zps75.corp.google.com with ESMTP id k7EKLOdt029256
	for <git@vger.kernel.org>; Mon, 14 Aug 2006 13:21:24 -0700
Received: by localhost (Postfix, from userid 24081)
	id 71BA787D71; Mon, 14 Aug 2006 13:21:24 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by localhost (Postfix) with ESMTP id 6F15A87D70
	for <git@vger.kernel.org>; Mon, 14 Aug 2006 13:21:24 -0700 (PDT)
X-X-Sender: rientjes@chino.corp.google.com
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25384>

Makes functions void and cleans up calling functions.

		David

Signed-off-by: David Rientjes <rientjes@google.com>
---
 builtin-diff.c |   57 +++++++++++++++++++++++++++-----------------------------
 1 files changed, 27 insertions(+), 30 deletions(-)

diff --git a/builtin-diff.c b/builtin-diff.c
index 82afce7..ca157e2 100644
--- a/builtin-diff.c
+++ b/builtin-diff.c
@@ -90,10 +90,10 @@ static void stuff_change(struct diff_opt
 	diff_queue(&diff_queued_diff, one, two);
 }
 
-static int builtin_diff_b_f(struct rev_info *revs,
-			    int argc, const char **argv,
-			    struct blobinfo *blob,
-			    const char *path)
+static void builtin_diff_b_f(struct rev_info *revs,
+			     int argc, const char **argv,
+			     struct blobinfo *blob,
+			     const char *path)
 {
 	/* Blob vs file in the working tree*/
 	struct stat st;
@@ -111,12 +111,11 @@ static int builtin_diff_b_f(struct rev_i
 		     path, path);
 	diffcore_std(&revs->diffopt);
 	diff_flush(&revs->diffopt);
-	return 0;
 }
 
-static int builtin_diff_blobs(struct rev_info *revs,
-			      int argc, const char **argv,
-			      struct blobinfo *blob)
+static void builtin_diff_blobs(struct rev_info *revs,
+			       int argc, const char **argv,
+			       struct blobinfo *blob)
 {
 	unsigned mode = canon_mode(S_IFREG | 0644);
 
@@ -129,7 +128,6 @@ static int builtin_diff_blobs(struct rev
 		     blob[0].name, blob[1].name);
 	diffcore_std(&revs->diffopt);
 	diff_flush(&revs->diffopt);
-	return 0;
 }
 
 static int builtin_diff_index(struct rev_info *revs,
@@ -155,9 +153,9 @@ static int builtin_diff_index(struct rev
 	return run_diff_index(revs, cached);
 }
 
-static int builtin_diff_tree(struct rev_info *revs,
-			     int argc, const char **argv,
-			     struct object_array_entry *ent)
+static void builtin_diff_tree(struct rev_info *revs,
+			      int argc, const char **argv,
+			      struct object_array_entry *ent)
 {
 	const unsigned char *(sha1[2]);
 	int swap = 0;
@@ -174,13 +172,12 @@ static int builtin_diff_tree(struct rev_
 	sha1[1-swap] = ent[1].item->sha1;
 	diff_tree_sha1(sha1[0], sha1[1], "", &revs->diffopt);
 	log_tree_diff_flush(revs);
-	return 0;
 }
 
-static int builtin_diff_combined(struct rev_info *revs,
-				 int argc, const char **argv,
-				 struct object_array_entry *ent,
-				 int ents)
+static void builtin_diff_combined(struct rev_info *revs,
+				  int argc, const char **argv,
+				  struct object_array_entry *ent,
+				  int ents)
 {
 	const unsigned char (*parent)[20];
 	int i;
@@ -196,7 +193,6 @@ static int builtin_diff_combined(struct 
 		memcpy(parent + i, ent[ents - 1 - i].item->sha1, 20);
 	diff_tree_combined(parent[0], parent + 1, ents - 1,
 			   revs->dense_combined_merges, revs);
-	return 0;
 }
 
 void add_head(struct rev_info *revs)
@@ -316,17 +312,16 @@ int cmd_diff(int argc, const char **argv
 		switch (blobs) {
 		case 0:
 			return builtin_diff_files(&rev, argc, argv);
-			break;
 		case 1:
 			if (paths != 1)
 				usage(builtin_diff_usage);
-			return builtin_diff_b_f(&rev, argc, argv, blob, path);
-			break;
+			builtin_diff_b_f(&rev, argc, argv, blob, path);
+			return 0;
 		case 2:
 			if (paths)
 				usage(builtin_diff_usage);
-			return builtin_diff_blobs(&rev, argc, argv, blob);
-			break;
+			builtin_diff_blobs(&rev, argc, argv, blob);
+			return 0;
 		default:
 			usage(builtin_diff_usage);
 		}
@@ -335,18 +330,20 @@ int cmd_diff(int argc, const char **argv
 		usage(builtin_diff_usage);
 	else if (ents == 1)
 		return builtin_diff_index(&rev, argc, argv);
-	else if (ents == 2)
-		return builtin_diff_tree(&rev, argc, argv, ent);
-	else if ((ents == 3) && (ent[0].item->flags & UNINTERESTING)) {
+	else if (ents == 2) {
+		builtin_diff_tree(&rev, argc, argv, ent);
+		return 0;
+	} else if ((ents == 3) && (ent[0].item->flags & UNINTERESTING)) {
 		/* diff A...B where there is one sane merge base between
 		 * A and B.  We have ent[0] == merge-base, ent[1] == A,
 		 * and ent[2] == B.  Show diff between the base and B.
 		 */
 		ent[1] = ent[2];
-		return builtin_diff_tree(&rev, argc, argv, ent);
+		builtin_diff_tree(&rev, argc, argv, ent);
+		return 0;
+	} else {
+		builtin_diff_combined(&rev, argc, argv, ent, ents);
+		return 0;
 	}
-	else
-		return builtin_diff_combined(&rev, argc, argv,
-					     ent, ents);
 	usage(builtin_diff_usage);
 }
-- 
1.4.2.g89bb-dirty
