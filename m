Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9AA741F4B5
	for <e@80x24.org>; Fri, 15 Nov 2019 14:16:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727528AbfKOOQH (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Nov 2019 09:16:07 -0500
Received: from mail-wm1-f50.google.com ([209.85.128.50]:38548 "EHLO
        mail-wm1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727420AbfKOOQG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Nov 2019 09:16:06 -0500
Received: by mail-wm1-f50.google.com with SMTP id z19so10594816wmk.3
        for <git@vger.kernel.org>; Fri, 15 Nov 2019 06:16:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Or9CZRa468VpWlF4CBSYitgmMNVyelgxDsvskSvosXQ=;
        b=ouGxWSvVBnI74siKjSzS5VCxO0EgZ4lTjxGQ9TFgml8j/ZfwqpDmlqWxx0EHeBC+O2
         TaVrSS1aPQRHjq6amacJ9BWTxZy1HSGRjN2/DndUgWb/Hf7X5PdEoQmRrJ45yGc470Qy
         vf1OM1W8Ttns6QU3KM35l/pu3TswnNMoZYxaOPLsaNGae6P92oh3bKyT1CP32ecnViMq
         Hz4NWuDv4PwofjWicluxTIuJZqdy5xCLqV1ysuuMdrc+Xt2r9IwvlWOYio+fmEsz9Ohr
         rUMHd7qmYM8ka/U+002hRveIaTf0BEKTp4comJZKnqLsi+ASo6DJTnWIHGUWpuqK4sRA
         07bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Or9CZRa468VpWlF4CBSYitgmMNVyelgxDsvskSvosXQ=;
        b=FD+cKo9Kr9yk0hMDVjYEuDY4FddlkNwL0MhAhZykTZn/vDnf7jIMlIYZ8w3rjQo4jh
         9ZpzlluZwX6YWiPpHqItEJr+7TBTHPWOQq/j+obw5Zwdyu/0+b8vF75p9x8CGdFJ4rDa
         xPDPmDdGUD/H7NG0+ey4QB1qZdH40Bpi9wKLG9Ynqe/ZaplULFoBZnsc5UoVXyTaInnS
         6hDehJV56kGcs+v5Nz5zISiBw7CT7rqACrig0YT4s5BjnnvrCEEN61jIW4DZWh2vtk6O
         rs2T+1m34HRgRPMOEEGCzWyzU6VSAEOpBEwhDwjo3kApOWIHE0U0mFXGu6r3+cjLOudR
         5sHw==
X-Gm-Message-State: APjAAAV++bBHHK2NqDmI8231y/Fcu5dMF+7zjPX9AmvAPKft5CsKTqsV
        gSykr8cVh3dM7KGHUPAVIQgd4tnR
X-Google-Smtp-Source: APXvYqzw3HD5sD/zkioKt/v49+Kf9zaJBt2tvFYF8VEuxNccngTHqsApbUtk476bPGpnxzwYDZ5rRw==
X-Received: by 2002:a1c:39c1:: with SMTP id g184mr14825536wma.75.1573827364642;
        Fri, 15 Nov 2019 06:16:04 -0800 (PST)
Received: from localhost.localdomain ([2a04:cec0:1050:ac52:b4cd:f6a2:ba59:f1d4])
        by smtp.gmail.com with ESMTPSA id a2sm7907874wrt.79.2019.11.15.06.16.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2019 06:16:04 -0800 (PST)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: [PATCH v3 5/9] pack-bitmap: introduce bitmap_walk_contains()
Date:   Fri, 15 Nov 2019 15:15:37 +0100
Message-Id: <20191115141541.11149-6-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.24.0-rc1
In-Reply-To: <20191115141541.11149-1-chriscool@tuxfamily.org>
References: <20191115141541.11149-1-chriscool@tuxfamily.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff King <peff@peff.net>

We will use this helper function in a following commit to
tell us if an object is packed.

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 pack-bitmap.c | 12 ++++++++++++
 pack-bitmap.h |  3 +++
 2 files changed, 15 insertions(+)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index 016d0319fc..8a51302a1a 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -826,6 +826,18 @@ int reuse_partial_packfile_from_bitmap(struct bitmap_index *bitmap_git,
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
index 466c5afa09..6ab6033dbe 100644
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
2.24.0-rc1

