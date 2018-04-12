Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 867831F42D
	for <e@80x24.org>; Thu, 12 Apr 2018 00:21:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752594AbeDLAVc (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Apr 2018 20:21:32 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:33674 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752500AbeDLAV3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Apr 2018 20:21:29 -0400
Received: by mail-pl0-f67.google.com with SMTP id w12-v6so1694018plp.0
        for <git@vger.kernel.org>; Wed, 11 Apr 2018 17:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pz1RzmKFV1MPiP3Jp6eeEfcyGbC/fYNyYH9zY2IfOKg=;
        b=aeS+KUiUEbqsNjDdTIAXqKlS1f2T4IJ0fKdfl3UUw2Yf6Qc8Pq0L5sQJLt3EBMJhtl
         QnL/egPGz9ak15CakCWdGdkpLc3XCKbksAmE55aLb8GDbSmi1ipgkLdjfowAuVPgb3LL
         OTI+XWBq5CPJnPdW+6TCkz6WpUqJTTROFQ3LSwSoCZ1MtFgGVgIk30Ibs1xz5tO9oFW0
         DhuhYsOwFhjrcdIUFH1C1O0b7vHKkcIImklfBNLNytYPijVNQt9vBie/RWsA2z8dEinb
         94VsMgP3SYTfTnloaCiMNPUlWDzMwMLtmyqh2NS84T7dIZDjczq3dPIu43yRR5Aq8EB/
         Kb6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pz1RzmKFV1MPiP3Jp6eeEfcyGbC/fYNyYH9zY2IfOKg=;
        b=Th0RPcXSpsmmHk28N/dJxOeQ53h5Qp9quQ0/Ju5ODuM8drhnVeWcyuZDMydFpYCcHS
         uHVwr54Jmvb5gRFbcpJ8Z+l2PGE0iWjJh90/Bpi5ChdKYByG5GEQOKUBsoMt6GjIaho+
         KCIDvJlrPX+cGFa6+8+QLnDMCRsrZmku/18evcPw0GaKoX4H0d78wxcVa3fPjCJDT83b
         9Xzi3OMXrTRB5NyLskaMG8qH3ziJXFJfYnZNCBliszXgsqzx0v4BIx0qC5j25Bsgndve
         IJ2LJHpbZ711MDf30oEqpaNiqRl9wPlt1GGV9fTqdERBxfYGmTSE+39Gyed20ir11EFT
         AOqg==
X-Gm-Message-State: ALQs6tAZYCWzs4vK9IjmUAcH3Nj52D31B3Jxfy25oPlAAh7EzjnU4bw5
        kgfpO6v15th6mNDWlgJei70QPGYbw7E=
X-Google-Smtp-Source: AIpwx4/VJChtw+U4BUWL5SQctC48Y+qjSt/YedcaK/s5mabsasHc6sP+7JpHcQlb9R0R8/D782B7EQ==
X-Received: by 2002:a17:902:8f94:: with SMTP id z20-v6mr7338073plo.174.1523492487805;
        Wed, 11 Apr 2018 17:21:27 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id l26sm5455936pfj.70.2018.04.11.17.21.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 11 Apr 2018 17:21:27 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, jonathantanmy@google.com, l.s.r@web.de,
        pclouds@gmail.com, sandals@crustytoothpaste.net,
        sunshine@sunshineco.com
Subject: [PATCH 02/15] replace-object: move replace_map to object store
Date:   Wed, 11 Apr 2018 17:21:05 -0700
Message-Id: <20180412002118.102976-3-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.484.g0c8726318c-goog
In-Reply-To: <20180412002118.102976-1-sbeller@google.com>
References: <20180409224533.17764-1-sbeller@google.com>
 <20180412002118.102976-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The relationship between an object X and another object Y that
replaces the object X is defined only within the scope of a
single repository.

The exception in reachability rule around these replacement objects
is also local to a repository (i.e. if traversal from refs reaches
X, then both X and Y are reachable and need to be kept from gc).

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 object-store.h   |  8 ++++++++
 replace-object.h |  9 +++++++++
 replace_object.c | 17 +++++++----------
 3 files changed, 24 insertions(+), 10 deletions(-)
 create mode 100644 replace-object.h

diff --git a/object-store.h b/object-store.h
index fef33f345f..c04b4c95eb 100644
--- a/object-store.h
+++ b/object-store.h
@@ -1,6 +1,8 @@
 #ifndef OBJECT_STORE_H
 #define OBJECT_STORE_H
 
+#include "oidmap.h"
+
 struct alternate_object_database {
 	struct alternate_object_database *next;
 
@@ -93,6 +95,12 @@ struct raw_object_store {
 	struct alternate_object_database *alt_odb_list;
 	struct alternate_object_database **alt_odb_tail;
 
+	/*
+	 * Objects that should be substituted by other objects
+	 * (see git-replace(1)).
+	 */
+	struct oidmap replace_map;
+
 	/*
 	 * private data
 	 *
diff --git a/replace-object.h b/replace-object.h
new file mode 100644
index 0000000000..f9a2b70eb8
--- /dev/null
+++ b/replace-object.h
@@ -0,0 +1,9 @@
+#ifndef REPLACE_OBJECT_H
+#define REPLACE_OBJECT_H
+
+struct replace_object {
+	struct oidmap_entry original;
+	struct object_id replacement;
+};
+
+#endif /* REPLACE_OBJECT_H */
diff --git a/replace_object.c b/replace_object.c
index a757a5ebf2..afbdf2df25 100644
--- a/replace_object.c
+++ b/replace_object.c
@@ -1,15 +1,11 @@
 #include "cache.h"
 #include "oidmap.h"
+#include "object-store.h"
+#include "replace-object.h"
 #include "refs.h"
+#include "repository.h"
 #include "commit.h"
 
-struct replace_object {
-	struct oidmap_entry original;
-	struct object_id replacement;
-};
-
-static struct oidmap replace_map = OIDMAP_INIT;
-
 static int register_replace_ref(const char *refname,
 				const struct object_id *oid,
 				int flag, void *cb_data)
@@ -29,7 +25,7 @@ static int register_replace_ref(const char *refname,
 	oidcpy(&repl_obj->replacement, oid);
 
 	/* Register new object */
-	if (oidmap_put(&replace_map, repl_obj))
+	if (oidmap_put(&the_repository->objects->replace_map, repl_obj))
 		die("duplicate replace ref: %s", refname);
 
 	return 0;
@@ -44,7 +40,7 @@ static void prepare_replace_object(void)
 
 	for_each_replace_ref(register_replace_ref, NULL);
 	replace_object_prepared = 1;
-	if (!replace_map.map.tablesize)
+	if (!the_repository->objects->replace_map.map.tablesize)
 		check_replace_refs = 0;
 }
 
@@ -67,7 +63,8 @@ const struct object_id *do_lookup_replace_object(const struct object_id *oid)
 
 	/* Try to recursively replace the object */
 	while (depth-- > 0) {
-		struct replace_object *repl_obj = oidmap_get(&replace_map, cur);
+		struct replace_object *repl_obj =
+			oidmap_get(&the_repository->objects->replace_map, cur);
 		if (!repl_obj)
 			return cur;
 		cur = &repl_obj->replacement;
-- 
2.17.0.484.g0c8726318c-goog

