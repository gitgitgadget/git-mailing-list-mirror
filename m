Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2CC491FE4E
	for <e@80x24.org>; Wed, 29 Jun 2016 11:37:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752264AbcF2LhD (ORCPT <rfc822;e@80x24.org>);
	Wed, 29 Jun 2016 07:37:03 -0400
Received: from mout.gmx.net ([212.227.15.15]:58231 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752191AbcF2Lg7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jun 2016 07:36:59 -0400
Received: from virtualbox ([37.24.143.100]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0MHX4u-1bLXBb12w0-003NPm; Wed, 29 Jun 2016 13:36:55
 +0200
Date:	Wed, 29 Jun 2016 13:36:54 +0200 (CEST)
From:	Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	git@vger.kernel.org
cc:	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 5/9] merge-recursive: avoid returning a wholesale struct
In-Reply-To: <cover.1467199553.git.johannes.schindelin@gmx.de>
Message-ID: <c33e9cdb1ec6cbebcc3124a62b7b9d52b92cf6c9.1467199553.git.johannes.schindelin@gmx.de>
References: <cover.1467199553.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:Yi4sLYmS8HmQQORU/2SitmTSPIc03QGL0f+pGi3dfBMwz2OWhK0
 tq+fDxbRedU92EtLeE1vYwPs/vzzMVO5yY1fLV4yuKmgTn7YbuwmmDQr0kLE1pmqBrt6bAc
 dmmRY38SycHJ2Xwk5AcgJ+IXBvKugoXy2ovsnYx+MsStzLzh3waFhFbnLoPh7U1xMoVkjUM
 kCaxKhDNcm57ZJYTRP4hg==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:JqBsSDo+6Ns=:hIdmJT8VSRHrm405qyOXkf
 YaiHQrK8k+eRDHM/Z1mB3IP82PRFbbgkrt0zBmNLYon63L9LjyyjOphJGL5bLANw4xkLLMA6h
 Dc7gFXWCsfqlZZv/c1uOKJD8+y1BDAMe/wL4LrjxjY4V+1onYg8o6jaIkGvDI5b0rEYSFHX6n
 8jJK/ZbRtkwWkl4T1lmTm2i0ZnohimQxYLwQpXaaNOuulLVPq05MEGaEeH+/8CVi+AYsyh7iH
 y1H27KTxMnGtsmbdG/mshV+Wr2b3mucxV53vvq8vebG8HS9qd3CB5Nat1oAVm4eaRg+X5b+Ls
 T5vnlZpiOJG3NHm+ZYW29wWv2/si/jsWy2tQ7U2dobhagKMLwsC7ZKYAhNca0i2SUIemU0ElB
 heq+Hj7tPgE6L+PLAjkh9FLQ5wlHrT//H2T1vJdthb+G2nT4tAxpE0ld/i8K16p/MgvTDfzUF
 4XQLLWOIuN4p5IoTvoUwge7Z8FWxY3mEYsue0biKb95kdQ62Zb2squiwdC5XzkvQDtYdGt1jA
 W4y9Ml+2IpQAX+uLTUp/f2yd7WuucDjNhe/JctLJt27pqIJLvzRm4+wnVZYScOQaHXGdaBiAv
 pOR8PPaAoU7t067EbPkzF6NQ841/g+hSvTE46EZ0yjxpxj3USypzSSYhadyKSB3miP64UOAsQ
 zSm9u0wCGcfenvY1WhLiGa67oYUOkuoJhYgN5Sx0LgKtf3pT6uCDQRwaczaVSxujvU0SpRAK6
 mC4IcZ9sf6gBRUDuIQwsFIQdvJNA4a6aS+eylg5OrKzU7wvz1yG2OIV4BJzBCed18ATOWYv2x
 YumreWr
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

It is technically allowed, as per C89, for functions' return type to
be complete structs (i.e. *not* just pointers to structs), but it is
bad practice.

This is a very late attempt to contain the damage done by this developer
in 6d297f8 (Status update on merge-recursive in C, 2006-07-08) which
introduced such a return type.

It will also help the current effort to libify merge-recursive.c, as
it will allow us to return proper error codes later.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 merge-recursive.c | 93 ++++++++++++++++++++++++++++++-------------------------
 1 file changed, 50 insertions(+), 43 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index c4ece96..d56651c9 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -888,47 +888,47 @@ static int merge_3way(struct merge_options *o,
 	return merge_status;
 }
 
-static struct merge_file_info merge_file_1(struct merge_options *o,
+static int merge_file_1(struct merge_options *o,
 					   const struct diff_filespec *one,
 					   const struct diff_filespec *a,
 					   const struct diff_filespec *b,
 					   const char *branch1,
-					   const char *branch2)
+					   const char *branch2,
+					   struct merge_file_info *result)
 {
-	struct merge_file_info result;
-	result.merge = 0;
-	result.clean = 1;
+	result->merge = 0;
+	result->clean = 1;
 
 	if ((S_IFMT & a->mode) != (S_IFMT & b->mode)) {
-		result.clean = 0;
+		result->clean = 0;
 		if (S_ISREG(a->mode)) {
-			result.mode = a->mode;
-			hashcpy(result.sha, a->sha1);
+			result->mode = a->mode;
+			hashcpy(result->sha, a->sha1);
 		} else {
-			result.mode = b->mode;
-			hashcpy(result.sha, b->sha1);
+			result->mode = b->mode;
+			hashcpy(result->sha, b->sha1);
 		}
 	} else {
 		if (!sha_eq(a->sha1, one->sha1) && !sha_eq(b->sha1, one->sha1))
-			result.merge = 1;
+			result->merge = 1;
 
 		/*
 		 * Merge modes
 		 */
 		if (a->mode == b->mode || a->mode == one->mode)
-			result.mode = b->mode;
+			result->mode = b->mode;
 		else {
-			result.mode = a->mode;
+			result->mode = a->mode;
 			if (b->mode != one->mode) {
-				result.clean = 0;
-				result.merge = 1;
+				result->clean = 0;
+				result->merge = 1;
 			}
 		}
 
 		if (sha_eq(a->sha1, b->sha1) || sha_eq(a->sha1, one->sha1))
-			hashcpy(result.sha, b->sha1);
+			hashcpy(result->sha, b->sha1);
 		else if (sha_eq(b->sha1, one->sha1))
-			hashcpy(result.sha, a->sha1);
+			hashcpy(result->sha, a->sha1);
 		else if (S_ISREG(a->mode)) {
 			mmbuffer_t result_buf;
 			int merge_status;
@@ -940,62 +940,63 @@ static struct merge_file_info merge_file_1(struct merge_options *o,
 				die(_("Failed to execute internal merge"));
 
 			if (write_sha1_file(result_buf.ptr, result_buf.size,
-					    blob_type, result.sha))
+					    blob_type, result->sha))
 				die(_("Unable to add %s to database"),
 				    a->path);
 
 			free(result_buf.ptr);
-			result.clean = (merge_status == 0);
+			result->clean = (merge_status == 0);
 		} else if (S_ISGITLINK(a->mode)) {
-			result.clean = merge_submodule(result.sha,
+			result->clean = merge_submodule(result->sha,
 						       one->path, one->sha1,
 						       a->sha1, b->sha1,
 						       !o->call_depth);
 		} else if (S_ISLNK(a->mode)) {
-			hashcpy(result.sha, a->sha1);
+			hashcpy(result->sha, a->sha1);
 
 			if (!sha_eq(a->sha1, b->sha1))
-				result.clean = 0;
+				result->clean = 0;
 		} else
 			die(_("BUG: unsupported object type in the tree"));
 	}
 
-	return result;
+	return 0;
 }
 
-static struct merge_file_info
-merge_file_special_markers(struct merge_options *o,
+static int merge_file_special_markers(struct merge_options *o,
 			   const struct diff_filespec *one,
 			   const struct diff_filespec *a,
 			   const struct diff_filespec *b,
 			   const char *branch1,
 			   const char *filename1,
 			   const char *branch2,
-			   const char *filename2)
+			   const char *filename2,
+			   struct merge_file_info *mfi)
 {
 	char *side1 = NULL;
 	char *side2 = NULL;
-	struct merge_file_info mfi;
+	int ret;
 
 	if (filename1)
 		side1 = xstrfmt("%s:%s", branch1, filename1);
 	if (filename2)
 		side2 = xstrfmt("%s:%s", branch2, filename2);
 
-	mfi = merge_file_1(o, one, a, b,
-			   side1 ? side1 : branch1, side2 ? side2 : branch2);
+	ret = merge_file_1(o, one, a, b,
+		side1 ? side1 : branch1, side2 ? side2 : branch2, mfi);
 	free(side1);
 	free(side2);
-	return mfi;
+	return ret;
 }
 
-static struct merge_file_info merge_file_one(struct merge_options *o,
+static int merge_file_one(struct merge_options *o,
 					 const char *path,
 					 const unsigned char *o_sha, int o_mode,
 					 const unsigned char *a_sha, int a_mode,
 					 const unsigned char *b_sha, int b_mode,
 					 const char *branch1,
-					 const char *branch2)
+					 const char *branch2,
+					 struct merge_file_info *mfi)
 {
 	struct diff_filespec one, a, b;
 
@@ -1006,7 +1007,7 @@ static struct merge_file_info merge_file_one(struct merge_options *o,
 	a.mode = a_mode;
 	hashcpy(b.sha1, b_sha);
 	b.mode = b_mode;
-	return merge_file_1(o, &one, &a, &b, branch1, branch2);
+	return merge_file_1(o, &one, &a, &b, branch1, branch2, mfi);
 }
 
 static void handle_change_delete(struct merge_options *o,
@@ -1179,11 +1180,14 @@ static void conflict_rename_rename_1to2(struct merge_options *o,
 		struct merge_file_info mfi;
 		struct diff_filespec other;
 		struct diff_filespec *add;
-		mfi = merge_file_one(o, one->path,
+
+		if (merge_file_one(o, one->path,
 				 one->sha1, one->mode,
 				 a->sha1, a->mode,
 				 b->sha1, b->mode,
-				 ci->branch1, ci->branch2);
+				 ci->branch1, ci->branch2, &mfi) < 0)
+			return;
+
 		/*
 		 * FIXME: For rename/add-source conflicts (if we could detect
 		 * such), this is wrong.  We should instead find a unique
@@ -1237,12 +1241,13 @@ static void conflict_rename_rename_2to1(struct merge_options *o,
 	remove_file(o, 1, a->path, o->call_depth || would_lose_untracked(a->path));
 	remove_file(o, 1, b->path, o->call_depth || would_lose_untracked(b->path));
 
-	mfi_c1 = merge_file_special_markers(o, a, c1, &ci->ren1_other,
+	if (merge_file_special_markers(o, a, c1, &ci->ren1_other,
 					    o->branch1, c1->path,
-					    o->branch2, ci->ren1_other.path);
-	mfi_c2 = merge_file_special_markers(o, b, &ci->ren2_other, c2,
+					    o->branch2, ci->ren1_other.path, &mfi_c1) < 0 ||
+	    merge_file_special_markers(o, b, &ci->ren2_other, c2,
 					    o->branch1, ci->ren2_other.path,
-					    o->branch2, c2->path);
+					    o->branch2, c2->path, &mfi_c2) < 0)
+		return;
 
 	if (o->call_depth) {
 		/*
@@ -1463,10 +1468,11 @@ static int process_renames(struct merge_options *o,
 				       ren1_dst, branch2);
 				if (o->call_depth) {
 					struct merge_file_info mfi;
-					mfi = merge_file_one(o, ren1_dst, null_sha1, 0,
+					if (merge_file_one(o, ren1_dst, null_sha1, 0,
 							 ren1->pair->two->sha1, ren1->pair->two->mode,
 							 dst_other.sha1, dst_other.mode,
-							 branch1, branch2);
+							 branch1, branch2, &mfi) < 0)
+						return -1;
 					output(o, 1, _("Adding merged %s"), ren1_dst);
 					update_file(o, 0, mfi.sha, mfi.mode, ren1_dst);
 					try_merge = 0;
@@ -1622,9 +1628,10 @@ static int merge_content(struct merge_options *o,
 		if (dir_in_way(path, !o->call_depth))
 			df_conflict_remains = 1;
 	}
-	mfi = merge_file_special_markers(o, &one, &a, &b,
+	if (merge_file_special_markers(o, &one, &a, &b,
 					 o->branch1, path1,
-					 o->branch2, path2);
+					 o->branch2, path2, &mfi) < 0)
+		return -1;
 
 	if (mfi.clean && !df_conflict_remains &&
 	    sha_eq(mfi.sha, a_sha) && mfi.mode == a_mode) {
-- 
2.9.0.268.gcabc8b0


