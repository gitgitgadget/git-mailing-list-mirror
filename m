Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED230C433E6
	for <git@archiver.kernel.org>; Thu, 31 Dec 2020 11:57:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B044322473
	for <git@archiver.kernel.org>; Thu, 31 Dec 2020 11:57:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726520AbgLaL51 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 31 Dec 2020 06:57:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726071AbgLaL50 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Dec 2020 06:57:26 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C41DC061799
        for <git@vger.kernel.org>; Thu, 31 Dec 2020 03:56:45 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id h205so43612933lfd.5
        for <git@vger.kernel.org>; Thu, 31 Dec 2020 03:56:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2aGz4dIQ4moGrCSgvd3CKn2aam6rHNUkjzCDwMuPOWY=;
        b=UhX/s3qZgRDGK2mhKio8H7IA+qvaZSvzecpXM2yRJKEAN+W4X8zu7XOnsnLQqkrY3A
         xN1scrPtlfb339RuXst+gyBhtRuf2sbZE0YJRSl1Ab9ZniSa4pkWWUtbwtuO4csxXvmw
         PVJxmNr7nx0le0Ks43fGZyUEUXf426/SdzZ087o/9o2497j8br/y1oqPujHJaW/eR1vh
         JrHJWzfE9Vaj0vvD6H42Y+LrrFK2RNKSQAPG255ze2neT1y/yldADQ9viwGHeUh4PtGG
         sovRDUTkcaoYnFJ0Ps5FmWxHFsArP6Kgxk5lt6IYfU+v+dHdzuajlKMn5GA4UGVd3Tye
         gIXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2aGz4dIQ4moGrCSgvd3CKn2aam6rHNUkjzCDwMuPOWY=;
        b=HG22fASwXOjHSxOtMTEX7BbIx10l5zZrLoO6DXz4wfDd5fWSogIIFipBuJyTfZsPvV
         T4NVB4Va8JyRk8A6xzXmfuFtXojQFXtiFkPkez0xx6+QregQqFXCk18sTPQx4+q82GSh
         WVeI9O7BplhBfxLT42mfO2GEIv988+NhSk8FFBuZ9k2dAu7YCTb/qK9rSwj9aiYnCUgg
         jSj4DoT/cg9sRdyXnVkTVXemHvZDAUbkHZ/rEwu8HOk85Sutvi321qtV6WsNrVweDLEa
         VcrWkrbWcbL6k7j4rCxj7g/uiO51laSGfczRqsWozCaNAaq/2IXqkIu6PgChb8U4YQna
         ZYIA==
X-Gm-Message-State: AOAM533Rh3Pjwvze4E2p+aZkoJ4X9NKN86vqusOJpXMbdJFlBkFBf57S
        /ke7b7fXuQTD1xFNNiIWC3zZcn+Mzf4=
X-Google-Smtp-Source: ABdhPJzyxPlTQz0I5+n72aS+5jX7is0+TjRRgloGG5T10LQzTR0vBGnbHQkkJXon8FiFbdIKpD83+A==
X-Received: by 2002:a05:6512:22cd:: with SMTP id g13mr16064482lfu.368.1609415803696;
        Thu, 31 Dec 2020 03:56:43 -0800 (PST)
Received: from localhost.localdomain (host-189-203-5.junet.se. [207.189.203.5])
        by smtp.gmail.com with ESMTPSA id m11sm7505329ljp.12.2020.12.31.03.56.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Dec 2020 03:56:43 -0800 (PST)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     "brian m . carlson" <sandals@crustytoothpaste.net>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v2 2/4] object-file.c: rename from sha1-file.c
Date:   Thu, 31 Dec 2020 12:56:21 +0100
Message-Id: <7ab29b868f3980d1bf20fe21db5213b43e06c00b.1609415114.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <cover.1609415114.git.martin.agren@gmail.com>
References: <cover.1609282997.git.martin.agren@gmail.com> <cover.1609415114.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Drop the last remnant of "sha1" in this file and rename it to reflect
that we're not just able to handle SHA-1 these days.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 t/oid-info/README            | 2 +-
 builtin/index-pack.c         | 2 +-
 sha1-file.c => object-file.c | 8 ++++----
 Makefile                     | 2 +-
 4 files changed, 7 insertions(+), 7 deletions(-)
 rename sha1-file.c => object-file.c (99%)

diff --git a/t/oid-info/README b/t/oid-info/README
index 27f843fc00..ca56a74b1e 100644
--- a/t/oid-info/README
+++ b/t/oid-info/README
@@ -5,7 +5,7 @@ starting with `#` are ignored.  The key and value are separated by whitespace
 (specifically, those whitespace in the default `$IFS`).  The key consists only
 of shell identifier characters, and the value consists of a hash algorithm,
 colon, and value.  The hash algorithm also consists only of shell identifier
-characters; it should match the value in sha1-file.c.
+characters; it should match the value in object-file.c.
 
 For example, the following lines map the key "rawsz" to "20" if SHA-1 is in use
 and to "32" if SHA-256 is in use:
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 4b8d86e0ad..557bd2f348 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -1641,7 +1641,7 @@ static void read_idx_option(struct pack_idx_option *opts, const char *pack_name)
 	/*
 	 * Get rid of the idx file as we do not need it anymore.
 	 * NEEDSWORK: extract this bit from free_pack_by_name() in
-	 * sha1-file.c, perhaps?  It shouldn't matter very much as we
+	 * object-file.c, perhaps?  It shouldn't matter very much as we
 	 * know we haven't installed this pack (hence we never have
 	 * read anything from it).
 	 */
diff --git a/sha1-file.c b/object-file.c
similarity index 99%
rename from sha1-file.c
rename to object-file.c
index c3c49d2fa5..3508598d97 100644
--- a/sha1-file.c
+++ b/object-file.c
@@ -3,7 +3,7 @@
  *
  * Copyright (C) Linus Torvalds, 2005
  *
- * This handles basic git sha1 object files - packing, unpacking,
+ * This handles basic git object files - packing, unpacking,
  * creation etc.
  */
 #include "cache.h"
@@ -508,9 +508,9 @@ static int alt_odb_usable(struct raw_object_store *o,
  * LF separated.  Its base points at a statically allocated buffer that
  * contains "/the/directory/corresponding/to/.git/objects/...", while
  * its name points just after the slash at the end of ".git/objects/"
- * in the example above, and has enough space to hold 40-byte hex
- * SHA1, an extra slash for the first level indirection, and the
- * terminating NUL.
+ * in the example above, and has enough space to hold all hex characters
+ * of the object ID, an extra slash for the first level indirection, and
+ * the terminating NUL.
  */
 static void read_info_alternates(struct repository *r,
 				 const char *relative_base,
diff --git a/Makefile b/Makefile
index 8bb1163f70..224a1c6940 100644
--- a/Makefile
+++ b/Makefile
@@ -937,6 +937,7 @@ LIB_OBJS += notes-cache.o
 LIB_OBJS += notes-merge.o
 LIB_OBJS += notes-utils.o
 LIB_OBJS += notes.o
+LIB_OBJS += object-file.o
 LIB_OBJS += object-name.o
 LIB_OBJS += object.o
 LIB_OBJS += oid-array.o
@@ -994,7 +995,6 @@ LIB_OBJS += sequencer.o
 LIB_OBJS += serve.o
 LIB_OBJS += server-info.o
 LIB_OBJS += setup.o
-LIB_OBJS += sha1-file.o
 LIB_OBJS += sha1-lookup.o
 LIB_OBJS += shallow.o
 LIB_OBJS += sideband.o
-- 
2.30.0

