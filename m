From: David Barr <david.barr@cordelta.com>
Subject: =?UTF-8?q?=5BPATCH=207/9=5D=20vcs-svn=3A=20drop=20trp=2Eh?=
Date: Sat, 19 Mar 2011 18:03:49 +1100
Message-ID: <1300518231-20008-8-git-send-email-david.barr@cordelta.com>
References: <1300518231-20008-1-git-send-email-david.barr@cordelta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Sam Vilain <sam@vilain.net>, Stephen Bash <bash@genarts.com>,
	Tomas Carnecky <tom@dbservice.com>,
	David Barr <david.barr@cordelta.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Mar 19 08:12:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q0qLG-0004uk-OG
	for gcvg-git-2@lo.gmane.org; Sat, 19 Mar 2011 08:12:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755336Ab1CSHMm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 19 Mar 2011 03:12:42 -0400
Received: from [119.15.97.146] ([119.15.97.146]:51952 "EHLO mailhost.cordelta"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754071Ab1CSHMO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Mar 2011 03:12:14 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mailhost.cordelta (Postfix) with ESMTP id 40A10C053;
	Sat, 19 Mar 2011 18:00:40 +1100 (EST)
X-Virus-Scanned: amavisd-new at mailhost.cordelta
Received: from mailhost.cordelta ([127.0.0.1])
	by localhost (mailhost.cordelta [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3Z7MANCCI-Qa; Sat, 19 Mar 2011 18:00:33 +1100 (EST)
Received: from dba.cordelta (unknown [192.168.123.140])
	by mailhost.cordelta (Postfix) with ESMTP id 9CA1EC052;
	Sat, 19 Mar 2011 18:00:28 +1100 (EST)
X-Mailer: git-send-email 1.7.3.2.846.gf4b062
In-Reply-To: <1300518231-20008-1-git-send-email-david.barr@cordelta.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169392>

Signed-off-by: David Barr <david.barr@cordelta.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: David Barr <david.barr@cordelta.com>
---
 .gitignore         |    1 -
 Makefile           |    3 +-
 t/t0080-vcs-svn.sh |   22 -----
 test-treap.c       |   70 ---------------
 vcs-svn/LICENSE    |    3 -
 vcs-svn/trp.h      |  237 --------------------------------------------=
--------
 vcs-svn/trp.txt    |  109 ------------------------
 7 files changed, 1 insertions(+), 444 deletions(-)
 delete mode 100644 test-treap.c
 delete mode 100644 vcs-svn/trp.h
 delete mode 100644 vcs-svn/trp.txt

diff --git a/.gitignore b/.gitignore
index 215e842..aa94ff1 100644
--- a/.gitignore
+++ b/.gitignore
@@ -179,7 +179,6 @@
 /test-sigchain
 /test-subprocess
 /test-svn-fe
-/test-treap
 /common-cmds.h
 *.tar.gz
 *.dsc
diff --git a/Makefile b/Makefile
index f8182e5..2d56ab9 100644
--- a/Makefile
+++ b/Makefile
@@ -432,7 +432,6 @@ TEST_PROGRAMS_NEED_X +=3D test-sha1
 TEST_PROGRAMS_NEED_X +=3D test-sigchain
 TEST_PROGRAMS_NEED_X +=3D test-subprocess
 TEST_PROGRAMS_NEED_X +=3D test-svn-fe
-TEST_PROGRAMS_NEED_X +=3D test-treap
 TEST_PROGRAMS_NEED_X +=3D test-index-version
 TEST_PROGRAMS_NEED_X +=3D test-mktemp
=20
@@ -1963,7 +1962,7 @@ xdiff-interface.o $(XDIFF_OBJS): \
 	xdiff/xutils.h xdiff/xprepare.h xdiff/xdiffi.h xdiff/xemit.h
=20
 $(VCSSVN_OBJS) $(VCSSVN_TEST_OBJS): $(LIB_H) \
-	vcs-svn/obj_pool.h vcs-svn/trp.h \
+	vcs-svn/obj_pool.h \
 	vcs-svn/line_buffer.h vcs-svn/repo_tree.h vcs-svn/fast_export.h \
 	vcs-svn/svndump.h
=20
diff --git a/t/t0080-vcs-svn.sh b/t/t0080-vcs-svn.sh
index ce02c58..3f29496 100755
--- a/t/t0080-vcs-svn.sh
+++ b/t/t0080-vcs-svn.sh
@@ -76,26 +76,4 @@ test_expect_success 'obj pool: high-water mark' '
 	test_cmp expected actual
 '
=20
-test_expect_success 'treap sort' '
-	cat <<-\EOF >unsorted &&
-	68
-	12
-	13
-	13
-	68
-	13
-	13
-	21
-	10
-	11
-	12
-	13
-	13
-	EOF
-	sort unsorted >expected &&
-
-	test-treap <unsorted >actual &&
-	test_cmp expected actual
-'
-
 test_done
diff --git a/test-treap.c b/test-treap.c
deleted file mode 100644
index ab8c951..0000000
--- a/test-treap.c
+++ /dev/null
@@ -1,70 +0,0 @@
-/*
- * test-treap.c: code to exercise the svn importer's treap structure
- */
-
-#include "cache.h"
-#include "vcs-svn/obj_pool.h"
-#include "vcs-svn/trp.h"
-
-struct int_node {
-	uintmax_t n;
-	struct trp_node children;
-};
-
-obj_pool_gen(node, struct int_node, 3)
-
-static int node_cmp(struct int_node *a, struct int_node *b)
-{
-	return (a->n > b->n) - (a->n < b->n);
-}
-
-trp_gen(static, treap_, struct int_node, children, node, node_cmp)
-
-static void strtonode(struct int_node *item, const char *s)
-{
-	char *end;
-	item->n =3D strtoumax(s, &end, 10);
-	if (*s =3D=3D '\0' || (*end !=3D '\n' && *end !=3D '\0'))
-		die("invalid integer: %s", s);
-}
-
-int main(int argc, char *argv[])
-{
-	struct strbuf sb =3D STRBUF_INIT;
-	struct trp_root root =3D { ~0 };
-	uint32_t item;
-
-	if (argc !=3D 1)
-		usage("test-treap < ints");
-
-	while (strbuf_getline(&sb, stdin, '\n') !=3D EOF) {
-		struct int_node *node =3D node_pointer(node_alloc(1));
-
-		item =3D node_offset(node);
-		strtonode(node, sb.buf);
-		node =3D treap_insert(&root, node_pointer(item));
-		if (node_offset(node) !=3D item)
-			die("inserted %"PRIu32" in place of %"PRIu32"",
-				node_offset(node), item);
-	}
-
-	item =3D node_offset(treap_first(&root));
-	while (~item) {
-		uint32_t next;
-		struct int_node *tmp =3D node_pointer(node_alloc(1));
-
-		tmp->n =3D node_pointer(item)->n;
-		next =3D node_offset(treap_next(&root, node_pointer(item)));
-
-		treap_remove(&root, node_pointer(item));
-		item =3D node_offset(treap_nsearch(&root, tmp));
-
-		if (item !=3D next && (!~item || node_pointer(item)->n !=3D tmp->n))
-			die("found %"PRIuMAX" in place of %"PRIuMAX"",
-				~item ? node_pointer(item)->n : ~(uintmax_t) 0,
-				~next ? node_pointer(next)->n : ~(uintmax_t) 0);
-		printf("%"PRIuMAX"\n", tmp->n);
-	}
-	node_reset();
-	return 0;
-}
diff --git a/vcs-svn/LICENSE b/vcs-svn/LICENSE
index 0a5e3c4..533f585 100644
--- a/vcs-svn/LICENSE
+++ b/vcs-svn/LICENSE
@@ -1,9 +1,6 @@
 Copyright (C) 2010 David Barr <david.barr@cordelta.com>.
 All rights reserved.
=20
-Copyright (C) 2008 Jason Evans <jasone@canonware.com>.
-All rights reserved.
-
 Copyright (C) 2005 Stefan Hegny, hydrografix Consulting GmbH,
 Frankfurt/Main, Germany
 and others, see http://svn2cc.sarovar.org
diff --git a/vcs-svn/trp.h b/vcs-svn/trp.h
deleted file mode 100644
index c32b918..0000000
--- a/vcs-svn/trp.h
+++ /dev/null
@@ -1,237 +0,0 @@
-/*
- * C macro implementation of treaps.
- *
- * Usage:
- *   #include <stdint.h>
- *   #include "trp.h"
- *   trp_gen(...)
- *
- * Licensed under a two-clause BSD-style license.
- * See LICENSE for details.
- */
-
-#ifndef TRP_H_
-#define TRP_H_
-
-#define MAYBE_UNUSED __attribute__((__unused__))
-
-/* Node structure. */
-struct trp_node {
-	uint32_t trpn_left;
-	uint32_t trpn_right;
-};
-
-/* Root structure. */
-struct trp_root {
-	uint32_t trp_root;
-};
-
-/* Pointer/Offset conversion. */
-#define trpn_pointer(a_base, a_offset) (a_base##_pointer(a_offset))
-#define trpn_offset(a_base, a_pointer) (a_base##_offset(a_pointer))
-#define trpn_modify(a_base, a_offset) \
-	do { \
-		if ((a_offset) < a_base##_pool.committed) { \
-			uint32_t old_offset =3D (a_offset);\
-			(a_offset) =3D a_base##_alloc(1); \
-			*trpn_pointer(a_base, a_offset) =3D \
-				*trpn_pointer(a_base, old_offset); \
-		} \
-	} while (0)
-
-/* Left accessors. */
-#define trp_left_get(a_base, a_field, a_node) \
-	(trpn_pointer(a_base, a_node)->a_field.trpn_left)
-#define trp_left_set(a_base, a_field, a_node, a_left) \
-	do { \
-		trpn_modify(a_base, a_node); \
-		trp_left_get(a_base, a_field, a_node) =3D (a_left); \
-	} while (0)
-
-/* Right accessors. */
-#define trp_right_get(a_base, a_field, a_node) \
-	(trpn_pointer(a_base, a_node)->a_field.trpn_right)
-#define trp_right_set(a_base, a_field, a_node, a_right) \
-	do { \
-		trpn_modify(a_base, a_node); \
-		trp_right_get(a_base, a_field, a_node) =3D (a_right); \
-	} while (0)
-
-/*
- * Fibonacci hash function.
- * The multiplier is the nearest prime to (2^32 times (=E2=88=9A5 - 1)=
/2).
- * See Knuth =C2=A76.4: volume 3, 3rd ed, p518.
- */
-#define trpn_hash(a_node) (uint32_t) (2654435761u * (a_node))
-
-/* Priority accessors. */
-#define trp_prio_get(a_node) trpn_hash(a_node)
-
-/* Node initializer. */
-#define trp_node_new(a_base, a_field, a_node) \
-	do { \
-		trp_left_set(a_base, a_field, (a_node), ~0); \
-		trp_right_set(a_base, a_field, (a_node), ~0); \
-	} while (0)
-
-/* Internal utility macros. */
-#define trpn_first(a_base, a_field, a_root, r_node) \
-	do { \
-		(r_node) =3D (a_root); \
-		if ((r_node) =3D=3D ~0) \
-			return NULL; \
-		while (~trp_left_get(a_base, a_field, (r_node))) \
-			(r_node) =3D trp_left_get(a_base, a_field, (r_node)); \
-	} while (0)
-
-#define trpn_rotate_left(a_base, a_field, a_node, r_node) \
-	do { \
-		(r_node) =3D trp_right_get(a_base, a_field, (a_node)); \
-		trp_right_set(a_base, a_field, (a_node), \
-			trp_left_get(a_base, a_field, (r_node))); \
-		trp_left_set(a_base, a_field, (r_node), (a_node)); \
-	} while (0)
-
-#define trpn_rotate_right(a_base, a_field, a_node, r_node) \
-	do { \
-		(r_node) =3D trp_left_get(a_base, a_field, (a_node)); \
-		trp_left_set(a_base, a_field, (a_node), \
-			trp_right_get(a_base, a_field, (r_node))); \
-		trp_right_set(a_base, a_field, (r_node), (a_node)); \
-	} while (0)
-
-#define trp_gen(a_attr, a_pre, a_type, a_field, a_base, a_cmp) \
-a_attr a_type MAYBE_UNUSED *a_pre##first(struct trp_root *treap) \
-{ \
-	uint32_t ret; \
-	trpn_first(a_base, a_field, treap->trp_root, ret); \
-	return trpn_pointer(a_base, ret); \
-} \
-a_attr a_type MAYBE_UNUSED *a_pre##next(struct trp_root *treap, a_type=
 *node) \
-{ \
-	uint32_t ret; \
-	uint32_t offset =3D trpn_offset(a_base, node); \
-	if (~trp_right_get(a_base, a_field, offset)) { \
-		trpn_first(a_base, a_field, \
-			trp_right_get(a_base, a_field, offset), ret); \
-	} else { \
-		uint32_t tnode =3D treap->trp_root; \
-		ret =3D ~0; \
-		while (1) { \
-			int cmp =3D (a_cmp)(trpn_pointer(a_base, offset), \
-				trpn_pointer(a_base, tnode)); \
-			if (cmp < 0) { \
-				ret =3D tnode; \
-				tnode =3D trp_left_get(a_base, a_field, tnode); \
-			} else if (cmp > 0) { \
-				tnode =3D trp_right_get(a_base, a_field, tnode); \
-			} else { \
-				break; \
-			} \
-		} \
-	} \
-	return trpn_pointer(a_base, ret); \
-} \
-a_attr a_type MAYBE_UNUSED *a_pre##search(struct trp_root *treap, a_ty=
pe *key) \
-{ \
-	int cmp; \
-	uint32_t ret =3D treap->trp_root; \
-	while (~ret && (cmp =3D (a_cmp)(key, trpn_pointer(a_base, ret)))) { \
-		if (cmp < 0) { \
-			ret =3D trp_left_get(a_base, a_field, ret); \
-		} else { \
-			ret =3D trp_right_get(a_base, a_field, ret); \
-		} \
-	} \
-	return trpn_pointer(a_base, ret); \
-} \
-a_attr a_type MAYBE_UNUSED *a_pre##nsearch(struct trp_root *treap, a_t=
ype *key) \
-{ \
-	int cmp; \
-	uint32_t ret =3D treap->trp_root; \
-	while (~ret && (cmp =3D (a_cmp)(key, trpn_pointer(a_base, ret)))) { \
-		if (cmp < 0) { \
-			if (!~trp_left_get(a_base, a_field, ret)) \
-				break; \
-			ret =3D trp_left_get(a_base, a_field, ret); \
-		} else { \
-			ret =3D trp_right_get(a_base, a_field, ret); \
-		} \
-	} \
-	return trpn_pointer(a_base, ret); \
-} \
-a_attr uint32_t MAYBE_UNUSED a_pre##insert_recurse(uint32_t cur_node, =
uint32_t ins_node) \
-{ \
-	if (cur_node =3D=3D ~0) { \
-		return ins_node; \
-	} else { \
-		uint32_t ret; \
-		int cmp =3D (a_cmp)(trpn_pointer(a_base, ins_node), \
-					trpn_pointer(a_base, cur_node)); \
-		if (cmp < 0) { \
-			uint32_t left =3D a_pre##insert_recurse( \
-				trp_left_get(a_base, a_field, cur_node), ins_node); \
-			trp_left_set(a_base, a_field, cur_node, left); \
-			if (trp_prio_get(left) < trp_prio_get(cur_node)) \
-				trpn_rotate_right(a_base, a_field, cur_node, ret); \
-			else \
-				ret =3D cur_node; \
-		} else { \
-			uint32_t right =3D a_pre##insert_recurse( \
-				trp_right_get(a_base, a_field, cur_node), ins_node); \
-			trp_right_set(a_base, a_field, cur_node, right); \
-			if (trp_prio_get(right) < trp_prio_get(cur_node)) \
-				trpn_rotate_left(a_base, a_field, cur_node, ret); \
-			else \
-				ret =3D cur_node; \
-		} \
-		return ret; \
-	} \
-} \
-a_attr a_type *MAYBE_UNUSED a_pre##insert(struct trp_root *treap, a_ty=
pe *node) \
-{ \
-	uint32_t offset =3D trpn_offset(a_base, node); \
-	trp_node_new(a_base, a_field, offset); \
-	treap->trp_root =3D a_pre##insert_recurse(treap->trp_root, offset); \
-	return trpn_pointer(a_base, offset); \
-} \
-a_attr uint32_t MAYBE_UNUSED a_pre##remove_recurse(uint32_t cur_node, =
uint32_t rem_node) \
-{ \
-	int cmp =3D a_cmp(trpn_pointer(a_base, rem_node), \
-			trpn_pointer(a_base, cur_node)); \
-	if (cmp =3D=3D 0) { \
-		uint32_t ret; \
-		uint32_t left =3D trp_left_get(a_base, a_field, cur_node); \
-		uint32_t right =3D trp_right_get(a_base, a_field, cur_node); \
-		if (left =3D=3D ~0) { \
-			if (right =3D=3D ~0) \
-				return ~0; \
-		} else if (right =3D=3D ~0 || trp_prio_get(left) < trp_prio_get(righ=
t)) { \
-			trpn_rotate_right(a_base, a_field, cur_node, ret); \
-			right =3D a_pre##remove_recurse(cur_node, rem_node); \
-			trp_right_set(a_base, a_field, ret, right); \
-			return ret; \
-		} \
-		trpn_rotate_left(a_base, a_field, cur_node, ret); \
-		left =3D a_pre##remove_recurse(cur_node, rem_node); \
-		trp_left_set(a_base, a_field, ret, left); \
-		return ret; \
-	} else if (cmp < 0) { \
-		uint32_t left =3D a_pre##remove_recurse( \
-			trp_left_get(a_base, a_field, cur_node), rem_node); \
-		trp_left_set(a_base, a_field, cur_node, left); \
-		return cur_node; \
-	} else { \
-		uint32_t right =3D a_pre##remove_recurse( \
-			trp_right_get(a_base, a_field, cur_node), rem_node); \
-		trp_right_set(a_base, a_field, cur_node, right); \
-		return cur_node; \
-	} \
-} \
-a_attr void MAYBE_UNUSED a_pre##remove(struct trp_root *treap, a_type =
*node) \
-{ \
-	treap->trp_root =3D a_pre##remove_recurse(treap->trp_root, \
-		trpn_offset(a_base, node)); \
-} \
-
-#endif
diff --git a/vcs-svn/trp.txt b/vcs-svn/trp.txt
deleted file mode 100644
index 5ca6b42..0000000
--- a/vcs-svn/trp.txt
+++ /dev/null
@@ -1,109 +0,0 @@
-Motivation
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
-
-Treaps provide a memory-efficient binary search tree structure.
-Insertion/deletion/search are about as about as fast in the average
-case as red-black trees and the chances of worst-case behavior are
-vanishingly small, thanks to (pseudo-)randomness.  The bad worst-case
-behavior is a small price to pay, given that treaps are much simpler
-to implement.
-
-API
-=3D=3D=3D
-
-The trp API generates a data structure and functions to handle a
-large growing set of objects stored in a pool.
-
-The caller:
-
-. Specifies parameters for the generated functions with the
-  trp_gen(static, foo_, ...) macro.
-
-. Allocates a `struct trp_root` variable and sets it to {~0}.
-
-. Adds new nodes to the set using `foo_insert`.  Any pointers
-  to existing nodes cannot be relied upon any more, so the caller
-  might retrieve them anew with `foo_pointer`.
-
-. Can find a specific item in the set using `foo_search`.
-
-. Can iterate over items in the set using `foo_first` and `foo_next`.
-
-. Can remove an item from the set using `foo_remove`.
-
-Example:
-
-----
-struct ex_node {
-	const char *s;
-	struct trp_node ex_link;
-};
-static struct trp_root ex_base =3D {~0};
-obj_pool_gen(ex, struct ex_node, 4096);
-trp_gen(static, ex_, struct ex_node, ex_link, ex, strcmp)
-struct ex_node *item;
-
-item =3D ex_pointer(ex_alloc(1));
-item->s =3D "hello";
-ex_insert(&ex_base, item);
-item =3D ex_pointer(ex_alloc(1));
-item->s =3D "goodbye";
-ex_insert(&ex_base, item);
-for (item =3D ex_first(&ex_base); item; item =3D ex_next(&ex_base, ite=
m))
-	printf("%s\n", item->s);
-----
-
-Functions
----------
-
-trp_gen(attr, foo_, node_type, link_field, pool, cmp)::
-
-	Generate a type-specific treap implementation.
-+
-. The storage class for generated functions will be 'attr' (e.g., `sta=
tic`).
-. Generated function names are prefixed with 'foo_' (e.g., `treap_`).
-. Treap nodes will be of type 'node_type' (e.g., `struct treap_node`).
-  This type must be a struct with at least one `struct trp_node` field
-  to point to its children.
-. The field used to access child nodes will be 'link_field'.
-. All treap nodes must lie in the 'pool' object pool.
-. Treap nodes must be totally ordered by the 'cmp' relation, with the
-  following prototype:
-+
-int (*cmp)(node_type \*a, node_type \*b)
-+
-and returning a value less than, equal to, or greater than zero
-according to the result of comparison.
-
-node_type {asterisk}foo_insert(struct trp_root *treap, node_type \*nod=
e)::
-
-	Insert node into treap.  If inserted multiple times,
-	a node will appear in the treap multiple times.
-+
-The return value is the address of the node within the treap,
-which might differ from `node` if `pool_alloc` had to call
-`realloc` to expand the pool.
-
-void foo_remove(struct trp_root *treap, node_type \*node)::
-
-	Remove node from treap.  Caller must ensure node is
-	present in treap before using this function.
-
-node_type *foo_search(struct trp_root \*treap, node_type \*key)::
-
-	Search for a node that matches key.  If no match is found,
-	result is NULL.
-
-node_type *foo_nsearch(struct trp_root \*treap, node_type \*key)::
-
-	Like `foo_search`, but if if the key is missing return what
-	would be key's successor, were key in treap (NULL if no
-	successor).
-
-node_type *foo_first(struct trp_root \*treap)::
-
-	Find the first item from the treap, in sorted order.
-
-node_type *foo_next(struct trp_root \*treap, node_type \*node)::
-
-	Find the next item.
--=20
1.7.3.2.846.gf4b062
