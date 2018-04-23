Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 354511F42D
	for <e@80x24.org>; Mon, 23 Apr 2018 23:43:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932820AbeDWXnu (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Apr 2018 19:43:50 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:35648 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932777AbeDWXnm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Apr 2018 19:43:42 -0400
Received: by mail-pf0-f196.google.com with SMTP id j5so10625277pfh.2
        for <git@vger.kernel.org>; Mon, 23 Apr 2018 16:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8X3DuApjYJVvmku0N14Eep5MPpa6B/YlVoU8BCiQjl8=;
        b=vOw8/jKegUZ4gGAZ5gc5xYQ6lpGiT3vsQA2VzRDb58Af6ULnZA+8Qf/jNosRKMmtNO
         anGCvlDIh9o6t2Z0tlDCylRqeoNiNtIrIuyuFL9XGe4jjP8UUYVFt06I6XUC7TzNuDTx
         ieIGi2unDUQUQUbByEy5bX6JqCvTbJd55GQTHTbeW1aPWZMJ8gn80N8eS+C2I/YL3JG5
         U6XF/Hw94AkNAQl/NMSOyZd8RMYiyUajskUpdko6yc7XBGonMvhwC/YvKHODxh7e++5I
         9VwPytrhvXwRL7ARYEA27qjFMMOyRcXKhNrl1sHKjYTsLN+G8CZr8qNHY0e+C/5paSGD
         42qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8X3DuApjYJVvmku0N14Eep5MPpa6B/YlVoU8BCiQjl8=;
        b=ntNFV2zoNywYqIQGsFVdNaI7ywsQJ86BGaD6LGHc6C+ckfh4vsNGM33jHJqYLtTc6Q
         ms4+oWgFHeGRmANIQ6FlrLscimH11vfWxE1LC9X6vNWFShVGbJpkmOXEHIaYTxIvyHGb
         XJJsyyjOBUMznciKYLCJCphT/8p1yUEsQ0S9b2EDNqhFd6k2JJHMC6uYdaQIfY6tJf0a
         1zeAjQ4XRjzYiSYZJAHf1QuGhprVqkgk9Gw9j4MaBGswldD3FNPE/yA1MP624QtGr0MM
         pyz5IAAUM3Y1qFjW47a3nqY69KjW69wV2k2lpBPgwp4p0urYa9zqWZGdu4nqt6OiXsl9
         sN9g==
X-Gm-Message-State: ALQs6tDZB8fnDV2I6EFoqw2aFAOmmc+GvfLNXWLkby8HUmng+m0cue5I
        7pun/n1EzuHLcw23NAUTMCx6rbiliGw=
X-Google-Smtp-Source: AIpwx48ZPPWpmcxoQwXOvXGj32wVXA1hc/sBi3b54KeCcmWjZ7NinS7YAYe/OG5Ow7szmnNmKv26Tw==
X-Received: by 10.99.116.89 with SMTP id e25mr18678077pgn.43.1524527020919;
        Mon, 23 Apr 2018 16:43:40 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id g16sm12795998pgn.51.2018.04.23.16.43.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 23 Apr 2018 16:43:40 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 7/9] packfile: add repository argument to unpack_entry
Date:   Mon, 23 Apr 2018 16:43:25 -0700
Message-Id: <20180423234327.250484-8-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d-goog
In-Reply-To: <20180423234327.250484-1-sbeller@google.com>
References: <20180423234327.250484-1-sbeller@google.com>
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
index afe06bd7c1..b009353e93 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -1376,7 +1376,7 @@ static void *gfi_unpack_entry(
 		 */
 		p->pack_size = pack_size + the_hash_algo->rawsz;
 	}
-	return unpack_entry(p, oe->idx.offset, &type, sizep);
+	return unpack_entry(the_repository, p, oe->idx.offset, &type, sizep);
 }
 
 static const char *get_mode(const char *str, uint16_t *modep)
diff --git a/pack-check.c b/pack-check.c
index 385d964bdd..d3a57df34f 100644
--- a/pack-check.c
+++ b/pack-check.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "repository.h"
 #include "pack.h"
 #include "pack-revindex.h"
 #include "progress.h"
@@ -134,7 +135,7 @@ static int verify_packfile(struct packed_git *p,
 			data = NULL;
 			data_valid = 0;
 		} else {
-			data = unpack_entry(p, entries[i].offset, &type, &size);
+			data = unpack_entry(the_repository, p, entries[i].offset, &type, &size);
 			data_valid = 1;
 		}
 
diff --git a/packfile.c b/packfile.c
index 2876e04bb1..d5ac48ef18 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1279,7 +1279,7 @@ static void *cache_or_unpack_entry(struct packed_git *p, off_t base_offset,
 
 	ent = get_delta_base_cache_entry(p, base_offset);
 	if (!ent)
-		return unpack_entry(p, base_offset, type, base_size);
+		return unpack_entry(the_repository, p, base_offset, type, base_size);
 
 	if (type)
 		*type = ent->type;
@@ -1485,8 +1485,9 @@ static void *read_object_the_repository(const struct object_id *oid,
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
index bc8d840b1b..1efa57a90e 100644
--- a/packfile.h
+++ b/packfile.h
@@ -115,7 +115,8 @@ extern off_t nth_packed_object_offset(const struct packed_git *, uint32_t n);
 extern off_t find_pack_entry_one(const unsigned char *sha1, struct packed_git *);
 
 extern int is_pack_valid(struct packed_git *);
-extern void *unpack_entry(struct packed_git *, off_t, enum object_type *, unsigned long *);
+#define unpack_entry(r, p, of, ot, s) unpack_entry_##r(p, of, ot, s)
+extern void *unpack_entry_the_repository(struct packed_git *, off_t, enum object_type *, unsigned long *);
 extern unsigned long unpack_object_header_buffer(const unsigned char *buf, unsigned long len, enum object_type *type, unsigned long *sizep);
 extern unsigned long get_size_from_delta(struct packed_git *, struct pack_window **, off_t);
 extern int unpack_object_header(struct packed_git *, struct pack_window **, off_t *, unsigned long *);
-- 
2.17.0.484.g0c8726318c-goog

