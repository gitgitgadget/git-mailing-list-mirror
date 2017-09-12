Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EECD51FADE
	for <e@80x24.org>; Tue, 12 Sep 2017 17:28:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751501AbdILR2o (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Sep 2017 13:28:44 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:33323 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751405AbdILR2n (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Sep 2017 13:28:43 -0400
Received: by mail-pg0-f67.google.com with SMTP id i130so4477259pgc.0
        for <git@vger.kernel.org>; Tue, 12 Sep 2017 10:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OLcPZuuxvCUS9lECAHlM0WhEKykXT3HGKu0aQKjhttE=;
        b=KLr+LKxbecWOhzGS94fyezu4SAZ16pzycKy788yQGCq2DQ1Lu2AXZNQ+izntXzj/r5
         zcfKAgATeSHgF+s9njp3VErMhi+4vioSYoUTxrFVvBhQGuN0JXHaoPlBSecBuJvdov0d
         6j44IXc/YyJnuIV3Dg3lmmEh9ZWO3lm5qbhIOi4TmU2+83WGSVkf5KNRUBAFkbxNNlgr
         e+P8bVSoWRRV0v4xZQ/Id+znGNP9CxmJ7NFqIVDLgQipXt0DZbpVi3hR/teYBQAJEJrL
         3L3PsiqzSi2rnCoqY0Eg2AK03y9RBr5ESDw+ybZBK1Gac142wGpC6rLyC5s7at7Wd+5r
         gvdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OLcPZuuxvCUS9lECAHlM0WhEKykXT3HGKu0aQKjhttE=;
        b=s+LJncx5ra1xPrKvzb3SqFAAuE0/82Y5IebcigZ41gIv+xy9O9bIObof4L4TcUlkgA
         j9LM907/CeWb5z4dKk+hsmrBPCOP3BU6FutZ2Pi+kVfbGJNpZTm05XB2d15s9tIzwkEH
         hJ9B8mOLCerIXR5pWs8kICsW0KczSVCRJTrFPklN4kiWFDFfCdZPMzyjxE32NnGeThxy
         f7CJ7rGAv91e3Z2fFWpVLhM6soroj715cmt+RlI3R4jQMzYd3W4NDK0d7Hz7xGRNcyGn
         fmG+vThVVbgOIY7+yP3kLmCeJII8cLIhvkuaT9I9l7uAoCw5pYtWxcSxjsge2PlnErqv
         ewaA==
X-Gm-Message-State: AHPjjUir9w+SsFeG2J2Jn92lxhvgeMoyT8/u5v6E2uRwodffopJi/yLK
        hu46+oMcgqWXSqwtEJA=
X-Google-Smtp-Source: ADKCNb5ufRGbgbncqpKtzMVOc4/8CqrxjQQ9o8T2bJnRgM5EJbbZJGdNH34No7kye6cyS+gGgSFS/w==
X-Received: by 10.84.232.199 with SMTP id x7mr18218108plm.191.1505237322266;
        Tue, 12 Sep 2017 10:28:42 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:9def:8161:22df:85ca])
        by smtp.gmail.com with ESMTPSA id x13sm11711744pgt.16.2017.09.12.10.28.41
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 12 Sep 2017 10:28:41 -0700 (PDT)
Date:   Tue, 12 Sep 2017 10:28:39 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/4] pack: make packed_git_mru global a value instead of a
 pointer
Message-ID: <20170912172839.GB144745@aiede.mtv.corp.google.com>
References: <20170912172330.GA144745@aiede.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170912172330.GA144745@aiede.mtv.corp.google.com>
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
Acked-by: Jeff King <peff@peff.net>
---
Unchanged from
https://public-inbox.org/git/20170830064827.GB153983@aiede.mtv.corp.google.com/.

I agree with the comments there that it would be nice to make this use
list.h (#leftoverbits) and would be happy to read a patch doing that.
Once we're done adapting the object store to work with arbitrary
repositories we may come back to this, but I'd be happier if it's just
already taken care of for us.

 builtin/pack-objects.c |  4 ++--
 cache.h                |  4 ++--
 packfile.c             | 12 +++++-------
 3 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index a57b4f058d..f721137eaf 100644
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
2.14.1.690.gbb1197296e

