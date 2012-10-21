From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 8/8] string_list_longest_prefix(): remove function
Date: Sun, 21 Oct 2012 07:57:37 +0200
Message-ID: <1350799057-13846-9-git-send-email-mhagger@alum.mit.edu>
References: <1350799057-13846-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jiang Xin <worldhello.net@gmail.com>,
	Lea Wiemann <lewiemann@gmail.com>,
	David Reiss <dreiss@facebook.com>,
	Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Oct 21 07:59:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TPoYq-0006i8-HH
	for gcvg-git-2@plane.gmane.org; Sun, 21 Oct 2012 07:58:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751855Ab2JUF6m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Oct 2012 01:58:42 -0400
Received: from ALUM-MAILSEC-SCANNER-5.MIT.EDU ([18.7.68.17]:45460 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751811Ab2JUF6l (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 21 Oct 2012 01:58:41 -0400
X-AuditID: 12074411-b7fa36d0000008cc-b4-50838f0ff7e5
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id BF.C3.02252.F0F83805; Sun, 21 Oct 2012 01:58:39 -0400 (EDT)
Received: from michael.fritz.box (p57A24D34.dip.t-dialin.net [87.162.77.52])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id q9L5w2Wv013120
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 21 Oct 2012 01:58:38 -0400
X-Mailer: git-send-email 1.7.11.3
In-Reply-To: <1350799057-13846-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrGIsWRmVeSWpSXmKPExsUixO6iqMvf3xxgcPeLhcWRN0+YLbqudDNZ
	NPReYbZ4Mvcus8XRUxYWt1fMZ7ZY/+4qswO7x9/3H5g83rT3MnrsnHWX3ePhqy52j4uXlD0+
	b5ILYIvitklKLCkLzkzP07dL4M64PXMXe0GXdsWmS7vYGhiPKXUxcnJICJhIXFl9lxnCFpO4
	cG89WxcjF4eQwGVGiadnFzBDOGeYJD4+fc0EUsUmoCuxqKcZzBYRUJOY2HaIBaSIWeAOo8TC
	K2/ARgkLuEr86v8IVsQioCoxcdUxFhCbV8BF4s2O+6wQ6xQlfnxfA1bPCVR/ZdkcNhBbCKhm
	58b3jBMYeRcwMqxilEvMKc3VzU3MzClOTdYtTk7My0st0jXVy80s0UtNKd3ECAk5wR2MM07K
	HWIU4GBU4uGNsm0OEGJNLCuuzD3EKMnBpCTK+6IXKMSXlJ9SmZFYnBFfVJqTWnyIUYKDWUmE
	d7cgUI43JbGyKrUoHyYlzcGiJM7Lt0TdT0ggPbEkNTs1tSC1CCYrw8GhJMG7HWSoYFFqempF
	WmZOCUKaiYMTRHCBbOAB2nAapJC3uCAxtzgzHaLoFKOilDjvTZCEAEgiozQPbgAsObxiFAf6
	R5j3EkgVDzCxwHW/AhrMBDTYnLsRZHBJIkJKqoFx3X9HxVdF+3931cWYxPZfNOE8J7u49GXM
	/sUzf7zwuL/Nftt9xh1niv7YHL8p6GFzRXbzk5jePiHDOumrPvUvn2Wv1bJ47tu3QGTd32+Z
	bopXD30QZ2M3XvNAjuPvfAexWT966s5wT/Y7ZxZ0K5M/rHf9xQtbf4fr6a1p0zpl 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208107>

This function was added in f103f95b11d087f07c0c48bf784cd9197e18f203 in
the erroneous expectation that it would be used in the
reimplementation of longest_ancestor_length().  But it turned out to
be easier to use a function specialized for comparing path prefixes
(i.e., one that knows about slashes and root paths) than to prepare
the paths in such a way that a generic string prefix comparison
function can be used.  So delete string_list_longest_prefix() and its
documentation and test cases.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 Documentation/technical/api-string-list.txt |  8 --------
 string-list.c                               | 20 -------------------
 string-list.h                               |  8 --------
 t/t0063-string-list.sh                      | 30 -----------------------------
 test-string-list.c                          | 20 -------------------
 5 files changed, 86 deletions(-)

diff --git a/Documentation/technical/api-string-list.txt b/Documentation/technical/api-string-list.txt
index 94d7a2b..618400d 100644
--- a/Documentation/technical/api-string-list.txt
+++ b/Documentation/technical/api-string-list.txt
@@ -75,14 +75,6 @@ Functions
 	to be deleted.  Preserve the order of the items that are
 	retained.
 
-`string_list_longest_prefix`::
-
-	Return the longest string within a string_list that is a
-	prefix (in the sense of prefixcmp()) of the specified string,
-	or NULL if no such prefix exists.  This function does not
-	require the string_list to be sorted (it does a linear
-	search).
-
 `print_string_list`::
 
 	Dump a string_list to stdout, useful mainly for debugging purposes. It
diff --git a/string-list.c b/string-list.c
index c54b816..decfa74 100644
--- a/string-list.c
+++ b/string-list.c
@@ -136,26 +136,6 @@ void filter_string_list(struct string_list *list, int free_util,
 	list->nr = dst;
 }
 
-char *string_list_longest_prefix(const struct string_list *prefixes,
-				 const char *string)
-{
-	int i, max_len = -1;
-	char *retval = NULL;
-
-	for (i = 0; i < prefixes->nr; i++) {
-		char *prefix = prefixes->items[i].string;
-		if (!prefixcmp(string, prefix)) {
-			int len = strlen(prefix);
-			if (len > max_len) {
-				retval = prefix;
-				max_len = len;
-			}
-		}
-	}
-
-	return retval;
-}
-
 void string_list_clear(struct string_list *list, int free_util)
 {
 	if (list->items) {
diff --git a/string-list.h b/string-list.h
index 5efd07b..3a6a6dc 100644
--- a/string-list.h
+++ b/string-list.h
@@ -38,14 +38,6 @@ int for_each_string_list(struct string_list *list,
 void filter_string_list(struct string_list *list, int free_util,
 			string_list_each_func_t want, void *cb_data);
 
-/*
- * Return the longest string in prefixes that is a prefix (in the
- * sense of prefixcmp()) of string, or NULL if no such prefix exists.
- * This function does not require the string_list to be sorted (it
- * does a linear search).
- */
-char *string_list_longest_prefix(const struct string_list *prefixes, const char *string);
-
 
 /* Use these functions only on sorted lists: */
 int string_list_has_string(const struct string_list *list, const char *string);
diff --git a/t/t0063-string-list.sh b/t/t0063-string-list.sh
index 41c8826..dbfc05e 100755
--- a/t/t0063-string-list.sh
+++ b/t/t0063-string-list.sh
@@ -17,14 +17,6 @@ test_split () {
 	"
 }
 
-test_longest_prefix () {
-	test "$(test-string-list longest_prefix "$1" "$2")" = "$3"
-}
-
-test_no_longest_prefix () {
-	test_must_fail test-string-list longest_prefix "$1" "$2"
-}
-
 test_split "foo:bar:baz" ":" "-1" <<EOF
 3
 [0]: "foo"
@@ -96,26 +88,4 @@ test_expect_success "test remove_duplicates" '
 	test a:b:c = "$(test-string-list remove_duplicates a:a:a:b:b:b:c:c:c)"
 '
 
-test_expect_success "test longest_prefix" '
-	test_no_longest_prefix - '' &&
-	test_no_longest_prefix - x &&
-	test_longest_prefix "" x "" &&
-	test_longest_prefix x x x &&
-	test_longest_prefix "" foo "" &&
-	test_longest_prefix : foo "" &&
-	test_longest_prefix f foo f &&
-	test_longest_prefix foo foobar foo &&
-	test_longest_prefix foo foo foo &&
-	test_no_longest_prefix bar foo &&
-	test_no_longest_prefix bar:bar foo &&
-	test_no_longest_prefix foobar foo &&
-	test_longest_prefix foo:bar foo foo &&
-	test_longest_prefix foo:bar bar bar &&
-	test_longest_prefix foo::bar foo foo &&
-	test_longest_prefix foo:foobar foo foo &&
-	test_longest_prefix foobar:foo foo foo &&
-	test_longest_prefix foo: bar "" &&
-	test_longest_prefix :foo bar ""
-'
-
 test_done
diff --git a/test-string-list.c b/test-string-list.c
index 4693295..00ce6c9 100644
--- a/test-string-list.c
+++ b/test-string-list.c
@@ -97,26 +97,6 @@ int main(int argc, char **argv)
 		return 0;
 	}
 
-	if (argc == 4 && !strcmp(argv[1], "longest_prefix")) {
-		/* arguments: <colon-separated-prefixes>|- <string> */
-		struct string_list prefixes = STRING_LIST_INIT_DUP;
-		int retval;
-		const char *prefix_string = argv[2];
-		const char *string = argv[3];
-		const char *match;
-
-		parse_string_list(&prefixes, prefix_string);
-		match = string_list_longest_prefix(&prefixes, string);
-		if (match) {
-			printf("%s\n", match);
-			retval = 0;
-		}
-		else
-			retval = 1;
-		string_list_clear(&prefixes, 0);
-		return retval;
-	}
-
 	fprintf(stderr, "%s: unknown function name: %s\n", argv[0],
 		argv[1] ? argv[1] : "(there was none)");
 	return 1;
-- 
1.7.11.3
