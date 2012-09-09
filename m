From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 4/4] Add a function string_list_longest_prefix()
Date: Sun,  9 Sep 2012 07:53:10 +0200
Message-ID: <1347169990-9279-5-git-send-email-mhagger@alum.mit.edu>
References: <1347169990-9279-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Sep 09 07:54:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TAaTp-0003vs-Qc
	for gcvg-git-2@plane.gmane.org; Sun, 09 Sep 2012 07:54:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752164Ab2IIFye (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Sep 2012 01:54:34 -0400
Received: from ALUM-MAILSEC-SCANNER-2.MIT.EDU ([18.7.68.13]:49472 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751979Ab2IIFxy (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 9 Sep 2012 01:53:54 -0400
X-AuditID: 1207440d-b7f236d000000943-a4-504c2ef1fdc2
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id 0D.D1.02371.1FE2C405; Sun,  9 Sep 2012 01:53:53 -0400 (EDT)
Received: from michael.fritz.box (p57A25CBD.dip.t-dialin.net [87.162.92.189])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id q895raZD028212
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 9 Sep 2012 01:53:52 -0400
X-Mailer: git-send-email 1.7.11.3
In-Reply-To: <1347169990-9279-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrMIsWRmVeSWpSXmKPExsUixO6iqPtRzyfA4NR1eYuuK91MFg29V5gt
	bq+Yz+zA7PH3/Qcmj4uXlD0+b5ILYI7itklKLCkLzkzP07dL4M7oW7CCseCCWsX843vYGhjv
	yXUxcnJICJhIvPq4igXCFpO4cG89WxcjF4eQwGVGiVOtV5kgnDNMEg9v/mUCqWIT0JVY1NMM
	ZosIqElMbDsE1s0s4CCx+XMjI4gtDGSvmLcQzGYRUJV4+Gw6M4jNK+AscejrIXaIbYoSP76v
	AYtzCrhI3L66GywuBFTz/fNl9gmMvAsYGVYxyiXmlObq5iZm5hSnJusWJyfm5aUW6Rrp5WaW
	6KWmlG5ihAQL7w7G/+tkDjEKcDAq8fAy3/EOEGJNLCuuzD3EKMnBpCTKa67tEyDEl5SfUpmR
	WJwRX1Sak1p8iFGCg1lJhPcqO1CONyWxsiq1KB8mJc3BoiTOq7ZE3U9IID2xJDU7NbUgtQgm
	K8PBoSTBKwiMCiHBotT01Iq0zJwShDQTByeI4ALZwAO0wRikkLe4IDG3ODMdougUo6KUOC8v
	SEIAJJFRmgc3ABbXrxjFgf4R5lUDqeIBpgS47ldAg5mABos88wAZXJKIkJJqYOwvOhf/0u4Y
	n8dDPcPwzXb2C4rfxG3wuRDLfWlJxdqAaUtOnk5o/LFPZK7A4QdJL74w9Ze+2Gj6hLGXvXjB
	z3vJv/7vup1SdNPMQKfn4bZfLiFxXALtJ3K3uYtfNL3JFW3hnG7loKh+lXXpPOWZ2XsCzxbK
	+0/OOnFpkvGvzDfia/QL90z3Oq7EUpyRaKjFXFScCACcQxkPxgIAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205050>


Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 Documentation/technical/api-string-list.txt |  8 ++++++++
 string-list.c                               | 20 +++++++++++++++++++
 string-list.h                               |  8 ++++++++
 t/t0063-string-list.sh                      | 30 +++++++++++++++++++++++++++++
 test-string-list.c                          | 22 +++++++++++++++++++++
 5 files changed, 88 insertions(+)

diff --git a/Documentation/technical/api-string-list.txt b/Documentation/technical/api-string-list.txt
index 9206f8f..291ac4c 100644
--- a/Documentation/technical/api-string-list.txt
+++ b/Documentation/technical/api-string-list.txt
@@ -68,6 +68,14 @@ Functions
 	to be deleted.  Preserve the order of the items that are
 	retained.
 
+`string_list_longest_prefix`::
+
+	Return the longest string within a string_list that is a
+	prefix (in the sense of prefixcmp()) of the specified string,
+	or NULL if no such prefix exists.  This function does not
+	require the string_list to be sorted (it does a linear
+	search).
+
 `print_string_list`::
 
 	Dump a string_list to stdout, useful mainly for debugging purposes. It
diff --git a/string-list.c b/string-list.c
index bfef6cf..043f6c4 100644
--- a/string-list.c
+++ b/string-list.c
@@ -136,6 +136,26 @@ void filter_string_list(struct string_list *list, int free_util,
 	list->nr = dst;
 }
 
+char *string_list_longest_prefix(const struct string_list *prefixes,
+				 const char *string)
+{
+	int i, max_len = -1;
+	char *retval = NULL;
+
+	for (i = 0; i < prefixes->nr; i++) {
+		char *prefix = prefixes->items[i].string;
+		if (!prefixcmp(string, prefix)) {
+			int len = strlen(prefix);
+			if (len > max_len) {
+				retval = prefix;
+				max_len = len;
+			}
+		}
+	}
+
+	return retval;
+}
+
 void string_list_clear(struct string_list *list, int free_util)
 {
 	if (list->items) {
diff --git a/string-list.h b/string-list.h
index c4dc659..680916c 100644
--- a/string-list.h
+++ b/string-list.h
@@ -38,6 +38,14 @@ int for_each_string_list(struct string_list *list,
 void filter_string_list(struct string_list *list, int free_util,
 			string_list_each_func_t fn, void *cb_data);
 
+/*
+ * Return the longest string in prefixes that is a prefix (in the
+ * sense of prefixcmp()) of string, or NULL if no such prefix exists.
+ * This function does not require the string_list to be sorted (it
+ * does a linear search).
+ */
+char *string_list_longest_prefix(const struct string_list *prefixes, const char *string);
+
 
 /* Use these functions only on sorted lists: */
 int string_list_has_string(const struct string_list *list, const char *string);
diff --git a/t/t0063-string-list.sh b/t/t0063-string-list.sh
index 0eede83..fa96eba 100755
--- a/t/t0063-string-list.sh
+++ b/t/t0063-string-list.sh
@@ -15,6 +15,14 @@ string_list_split_in_place() {
 	"
 }
 
+longest_prefix() {
+	test "$(test-string-list longest_prefix "$1" "$2")" = "$3"
+}
+
+no_longest_prefix() {
+	test_must_fail test-string-list longest_prefix "$1" "$2"
+}
+
 string_list_split_in_place "foo:bar:baz" ":" "-1" <<EOF
 3
 [0]: "foo"
@@ -60,4 +68,26 @@ string_list_split_in_place ":" ":" "-1" <<EOF
 [1]: ""
 EOF
 
+test_expect_success "test longest_prefix" '
+	no_longest_prefix - '' &&
+	no_longest_prefix - x &&
+	longest_prefix "" x "" &&
+	longest_prefix x x x &&
+	longest_prefix "" foo "" &&
+	longest_prefix : foo "" &&
+	longest_prefix f foo f &&
+	longest_prefix foo foobar foo &&
+	longest_prefix foo foo foo &&
+	no_longest_prefix bar foo &&
+	no_longest_prefix bar:bar foo &&
+	no_longest_prefix foobar foo &&
+	longest_prefix foo:bar foo foo &&
+	longest_prefix foo:bar bar bar &&
+	longest_prefix foo::bar foo foo &&
+	longest_prefix foo:foobar foo foo &&
+	longest_prefix foobar:foo foo foo &&
+	longest_prefix foo: bar "" &&
+	longest_prefix :foo bar ""
+'
+
 test_done
diff --git a/test-string-list.c b/test-string-list.c
index f08d3cc..c7e71f2 100644
--- a/test-string-list.c
+++ b/test-string-list.c
@@ -19,6 +19,28 @@ int main(int argc, char **argv)
 		return 0;
 	}
 
+	if (argc == 4 && !strcmp(argv[1], "longest_prefix")) {
+		/* arguments: <colon-separated-prefixes>|- <string> */
+		struct string_list prefixes = STRING_LIST_INIT_NODUP;
+		int retval;
+		char *prefix_string = xstrdup(argv[2]);
+		char *string = argv[3];
+		char *match;
+
+		if (strcmp(prefix_string, "-"))
+			string_list_split_in_place(&prefixes, prefix_string, ':', -1);
+		match = string_list_longest_prefix(&prefixes, string);
+		if (match) {
+			printf("%s\n", match);
+			retval = 0;
+		}
+		else
+			retval = 1;
+		string_list_clear(&prefixes, 0);
+		free(prefix_string);
+		return retval;
+	}
+
 	fprintf(stderr, "%s: unknown function name: %s\n", argv[0],
 		argv[1] ? argv[1] : "(there was none)");
 	return 1;
-- 
1.7.11.3
