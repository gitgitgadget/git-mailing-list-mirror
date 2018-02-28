Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C12DC1F404
	for <e@80x24.org>; Wed, 28 Feb 2018 01:06:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751906AbeB1BGk (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Feb 2018 20:06:40 -0500
Received: from mail-pl0-f68.google.com ([209.85.160.68]:35572 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751631AbeB1BG3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Feb 2018 20:06:29 -0500
Received: by mail-pl0-f68.google.com with SMTP id bb3-v6so503004plb.2
        for <git@vger.kernel.org>; Tue, 27 Feb 2018 17:06:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xQk16MRp7Gp4hEhC4Qu0p6Tj69APVnE89RgIf9x8IvQ=;
        b=SXtGsiWvNmYp7V8Jncl6Qi2fwZL8F5Ipjjru0RjGhInTjvlp99k+Vn5tvLiulZHvTP
         +2xIjcR3P7IA/IqjKnMWm1JH5fw1Xfkhv3CW8MyaT07sVLn0FVdxhDBFXykWDbe83VAZ
         Ao0h575fAPiL9zrc5DZi364VRxz9tmYquCkxwLJAWI8oULs11VHBa3x8kkpKluAC13+F
         je4Y+vVjWPVypD3SlP2nFlT2WbMdQhjatrZBbiK5qh6K2Uh02JYxItbBPBynmvM62Jo7
         ZBpCh88Syp9BBBssIr07mEJ32UiFpklnFkS9BeJ5LV/NtUoAiMP0aa2TJDEGYITHKLCC
         0lHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xQk16MRp7Gp4hEhC4Qu0p6Tj69APVnE89RgIf9x8IvQ=;
        b=ipB6doapyNDBMfuWfZ5o9dUW/Oy9P7EWLmU+h8puWd5PqAI0EzKlI6vGjtNQa/iG6a
         VTCUQO0GnJ0Rv76JAeqB6rcH0HS9zBVvQPleOODQJwSwtV051nwViDPvkiyAQUyENG+e
         Sh+GvVkCqGSPgbu3xGyb/7Px2zmEsI6Iu48T7bi8qp+NDI2JE/vg2unyvzSoTk91hE8v
         yzJ5yTV9QOJa2JgY0Lzo4gcEa6WrKYE7jlH9g0ahFngar4WBdjfwZy8eRyQvX2fffioB
         mSDQXfbJzbWgKPHaXwnBP0ALHfdVMunXVvIVHB5AWaf0Zf/qn7wPloU43UNd0335SYy0
         2adg==
X-Gm-Message-State: APf1xPAQnn0uH9x0yKARU3i4gx7Qpo3HyC0iQqhjjk9Q041/GmyDSAB6
        BqJwBhOYwesjxJVvZec+9Ly6B6FxW5o=
X-Google-Smtp-Source: AH8x224xiKr3hlHRIu/bnOIaRqhfXKFR+MU+fcBC9FzKcIKMpdpk2HjKKfybHVJDDRmrvPHseenBqQ==
X-Received: by 2002:a17:902:ba95:: with SMTP id k21-v6mr16411002pls.111.1519779988134;
        Tue, 27 Feb 2018 17:06:28 -0800 (PST)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id j64sm525082pfe.68.2018.02.27.17.06.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 27 Feb 2018 17:06:27 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     pclouds@gmail.com, Stefan Beller <sbeller@google.com>
Subject: [PATCH 10/11] packfile: add repository argument to find_pack_entry
Date:   Tue, 27 Feb 2018 17:06:07 -0800
Message-Id: <20180228010608.215505-11-sbeller@google.com>
X-Mailer: git-send-email 2.16.2.395.g2e18187dfd-goog
In-Reply-To: <20180228010608.215505-1-sbeller@google.com>
References: <20180228010608.215505-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

While at it move the documentation to the header and mention which pack
files are searched.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 packfile.c  | 8 ++------
 packfile.h  | 7 ++++++-
 sha1_file.c | 6 +++---
 3 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/packfile.c b/packfile.c
index b12fc0789e0..e16f8252233 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1835,11 +1835,7 @@ static int fill_pack_entry(const unsigned char *sha1,
 	return 1;
 }
 
-/*
- * Iff a pack file contains the object named by sha1, return true and
- * store its location to e.
- */
-int find_pack_entry(const unsigned char *sha1, struct pack_entry *e)
+int find_pack_entry_the_repository(const unsigned char *sha1, struct pack_entry *e)
 {
 	struct list_head *pos;
 
@@ -1860,7 +1856,7 @@ int find_pack_entry(const unsigned char *sha1, struct pack_entry *e)
 int has_sha1_pack(const unsigned char *sha1)
 {
 	struct pack_entry e;
-	return find_pack_entry(sha1, &e);
+	return find_pack_entry(the_repository, sha1, &e);
 }
 
 int has_pack_index(const unsigned char *sha1)
diff --git a/packfile.h b/packfile.h
index 99f4741bd95..feeabd6f031 100644
--- a/packfile.h
+++ b/packfile.h
@@ -120,7 +120,12 @@ extern int packed_object_info(struct packed_git *pack, off_t offset, struct obje
 extern void mark_bad_packed_object(struct packed_git *p, const unsigned char *sha1);
 extern const struct packed_git *has_packed_and_bad(const unsigned char *sha1);
 
-extern int find_pack_entry(const unsigned char *sha1, struct pack_entry *e);
+/*
+ * Iff a pack file in the given repository contains the object named by sha1,
+ * return true and store its location to e.
+ */
+#define find_pack_entry(r, s, e) find_pack_entry_##r(s, e)
+extern int find_pack_entry_the_repository(const unsigned char *sha1, struct pack_entry *e);
 
 extern int has_sha1_pack(const unsigned char *sha1);
 
diff --git a/sha1_file.c b/sha1_file.c
index 0b9fefaaf02..d498b3e90b9 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1273,7 +1273,7 @@ int sha1_object_info_extended(const unsigned char *sha1, struct object_info *oi,
 	}
 
 	while (1) {
-		if (find_pack_entry(real, &e))
+		if (find_pack_entry(the_repository, real, &e))
 			break;
 
 		/* Most likely it's a loose object. */
@@ -1282,7 +1282,7 @@ int sha1_object_info_extended(const unsigned char *sha1, struct object_info *oi,
 
 		/* Not a loose object; someone else may have just packed it. */
 		reprepare_packed_git(the_repository);
-		if (find_pack_entry(real, &e))
+		if (find_pack_entry(the_repository, real, &e))
 			break;
 
 		/* Check if it is a missing object */
@@ -1662,7 +1662,7 @@ static int freshen_loose_object(const unsigned char *sha1)
 static int freshen_packed_object(const unsigned char *sha1)
 {
 	struct pack_entry e;
-	if (!find_pack_entry(sha1, &e))
+	if (!find_pack_entry(the_repository, sha1, &e))
 		return 0;
 	if (e.p->freshened)
 		return 1;
-- 
2.16.2.395.g2e18187dfd-goog

