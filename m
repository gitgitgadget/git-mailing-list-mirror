Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4D6CC433B4
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 18:10:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD2CC61007
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 18:10:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234481AbhDISK5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Apr 2021 14:10:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233332AbhDISKz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Apr 2021 14:10:55 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2E7BC061761
        for <git@vger.kernel.org>; Fri,  9 Apr 2021 11:10:42 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id 6so5436789ilt.9
        for <git@vger.kernel.org>; Fri, 09 Apr 2021 11:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=W75OvUzV1Ne5gy9b3QjGrVR36zju90e4pT7ovIYRPkg=;
        b=Et0SkSaDZJUl/PJimgsyRpv1cjtLKBtjvlz2dQgU07u3NM0fIZQ4XiJ/pCv9ybETbq
         B9+NWU8EKzl3OxxnRmG4iYkZX2t93wYhOOkv4l3YXfoTHfeHgc3CBE2DnaTYQHBbba0C
         dW3nSHnHS9zktmBq4pTDA7xhakyRCJpiBisdmhM2OugcRVUGy8V0Pq8rMFk9WlX89w5F
         vpVAL8ErWaTV40VkA/sQxl0Z5LQXPKa2nsBImgOv9IiJVQ67AwvV4Cr9LRZoleA+4/BW
         YOuPRGKQm+0PwA1P3J8BtJejelVvMJ6AGa9JzVUQ9SR+oesM+y23xaRS9ptnrmCcLPZV
         t0FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=W75OvUzV1Ne5gy9b3QjGrVR36zju90e4pT7ovIYRPkg=;
        b=pyueVD4ykLyyX+G4wK09PYA7XZenoFWBRIE2A/qZeq2xQVDHKIUZdkGvDpjya2IKiL
         sX/SbT6+JSzEOWS6VH5qYI0t/VRnnNRPWsctN6j1cW8gMAd5D8Amz3YpBPONsdwELKPB
         RTJRBptnrf5bn4+fGiXxGH9u7FFLJlGvut8eInzL0mPLF978kxcKiueCOrAcTndOPkyV
         9hD2j6EyOmlc5edmtNO90kivcmMuNLO8tNKc0WImCoFnUJj9QUO2N9mFsjKTR4p5n3nq
         zTBWYZpcLJZvKTwkjTdfV42aAt7ykNMDtEtNEEbKu/eXYLIlaiV/m/YVpTSN+BN7Sm03
         dSQg==
X-Gm-Message-State: AOAM531KLyk6i6IUlYJgV/jX0LuxQU8dYIDXmRm7FXsvK22pyoZgfmmk
        qk3XkdRE7DS1VJfDTxt4zf6WnVWEVv7BAP8O
X-Google-Smtp-Source: ABdhPJw5p7gIyFh0eqLvqrrUIHQ4XlCS/HEb5VnGBYkPu03Dv0/1nqhMsvfwRubOMLCve6mvYhVTFQ==
X-Received: by 2002:a05:6e02:198f:: with SMTP id g15mr12255895ilf.200.1617991841930;
        Fri, 09 Apr 2021 11:10:41 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:64f1:fbc0:31eb:386a])
        by smtp.gmail.com with ESMTPSA id q21sm1594917ioh.41.2021.04.09.11.10.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 11:10:41 -0700 (PDT)
Date:   Fri, 9 Apr 2021 14:10:39 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, dstolee@microsoft.com, gitster@pobox.com,
        jonathantanmy@google.com
Subject: [PATCH 01/22] pack-bitmap.c: harden 'test_bitmap_walk()' to check
 type bitmaps
Message-ID: <2d1c6ccab5e2feaa4db1bcd08178a698b3e00241.1617991824.git.me@ttaylorr.com>
References: <cover.1617991824.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1617991824.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The special `--test-bitmap` mode of `git rev-list` is used to compare
the result of an object traversal with a bitmap to check its integrity.
This mode does not, however, assert that the types of reachable objects
are stored correctly.

