Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF471C4338F
	for <git@archiver.kernel.org>; Tue, 27 Jul 2021 21:21:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8BE286023F
	for <git@archiver.kernel.org>; Tue, 27 Jul 2021 21:21:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233434AbhG0VVO (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Jul 2021 17:21:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231944AbhG0VVC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Jul 2021 17:21:02 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47D1FC0617BE
        for <git@vger.kernel.org>; Tue, 27 Jul 2021 14:19:26 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id h18so652479ilc.5
        for <git@vger.kernel.org>; Tue, 27 Jul 2021 14:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kzw/gj6+Sf/QM0vb/peslJKM94uO/PIoS8MG1YMyGlE=;
        b=qWvUOg9K7NxE3g9P3nu25jmj4fXUUWVk3OQ8dHc2nKtkpX9Hw9ifWAt6p4+2G4iowD
         wlPYQX4XI9mOKjhkGRJ2BT7ESzHfTZJV6+x9JBhmSRCs8ytXiFZA5M5WIfL7LldlR1qq
         vzZQIqlrZk8dL2oMq/Ur21CvUOq+cAM0Ej1DZKi2eS4Uewhm+tIfwnKdZe40JtRXb1aT
         zKE2b8poRV3bILBc6TMpugeW0LxWg5BDmnK+eOf4uVsxFBujhYM+LVTgBAzVNoSOust4
         5AXTzwe5nQaGyin4fsAJyRsmjThBcG/SBzHE28R4xS7fAchGwaHAeR+jGpmDjh+bvdPI
         grqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kzw/gj6+Sf/QM0vb/peslJKM94uO/PIoS8MG1YMyGlE=;
        b=KKCQjAwF8ecD6e9ODsuMZtNhtSygyUS7uRi0YmggtPr/Hq5uwHD3xN/nHaccaSHLFE
         ewFQS46DN5slrF8lm5ZsHakNZy6Q1BXtfLAJ6lhsadrSdkjbyfQ6IQCY+knTVvMBuflc
         WZaqc7zXXESdlU1hLLe2W3eyTkKeSYaDYF35e21xZ2MnET/VE1XZfx3ZzFxMKwn+3Vpv
         6rl9kgmBTHjYRwxBjkJY9Lwi5QBnquHzWbgQ9HV3zEVBZXv7miwgOLNYg5vBxIpwt93H
         7B7RPnFCSnmAgMa7KQImci39oNKW3OMtAdQaD+4LGlKYtCvu42M3SJbePNxYwxwBC3oJ
         BDJA==
X-Gm-Message-State: AOAM532rNcwew9pX9w9HyXRPVcwLcQVv/YtXA3jSLQvKfvLSFOOJZ6xr
        FQXRuHD4Zr6+iZFe9zULAhdBQBoRroQ/IE6f
X-Google-Smtp-Source: ABdhPJw3RIEQBB0aLFm+sIWAND4o+1Wy92zCjC5q+xfoGM88zdfeoxl6303Eo7tpx4RIJ8MNtEGJmg==
X-Received: by 2002:a92:c266:: with SMTP id h6mr18081835ild.273.1627420765623;
        Tue, 27 Jul 2021 14:19:25 -0700 (PDT)
Received: from localhost ([2600:1700:d843:8f:6813:d625:75e6:4f64])
        by smtp.gmail.com with ESMTPSA id q1sm3262133ioi.42.2021.07.27.14.19.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jul 2021 14:19:25 -0700 (PDT)
Date:   Tue, 27 Jul 2021 17:19:24 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, dstolee@microsoft.com, gitster@pobox.com,
        jonathantanmy@google.com
Subject: [PATCH v3 01/25] pack-bitmap.c: harden 'test_bitmap_walk()' to check
 type bitmaps
Message-ID: <fa4cbed48e558d797cac318a2692e300ff7d32e2.1627420428.git.me@ttaylorr.com>
References: <cover.1617991824.git.me@ttaylorr.com>
 <cover.1627420428.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1627420428.git.me@ttaylorr.com>
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
index bfc10148f5..a73960a55d 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -1319,10 +1319,52 @@ void count_bitmap_commit_list(struct bitmap_index *bitmap_git,
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
@@ -1332,6 +1374,7 @@ static void test_show_object(struct object *object, const char *name,
 	bitmap_pos = bitmap_position(tdata->bitmap_git, &object->oid);
 	if (bitmap_pos < 0)
 		die("Object not in bitmap: %s\n", oid_to_hex(&object->oid));
+	test_bitmap_type(tdata, object, bitmap_pos);
 
 	bitmap_set(tdata->base, bitmap_pos);
 	display_progress(tdata->prg, ++tdata->seen);
@@ -1346,6 +1389,7 @@ static void test_show_commit(struct commit *commit, void *data)
 				     &commit->object.oid);
 	if (bitmap_pos < 0)
 		die("Object not in bitmap: %s\n", oid_to_hex(&commit->object.oid));
+	test_bitmap_type(tdata, &commit->object, bitmap_pos);
 
 	bitmap_set(tdata->base, bitmap_pos);
 	display_progress(tdata->prg, ++tdata->seen);
@@ -1393,6 +1437,10 @@ void test_bitmap_walk(struct rev_info *revs)
 
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

