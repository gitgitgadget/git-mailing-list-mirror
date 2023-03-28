Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B78CC6FD18
	for <git@archiver.kernel.org>; Tue, 28 Mar 2023 20:58:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbjC1U6V (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Mar 2023 16:58:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbjC1U6G (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Mar 2023 16:58:06 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AACBA3A82
        for <git@vger.kernel.org>; Tue, 28 Mar 2023 13:57:26 -0700 (PDT)
Received: (qmail 2321 invoked by uid 109); 28 Mar 2023 20:57:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 28 Mar 2023 20:57:26 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2248 invoked by uid 111); 28 Mar 2023 20:57:25 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 28 Mar 2023 16:57:25 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 28 Mar 2023 16:57:25 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 6/7] t/helper: mark unused argv/argc arguments
Message-ID: <20230328205725.GF1754055@coredump.intra.peff.net>
References: <20230328205253.GA1753925@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230328205253.GA1753925@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Many test helper programs do not bother to look at argc or argv, because
they don't take any options. In a user-facing program, it's a good idea
to check for unexpected arguments and complain. But for a test helper,
it's not worth the trouble to enforce this.

But we do want to tell the compiler we're OK with ignoring them, to
silence -Wunused-parameter (and obviously we can't get rid of them,
since we have to conform to the usual cmd__foo() interface).

Signed-off-by: Jeff King <peff@peff.net>
---
 t/helper/test-ctype.c                | 2 +-
 t/helper/test-date.c                 | 2 +-
 t/helper/test-drop-caches.c          | 2 +-
 t/helper/test-dump-cache-tree.c      | 2 +-
 t/helper/test-dump-fsmonitor.c       | 2 +-
 t/helper/test-dump-split-index.c     | 2 +-
 t/helper/test-dump-untracked-cache.c | 2 +-
 t/helper/test-example-decorate.c     | 2 +-
 t/helper/test-fsmonitor-client.c     | 2 +-
 t/helper/test-hexdump.c              | 2 +-
 t/helper/test-index-version.c        | 2 +-
 t/helper/test-match-trees.c          | 2 +-
 t/helper/test-oid-array.c            | 2 +-
 t/helper/test-oidmap.c               | 2 +-
 t/helper/test-oidtree.c              | 4 ++--
 t/helper/test-online-cpus.c          | 2 +-
 t/helper/test-parse-options.c        | 4 ++--
 t/helper/test-prio-queue.c           | 2 +-
 t/helper/test-read-graph.c           | 2 +-
 t/helper/test-ref-store.c            | 5 +++--
 t/helper/test-scrap-cache-tree.c     | 2 +-
 t/helper/test-sigchain.c             | 2 +-
 t/helper/test-strcmp-offset.c        | 2 +-
 t/helper/test-submodule-config.c     | 2 +-
 t/helper/test-submodule.c            | 2 +-
 t/helper/test-trace2.c               | 6 +++---
 t/helper/test-xml-encode.c           | 2 +-
 27 files changed, 33 insertions(+), 32 deletions(-)

diff --git a/t/helper/test-ctype.c b/t/helper/test-ctype.c
index 534ca66441c..71a1a5c9b04 100644
--- a/t/helper/test-ctype.c
+++ b/t/helper/test-ctype.c
@@ -47,7 +47,7 @@ static int is_in(const char *s, int ch)
 	"\x10\x11\x12\x13\x14\x15\x16\x17\x18\x19\x1a\x1b\x1c\x1d\x1e\x1f" \
 	"\x7f"
 
-int cmd__ctype(int argc, const char **argv)
+int cmd__ctype(int argc UNUSED, const char **argv UNUSED)
 {
 	TEST_CLASS(isdigit, DIGIT);
 	TEST_CLASS(isspace, " \n\r\t");
diff --git a/t/helper/test-date.c b/t/helper/test-date.c
index 45951b1df87..cd6a6df7023 100644
--- a/t/helper/test-date.c
+++ b/t/helper/test-date.c
@@ -104,7 +104,7 @@ static void getnanos(const char **argv)
 	printf("%lf\n", seconds);
 }
 
