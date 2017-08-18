Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3A5DC208CD
	for <e@80x24.org>; Fri, 18 Aug 2017 22:21:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752021AbdHRWVb (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Aug 2017 18:21:31 -0400
Received: from mail-pg0-f46.google.com ([74.125.83.46]:33976 "EHLO
        mail-pg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751674AbdHRWVI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Aug 2017 18:21:08 -0400
Received: by mail-pg0-f46.google.com with SMTP id n4so8536345pgn.1
        for <git@vger.kernel.org>; Fri, 18 Aug 2017 15:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=LCFqufLJivXJGuZoBZJwEGFUpdCGOUEUuS3J5Vi3Ok4=;
        b=qujtnBbnIESUSF2Efq0BcQDlkTrADjkp/pCk8/qxWHFqkFhvp+TrSTrjZdHy3Mhcpx
         ZqhFQhZT5qPGhZdTZzhxoU7RWCaR+TUllvO+LdG2EHgHguN1ap8QCUfyIj5A92ffkEX5
         QLzyOKB0c4cYAz6T56yeewvzh4eRhwtZLHqHtMl1fcJF9vFfeXH6Oc4h44i6T9xaqKYs
         Cz0vVhxCP2lkRiMgu4W/1tww8ur7+XpDLNaWuDK+HFPWYstqt2VTL+OHL7d5owfv/dyv
         feQjuI9L3oZ5CAp+qRREAQthVuDc4yIvLBozj5wB3JHuRHWh2q4EqJ0y5YCyv5ETwan1
         59jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=LCFqufLJivXJGuZoBZJwEGFUpdCGOUEUuS3J5Vi3Ok4=;
        b=JNKqUfTZewg2BWDP2pxJs03pNBfFftirFqc1h0KCa6t9FP/ztxl7h8jQJrg8P3uIK0
         09wdRw378BvuhIoCwM5l52yrXGnTWiCFmwJ53CvcPoJhUY9AuJ7q2BN4MG2EQ9qofoh/
         zSZkePERV616ya+SOins1dj/mGKjKuyF8I2rjdVZo4Qt8ZnFKsKMqeskiDV+wVKx/8uJ
         ciKNguXVT81fr6iPaPxH5yaQncUvthuMVicCUiW4U4Asu3xXZr7BMbfr5keGPlw8lcrA
         q29WTFPgr99hMpyFhvjlk2shs90xsL/E1YgJbWLEXcy25J1gNyzCkLYC1yRx5zTBmRG9
         n4xw==
X-Gm-Message-State: AHYfb5icyO11Q7aNz4uUFDcJYDtZbdkHqIF4F/VXxkuTjTmLoqTbQaqU
        9Q3WjLwUR7ScPZrxXcP4yg==
X-Received: by 10.98.100.204 with SMTP id y195mr9993532pfb.303.1503094867599;
        Fri, 18 Aug 2017 15:21:07 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([100.96.218.24])
        by smtp.gmail.com with ESMTPSA id w123sm12544006pfb.60.2017.08.18.15.21.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 18 Aug 2017 15:21:06 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com
Subject: [PATCH v3 20/23] pack: move find_pack_entry() and make it global
Date:   Fri, 18 Aug 2017 15:20:35 -0700
Message-Id: <581351b54a82ad610c99b4d9dd405eb53efb1995.1503094448.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.14.1.480.gb18f417b89-goog
In-Reply-To: <cover.1503094448.git.jonathantanmy@google.com>
References: <cover.1503094448.git.jonathantanmy@google.com>
In-Reply-To: <cover.1503094448.git.jonathantanmy@google.com>
References: <cover.1502220307.git.jonathantanmy@google.com> <cover.1503094448.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This function needs to be global as it is used by sha1_file.c and will
be used by packfile.c.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 packfile.c  | 53 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 packfile.h  |  2 ++
 sha1_file.c | 53 -----------------------------------------------------
 3 files changed, 55 insertions(+), 53 deletions(-)

diff --git a/packfile.c b/packfile.c
index ba3a5eb3a..ae5395f5f 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1787,3 +1787,56 @@ struct packed_git *find_sha1_pack(const unsigned char *sha1,
 	return NULL;
 
 }
+
+static int fill_pack_entry(const unsigned char *sha1,
+			   struct pack_entry *e,
+			   struct packed_git *p)
+{
+	off_t offset;
+
+	if (p->num_bad_objects) {
+		unsigned i;
+		for (i = 0; i < p->num_bad_objects; i++)
+			if (!hashcmp(sha1, p->bad_object_sha1 + 20 * i))
+				return 0;
+	}
+
+	offset = find_pack_entry_one(sha1, p);
+	if (!offset)
+		return 0;
+
+	/*
+	 * We are about to tell the caller where they can locate the
+	 * requested object.  We better make sure the packfile is
+	 * still here and can be accessed before supplying that
+	 * answer, as it may have been deleted since the index was
+	 * loaded!
+	 */
+	if (!is_pack_valid(p))
+		return 0;
+	e->offset = offset;
+	e->p = p;
+	hashcpy(e->sha1, sha1);
+	return 1;
+}
+
+/*
+ * Iff a pack file contains the object named by sha1, return true and
+ * store its location to e.
+ */
+int find_pack_entry(const unsigned char *sha1, struct pack_entry *e)
+{
+	struct mru_entry *p;
+
+	prepare_packed_git();
+	if (!packed_git)
+		return 0;
+
+	for (p = packed_git_mru->head; p; p = p->next) {
+		if (fill_pack_entry(sha1, e, p->item)) {
+			mru_mark(packed_git_mru, p);
+			return 1;
+		}
+	}
+	return 0;
+}
diff --git a/packfile.h b/packfile.h
index a4ff6f6ed..c9b4fcfaf 100644
--- a/packfile.h
+++ b/packfile.h
@@ -118,4 +118,6 @@ extern int packed_object_info(struct packed_git *pack, off_t offset, struct obje
 extern void mark_bad_packed_object(struct packed_git *p, const unsigned char *sha1);
 extern const struct packed_git *has_packed_and_bad(const unsigned char *sha1);
 
+extern int find_pack_entry(const unsigned char *sha1, struct pack_entry *e);
+
 #endif
diff --git a/sha1_file.c b/sha1_file.c
index 8853672d2..76c86639c 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1074,59 +1074,6 @@ int parse_sha1_header(const char *hdr, unsigned long *sizep)
 	return parse_sha1_header_extended(hdr, &oi, 0);
 }
 
-static int fill_pack_entry(const unsigned char *sha1,
-			   struct pack_entry *e,
-			   struct packed_git *p)
-{
-	off_t offset;
-
-	if (p->num_bad_objects) {
-		unsigned i;
-		for (i = 0; i < p->num_bad_objects; i++)
-			if (!hashcmp(sha1, p->bad_object_sha1 + 20 * i))
-				return 0;
-	}
-
-	offset = find_pack_entry_one(sha1, p);
-	if (!offset)
-		return 0;
-
-	/*
-	 * We are about to tell the caller where they can locate the
-	 * requested object.  We better make sure the packfile is
-	 * still here and can be accessed before supplying that
-	 * answer, as it may have been deleted since the index was
-	 * loaded!
-	 */
-	if (!is_pack_valid(p))
-		return 0;
-	e->offset = offset;
-	e->p = p;
-	hashcpy(e->sha1, sha1);
-	return 1;
-}
-
-/*
- * Iff a pack file contains the object named by sha1, return true and
- * store its location to e.
- */
-static int find_pack_entry(const unsigned char *sha1, struct pack_entry *e)
-{
-	struct mru_entry *p;
-
-	prepare_packed_git();
-	if (!packed_git)
-		return 0;
-
-	for (p = packed_git_mru->head; p; p = p->next) {
-		if (fill_pack_entry(sha1, e, p->item)) {
-			mru_mark(packed_git_mru, p);
-			return 1;
-		}
-	}
-	return 0;
-}
-
 static int sha1_loose_object_info(const unsigned char *sha1,
 				  struct object_info *oi,
 				  int flags)
-- 
2.14.1.480.gb18f417b89-goog

