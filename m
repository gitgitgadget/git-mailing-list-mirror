Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD3ADC433ED
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 12:50:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7712B613C5
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 12:50:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232216AbhDTMv3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Apr 2021 08:51:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232094AbhDTMvY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Apr 2021 08:51:24 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA585C06138D
        for <git@vger.kernel.org>; Tue, 20 Apr 2021 05:50:51 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id l4so58048261ejc.10
        for <git@vger.kernel.org>; Tue, 20 Apr 2021 05:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zv8AWtA0FiYIE7S7p8kKbM8TYiLmZzrsPo0xgHIsrpg=;
        b=boTIhDGtqkxqs3hdbt2pP53lIhhnTu/iK3gh7SjLzWZ2Shd26htXvMbG6xjb4/FOXU
         8X2uD8C9jYCr9aPz1e+f1+F/p8RgHB38tREaBLyX+u6lFguHGCrVucp+IW/tONWxJfqV
         wZt7oawM923hrzEiE1Idu8sywAT6HBUOGWE5+RwcTPQ9WRQLA/CSWz5t9AZgLIQ6ARm7
         0z+f05ul2l+UcxSg9aAK3E5Kb6E8rx5W7HWWgn8JjDAUlwu/6s8XMjIkbKqaMhpWK+5v
         G2RkkNKfOEjg+apXz7N5k40oRreQVLSewBU9XCYcGmwScDhKGEq95wdFSskNM5cOCh1t
         Db9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zv8AWtA0FiYIE7S7p8kKbM8TYiLmZzrsPo0xgHIsrpg=;
        b=syk/0+who44aOY8sy20aJVm5i3LMfDP4qDNGPAsnP4bR/TEgRn5cHqp+Ry/tZZj3f4
         CY4IWRbqIWHxw0z8j5vIvj86ED6QTJ2/eseor4KILIhd1absDg+aGkRgOtNQxcMvTY1Y
         sAjI83SRWHGgm7PhIZmurz9bYTkJyO1savexhK8w29rHSZkZy8dA9tlJ7jXjQDZaSkVn
         1q25D7I1dQmdkLrUD4pEvWcmmtzyDVj54lZi1lGHbfMm1TofioxfmUeiIhgdEPpifLks
         Bfpw3E2S5aWIENaQFNVliQn5YYKzrVpcBQnBErPKdHvYkHvfIV2PrSbHuQOhL3J8ZPkc
         n9nQ==
X-Gm-Message-State: AOAM532vDczWsj9ONtjfkVBCNRP081e7ttGn5GW6HAhPmQMlgP9mm4ty
        FTW9+mMt/SC8NLOc5m7m481QKn9uL69XQw==
X-Google-Smtp-Source: ABdhPJz2VqVUNO0+Jd2HSmwH/ZUKZnLTSjdqBV/wGVxFlqmHW6cbn4a1n438VY4p7NiFg3nu0rROmg==
X-Received: by 2002:a17:906:29ca:: with SMTP id y10mr28182559eje.250.1618923050235;
        Tue, 20 Apr 2021 05:50:50 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id f3sm12630900eje.45.2021.04.20.05.50.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Apr 2021 05:50:49 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 06/10] blob.c: remove parse_blob_buffer()
Date:   Tue, 20 Apr 2021 14:50:39 +0200
Message-Id: <patch-06.10-02c8d2a9ba-20210420T124428Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.723.ga5d7868e4a
In-Reply-To: <cover-00.10-0000000000-20210420T124428Z-avarab@gmail.com>
References: <cover-0.3-0000000000-20210409T080534Z-avarab@gmail.com> <cover-00.10-0000000000-20210420T124428Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As noted in the comment introduced in 837d395a5c0 (Replace
parse_blob() with an explanatory comment, 2010-01-18) the old
parse_blob() function and the parse_blob_buffer() existed to provide
consistency in the API.

See bd2c39f58f9 ([PATCH] don't load and decompress objects twice with
parse_object(), 2005-05-06) for the introduction of
parse_blob_buffer().

