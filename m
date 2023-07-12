Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4954EB64DD
	for <git@archiver.kernel.org>; Wed, 12 Jul 2023 23:38:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233002AbjGLXiI (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Jul 2023 19:38:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233391AbjGLXh5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jul 2023 19:37:57 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B858211C
        for <git@vger.kernel.org>; Wed, 12 Jul 2023 16:37:54 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-579efc32377so81928137b3.1
        for <git@vger.kernel.org>; Wed, 12 Jul 2023 16:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1689205073; x=1691797073;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4YUlZoHQI+N0Wp5Inpg3wT76vKxb7CvRII98frxzjeE=;
        b=U5/hGMRplLiv4cWlSDbWqoQ4vrarUZmtXootDrQJVl9iAMwpOdxGLt293qwDnW9bAR
         Vo46ozeYIeJ4cC0WuviOrU/uy5qPREscXuk0hITGcbiR7wtATQomVfTl3iSJEjBCKj2t
         q6g3vJW4XnpDeiWwrnfvoJFjLShqt559yYdednrb+gwEaNMp/u8v2lnwYSB2prN4E0Z7
         dBxeCunSooLOKFwvJvXDB1sugz8E0xu0K7Eukk8Lrn5+iGZCE4Ts9+s2xEXhmttGiZHn
         YP+lZ1eV1O0cwHe/1/j0uksu/fhDC9yWKcTPQxARiZxc29/62b80De4/ia75HZi+jF2O
         KUXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689205073; x=1691797073;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4YUlZoHQI+N0Wp5Inpg3wT76vKxb7CvRII98frxzjeE=;
        b=b1sYj7aKqYSodtZK8t4/g3S2Nuy+t2/R1HzfSdDFcWP5guK31hQALoQMCQ6lpxcFty
         pKRz8Kk0TeFSzX/y3izS9E9tbs2eUbsmF4D3EX2Sdy8fS5d05oT4vvm73NGBK0i/5IcA
         NssonA3oI5dMfKjZjkRJwj2NEYyusRPmbd0hpzksOU2ML+u919V8U7Of0uIiRfX9oGP5
         A9H62P4eiVZsGMlMAAbpeQ5rKSP1THXoAUl8EJX6VL3qaRmjiglToKUDvOkvDYWpRIYv
         xBM1bm7kNRMLq88jfRI5lREUaJisO1AqCi9W1GtWYsZOEsIGNp99gJ0zUjqr7nKwMntw
         LAIg==
X-Gm-Message-State: ABy/qLYnSyHN1W/OL2IsMXJiKYl3zr4ZGdUBbHarth1ZIFxaNLbxJuKp
        UeqeGXbUzm1hqbzTyOn9YHa54/Hxq7etWGFAN0FPoA==
X-Google-Smtp-Source: APBJJlFvBXczxwLN2hPGo5W8DqOHjJ7cbJMcMTc/eL2gYLiBCYakFljjxtTe6GLo1nvzFokHzD84Zg==
X-Received: by 2002:a81:8645:0:b0:576:8fcd:270f with SMTP id w66-20020a818645000000b005768fcd270fmr128168ywf.19.1689205073283;
        Wed, 12 Jul 2023 16:37:53 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id n7-20020a819c47000000b00568b941e5e3sm1445057ywa.72.2023.07.12.16.37.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 16:37:53 -0700 (PDT)
Date:   Wed, 12 Jul 2023 19:37:52 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Victoria Dye <vdye@github.com>
Subject: [PATCH 10/20] pack-bitmap.c: ensure that eindex lookups don't
 overflow
Message-ID: <822cb19da4e7dac5b1d4d4c7e115d7e4bcb7c976.1689205042.git.me@ttaylorr.com>
References: <cover.1689205042.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1689205042.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When a bitmap is used to answer some reachability query, it creates a
pseudo-bitmap called the "extended index" on top of any existing bitmaps
to store objects that are relevant to the query, but not mentioned in
the bitmap.

When looking up the ith object in the extended index in a bitmap, it is
common to write something like:

    bitmap_get(result, i + bitmap_num_objects(bitmap_git))

, indicating that we want the ith object following all other objects
mentioned in the bitmap_git.

Since the type of `i` and the return type of `bitmap_num_objects()` are
both `uint32_t`s,  But if there are either a large number of objects in
the bitmap, or a large number of objects in the extended index (or
both), this addition can overflow when the sum is greater than 2^32-1.

Having that large of a bitmap position is entirely acceptable, but we
need to ensure that the computed bitmap position for that object is
performed using 64-bits and doesn't overflow.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 pack-bitmap.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index 7367f62bb6..7ddb465c20 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -1294,7 +1294,7 @@ static void show_extended_objects(struct bitmap_index *bitmap_git,
 	for (i = 0; i < eindex->count; ++i) {
 		struct object *obj;
 
-		if (!bitmap_get(objects, bitmap_num_objects(bitmap_git) + i))
+		if (!bitmap_get(objects, st_add(bitmap_num_objects(bitmap_git), i)))
 			continue;
 
 		obj = eindex->objects[i];
@@ -1473,7 +1473,7 @@ static void filter_bitmap_exclude_type(struct bitmap_index *bitmap_git,
 	 * them individually.
 	 */
 	for (i = 0; i < eindex->count; i++) {
-		uint32_t pos = i + bitmap_num_objects(bitmap_git);
+		size_t pos = st_add(i, bitmap_num_objects(bitmap_git));
 		if (eindex->objects[i]->type == type &&
 		    bitmap_get(to_filter, pos) &&
 		    !bitmap_get(tips, pos))
@@ -1564,7 +1564,7 @@ static void filter_bitmap_blob_limit(struct bitmap_index *bitmap_git,
 	}
 
 	for (i = 0; i < eindex->count; i++) {
-		uint32_t pos = i + bitmap_num_objects(bitmap_git);
+		size_t pos = st_add(i, bitmap_num_objects(bitmap_git));
 		if (eindex->objects[i]->type == OBJ_BLOB &&
 		    bitmap_get(to_filter, pos) &&
 		    !bitmap_get(tips, pos) &&
@@ -2038,7 +2038,8 @@ static uint32_t count_object_type(struct bitmap_index *bitmap_git,
 
 	for (i = 0; i < eindex->count; ++i) {
 		if (eindex->objects[i]->type == type &&
-			bitmap_get(objects, bitmap_num_objects(bitmap_git) + i))
+		    bitmap_get(objects,
+			       st_add(bitmap_num_objects(bitmap_git), i)))
 			count++;
 	}
 
@@ -2452,7 +2453,8 @@ static off_t get_disk_usage_for_extended(struct bitmap_index *bitmap_git)
 	for (i = 0; i < eindex->count; i++) {
 		struct object *obj = eindex->objects[i];
 
-		if (!bitmap_get(result, bitmap_num_objects(bitmap_git) + i))
+		if (!bitmap_get(result,
+				st_add(bitmap_num_objects(bitmap_git), i)))
 			continue;
 
 		if (oid_object_info_extended(the_repository, &obj->oid, &oi, 0) < 0)
-- 
2.41.0.347.g7b976b8871f

