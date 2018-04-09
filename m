Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 66DDD1F404
	for <e@80x24.org>; Mon,  9 Apr 2018 22:45:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751881AbeDIWpp (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Apr 2018 18:45:45 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:39714 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750982AbeDIWpn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Apr 2018 18:45:43 -0400
Received: by mail-pl0-f68.google.com with SMTP id e7-v6so4084656plt.6
        for <git@vger.kernel.org>; Mon, 09 Apr 2018 15:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wbOzKaKdpQvTDzKg23kVjEXHMBeWQM/9ipDlVzRfsr4=;
        b=PU34qcQm+wcPHvRDl64M7/SuaAe6avZWru6iT5MR5znVCuA1Bwx1X8axyflXCzU7Wb
         YvbL/0qn7+q+7VhKjBZ4yEzpTVDvT+yCjnXN5ilEwgsrumVh6bRIpDnAxI0BtdHA+h+d
         8QSsCCjc9ikVulUMlV1HMMyXj62kh2LjrRWk3eFqPJ/zlNcwiDiS3nPDUP6GKuvkmJml
         ZguPA6k2Y/s3ugxMAG6kUdOozrz05qmK7RfEQB+QIr/wMR8UlrJJIafGTBYx8HJza7bU
         32CoFnUX53LnjTSdCAPTsQ5QUh6AuiFIdihTCwACQsPS7rnlzrH8/JgHzPagkhnMF6So
         AK7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wbOzKaKdpQvTDzKg23kVjEXHMBeWQM/9ipDlVzRfsr4=;
        b=BdBllgGTWFCSMTapSLDxIz3tSVWmP9Ofqivp5VW/aj1sp+WmnfK6Fx8tjnfwlFcAlM
         Rtlf15AFuDuWOgsO+iePwqc5MAworo34zGZuVli0ydUEnN7fkrMV18wWMTrk/iec+A2+
         wNdQK50EPoC4APe4veN2TG6C5OICbzPGeQe9TTfC9HHXLiqYy8YTpIjHR2TYbJ0gjx/Y
         ZKnOVTskjBCypHi+8DagHf+IdQ7dSWLwH0yzZdEwv/8k4bY6s+OM5qBsTjIH8JtXKM8K
         A4j9enPDs9UbPd7QTKM1+U5y3bEqriIkWNP7qjNIB6vd54CIWxCWbYIfYhzZ2GqvsIJp
         J/Cw==
X-Gm-Message-State: ALQs6tBF/WOU0i3CZkKD8TlpLJIDdjEUWau9pZ7WPNx/w5fogX2N/N3h
        tiuUBVWzOZD4yctrCTDmj2Bk2w==
X-Google-Smtp-Source: AIpwx4+RrIrO9GaROv2QxtYDuReAzghSTefhrQ3fakzq/JRLz42iBQpoXE0eP7lCzeWMdv3WiI0DGA==
X-Received: by 2002:a17:902:be07:: with SMTP id r7-v6mr6566585pls.337.1523313942262;
        Mon, 09 Apr 2018 15:45:42 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id 27sm2578241pfo.137.2018.04.09.15.45.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 09 Apr 2018 15:45:41 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, jonathantanmy@google.com,
        sunshine@sunshineco.com, pclouds@gmail.com, l.s.r@web.de,
        sandals@crustytoothpaste.net
Subject: [PATCH 03/16] replace-object: move replace_map to object store
Date:   Mon,  9 Apr 2018 15:45:20 -0700
Message-Id: <20180409224533.17764-4-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.484.g0c8726318c-goog
In-Reply-To: <20180409224533.17764-1-sbeller@google.com>
References: <20180406232136.253950-1-sbeller@google.com>
 <20180409224533.17764-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 object-store.h   |  8 ++++++++
 replace-object.c | 17 +++++++----------
 replace-object.h |  9 +++++++++
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
diff --git a/replace-object.c b/replace-object.c
index a757a5ebf2..afbdf2df25 100644
--- a/replace-object.c
+++ b/replace-object.c
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
-- 
2.17.0.484.g0c8726318c-goog

