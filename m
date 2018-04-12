Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3DEEA1F42D
	for <e@80x24.org>; Thu, 12 Apr 2018 00:21:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752527AbeDLAV3 (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Apr 2018 20:21:29 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:46867 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751668AbeDLAV1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Apr 2018 20:21:27 -0400
Received: by mail-pl0-f66.google.com with SMTP id 59-v6so2592375plc.13
        for <git@vger.kernel.org>; Wed, 11 Apr 2018 17:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=N4RyjpFnIwoYN27CQNm493IPqJQt2i2J0/EftDs5Sk4=;
        b=DKDKgP5qiVQPhpo3eSVvrtwfzAr7YUlugFdwfVybxex5O9dMLI+YNGx1JEfNMUdvpG
         fkMgmkUBJg0IlS05mod4gtE59Cyz6nZ0YNWzIwE2n6uHTL4AMc8QFB730sYEjuAREo0x
         mQ0V81OEJqrhuTsZIVmV/VWAULoTJ+vyHH3CWL6YYFyGcIWAG2Svg8i8ZONETu2m7057
         RqK90moRFJ0DtCzJYwM480FpuGl/Dvyt2lffOtnigSlDr5bQLnuN9Jvbh289MsMep1Wc
         9RIStZ6aVFVXdC8yHu6uasX7tEbx4PSjpKf2Ze7jTOvoJTfjYSQJ83zKkYZsA2OncqEc
         8Qvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=N4RyjpFnIwoYN27CQNm493IPqJQt2i2J0/EftDs5Sk4=;
        b=KfTxJ7j02l0ROrdD+VxrSH/LQ3wTxpK0ozj5WCruYyd0tRNzEAsQajJXA26DwQJkK5
         JJPqOHJJbhLGYPVlDvQEZBZUNvwrMDe19SlzRTumS6WhMjbJKpuJtCLYn4b4cviWWsLQ
         0Nx25g49BGSeyEQ2P+oOfQO0ujr9/A1eB7jisiYzvk4BNspsigzo0+s+z9XC5w47USOZ
         7q6exdqyFCoNmg8d9JCQnP2MDKoi0Q+N411iyTFHsNPktbymJglqmDzJUQO07iA8UPuA
         tkXOOQXkFI+ZRXv5vY1i51zsp4CohrnXc5OzQMhZD706tlKcJY/t4UEA67YLA5llCzZu
         Mamw==
X-Gm-Message-State: ALQs6tDciour4Z/dgBZ4X5edaTna1bZUAHzLPAZ+Wz+HQv4XvX3jiQbH
        LXQevLhED5GN2EeVaeItIGhjRg==
X-Google-Smtp-Source: AIpwx4+bB9TGCC8Yjse6SdBgPp8mHOH3s+E49OI4Rjfv3ptIFDDLnCIxgWlEoyznjrCsNquK0P4yOQ==
X-Received: by 2002:a17:902:a506:: with SMTP id s6-v6mr7160320plq.191.1523492486307;
        Wed, 11 Apr 2018 17:21:26 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id r70sm5145332pfe.22.2018.04.11.17.21.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 11 Apr 2018 17:21:24 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, jonathantanmy@google.com, l.s.r@web.de,
        pclouds@gmail.com, sandals@crustytoothpaste.net,
        sunshine@sunshineco.com
Subject: [PATCH 01/15] replace_object: use oidmap
Date:   Wed, 11 Apr 2018 17:21:04 -0700
Message-Id: <20180412002118.102976-2-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.484.g0c8726318c-goog
In-Reply-To: <20180412002118.102976-1-sbeller@google.com>
References: <20180409224533.17764-1-sbeller@google.com>
 <20180412002118.102976-1-sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: René Scharfe <l.s.r@web.de>

Load the replace objects into an oidmap to allow for easy lookups in
constant time.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 replace_object.c | 76 ++++++++++--------------------------------------
 1 file changed, 16 insertions(+), 60 deletions(-)

diff --git a/replace_object.c b/replace_object.c
index 336357394d..a757a5ebf2 100644
--- a/replace_object.c
+++ b/replace_object.c
@@ -1,54 +1,14 @@
 #include "cache.h"
-#include "sha1-lookup.h"
+#include "oidmap.h"
 #include "refs.h"
 #include "commit.h"
 
-/*
- * An array of replacements.  The array is kept sorted by the original
- * sha1.
- */
-static struct replace_object {
-	struct object_id original;
+struct replace_object {
+	struct oidmap_entry original;
 	struct object_id replacement;
-} **replace_object;
-
-static int replace_object_alloc, replace_object_nr;
+};
 
-static const unsigned char *replace_sha1_access(size_t index, void *table)
-{
-	struct replace_object **replace = table;
-	return replace[index]->original.hash;
-}
-
-static int replace_object_pos(const unsigned char *sha1)
-{
-	return sha1_pos(sha1, replace_object, replace_object_nr,
-			replace_sha1_access);
-}
-
-static int register_replace_object(struct replace_object *replace,
-				   int ignore_dups)
-{
-	int pos = replace_object_pos(replace->original.hash);
-
-	if (0 <= pos) {
-		if (ignore_dups)
-			free(replace);
-		else {
-			free(replace_object[pos]);
-			replace_object[pos] = replace;
-		}
-		return 1;
-	}
-	pos = -pos - 1;
-	ALLOC_GROW(replace_object, replace_object_nr + 1, replace_object_alloc);
-	replace_object_nr++;
-	if (pos < replace_object_nr)
-		MOVE_ARRAY(replace_object + pos + 1, replace_object + pos,
-			   replace_object_nr - pos - 1);
-	replace_object[pos] = replace;
-	return 0;
-}
+static struct oidmap replace_map = OIDMAP_INIT;
 
 static int register_replace_ref(const char *refname,
 				const struct object_id *oid,
@@ -59,7 +19,7 @@ static int register_replace_ref(const char *refname,
 	const char *hash = slash ? slash + 1 : refname;
 	struct replace_object *repl_obj = xmalloc(sizeof(*repl_obj));
 
-	if (get_oid_hex(hash, &repl_obj->original)) {
+	if (get_oid_hex(hash, &repl_obj->original.oid)) {
 		free(repl_obj);
 		warning("bad replace ref name: %s", refname);
 		return 0;
@@ -69,7 +29,7 @@ static int register_replace_ref(const char *refname,
 	oidcpy(&repl_obj->replacement, oid);
 
 	/* Register new object */
-	if (register_replace_object(repl_obj, 1))
+	if (oidmap_put(&replace_map, repl_obj))
 		die("duplicate replace ref: %s", refname);
 
 	return 0;
@@ -84,7 +44,7 @@ static void prepare_replace_object(void)
 
 	for_each_replace_ref(register_replace_ref, NULL);
 	replace_object_prepared = 1;
-	if (!replace_object_nr)
+	if (!replace_map.map.tablesize)
 		check_replace_refs = 0;
 }
 
@@ -100,21 +60,17 @@ static void prepare_replace_object(void)
  */
 const struct object_id *do_lookup_replace_object(const struct object_id *oid)
 {
-	int pos, depth = MAXREPLACEDEPTH;
+	int depth = MAXREPLACEDEPTH;
 	const struct object_id *cur = oid;
 
 	prepare_replace_object();
 
 	/* Try to recursively replace the object */
-	do {
-		if (--depth < 0)
-			die("replace depth too high for object %s",
-			    oid_to_hex(oid));
-
-		pos = replace_object_pos(cur->hash);
-		if (0 <= pos)
-			cur = &replace_object[pos]->replacement;
-	} while (0 <= pos);
-
-	return cur;
+	while (depth-- > 0) {
+		struct replace_object *repl_obj = oidmap_get(&replace_map, cur);
+		if (!repl_obj)
+			return cur;
+		cur = &repl_obj->replacement;
+	}
+	die("replace depth too high for object %s", oid_to_hex(oid));
 }
-- 
2.17.0.484.g0c8726318c-goog

