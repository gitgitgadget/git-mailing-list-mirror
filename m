Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E9CEF1F424
	for <e@80x24.org>; Wed, 25 Apr 2018 18:24:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756489AbeDYSYV (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Apr 2018 14:24:21 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:34975 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756099AbeDYSVV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Apr 2018 14:21:21 -0400
Received: by mail-pf0-f193.google.com with SMTP id j5so15926491pfh.2
        for <git@vger.kernel.org>; Wed, 25 Apr 2018 11:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zeevuMy4/K6PjAfDOJh5gu1QsamQzHAAPOMxHYoC+8I=;
        b=HjEiroU/Kw2FltWgha2W4QDHcHJlO23oYyxAJHsOBwBUtylfaL4922iXW7hGQHbFpK
         SCEmA85JEX/O179eD+1zGjqY3ULoIbjQGPpdlD7gm9G1l23JvB7cfL5i9FQhS/qqmjY2
         9T9f+Sjd5BsH7WHsFH8bdDLQP8KdcoP8FO3l3Q9ulsuS5KldTxD0vDLu5Geq06Y1tp4E
         Z5oSZqpEm8dkUUXFp4SDjbTgD82aSikV/Ou2GiUX9zs9YrSucVffDoZbkRkQnuKM2kpi
         52Nwu0dXu1aQ4CFb3ysfAnRkH1f91YQvbYzVUAITtvE3/mahpTs307QG5/JEm3s0rSFU
         IZSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zeevuMy4/K6PjAfDOJh5gu1QsamQzHAAPOMxHYoC+8I=;
        b=VUIPmtGXfiL3DvZ6V0jKiAwldVmwXb6PsSHuGsLXk9xjRv2LzL4mEWZLbvcH2y5BZN
         HS3RN/IrL1FwSwIJgtrWZaShCRvgzKzihOdPdbZPCCf4cUmP9Ya14McBCVpvFM1kDpgB
         xX+5xCOJHCdv0jTfBoJe6cqZ4M8H7hVMKHZV3BdFX8rhis80b/WNwZx2P2cogMLzW+fD
         90r/kezz/EFyu6TVyKz1OovPcukFiZVx/rY4xOyV+ghIhLx9vnjIu2pDwTE6aidr5V2q
         oJfCG0YHEJeML4rzAcPpMC+ovdnThsuLGgo0pm5NucOejO58IyGUcTa689XHQ8XQEdMs
         7wUg==
X-Gm-Message-State: ALQs6tA97cwPjpaJOBOH7e7Upg3zfA9ZDHbYRpYLhSQnAq3r/IJuqMT2
        6eHFLjyq0LACGQz5f2RHKAlYksw40fU=
X-Google-Smtp-Source: AIpwx4/guNs/9zNSPFihPwk8RVFY3NQtwCEqch/lPEruQDkkRL0VCUHXP7n7mMPNaF9eKBPcMZomvw==
X-Received: by 10.98.35.11 with SMTP id j11mr19454682pfj.177.1524680480875;
        Wed, 25 Apr 2018 11:21:20 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id o88sm38479664pfk.91.2018.04.25.11.21.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 25 Apr 2018 11:21:20 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     bmwill@google.com, git@vger.kernel.org, gitster@pobox.com,
        jonathantanmy@google.com, sandals@crustytoothpaste.net,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCHv3 7/9] packfile: add repository argument to unpack_entry
Date:   Wed, 25 Apr 2018 11:21:04 -0700
Message-Id: <20180425182106.162972-8-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d-goog
In-Reply-To: <20180425182106.162972-1-sbeller@google.com>
References: <20180424215910.22201-1-sbeller@google.com>
 <20180425182106.162972-1-sbeller@google.com>
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
2.17.0.441.gb46fe60e1d-goog

