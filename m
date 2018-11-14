Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-12.3 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4948D1F87F
	for <e@80x24.org>; Wed, 14 Nov 2018 00:13:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728797AbeKNKOW (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Nov 2018 05:14:22 -0500
Received: from mail-qk1-f202.google.com ([209.85.222.202]:55925 "EHLO
        mail-qk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726408AbeKNKOW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Nov 2018 05:14:22 -0500
Received: by mail-qk1-f202.google.com with SMTP id 98so34124901qkp.22
        for <git@vger.kernel.org>; Tue, 13 Nov 2018 16:13:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Ibc7hEFsjuir2b98MoZhtmpr7yqFPPDd1zPnA+ln3sg=;
        b=eeyCAr2Yepu3mCV7OIUgruNooJ3zUdvFdCnESMTP4p4RbkFuoc8rlvVdffIFz1cxFx
         uaGA0Xee8gfNqym6/xCTfc7HVgx1nBm4RWbHqswY2EJyJIHO74A6QS165izKgNFroJQP
         zfD5k9eE3JKui6SzG3KWmTFPnbPHQ/aenfliIPvJK7B/bK/deyhP6cNnO6tMGqqfbZRC
         2t25zY1B4JFQor4vbU1MewsbUpDYNV9jn/vlQc6T01Q5uvIPJpAaWZqanAIUo7l4WeCY
         yRCmOFzgZ80UavmxeCqpS8YOIuqILZjDSWp0A7+b3+yfS3q+kmk619KFHk4DyOVDXTbw
         /rSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Ibc7hEFsjuir2b98MoZhtmpr7yqFPPDd1zPnA+ln3sg=;
        b=O1KdZ8NltZJd4ncrgtMdyvTqNeQQwqvG3SzLLzgBhVng68+rtugtenC/z4M2eAMfdv
         s2ZKKUc2KoVzurP0YUt+DnQp2q7Z86j0+H9i7ihKsMM+YpYyPzU9XWI9Cl0Acmn5nPfY
         1ALCHlueGGE+WQniDr5fdt/JQSv1UXEnEFAF43RMI3hd2ONlxJ6uL57mWQnBKKxeoFxD
         VkftR/70e2U4tQeH+c4AtxfeFyADhajwxFBdGEaF1STx3XAzaP5qMpb36mpOh6hAVyoY
         Yh80OsowtUTjVRU/ZL2QGca+SUrHNSow2jjUJxR0SV1AzZ4W1jGSCqQO3Cfz8FgW2Oke
         JVNQ==
X-Gm-Message-State: AGRZ1gKhqteFxdhb+VuXSNEDYFZol/Co9oqbxZCUMb+raWOCFseoUylg
        FRWnGE0AyMwydUn3bpplrZy8baVl+kGD
X-Google-Smtp-Source: AJdET5cFTV8iH7LXMPL8IVHW5g6xsb9fUXcjULcdL1wb1BeCUUwN7OSt4japmrXVx6DNge/8WcqkuuaSPLO3
X-Received: by 2002:ac8:26cb:: with SMTP id 11mr5106683qtp.34.1542154418916;
 Tue, 13 Nov 2018 16:13:38 -0800 (PST)
Date:   Tue, 13 Nov 2018 16:12:46 -0800
In-Reply-To: <20181114001306.138053-1-sbeller@google.com>
Message-Id: <20181114001306.138053-4-sbeller@google.com>
Mime-Version: 1.0
References: <20181114001306.138053-1-sbeller@google.com>
X-Mailer: git-send-email 2.19.1.1215.g8438c0b245-goog
Subject: [PATCH 03/23] object-store: allow read_object_file_extended to read
 from any repo
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com, jonathantanmy@google.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

read_object_file_extended is not widely used, so migrate it all at once.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 object-store.h |  5 +++--
 sha1-file.c    | 11 ++++++-----
 streaming.c    |  2 +-
 3 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/object-store.h b/object-store.h
index 63b7605a3e..3d98a682b2 100644
--- a/object-store.h
+++ b/object-store.h
@@ -161,12 +161,13 @@ void sha1_file_name(struct repository *r, struct strbuf *buf, const unsigned cha
 
 void *map_sha1_file(struct repository *r, const unsigned char *sha1, unsigned long *size);
 
-extern void *read_object_file_extended(const struct object_id *oid,
+extern void *read_object_file_extended(struct repository *r,
+				       const struct object_id *oid,
 				       enum object_type *type,
 				       unsigned long *size, int lookup_replace);
 static inline void *read_object_file(const struct object_id *oid, enum object_type *type, unsigned long *size)
 {
-	return read_object_file_extended(oid, type, size, 1);
+	return read_object_file_extended(the_repository, oid, type, size, 1);
 }
 
 /* Read and unpack an object file into memory, write memory to an object file */
diff --git a/sha1-file.c b/sha1-file.c
index 856e000ee1..c5b704aec5 100644
--- a/sha1-file.c
+++ b/sha1-file.c
@@ -1403,7 +1403,8 @@ int pretend_object_file(void *buf, unsigned long len, enum object_type type,
  * deal with them should arrange to call read_object() and give error
  * messages themselves.
  */
-void *read_object_file_extended(const struct object_id *oid,
+void *read_object_file_extended(struct repository *r,
+				const struct object_id *oid,
 				enum object_type *type,
 				unsigned long *size,
 				int lookup_replace)
@@ -1413,10 +1414,10 @@ void *read_object_file_extended(const struct object_id *oid,
 	const char *path;
 	struct stat st;
 	const struct object_id *repl = lookup_replace ?
-		lookup_replace_object(the_repository, oid) : oid;
+		lookup_replace_object(r, oid) : oid;
 
 	errno = 0;
-	data = read_object(the_repository, repl->hash, type, size);
+	data = read_object(r, repl->hash, type, size);
 	if (data)
 		return data;
 
@@ -1428,11 +1429,11 @@ void *read_object_file_extended(const struct object_id *oid,
 		die(_("replacement %s not found for %s"),
 		    oid_to_hex(repl), oid_to_hex(oid));
 
-	if (!stat_sha1_file(the_repository, repl->hash, &st, &path))
+	if (!stat_sha1_file(r, repl->hash, &st, &path))
 		die(_("loose object %s (stored in %s) is corrupt"),
 		    oid_to_hex(repl), path);
 
-	if ((p = has_packed_and_bad(the_repository, repl->hash)) != NULL)
+	if ((p = has_packed_and_bad(r, repl->hash)) != NULL)
 		die(_("packed object %s (stored in %s) is corrupt"),
 		    oid_to_hex(repl), p->pack_name);
 
diff --git a/streaming.c b/streaming.c
index d1e6b2dce6..c843a1230f 100644
--- a/streaming.c
+++ b/streaming.c
@@ -490,7 +490,7 @@ static struct stream_vtbl incore_vtbl = {
 
 static open_method_decl(incore)
 {
-	st->u.incore.buf = read_object_file_extended(oid, type, &st->size, 0);
+	st->u.incore.buf = read_object_file_extended(the_repository, oid, type, &st->size, 0);
 	st->u.incore.read_ptr = 0;
 	st->vtbl = &incore_vtbl;
 
-- 
2.19.1.1215.g8438c0b245-goog

