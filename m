Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA9CDC432BE
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 20:51:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A4CC60ED4
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 20:51:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241159AbhHaUwn (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 Aug 2021 16:52:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241217AbhHaUwj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Aug 2021 16:52:39 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04DAEC061796
        for <git@vger.kernel.org>; Tue, 31 Aug 2021 13:51:44 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id b10so760904ioq.9
        for <git@vger.kernel.org>; Tue, 31 Aug 2021 13:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+P3lStOCr1PeSqvaQjnYzB0LEBCnLp1CL09lxHtH7a0=;
        b=B751DgvX/R3rNY9COXWG1C9LPpWw0K+HjZUi3w2E6ueD2tohgLOtM6Qv5SE9mTISsm
         YqjKD5oVH+0f3mVJWwAEg/rtkm85mEptiSKCffUijND7aMgdEfrlCvCxYbXknBv9vc2v
         4UgJ1wHi5dhb5QPvJaD/d9XXh5RzgpRxD6XQeipE+mVQDi8vSeiNkafMoCIKAIlbMDBw
         xdVtNciB1/qMDhpKMAaL2zz4sZmNgnLlV1gS64Ripsu2BSzIHZVG+P3tJJA1HE7bs3JT
         x4CYZJ04EwoOz6d5PHz9LGke9cyFM+6MH2cwsmKb8tkrv8toE417b/HHbIwrEg6Ri2n4
         MRKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+P3lStOCr1PeSqvaQjnYzB0LEBCnLp1CL09lxHtH7a0=;
        b=my60ooouvr7+Z+TARZOfzujVSUHu3/AlDfRVw176yG18+fpU4mXCToUGtxp52p4CEC
         m5zvfwKzBUyT2ekPGyCgqeHJg9hH25XEs3DeiZIOp6byU4P+4eRIPtf0erCW43kL6llN
         EqMEQWiUhmSNlKRqbjgAbd5hdLcSuxLGcLVn3kBPIpiS9qNV+OBDdX/ldAu1f0qshLE0
         fC1y/dbyF/VXm/+758MQXb4ePaUcH6JmWGnSCNJUbCGqily3uprQoQdBwxFoG0pyANa+
         NNe14DrGden2Fo6OT9/ZyQqYWt66RlegKqoub5dWWYy1WQugr4W4bF3HPkA0YlSezVNw
         8POg==
X-Gm-Message-State: AOAM531SZvImf9UPeI8xdnl3IJ2KE5OF0xav9NGNtXhLLvF+I5x8RO9L
        7LvGEuM3elHiH/Wg2JeCT1mMh93Ndbyl2mgR
X-Google-Smtp-Source: ABdhPJzS95jrCmJJPL9qZcttQW/MCLoAJkxy8LvVfUJ4CnJJWGDo/NkPaM3UGJS8Gz4X2G1C4d7kGw==
X-Received: by 2002:a02:850a:: with SMTP id g10mr4597136jai.134.1630443103316;
        Tue, 31 Aug 2021 13:51:43 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id l18sm1900817ilj.82.2021.08.31.13.51.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Aug 2021 13:51:42 -0700 (PDT)
Date:   Tue, 31 Aug 2021 16:51:42 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, dstolee@microsoft.com, gitster@pobox.com,
        jonathantanmy@google.com
Subject: [PATCH v5 01/27] pack-bitmap.c: harden 'test_bitmap_walk()' to check
 type bitmaps
Message-ID: <7815d9929d7b34f566b9748e03818c37d22a6808.1630443072.git.me@ttaylorr.com>
References: <cover.1617991824.git.me@ttaylorr.com>
 <cover.1630443072.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1630443072.git.me@ttaylorr.com>
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
2.33.0.96.g73915697e6

