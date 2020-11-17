Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C6C8C63697
	for <git@archiver.kernel.org>; Tue, 17 Nov 2020 21:48:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2A16241A7
	for <git@archiver.kernel.org>; Tue, 17 Nov 2020 21:48:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="x5mOGwug"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728574AbgKQVsZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Nov 2020 16:48:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728385AbgKQVsY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Nov 2020 16:48:24 -0500
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 219BAC0613CF
        for <git@vger.kernel.org>; Tue, 17 Nov 2020 13:48:23 -0800 (PST)
Received: by mail-qv1-xf41.google.com with SMTP id e14so4438126qve.3
        for <git@vger.kernel.org>; Tue, 17 Nov 2020 13:48:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=IhkxgLth/z+cgMyj/QWQzcwniJPc/I0VOjeQDzXCE7Q=;
        b=x5mOGwugUhnpEM9xLOtOEyfUhSn/s+ZxMpM8TwqJJzpF4tgKxcEBZoUJGnezjS3MEg
         vVnwu9zqr/vSwOi2ce/7K7K/J8KsNofZz/fj6QfWQKaKvV+opc7FfKd5k20uFE9VTIZG
         Us9qvckD4jeqAK7fcYbzhyFGc7Ienwi+5e4bkGqsl1F9U8ZnoJrFovOgsnAspqSyOwnH
         aI/MKpfYEGBUpHqr2YB5ZUopTrcWoEG0M4emQnRDh5ptVn0bi4yIIR7fbWZ+anfs9mR2
         Ow3j47vjqlMD7SI//yludgnplpcM8ztKrwbDKrNVg17hylHZh2J8kMj2KXt7SOKrSOOB
         uQtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IhkxgLth/z+cgMyj/QWQzcwniJPc/I0VOjeQDzXCE7Q=;
        b=fuKSKtpek8vQYr60rRIZ1gn4m72b5DRXwa7Zt/rMQjPZVRpXmXlYN//VvYHMvyM6C/
         MN1AWL+0E24b/8cpmiNcQKy/SlCqahAx5ZtIE5lMqDxmMWbJnmpiyWtDKMcZqBzsLnlm
         RYSEdPRPA5n4+6LbMHWTRAnF0sgygf6JC6hZcv5vmp6cwEKVfWAD+AwDu10d26Rni6lm
         FTBAskRW+754z4WlpM7hg0mrFv/5eO5bGSS7Qw0XBkUeYU9XyYL2wADjodjyswd9NFZw
         Falc0awMo07kFilquOViIL9qBiRo2c0D6V03CvCfPqOFBwvz9PO7JftkDwLPhfUf//Po
         sDvw==
X-Gm-Message-State: AOAM530ETjqbJ2uadB268W4lJqmRAOIXtJ982lCdeoJP58p3SNLo8D+l
        qM3zlxB1JICO5oM+4OdROP8bj+re5/g1FwKw
X-Google-Smtp-Source: ABdhPJzZ3YtQhZ9d6DDe5WWjB7Mo+++JDbyDpWPNZ4YvPsrJ0mOFKCgp0syM8edZ87rD3cm7gSBO/A==
X-Received: by 2002:a0c:b34a:: with SMTP id a10mr1790753qvf.15.1605649702015;
        Tue, 17 Nov 2020 13:48:22 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:7fe5:c4d6:f587:dc1f])
        by smtp.gmail.com with ESMTPSA id 72sm15579116qkn.44.2020.11.17.13.48.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2020 13:48:21 -0800 (PST)
Date:   Tue, 17 Nov 2020 16:48:19 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     dstolee@microsoft.com, gitster@pobox.com, peff@peff.net,
        martin.agren@gmail.com, szeder.dev@gmail.com
Subject: [PATCH v2 21/24] pack-bitmap: factor out 'add_commit_to_bitmap()'
Message-ID: <f40a39a48a834443f76015821c0e56021b58fc9a.1605649533.git.me@ttaylorr.com>
References: <cover.1605123652.git.me@ttaylorr.com>
 <cover.1605649533.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1605649533.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

'find_objects()' currently needs to interact with the bitmaps khash
pretty closely. To make 'find_objects()' read a little more
straightforwardly, remove some of the khash-level details into a new
function that describes what it does: 'add_commit_to_bitmap()'.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 pack-bitmap.c | 36 +++++++++++++++++++++---------------
 1 file changed, 21 insertions(+), 15 deletions(-)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index 5efb8af121..d88745fb02 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -521,6 +521,23 @@ static int should_include(struct commit *commit, void *_data)
 	return 1;
 }
 
+static int add_commit_to_bitmap(struct bitmap_index *bitmap_git,
+				struct bitmap **base,
+				struct commit *commit)
+{
+	struct ewah_bitmap *or_with = bitmap_for_commit(bitmap_git, commit);
+
+	if (!or_with)
+		return 0;
+
+	if (*base == NULL)
+		*base = ewah_to_bitmap(or_with);
+	else
+		bitmap_or_ewah(*base, or_with);
+
+	return 1;
+}
+
 static struct bitmap *find_objects(struct bitmap_index *bitmap_git,
 				   struct rev_info *revs,
 				   struct object_list *roots,
@@ -544,21 +561,10 @@ static struct bitmap *find_objects(struct bitmap_index *bitmap_git,
 		struct object *object = roots->item;
 		roots = roots->next;
 
-		if (object->type == OBJ_COMMIT) {
-			khiter_t pos = kh_get_oid_map(bitmap_git->bitmaps, object->oid);
-
-			if (pos < kh_end(bitmap_git->bitmaps)) {
-				struct stored_bitmap *st = kh_value(bitmap_git->bitmaps, pos);
-				struct ewah_bitmap *or_with = lookup_stored_bitmap(st);
-
-				if (base == NULL)
-					base = ewah_to_bitmap(or_with);
-				else
-					bitmap_or_ewah(base, or_with);
-
-				object->flags |= SEEN;
-				continue;
-			}
+		if (object->type == OBJ_COMMIT &&
+		    add_commit_to_bitmap(bitmap_git, &base, (struct commit *)object)) {
+			object->flags |= SEEN;
+			continue;
 		}
 
 		object_list_insert(object, &not_mapped);
-- 
2.29.2.312.gabc4d358d8

