Return-Path: <SRS0=8h89=7R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F828C433E2
	for <git@archiver.kernel.org>; Thu,  4 Jun 2020 07:30:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 682AB2072E
	for <git@archiver.kernel.org>; Thu,  4 Jun 2020 07:30:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tBhazdlo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728214AbgFDH35 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Jun 2020 03:29:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728145AbgFDH3y (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Jun 2020 03:29:54 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D0C1C05BD1E
        for <git@vger.kernel.org>; Thu,  4 Jun 2020 00:29:53 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id n23so3055770pgb.12
        for <git@vger.kernel.org>; Thu, 04 Jun 2020 00:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RvxBuCutDVGe4b7HkC31Y6mQZcX3z37QQdSYYPKL2GM=;
        b=tBhazdlodHT6vZlKrs2W9QJDbnEh6hyhiGYGcjQYPRL3SyYmg6mQMgQI6X5NBo6QdX
         M0RrQTiqN3TPxPSjaBHqX+31OT7wsrI8lYYdcRsq2HvCmuQD9OkBpmU4GjhUsNqdwukJ
         O1X4iZ+w7qoZ8OK0JCXBf+nD8qLE8+7A5x1fCzu+4jBzkEnSUy7YZ6FC+o2n6Wareq3M
         hNv2LWQ0Ha8ac6Wo09vMmZemYGTGIHBwrQ6Xy3BUnpHbYOzC/p3kBbnn5jBN7CccfFYL
         tCweVmzH25OOgA7r1D6LdRGseceGLBj2YyntKV+0mH79xT4eRfpsRPxl79UFpFoczUKb
         uTnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RvxBuCutDVGe4b7HkC31Y6mQZcX3z37QQdSYYPKL2GM=;
        b=HSXxabyPdDYbKftwxsTSnS2G6r7VTgp1rG00FDjtyGVxviGqpFNmrReyxnHxmJDxhh
         Cmp+Xz92s9NWIeTn9hWTsL0ob9G4grjzorLQkix3ESxUjKVe0LKLLF1Hf8B57svnJlCS
         ZBZR50w+E7UUz2mCEqNJ1U8/l9kup1iborvku1VoPmNFN14gn3Qv2ZzIZ6V6etXjOWpS
         kd2i1FNiVzsGqBswSDe8OvtkTyHLAdwkIfNHXPmM5bkRH3dhXrXeA6QaXXJXrtGGCfGN
         jbRCjKVu2IX1AMdiTTEfXQxMmKmKfh7PHb64aJr0KztkiheVhb9lRYraWW1dkbY3YnGd
         JSOA==
X-Gm-Message-State: AOAM531NfFyoHiOz1YGMV6H3MVp5pIWGtjr5xBDkVYL5UQsOsXW5UlmH
        BUMvAv8Ng3b9Bz1vtKCvsq5Ivh2p
X-Google-Smtp-Source: ABdhPJzVGrPk8M617zM4XJfVZHNBJEN7O8K396BFKnpCPANpg46zpAhfYWkM8Dr4XK5yu+zu3sZ8pA==
X-Received: by 2002:a63:ec0c:: with SMTP id j12mr3116746pgh.255.1591255792603;
        Thu, 04 Jun 2020 00:29:52 -0700 (PDT)
Received: from localhost.localdomain ([2409:4064:2480:9552:2003:1696:484d:e269])
        by smtp.gmail.com with ESMTPSA id c12sm3335108pgt.91.2020.06.04.00.29.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2020 00:29:51 -0700 (PDT)
From:   Abhishek Kumar <abhishekkumar8222@gmail.com>
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, jnareb@gmail.com
Subject: [GSoC Patch 1/3] commit: introduce helpers for generation slab
Date:   Thu,  4 Jun 2020 12:57:57 +0530
Message-Id: <20200604072759.19142-2-abhishekkumar8222@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200604072759.19142-1-abhishekkumar8222@gmail.com>
References: <20200604072759.19142-1-abhishekkumar8222@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The struct member generation refers to "generation number" (or more
broadly, a reachablity index value) used by commit-graph to reduce time
taken to walk commits. However, generation is not useful in other
contexts and bloats the struct.

Let's move it to a commit-slab and shrink the struct by four bytes.

Signed-off-by: Abhishek Kumar <abhishekkumar8222@gmail.com>
---
 commit-graph.c | 27 +++++++++++++++++++++++++++
 commit-graph.h |  5 +++++
 commit.h       |  3 ---
 3 files changed, 32 insertions(+), 3 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index e3420ddcbf..63f419048d 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -87,6 +87,33 @@ static int commit_pos_cmp(const void *va, const void *vb)
 	       commit_pos_at(&commit_pos, b);
 }
 
+define_commit_slab(generation_slab, uint32_t);
+static struct generation_slab generation_slab = COMMIT_SLAB_INIT(1, generation_slab);
+
+uint32_t generation(const struct commit *c)
+{
+	uint32_t *gen = generation_slab_peek(&generation_slab, c);
+
+	return gen ? *gen : GENERATION_NUMBER_INFINITY;
+}
+
+static void set_generation(const struct commit *c, const uint32_t generation)
+{
+	unsigned int i = generation_slab.slab_count;
+	uint32_t *gen = generation_slab_at(&generation_slab, c);
+
+	/*
+	 * commit-slab initializes with zero, overwrite this with
+	 * GENERATION_NUMBER_INFINITY
+	 */
+	for (; i < generation_slab.slab_count; ++i) {
+		memset(generation_slab.slab[i], GENERATION_NUMBER_INFINITY,
+		       generation_slab.slab_size * sizeof(uint32_t));
+	}
+
+	*gen = generation;
+}
+
 static int commit_gen_cmp(const void *va, const void *vb)
 {
 	const struct commit *a = *(const struct commit **)va;
diff --git a/commit-graph.h b/commit-graph.h
index 4212766a4f..653bd041ad 100644
--- a/commit-graph.h
+++ b/commit-graph.h
@@ -8,6 +8,10 @@
 #include "object-store.h"
 #include "oidset.h"
 
+#define GENERATION_NUMBER_INFINITY 0xFFFFFFFF
+#define GENERATION_NUMBER_MAX 0x3FFFFFFF
+#define GENERATION_NUMBER_ZERO 0
+
 #define GIT_TEST_COMMIT_GRAPH "GIT_TEST_COMMIT_GRAPH"
 #define GIT_TEST_COMMIT_GRAPH_DIE_ON_LOAD "GIT_TEST_COMMIT_GRAPH_DIE_ON_LOAD"
 #define GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS "GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS"
@@ -137,4 +141,5 @@ void free_commit_graph(struct commit_graph *);
  */
 void disable_commit_graph(struct repository *r);
 
+uint32_t generation(const struct commit *c);
 #endif
diff --git a/commit.h b/commit.h
index 1b2dea5d85..cc610400d5 100644
--- a/commit.h
+++ b/commit.h
@@ -11,9 +11,6 @@
 #include "commit-slab.h"
 
 #define COMMIT_NOT_FROM_GRAPH 0xFFFFFFFF
-#define GENERATION_NUMBER_INFINITY 0xFFFFFFFF
-#define GENERATION_NUMBER_MAX 0x3FFFFFFF
-#define GENERATION_NUMBER_ZERO 0
 
 struct commit_list {
 	struct commit *item;
-- 
2.27.0