We're not going to parse blobs like we "parse" commits, trees or
tags. So we should not have the parse_blob_buffer() take arguments
that pretends that we do. Its only use is to set the "parsed" flag.

So let's entirely remove the function, and use our newly created
create_blob() for the allocation. We can then set the "parsed" flag
directly in parse_object_buffer() and parse_object() instead.

At this point I could move the comment added in 837d395a5c0 to one or
both of those object.c function, but let's just delete it instead. I
think it's obvious from the flow of the code what's going on
here. Setting the parsed flag no longer happens at a distance, so why
we're doing it isn't unclear anymore.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 blob.c   |  8 +-------
 blob.h   | 12 +-----------
 object.c | 11 +++++++----
 3 files changed, 9 insertions(+), 22 deletions(-)

diff --git a/blob.c b/blob.c
index d98b6badc7..1308299eab 100644
--- a/blob.c
+++ b/blob.c
@@ -5,7 +5,7 @@
 
 const char *blob_type = "blob";
 
-static struct blob *create_blob(struct repository *r, const struct object_id *oid)
+struct blob *create_blob(struct repository *r, const struct object_id *oid)
 {
 	return create_object(r, oid, alloc_blob_node(r));
 }
@@ -17,9 +17,3 @@ struct blob *lookup_blob(struct repository *r, const struct object_id *oid)
 		return create_blob(r, oid);
 	return object_as_type(obj, OBJ_BLOB, 0);
 }
-
-int parse_blob_buffer(struct blob *item, void *buffer, unsigned long size)
-{
-	item->object.parsed = 1;
-	return 0;
-}
diff --git a/blob.h b/blob.h
index 1664872055..6e6b23a769 100644
--- a/blob.h
+++ b/blob.h
@@ -9,17 +9,7 @@ struct blob {
 	struct object object;
 };
 
+struct blob *create_blob(struct repository *r, const struct object_id *oid);
 struct blob *lookup_blob(struct repository *r, const struct object_id *oid);
 
-int parse_blob_buffer(struct blob *item, void *buffer, unsigned long size);
-
-/**
- * Blobs do not contain references to other objects and do not have
- * structured data that needs parsing. However, code may use the
- * "parsed" bit in the struct object for a blob to determine whether
- * its content has been found to actually be available, so
- * parse_blob_buffer() is used (by object.c) to flag that the object
- * has been read successfully from the database.
- **/
-
 #endif /* BLOB_H */
diff --git a/object.c b/object.c
index 78343781ae..f4e419e5c3 100644
--- a/object.c
+++ b/object.c
@@ -195,8 +195,7 @@ struct object *parse_object_buffer(struct repository *r, const struct object_id
 	if (type == OBJ_BLOB) {
 		struct blob *blob = lookup_blob(r, oid);
 		if (blob) {
-			if (parse_blob_buffer(blob, buffer, size))
-				return NULL;
+			blob->object.parsed = 1;
 			obj = &blob->object;
 		}
 	} else if (type == OBJ_TREE) {
@@ -262,12 +261,16 @@ struct object *parse_object(struct repository *r, const struct object_id *oid)
 	if ((obj && obj->type == OBJ_BLOB && repo_has_object_file(r, oid)) ||
 	    (!obj && repo_has_object_file(r, oid) &&
 	     oid_object_info(r, oid, NULL) == OBJ_BLOB)) {
+		if (!obj) {
+			struct blob *blob = create_blob(r, oid);
+			obj = &blob->object;
+		}
 		if (check_object_signature(r, repl, NULL, 0, NULL) < 0) {
 			error(_("hash mismatch %s"), oid_to_hex(oid));
 			return NULL;
 		}
-		parse_blob_buffer(lookup_blob(r, oid), NULL, 0);
-		return lookup_object(r, oid);
+		obj->parsed = 1;
+		return obj;
 	}
 
 	buffer = repo_read_object_file(r, oid, &type, &size);
-- 
2.31.1.723.ga5d7868e4a

