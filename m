Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 26280208CD
	for <e@80x24.org>; Fri, 18 Aug 2017 22:21:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751807AbdHRWVJ (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Aug 2017 18:21:09 -0400
Received: from mail-pg0-f53.google.com ([74.125.83.53]:33646 "EHLO
        mail-pg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751594AbdHRWVB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Aug 2017 18:21:01 -0400
Received: by mail-pg0-f53.google.com with SMTP id t3so44140261pgt.0
        for <git@vger.kernel.org>; Fri, 18 Aug 2017 15:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=vjSGusTT9d/9kQgixJQtbStxV/GRf7NbCfqPOsxkyq4=;
        b=UdRpU9CaMjJarYAcp9lkJXKbsj4LBSIxUG6roZDqC+eOnwkqAoOQqlJ690bE0q740P
         woUF1G9fXKip4NjaanB76qXhd/T0i0uahFzCDepkeg/plMUU7XTGJcDynIAoGChNACiS
         BLbKRKwBY9hp3EhCJBzw8qFucsqqkp+tVgeZ5C6hX1nUyCkU3LfzmGf57+JlCKLCqtYo
         /PKpsjAlgKPwcFFuGeLpRjFXcvkPkzjMSnqqaqDXQul650n5YBcnOYtXz+aCNIoIK57D
         R0ctZLpMq3GfA6wRoTZHckFL7NVpgE/b1dhjexDpi8yTtn+hPpNcxzZs94phv7ErcQxO
         0xhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=vjSGusTT9d/9kQgixJQtbStxV/GRf7NbCfqPOsxkyq4=;
        b=hrRe+pPtcAyaoZMXkVDdAWmDxwCJL7bfGtN1eu02MEREBWHTZXwA3WFFAoyTbvCd16
         dG53ZbhTgn5tWHQwXTWpf8R2czYDjsdm8XUrM6z0aOgWYPUzdSlB5nWajaRqT8zml7Nj
         H1xcXWcCmc9VKhb5M5Kh1OFASoWmqk/KVvAe9HeFk1CWAMjyaAGWmI0Kpm8/+hSkV0lB
         RtRdJQSvf8p9ZNHAiedzEsE01WCuwBTpGEN7Qznj7R3NPGE0rLAxEe9gllB7BqnyssfC
         Lmq92+v+FGJjo1NwHmhmjAiNWBCkMMJOlEbC4UnAo1MEan6npILLcpDJ/8h36MRlj3vf
         Kxpg==
X-Gm-Message-State: AHYfb5jXAfAmFYK4roJR5526Ex+GKuZ8t4Vfcc9/BMQXYHlIlJK6hyEX
        6tLNxDUdBS3iHyEevFjDkw==
X-Received: by 10.101.88.136 with SMTP id d8mr9938178pgu.376.1503094860651;
        Fri, 18 Aug 2017 15:21:00 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([100.96.218.24])
        by smtp.gmail.com with ESMTPSA id w123sm12544006pfb.60.2017.08.18.15.20.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 18 Aug 2017 15:20:59 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com
Subject: [PATCH v3 14/23] pack: move unpack_object_header()
Date:   Fri, 18 Aug 2017 15:20:29 -0700
Message-Id: <5ed586488d0d603fa6967a49db1deab4149bda11.1503094448.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.14.1.480.gb18f417b89-goog
In-Reply-To: <cover.1503094448.git.jonathantanmy@google.com>
References: <cover.1503094448.git.jonathantanmy@google.com>
In-Reply-To: <cover.1503094448.git.jonathantanmy@google.com>
References: <cover.1502220307.git.jonathantanmy@google.com> <cover.1503094448.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 cache.h     |  1 -
 packfile.c  | 26 ++++++++++++++++++++++++++
 packfile.h  |  1 +
 sha1_file.c | 26 --------------------------
 4 files changed, 27 insertions(+), 27 deletions(-)

diff --git a/cache.h b/cache.h
index 87f65aeea..7adbc587d 100644
--- a/cache.h
+++ b/cache.h
@@ -1669,7 +1669,6 @@ extern off_t find_pack_entry_one(const unsigned char *sha1, struct packed_git *)
 
 extern int is_pack_valid(struct packed_git *);
 extern void *unpack_entry(struct packed_git *, off_t, enum object_type *, unsigned long *);
-extern int unpack_object_header(struct packed_git *, struct pack_window **, off_t *, unsigned long *);
 
 /*
  * Iterate over the files in the loose-object parts of the object
diff --git a/packfile.c b/packfile.c
index fa90b643e..3543b37b8 100644
--- a/packfile.c
+++ b/packfile.c
@@ -949,3 +949,29 @@ unsigned long get_size_from_delta(struct packed_git *p,
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
+	size_t left;
+	size_t used;
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
diff --git a/packfile.h b/packfile.h
index 9c3bce6b2..d22a528b5 100644
--- a/packfile.h
+++ b/packfile.h
@@ -64,6 +64,7 @@ extern struct packed_git *add_packed_git(const char *path, size_t path_len, int
 
 extern unsigned long unpack_object_header_buffer(const unsigned char *buf, unsigned long len, enum object_type *type, unsigned long *sizep);
 extern unsigned long get_size_from_delta(struct packed_git *, struct pack_window **, off_t);
+extern int unpack_object_header(struct packed_git *, struct pack_window **, off_t *, unsigned long *);
 
 extern void release_pack_memory(size_t);
 
diff --git a/sha1_file.c b/sha1_file.c
index 5d016ad6b..681dcf1c0 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1171,32 +1171,6 @@ static const unsigned char *get_delta_base_sha1(struct packed_git *p,
 		return NULL;
 }
 
-int unpack_object_header(struct packed_git *p,
-			 struct pack_window **w_curs,
-			 off_t *curpos,
-			 unsigned long *sizep)
-{
-	unsigned char *base;
-	size_t left;
-	size_t used;
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
2.14.1.480.gb18f417b89-goog

