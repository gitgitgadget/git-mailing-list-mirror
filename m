Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6558E1F404
	for <e@80x24.org>; Wed, 21 Feb 2018 01:54:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751417AbeBUByy (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Feb 2018 20:54:54 -0500
Received: from mail-pl0-f65.google.com ([209.85.160.65]:40929 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751378AbeBUByw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Feb 2018 20:54:52 -0500
Received: by mail-pl0-f65.google.com with SMTP id i6so86129plt.7
        for <git@vger.kernel.org>; Tue, 20 Feb 2018 17:54:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=o5U/cZG1l8uPim2JYuBhR8+MRluflVzUYaX4MWkNCTw=;
        b=XZSnijDGaGzq/HqT9RoacEcfFMOM7KgU+6Tw6Ap8YJn+GU8bfkD5+t7OAFC0oRAUMv
         VkUI138LM29x3VjnELGatFWzKLxya+CZvkOvM1FqSWvTd2ErPuBwM3il7pOgIj/RoNs9
         20bsVzAxBEHGWnN66GspLHKlVziGpJ3DXX+VOUkhoXWpBmY5oyV24CDYiueBgaYkwcM0
         0v3u9JVyDHqW/JH78yVgHPT7AXIQ8FSLvnYvtAvD8RN11zZINXXJBhbvSO5bLMUHP9SQ
         W1i8yqwCMLcrBwJHWoqMZ9WnfESznKGa/roOW6MroW5wruZnXMeMWpxFazADk77WFfdU
         jUMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=o5U/cZG1l8uPim2JYuBhR8+MRluflVzUYaX4MWkNCTw=;
        b=RU4Zxee6qDe0UJUh0yRn95k4tsyXkOoRalXb8vwi/TGKH6T6m9rrCmooz/BOD5Lw22
         qdoZPXqcboGmAaEA8YHXaRjSnYNEIAldumCs02V93QMwy0nWtzqyvyPa6aSGkNMWlxFL
         gGJPt3thK8lXWZp7McmhMyZ3+nQMFcjO3UETV1wCxHT8MGBvZdzKVPAIQUBfDf1aLhJZ
         QMs0xM3hgPg8ZjflPQGbrIQJifY7gmhXl1/mpsI2ZiJ8c3s/EUc1pEK0vuH32zBXXrhY
         v2BZZX0jx7qjAmV+VbMKh8aphBBdKXWYInraSGVtBxap4XzoV3Oa0AjGVfX8trmDgQRC
         RAJQ==
X-Gm-Message-State: APf1xPD5LRrzvasxbTNJbyuZ7vejHQSMLldlhQygp0EQdx62DiO7HRKh
        5z/WG8/ytqBrC9vpCnAf+mlLPW/zkT4=
X-Google-Smtp-Source: AH8x225CEfPCLKvl8cNlAUnxP1+jCk/F4/gPfTPC1csJS31flCVIP2N0z/GrgqqSTjiVE5LnhP5H3g==
X-Received: by 2002:a17:902:6b0b:: with SMTP id o11-v6mr1502950plk.109.1519178091495;
        Tue, 20 Feb 2018 17:54:51 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id b26sm5391765pfn.60.2018.02.20.17.54.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 20 Feb 2018 17:54:50 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, gitster@pobox.com, jonathantanmy@google.com,
        pclouds@gmail.com, sunshine@sunshineco.com,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 08/27] pack: move approximate object count to object store
Date:   Tue, 20 Feb 2018 17:54:11 -0800
Message-Id: <20180221015430.96054-9-sbeller@google.com>
X-Mailer: git-send-email 2.16.1.291.g4437f3f132-goog
In-Reply-To: <20180221015430.96054-1-sbeller@google.com>
References: <20180216174626.24677-1-sbeller@google.com>
 <20180221015430.96054-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The approximate_object_count() function maintains a rough count of
objects in a repository to estimate how long object name abbreviates
should be.  Object names are scoped to a repository and the
appropriate length may differ by repository, so the object count
should not be global.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 object-store.h | 10 +++++++++-
 packfile.c     | 11 +++++------
 2 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/object-store.h b/object-store.h
index 6cecba3951..bd1e4fcd8b 100644
--- a/object-store.h
+++ b/object-store.h
@@ -93,6 +93,14 @@ struct raw_object_store {
 	struct alternate_object_database *alt_odb_list;
 	struct alternate_object_database **alt_odb_tail;
 
+	/*
+	 * A fast, rough count of the number of objects in the repository.
+	 * These two fields are not meant for direct access. Use
+	 * approximate_object_count() instead.
+	 */
+	unsigned long approximate_object_count;
+	unsigned approximate_object_count_valid : 1;
+
 	/*
 	 * Whether packed_git has already been populated with this repository's
 	 * packs.
@@ -107,7 +115,7 @@ struct raw_object_store {
  * that macro on member variables. Use NULL instead as that is defined
  * and accepted, deferring the real init to prepare_packed_git_mru(). */
 #define __MRU_INIT { NULL, NULL }
-#define RAW_OBJECT_STORE_INIT { NULL, NULL, __MRU_INIT, NULL, NULL, 0 }
+#define RAW_OBJECT_STORE_INIT { NULL, NULL, __MRU_INIT, NULL, NULL, 0, 0, 0 }
 
 void raw_object_store_clear(struct raw_object_store *o);
 
diff --git a/packfile.c b/packfile.c
index a8a2e7fe43..693bafbc98 100644
--- a/packfile.c
+++ b/packfile.c
@@ -803,8 +803,6 @@ static void prepare_packed_git_one(char *objdir, int local)
 	strbuf_release(&path);
 }
 
-static int approximate_object_count_valid;
-
 /*
  * Give a fast, rough count of the number of objects in the repository. This
  * ignores loose objects completely. If you have a lot of them, then either
@@ -814,8 +812,8 @@ static int approximate_object_count_valid;
  */
 unsigned long approximate_object_count(void)
 {
-	static unsigned long count;
-	if (!approximate_object_count_valid) {
+	if (!the_repository->objects.approximate_object_count_valid) {
+		unsigned long count;
 		struct packed_git *p;
 
 		prepare_packed_git();
@@ -825,8 +823,9 @@ unsigned long approximate_object_count(void)
 				continue;
 			count += p->num_objects;
 		}
+		the_repository->objects.approximate_object_count = count;
 	}
-	return count;
+	return the_repository->objects.approximate_object_count;
 }
 
 static void *get_next_packed_git(const void *p)
@@ -901,7 +900,7 @@ void prepare_packed_git(void)
 
 void reprepare_packed_git(void)
 {
-	approximate_object_count_valid = 0;
+	the_repository->objects.approximate_object_count_valid = 0;
 	the_repository->objects.packed_git_initialized = 0;
 	prepare_packed_git();
 }
-- 
2.16.1.291.g4437f3f132-goog

