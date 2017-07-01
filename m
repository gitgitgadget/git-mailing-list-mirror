Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2F184201A0
	for <e@80x24.org>; Sat,  1 Jul 2017 00:28:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751974AbdGAA2p (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Jun 2017 20:28:45 -0400
Received: from mail-pg0-f50.google.com ([74.125.83.50]:34240 "EHLO
        mail-pg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751900AbdGAA2o (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Jun 2017 20:28:44 -0400
Received: by mail-pg0-f50.google.com with SMTP id t186so70725910pgb.1
        for <git@vger.kernel.org>; Fri, 30 Jun 2017 17:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TbeX2qNS0t3WmJt+bfFRxQxo9+WX1w6CVgDzDRXbW3s=;
        b=nueQ5NGJS9UJH50mq9T4hgccAkIklrk3iA7mg1Fnw9ur7b6oZnXKL3uLzOeiiwFHqZ
         CHhVUJNbBGFy9D+A/aI11v2yCO9fh9C6CwM2LkY8ZPBGo0tJr8Xu1ro09fFPe3hBvUFA
         g2sucEbLxZi9imhCsouMUIPy8iNoNLkO9ZV9/6kYQr9yi2aaAdu0ZNnvaIITLTyFghC0
         LKi3ddnZ0+hbIYfg+k/Arc7buKuI4gnZYLhdpvJiOhBkHlhCCVzECf5ecSfWfMCHspFn
         nBGIcO+4spur32Wyex4pz7XzYKQrWLMmtC7IS/cCzNPzDnhy1d/dnbfstNU5gFRNX91K
         7r6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=TbeX2qNS0t3WmJt+bfFRxQxo9+WX1w6CVgDzDRXbW3s=;
        b=oIXwpPNn9ZVui3w5j7rC4UN9DXRqrVIQlkrr8iwINDkjh72uaQgHKrwQOVveFTiyL/
         fyzMJfJpf/3Rhy6FOkBM4pA5L/3cbClU05u/nM3Ik/HUWtx2992XqYArvbotgDqHp0vm
         K9ngWhqdMlePXEQ4Q1TMRT5PJzOHg5L2ZvzsnH608nFbgDMoV57luWLKZ5ir6dcNJ3la
         ELTzw8cTQPO45HiPAzz5urG6sFlW74P0PKdJkmQQ5aU1Fu5IMcGXShZRHHpwTC1VwL3Y
         1jB1TGkVEvpo2SHbK/ztITPqk4jTr8JcFoQRhyCI4of6ukyOOCl5QbeAspMWoyAzuCxv
         w6jQ==
X-Gm-Message-State: AKS2vOzoaXba3DNg6RVitWHeMqxYKNHdyjUv1fpASlQhEVpXpCoMyCTn
        mdWxXNThHduXqcQjtCdtMw==
X-Received: by 10.98.10.68 with SMTP id s65mr6042508pfi.89.1498868923145;
        Fri, 30 Jun 2017 17:28:43 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:cc8b:7c8c:8e14:f9b5])
        by smtp.gmail.com with ESMTPSA id y192sm14945777pgd.38.2017.06.30.17.28.42
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 30 Jun 2017 17:28:42 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Stefan Beller <sbeller@google.com>
Subject: [PATCH 01/10] attr.c: drop hashmap_cmp_fn cast
Date:   Fri, 30 Jun 2017 17:28:29 -0700
Message-Id: <20170701002838.22785-2-sbeller@google.com>
X-Mailer: git-send-email 2.13.0.31.g9b732c453e
In-Reply-To: <20170701002838.22785-1-sbeller@google.com>
References: <20170701002838.22785-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

MAke the code more readable and less error prone by avoiding the cast
of the compare function pointer in hashmap_init, but instead have the
correctly named void pointers to casted to the specific data structure.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 attr.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/attr.c b/attr.c
index 56961f0236..2f49151736 100644
--- a/attr.c
+++ b/attr.c
@@ -76,18 +76,20 @@ struct attr_hash_entry {
 };
 
 /* attr_hashmap comparison function */
-static int attr_hash_entry_cmp(void *unused_cmp_data,
-			       const struct attr_hash_entry *a,
-			       const struct attr_hash_entry *b,
-			       void *unused_keydata)
+static int attr_hash_entry_cmp(const void *unused_cmp_data,
+			       const void *entry,
+			       const void *entry_or_key,
+			       const void *unused_keydata)
 {
+	const struct attr_hash_entry *a = entry;
+	const struct attr_hash_entry *b = entry_or_key;
 	return (a->keylen != b->keylen) || strncmp(a->key, b->key, a->keylen);
 }
 
 /* Initialize an 'attr_hashmap' object */
 static void attr_hashmap_init(struct attr_hashmap *map)
 {
-	hashmap_init(&map->map, (hashmap_cmp_fn) attr_hash_entry_cmp, NULL, 0);
+	hashmap_init(&map->map, attr_hash_entry_cmp, NULL, 0);
 }
 
 /*
-- 
2.13.0.31.g9b732c453e

