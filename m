Return-Path: <SRS0=sJPh=5P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 243A8C43331
	for <git@archiver.kernel.org>; Mon, 30 Mar 2020 14:04:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F04D420780
	for <git@archiver.kernel.org>; Mon, 30 Mar 2020 14:04:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727526AbgC3OEF (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Mar 2020 10:04:05 -0400
Received: from cloud.peff.net ([104.130.231.41]:55628 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727191AbgC3OEE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Mar 2020 10:04:04 -0400
Received: (qmail 15172 invoked by uid 109); 30 Mar 2020 14:04:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 30 Mar 2020 14:04:04 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18746 invoked by uid 111); 30 Mar 2020 14:14:07 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 30 Mar 2020 10:14:07 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 30 Mar 2020 10:04:03 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 4/7] test-tool: rename sha1-array to oid-array
Message-ID: <20200330140403.GD2456038@coredump.intra.peff.net>
References: <20200330140247.GA476088@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200330140247.GA476088@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This matches the actual data structure name, as well as the source file
that contains the code we're testing. The test scripts need updating to
use the new name, as well.

Signed-off-by: Jeff King <peff@peff.net>
---
 Makefile                                         |  2 +-
 t/helper/{test-sha1-array.c => test-oid-array.c} |  6 +++---
 t/helper/test-tool.c                             |  2 +-
 t/helper/test-tool.h                             |  2 +-
 t/t0064-sha1-array.sh                            | 16 ++++++++--------
 5 files changed, 14 insertions(+), 14 deletions(-)
 rename t/helper/{test-sha1-array.c => test-oid-array.c} (85%)

diff --git a/Makefile b/Makefile
index abfe5cc29b..dc356ce4dd 100644
--- a/Makefile
+++ b/Makefile
@@ -738,7 +738,7 @@ TEST_BUILTINS_OBJS += test-run-command.o
 TEST_BUILTINS_OBJS += test-scrap-cache-tree.o
 TEST_BUILTINS_OBJS += test-serve-v2.o
 TEST_BUILTINS_OBJS += test-sha1.o
-TEST_BUILTINS_OBJS += test-sha1-array.o
+TEST_BUILTINS_OBJS += test-oid-array.o
 TEST_BUILTINS_OBJS += test-sha256.o
 TEST_BUILTINS_OBJS += test-sigchain.o
 TEST_BUILTINS_OBJS += test-strcmp-offset.o
diff --git a/t/helper/test-sha1-array.c b/t/helper/test-oid-array.c
similarity index 85%
rename from t/helper/test-sha1-array.c
rename to t/helper/test-oid-array.c
index 6f7d3b939e..ce9fd5f091 100644
--- a/t/helper/test-sha1-array.c
+++ b/t/helper/test-oid-array.c
@@ -8,7 +8,7 @@ static int print_oid(const struct object_id *oid, void *data)
 	return 0;
 }
 
