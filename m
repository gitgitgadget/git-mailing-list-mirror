Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B25BE201A0
	for <e@80x24.org>; Sat,  1 Jul 2017 00:28:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752149AbdGAA24 (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Jun 2017 20:28:56 -0400
Received: from mail-pg0-f43.google.com ([74.125.83.43]:34263 "EHLO
        mail-pg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752138AbdGAA2y (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Jun 2017 20:28:54 -0400
Received: by mail-pg0-f43.google.com with SMTP id t186so70727031pgb.1
        for <git@vger.kernel.org>; Fri, 30 Jun 2017 17:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7shNUlvKRO5eXtUb/Qg2cEdx+kAwz53UsFZgnxHVZi0=;
        b=WZikTFuJ8lXb0a8xi+5wb0OssTfwC16wVTMybSEUmaIoYzktSO3izgrsDfCBN2zLt1
         /lizsxBBBs+imngkivHtwKIjm4aXi8otlB2wSZWrvqT3xEv+C0/oMyaqyaGjpGyVRHfL
         2bdqgFn+uI30AuDOyMJHfD8V20r0mMxZFdeFaKfcynitXMmWisKr6YY1N+ep34achd7e
         bVgFmiBreuLJgzPA2xkHPzJXhtdRknKLG/k3Y+x1ERGSwpqgihXNU9Kmlkb3Rr8fMb+0
         owW0bHl0dub9odjzVAYziP/sjabUk+W3JVAgdKqV5wxc8cje9DAqFAH7V/krPyO3uGHm
         FmyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7shNUlvKRO5eXtUb/Qg2cEdx+kAwz53UsFZgnxHVZi0=;
        b=dpqwj80/Sv5aCsvgu7zwnpkzgDD7tH6tOpx6jN5J4okvalIii2QRfFKPPf8tlYsjQr
         idVtf1+9mW08jnre9K0uGL08vLSkxRbZ+RaFg/KTjanNLlakqhsxnpVWyMhS2kMvYgRK
         CdpV01o7kdOAjT+rjA8Q+1Q4oAuifnvNuEhh0vKN39nuR6dkHa8NaSBbt8vNDFmHtav3
         ZSz7ULYWqrD2/uFlhJjLPheHXdh7hfQsg9+iUYbLmaX8k/EgqQeC4p2r583sZuCQ49yn
         IOKvdeXnwCC9EIhSPH4odO1wVnkxhkLkykEO3M5QUjTj2eK9RUFf3l/Ra1C1LtMGqqRN
         ESUg==
X-Gm-Message-State: AKS2vOz4nu169kBv1BKqQW4+0qXH+YnE14arZdciwraQnFE5qqEiBhCq
        aelWM8JS6axMuiGW5V7myg==
X-Received: by 10.99.106.66 with SMTP id f63mr23661893pgc.150.1498868933739;
        Fri, 30 Jun 2017 17:28:53 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:cc8b:7c8c:8e14:f9b5])
        by smtp.gmail.com with ESMTPSA id 79sm21228890pgg.46.2017.06.30.17.28.52
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 30 Jun 2017 17:28:53 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Stefan Beller <sbeller@google.com>
Subject: [PATCH 10/10] t/helper/test-hashmap: use custom data instead of duplicate cmp functions
Date:   Fri, 30 Jun 2017 17:28:38 -0700
Message-Id: <20170701002838.22785-11-sbeller@google.com>
X-Mailer: git-send-email 2.13.0.31.g9b732c453e
In-Reply-To: <20170701002838.22785-1-sbeller@google.com>
References: <20170701002838.22785-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

With the new field that is passed to the compare function, we can pass
through flags there instead of having multiple compare functions.
Also drop the cast to hashmap_cmp_fn.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 t/helper/test-hashmap.c | 34 ++++++++++++++++------------------
 1 file changed, 16 insertions(+), 18 deletions(-)

diff --git a/t/helper/test-hashmap.c b/t/helper/test-hashmap.c
index 095d7395f3..93ccfbb75f 100644
--- a/t/helper/test-hashmap.c
+++ b/t/helper/test-hashmap.c
@@ -13,20 +13,20 @@ static const char *get_value(const struct test_entry *e)
 	return e->key + strlen(e->key) + 1;
 }
 
-static int test_entry_cmp(const void *unused_cmp_data,
-			  const struct test_entry *e1,
-			  const struct test_entry *e2,
-			  const char* key)
+static int test_entry_cmp(const void *cmp_data,
+			  const void *entry,
+			  const void *entry_or_key,
+			  const void* keydata)
 {
-	return strcmp(e1->key, key ? key : e2->key);
-}
-
-static int test_entry_cmp_icase(const void *unused_cmp_data,
-				const struct test_entry *e1,
-				const struct test_entry *e2,
-				const char* key)
-{
-	return strcasecmp(e1->key, key ? key : e2->key);
+	const int ignore_case = cmp_data ? *((int*)cmp_data) : 0;
+	const struct test_entry *e1 = entry;
+	const struct test_entry *e2 = entry_or_key;
+	const char* key = keydata;
+
+	if (ignore_case)
+		return strcasecmp(e1->key, key ? key : e2->key);
+	else
+		return strcmp(e1->key, key ? key : e2->key);
 }
 
 static struct test_entry *alloc_test_entry(int hash, char *key, int klen,
@@ -96,8 +96,7 @@ static void perf_hashmap(unsigned int method, unsigned int rounds)
 	if (method & TEST_ADD) {
 		/* test adding to the map */
 		for (j = 0; j < rounds; j++) {
-			hashmap_init(&map, (hashmap_cmp_fn) test_entry_cmp,
-				     NULL, 0);
+			hashmap_init(&map, test_entry_cmp, NULL, 0);
 
 			/* add entries */
 			for (i = 0; i < TEST_SIZE; i++) {
@@ -109,7 +108,7 @@ static void perf_hashmap(unsigned int method, unsigned int rounds)
 		}
 	} else {
 		/* test map lookups */
-		hashmap_init(&map, (hashmap_cmp_fn) test_entry_cmp, NULL, 0);
+		hashmap_init(&map, test_entry_cmp, NULL, 0);
 
 		/* fill the map (sparsely if specified) */
 		j = (method & TEST_SPARSE) ? TEST_SIZE / 10 : TEST_SIZE;
@@ -151,8 +150,7 @@ int cmd_main(int argc, const char **argv)
 
 	/* init hash map */
 	icase = argc > 1 && !strcmp("ignorecase", argv[1]);
-	hashmap_init(&map, (hashmap_cmp_fn) (icase ? test_entry_cmp_icase
-			: test_entry_cmp), NULL, 0);
+	hashmap_init(&map, test_entry_cmp, &icase, 0);
 
 	/* process commands from stdin */
 	while (fgets(line, sizeof(line), stdin)) {
-- 
2.13.0.31.g9b732c453e

