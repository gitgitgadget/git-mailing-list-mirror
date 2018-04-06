Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 894871F404
	for <e@80x24.org>; Fri,  6 Apr 2018 23:21:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751645AbeDFXV4 (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Apr 2018 19:21:56 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:43226 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751534AbeDFXVx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Apr 2018 19:21:53 -0400
Received: by mail-pf0-f193.google.com with SMTP id j2so1789259pff.10
        for <git@vger.kernel.org>; Fri, 06 Apr 2018 16:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=h0lWC1riSYJd9XE+F12CFWGVGV59EuLeo48nCLQpviI=;
        b=GaaqkPuvULkxFb/d+QSO6LGQwdNUSlfowtzXV6BttTODpZAz0OqmJx+t4Ue7C+aytx
         dHfxM3oWguVD/dIS0jA4iEyzSs+AJ469/FtBxZO2AQDDJOhod/jOMzVZZNvpWdTGM1nK
         MvOmodPRddYL2INXcLCcB0zYl3qvnJazq95DbAjwUp1LPTdWwS5ogcxYaoUy8am7fioC
         DH3NFxmeRrsSrKaetq7tsnn5T8pCedsTUex10EINPifjsocDZouZiY4aGknSbIt7LlO6
         s2J37A0nv3nf7S834Qc9CarRkUiJE5JOZgSc9GHGqtgOgKATzxZO3KPH831c9z3NHD9h
         z9aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=h0lWC1riSYJd9XE+F12CFWGVGV59EuLeo48nCLQpviI=;
        b=SpizcgCqjC2L0SohB0DnGRKePgf8H5SvsA4NHCBduv8mnPPPUtFLsRnDRVNLdNanVa
         aBV46iJWbJPnfKvbTDSKLlNGbHqwGRamw6unc+pRbkFNStD1ed+UzRh5nWKFNyAwUBP2
         JZeoJnP5Rxh6fFqQ84BVE7CcDzTySOJWLNxpvqfBAxxUwwgi34LGyEtijLqMD1sNtunf
         8ruSrEZddSuQpPnUVOTSC+sBh4OwNN3WEl5dfdkltdL4yXT3OvOrxvjXPqkgajPzKLoO
         7qnbkB+9FAiPRkpzP+rces4sRWc5tdiLXzMrQl7yjBNlm/eQS6PrKqH4Vx8qnt3SlKEe
         pY6g==
X-Gm-Message-State: AElRT7F/ZPwjJhoNQTtxc6NW2JWYqNArC5XK4zM3S3foZ4nPmOiBnsI7
        /YVFtTB5D3x8f341Yoiu47GSgw==
X-Google-Smtp-Source: AIpwx49hwQGdoizjH2h1UAIcoz25Yi/A+tEAiC8gkb4P/EpU+z18fulxwSwEsby4vN4nGNivZTR8Ig==
X-Received: by 10.101.64.139 with SMTP id t11mr19246632pgp.119.1523056912527;
        Fri, 06 Apr 2018 16:21:52 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id f64sm21222198pfa.154.2018.04.06.16.21.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 06 Apr 2018 16:21:51 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     jonathantanmy@google.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 02/19] replace-object: move replace_object to object store
Date:   Fri,  6 Apr 2018 16:21:19 -0700
Message-Id: <20180406232136.253950-3-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.484.g0c8726318c-goog
In-Reply-To: <20180406232136.253950-1-sbeller@google.com>
References: <20180406232136.253950-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Refs belong to particular repositories, so the replacements defined by
them should belong to a particular repository as well.

Move the definition of a single object replacement to a new header
"replace-object.h". While at it replace the hardcoded 20 by GIT_MAX_RAWSZ.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 object-store.h   | 14 ++++++++++++++
 replace-object.c | 40 ++++++++++++++++++----------------------
 replace-object.h |  9 +++++++++
 3 files changed, 41 insertions(+), 22 deletions(-)
 create mode 100644 replace-object.h

