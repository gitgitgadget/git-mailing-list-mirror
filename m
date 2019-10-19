Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 349701F4C0
	for <e@80x24.org>; Sat, 19 Oct 2019 10:36:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726090AbfJSKf7 (ORCPT <rfc822;e@80x24.org>);
        Sat, 19 Oct 2019 06:35:59 -0400
Received: from mail-wm1-f44.google.com ([209.85.128.44]:38403 "EHLO
        mail-wm1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726077AbfJSKf6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Oct 2019 06:35:58 -0400
Received: by mail-wm1-f44.google.com with SMTP id 3so8339218wmi.3
        for <git@vger.kernel.org>; Sat, 19 Oct 2019 03:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gFGwwi+GBO0lN0KYb6ZvLRcrKMzEqi9SVRxjC5jMOfY=;
        b=Z93phz6/E/F6ILBlbJEGpeYaS6JsJC368CLEptjWX518QRJMfSbiPnR+YoHcqD3ceK
         JSz6p0qNmDNiZE/xnO9zS376szHN9KsZSpZ1MhqYPtaiqSVVZrrsB+aAbV/74kd0O3V0
         mTknE2EPha6Y2gCPwUNH6njUAr9PN91zX9nN+W/iGn5OtWwHPmQ+9aa4nC1TkQfQ7COf
         HYMTRpfgKiYSLfMQKBFfAHbDxzy8H2wKlzBZbxKO1cpnSYaWl7w0GsVPH+cEvlHjZjmM
         laeeLyQBmiUrBEhQvOkl4KtdRX7SzjDeBDUPLjve/9cAAIkatBp9WeUjBXeuXdN/H7XC
         NkLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gFGwwi+GBO0lN0KYb6ZvLRcrKMzEqi9SVRxjC5jMOfY=;
        b=QE3DLc3SL0gAS9aiv54Jx/UaWwMVnTWG/jBt765SO32hTZoqRNJv74lCbF69a31MAE
         9usf2R/NnxU/RzDcbsCoFZCm2KZ0YDVzEH5C8tJuE+Fx9HyxGacIiuTpXhvri5TKZfal
         lzg9XVSPiUypPq5VSRc43ht5F7aBaW1NfA5UqpTttMgZxXYN0zpdNN7ocFI9+uXkpHfw
         ZWF2pH7A1H7rftfQATHZEUmxhhqZucx9NhId1y2fpATNKmWjRcHdw9xaWlByawBW0Zox
         vutIbQNGmIeifn17XfJlnlIa/9xusAi3Kwcd7TSBT80wID97Jqpt9bsUoLy5xJToxGv2
         sq+Q==
X-Gm-Message-State: APjAAAWjOy1W3qscBV7eVT/cErHcawqQroD//I4ahby0CAiTROyhl6l1
        r92UcSUpYwCsMqVMxRNunmtSlcXeLb/AFg==
X-Google-Smtp-Source: APXvYqxUNAFJDr2y3xOdVzzT+DeO5hik0HgYmV8Grd9ZmEhDhIhMBvQ8e57zfDg63HVtxKQX1bov9w==
X-Received: by 2002:a1c:2604:: with SMTP id m4mr12053918wmm.112.1571481356218;
        Sat, 19 Oct 2019 03:35:56 -0700 (PDT)
Received: from localhost.localdomain ([80.214.68.206])
        by smtp.gmail.com with ESMTPSA id p68sm6383086wme.0.2019.10.19.03.35.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Oct 2019 03:35:55 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: [PATCH v2 5/9] pack-bitmap: introduce bitmap_walk_contains()
Date:   Sat, 19 Oct 2019 12:35:27 +0200
Message-Id: <20191019103531.23274-6-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.24.0.rc0.9.gef620577e2
In-Reply-To: <20191019103531.23274-1-chriscool@tuxfamily.org>
References: <20191019103531.23274-1-chriscool@tuxfamily.org>
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
2.24.0.rc0.9.gef620577e2

