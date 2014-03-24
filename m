From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 15/27] update-ref --stdin -z: Deprecate interpreting the empty string as zeros
Date: Mon, 24 Mar 2014 18:56:48 +0100
Message-ID: <1395683820-17304-16-git-send-email-mhagger@alum.mit.edu>
References: <1395683820-17304-1-git-send-email-mhagger@alum.mit.edu>
Cc: Brad King <brad.king@kitware.com>,
	Johan Herland <johan@herland.net>, Jeff King <peff@peff.net>,
	Vicent Marti <tanoku@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 24 18:57:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WS98A-00018N-6P
	for gcvg-git-2@plane.gmane.org; Mon, 24 Mar 2014 18:57:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753821AbaCXR5m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Mar 2014 13:57:42 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:54325 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753806AbaCXR5k (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 24 Mar 2014 13:57:40 -0400
X-AuditID: 12074413-f79076d000002d17-a5-53307213ab50
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id E2.F5.11543.31270335; Mon, 24 Mar 2014 13:57:39 -0400 (EDT)
Received: from michael.fritz.box (p57A25F6C.dip0.t-ipconnect.de [87.162.95.108])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s2OHv4xl028070
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Mon, 24 Mar 2014 13:57:37 -0400
X-Mailer: git-send-email 1.9.0
In-Reply-To: <1395683820-17304-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrAIsWRmVeSWpSXmKPExsUixO6iqCtcZBBsMH+JusXOdRIWXVe6mSwa
	eq8wW8y7u4vJ4vaK+cwWP1p6mC0+di5gdmD3+Pv+A5PHzll32T0uvfzO5vHx2XJ2j2e9exg9
	Ll5S9vi8SS6APYrbJimxpCw4Mz1P3y6BO+NgxwHmgrNyFdfW7GRuYLwr0cXIySEhYCJx824/
	E4QtJnHh3nq2LkYuDiGBy4wSjcuXsUI4J5gk1vSfYQepYhPQlVjU0wzWISKgJjGx7RALSBGz
	wBVGiSsft7OAJIQFEiUev3sN1MDBwSKgKtGxQhokzCvgKjHl0Fd2iG1yElN+LwCzOYHiW9sP
	M4PYQgIuEjs+9jJNYORdwMiwilEuMac0Vzc3MTOnODVZtzg5MS8vtUjXXC83s0QvNaV0EyMk
	9IR3MO46KXeIUYCDUYmHd4OpQbAQa2JZcWXuIUZJDiYlUV62XKAQX1J+SmVGYnFGfFFpTmrx
	IUYJDmYlEV7LcKAcb0piZVVqUT5MSpqDRUmcV22Jup+QQHpiSWp2ampBahFMVoaDQ0mCN6sA
	qFGwKDU9tSItM6cEIc3EwQkynEtKpDg1LyW1KLG0JCMeFBvxxcDoAEnxAO11KATZW1yQmAsU
	hWg9xagoJc57DWSuAEgiozQPbiwsobxiFAf6UphXDaSdB5iM4LpfAQ1mAhoc3qQHMrgkESEl
	1cAoxZkmc2uDY9KpuuSy3VqnjEXtIq7LP5r+aOfyep41RXe5dO5HnbnmrVKprvbPLXDlpyUW
	m+ucHr9IY3tpf/JCTt5v6Tk/NysVGPOIpOSLf/Y5LTPnw5cHos/fv+E17rodc/9h 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244840>

In the original version of this command, for the single case of the
"update" command's <newvalue>, the empty string was interpreted as
being equivalent to 40 "0"s.  This shorthand is unnecessary (binary
input will usually be generated programmatically anyway), and it
complicates the parser and the documentation.

So gently deprecate this usage: remove its description from the
documentation and emit a warning if it is found.  But for reasons of
backwards compatibility, continue to accept it.

Helped-by: Brad King <brad.king@kitware.com>
Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 Documentation/git-update-ref.txt | 18 ++++++++++++------
 builtin/update-ref.c             |  2 ++
 t/t1400-update-ref.sh            |  5 +++--
 3 files changed, 17 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-update-ref.txt b/Documentation/git-update-ref.txt
index 0a0a551..c8f5ae5 100644
--- a/Documentation/git-update-ref.txt
+++ b/Documentation/git-update-ref.txt
@@ -68,7 +68,12 @@ performs all modifications together.  Specify commands of the form:
 	option SP <opt> LF
 
 Quote fields containing whitespace as if they were strings in C source
-code.  Alternatively, use `-z` to specify commands without quoting:
+code; i.e., surrounded by double-quotes and with backslash escapes.
+Use 40 "0" characters or the empty string to specify a zero value.  To
+specify a missing value, omit the value and its preceding SP entirely.
+
+Alternatively, use `-z` to specify in NUL-terminated format, without
+quoting:
 
 	update SP <ref> NUL <newvalue> NUL [<oldvalue>] NUL
 	create SP <ref> NUL <newvalue> NUL
@@ -76,8 +81,12 @@ code.  Alternatively, use `-z` to specify commands without quoting:
 	verify SP <ref> NUL [<oldvalue>] NUL
 	option SP <opt> NUL
 
-Lines of any other format or a repeated <ref> produce an error.
-Command meanings are:
+In this format, use 40 "0" to specify a zero value, and use the empty
+string to specify a missing value.
+
+In either format, values can be specified in any form that Git
+recognizes as an object name.  Commands in any other format or a
+repeated <ref> produce an error.  Command meanings are:
 
 update::
 	Set <ref> to <newvalue> after verifying <oldvalue>, if given.
@@ -102,9 +111,6 @@ option::
 	The only valid option is `no-deref` to avoid dereferencing
 	a symbolic ref.
 
-Use 40 "0" or the empty string to specify a zero value, except that
-with `-z` an empty <oldvalue> is considered missing.
-
 If all <ref>s can be locked with matching <oldvalue>s
 simultaneously, all modifications are performed.  Otherwise, no
 modifications are performed.  Note that while each individual
diff --git a/builtin/update-ref.c b/builtin/update-ref.c
index 6462b2f..eef7537 100644
--- a/builtin/update-ref.c
+++ b/builtin/update-ref.c
@@ -154,6 +154,8 @@ static int parse_next_sha1(struct strbuf *input, const char **next,
 				goto invalid;
 		} else if (flags & PARSE_SHA1_ALLOW_EMPTY) {
 			/* With -z, treat an empty value as all zeros: */
+			warning("%s %s: missing <newvalue>, treating as zero",
+				command, refname);
 			hashclr(sha1);
 		} else {
 			/*
diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
index 15f5bfd..2d61cce 100755
--- a/t/t1400-update-ref.sh
+++ b/t/t1400-update-ref.sh
@@ -730,10 +730,11 @@ test_expect_success 'stdin -z fails update with bad ref name' '
 	grep "fatal: invalid ref format: ~a" err
 '
 
-test_expect_success 'stdin -z treats empty new value as zeros' '
+test_expect_success 'stdin -z emits warning with empty new value' '
 	git update-ref $a $m &&
 	printf $F "update $a" "" "" >stdin &&
-	git update-ref -z --stdin <stdin &&
+	git update-ref -z --stdin <stdin 2>err &&
+	grep "warning: update $a: missing <newvalue>, treating as zero" err &&
 	test_must_fail git rev-parse --verify -q $a
 '
 
-- 
1.9.0
