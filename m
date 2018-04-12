Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A7B6D1F42D
	for <e@80x24.org>; Thu, 12 Apr 2018 00:21:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752648AbeDLAVm (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Apr 2018 20:21:42 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:38973 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752535AbeDLAVb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Apr 2018 20:21:31 -0400
Received: by mail-pl0-f67.google.com with SMTP id e7-v6so2604398plt.6
        for <git@vger.kernel.org>; Wed, 11 Apr 2018 17:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rsnvmqOnao4HCb2opLWPHnPVNKIQ+F1lifSkW9Mhv8o=;
        b=o1wNY66dS8hm6K/OzvkApJOsF8QTtzpPnCw45QPvRFRibezi+GXGLIk2aqz8NLv9Dq
         ywMqulVrRQPRBLGnpJlps0kFCGLIS2AC+kh/OossFNjzP6fDUCrHGxavCd/s9oHwqQrw
         iCKooGU4QQaWJMQZ8+eKKxUKAbPJ5vjJ9MkodRkQOQMO2ErFBD0ksL1k36rwTfIaCSqm
         Jx5h0hUJ2TOFi8FwlB8bQC5EuxtzQrkUKhg0t620mScg4VWILAyQYvcTbjYywn+l6dYj
         xEoy/TxLgvfY2U+1xX9NqcclUOFst2xUceSRpIko5mAruAh/cl3zQswVL3sH1eU+30rG
         0PDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rsnvmqOnao4HCb2opLWPHnPVNKIQ+F1lifSkW9Mhv8o=;
        b=h+JwjD8/JRvl4lqFEg2jP4LyqU2t8GZoR0axTX0NDfXIh6I1kQ767X2/eDtT763kdC
         RXebS5kHfPeVEkhZQv7lJKP0J2DrutMqkNqoJ7/m0iIpYqCMRJaZDEC6pLLQhV8KO8FG
         L6aKIv7gxGG3TRim2CeHAy4FChUMpI/enCpvWxo1oL5MDSISwri5cnzTnLJWEZZ05ejf
         vASeNg2pR6+xMu9zU9vRnPyBX442ONrT0ez/83DMud8LbJ1HSlnZhrTbv9pFERpmtN/o
         av2jGlgYPb36y18kaI3CmpF60hDFxULiAdYGd/y9oCY+0rnJRDuMv+qSRGwV0SCz0yo3
         FAIg==
X-Gm-Message-State: ALQs6tBlonUOQu2D39Oxwn7Kr0eE1FhzepJfO/sb2dOiVqTAtUNaBy9F
        m7+TJbk3EIvsYJtSA2Z2QrDIFw==
X-Google-Smtp-Source: AIpwx4/W77nDcQs9PNw7/xxX38pI4Vev7JS22g6ahdAi+fwDDETtqBxQW6696G6QjT3mLgNF7DYzNA==
X-Received: by 2002:a17:902:144:: with SMTP id 62-v6mr7395288plb.202.1523492490392;
        Wed, 11 Apr 2018 17:21:30 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id l14sm4095400pgu.46.2018.04.11.17.21.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 11 Apr 2018 17:21:29 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, jonathantanmy@google.com, l.s.r@web.de,
        pclouds@gmail.com, sandals@crustytoothpaste.net,
        sunshine@sunshineco.com
Subject: [PATCH 04/15] replace-object: eliminate replace objects prepared flag
Date:   Wed, 11 Apr 2018 17:21:07 -0700
Message-Id: <20180412002118.102976-5-sbeller@google.com>
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

Make the oidmap a pointer.

That way we eliminate the need for the global boolean
variable 'replace_object_prepared' as we can put this information
into the pointer being NULL or not.

Another advantage of this is that we would more quickly catch
code that tries to access replace-map without initializing it.

This also allows the '#include "oidmap.h"' introduced in a previous
patch to be replaced by the forward declaration of 'struct oidmap;'.
Keeping the type opaque discourages circumventing accessor functions;
not dragging in other headers avoids some compile time overhead.

One disadvantage of this is change is performance as we need to
pay the overhead for a malloc. The alternative of moving the
global variable into the object store is less modular code.

Helped-by: René Scharfe <l.s.r@web.de>
Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 object-store.h   |  2 +-
 replace_object.c | 16 +++++++++-------
 2 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/object-store.h b/object-store.h
index c04b4c95eb..1ff862c7f9 100644
--- a/object-store.h
+++ b/object-store.h
@@ -99,7 +99,7 @@ struct raw_object_store {
 	 * Objects that should be substituted by other objects
 	 * (see git-replace(1)).
 	 */
-	struct oidmap replace_map;
+	struct oidmap *replace_map;
 
 	/*
 	 * private data
diff --git a/replace_object.c b/replace_object.c
index afbdf2df25..953fa9cc40 100644
--- a/replace_object.c
+++ b/replace_object.c
@@ -25,7 +25,7 @@ static int register_replace_ref(const char *refname,
 	oidcpy(&repl_obj->replacement, oid);
 
 	/* Register new object */
-	if (oidmap_put(&the_repository->objects->replace_map, repl_obj))
+	if (oidmap_put(the_repository->objects->replace_map, repl_obj))
 		die("duplicate replace ref: %s", refname);
 
 	return 0;
@@ -33,14 +33,16 @@ static int register_replace_ref(const char *refname,
 
 static void prepare_replace_object(void)
 {
-	static int replace_object_prepared;
-
-	if (replace_object_prepared)
+	if (the_repository->objects->replace_map)
 		return;
 
+	the_repository->objects->replace_map =
+		xmalloc(sizeof(*the_repository->objects->replace_map));
+	oidmap_init(the_repository->objects->replace_map, 0);
+
 	for_each_replace_ref(register_replace_ref, NULL);
-	replace_object_prepared = 1;
-	if (!the_repository->objects->replace_map.map.tablesize)
+
+	if (!the_repository->objects->replace_map->map.tablesize)
 		check_replace_refs = 0;
 }
 
@@ -64,7 +66,7 @@ const struct object_id *do_lookup_replace_object(const struct object_id *oid)
 	/* Try to recursively replace the object */
 	while (depth-- > 0) {
 		struct replace_object *repl_obj =
-			oidmap_get(&the_repository->objects->replace_map, cur);
+			oidmap_get(the_repository->objects->replace_map, cur);
 		if (!repl_obj)
 			return cur;
 		cur = &repl_obj->replacement;
-- 
2.17.0.484.g0c8726318c-goog

