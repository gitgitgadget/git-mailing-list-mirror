Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6C0E41F454
	for <e@80x24.org>; Tue, 30 Oct 2018 22:08:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728459AbeJaHD4 (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Oct 2018 03:03:56 -0400
Received: from mail-pg1-f202.google.com ([209.85.215.202]:51295 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728453AbeJaHD4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Oct 2018 03:03:56 -0400
Received: by mail-pg1-f202.google.com with SMTP id z13-v6so10048666pgv.18
        for <git@vger.kernel.org>; Tue, 30 Oct 2018 15:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=XrsL5O26Au2090hyQQFE6jISbSI1/0Sj/6+EljMEBrw=;
        b=HQwnI5JQgvO3VdM1jQgbWm62EEoKxiahOlNKpBXcAsoarZ6ePhwkgN3GSEuNR1GT0H
         P+vzLqTJ9ls9tizcB8Hj2Rts6yahkaJZo5mR793Y2rZ4H37nhts9vO3ndIPpoY5BexX/
         mpvPK+VGkOwD/oryvCwytWMilbQ4CO3ruRLtbhPpf6h2/lkhIX+1R9pm706w/cU1WCJq
         bt0G40jStURkDP+RSubhPN/aME1L7EQ7+D5jWfuY3OBxJI1oZpDT9aWa/amujB/LZv51
         zy4Nwgv/kxMI+/eqgtlpHe52W0aT+f+0WBep2iHNrJWyKY2yQGiF8svfcj9i/gMFi9tm
         L81w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=XrsL5O26Au2090hyQQFE6jISbSI1/0Sj/6+EljMEBrw=;
        b=TtKkfwtMc9Sr3QwwbP6JwvxO2QMkTKG0b+r6aVeNldVcLvJn51WaJP3d+3FwRFVsYP
         JjOdeu2uNexLkMU/Dj4t7CZX3eNzEW/1iHc1UyAE9fdsy9I/vi53eaICnfx2vwLhLj9K
         nKsyUCQxFnSgrkrIADwjcsDavK7/1fuqmhPllUCAbuYQ2cyk+p4MlwKQ2fLVtXrYsfMJ
         wRJoDJJViOgffWa9uZBhd8Mhl5HixGEGGGh20pA9CZYKZQCTFOMgSpmV9eiU46IcumoQ
         rZUy6z670qX7QeOvTRWK7cJc5XweJZSxQnWPGMSsUuwids/4ePOXhvRwdntAvTKi1CLE
         v1OQ==
X-Gm-Message-State: AGRZ1gK8cP3M5/a30cn3VA9a3G9N+ye//rIxIRJSVNnZun5IbMOGzSWx
        6CO0SisoWRQRyMTd7MniiX36EpUe0Y4uX9A6TGjw0c8Wq7q+wMjPMQBz8fpalKAy2dabey9u2c4
        X+V1iW0/kN24RxvZiWDJ4gAgWnxhSbWtUM1PxMGiz48r9piABNlzHbKUK8KLF
X-Google-Smtp-Source: AJdET5d06Usp5tH58tx6KrV2QQMjOSS2go0zkX7dqbZM7KcikAX4sWfcoI1G7ywRzgBLoB44jPErC3uY24M1
X-Received: by 2002:a62:11dd:: with SMTP id 90-v6mr273891pfr.142.1540937320947;
 Tue, 30 Oct 2018 15:08:40 -0700 (PDT)
Date:   Tue, 30 Oct 2018 15:07:57 -0700
In-Reply-To: <20181030220817.61691-1-sbeller@google.com>
Message-Id: <20181030220817.61691-5-sbeller@google.com>
Mime-Version: 1.0
References: <20181030220817.61691-1-sbeller@google.com>
X-Mailer: git-send-email 2.19.1.930.g4563a0d9d0-goog
Subject: [PATCH 04/24] object-store: allow read_object_file_extended to read
 from arbitrary repositories
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     szeder.dev@gmail.com, jonathantanmy@google.com,
        Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>
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
2.19.1.930.g4563a0d9d0-goog

