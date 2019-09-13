Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 625781F463
	for <e@80x24.org>; Fri, 13 Sep 2019 13:02:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388195AbfIMNCz (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Sep 2019 09:02:55 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:43926 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388176AbfIMNCz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Sep 2019 09:02:55 -0400
Received: by mail-ed1-f65.google.com with SMTP id c19so26921581edy.10
        for <git@vger.kernel.org>; Fri, 13 Sep 2019 06:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nbIYPYfvlZmjFMk31c6i2QEUyWC7Lyz7Rjql2VovRmI=;
        b=SfgsLQNOYhaf9jgQ8sXtJE4w18WxWiwJuvf9NlbVahyBXcFAK8dAab0plOXEn2RT+4
         HvWHyt1wm8ZmdmD9jCi4CUAZoPWPNk5pu3mfnkAwQiZMaOEL6f0bFkNgEdLbeKTtLsWI
         zRwA/dmDfPWhqt3dHflnpDXWMAeuQBv63qPv95I0pCHQ7H9K04XidS/8ykxJ0LSdzZfs
         kV+BxvJ9O3PxQXXnn0teeoa97VLC4hlWRylPlQHBiTu+xCLZEsor4yV0JASNFw66TjQq
         BLeaY6/BAcgxZDbzGGbV75yJKAJD6K7HPK2IotoXh4KacqkP4/m4ti2hFzwRz8pfdMX9
         ZoAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nbIYPYfvlZmjFMk31c6i2QEUyWC7Lyz7Rjql2VovRmI=;
        b=q5myxXErhCqgOiz91iR7/O30Sn+PRRemL4FQ7Vca4JlnY7nUvl1ka1l1LeIOpTP/l3
         JbZpznytiGgbEuFn3keMclI10FhNKrDtpUeLom7dYn12fXOJUrgXcvJ2UhyvUGHQ/BqY
         pK13zUJiP9qpQoikohh25JI7tMWc4Qs2l6nk2OW2NS2nqUn7JPWcROa2aaLCXDqi1w5n
         yw0F+MOnwhjGSrAq9vtV+JSFg1fX8/wUy6obQWRBN98zYhrx4wrYqMpADUT61o+umhUu
         j1hPw6XzSOoFhvfOonY4OPxjFVpGijv8grV2RZMfCD9Xpj2tBXxlXLmiyruckLBz1krs
         feYQ==
X-Gm-Message-State: APjAAAVF011VpzCo+CAWfozeO9uoJj2J/JRaSkA5PJB6RIHY27fgGZi2
        gJIaJZr7PWXSrG6PtpD+nslRjLMZ
X-Google-Smtp-Source: APXvYqxZiErAo4ui1dXbzWNTXD4Z0xeD5GDR6R+aDLo6zLJLDBPeckf+yuI92NOVi/ldTakIaTQIlQ==
X-Received: by 2002:a17:906:79ca:: with SMTP id m10mr3712986ejo.292.1568379773221;
        Fri, 13 Sep 2019 06:02:53 -0700 (PDT)
Received: from ubuntu-N150ZU.booking.pcln.com (access-114.38.rev.fr.colt.net. [213.41.38.114])
        by smtp.gmail.com with ESMTPSA id c14sm2846570ejx.31.2019.09.13.06.02.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2019 06:02:52 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [RFC PATCH 06/10] pack-bitmap: introduce bitmap_walk_contains()
Date:   Fri, 13 Sep 2019 15:02:22 +0200
Message-Id: <20190913130226.7449-7-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.23.0.46.gd213b4aca1.dirty
In-Reply-To: <20190913130226.7449-1-chriscool@tuxfamily.org>
References: <20190913130226.7449-1-chriscool@tuxfamily.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff King <peff@peff.net>

We will use this helper function in a following patch to
tell us if an object is packed.

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 pack-bitmap.c | 12 ++++++++++++
 pack-bitmap.h |  3 +++
 2 files changed, 15 insertions(+)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index b2422fed8f..1833971dc7 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -828,6 +828,18 @@ int reuse_partial_packfile_from_bitmap(struct bitmap_index *bitmap_git,
 	return 0;
 }
 
+int bitmap_walk_contains(struct bitmap_index *bitmap_git,
+			 struct bitmap *bitmap, const struct object_id *oid)
+{
+	int idx;
+
+	if (!bitmap)
+		return 0;
+
+	idx = bitmap_position(bitmap_git, oid);
+	return idx >= 0 && bitmap_get(bitmap, idx);
+}
+
 void traverse_bitmap_commit_list(struct bitmap_index *bitmap_git,
 				 show_reachable_fn show_reachable)
 {
diff --git a/pack-bitmap.h b/pack-bitmap.h
index 00de3ec8e4..5425767f0f 100644
--- a/pack-bitmap.h
+++ b/pack-bitmap.h
@@ -3,6 +3,7 @@
 
 #include "ewah/ewok.h"
 #include "khash.h"
+#include "pack.h"
 #include "pack-objects.h"
 
 struct commit;
@@ -53,6 +54,8 @@ int reuse_partial_packfile_from_bitmap(struct bitmap_index *,
 int rebuild_existing_bitmaps(struct bitmap_index *, struct packing_data *mapping,
 			     kh_oid_map_t *reused_bitmaps, int show_progress);
 void free_bitmap_index(struct bitmap_index *);
+int bitmap_walk_contains(struct bitmap_index *,
+			 struct bitmap *bitmap, const struct object_id *oid);
 
 /*
  * After a traversal has been performed by prepare_bitmap_walk(), this can be
-- 
2.23.0.46.gd213b4aca1.dirty

