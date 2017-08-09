Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 64B9420899
	for <e@80x24.org>; Wed,  9 Aug 2017 01:23:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752553AbdHIBXU (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Aug 2017 21:23:20 -0400
Received: from mail-pg0-f41.google.com ([74.125.83.41]:34328 "EHLO
        mail-pg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752500AbdHIBXT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Aug 2017 21:23:19 -0400
Received: by mail-pg0-f41.google.com with SMTP id u185so21605541pgb.1
        for <git@vger.kernel.org>; Tue, 08 Aug 2017 18:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=LfFiOuXd+M81PmbFFdo5AwLLR2yDihDIPX7+/RE2Qtc=;
        b=OapiF5B10BlFaBhy3PZFEBQOZabgFVJy4op2SozALXBjua8VV/JdqwF2/4Mvjc1klO
         P9eDmq0pHnfRLqOFFLjT1gIocTIlhVUJB3i8QdBqyhpS0aVq2qRpEL8Ht4ljNw7bq+VI
         aJrelptTDjtngpofAMTUqLk47jrfcXUz9sQXQAsbu3n5YYlmhUuc7ODqo323zEM6q5MQ
         1N9gMmvKBbto15gtDC3jVxGEdZ62gOxO9jHDoR138N4qGEb1Tt4VejlQMWojtVz9z8jP
         F+b8FHcQOdcME+KrBIBgZdQGSAYMn9euRRnIFgHFyYd2KuEU+i6qiZWU7R7Ljk/HVykJ
         iJew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=LfFiOuXd+M81PmbFFdo5AwLLR2yDihDIPX7+/RE2Qtc=;
        b=sCGvpyEYNqoVvCDsVPfEY4UzQcrlzB12e43Oecoj47GjzH6IVxfJvV/8yGxq6REQrS
         DZPv3ZN6oYmc7S4uLvjX12OSemagoAUZ3HpWoxVSa3lbn4UpZmDblX5StYGrC8Zj4Yi+
         rTwDSRbhzUf3bw7nbninjQqSz+kZ/LDXHjRP5hocrxaOxOMPXTPMegSXAYvg6DjwnEhb
         p4eB3BSRH/iXl+SPdgDEV/9UDInQWKpIDEQrqTWjUGV/gbDRlV7U6ie42bRhTWEN0bUQ
         kn5XI9o7WadNsYRNVukV18adqjrKESHSZtxYO3plFuZkj43mSklLf+VsR769PnX/cNO/
         RwZg==
X-Gm-Message-State: AHYfb5gKgFKTNEIyZKZjOChvEYCME3TWDdR4nxnDoibOw1mgBkw4qNhd
        fcuHRWJNnBaHi26YqoaJcw==
X-Received: by 10.98.36.198 with SMTP id k67mr6597351pfk.154.1502241798195;
        Tue, 08 Aug 2017 18:23:18 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([100.96.218.24])
        by smtp.gmail.com with ESMTPSA id r5sm4479602pgn.45.2017.08.08.18.23.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 08 Aug 2017 18:23:17 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com,
        sbeller@google.com
Subject: [PATCH v2 14/25] pack: move unpack_object_header()
Date:   Tue,  8 Aug 2017 18:22:46 -0700
Message-Id: <f8a3e07776667c0417b630978c96847d9c773b51.1502241234.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.14.0.434.g98096fd7a8-goog
In-Reply-To: <cover.1502241234.git.jonathantanmy@google.com>
References: <cover.1502241234.git.jonathantanmy@google.com>
In-Reply-To: <cover.1502241234.git.jonathantanmy@google.com>
References: <cover.1502220307.git.jonathantanmy@google.com> <cover.1502241234.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 cache.h     |  1 -
 pack.h      |  1 +
 packfile.c  | 26 ++++++++++++++++++++++++++
 sha1_file.c | 26 --------------------------
 4 files changed, 27 insertions(+), 27 deletions(-)

diff --git a/cache.h b/cache.h
index e29918c75..1ae3333a0 100644
--- a/cache.h
+++ b/cache.h
@@ -1661,7 +1661,6 @@ extern off_t find_pack_entry_one(const unsigned char *sha1, struct packed_git *)
 
 extern int is_pack_valid(struct packed_git *);
 extern void *unpack_entry(struct packed_git *, off_t, enum object_type *, unsigned long *);
-extern int unpack_object_header(struct packed_git *, struct pack_window **, off_t *, unsigned long *);
 
 /*
  * Iterate over the files in the loose-object parts of the object
diff --git a/pack.h b/pack.h
index 69c92d8d2..5e3552392 100644
--- a/pack.h
+++ b/pack.h
@@ -169,5 +169,6 @@ unsigned long approximate_object_count(void);
 
 extern unsigned long unpack_object_header_buffer(const unsigned char *buf, unsigned long len, enum object_type *type, unsigned long *sizep);
 extern unsigned long get_size_from_delta(struct packed_git *, struct pack_window **, off_t);
+extern int unpack_object_header(struct packed_git *, struct pack_window **, off_t *, unsigned long *);
 
 #endif
diff --git a/packfile.c b/packfile.c
index 511afad85..a4db78ea0 100644
--- a/packfile.c
+++ b/packfile.c
@@ -948,3 +948,29 @@ unsigned long get_size_from_delta(struct packed_git *p,
 	/* Read the result size */
 	return get_delta_hdr_size(&data, delta_head+sizeof(delta_head));
 }
+
+int unpack_object_header(struct packed_git *p,
+			 struct pack_window **w_curs,
+			 off_t *curpos,
+			 unsigned long *sizep)
+{
+	unsigned char *base;
+	unsigned long left;
+	unsigned long used;
+	enum object_type type;
+
+	/* use_pack() assures us we have [base, base + 20) available
+	 * as a range that we can look at.  (Its actually the hash
+	 * size that is assured.)  With our object header encoding
+	 * the maximum deflated object size is 2^137, which is just
+	 * insane, so we know won't exceed what we have been given.
+	 */
+	base = use_pack(p, w_curs, *curpos, &left);
+	used = unpack_object_header_buffer(base, left, &type, sizep);
+	if (!used) {
+		type = OBJ_BAD;
+	} else
+		*curpos += used;
+
+	return type;
+}
diff --git a/sha1_file.c b/sha1_file.c
index 7d354d9b6..f3bcdae17 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1170,32 +1170,6 @@ static const unsigned char *get_delta_base_sha1(struct packed_git *p,
 		return NULL;
 }
 
-int unpack_object_header(struct packed_git *p,
-			 struct pack_window **w_curs,
-			 off_t *curpos,
-			 unsigned long *sizep)
-{
-	unsigned char *base;
-	unsigned long left;
-	unsigned long used;
-	enum object_type type;
-
-	/* use_pack() assures us we have [base, base + 20) available
-	 * as a range that we can look at.  (Its actually the hash
-	 * size that is assured.)  With our object header encoding
-	 * the maximum deflated object size is 2^137, which is just
-	 * insane, so we know won't exceed what we have been given.
-	 */
-	base = use_pack(p, w_curs, *curpos, &left);
-	used = unpack_object_header_buffer(base, left, &type, sizep);
-	if (!used) {
-		type = OBJ_BAD;
-	} else
-		*curpos += used;
-
-	return type;
-}
-
 static int retry_bad_packed_offset(struct packed_git *p, off_t obj_offset)
 {
 	int type;
-- 
2.14.0.434.g98096fd7a8-goog

