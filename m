Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5937B1F97E
	for <e@80x24.org>; Thu, 11 Oct 2018 21:18:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726903AbeJLErK (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Oct 2018 00:47:10 -0400
Received: from mail-yw1-f74.google.com ([209.85.161.74]:41857 "EHLO
        mail-yw1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726210AbeJLErK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Oct 2018 00:47:10 -0400
Received: by mail-yw1-f74.google.com with SMTP id d23-v6so5843366ywd.8
        for <git@vger.kernel.org>; Thu, 11 Oct 2018 14:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=oKupGglTaz+JkyOCnYUv6My7t1bqxgM24KPHQka9dE8=;
        b=SOUqOmD/mPShBPKPC8wzV/vVOOA3YBY8ju/Y8YpJSwq9gbRefR0z4BJJC3SYUHecIs
         7SXrlcP9f0VfxlGCfS6Es456s4tb2KWfg/xaVv1V+pQbr3SaLwZp9O8i5cEJZp8oQ1Kz
         qhDRepj5KJEHVKwv7/F3CPsSgcDyMEqkge1vJ7tZRdg8efjIQy5gT5B7Qijjnl5UG+rM
         kVnsOmeyyTu0Es7UR4g6e9rQSBVIyMuWHj/9kjyf36pzD1utwsukXzeY/d7Y6S+3kKf2
         pS4RxItwmKn4zztL5mlXs9gPMb4aLa/fQBwdklCtAErFvHAyhQvsJY+AlAIwDT8F1aO3
         xEVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=oKupGglTaz+JkyOCnYUv6My7t1bqxgM24KPHQka9dE8=;
        b=T9bOGZJB8KBff91zcrBQVsq4ijvvD3n8rLtmwPEHSGY2e/eQkl3Qc90OCdX3XImhmF
         W0s5IqPJNjHRYHW02BnXNwZvPplRaqNinpSCcxBlu4/4wXTEnVP6JeEKiptzIMTDkwqn
         zb6xCOKfcNGqYn+gigxbB95LWSnx8vvbxBmn0OwI2/b7gc7YpbtxoD2acWuhjsVCNx1T
         VTf5SwOdKkO8fx/gjaUkJpxaZMOQdqLh9aGy7s9J8biICYHEsGPOepf9wGr33MDnCgmv
         2xUdOpe5Q/Y/bJfCs9VPlseyntwlIyzVZh6S5fkiyeEAQTsJlRoeDeV4yScSAJ37rmg5
         C7aQ==
X-Gm-Message-State: ABuFfohglppg+p6oDz08gIB9737uzSXuq0r4YOBni7IugzXzNBv1TLoT
        eNWj9Md15vNSJUdtcsm9SjDhByiv/jdiUOB1D1KftXPk9rltv8c5Fg5g3vhW0wkAdoiPhs8Ixk3
        WMAnqTG78jlzGATkiftIZcs7eoxkUUBrdoKB28Dx5171jE6R+MT+qn1oJjT1i
X-Google-Smtp-Source: ACcGV60nwDdJLwAI5Of1d9rnBMOoSrkaEciPtpn12aizaYJwsy6oCW8iZS1q0N4nmbCvSGL02CLH9wMA7E8Y
X-Received: by 2002:a25:8545:: with SMTP id f5-v6mr1966724ybn.74.1539292684914;
 Thu, 11 Oct 2018 14:18:04 -0700 (PDT)
Date:   Thu, 11 Oct 2018 14:17:38 -0700
In-Reply-To: <20181011211754.31369-1-sbeller@google.com>
Message-Id: <20181011211754.31369-4-sbeller@google.com>
Mime-Version: 1.0
References: <20181011211754.31369-1-sbeller@google.com>
X-Mailer: git-send-email 2.19.0
Subject: [PATCH 03/19] object-store: allow read_object_file_extended to read
 from arbitrary repositories
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     jonathantanmy@google.com, Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

read_object_file_extended is not widely used, so migrate it all at once.

Signed-off-by: Stefan Beller <sbeller@google.com>
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

