Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 293F4C4743C
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 22:25:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0CDD9611CE
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 22:25:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231826AbhFUW1U (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Jun 2021 18:27:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbhFUW1P (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Jun 2021 18:27:15 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1BC0C061574
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 15:25:00 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id f10so12026679iok.6
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 15:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JMyZQ9uYc5pqgSysG3QhSpm5Mht+vN571BzNg3z+bE4=;
        b=gte72RpXXFDhja/Cowy27+9jX038s/p93WWxv+KXzFS+xi3u4WXZYAfm+KVHLrF5HL
         Q2Y8EXkbitX1VGqWcWuqYcd+3+F0vkp4d38jskE7/++AiX8vmLlgDq9g414aW9kYjSkY
         GKp6UWTCZc3MRY2I0kOVb1XaxDT+dHroJddPhI0QgqCae6E91t4dKXY68Esej0cNbVLo
         dCinAu2EdhiuYvgpOxUMi6bHRmIAJp+WuCYJLhcZSFsA+scN6Anplhb72T5Z+QjNQuml
         r99nrwNgkf0GWqNW/DikQBRlLqvnx/iYpZhtmMyAJn/Ynwk/zr9FGpJ0ZnU7FO8Scs4H
         9mZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JMyZQ9uYc5pqgSysG3QhSpm5Mht+vN571BzNg3z+bE4=;
        b=rV3k00Cd0RqoneBKxLGZXRjBcZb82xLHM/zpNZvFh7PwUApd4jP+W+9V7NwanlYJuc
         60F7GJ/A+bfU5TWcvM0+vYZ6pQUnqkZdXKczQlnQJRTzcmyeLN80G5x7TbJKzkhXGLl8
         VjpK6PXv/KC85aVuHCnCILjsgmoFYvXxLl2apHOcJ21FYrem7zATRcvlKGvp7PYIGa5l
         6lwas84pLy7joOUEpLTqjnqvfN4M3xuCAwHIIUPOAvSliKMtn1hqTycrA3EU/fntpyPb
         xFr9kArZGSWiCTIzuT1NAyH7OpES3LlF9OycgRsqDkjpZPEr0ye8xq6F44gj0MI+Msjv
         RNug==
X-Gm-Message-State: AOAM5336tVgWs3VsJpYuCVQIafcX1deXF91fYA+3bOHmg/g3vH271TnZ
        lA3dIkjek7Ngn5AA61WmZK8B9HqH5ElDj0k0
X-Google-Smtp-Source: ABdhPJwkj+5Sl1Q6f968iDnL9ZohjTONDgjf1/v/cPPIz5zf+cxyw6UFO59sO/3PrTxwd0f9vwwyww==
X-Received: by 2002:a6b:103:: with SMTP id 3mr245894iob.156.1624314300182;
        Mon, 21 Jun 2021 15:25:00 -0700 (PDT)
Received: from localhost ([2600:1700:d843:8f:f6bb:34fc:22a7:6a3])
        by smtp.gmail.com with ESMTPSA id g9sm6551099ile.12.2021.06.21.15.24.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jun 2021 15:24:59 -0700 (PDT)
Date:   Mon, 21 Jun 2021 18:24:59 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, dstolee@microsoft.com, gitster@pobox.com,
        jonathantanmy@google.com
Subject: [PATCH v2 01/24] pack-bitmap.c: harden 'test_bitmap_walk()' to check
 type bitmaps
Message-ID: <a18baeb0b42994ebcb216df5fe69459ba9a33795.1624314293.git.me@ttaylorr.com>
References: <cover.1617991824.git.me@ttaylorr.com>
 <cover.1624314293.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1624314293.git.me@ttaylorr.com>
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
index d90e1d9d8c..368fa59a42 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -1301,10 +1301,52 @@ void count_bitmap_commit_list(struct bitmap_index *bitmap_git,
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
@@ -1314,6 +1356,7 @@ static void test_show_object(struct object *object, const char *name,
 	bitmap_pos = bitmap_position(tdata->bitmap_git, &object->oid);
 	if (bitmap_pos < 0)
 		die("Object not in bitmap: %s\n", oid_to_hex(&object->oid));
+	test_bitmap_type(tdata, object, bitmap_pos);
 
 	bitmap_set(tdata->base, bitmap_pos);
 	display_progress(tdata->prg, ++tdata->seen);
@@ -1328,6 +1371,7 @@ static void test_show_commit(struct commit *commit, void *data)
 				     &commit->object.oid);
 	if (bitmap_pos < 0)
 		die("Object not in bitmap: %s\n", oid_to_hex(&commit->object.oid));
+	test_bitmap_type(tdata, &commit->object, bitmap_pos);
 
 	bitmap_set(tdata->base, bitmap_pos);
 	display_progress(tdata->prg, ++tdata->seen);
@@ -1375,6 +1419,10 @@ void test_bitmap_walk(struct rev_info *revs)
 
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