diff --git a/object-store.h b/object-store.h
index fef33f345f..da639b3184 100644
--- a/object-store.h
+++ b/object-store.h
@@ -93,6 +93,20 @@ struct raw_object_store {
 	struct alternate_object_database *alt_odb_list;
 	struct alternate_object_database **alt_odb_tail;
 
+	/*
+	 * Objects that should be substituted by other objects
+	 * (see git-replace(1)).
+	 */
+	struct replace_objects {
+		/*
+		 * An array of replacements.  The array is kept sorted by the original
+		 * sha1.
+		 */
+		struct replace_object **items;
+
+		int alloc, nr;
+	} replacements;
+
 	/*
 	 * private data
 	 *
diff --git a/replace-object.c b/replace-object.c
index 3e49965d05..a7eb31026e 100644
--- a/replace-object.c
+++ b/replace-object.c
@@ -1,19 +1,11 @@
 #include "cache.h"
+#include "replace-object.h"
+#include "object-store.h"
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
@@ -22,7 +14,8 @@ static const unsigned char *replace_sha1_access(size_t index, void *table)
 
 static int replace_object_pos(const unsigned char *sha1)
 {
-	return sha1_pos(sha1, replace_object, replace_object_nr,
+	return sha1_pos(sha1,  the_repository->objects->replacements.items,
+			 the_repository->objects->replacements.nr,
 			replace_sha1_access);
 }
 
@@ -35,18 +28,21 @@ static int register_replace_object(struct replace_object *replace,
 		if (ignore_dups)
 			free(replace);
 		else {
-			free(replace_object[pos]);
-			replace_object[pos] = replace;
+			free( the_repository->objects->replacements.items[pos]);
+			 the_repository->objects->replacements.items[pos] = replace;
 		}
 		return 1;
 	}
 	pos = -pos - 1;
-	ALLOC_GROW(replace_object, replace_object_nr + 1, replace_object_alloc);
-	replace_object_nr++;
-	if (pos < replace_object_nr)
-		MOVE_ARRAY(replace_object + pos + 1, replace_object + pos,
-			   replace_object_nr - pos - 1);
-	replace_object[pos] = replace;
+	ALLOC_GROW( the_repository->objects->replacements.items,
+		    the_repository->objects->replacements.nr + 1,
+		    the_repository->objects->replacements.alloc);
+	 the_repository->objects->replacements.nr++;
+	if (pos <  the_repository->objects->replacements.nr)
+		MOVE_ARRAY( the_repository->objects->replacements.items + pos + 1,
+			    the_repository->objects->replacements.items + pos,
+			    the_repository->objects->replacements.nr - pos - 1);
+	 the_repository->objects->replacements.items[pos] = replace;
 	return 0;
 }
 
@@ -84,7 +80,7 @@ static void prepare_replace_object(void)
 
 	for_each_replace_ref(register_replace_ref, NULL);
 	replace_object_prepared = 1;
-	if (!replace_object_nr)
+	if (!the_repository->objects->replacements.nr)
 		check_replace_refs = 0;
 }
 
@@ -113,7 +109,7 @@ const unsigned char *do_lookup_replace_object(const unsigned char *sha1)
 
 		pos = replace_object_pos(cur);
 		if (0 <= pos)
-			cur = replace_object[pos]->replacement;
+			cur = the_repository->objects->replacements.items[pos]->replacement;
 	} while (0 <= pos);
 
 	return cur;
diff --git a/replace-object.h b/replace-object.h
new file mode 100644
index 0000000000..50731ec9c2
--- /dev/null
+++ b/replace-object.h
@@ -0,0 +1,9 @@
+#ifndef REPLACE_OBJECT_H
+#define REPLACE_OBJECT_H
+
+struct replace_object {
+	unsigned char original[GIT_MAX_RAWSZ];
+	unsigned char replacement[GIT_MAX_RAWSZ];
+};
+
+#endif /* REPLACE_OBJECT_H */
-- 
2.17.0.484.g0c8726318c-goog

