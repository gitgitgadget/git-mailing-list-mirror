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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31E12C433E6
	for <git@archiver.kernel.org>; Tue, 29 Dec 2020 23:55:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB9C7221F8
	for <git@archiver.kernel.org>; Tue, 29 Dec 2020 23:55:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726261AbgL2XzR (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Dec 2020 18:55:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726156AbgL2XzR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Dec 2020 18:55:17 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5DBBC06179C
        for <git@vger.kernel.org>; Tue, 29 Dec 2020 15:54:36 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id h205so34238802lfd.5
        for <git@vger.kernel.org>; Tue, 29 Dec 2020 15:54:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GhrHVEP3I1HBKsvGXuslcLcaHIRYwoJY/ioTGvJc3MU=;
        b=vW1RuxAAHuOFZljikDxfELg1+uh4B3BFduOxm2CLrPxZjMh24w537JEYOwhme75c7z
         y8iSdWTW/fM5sdd1NoYkmdaZCiYSGPMU04UThe1ChS72RR0xXIijmioYO0snITbEV64s
         WrGu0LYy5iQeVhm/wUraAg8AY1FNr2Sxlo23R++hKU0GEWOtql6zobuQhdFTdnrRL9f6
         n1yyWBoIF22H8ZJF6RTJbhr7SxnbTF9ZkTFaP9w2NSa8/iwQuB17jwisOkgr4GUSWdIy
         naz/zjSmMg99zaH+t0TSt/AbqVlBhtDBHfqf9AVnZb9UCA9RDmvL/qmfMsOcv1qpiKCE
         F2Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GhrHVEP3I1HBKsvGXuslcLcaHIRYwoJY/ioTGvJc3MU=;
        b=jB28pfcoGr9pbSMIYAfhkrCOBx5UDR2gNQX1ct4IysNM6lXiqRiCPl02Rm3MO+oUSO
         5QCKGDVKF5fyeJLxzQMo8c8YbKySI7sHEgL62Q8JgxqdrLPPjN5l3GOxa4c4bZIHduj/
         FQ2OmyXFnyQI0aAKtqQD7En263WHUQIlXDxP0rF6BIKmKRjcQl8bpQgvMea5YK8PEXLx
         cCIbzsBRqrp+G4km2pp7JPiy/svnW4wTHZLyZmeIHGMIYPtvg6LWr6osQPSBuMStQXdx
         f0OVrXG4vGZWBaEMgxgxjY6S/zNZTFnGqHKqA31ZVqWpO1//9MZfqeWWZhfD4jH2thBe
         bEjg==
X-Gm-Message-State: AOAM533Ul1HmpfuCWkNPZB2vH3B0ovYok9UCOGoCGiolq0NT2/QJtBfl
        bG8SUk4aR4gGY2hv4aNL3Ck2GfEQQlw=
X-Google-Smtp-Source: ABdhPJzybLMM+/bYpz+8du0IqwWEjKSkpOFed2RLWvjmZHcj1d/qMWS47PziUN3fgZYjjL8RV3KcZA==
X-Received: by 2002:a05:6512:242:: with SMTP id b2mr22950401lfo.460.1609286075154;
        Tue, 29 Dec 2020 15:54:35 -0800 (PST)
Received: from localhost.localdomain (78-66-223-148-no2204.tbcn.telia.com. [78.66.223.148])
        by smtp.gmail.com with ESMTPSA id q25sm5777240lfd.282.2020.12.29.15.54.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Dec 2020 15:54:34 -0800 (PST)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH 2/4] object-file.c: rename from sha1-file.c
Date:   Wed, 30 Dec 2020 00:52:58 +0100
Message-Id: <4243886d8a3df2922fd56fed2a25b2911ec7128c.1609282997.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <cover.1609282997.git.martin.agren@gmail.com>
References: <cover.1609282997.git.martin.agren@gmail.com>
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
 sha1-file.c => object-file.c | 2 +-
 Makefile                     | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)
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
index c3c49d2fa5..b0c47b02bd 100644
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

