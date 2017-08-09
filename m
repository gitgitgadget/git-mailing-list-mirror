Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 85DEE208B5
	for <e@80x24.org>; Wed,  9 Aug 2017 01:23:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752593AbdHIBXc (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Aug 2017 21:23:32 -0400
Received: from mail-pg0-f54.google.com ([74.125.83.54]:36921 "EHLO
        mail-pg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752557AbdHIBX2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Aug 2017 21:23:28 -0400
Received: by mail-pg0-f54.google.com with SMTP id y129so21571665pgy.4
        for <git@vger.kernel.org>; Tue, 08 Aug 2017 18:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=zz81tQeUfxsnqV3PndswIPKRUKIfSjOBBtiJhKoHLac=;
        b=epB1znjzTUIY3663liR0eXQ0y5koeJ+S1q7h3Ch8M/N4MwiOJ5GhtqkJLmbf8U7820
         iSM3N8u0hsTJr6DAkE14cBqUVpAsvuXF4U6m1nwjUffabigEVqBILNpmQGQSZFJ3nmnF
         AIkrsSeGseUrzmLJ00KLCR5W6lSBTkPH2FDYas4RICO4gOppuETZgOzR3FcXVE4zhTMw
         VgR6ZosEeR2sBLlv5HCXhFx0q/csRREMcTkw/fa7UhA7CE4KSElyl8NAgZfAWBE84Q1p
         cYGBR92PGHKReKbg94XfqbzxXAS1JArcRlKXZ9V6rZwlc0hljOcZAvqNCp9mTAr2RnU2
         jeyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=zz81tQeUfxsnqV3PndswIPKRUKIfSjOBBtiJhKoHLac=;
        b=tPY41C2/a66322xWriux6uNobtu3lqgtsb6ikdwLrP53xt+SVOlQlYidAZiJlPqljp
         uVTK82go0lBP4z+QAwlYOBBKI0ym5ukPk9COKDFx/gP+yeFvshgFKyJUCgYHONGU35+O
         Lp0jvlqfYkBkndbc8ZyjUVE5y6qoWSw4bQ2jPA+lRfe+CPRJgUlJ5Tal36kkmm2FhmIh
         LwHRUgj1ffruA3ujuwSBUSTytakGw6QK+MVdHa0djKmBZXL3m1ySRAtjMdAtSBOKN8yS
         CVBXiEePecAEAcTgJWPHQHi2NOtjH1VZ7Q6JvoQI8UOr7v8IBAvi+3eeIWS9wFJj0tF+
         gqew==
X-Gm-Message-State: AHYfb5hiJ7lwUYSBqbRIJt9IUd9Lpne0lOpZBg+oFTAVCFHjP5dBtWu4
        qy5Iou3fSDx7Txd/tuublA==
X-Received: by 10.99.97.129 with SMTP id v123mr5835948pgb.337.1502241807236;
        Tue, 08 Aug 2017 18:23:27 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([100.96.218.24])
        by smtp.gmail.com with ESMTPSA id r5sm4479602pgn.45.2017.08.08.18.23.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 08 Aug 2017 18:23:26 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com,
        sbeller@google.com
Subject: [PATCH v2 22/25] pack: move find_pack_entry() and make it global
Date:   Tue,  8 Aug 2017 18:22:54 -0700
Message-Id: <3de1263395e5186044b5f8a715ae8b8e59d9ba97.1502241234.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.14.0.434.g98096fd7a8-goog
In-Reply-To: <cover.1502241234.git.jonathantanmy@google.com>
References: <cover.1502241234.git.jonathantanmy@google.com>
In-Reply-To: <cover.1502241234.git.jonathantanmy@google.com>
References: <cover.1502220307.git.jonathantanmy@google.com> <cover.1502241234.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This function needs to be global as it is used by sha1_file.c and will
be used by packfile.c.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 pack.h      |  2 ++
 packfile.c  | 53 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 sha1_file.c | 53 -----------------------------------------------------
 3 files changed, 55 insertions(+), 53 deletions(-)

diff --git a/pack.h b/pack.h
index 0517d6542..1021a781c 100644
--- a/pack.h
+++ b/pack.h
@@ -221,4 +221,6 @@ extern int is_pack_valid(struct packed_git *);
 extern struct packed_git *find_sha1_pack(const unsigned char *sha1,
 					 struct packed_git *packs);
 
+extern int find_pack_entry(const unsigned char *sha1, struct pack_entry *e);
+
 #endif
diff --git a/packfile.c b/packfile.c
index f16b56262..0f1e3338b 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1796,3 +1796,56 @@ struct packed_git *find_sha1_pack(const unsigned char *sha1,
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
diff --git a/sha1_file.c b/sha1_file.c
index 229358663..1a505eae5 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1073,59 +1073,6 @@ int parse_sha1_header(const char *hdr, unsigned long *sizep)
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
2.14.0.434.g98096fd7a8-goog

