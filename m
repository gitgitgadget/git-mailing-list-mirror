Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 07E2A208CD
	for <e@80x24.org>; Wed, 30 Aug 2017 06:48:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750862AbdH3Gsb (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Aug 2017 02:48:31 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:36208 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750746AbdH3Gsa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Aug 2017 02:48:30 -0400
Received: by mail-pg0-f65.google.com with SMTP id 83so4453334pgb.3
        for <git@vger.kernel.org>; Tue, 29 Aug 2017 23:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lZ8bSWRrH+4uAaG4EHdhe5pErdk0pnszg9W+FCnDWZM=;
        b=hNOwsKKUXLQ8gmZDhsyHa8Pe1YP87P28NFB8jrrpN7TFB69T+6Fd19Eu12ucPB67vE
         0zH9A1YDT7BjhYBcfNOYpRiZCuBpXj/AQxfGlh5hJHQhBAsgPIsn0ipGV3BIivvRzUFO
         z7QjsPO0TJGwtuPzEYuvT7rkKszgYe1GODkhlTiZkmdI/MwLHqwjXf5I2seeYqRiqiYV
         8Je9sHJFzyuxqydJjbMzsLNbQ7olGADpSim26KXkU0o7byH5UBxbWv9SoTfDFL5jDNrC
         kvGVcKltz6uz/EFTISDEMlv15N71RA0M3nUkQlTXAIKIVaxN7kV0JzoEI+wenDdViU9c
         xhAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lZ8bSWRrH+4uAaG4EHdhe5pErdk0pnszg9W+FCnDWZM=;
        b=dkux8r3rtjaw7o7NcJgZAYtRntrXAiEDlWnqfUfK/C6Ne9ZEQV1ZmElERonXAgLHN5
         E+4z/3eKFLQ9Kcdrr4KVREmt4xm0iYCRUuTWMVHtH9iz9sywVwV7/zAKLYj+ub9q/mf8
         v6eBGe0Ash6QXQHVtm1lqk/35WStRWIwwWmg+E2iDFpVvwEtEb5PrQjfI4Wo84eWCVlx
         2K8xxHxkTlXVYPOkHupqfIMZWXxbYbcisIJoOT0BnY9I/sNaLi1QVonPq8dToXgf8d3h
         7ANvxGxFViW3VDI5rCVfDL9SsIQ0hILchq8fmP8AcgdEucT/t2idcxhb/O6pC+h73ycF
         TBUg==
X-Gm-Message-State: AHYfb5iMyvcbuKprh8O8ktTXi7ba/YtGq2Zi8EShOHOHfs1kJYRGYz04
        u5fCz6X0NdfuwYdd8nU=
X-Received: by 10.99.49.196 with SMTP id x187mr584578pgx.224.1504075709376;
        Tue, 29 Aug 2017 23:48:29 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:402:5042:50b1:56af:6f3d])
        by smtp.gmail.com with ESMTPSA id m6sm7293646pfm.99.2017.08.29.23.48.28
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 29 Aug 2017 23:48:28 -0700 (PDT)
Date:   Tue, 29 Aug 2017 23:48:27 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>
Subject: [PATCH 01/39] pack: make packed_git_mru global a value instead of a
 pointer
Message-ID: <20170830064827.GB153983@aiede.mtv.corp.google.com>
References: <20170830064634.GA153983@aiede.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170830064634.GA153983@aiede.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The MRU cache that keeps track of recently used packs is represented
using two global variables:

	struct mru packed_git_mru_storage;
	struct mru *packed_git_mru = &packed_git_mru_storage;

Callers never assign to the packed_git_mru pointer, though, so we can
simplify by eliminating it and using &packed_git_mru_storage (renamed
to &packed_git_mru) directly.  This variable is only used by the
packfile subsystem, making this a relatively uninvasive change (and
any new unadapted callers would trigger a compile error).

Noticed while moving these globals to the object_store struct.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 builtin/pack-objects.c |  4 ++--
 cache.h                |  4 ++--
 packfile.c             | 12 +++++-------
 3 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 82ad6e0c81..ad53d4fa72 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1012,7 +1012,7 @@ static int want_object_in_pack(const unsigned char *sha1,
 			return want;
 	}
 
-	for (entry = packed_git_mru->head; entry; entry = entry->next) {
+	for (entry = packed_git_mru.head; entry; entry = entry->next) {
 		struct packed_git *p = entry->item;
 		off_t offset;
 
@@ -1030,7 +1030,7 @@ static int want_object_in_pack(const unsigned char *sha1,
 			}
 			want = want_found_object(exclude, p);
 			if (!exclude && want > 0)
-				mru_mark(packed_git_mru, entry);
+				mru_mark(&packed_git_mru, entry);
 			if (want != -1)
 				return want;
 		}
diff --git a/cache.h b/cache.h
index a916bc79e3..49b083ee0a 100644
--- a/cache.h
+++ b/cache.h
@@ -4,6 +4,7 @@
 #include "git-compat-util.h"
 #include "strbuf.h"
 #include "hashmap.h"
+#include "mru.h"
 #include "advice.h"
 #include "gettext.h"
 #include "convert.h"
@@ -1589,8 +1590,7 @@ extern struct packed_git {
  * A most-recently-used ordered version of the packed_git list, which can
  * be iterated instead of packed_git (and marked via mru_mark).
  */
-struct mru;
-extern struct mru *packed_git_mru;
+extern struct mru packed_git_mru;
 
 struct pack_entry {
 	off_t offset;
diff --git a/packfile.c b/packfile.c
index f86fa051c9..f69a5c8d60 100644
--- a/packfile.c
+++ b/packfile.c
@@ -40,9 +40,7 @@ static unsigned int pack_max_fds;
 static size_t peak_pack_mapped;
 static size_t pack_mapped;
 struct packed_git *packed_git;
-
-static struct mru packed_git_mru_storage;
-struct mru *packed_git_mru = &packed_git_mru_storage;
+struct mru packed_git_mru;
 
 #define SZ_FMT PRIuMAX
 static inline uintmax_t sz_fmt(size_t s) { return s; }
@@ -861,9 +859,9 @@ static void prepare_packed_git_mru(void)
 {
 	struct packed_git *p;
 
-	mru_clear(packed_git_mru);
+	mru_clear(&packed_git_mru);
 	for (p = packed_git; p; p = p->next)
-		mru_append(packed_git_mru, p);
+		mru_append(&packed_git_mru, p);
 }
 
 static int prepare_packed_git_run_once = 0;
@@ -1832,9 +1830,9 @@ int find_pack_entry(const unsigned char *sha1, struct pack_entry *e)
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
2.14.1.581.gf28d330327

