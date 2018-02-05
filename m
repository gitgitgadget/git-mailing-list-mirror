Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3118A1F404
	for <e@80x24.org>; Tue,  6 Feb 2018 00:02:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752058AbeBFAB5 (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 19:01:57 -0500
Received: from mail-pl0-f65.google.com ([209.85.160.65]:46398 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751956AbeBFAB4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 19:01:56 -0500
Received: by mail-pl0-f65.google.com with SMTP id 36so82421ple.13
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 16:01:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bqJ2YAx8+rN1BRg0B9ObsSQlFSAED1MABaneomkYXCA=;
        b=QQesWX3EHHN4r7puW0StWx7gSzv3f7dLjwrJKkJlsuesGXfuY0K1iwLvU8oOd0RS+B
         +EYg/aXjTeH1sKVRxLoXjMUoLQ31EOw1/YE+5DC+hw2oYEleACI8io2WQfzYvz1EP3AJ
         kXySZ+T8l/AUb4J/fTGfDtixBSR2+cr5BO28HH9KEgT/5FeCOX5O4RFO12Zq7jO2q2KF
         ad+wVi8fRzZTgnwIR9KuIyMgq4WQdSBMGyGv1A8VK9Vb22G1AZKORmrPtOWKjY/E0eHW
         BaG8RifnfM3uA1UlgDGMzct5sp8z0SxLE23ojfXOqKAPyDYBYhCpeL/LYhQEFPKjsqrO
         MSrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bqJ2YAx8+rN1BRg0B9ObsSQlFSAED1MABaneomkYXCA=;
        b=f90aQgXNWnwLtnx9Dz4MfbW5fouyUIG6l3BwI5KIIis2oE+YZbTbpFNgKzA573sJqg
         dg2y1NO7RLiLDhbLIyOGrZpy1XcxzeF1dQNqFDArDPnl5T1e106+urhQduJEjGn8O1gC
         QpQy3B4Gap0oqWcfYdzZO8oc3UkTvd9wxk9vvCBS9EeIBaxTH3kRGDDN+sC79oCK5ElN
         kvcFcDDtEMkbheJ2U1FdKKI103CZ+ZaqK7AispmnqrjoFcdwKhO2kXAjejD05r1rp14S
         kwYbPtuf/AmIx+DPy/+sY+EGIbx+xm4/FuwDEtXVMv92NfXFpCYX3gkUNI1e4LVpysDL
         IQcA==
X-Gm-Message-State: APf1xPD9AWLt1ea7y+S2KJ9gMLHCgxQpxAIyGNWTAlNe256Ag2RvCTEH
        2DpDbwkmXKH+gDw9Usy/rtr9xbcFLzo=
X-Google-Smtp-Source: AH8x225bVffyGlRHwRSA8tzZSCux7F9RhmPjR2Nx07WYIOc5gr3kQWxrxpQz0aCfhAkSUSz8+T6aeQ==
X-Received: by 2002:a17:902:6ec5:: with SMTP id l5-v6mr486359pln.443.1517875315015;
        Mon, 05 Feb 2018 16:01:55 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id 65sm19852527pfm.152.2018.02.05.16.01.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Feb 2018 16:01:54 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 040/194] replace-object: move replace_object to object store
Date:   Mon,  5 Feb 2018 15:55:01 -0800
Message-Id: <20180205235735.216710-20-sbeller@google.com>
X-Mailer: git-send-email 2.15.1.433.g936d1b9894.dirty
In-Reply-To: <20180205235735.216710-1-sbeller@google.com>
References: <20180205235508.216277-1-sbeller@google.com>
 <20180205235735.216710-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Refs belong to particular repositories, so the replacements defined by them
should belong to a particular repository as well.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 object-store.h   |  9 ++++++++-
 replace-object.c | 42 ++++++++++++++++++------------------------
 replace-object.h | 20 ++++++++++++++++++++
 3 files changed, 46 insertions(+), 25 deletions(-)
 create mode 100644 replace-object.h

diff --git a/object-store.h b/object-store.h
index 57b8d89738..298e34e978 100644
--- a/object-store.h
+++ b/object-store.h
@@ -3,6 +3,7 @@
 
 #include "cache.h"
 #include "mru.h"
+#include "replace-object.h"
 
 struct object_store {
 	struct packed_git *packed_git;
@@ -16,6 +17,12 @@ struct object_store {
 	struct alternate_object_database *alt_odb_list;
 	struct alternate_object_database **alt_odb_tail;
 
+	/*
+	 * Objects that should be substituted by other objects
+	 * (see git-replace(1)).
+	 */
+	struct replace_objects replacements;
+
 	/*
 	 * A fast, rough count of the number of objects in the repository.
 	 * These two fields are not meant for direct access. Use
@@ -30,7 +37,7 @@ struct object_store {
 	 */
 	unsigned packed_git_initialized : 1;
 };
-#define OBJECT_STORE_INIT { NULL, MRU_INIT, NULL, NULL, 0, 0, 0 }
+#define OBJECT_STORE_INIT { NULL, MRU_INIT, NULL, NULL, REPLACE_OBJECTS_INIT, 0, 0, 0 }
 
 struct packed_git {
 	struct packed_git *next;
diff --git a/replace-object.c b/replace-object.c
index f0b39f06d5..d26e180639 100644
--- a/replace-object.c
+++ b/replace-object.c
@@ -1,19 +1,10 @@
 #include "cache.h"
+#include "replace-object.h"
 #include "sha1-lookup.h"
 #include "refs.h"
+#include "repository.h"
 #include "commit.h"
 
-/*
- * An array of replacements.  The array is kept sorted by the original
- * sha1.
- */
-static struct replace_object {
-	unsigned char original[20];
-	unsigned char replacement[20];
-} **replace_object;
-
-static int replace_object_alloc, replace_object_nr;
-
 static const unsigned char *replace_sha1_access(size_t index, void *table)
 {
 	struct replace_object **replace = table;
@@ -22,7 +13,8 @@ static const unsigned char *replace_sha1_access(size_t index, void *table)
 
 static int replace_object_pos(const unsigned char *sha1)
 {
-	return sha1_pos(sha1, replace_object, replace_object_nr,
+	return sha1_pos(sha1, the_repository->objects.replacements.items,
+			the_repository->objects.replacements.nr,
 			replace_sha1_access);
 }
 
@@ -35,20 +27,22 @@ static int register_replace_object(struct replace_object *replace,
 		if (ignore_dups)
 			free(replace);
 		else {
-			free(replace_object[pos]);
-			replace_object[pos] = replace;
+			free(the_repository->objects.replacements.items[pos]);
+			the_repository->objects.replacements.items[pos] = replace;
 		}
 		return 1;
 	}
 	pos = -pos - 1;
-	ALLOC_GROW(replace_object, replace_object_nr + 1, replace_object_alloc);
-	replace_object_nr++;
-	if (pos < replace_object_nr)
-		memmove(replace_object + pos + 1,
-			replace_object + pos,
-			(replace_object_nr - pos - 1) *
-			sizeof(*replace_object));
-	replace_object[pos] = replace;
+	ALLOC_GROW(the_repository->objects.replacements.items,
+		   the_repository->objects.replacements.nr + 1,
+		   the_repository->objects.replacements.alloc);
+	the_repository->objects.replacements.nr++;
+	if (pos < the_repository->objects.replacements.nr)
+		memmove(the_repository->objects.replacements.items + pos + 1,
+			the_repository->objects.replacements.items + pos,
+			(the_repository->objects.replacements.nr - pos - 1) *
+			sizeof(*the_repository->objects.replacements.items));
+	the_repository->objects.replacements.items[pos] = replace;
 	return 0;
 }
 
@@ -86,7 +80,7 @@ static void prepare_replace_object(void)
 
 	for_each_replace_ref(register_replace_ref, NULL);
 	replace_object_prepared = 1;
-	if (!replace_object_nr)
+	if (!the_repository->objects.replacements.nr)
 		check_replace_refs = 0;
 }
 
@@ -115,7 +109,7 @@ const unsigned char *do_lookup_replace_object(const unsigned char *sha1)
 
 		pos = replace_object_pos(cur);
 		if (0 <= pos)
-			cur = replace_object[pos]->replacement;
+			cur = the_repository->objects.replacements.items[pos]->replacement;
 	} while (0 <= pos);
 
 	return cur;
diff --git a/replace-object.h b/replace-object.h
new file mode 100644
index 0000000000..483335ffcc
--- /dev/null
+++ b/replace-object.h
@@ -0,0 +1,20 @@
+#ifndef REPLACE_OBJECT_H
+#define REPLACE_OBJECT_H
+
+struct replace_objects {
+	/*
+	 * An array of replacements.  The array is kept sorted by the original
+	 * sha1.
+	 */
+	struct replace_object **items;
+
+	int alloc, nr;
+};
+#define REPLACE_OBJECTS_INIT { NULL, 0, 0 }
+
+struct replace_object {
+	unsigned char original[20];
+	unsigned char replacement[20];
+};
+
+#endif /* REPLACE_OBJECT_H */
-- 
2.15.1.433.g936d1b9894.dirty

