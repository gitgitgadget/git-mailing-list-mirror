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
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAA24C433B4
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 08:07:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C545611B0
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 08:07:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232051AbhDIIHz (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Apr 2021 04:07:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232005AbhDIIHx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Apr 2021 04:07:53 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C63F6C061760
        for <git@vger.kernel.org>; Fri,  9 Apr 2021 01:07:40 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id y124-20020a1c32820000b029010c93864955so4203847wmy.5
        for <git@vger.kernel.org>; Fri, 09 Apr 2021 01:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IccIA9PPX0A29TQyVOZgn/4F98G0734JFevU19zjFjM=;
        b=YJpiXpTJ7Gkiy6II/NDdbq8H/fdYGKUsCz0CsZGhqDwhUk7yVVXXk+f6Bl483vYyaN
         XF/0XTnPJLaTINWwKAfEO02kMNFeVjGwyE9kdmyiAJLnMM1Sdj9WURfuC/s9Zj4/W4ZP
         3GQEUEdnULhOKL5a6ECYoruNMARpeWPcWKm3+L4csBIXI620KE5eVj/jPwrYbJjfhdo6
         /9G0aH2qSbHnHh0E7382HFTq5qFap++vPI2QXfA2ryP3Fs8fyjciNtF83T9FmsHLUjrj
         rJDE0TSzljbXVijpSvs8lS5ttA2e6vJBkKagu+b59h0aypae3lND96dx9Q218e/beIuM
         74BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IccIA9PPX0A29TQyVOZgn/4F98G0734JFevU19zjFjM=;
        b=dvf7nHtqG9G+82jIsk9823fBiHQcEVkX8L4Wpk3DQXa3TVvanWbootp06aTGrt6KJQ
         B6Df/KIaPCNL67CZwukHozIWCpjvTEPp7JJzCh48iZaxnCBsirZpkq422xLx1BjI+fZj
         WcMib4RYMppiCj91ZkKJCPii9hmrw1RuuKzOVGytghL1XSKE7mPXQTn4+n8l/iM/d5Gh
         kTCtsMhZ37BM1DO9T91odaTiZonbA5eBsTMJVAi8gLLs1uzgNX7r7sR21Ref8Y2CUDsX
         ToSOoaYfCYCQ0XjaeaHb51T9tYlo/KoXkmanX8C1ABzN9oZItWVLb//gNDkuCu8ELKJA
         ko/g==
X-Gm-Message-State: AOAM530U4/zEHN049Bh4QT4CM9FR5pTMTaEX8SAT22hcTpF0A32KdzwC
        SQ644UGbq3bvffq5NEkXQ9/KfKF0I9nmTg==
X-Google-Smtp-Source: ABdhPJy6cI+Ad0rxY/r140gKLm1+uckOgkw0tHe1UZHrXNJG3SGn7Qv0F/EE9Y02E+m/z0QONRC1Kw==
X-Received: by 2002:a1c:2b05:: with SMTP id r5mr11841273wmr.107.1617955659288;
        Fri, 09 Apr 2021 01:07:39 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id b15sm3105988wrx.73.2021.04.09.01.07.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 01:07:38 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 1/2] blob.c: remove buffer & size arguments to parse_blob_buffer()
Date:   Fri,  9 Apr 2021 10:07:27 +0200
Message-Id: <patch-1.3-68a7709fe5-20210409T080534Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.584.gf4baedee75
In-Reply-To: <cover-0.3-0000000000-20210409T080534Z-avarab@gmail.com>
References: <cover-00.11-00000000000-20210328T021238Z-avarab@gmail.com> <cover-0.3-0000000000-20210409T080534Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As noted in the comment introduced in 837d395a5c0 (Replace
parse_blob() with an explanatory comment, 2010-01-18) the old
parse_blob() function and the current parse_blob_buffer() exist merely
to provide consistency in the API.

We're not going to parse blobs like we "parse" commits, trees or
tags. So let's not have the parse_blob_buffer() take arguments that
pretends that we do. Its only use is to set the "parsed" flag.

See bd2c39f58f9 ([PATCH] don't load and decompress objects twice with
parse_object(), 2005-05-06) for the introduction of parse_blob_buffer().

I'm moving the prototype of parse_blob_buffer() below the comment
added in 837d395a5c0 while I'm at it. That comment was originally
meant to be a replacement for the missing parse_blob() function, but
it's much less confusing to have it be above the parse_blob_buffer()
function it refers to.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 blob.c   | 2 +-
 blob.h   | 3 +--
 object.c | 4 ++--
 3 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/blob.c b/blob.c
index 182718aba9..389a7546dc 100644
--- a/blob.c
+++ b/blob.c
@@ -13,7 +13,7 @@ struct blob *lookup_blob(struct repository *r, const struct object_id *oid)
 	return object_as_type(obj, OBJ_BLOB, 0);
 }
 
-int parse_blob_buffer(struct blob *item, void *buffer, unsigned long size)
+int parse_blob_buffer(struct blob *item)
 {
 	item->object.parsed = 1;
 	return 0;
diff --git a/blob.h b/blob.h
index 1664872055..ac1d4804a5 100644
--- a/blob.h
+++ b/blob.h
@@ -11,8 +11,6 @@ struct blob {
 
 struct blob *lookup_blob(struct repository *r, const struct object_id *oid);
 
-int parse_blob_buffer(struct blob *item, void *buffer, unsigned long size);
-
 /**
  * Blobs do not contain references to other objects and do not have
  * structured data that needs parsing. However, code may use the
@@ -21,5 +19,6 @@ int parse_blob_buffer(struct blob *item, void *buffer, unsigned long size);
  * parse_blob_buffer() is used (by object.c) to flag that the object
  * has been read successfully from the database.
  **/
+int parse_blob_buffer(struct blob *item);
 
 #endif /* BLOB_H */
diff --git a/object.c b/object.c
index 78343781ae..63896abf01 100644
--- a/object.c
+++ b/object.c
@@ -195,7 +195,7 @@ struct object *parse_object_buffer(struct repository *r, const struct object_id
 	if (type == OBJ_BLOB) {
 		struct blob *blob = lookup_blob(r, oid);
 		if (blob) {
-			if (parse_blob_buffer(blob, buffer, size))
+			if (parse_blob_buffer(blob))
 				return NULL;
 			obj = &blob->object;
 		}
@@ -266,7 +266,7 @@ struct object *parse_object(struct repository *r, const struct object_id *oid)
 			error(_("hash mismatch %s"), oid_to_hex(oid));
 			return NULL;
 		}
-		parse_blob_buffer(lookup_blob(r, oid), NULL, 0);
+		parse_blob_buffer(lookup_blob(r, oid));
 		return lookup_object(r, oid);
 	}
 
-- 
2.31.1.584.gf4baedee75

