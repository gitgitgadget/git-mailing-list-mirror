Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A82CA20437
	for <e@80x24.org>; Tue, 24 Oct 2017 18:59:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752055AbdJXS7c (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Oct 2017 14:59:32 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:54218 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751591AbdJXS73 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Oct 2017 14:59:29 -0400
Received: by mail-it0-f67.google.com with SMTP id n195so11279468itg.2
        for <git@vger.kernel.org>; Tue, 24 Oct 2017 11:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RicbU2FMJhwm6kaSsw/IyAJAKD2PWjWYii9Y6gHsAtk=;
        b=PDsP/UOJzFT6b7HYjK6v3mJx7xYu52kqdbko/JAi0qjM7HMft8E0aYa+2TxmXT8wvO
         Ofqx9Ud0tYIt0HnWalUbvY8pF4GLhwTEXnsD2Q7cFArd8rs34jf9j8Tbtwt8UfnIh3wK
         ZgsuHWB4dflvL8lB97FW3mwfxPtgBnBXRkSeZAqxvxP2QEi5TsKramRwNp96oJK5BgIM
         U2tWQPsLxzUuCreMrtnz3K0jYMYx9Ep7gbJQemrK3PX265wkD//MzCuXE/qtdpzxDT7H
         3IkwxITlF4iiKM7aqRdd2g5PT7wNLN8qrmrLxiwH66UO2/hNT66NyXRHHM51+Inje5By
         53Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=RicbU2FMJhwm6kaSsw/IyAJAKD2PWjWYii9Y6gHsAtk=;
        b=fKsd1BVfs2n/Q0aQy6BBnLTZUoA5qC1jA1D+spc4CbKG0Reuu1cndpH5uKhvIDM3Bj
         n4WquYq4w76Z7+WoHKQ57U8zDbQe1zAX17CGM1DJ33jn1pwd+9iq2sVCFHqi1j+oljJ7
         QHDu36fadWCCnDeDd3cVPN1STb6ADXUPPYFWzg3/XXS1Gcx+MN4O+D1qYVkMFwSf+Cbs
         9cIi2v1jd+E+KxZThWPgn4mt0jwY3Cdu7DgvfNIq6xazZWnoe5BhoOcc5lwvYvnJ402D
         /a8f0d+BT5Gfv5jsNdajaPPLwBDkEXiDUZiiQnP4Edz0STsN1Yg5f24tbtxClpZwSHG2
         JiAQ==
X-Gm-Message-State: AMCzsaXj92/bktqZNHbLeQMbt1+48VJe+6Wm2IfE0Bg9pRWBZLuyPBmm
        zCHntQ2OheewKtrp9gQUKMUDvMebKRU=
X-Google-Smtp-Source: ABhQp+SIOByhvGmcX80q6K4aorL9KZnI64DQCeXZlghhqCAaANZqvwtr5WiALZ4QeGwntl5mWIGQ7g==
X-Received: by 10.36.185.21 with SMTP id w21mr64022ite.35.1508871567804;
        Tue, 24 Oct 2017 11:59:27 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:24db:446:6fc5:b25b])
        by smtp.gmail.com with ESMTPSA id e34sm382760ioj.83.2017.10.24.11.59.26
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 24 Oct 2017 11:59:26 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Subject: [PATCH 3/4] xdiff: use stronger hash function internally
Date:   Tue, 24 Oct 2017 11:59:16 -0700
Message-Id: <20171024185917.20515-4-sbeller@google.com>
X-Mailer: git-send-email 2.15.0.rc2.6.g953226eb5f
In-Reply-To: <20171024185917.20515-1-sbeller@google.com>
References: <20171024185917.20515-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Instead of using the hash seeded with 5381, and updated via
`(hash << 5) ^ new_byte`, use the FNV-1 primitives as offered by
hashmap.h, which is seeded with 0x811c9dc5 and computed as
`(hash * 0x01000193) ^ new_byte`.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 xdiff/xutils.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/xdiff/xutils.c b/xdiff/xutils.c
index 04d7b32e4e..a58a28c687 100644
--- a/xdiff/xutils.c
+++ b/xdiff/xutils.c
@@ -24,7 +24,8 @@
 #include <assert.h>
 #include "xinclude.h"
 
-
+#include "cache.h"
+#include "hashmap.h"
 
 
 long xdl_bogosqrt(long n) {
@@ -228,7 +229,7 @@ int xdl_recmatch(const char *l1, long s1, const char *l2, long s2, long flags)
 
 static unsigned long xdl_hash_record_with_whitespace(char const **data,
 		char const *top, long flags) {
-	unsigned long ha = 5381;
+	unsigned long ha = memhash(NULL, 0);
 	char const *ptr = *data;
 
 	for (; ptr < top && *ptr != '\n'; ptr++) {
@@ -243,21 +244,18 @@ static unsigned long xdl_hash_record_with_whitespace(char const **data,
 				; /* already handled */
 			else if (flags & XDF_IGNORE_WHITESPACE_CHANGE
 				 && !at_eol) {
-				ha += (ha << 5);
-				ha ^= (unsigned long) ' ';
+				ha = memhash_feed(ha, (unsigned char) ' ');
 			}
 			else if (flags & XDF_IGNORE_WHITESPACE_AT_EOL
 				 && !at_eol) {
 				while (ptr2 != ptr + 1) {
-					ha += (ha << 5);
-					ha ^= (unsigned long) *ptr2;
+					ha = memhash_feed(ha, (unsigned char) *ptr2);
 					ptr2++;
 				}
 			}
 			continue;
 		}
-		ha += (ha << 5);
-		ha ^= (unsigned long) *ptr;
+		ha = memhash_feed(ha, (unsigned char) *ptr);
 	}
 	*data = ptr < top ? ptr + 1: ptr;
 
@@ -265,15 +263,14 @@ static unsigned long xdl_hash_record_with_whitespace(char const **data,
 }
 
 unsigned long xdl_hash_record(char const **data, char const *top, long flags) {
-	unsigned long ha = 5381;
+	unsigned long ha = memhash(NULL, 0);
 	char const *ptr = *data;
 
 	if (flags & XDF_WHITESPACE_FLAGS)
 		return xdl_hash_record_with_whitespace(data, top, flags);
 
 	for (; ptr < top && *ptr != '\n'; ptr++) {
-		ha += (ha << 5);
-		ha ^= (unsigned long) *ptr;
+		ha = memhash_feed(ha, (unsigned char) *ptr);
 	}
 	*data = ptr < top ? ptr + 1: ptr;
 
-- 
2.15.0.rc2.6.g953226eb5f