-int cmd__sha1_array(int argc, const char **argv)
+int cmd__oid_array(int argc, const char **argv)
 {
 	struct oid_array array = OID_ARRAY_INIT;
 	struct strbuf line = STRBUF_INIT;
@@ -19,11 +19,11 @@ int cmd__sha1_array(int argc, const char **argv)
 
 		if (skip_prefix(line.buf, "append ", &arg)) {
 			if (get_oid_hex(arg, &oid))
-				die("not a hexadecimal SHA1: %s", arg);
+				die("not a hexadecimal oid: %s", arg);
 			oid_array_append(&array, &oid);
 		} else if (skip_prefix(line.buf, "lookup ", &arg)) {
 			if (get_oid_hex(arg, &oid))
-				die("not a hexadecimal SHA1: %s", arg);
+				die("not a hexadecimal oid: %s", arg);
 			printf("%d\n", oid_array_lookup(&array, &oid));
 		} else if (!strcmp(line.buf, "clear"))
 			oid_array_clear(&array);
diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
index 31eedcd241..c1b320c24c 100644
--- a/t/helper/test-tool.c
+++ b/t/helper/test-tool.c
@@ -37,6 +37,7 @@ static struct test_cmd cmds[] = {
 	{ "match-trees", cmd__match_trees },
 	{ "mergesort", cmd__mergesort },
 	{ "mktemp", cmd__mktemp },
+	{ "oid-array", cmd__oid_array },
 	{ "oidmap", cmd__oidmap },
 	{ "online-cpus", cmd__online_cpus },
 	{ "parse-options", cmd__parse_options },
@@ -57,7 +58,6 @@ static struct test_cmd cmds[] = {
 	{ "scrap-cache-tree", cmd__scrap_cache_tree },
 	{ "serve-v2", cmd__serve_v2 },
 	{ "sha1", cmd__sha1 },
-	{ "sha1-array", cmd__sha1_array },
 	{ "sha256", cmd__sha256 },
 	{ "sigchain", cmd__sigchain },
 	{ "strcmp-offset", cmd__strcmp_offset },
diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
index 4eb5e6609e..1cbaec02f3 100644
--- a/t/helper/test-tool.h
+++ b/t/helper/test-tool.h
@@ -47,7 +47,7 @@ int cmd__run_command(int argc, const char **argv);
 int cmd__scrap_cache_tree(int argc, const char **argv);
 int cmd__serve_v2(int argc, const char **argv);
 int cmd__sha1(int argc, const char **argv);
-int cmd__sha1_array(int argc, const char **argv);
+int cmd__oid_array(int argc, const char **argv);
 int cmd__sha256(int argc, const char **argv);
 int cmd__sigchain(int argc, const char **argv);
 int cmd__strcmp_offset(int argc, const char **argv);
diff --git a/t/t0064-sha1-array.sh b/t/t0064-sha1-array.sh
index 5dda570b9a..45685af2fd 100755
--- a/t/t0064-sha1-array.sh
+++ b/t/t0064-sha1-array.sh
@@ -18,7 +18,7 @@ test_expect_success 'ordered enumeration' '
 	{
 		echoid append 88 44 aa 55 &&
 		echo for_each_unique
-	} | test-tool sha1-array >actual &&
+	} | test-tool oid-array >actual &&
 	test_cmp expect actual
 '
 
@@ -28,15 +28,15 @@ test_expect_success 'ordered enumeration with duplicate suppression' '
 		echoid append 88 44 aa 55 &&
 		echoid append 88 44 aa 55 &&
 		echo for_each_unique
-	} | test-tool sha1-array >actual &&
+	} | test-tool oid-array >actual &&
 	test_cmp expect actual
 '
 
 test_expect_success 'lookup' '
 	{
 		echoid append 88 44 aa 55 &&
 		echoid lookup 55
-	} | test-tool sha1-array >actual &&
+	} | test-tool oid-array >actual &&
 	n=$(cat actual) &&
 	test "$n" -eq 1
 '
@@ -45,7 +45,7 @@ test_expect_success 'lookup non-existing entry' '
 	{
 		echoid append 88 44 aa 55 &&
 		echoid lookup 33
-	} | test-tool sha1-array >actual &&
+	} | test-tool oid-array >actual &&
 	n=$(cat actual) &&
 	test "$n" -lt 0
 '
@@ -55,7 +55,7 @@ test_expect_success 'lookup with duplicates' '
 		echoid append 88 44 aa 55 &&
 		echoid append 88 44 aa 55 &&
 		echoid lookup 55
-	} | test-tool sha1-array >actual &&
+	} | test-tool oid-array >actual &&
 	n=$(cat actual) &&
 	test "$n" -ge 2 &&
 	test "$n" -le 3
@@ -66,7 +66,7 @@ test_expect_success 'lookup non-existing entry with duplicates' '
 		echoid append 88 44 aa 55 &&
 		echoid append 88 44 aa 55 &&
 		echoid lookup 66
-	} | test-tool sha1-array >actual &&
+	} | test-tool oid-array >actual &&
 	n=$(cat actual) &&
 	test "$n" -lt 0
 '
@@ -81,7 +81,7 @@ test_expect_success 'lookup with almost duplicate values' '
 		echo "append $id1" &&
 		echo "append $id2" &&
 		echoid lookup 55
-	} | test-tool sha1-array >actual &&
+	} | test-tool oid-array >actual &&
 	n=$(cat actual) &&
 	test "$n" -eq 0
 '
@@ -90,7 +90,7 @@ test_expect_success 'lookup with single duplicate value' '
 	{
 		echoid append 55 55 &&
 		echoid lookup 55
-	} | test-tool sha1-array >actual &&
+	} | test-tool oid-array >actual &&
 	n=$(cat actual) &&
 	test "$n" -ge 0 &&
 	test "$n" -le 1
-- 
2.26.0.597.g7e08ed78ff

