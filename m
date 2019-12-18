Return-Path: <SRS0=Z/Vr=2I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F510C2D0C3
	for <git@archiver.kernel.org>; Wed, 18 Dec 2019 11:26:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6104A21582
	for <git@archiver.kernel.org>; Wed, 18 Dec 2019 11:26:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DhX8kR6j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbfLRL0O (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Dec 2019 06:26:14 -0500
Received: from mail-wm1-f41.google.com ([209.85.128.41]:35293 "EHLO
        mail-wm1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726141AbfLRL0N (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Dec 2019 06:26:13 -0500
Received: by mail-wm1-f41.google.com with SMTP id p17so1491187wmb.0
        for <git@vger.kernel.org>; Wed, 18 Dec 2019 03:26:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cBvBDYGTTds24xnjho/x6hcXxB6lw9adCvPuXB2U0XU=;
        b=DhX8kR6jyPN7bl10W7Hir9GQzpCFGit3ppFCgnbDR0gOdWIVCSr4BVnCWEgyl82KSb
         JUlRzuTq78guvd9yFVMhysQtISBBcyWyTcL4uCw4dvnhWLBzqEeRp00QluN22rz0ct3+
         VYM6VC/QTdlmOXNeAxCMF3ueMjjp5M9fNL2+kVsqDRmFVyg+5R68dRUOulkH2xl9J030
         F+t2HyKq4hl34spjvPkPHTd5dLiCWH8/xte1qY3s3RlsY/5pyi6awsWoq7zdYhTMnQAI
         X+ARdBSiqm3U201A98hnM2joZ6/8xJBI741w6ZtIeyWSvOcY43aGgLBHrxgi8Stxlamw
         59hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cBvBDYGTTds24xnjho/x6hcXxB6lw9adCvPuXB2U0XU=;
        b=NWwNgDQcE5SsMzg4Wwh/qvf49F4J8zb6kwBkGHyqUydQVlF67/3AuHDMK6ElgyLRlE
         pZXOVGlq5Vg6po06xjfBEERAXvE7r/j56A5yiCYY9CHq/m0JpPWkWzXbkbZRy6+zHffp
         304F1uNJdj3chzks6SGWpNXpTH+YkLykpDgp1ZUhclAtk6/t9oQmKuHl1EWfAm2AFoLx
         p/f5XQaJfLZGh1l50C7C6HNutFZ35S7is+0BU2psusOj+wb4b0P1bepIYHcePbf/VTAH
         sXV2MtP2h+0Vn+YA+iSeyXzu4B0ocGgrxM7sFJ2YJ6W2mUmAI+2crQTk7W/ikdGNAyQ8
         ijyw==
X-Gm-Message-State: APjAAAUzqPaiuntiWoYcqwJv58gf6anxD//Zx4Bj8E/MRjwGkrCoIc2r
        5+w8p9/4QTKj6F1mXiZqRo3JuTTs
X-Google-Smtp-Source: APXvYqyoREQmM/KcZPdKTwNhabqSzZOAx+58FpFZVpWY+MUdO+bX2oi92JRROoIKosKtVmnek0Q9XA==
X-Received: by 2002:a1c:9d8b:: with SMTP id g133mr2575470wme.27.1576668370765;
        Wed, 18 Dec 2019 03:26:10 -0800 (PST)
Received: from localhost.localdomain ([2a04:cec0:116b:f417:15eb:66f2:c98d:a463])
        by smtp.gmail.com with ESMTPSA id f127sm1204647wma.4.2019.12.18.03.26.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2019 03:26:10 -0800 (PST)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: [PATCH v4 04/12] pack-bitmap: introduce bitmap_walk_contains()
Date:   Wed, 18 Dec 2019 12:25:39 +0100
Message-Id: <20191218112547.4974-5-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.24.1.498.g561400140f
In-Reply-To: <20191218112547.4974-1-chriscool@tuxfamily.org>
References: <20191218112547.4974-1-chriscool@tuxfamily.org>
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
index e07c798879..fb4f6297f2 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -830,6 +830,18 @@ int reuse_partial_packfile_from_bitmap(struct bitmap_index *bitmap_git,
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
2.24.1.498.g561400140f

