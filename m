Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3983E20958
	for <e@80x24.org>; Sun, 26 Mar 2017 16:03:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751691AbdCZQDI (ORCPT <rfc822;e@80x24.org>);
        Sun, 26 Mar 2017 12:03:08 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:58008 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751406AbdCZQB6 (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 26 Mar 2017 12:01:58 -0400
Received: from genre.crustytoothpaste.net (unknown [172.16.2.244])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 52161280B1;
        Sun, 26 Mar 2017 16:01:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1490544113;
        bh=vloCFYZNrWxRuB81JKVsW6w0m1QPGOwoA9F8kAvN3SI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TWO5OY+x6JKWd0HMgoPEEkY+wz7uSbI18uzBHCiCfSrdgpbcqGSAszbl55bSi7YH8
         KI2BJ2VS9lSl3gonQRWDT/DfVaDykt0A2dnT+T4UyJObo5ZHPvYwcSeDfuET8gGOMD
         Z4xVrSR55FScgRxQm/uoP5HMFYU2MxzRY6pdBxCDjYCASAiDBLTEiUceFv76VRXD2/
         N+7/Tbpew0GDuAJ8UgIv28x/vVZRKSwgq0mZrrGjPa6vxFVWDfC+CdNTQXedcspp1w
         un8ecCispxImlBjCDcxDejJlnJhzrZsJ33BhT5vNls/6+QytnMfkCFpNjoTelpseQ/
         YVJ4c9M00hA9PYgvE2iuodBZ3o4YXb3u0CU81k0vb2pwJ3LM4WFYBPISxkTcp/tQCg
         4ArO2PL2o6/O9Gjw/TER9jKWRVj0CrVDwgnAHzis/Ch2r2UClWuvb/Ea6HVm0bZxHE
         /5h2KykrOsdn06A4TW6aACZJdHJU/q7hkVD5cJo5IKvLywFThXU
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 04/21] builtin/diff: convert to struct object_id
Date:   Sun, 26 Mar 2017 16:01:26 +0000
Message-Id: <20170326160143.769630-5-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170326160143.769630-1-sandals@crustytoothpaste.net>
References: <20170326160143.769630-1-sandals@crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/diff.c | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/builtin/diff.c b/builtin/diff.c
index 3d64b85337..398eee00d5 100644
--- a/builtin/diff.c
+++ b/builtin/diff.c
@@ -21,7 +21,7 @@
 #define DIFF_NO_INDEX_IMPLICIT 2
 
 struct blobinfo {
-	unsigned char sha1[20];
+	struct object_id oid;
 	const char *name;
 	unsigned mode;
 };
@@ -31,22 +31,22 @@ static const char builtin_diff_usage[] =
 
 static void stuff_change(struct diff_options *opt,
 			 unsigned old_mode, unsigned new_mode,
-			 const unsigned char *old_sha1,
-			 const unsigned char *new_sha1,
-			 int old_sha1_valid,
-			 int new_sha1_valid,
+			 const struct object_id *old_oid,
+			 const struct object_id *new_oid,
+			 int old_oid_valid,
+			 int new_oid_valid,
 			 const char *old_name,
 			 const char *new_name)
 {
 	struct diff_filespec *one, *two;
 
-	if (!is_null_sha1(old_sha1) && !is_null_sha1(new_sha1) &&
-	    !hashcmp(old_sha1, new_sha1) && (old_mode == new_mode))
+	if (!is_null_oid(old_oid) && !is_null_oid(new_oid) &&
+	    !oidcmp(old_oid, new_oid) && (old_mode == new_mode))
 		return;
 
 	if (DIFF_OPT_TST(opt, REVERSE_DIFF)) {
 		SWAP(old_mode, new_mode);
-		SWAP(old_sha1, new_sha1);
+		SWAP(old_oid, new_oid);
 		SWAP(old_name, new_name);
 	}
 
@@ -57,8 +57,8 @@ static void stuff_change(struct diff_options *opt,
 
 	one = alloc_filespec(old_name);
 	two = alloc_filespec(new_name);
-	fill_filespec(one, old_sha1, old_sha1_valid, old_mode);
-	fill_filespec(two, new_sha1, new_sha1_valid, new_mode);
+	fill_filespec(one, old_oid->hash, old_oid_valid, old_mode);
+	fill_filespec(two, new_oid->hash, new_oid_valid, new_mode);
 
 	diff_queue(&diff_queued_diff, one, two);
 }
@@ -89,7 +89,7 @@ static int builtin_diff_b_f(struct rev_info *revs,
 
 	stuff_change(&revs->diffopt,
 		     blob[0].mode, canon_mode(st.st_mode),
-		     blob[0].sha1, null_sha1,
+		     &blob[0].oid, &null_oid,
 		     1, 0,
 		     path, path);
 	diffcore_std(&revs->diffopt);
@@ -114,7 +114,7 @@ static int builtin_diff_blobs(struct rev_info *revs,
 
 	stuff_change(&revs->diffopt,
 		     blob[0].mode, blob[1].mode,
-		     blob[0].sha1, blob[1].sha1,
+		     &blob[0].oid, &blob[1].oid,
 		     1, 1,
 		     blob[0].name, blob[1].name);
 	diffcore_std(&revs->diffopt);
@@ -160,7 +160,7 @@ static int builtin_diff_tree(struct rev_info *revs,
 			     struct object_array_entry *ent0,
 			     struct object_array_entry *ent1)
 {
-	const unsigned char *(sha1[2]);
+	const struct object_id *(oid[2]);
 	int swap = 0;
 
 	if (argc > 1)
@@ -172,9 +172,9 @@ static int builtin_diff_tree(struct rev_info *revs,
 	 */
 	if (ent1->item->flags & UNINTERESTING)
 		swap = 1;
-	sha1[swap] = ent0->item->oid.hash;
-	sha1[1 - swap] = ent1->item->oid.hash;
-	diff_tree_sha1(sha1[0], sha1[1], "", &revs->diffopt);
+	oid[swap] = &ent0->item->oid;
+	oid[1 - swap] = &ent1->item->oid;
+	diff_tree_sha1(oid[0]->hash, oid[1]->hash, "", &revs->diffopt);
 	log_tree_diff_flush(revs);
 	return 0;
 }
@@ -408,7 +408,7 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
 		} else if (obj->type == OBJ_BLOB) {
 			if (2 <= blobs)
 				die(_("more than two blobs given: '%s'"), name);
-			hashcpy(blob[blobs].sha1, obj->oid.hash);
+			hashcpy(blob[blobs].oid.hash, obj->oid.hash);
 			blob[blobs].name = name;
 			blob[blobs].mode = entry->mode;
 			blobs++;
