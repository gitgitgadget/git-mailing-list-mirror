Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C65731F404
	for <e@80x24.org>; Mon,  9 Apr 2018 22:45:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751863AbeDIWpl (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Apr 2018 18:45:41 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:47024 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751701AbeDIWpk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Apr 2018 18:45:40 -0400
Received: by mail-pf0-f196.google.com with SMTP id h69so6609000pfe.13
        for <git@vger.kernel.org>; Mon, 09 Apr 2018 15:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=N4RyjpFnIwoYN27CQNm493IPqJQt2i2J0/EftDs5Sk4=;
        b=XeEVJWQRVYlN+Fepxxm9k5H2bEUAE2QRMJyAImX71ahFOk2Sbm1M4zJ+4smO7Mk9vp
         vnQd3ucbNMUaDVqb0KoyiFalcnVC7SDdruHtRW33gNeCHmyX5ugeTD0HdLy1wS8kDOPF
         BuiXvjTFyU0SZSdinp3y5YNtaBaM4yaHuRBSRqjnz7P8SFv7PFCR4HJ1Cv+I+dfWC3z0
         fHrFaZ3MLnvBS6djRaqNvdivOZ+GiFEY8dqPeaooBkIcy6r4ntLwREi5kKGXvMdGRaWf
         ATESoEDTI4l/UR8hAI5HKzoHCqfbPj27Oa66yQx76LOLxnmdboHe6D8F2QCvOGN/PPMb
         BC3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=N4RyjpFnIwoYN27CQNm493IPqJQt2i2J0/EftDs5Sk4=;
        b=Qdp2e+SgZGWFZXQa+E94IKEjfaEsfyfzmQtBgbHDvU6cQ7wrjKnq8Z8+AHQbNW2Ees
         dF+i5qqVRgT3Rmef9KQ9brwYbexuomV0jeQD3XA7bAiVt5zVocnfhmFDtC5iG65fav+E
         ZJH6GI8GUKfU0m/65qylDfkEgrqUWKQwjH7qJvr2d6/Qw4IjCiLAKCNMHcr53J6xKLye
         Cnqf6fer/6TmtT2QDJ1iU9OD/AqWZYtFIjBswPMAJJGSfKsOBDIpUVfKxH+74wtRMj0M
         zs1LmsARngt+Sn60HPk5bStL7/oFJvUHIUUQCEFHoaKYKcKqEC4mfkdqoNa9s9v39SaS
         XMgA==
X-Gm-Message-State: ALQs6tBE2UePlpJ1ReQ1TMnyaucXEhCCnk5FFWFwDrp9ga3k1dxMUxtN
        f5CQxlHZBTOZvrqRfisUcku9iQ==
X-Google-Smtp-Source: AIpwx4+WisTZeByOl875UL/yHskDUEEYeZYZW8ACpKovjS2Ht14Hpl37eOmBB2r7bj4Y99udpZ8IJw==
X-Received: by 10.99.67.65 with SMTP id q62mr824527pga.358.1523313939355;
        Mon, 09 Apr 2018 15:45:39 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id f12sm2100686pgr.37.2018.04.09.15.45.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 09 Apr 2018 15:45:38 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, jonathantanmy@google.com,
        sunshine@sunshineco.com, pclouds@gmail.com, l.s.r@web.de,
        sandals@crustytoothpaste.net
Subject: [PATCH 01/16] replace_object: use oidmap
Date:   Mon,  9 Apr 2018 15:45:18 -0700
Message-Id: <20180409224533.17764-2-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.484.g0c8726318c-goog
In-Reply-To: <20180409224533.17764-1-sbeller@google.com>
References: <20180406232136.253950-1-sbeller@google.com>
 <20180409224533.17764-1-sbeller@google.com>
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

