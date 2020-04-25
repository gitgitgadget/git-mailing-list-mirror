Return-Path: <SRS0=d/2q=6J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DA3BC2BA1A
	for <git@archiver.kernel.org>; Sat, 25 Apr 2020 03:00:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E809420776
	for <git@archiver.kernel.org>; Sat, 25 Apr 2020 03:00:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KoTxeIIn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726108AbgDYDAt (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Apr 2020 23:00:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726061AbgDYDAt (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 24 Apr 2020 23:00:49 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AE1FC09B049
        for <git@vger.kernel.org>; Fri, 24 Apr 2020 20:00:49 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id x26so5555668pgc.10
        for <git@vger.kernel.org>; Fri, 24 Apr 2020 20:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=3xvR/WkJJMhFTkttGE5FSKsYRrQqt1XhV9esX837F9E=;
        b=KoTxeIInzo9+0pDeqgNJuOsDz2ZdDUdQjZT6sXoX3cNy3DpRq+drbduU3q1ciyQSG7
         CkbCQ/tL2Sgh9k/qWQk67UeNWce7rpUXP/J6FCEnw+C4beTZHfjxh2OG+Nyvxqc7gr3k
         GF1FHs2EvgQjUzvljjmi8/HtCW8CTWWfKkGcU2wjLH0548ztTtVBRHf56fFQMIqeEQ3m
         U41+q5d+B04n0VEbzwSaOYKZJZYVB2PVinxYZLF4CC8mYsuCu6MNxwvf8JzqV2yn4Vin
         jF+NimRBo6pcRz2pz2DAulu0TU4J/lzbrR7OshwakqSGz17BsHgFTUs1EB4TAfcceNlc
         4K8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3xvR/WkJJMhFTkttGE5FSKsYRrQqt1XhV9esX837F9E=;
        b=uBDrP5PORnfL5cSsedV3ZsaQYMQifbCpOnHZtGVqtaCC7z6W/HLccL+dCtzihsld9m
         cO13rDMRzLhepuxa+4pcXvcPejh85mlitRq8q+wnVaZDBI+9Z6bk28WCsb7+N5H0WcJS
         nSvM6AfFxfplCPM2npwKA2cZ9dR3M7CygjjRbu7pNcuBU66QUxJGoDzIxy7ks1I85SQ3
         aEpW3DzSVUqqx5v3pOPSJl6E9Eoouwx1zTgkzo5bplifdB0KLP8j+gOpUqowYNcRBUqs
         UQ8J1VKGZ4aPu3BZ/aRpFugTTx6ozY13FRQ87q64GOVZHN49qqlp5hpdeX4RjLccw/x8
         2RuQ==
X-Gm-Message-State: AGi0PuYxlySwdwVMTYkl7PQAgGElDR6oocQt4Bw76wLK8gyIbl781wDq
        3my05b890jbxG8gVFt9qeoMIm2TlueU=
X-Google-Smtp-Source: APiQypKviHvG5DBEAPjZ/t6j8hYDlP53wr+YXCOydicdYJIbfGp/+tGnj+NLF6U718Mo154YhAP6uA==
X-Received: by 2002:a63:6c83:: with SMTP id h125mr12930428pgc.168.1587783648151;
        Fri, 24 Apr 2020 20:00:48 -0700 (PDT)
Received: from localhost.localdomain ([2409:4064:79a:d9e8:1f9e:c3b5:9fc6:c4b2])
        by smtp.gmail.com with ESMTPSA id f99sm5990992pjg.22.2020.04.24.20.00.45
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2020 20:00:47 -0700 (PDT)
From:   Abhishek Kumar <abhishekkumar8222@gmail.com>
To:     git@vger.kernel.org
Subject: [PATCH v3 2/3] oidmap: rework iterators to return typed pointer
Date:   Sat, 25 Apr 2020 08:29:20 +0530
Message-Id: <20200425025921.1397-2-abhishekkumar8222@gmail.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200425025921.1397-1-abhishekkumar8222@gmail.com>
References: <20200408040659.14511-1-abhishekkumar8222@gmail.com>
 <20200425025921.1397-1-abhishekkumar8222@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

87571c3f (hashmap: use *_entry APIs for iteration, 2019-10-06) modified
hashmap_iter_next() to return a hashmap_entry pointer instead of void
pointer.

However, oidmap_iter_next() is unaware of the struct type containing
oidmap_entry and explicitly returns a void pointer.

Rewrite oidmap_iter_next() to return oidmap_entry pointer and add
helper macros to return pointers to container struct.

Signed-off-by: Abhishek Kumar <abhishekkumar8222@gmail.com>
---
 oidmap.h               | 41 +++++++++++++++++++++++++++++++++++------
 t/helper/test-oidmap.c |  7 ++++---
 2 files changed, 39 insertions(+), 9 deletions(-)

diff --git a/oidmap.h b/oidmap.h
index c66a83ab1d..d79b087ab0 100644
--- a/oidmap.h
+++ b/oidmap.h
@@ -66,6 +66,8 @@ void *oidmap_put(struct oidmap *map, void *entry);
  */
 void *oidmap_remove(struct oidmap *map, const struct object_id *key);
 
+#define oidmap_entry_from_hashmap_entry(entry) \
+	container_of_or_null(entry, struct oidmap_entry, internal_entry)
 
 struct oidmap_iter {
 	struct hashmap_iter h_iter;
@@ -76,18 +78,45 @@ static inline void oidmap_iter_init(struct oidmap *map, struct oidmap_iter *iter
 	hashmap_iter_init(&map->map, &iter->h_iter);
 }
 
-static inline void *oidmap_iter_next(struct oidmap_iter *iter)
+/* Returns the next oidmap_entry, or NULL if there are no more entries. */
+static inline struct oidmap_entry *oidmap_iter_next(struct oidmap_iter *iter)
 {
-	/* TODO: this API could be reworked to do compile-time type checks */
-	return (void *)hashmap_iter_next(&iter->h_iter);
+	return oidmap_entry_from_hashmap_entry(
+			hashmap_iter_next(&iter->h_iter));
 }
 
-static inline void *oidmap_iter_first(struct oidmap *map,
+/* Initializes the iterator and returns the first entry, if any. */
+static inline struct oidmap_entry *oidmap_iter_first(struct oidmap *map,
 				      struct oidmap_iter *iter)
 {
 	oidmap_iter_init(map, iter);
-	/* TODO: this API could be reworked to do compile-time type checks */
-	return (void *)oidmap_iter_next(iter);
+	return oidmap_iter_next(iter);
 }
 
+/*
+ * Returns the first entry in @map using @iter, where the entry if of
+ * @type (e.g. "struct foo") and @member is the name of the
+ * "struct oidmap_entry" in @type
+ */
+#define oidmap_iter_first_entry(map, iter, type, member) \
+	container_of_or_null(oidmap_iter_first(map, iter), type, member)
+
+/* Internal macro for oidmap_for_each_entry */
+#define oidmap_iter_next_entry_offset(iter, offset) \
+	container_of_or_null_offset(oidmap_iter_next(iter), offset)
+
+/* Internal macro for oidmap_for_each_entry */
+#define oidmap_iter_first_entry_offset(map, iter, offset) \
+	container_of_or_null_offset(oidmap_iter_first(map, iter), offset)
+
+/*
+ * Iterate through @map using @iter, @var is a pointer to a type
+ * containing a @member which is a "struct oidmap_entry"
+ */
+#define oidmap_for_each_entry(map, iter, var, member) \
+	for (var = oidmap_iter_first_entry_offset(map, iter, \
+						OFFSETOF_VAR(var, member)); \
+		var; \
+		var = oidmap_iter_next_entry_offset(iter, \
+						OFFSETOF_VAR(var, member)))
 #endif
diff --git a/t/helper/test-oidmap.c b/t/helper/test-oidmap.c
index 0acf99931e..3f599b21b8 100644
--- a/t/helper/test-oidmap.c
+++ b/t/helper/test-oidmap.c
@@ -95,9 +95,10 @@ int cmd__oidmap(int argc, const char **argv)
 		} else if (!strcmp("iterate", cmd)) {
 
 			struct oidmap_iter iter;
-			oidmap_iter_init(&map, &iter);
-			while ((entry = oidmap_iter_next(&iter)))
-				printf("%s %s\n", oid_to_hex(&entry->entry.oid), entry->name);
+			struct test_entry *ent;
+
+			oidmap_for_each_entry(&map, &iter, ent, entry)
+				printf("%s %s\n", oid_to_hex(&ent->entry.oid), ent->name);
 
 		} else {
 
-- 
2.26.0

