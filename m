Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 15EF41F453
	for <e@80x24.org>; Tue, 16 Oct 2018 23:36:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727192AbeJQH2s (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Oct 2018 03:28:48 -0400
Received: from mail-ot1-f73.google.com ([209.85.210.73]:49196 "EHLO
        mail-ot1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727020AbeJQH2s (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Oct 2018 03:28:48 -0400
Received: by mail-ot1-f73.google.com with SMTP id j47so18225391ota.16
        for <git@vger.kernel.org>; Tue, 16 Oct 2018 16:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=r6pZnj6NNpuuleQyLYwbmCqXJeAhN5KJ5Dg6i/99Mwc=;
        b=WkxVLO4/zcWWiJzyR0wSXcOGFMX8ljTkXRk88A9fE+HtnEgYtbabxyUS5xmHeleIBf
         KTAE2g5RdsUgoe4rTM5CIjDAuEBPFGOtsJIDbWNQHw3b0fVRONbJkZ8chqBmG9F2jpRP
         bCv0Dz2ia4BUnjR15gxlysK6KCiikhaQuiHEgHtuxxnpYXm0mcoUMJDaCbUxWErGCZww
         FAowxUNrKVA/fYCovCUVDeds/W1vXRgDyZAT4+/FNsWYKtn3+qsoWHSTfodKhiY2cmqt
         NfnyQeVBu9NW9VfsbolMPbGPkOLnB3MyF6x2W1FGWExYe8HrJcc5lrzq7fwalDNWL6Uv
         pg9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=r6pZnj6NNpuuleQyLYwbmCqXJeAhN5KJ5Dg6i/99Mwc=;
        b=mzLkmZY2ZRvJQcFxtpH/uSacTGs8qtT2TqDVZJwldO383E0KxqHaRZYQVcYmv0KrWO
         Tc5Zs+mfoJexMkTA187FxSjOrBzhhqUtY3DU8XTQMSDMznMf6RtsKNZu/2SkIAwyYxUK
         YIRGPr59l27cRKxdLBwskDsXa+/HPZSsH3UGgtf2Irwadb1RTIyQtDBgKAoMw0pU4+LJ
         wyiw8MarwbBjADfikdIMhYru9lViXZe5gL4YWIQ2nLjDKEVt1CAPwFO9m4kf7L3BUG6Y
         SGIntZLtY7/cANWl6AQ0VmqTaNQCqY+bu/FZxQ6ujPA1om+TYGe+zyBE341OZVr2RnWs
         dhNg==
X-Gm-Message-State: ABuFfohUaOC9BdVfacFpCFlNJ+W6j7IEDNuDJ66KO3yMlWUuWmJw55Ea
        J3VLUDGZWspYdtwxJkgeRx5qBE8Nw61hUolweUWqivRpIwIuso/tw29Fuv81fhvrGSSpzwsdNeZ
        k6sstT1YkRNpQ61BxXIliyY5vBQTvPVI53yUIdnL7g+REPkIqmeP+R9dSCTUq
X-Google-Smtp-Source: ACcGV62RaxZ3Wp1jiBS+h52FVgKwLxUnfL2P2TXJ+8O8wAENgWTv7VCL57kC/5o8PPOiuUfLQ8KBWXxsP5gV
X-Received: by 2002:a9d:4a0b:: with SMTP id h11mr19512089otf.65.1539732962989;
 Tue, 16 Oct 2018 16:36:02 -0700 (PDT)
Date:   Tue, 16 Oct 2018 16:35:34 -0700
In-Reply-To: <20181016233550.251311-1-sbeller@google.com>
Message-Id: <20181016233550.251311-4-sbeller@google.com>
Mime-Version: 1.0
References: <20181016233550.251311-1-sbeller@google.com>
X-Mailer: git-send-email 2.19.0
Subject: [PATCH 03/19] object-store: allow read_object_file_extended to read
 from arbitrary repositories
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     jonathantanmy@google.com, Stefan Beller <sbeller@google.com>,
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
index 67e66227d9..6bb0ccbf05 100644
--- a/object-store.h
+++ b/object-store.h
@@ -146,12 +146,13 @@ void sha1_file_name(struct repository *r, struct strbuf *buf, const unsigned cha
 
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
index 13b3c5cb79..ce47524679 100644
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
2.19.0