Harden this mode by teaching it to also check that each time an object's
bit is marked, the corresponding bit should be set in exactly one of the
type bitmaps (whose type matches the object's true type).

Co-authored-by: Jeff King <peff@peff.net>
Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 pack-bitmap.c | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index 3ed15431cd..d45e91db1e 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -1263,10 +1263,52 @@ void count_bitmap_commit_list(struct bitmap_index *bitmap_git,
 struct bitmap_test_data {
 	struct bitmap_index *bitmap_git;
 	struct bitmap *base;
+	struct bitmap *commits;
+	struct bitmap *trees;
+	struct bitmap *blobs;
+	struct bitmap *tags;
 	struct progress *prg;
 	size_t seen;
 };
 
+static void test_bitmap_type(struct bitmap_test_data *tdata,
+			     struct object *obj, int pos)
+{
+	enum object_type bitmap_type = OBJ_NONE;
+	int bitmaps_nr = 0;
+
+	if (bitmap_get(tdata->commits, pos)) {
+		bitmap_type = OBJ_COMMIT;
+		bitmaps_nr++;
+	}
+	if (bitmap_get(tdata->trees, pos)) {
+		bitmap_type = OBJ_TREE;
+		bitmaps_nr++;
+	}
+	if (bitmap_get(tdata->blobs, pos)) {
+		bitmap_type = OBJ_BLOB;
+		bitmaps_nr++;
+	}
+	if (bitmap_get(tdata->tags, pos)) {
+		bitmap_type = OBJ_TAG;
+		bitmaps_nr++;
+	}
+
+	if (!bitmap_type)
+		die("object %s not found in type bitmaps",
+		    oid_to_hex(&obj->oid));
+
+	if (bitmaps_nr > 1)
+		die("object %s does not have a unique type",
+		    oid_to_hex(&obj->oid));
+
+	if (bitmap_type != obj->type)
+		die("object %s: real type %s, expected: %s",
+		    oid_to_hex(&obj->oid),
+		    type_name(obj->type),
+		    type_name(bitmap_type));
+}
+
 static void test_show_object(struct object *object, const char *name,
 			     void *data)
 {
@@ -1276,6 +1318,7 @@ static void test_show_object(struct object *object, const char *name,
 	bitmap_pos = bitmap_position(tdata->bitmap_git, &object->oid);
 	if (bitmap_pos < 0)
 		die("Object not in bitmap: %s\n", oid_to_hex(&object->oid));
+	test_bitmap_type(tdata, object, bitmap_pos);
 
 	bitmap_set(tdata->base, bitmap_pos);
 	display_progress(tdata->prg, ++tdata->seen);
@@ -1290,6 +1333,7 @@ static void test_show_commit(struct commit *commit, void *data)
 				     &commit->object.oid);
 	if (bitmap_pos < 0)
 		die("Object not in bitmap: %s\n", oid_to_hex(&commit->object.oid));
+	test_bitmap_type(tdata, &commit->object, bitmap_pos);
 
 	bitmap_set(tdata->base, bitmap_pos);
 	display_progress(tdata->prg, ++tdata->seen);
@@ -1337,6 +1381,10 @@ void test_bitmap_walk(struct rev_info *revs)
 
 	tdata.bitmap_git = bitmap_git;
 	tdata.base = bitmap_new();
+	tdata.commits = ewah_to_bitmap(bitmap_git->commits);
+	tdata.trees = ewah_to_bitmap(bitmap_git->trees);
+	tdata.blobs = ewah_to_bitmap(bitmap_git->blobs);
+	tdata.tags = ewah_to_bitmap(bitmap_git->tags);
 	tdata.prg = start_progress("Verifying bitmap entries", result_popcnt);
 	tdata.seen = 0;
 
-- 
2.31.1.163.ga65ce7f831

