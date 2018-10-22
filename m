Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9BB251F453
	for <e@80x24.org>; Mon, 22 Oct 2018 02:44:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727472AbeJVLAs (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Oct 2018 07:00:48 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:51772 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727418AbeJVLAo (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 22 Oct 2018 07:00:44 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:65d4:dc3c:f6f5:933b])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 49F9961B77;
        Mon, 22 Oct 2018 02:44:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1540176250;
        bh=j/dn2Gxt/op+PVZAowV1ZjfLEWkrEw13ZXMQQQUwb50=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=S56REaSlxptpKgrx33sGNZL+e4BQPm9VxqWb7CT4XT/2DUDG3OhRsY0+GpzjeBAA3
         v+qqvae43Pvq+QB3/hi5SO1g8I1bhsL6ule4gSpL9eDE0we/AQzMZsh0ErvtzqPOlc
         f298IFIrGmYqYf+nif/POJLrilmqmm1KbSDafa0GMdi8mWrGn5Bq+dtxS2B/mA5ib9
         kZhSa5O8Unafn6mSqDavAqIami2ILvns/8CGhRGDMxP0vzzYTv85MUg3vFK+ZYPYWU
         L6HydwRUYOYRTdA/1Znyma3IGLSg/ggER7pMRsGnGKfR0VFF42JJaBe5ArMvdVWzL1
         kPYGDM7xAR4q2hNn1WPAW6pFHdas6S/QQm/CfL3dTNZyzjpPKyfX36f9XBnkZT4Xmd
         XSUvqY/Zvf8ar2s4Fcan3lh+mGpZqsRRofP2wEOqwqobR5sqQknIElUTB1fKF0Gwr2
         1+VtqZclZtkAkF4qHo5jyXJ4jAPP1WviesWu+brY95Unj3hGXjQ
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Duy Nguyen <pclouds@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v3 08/12] t/helper: add a test helper to compute hash speed
Date:   Mon, 22 Oct 2018 02:43:38 +0000
Message-Id: <20181022024342.489564-9-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.19.1.568.g152ad8e336
In-Reply-To: <20181022024342.489564-1-sandals@crustytoothpaste.net>
References: <20181022024342.489564-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a utility (which is less for the testsuite and more for developers)
that can compute hash speeds for whatever hash algorithms are
implemented.  This allows developers to test their personal systems to
determine the performance characteristics of various algorithms.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 Makefile                   |  1 +
 t/helper/test-hash-speed.c | 61 ++++++++++++++++++++++++++++++++++++++
 t/helper/test-tool.c       |  1 +
 t/helper/test-tool.h       |  1 +
 4 files changed, 64 insertions(+)
 create mode 100644 t/helper/test-hash-speed.c

diff --git a/Makefile b/Makefile
index 81dc9ac819..68169a7abb 100644
--- a/Makefile
+++ b/Makefile
@@ -716,6 +716,7 @@ TEST_BUILTINS_OBJS += test-example-decorate.o
 TEST_BUILTINS_OBJS += test-genrandom.o
 TEST_BUILTINS_OBJS += test-hash.o
 TEST_BUILTINS_OBJS += test-hashmap.o
+TEST_BUILTINS_OBJS += test-hash-speed.o
 TEST_BUILTINS_OBJS += test-index-version.o
 TEST_BUILTINS_OBJS += test-json-writer.o
 TEST_BUILTINS_OBJS += test-lazy-init-name-hash.o
diff --git a/t/helper/test-hash-speed.c b/t/helper/test-hash-speed.c
new file mode 100644
index 0000000000..432233c7f0
--- /dev/null
+++ b/t/helper/test-hash-speed.c
@@ -0,0 +1,61 @@
+#include "test-tool.h"
+#include "cache.h"
+
+#define NUM_SECONDS 3
+
+static inline void compute_hash(const struct git_hash_algo *algo, git_hash_ctx *ctx, uint8_t *final, const void *p, size_t len)
+{
+	algo->init_fn(ctx);
+	algo->update_fn(ctx, p, len);
+	algo->final_fn(final, ctx);
+}
+
+int cmd__hash_speed(int ac, const char **av)
+{
+	git_hash_ctx ctx;
+	unsigned char hash[GIT_MAX_RAWSZ];
+	clock_t initial, start, end;
+	unsigned bufsizes[] = { 64, 256, 1024, 8192, 16384 };
+	int i;
+	void *p;
+	const struct git_hash_algo *algo = NULL;
+
+	if (ac == 2) {
+		for (i = 1; i < GIT_HASH_NALGOS; i++) {
+			if (!strcmp(av[1], hash_algos[i].name)) {
+				algo = &hash_algos[i];
+				break;
+			}
+		}
+	}
+	if (!algo)
+		die("usage: test-tool hash-speed algo_name");
+
+	/* Use this as an offset to make overflow less likely. */
+	initial = clock();
+
+	printf("algo: %s\n", algo->name);
+
+	for (i = 0; i < ARRAY_SIZE(bufsizes); i++) {
+		unsigned long j, kb;
+		double kb_per_sec;
+		p = xcalloc(1, bufsizes[i]);
+		start = end = clock() - initial;
+		for (j = 0; ((end - start) / CLOCKS_PER_SEC) < NUM_SECONDS; j++) {
+			compute_hash(algo, &ctx, hash, p, bufsizes[i]);
+
+			/*
+			 * Only check elapsed time every 128 iterations to avoid
+			 * dominating the runtime with system calls.
+			 */
+			if (!(j & 127))
+				end = clock() - initial;
+		}
+		kb = j * bufsizes[i];
+		kb_per_sec = kb / (1024 * ((double)end - start) / CLOCKS_PER_SEC);
+		printf("size %u: %lu iters; %lu KiB; %0.2f KiB/s\n", bufsizes[i], j, kb, kb_per_sec);
+		free(p);
+	}
+
+	exit(0);
+}
diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
index 6b5836dc1b..e009c8186d 100644
--- a/t/helper/test-tool.c
+++ b/t/helper/test-tool.c
@@ -20,6 +20,7 @@ static struct test_cmd cmds[] = {
 	{ "example-decorate", cmd__example_decorate },
 	{ "genrandom", cmd__genrandom },
 	{ "hashmap", cmd__hashmap },
+	{ "hash-speed", cmd__hash_speed },
 	{ "index-version", cmd__index_version },
 	{ "json-writer", cmd__json_writer },
 	{ "lazy-init-name-hash", cmd__lazy_init_name_hash },
diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
index 29ac7b0b0d..19a7e8332a 100644
--- a/t/helper/test-tool.h
+++ b/t/helper/test-tool.h
@@ -16,6 +16,7 @@ int cmd__dump_untracked_cache(int argc, const char **argv);
 int cmd__example_decorate(int argc, const char **argv);
 int cmd__genrandom(int argc, const char **argv);
 int cmd__hashmap(int argc, const char **argv);
+int cmd__hash_speed(int argc, const char **argv);
 int cmd__index_version(int argc, const char **argv);
 int cmd__json_writer(int argc, const char **argv);
 int cmd__lazy_init_name_hash(int argc, const char **argv);
