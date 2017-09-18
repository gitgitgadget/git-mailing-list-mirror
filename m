Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 580192047F
	for <e@80x24.org>; Mon, 18 Sep 2017 17:22:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933072AbdIRRWA (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Sep 2017 13:22:00 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34136 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933073AbdIRRV6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Sep 2017 13:21:58 -0400
Received: by mail-wm0-f68.google.com with SMTP id i131so1559379wma.1
        for <git@vger.kernel.org>; Mon, 18 Sep 2017 10:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=2TqQWhqUbsD8ItUYf/sLmzYwBQlhLUVKbqEVgryGzTw=;
        b=iDHTZzHUgrUftaXqZr917l6CT7GcF5hlfqT3Pi0LHu+1AtKSe6wLb7vFWWjO7jyyjq
         a8av59781y/zATuklhA3rv8+5BdU9wBkGXm2yIZX4Mi+q8wni3Avg91QJTucugjb6e2L
         1pFamoCsaTZBCvw0SwxXRdqV21Zvbp0xd66u3nqRb6sTn0JpUGy/yX5te2/imp0IFDM8
         iGj7igLRdAV2l4OhWTebhTjNVAgwtfznOHPmzFxbhna8c2ofqhC2baCeaS1XCpitVEqw
         JmfBA4ZLLiKUMvf+Bk8IZ2U6we98mPSJPcTDY6I4D9h2EqaAyYz4h4ye16sCME3N72wK
         lIPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=2TqQWhqUbsD8ItUYf/sLmzYwBQlhLUVKbqEVgryGzTw=;
        b=ohBIHqjG86QngirC+WDHro9Mq3dC89ApK3V97hlpCS9Kc7epYORrpOCByI3IQtaQu8
         kZyhL/aszc9rjHEGtv2dm2di5eAO8WjA8ccjWR28/KTTNZfzufhNdE+36hwpav1ArBI5
         kLHhgbhA98L85r0FPSJmO8nVAUCWwvb2M6SRrwiUOCOpOCDa1v+1cfdKksD7DLxXi+JJ
         UVLbejgE5+2NC/XSJBfkDDwBowJk5wjlpwKQsg2Zh2Vp6U7YUQRAs0UQVBrYIQPS2WJF
         ZIrngKA4RnamNQ5DVbBhLrQDcs9d/GOa1ddAnQLyc76/qTKdgG4D0tk4t1vehmT7scda
         l0Mw==
X-Gm-Message-State: AHPjjUisW0L77rUqcCW5tb0tcTXPgV4ohFEXFfWLLSP5GxbxjpklBVh/
        LVdHp4ICCfvU7A==
X-Google-Smtp-Source: AOwi7QCRoLAjBBc9j4Wvn1szKLhVNUfbsnZ/GOJoRqvyPICEq+8cpytKNgsbJXFgusg+icd0M76llw==
X-Received: by 10.28.229.147 with SMTP id c141mr8492630wmh.156.1505755317167;
        Mon, 18 Sep 2017 10:21:57 -0700 (PDT)
Received: from localhost.localdomain ([41.90.228.228])
        by smtp.googlemail.com with ESMTPSA id b125sm7791639wma.29.2017.09.18.10.21.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 18 Sep 2017 10:21:56 -0700 (PDT)
From:   phionah bugosi <bugosip@gmail.com>
To:     peff@peff.net
Cc:     git@vger.kernel.org, phionah bugosi <bugosip@gmail.com>
Subject: [OUTREACHY] pack: make packed_git_mru global a value instead of a pointer
Date:   Mon, 18 Sep 2017 20:21:43 +0300
Message-Id: <1505755303-5583-1-git-send-email-bugosip@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Just to reecho a previous change requested before in one of the mail threads, we currently have
two global variables declared:

struct mru packed_git_mru_storage;
struct mru *packed_git_mru = &packed_git_mru_storage;

We normally use pointers in C to point or refer to the same location or space in memory from multiple places. That
means in situations where we will have the pointer be assigned to in many places in our code. But in this case, we do not
have any other logic refering or assigning to the pointer packed_git_mru. In simple words we actually dont 
need a pointer in this case.

Therefore this patch makes packed_git_mru global a value instead of a pointer and
makes use of list.h


Signed-off-by: phionah bugosi <bugosip@gmail.com>
---
 builtin/pack-objects.c |  5 +++--
 cache.h                |  7 -------
 list.h                 |  6 ++++++
 packfile.c             | 12 ++++++------
 4 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index a57b4f0..189123f 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1,5 +1,6 @@
 #include "builtin.h"
 #include "cache.h"
+#include "list.h"
 #include "config.h"
 #include "attr.h"
 #include "object.h"
@@ -1012,7 +1013,7 @@ static int want_object_in_pack(const unsigned char *sha1,
 			return want;
 	}
 
-	for (entry = packed_git_mru->head; entry; entry = entry->next) {
+	for (entry = packed_git_mru.head; entry; entry = entry->next) {
 		struct packed_git *p = entry->item;
 		off_t offset;
 
@@ -1030,7 +1031,7 @@ static int want_object_in_pack(const unsigned char *sha1,
 			}
 			want = want_found_object(exclude, p);
 			if (!exclude && want > 0)
-				mru_mark(packed_git_mru, entry);
+				mru_mark(&packed_git_mru, entry);
 			if (want != -1)
 				return want;
 		}
diff --git a/cache.h b/cache.h
index a916bc7..c8d7086 100644
--- a/cache.h
+++ b/cache.h
@@ -1585,13 +1585,6 @@ extern struct packed_git {
 	char pack_name[FLEX_ARRAY]; /* more */
 } *packed_git;
 
-/*
- * A most-recently-used ordered version of the packed_git list, which can
- * be iterated instead of packed_git (and marked via mru_mark).
- */
-struct mru;
-extern struct mru *packed_git_mru;
-
 struct pack_entry {
 	off_t offset;
 	unsigned char sha1[20];
diff --git a/list.h b/list.h
index a226a87..525703b 100644
--- a/list.h
+++ b/list.h
@@ -26,6 +26,12 @@
 #define LIST_H	1
 
 /*
+ * A most-recently-used ordered version of the packed_git list, which can
+ * be iterated instead of packed_git (and marked via mru_mark).
+ */
+extern struct mru packed_git_mru
+
+/*
  * The definitions of this file are adopted from those which can be
  * found in the Linux kernel headers to enable people familiar with the
  * latter find their way in these sources as well.
diff --git a/packfile.c b/packfile.c
index f86fa05..61a61aa 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "list.h"
 #include "mru.h"
 #include "pack.h"
 #include "dir.h"
@@ -41,8 +42,7 @@ static size_t peak_pack_mapped;
 static size_t pack_mapped;
 struct packed_git *packed_git;
 
-static struct mru packed_git_mru_storage;
-struct mru *packed_git_mru = &packed_git_mru_storage;
+struct mru packed_git_mru;
 
 #define SZ_FMT PRIuMAX
 static inline uintmax_t sz_fmt(size_t s) { return s; }
@@ -861,9 +861,9 @@ static void prepare_packed_git_mru(void)
 {
 	struct packed_git *p;
 
-	mru_clear(packed_git_mru);
+	mru_clear(&packed_git_mru);
 	for (p = packed_git; p; p = p->next)
-		mru_append(packed_git_mru, p);
+		mru_append(&packed_git_mru, p);
 }
 
 static int prepare_packed_git_run_once = 0;
@@ -1832,9 +1832,9 @@ int find_pack_entry(const unsigned char *sha1, struct pack_entry *e)
 	if (!packed_git)
 		return 0;
 
-	for (p = packed_git_mru->head; p; p = p->next) {
+	for (p = packed_git_mru.head; p; p = p->next) {
 		if (fill_pack_entry(sha1, e, p->item)) {
-			mru_mark(packed_git_mru, p);
+			mru_mark(&packed_git_mru, p);
 			return 1;
 		}
 	}
-- 
2.7.4

