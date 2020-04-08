Return-Path: <SRS0=ek70=5Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21238C2BA16
	for <git@archiver.kernel.org>; Wed,  8 Apr 2020 04:08:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAF5F2074F
	for <git@archiver.kernel.org>; Wed,  8 Apr 2020 04:08:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Iq6VfYBj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726541AbgDHEIS (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Apr 2020 00:08:18 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38695 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725763AbgDHEIR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Apr 2020 00:08:17 -0400
Received: by mail-pf1-f193.google.com with SMTP id c21so1818412pfo.5
        for <git@vger.kernel.org>; Tue, 07 Apr 2020 21:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=QZT4Noa5DTPp9iPxpvUv3fbrlx444/sXNi69p4aBgQA=;
        b=Iq6VfYBjKEPnOVPZzsNi7NBmdYyc2+C9DMWUZMaxFeRzLSoFpnRCF1824LpqliImne
         IIFroSOrKEty0tt7ZyB2IUJCdgc8XCjO0Vyd5Hdm9VV10Yffsc7KYKIK2u2hjtR5QLp1
         hGPbakv7K5jz+AlQktSEZqpRqPbucNIpCRIt4Lo0+5crhGNlik5LmF/F+cMbY3lhREji
         JMHNiKVT4NQSPI3L3BtveqHs0dH9FTmvIq+G88PjAuMl7VPdPor7a0bvG8MHHL78vqS7
         0IrVvKg7Wc1ne0deNJW9fAEuVLS1pIyxy3RyPKe+zi4k3OHwZHIHbg7Vq5e1fu0FwZJb
         T5uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QZT4Noa5DTPp9iPxpvUv3fbrlx444/sXNi69p4aBgQA=;
        b=tL8788r1rkgl5BGlrnRJKFojx/WxFaLCNhgODcEWvWc7N9vKVvyTNcVNHCnDvtP6uw
         BX0S8JuppOtkyzmwk23Jc4u1DvybTDL7DZ1opEgULoppqd4q8MBeOHFfsFdbT1UzpR1o
         pyFfdkJVg07Vi60zjhdaVveATQbI81VQHiDGEtDkNaWV5vYAtEEVjTe7Hq50bPpDWtzv
         eI0e4d0JjKcXFKSJgkE3tlYKkN990e40VQeN0Czyxl1zpoe70WRWwRqfv3De9zqJSYod
         Ts4QBtQhJaHs0fZjCdXZ2moMiZD4HVo7QFT+mBPmxhyPcgF8urkdySMgJ53w4oQOcwww
         UHQw==
X-Gm-Message-State: AGi0PuZ85f91W4A+/3cDlPgjKjpO4aS6s71fkyJAKIzDXconHfkKB5we
        QXPeU89SYqKLBV2gB53hjXRiETflF9c=
X-Google-Smtp-Source: APiQypLJVCgSUGdU529hWMVLefoR26Vw9/uGil2LALOsmgA/nJz+E6BkgAoIIoo7zmVbdoFU+Mmn6A==
X-Received: by 2002:a63:ba1d:: with SMTP id k29mr5143155pgf.413.1586318896496;
        Tue, 07 Apr 2020 21:08:16 -0700 (PDT)
Received: from localhost.localdomain ([2409:4064:2182:8a2e:a277:ba54:a2ce:8862])
        by smtp.gmail.com with ESMTPSA id t23sm2997571pjq.27.2020.04.07.21.08.14
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2020 21:08:15 -0700 (PDT)
From:   Abhishek Kumar <abhishekkumar8222@gmail.com>
To:     git@vger.kernel.org
Subject: [PATCH 2/2] oidmap: rework iterators to return typed pointer
Date:   Wed,  8 Apr 2020 09:36:59 +0530
Message-Id: <20200408040659.14511-2-abhishekkumar8222@gmail.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200408040659.14511-1-abhishekkumar8222@gmail.com>
References: <20200408040659.14511-1-abhishekkumar8222@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

87571c3 modified hashmap_iter_next to return a hashmap_entry pointer
instead of void pointer.

However, oidmap_iter_next is unaware of the struct type containing
oidmap_entry and explicilty returns a void pointer.

Rework oidmap_iter_* to include struct type and return appropriate
pointer. This allows for compile-time type checks.

Signed-off-by: Abhishek Kumar <abhishekkumar8222@gmail.com>
---
 oidmap.h               | 27 +++++++++++++++------------
 t/helper/test-oidmap.c |  2 +-
 2 files changed, 16 insertions(+), 13 deletions(-)

diff --git a/oidmap.h b/oidmap.h
index c66a83ab1d..5d6b34a7ce 100644
--- a/oidmap.h
+++ b/oidmap.h
@@ -76,18 +76,21 @@ static inline void oidmap_iter_init(struct oidmap *map, struct oidmap_iter *iter
 	hashmap_iter_init(&map->map, &iter->h_iter);
 }
 
-static inline void *oidmap_iter_next(struct oidmap_iter *iter)
-{
-	/* TODO: this API could be reworked to do compile-time type checks */
-	return (void *)hashmap_iter_next(&iter->h_iter);
-}
+/*
+ * Returns the next entry, or NULL if there are no more entries.
+ *
+ * The entry is of @type (e.g. "struct foo") and has a member of type struct
+ * oidmap_entry.
+ */
+#define oidmap_iter_next(iter, type) \
+	(type *) hashmap_iter_next(&(iter)->h_iter)
 
-static inline void *oidmap_iter_first(struct oidmap *map,
-				      struct oidmap_iter *iter)
-{
-	oidmap_iter_init(map, iter);
-	/* TODO: this API could be reworked to do compile-time type checks */
-	return (void *)oidmap_iter_next(iter);
-}
+/*
+ * Returns the first entry in @map using @iter, where the entry is of @type
+ * (e.g. "struct foo") and has a member of type struct oidmap_entry.
+ */
+#define oidmap_iter_first(map, iter, type) \
+	({oidmap_iter_init(map, iter); \
+	 oidmap_iter_next(iter, type); })
 
 #endif
diff --git a/t/helper/test-oidmap.c b/t/helper/test-oidmap.c
index 0acf99931e..a28bf007a8 100644
--- a/t/helper/test-oidmap.c
+++ b/t/helper/test-oidmap.c
@@ -96,7 +96,7 @@ int cmd__oidmap(int argc, const char **argv)
 
 			struct oidmap_iter iter;
 			oidmap_iter_init(&map, &iter);
-			while ((entry = oidmap_iter_next(&iter)))
+			while ((entry = oidmap_iter_next(&iter, struct test_entry)))
 				printf("%s %s\n", oid_to_hex(&entry->entry.oid), entry->name);
 
 		} else {
-- 
2.26.0

