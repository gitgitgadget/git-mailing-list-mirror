Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 318F8C4338F
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 16:16:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D41760F4C
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 16:16:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbhHXQQk (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Aug 2021 12:16:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbhHXQQh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Aug 2021 12:16:37 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E5B3C061764
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 09:15:53 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id n24so27064490ion.10
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 09:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JToHhdtVTn4etFI7xctZBFCHT+B0WOr0FcUxXLnQ+cw=;
        b=mxseS81UxeLaW1Fn5av4iuALFYcKrvwESqXo+L3TbsUtMDGrSLtsl5DZV0mTxz8eFE
         nv219+5kZq73VdnsStq5mDfTuJJcdvTZ3WSVSEYsgY6ifUTGsM7skPv+CSXteBg41W+k
         /c65F8A0h0hSxy7rkXmkuso31pzg7/j4eBXEd3KBNkNgO+6A4d0zKuk6vJiPSBC7343w
         GYc0wxZ09wKWsHm7ykoL5kVZoGompYHvNRAjMrQkXgQTQCINaN37g39npJbRVtmCvP6k
         MQSKt9QIeQprYslayqm4A7Mca20LLYVf3TJZfdAEoGHZHRM+LrmqE/P8kfLviVGDaTpj
         37FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JToHhdtVTn4etFI7xctZBFCHT+B0WOr0FcUxXLnQ+cw=;
        b=g/83tkkLZGFAUH3sgX0aXMvCJM4SWnmTaBmjCNYZiOTWQqvaWErNE/dPq1TDT8L/2R
         +73nCJPk9JwKdKvPijg2+jIROODp9+zPE90fUwWNlhJNSjNwjJiAG7xtKVxyiUHV3JLY
         GWjnB2MH5B/gx5VElim3TYdORcvvG7Mxgp/aV2oKHqiCW+fe1dBfIJsLWl1srSNggGvo
         X07aqk1PgTPmMaikuQTilKB9j19CPgpJ7ILBvjrX9xukQYCl2yo99s/D24jzme3T6/9o
         T37WA+n+GYhCDHrXFX0WaHjKPLMK/4mAFsQDkIGcvBSZQS4kxzo/XwChR/Rg6L2VTi1e
         pIfw==
X-Gm-Message-State: AOAM533VShFR/suMLKVjKc+D8bqY5KYL39vu3B4PakoSJAA5PglukAR2
        sOQKeq/Qa+UCQIWv/9S10fX80rWi9el39KWO
X-Google-Smtp-Source: ABdhPJzsHe5U8/YqXizHisR8tKmVN7rZ3WQBeWfWn56VxH1mLRWp1rsnUMUf2FF00ub+js/ECbmgpg==
X-Received: by 2002:a02:958e:: with SMTP id b14mr34917317jai.123.1629821752586;
        Tue, 24 Aug 2021 09:15:52 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id q15sm10059303ilm.60.2021.08.24.09.15.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 09:15:51 -0700 (PDT)
Date:   Tue, 24 Aug 2021 12:15:51 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, dstolee@microsoft.com, gitster@pobox.com,
        jonathantanmy@google.com
Subject: [PATCH v4 01/25] pack-bitmap.c: harden 'test_bitmap_walk()' to check
 type bitmaps
Message-ID: <92dc0bbc0d0e3297f9eb6f51e8d6f40b367a77ca.1629821743.git.me@ttaylorr.com>
References: <cover.1617991824.git.me@ttaylorr.com>
 <cover.1629821743.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1629821743.git.me@ttaylorr.com>
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
index d999616c9e..9b11af87aa 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -1325,10 +1325,52 @@ void count_bitmap_commit_list(struct bitmap_index *bitmap_git,
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
+	if (bitmap_type == OBJ_NONE)
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
@@ -1338,6 +1380,7 @@ static void test_show_object(struct object *object, const char *name,
 	bitmap_pos = bitmap_position(tdata->bitmap_git, &object->oid);
 	if (bitmap_pos < 0)
 		die("Object not in bitmap: %s\n", oid_to_hex(&object->oid));
+	test_bitmap_type(tdata, object, bitmap_pos);
 
 	bitmap_set(tdata->base, bitmap_pos);
 	display_progress(tdata->prg, ++tdata->seen);
@@ -1352,6 +1395,7 @@ static void test_show_commit(struct commit *commit, void *data)
 				     &commit->object.oid);
 	if (bitmap_pos < 0)
 		die("Object not in bitmap: %s\n", oid_to_hex(&commit->object.oid));
+	test_bitmap_type(tdata, &commit->object, bitmap_pos);
 
 	bitmap_set(tdata->base, bitmap_pos);
 	display_progress(tdata->prg, ++tdata->seen);
@@ -1399,6 +1443,10 @@ void test_bitmap_walk(struct rev_info *revs)
 
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

