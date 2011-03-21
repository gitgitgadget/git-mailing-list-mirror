From: David Barr <david.barr@cordelta.com>
Subject: [PATCH 08/11] vcs-svn: drop string_pool
Date: Tue, 22 Mar 2011 10:49:57 +1100
Message-ID: <1300751400-7427-9-git-send-email-david.barr@cordelta.com>
References: <1300518231-20008-1-git-send-email-david.barr@cordelta.com>
 <1300751400-7427-1-git-send-email-david.barr@cordelta.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Sam Vilain <sam@vilain.net>, Stephen Bash <bash@genarts.com>,
	Tomas Carnecky <tom@dbservice.com>,
	David Barr <david.barr@cordelta.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Mar 22 00:50:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q1ory-0006bP-T0
	for gcvg-git-2@lo.gmane.org; Tue, 22 Mar 2011 00:50:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755937Ab1CUXug (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Mar 2011 19:50:36 -0400
Received: from mailhost.cordelta.com ([119.15.97.146]:59624 "EHLO
	mailhost.cordelta" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754660Ab1CUXuZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Mar 2011 19:50:25 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mailhost.cordelta (Postfix) with ESMTP id C3684C052;
	Tue, 22 Mar 2011 10:46:57 +1100 (EST)
X-Virus-Scanned: amavisd-new at mailhost.cordelta
Received: from mailhost.cordelta ([127.0.0.1])
	by localhost (mailhost.cordelta [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pJeBbFFREa55; Tue, 22 Mar 2011 10:46:46 +1100 (EST)
Received: from dba.cordelta (unknown [192.168.123.140])
	by mailhost.cordelta (Postfix) with ESMTP id CC086C059;
	Tue, 22 Mar 2011 10:46:38 +1100 (EST)
X-Mailer: git-send-email 1.7.3.2.846.gf4b062
In-Reply-To: <1300751400-7427-1-git-send-email-david.barr@cordelta.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169690>

Signed-off-by: David Barr <david.barr@cordelta.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: David Barr <david.barr@cordelta.com>
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: David Barr <david.barr@cordelta.com>
---
 .gitignore              |    1 -
 Makefile                |   12 ++---
 t/t0080-vcs-svn.sh      |   16 -------
 test-string-pool.c      |   31 -------------
 vcs-svn/string_pool.c   |  113 -----------------------------------------------
 vcs-svn/string_pool.h   |   12 -----
 vcs-svn/string_pool.txt |   43 ------------------
 7 files changed, 4 insertions(+), 224 deletions(-)
 delete mode 100644 test-string-pool.c
 delete mode 100644 vcs-svn/string_pool.c
 delete mode 100644 vcs-svn/string_pool.h
 delete mode 100644 vcs-svn/string_pool.txt

diff --git a/.gitignore b/.gitignore
index c460c66..215e842 100644
--- a/.gitignore
+++ b/.gitignore
@@ -177,7 +177,6 @@
 /test-run-command
 /test-sha1
 /test-sigchain
-/test-string-pool
 /test-subprocess
 /test-svn-fe
 /test-treap
diff --git a/Makefile b/Makefile
index ade7923..f8182e5 100644
--- a/Makefile
+++ b/Makefile
@@ -430,7 +430,6 @@ TEST_PROGRAMS_NEED_X += test-path-utils
 TEST_PROGRAMS_NEED_X += test-run-command
 TEST_PROGRAMS_NEED_X += test-sha1
 TEST_PROGRAMS_NEED_X += test-sigchain
-TEST_PROGRAMS_NEED_X += test-string-pool
 TEST_PROGRAMS_NEED_X += test-subprocess
 TEST_PROGRAMS_NEED_X += test-svn-fe
 TEST_PROGRAMS_NEED_X += test-treap
@@ -1838,10 +1837,9 @@ ifndef NO_CURL
 endif
 XDIFF_OBJS = xdiff/xdiffi.o xdiff/xprepare.o xdiff/xutils.o xdiff/xemit.o \
 	xdiff/xmerge.o xdiff/xpatience.o
-VCSSVN_OBJS = vcs-svn/string_pool.o vcs-svn/line_buffer.o \
-	vcs-svn/repo_tree.o vcs-svn/fast_export.o vcs-svn/svndump.o
-VCSSVN_TEST_OBJS = test-obj-pool.o test-string-pool.o \
-	test-line-buffer.o test-treap.o
+VCSSVN_OBJS = vcs-svn/line_buffer.o vcs-svn/repo_tree.o \
+	vcs-svn/fast_export.o vcs-svn/svndump.o
+VCSSVN_TEST_OBJS = test-obj-pool.o test-line-buffer.o test-treap.o
 OBJECTS := $(GIT_OBJS) $(XDIFF_OBJS) $(VCSSVN_OBJS)
 
 dep_files := $(foreach f,$(OBJECTS),$(dir $f).depend/$(notdir $f).d)
@@ -1965,7 +1963,7 @@ xdiff-interface.o $(XDIFF_OBJS): \
 	xdiff/xutils.h xdiff/xprepare.h xdiff/xdiffi.h xdiff/xemit.h
 
 $(VCSSVN_OBJS) $(VCSSVN_TEST_OBJS): $(LIB_H) \
-	vcs-svn/obj_pool.h vcs-svn/trp.h vcs-svn/string_pool.h \
+	vcs-svn/obj_pool.h vcs-svn/trp.h \
 	vcs-svn/line_buffer.h vcs-svn/repo_tree.h vcs-svn/fast_export.h \
 	vcs-svn/svndump.h
 
@@ -2133,8 +2131,6 @@ test-line-buffer$X: vcs-svn/lib.a
 
 test-parse-options$X: parse-options.o
 
-test-string-pool$X: vcs-svn/lib.a
-
 test-svn-fe$X: vcs-svn/lib.a
 
 .PRECIOUS: $(TEST_OBJS)
diff --git a/t/t0080-vcs-svn.sh b/t/t0080-vcs-svn.sh
index 99a314b..ce02c58 100755
--- a/t/t0080-vcs-svn.sh
+++ b/t/t0080-vcs-svn.sh
@@ -76,22 +76,6 @@ test_expect_success 'obj pool: high-water mark' '
 	test_cmp expected actual
 '
 
-test_expect_success 'string pool' '
-	echo a does not equal b >expected.differ &&
-	echo a equals a >expected.match &&
-	echo equals equals equals >expected.matchmore &&
-
-	test-string-pool "a,--b" >actual.differ &&
-	test-string-pool "a,a" >actual.match &&
-	test-string-pool "equals-equals" >actual.matchmore &&
-	test_must_fail test-string-pool a,a,a &&
-	test_must_fail test-string-pool a &&
-
-	test_cmp expected.differ actual.differ &&
-	test_cmp expected.match actual.match &&
-	test_cmp expected.matchmore actual.matchmore
-'
-
 test_expect_success 'treap sort' '
 	cat <<-\EOF >unsorted &&
 	68
diff --git a/test-string-pool.c b/test-string-pool.c
deleted file mode 100644
index c5782e6..0000000
--- a/test-string-pool.c
+++ /dev/null
@@ -1,31 +0,0 @@
-/*
- * test-string-pool.c: code to exercise the svn importer's string pool
- */
-
-#include "git-compat-util.h"
-#include "vcs-svn/string_pool.h"
-
-int main(int argc, char *argv[])
-{
-	const uint32_t unequal = pool_intern("does not equal");
-	const uint32_t equal = pool_intern("equals");
-	uint32_t buf[3];
-	uint32_t n;
-
-	if (argc != 2)
-		usage("test-string-pool <string>,<string>");
-
-	n = pool_tok_seq(3, buf, ",-", argv[1]);
-	if (n >= 3)
-		die("too many strings");
-	if (n <= 1)
-		die("too few strings");
-
-	buf[2] = buf[1];
-	buf[1] = (buf[0] == buf[2]) ? equal : unequal;
-	pool_print_seq(3, buf, ' ', stdout);
-	fputc('\n', stdout);
-
-	pool_reset();
-	return 0;
-}
diff --git a/vcs-svn/string_pool.c b/vcs-svn/string_pool.c
deleted file mode 100644
index be43598..0000000
--- a/vcs-svn/string_pool.c
+++ /dev/null
@@ -1,113 +0,0 @@
-/*
- * Licensed under a two-clause BSD-style license.
- * See LICENSE for details.
- */
-
-#include "git-compat-util.h"
-#include "quote.h"
-#include "trp.h"
-#include "obj_pool.h"
-#include "string_pool.h"
-
-static struct trp_root tree = { ~0 };
-
-struct node {
-	uint32_t offset;
-	struct trp_node children;
-};
-
-/* Two memory pools: one for struct node, and another for strings */
-obj_pool_gen(node, struct node, 4096)
-obj_pool_gen(string, char, 4096)
-
-static char *node_value(struct node *node)
-{
-	return node ? string_pointer(node->offset) : NULL;
-}
-
-static int node_cmp(struct node *a, struct node *b)
-{
-	return strcmp(node_value(a), node_value(b));
-}
-
-/* Build a Treap from the node structure (a trp_node w/ offset) */
-trp_gen(static, tree_, struct node, children, node, node_cmp);
-
-const char *pool_fetch(uint32_t entry)
-{
-	return node_value(node_pointer(entry));
-}
-
-uint32_t pool_intern(const char *key)
-{
-	/* Canonicalize key */
-	struct node *match = NULL, *node;
-	uint32_t key_len;
-	if (key == NULL)
-		return ~0;
-	key_len = strlen(key) + 1;
-	node = node_pointer(node_alloc(1));
-	node->offset = string_alloc(key_len);
-	strcpy(node_value(node), key);
-	match = tree_search(&tree, node);
-	if (!match) {
-		tree_insert(&tree, node);
-	} else {
-		node_free(1);
-		string_free(key_len);
-		node = match;
-	}
-	return node_offset(node);
-}
-
-uint32_t pool_tok_r(char *str, const char *delim, char **saveptr)
-{
-	char *token = strtok_r(str, delim, saveptr);
-	return token ? pool_intern(token) : ~0;
-}
-
-void pool_print_seq(uint32_t len, const uint32_t *seq, char delim, FILE *stream)
-{
-	uint32_t i;
-	for (i = 0; i < len && ~seq[i]; i++) {
-		fputs(pool_fetch(seq[i]), stream);
-		if (i < len - 1 && ~seq[i + 1])
-			fputc(delim, stream);
-	}
-}
-
-void pool_print_seq_q(uint32_t len, const uint32_t *seq, char delim, FILE *stream)
-{
-	uint32_t i;
-	for (i = 0; i < len && ~seq[i]; i++) {
-		quote_c_style(pool_fetch(seq[i]), NULL, stream, 1);
-		if (i < len - 1 && ~seq[i + 1])
-			fputc(delim, stream);
-	}
-}
-
-uint32_t pool_tok_seq(uint32_t sz, uint32_t *seq, const char *delim, char *str)
-{
-	char *context = NULL;
-	uint32_t token = ~0;
-	uint32_t length;
-
-	if (sz == 0)
-		return ~0;
-	if (str)
-		token = pool_tok_r(str, delim, &context);
-	for (length = 0; length < sz; length++) {
-		seq[length] = token;
-		if (token == ~0)
-			return length;
-		token = pool_tok_r(NULL, delim, &context);
-	}
-	seq[sz - 1] = ~0;
-	return sz;
-}
-
-void pool_reset(void)
-{
-	node_reset();
-	string_reset();
-}
diff --git a/vcs-svn/string_pool.h b/vcs-svn/string_pool.h
deleted file mode 100644
index 96e501d..0000000
--- a/vcs-svn/string_pool.h
+++ /dev/null
@@ -1,12 +0,0 @@
-#ifndef STRING_POOL_H_
-#define STRING_POOL_H_
-
-uint32_t pool_intern(const char *key);
-const char *pool_fetch(uint32_t entry);
-uint32_t pool_tok_r(char *str, const char *delim, char **saveptr);
-void pool_print_seq(uint32_t len, const uint32_t *seq, char delim, FILE *stream);
-void pool_print_seq_q(uint32_t len, const uint32_t *seq, char delim, FILE *stream);
-uint32_t pool_tok_seq(uint32_t sz, uint32_t *seq, const char *delim, char *str);
-void pool_reset(void);
-
-#endif
diff --git a/vcs-svn/string_pool.txt b/vcs-svn/string_pool.txt
deleted file mode 100644
index 1b41f15..0000000
--- a/vcs-svn/string_pool.txt
+++ /dev/null
@@ -1,43 +0,0 @@
-string_pool API
-===============
-
-The string_pool API provides facilities for replacing strings
-with integer keys that can be more easily compared and stored.
-The facilities are designed so that one could teach Git without
-too much trouble to store the information needed for these keys to
-remain valid over multiple executions.
-
-Functions
----------
-
-pool_intern::
-	Include a string in the string pool and get its key.
-	If that string is already in the pool, retrieves its
-	existing key.
-
-pool_fetch::
-	Retrieve the string associated to a given key.
-
-pool_tok_r::
-	Extract the key of the next token from a string.
-	Interface mimics strtok_r.
-
-pool_print_seq::
-	Print a sequence of strings named by key to a file, using the
-	specified delimiter to separate them.
-
-	If NULL (key ~0) appears in the sequence, the sequence ends
-	early.
-
-pool_tok_seq::
-	Split a string into tokens, storing the keys of segments
-	into a caller-provided array.
-
-	Unless sz is 0, the array will always be ~0-terminated.
-	If there is not enough room for all the tokens, the
-	array holds as many tokens as fit in the entries before
-	the terminating ~0.  Return value is the index after the
-	last token, or sz if the tokens did not fit.
-
-pool_reset::
-	Deallocate storage for the string pool.
-- 
1.7.3.2.846.gf4b062
