Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AC2CE1F404
	for <e@80x24.org>; Tue,  6 Feb 2018 00:09:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752069AbeBFAJV (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 19:09:21 -0500
Received: from mail-pl0-f67.google.com ([209.85.160.67]:40604 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751834AbeBFAJT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 19:09:19 -0500
Received: by mail-pl0-f67.google.com with SMTP id g18so106546plo.7
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 16:09:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mJ3hFxlHDwTGT2zn/CIh+wAwknHvCglKo5HL6k7RS0Q=;
        b=LZ3+4R7kwZM9RgZ9oUTaGHmp9vF/TXe8fv0QWTTKk5tYaZ+wU+RbiFyw/xzZKFN/Ap
         vjir9uo4LaLxwgrTTAI3DhKsoqMu8U0Y6FDQTZl2w+G4q6sP6r9Zs5AKaa+Rqz1FTXey
         Ni1fHrs+JOb3DlX5hQ5jlxbH1KRu8mQeKq+wZ77iW9v/53f77CDMw/3CmRF+BLa5YX4d
         4YDE4ENG0s7t0/0/UXNYvtoR8x20Kk0C8A23rBVlo+SxhHn4JfeBhmPfBraJTc4KxNP0
         svYlb/jSWUt6uWXw6nE+2JxfdlAe88bEluRmXQtUpy0loCbNtih5MV48Z9lLjS35KM4k
         Uvuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mJ3hFxlHDwTGT2zn/CIh+wAwknHvCglKo5HL6k7RS0Q=;
        b=af5+1fxP+FPkyfkqL4hTEhMGnqighFR/lrBNHM2iPhKTCzm/ems1Nq9yq8lciTjjKK
         OyAL0m/s9GdGbyAcmC4orxInKEHjyXlx6xbplNz1KsJXoCTQoazrGpS9bkNYHaccZOD8
         WRAV8zoPS0aGiNCHANGyJV6Dgb88lrMi+onTxaNDd4Z+wx7g4CLqfqwukaeyEvK7EuAl
         bUFH0k5CTQkgKlfoYAk4gu2KG/BXsGyFTCQjDCcSTOu9epZn6S6Wm2Oqek1XE6POcGEg
         uyWdaI73YQkj4q6Rra6rsJFB0Zniqaf7ADPy3JajbkcjZ0witVhEDtJFwXhV/AnBL2Xf
         wPdA==
X-Gm-Message-State: APf1xPDCJ/emp4VhCubAAvwSQ8rkN0yC7utj56Wz+ltlxjzWNf1spD+r
        /XfHCJ+QaQQVFc26B2Y2tEPDrNwNNw4=
X-Google-Smtp-Source: AH8x227xPu3u2An9HLLAQS6iqV3vTWtiuI8T0xXNhKrWLSvaov1/6OtWPgkTs0QxV4TnVFQFTUloXQ==
X-Received: by 2002:a17:902:7789:: with SMTP id o9-v6mr547465pll.84.1517875758733;
        Mon, 05 Feb 2018 16:09:18 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id p20sm17249148pfh.100.2018.02.05.16.09.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Feb 2018 16:09:18 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 071/194] packfile: add repository argument to unpack_entry
Date:   Mon,  5 Feb 2018 15:55:32 -0800
Message-Id: <20180205235735.216710-51-sbeller@google.com>
X-Mailer: git-send-email 2.15.1.433.g936d1b9894.dirty
In-Reply-To: <20180205235735.216710-1-sbeller@google.com>
References: <20180205235508.216277-1-sbeller@google.com>
 <20180205235735.216710-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a repository argument to allow the callers of unpack_entry
to be more specific about which repository to act on. This is a small
mechanical change; it doesn't change the implementation to handle
repositories other than the_repository yet.

As with the previous commits, use a macro to catch callers passing a
repository other than the_repository at compile time.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 fast-import.c | 2 +-
 pack-check.c  | 3 ++-
 packfile.c    | 7 ++++---
 packfile.h    | 3 ++-
 4 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index 2542f600ef..5618087015 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -1372,7 +1372,7 @@ static void *gfi_unpack_entry(
 		 */
 		p->pack_size = pack_size + 20;
 	}
-	return unpack_entry(p, oe->idx.offset, &type, sizep);
+	return unpack_entry(the_repository, p, oe->idx.offset, &type, sizep);
 }
 
 static const char *get_mode(const char *str, uint16_t *modep)
diff --git a/pack-check.c b/pack-check.c
index c80c3ed8fd..25afd59c7d 100644
--- a/pack-check.c
+++ b/pack-check.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "repository.h"
 #include "pack.h"
 #include "object-store.h"
 #include "pack-revindex.h"
@@ -134,7 +135,7 @@ static int verify_packfile(struct packed_git *p,
 			data = NULL;
 			data_valid = 0;
 		} else {
-			data = unpack_entry(p, entries[i].offset, &type, &size);
+			data = unpack_entry(the_repository, p, entries[i].offset, &type, &size);
 			data_valid = 1;
 		}
 
diff --git a/packfile.c b/packfile.c
index 56b2db8b06..69a1cedbe1 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1257,7 +1257,7 @@ static void *cache_or_unpack_entry(struct packed_git *p, off_t base_offset,
 
 	ent = get_delta_base_cache_entry(p, base_offset);
 	if (!ent)
-		return unpack_entry(p, base_offset, type, base_size);
+		return unpack_entry(the_repository, p, base_offset, type, base_size);
 
 	if (type)
 		*type = ent->type;
@@ -1463,8 +1463,9 @@ static void *read_object_the_repository(const unsigned char *sha1,
 	return content;
 }
 
-void *unpack_entry(struct packed_git *p, off_t obj_offset,
-		   enum object_type *final_type, unsigned long *final_size)
+void *unpack_entry_the_repository(struct packed_git *p, off_t obj_offset,
+				  enum object_type *final_type,
+				  unsigned long *final_size)
 {
 	struct pack_window *w_curs = NULL;
 	off_t curpos = obj_offset;
diff --git a/packfile.h b/packfile.h
index b42e5c2db1..615c58cbac 100644
--- a/packfile.h
+++ b/packfile.h
@@ -125,7 +125,8 @@ extern off_t nth_packed_object_offset(const struct packed_git *, uint32_t n);
 extern off_t find_pack_entry_one(const unsigned char *sha1, struct packed_git *);
 
 extern int is_pack_valid(struct packed_git *);
-extern void *unpack_entry(struct packed_git *, off_t, enum object_type *, unsigned long *);
+#define unpack_entry(r, p, of, ot, s) unpack_entry_##r(p, of, ot, s)
+extern void *unpack_entry_the_repository(struct packed_git *, off_t, enum object_type *, unsigned long *);
 extern unsigned long unpack_object_header_buffer(const unsigned char *buf, unsigned long len, enum object_type *type, unsigned long *sizep);
 extern unsigned long get_size_from_delta(struct packed_git *, struct pack_window **, off_t);
 extern int unpack_object_header(struct packed_git *, struct pack_window **, off_t *, unsigned long *);
-- 
2.15.1.433.g936d1b9894.dirty