-int cmd__date(int argc, const char **argv)
+int cmd__date(int argc UNUSED, const char **argv)
 {
 	const char *x;
 
diff --git a/t/helper/test-drop-caches.c b/t/helper/test-drop-caches.c
index e37396dd9c2..73e551cfc22 100644
--- a/t/helper/test-drop-caches.c
+++ b/t/helper/test-drop-caches.c
@@ -155,7 +155,7 @@ static int cmd_dropcaches(void)
 
 #endif
 
-int cmd__drop_caches(int argc, const char **argv)
+int cmd__drop_caches(int argc UNUSED, const char **argv UNUSED)
 {
 	cmd_sync();
 	return cmd_dropcaches();
diff --git a/t/helper/test-dump-cache-tree.c b/t/helper/test-dump-cache-tree.c
index 92dfc1aa8c4..ba1c5ce7175 100644
--- a/t/helper/test-dump-cache-tree.c
+++ b/t/helper/test-dump-cache-tree.c
@@ -57,7 +57,7 @@ static int dump_cache_tree(struct cache_tree *it,
 	return errs;
 }
 
-int cmd__dump_cache_tree(int ac, const char **av)
+int cmd__dump_cache_tree(int ac UNUSED, const char **av UNUSED)
 {
 	struct index_state istate;
 	struct cache_tree *another = cache_tree();
diff --git a/t/helper/test-dump-fsmonitor.c b/t/helper/test-dump-fsmonitor.c
index 975f0ac8905..3d2fb92ade8 100644
--- a/t/helper/test-dump-fsmonitor.c
+++ b/t/helper/test-dump-fsmonitor.c
@@ -1,7 +1,7 @@
 #include "test-tool.h"
 #include "cache.h"
 
-int cmd__dump_fsmonitor(int ac, const char **av)
+int cmd__dump_fsmonitor(int ac UNUSED, const char **av UNUSED)
 {
 	struct index_state *istate = the_repository->index;
 	int i;
diff --git a/t/helper/test-dump-split-index.c b/t/helper/test-dump-split-index.c
index 813d0a38fae..4fabbdea496 100644
--- a/t/helper/test-dump-split-index.c
+++ b/t/helper/test-dump-split-index.c
@@ -10,7 +10,7 @@ static void show_bit(size_t pos, void *data)
 	printf(" %d", (int)pos);
 }
 
-int cmd__dump_split_index(int ac, const char **av)
+int cmd__dump_split_index(int ac UNUSED, const char **av)
 {
 	struct split_index *si;
 	int i;
diff --git a/t/helper/test-dump-untracked-cache.c b/t/helper/test-dump-untracked-cache.c
index af953fabe87..bc1ef8d4dc0 100644
--- a/t/helper/test-dump-untracked-cache.c
+++ b/t/helper/test-dump-untracked-cache.c
@@ -41,7 +41,7 @@ static void dump(struct untracked_cache_dir *ucd, struct strbuf *base)
 	strbuf_setlen(base, len);
 }
 
-int cmd__dump_untracked_cache(int ac, const char **av)
+int cmd__dump_untracked_cache(int ac UNUSED, const char **av UNUSED)
 {
 	struct untracked_cache *uc;
 	struct strbuf base = STRBUF_INIT;
diff --git a/t/helper/test-example-decorate.c b/t/helper/test-example-decorate.c
index 7c7fc8efc13..2cf302ffcb3 100644
--- a/t/helper/test-example-decorate.c
+++ b/t/helper/test-example-decorate.c
@@ -3,7 +3,7 @@
 #include "object.h"
 #include "decorate.h"
 
-int cmd__example_decorate(int argc, const char **argv)
+int cmd__example_decorate(int argc UNUSED, const char **argv UNUSED)
 {
 	struct decoration n;
 	struct object_id one_oid = { {1} };
diff --git a/t/helper/test-fsmonitor-client.c b/t/helper/test-fsmonitor-client.c
index 54a4856c48c..0a1e492e5bc 100644
--- a/t/helper/test-fsmonitor-client.c
+++ b/t/helper/test-fsmonitor-client.c
@@ -11,7 +11,7 @@
 #include "trace2.h"
 
 #ifndef HAVE_FSMONITOR_DAEMON_BACKEND
-int cmd__fsmonitor_client(int argc, const char **argv)
+int cmd__fsmonitor_client(int argc UNUSED, const char **argv UNUSED)
 {
 	die("fsmonitor--daemon not available on this platform");
 }
diff --git a/t/helper/test-hexdump.c b/t/helper/test-hexdump.c
index 811e89c1bcb..05f55eca21a 100644
--- a/t/helper/test-hexdump.c
+++ b/t/helper/test-hexdump.c
@@ -4,7 +4,7 @@
 /*
  * Read stdin and print a hexdump to stdout.
  */
-int cmd__hexdump(int argc, const char **argv)
+int cmd__hexdump(int argc UNUSED, const char **argv UNUSED)
 {
 	char buf[1024];
 	ssize_t i, len;
diff --git a/t/helper/test-index-version.c b/t/helper/test-index-version.c
index fcd10968cc1..a06c45c1f84 100644
--- a/t/helper/test-index-version.c
+++ b/t/helper/test-index-version.c
@@ -1,7 +1,7 @@
 #include "test-tool.h"
 #include "cache.h"
 
-int cmd__index_version(int argc, const char **argv)
+int cmd__index_version(int argc UNUSED, const char **argv UNUSED)
 {
 	struct cache_header hdr;
 	int version;
diff --git a/t/helper/test-match-trees.c b/t/helper/test-match-trees.c
index 04bc2563f3e..184aa1a0870 100644
--- a/t/helper/test-match-trees.c
+++ b/t/helper/test-match-trees.c
@@ -3,7 +3,7 @@
 #include "hex.h"
 #include "tree.h"
 
-int cmd__match_trees(int ac, const char **av)
+int cmd__match_trees(int ac UNUSED, const char **av)
 {
 	struct object_id hash1, hash2, shifted;
 	struct tree *one, *two;
diff --git a/t/helper/test-oid-array.c b/t/helper/test-oid-array.c
index 0906993ad59..c3a1a00466a 100644
--- a/t/helper/test-oid-array.c
+++ b/t/helper/test-oid-array.c
@@ -9,7 +9,7 @@ static int print_oid(const struct object_id *oid, void *data)
 	return 0;
 }
 
-int cmd__oid_array(int argc, const char **argv)
+int cmd__oid_array(int argc UNUSED, const char **argv UNUSED)
 {
 	struct oid_array array = OID_ARRAY_INIT;
 	struct strbuf line = STRBUF_INIT;
diff --git a/t/helper/test-oidmap.c b/t/helper/test-oidmap.c
index 883d40efd45..ee92ae84949 100644
--- a/t/helper/test-oidmap.c
+++ b/t/helper/test-oidmap.c
@@ -22,7 +22,7 @@ struct test_entry {
  * iterate -> oidkey1 namevalue1\noidkey2 namevalue2\n...
  *
  */
-int cmd__oidmap(int argc, const char **argv)
+int cmd__oidmap(int argc UNUSED, const char **argv UNUSED)
 {
 	struct strbuf line = STRBUF_INIT;
 	struct oidmap map = OIDMAP_INIT;
diff --git a/t/helper/test-oidtree.c b/t/helper/test-oidtree.c
index 0b82431a70f..6a18e1bce80 100644
--- a/t/helper/test-oidtree.c
+++ b/t/helper/test-oidtree.c
@@ -3,13 +3,13 @@
 #include "hex.h"
 #include "oidtree.h"
 
-static enum cb_next print_oid(const struct object_id *oid, void *data)
+static enum cb_next print_oid(const struct object_id *oid, void *data UNUSED)
 {
 	puts(oid_to_hex(oid));
 	return CB_CONTINUE;
 }
 
-int cmd__oidtree(int argc, const char **argv)
+int cmd__oidtree(int argc UNUSED, const char **argv UNUSED)
 {
 	struct oidtree ot;
 	struct strbuf line = STRBUF_INIT;
diff --git a/t/helper/test-online-cpus.c b/t/helper/test-online-cpus.c
index 8cb0d53840f..47dc2117112 100644
--- a/t/helper/test-online-cpus.c
+++ b/t/helper/test-online-cpus.c
@@ -2,7 +2,7 @@
 #include "git-compat-util.h"
 #include "thread-utils.h"
 
-int cmd__online_cpus(int argc, const char **argv)
+int cmd__online_cpus(int argc UNUSED, const char **argv UNUSED)
 {
 	printf("%d\n", online_cpus());
 	return 0;
diff --git a/t/helper/test-parse-options.c b/t/helper/test-parse-options.c
index 506835521a4..b66039e5751 100644
--- a/t/helper/test-parse-options.c
+++ b/t/helper/test-parse-options.c
@@ -263,14 +263,14 @@ int cmd__parse_options_flags(int argc, const char **argv)
 	return parse_options_flags__cmd(argc, argv, test_flags);
 }
 
-static int subcmd_one(int argc, const char **argv, const char *prefix)
+static int subcmd_one(int argc, const char **argv, const char *prefix UNUSED)
 {
 	printf("fn: subcmd_one\n");
 	print_args(argc, argv);
 	return 0;
 }
 
-static int subcmd_two(int argc, const char **argv, const char *prefix)
+static int subcmd_two(int argc, const char **argv, const char *prefix UNUSED)
 {
 	printf("fn: subcmd_two\n");
 	print_args(argc, argv);
diff --git a/t/helper/test-prio-queue.c b/t/helper/test-prio-queue.c
index 4915412e074..f0bf255f5f0 100644
--- a/t/helper/test-prio-queue.c
+++ b/t/helper/test-prio-queue.c
@@ -16,7 +16,7 @@ static void show(int *v)
 	free(v);
 }
 
-int cmd__prio_queue(int argc, const char **argv)
+int cmd__prio_queue(int argc UNUSED, const char **argv)
 {
 	struct prio_queue pq = { intcmp };
 
diff --git a/t/helper/test-read-graph.c b/t/helper/test-read-graph.c
index 98b73bb8f25..f92aea9d1fd 100644
--- a/t/helper/test-read-graph.c
+++ b/t/helper/test-read-graph.c
@@ -5,7 +5,7 @@
 #include "object-store.h"
 #include "bloom.h"
 
-int cmd__read_graph(int argc, const char **argv)
+int cmd__read_graph(int argc UNUSED, const char **argv UNUSED)
 {
 	struct commit_graph *graph = NULL;
 	struct object_directory *odb;
diff --git a/t/helper/test-ref-store.c b/t/helper/test-ref-store.c
index 1745b088b7c..31c79a777a0 100644
--- a/t/helper/test-ref-store.c
+++ b/t/helper/test-ref-store.c
@@ -201,7 +201,8 @@ static int cmd_verify_ref(struct ref_store *refs, const char **argv)
 	return ret;
 }
 
-static int cmd_for_each_reflog(struct ref_store *refs, const char **argv)
+static int cmd_for_each_reflog(struct ref_store *refs,
+			       const char **argv UNUSED)
 {
 	return refs_for_each_reflog(refs, each_ref, NULL);
 }
@@ -323,7 +324,7 @@ static struct command commands[] = {
 	{ NULL, NULL }
 };
 
-int cmd__ref_store(int argc, const char **argv)
+int cmd__ref_store(int argc UNUSED, const char **argv)
 {
 	struct ref_store *refs;
 	const char *func;
diff --git a/t/helper/test-scrap-cache-tree.c b/t/helper/test-scrap-cache-tree.c
index a26107ed70a..8a42c475b3b 100644
--- a/t/helper/test-scrap-cache-tree.c
+++ b/t/helper/test-scrap-cache-tree.c
@@ -5,7 +5,7 @@
 #include "tree.h"
 #include "cache-tree.h"
 
-int cmd__scrap_cache_tree(int ac, const char **av)
+int cmd__scrap_cache_tree(int ac UNUSED, const char **av UNUSED)
 {
 	struct lock_file index_lock = LOCK_INIT;
 
diff --git a/t/helper/test-sigchain.c b/t/helper/test-sigchain.c
index d1cf7377b7c..2d5ecf73831 100644
--- a/t/helper/test-sigchain.c
+++ b/t/helper/test-sigchain.c
@@ -13,7 +13,7 @@ X(two)
 X(three)
 #undef X
 
-int cmd__sigchain(int argc, const char **argv)
+int cmd__sigchain(int argc UNUSED, const char **argv UNUSED)
 {
 	sigchain_push(SIGTERM, one);
 	sigchain_push(SIGTERM, two);
diff --git a/t/helper/test-strcmp-offset.c b/t/helper/test-strcmp-offset.c
index 44e4a6d143e..96b9a5b5291 100644
--- a/t/helper/test-strcmp-offset.c
+++ b/t/helper/test-strcmp-offset.c
@@ -1,7 +1,7 @@
 #include "test-tool.h"
 #include "cache.h"
 
-int cmd__strcmp_offset(int argc, const char **argv)
+int cmd__strcmp_offset(int argc UNUSED, const char **argv)
 {
 	int result;
 	size_t offset;
diff --git a/t/helper/test-submodule-config.c b/t/helper/test-submodule-config.c
index 22a41c40926..edeee41abdd 100644
--- a/t/helper/test-submodule-config.c
+++ b/t/helper/test-submodule-config.c
@@ -4,7 +4,7 @@
 #include "submodule-config.h"
 #include "submodule.h"
 
-static void die_usage(int argc, const char **argv, const char *msg)
+static void die_usage(int argc UNUSED, const char **argv, const char *msg)
 {
 	fprintf(stderr, "%s\n", msg);
 	fprintf(stderr, "Usage: %s [<commit> <submodulepath>] ...\n", argv[0]);
diff --git a/t/helper/test-submodule.c b/t/helper/test-submodule.c
index e060cc62268..3b75358723c 100644
--- a/t/helper/test-submodule.c
+++ b/t/helper/test-submodule.c
@@ -174,7 +174,7 @@ static int cmd__submodule_config_unset(int argc, const char **argv)
 	usage_with_options(usage, options);
 }
 
-static int cmd__submodule_config_writeable(int argc, const char **argv)
+static int cmd__submodule_config_writeable(int argc, const char **argv UNUSED)
 {
 	struct option options[] = {
 		OPT_END()
diff --git a/t/helper/test-trace2.c b/t/helper/test-trace2.c
index f374c21ec32..688c8d017db 100644
--- a/t/helper/test-trace2.c
+++ b/t/helper/test-trace2.c
@@ -208,23 +208,23 @@ static int ut_007BUG(int argc, const char **argv)
 	BUG("the bug message");
 }
 
-static int ut_008bug(int argc, const char **argv)
+static int ut_008bug(int argc UNUSED, const char **argv UNUSED)
 {
 	bug("a bug message");
 	bug("another bug message");
 	BUG_if_bug("an explicit BUG_if_bug() following bug() call(s) is nice, but not required");
 	return 0;
 }
 
-static int ut_009bug_BUG(int argc, const char **argv)
+static int ut_009bug_BUG(int argc UNUSED, const char **argv UNUSED)
 {
 	bug("a bug message");
 	bug("another bug message");
 	/* The BUG_if_bug(...) isn't here, but we'll spot bug() calls on exit()! */
 	return 0;
 }
 
-static int ut_010bug_BUG(int argc, const char **argv)
+static int ut_010bug_BUG(int argc UNUSED, const char **argv UNUSED)
 {
 	bug("a %s message", "bug");
 	BUG("a %s message", "BUG");
diff --git a/t/helper/test-xml-encode.c b/t/helper/test-xml-encode.c
index a648bbd961c..b2f330d1a44 100644
--- a/t/helper/test-xml-encode.c
+++ b/t/helper/test-xml-encode.c
@@ -6,7 +6,7 @@ static const char *utf8_replace_character = "&#xfffd;";
  * Encodes (possibly incorrect) UTF-8 on <stdin> to <stdout>, to be embedded
  * in an XML file.
  */
-int cmd__xml_encode(int argc, const char **argv)
+int cmd__xml_encode(int argc UNUSED, const char **argv UNUSED)
 {
 	unsigned char buf[1024], tmp[4], *tmp2 = NULL;
 	ssize_t cur = 0, len = 1, remaining = 0;
-- 
2.40.0.675.gb17cd5d94c8

