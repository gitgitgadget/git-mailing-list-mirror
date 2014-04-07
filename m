From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 15/27] update-ref --stdin -z: deprecate interpreting the empty string as zeros
Date: Mon,  7 Apr 2014 15:48:06 +0200
Message-ID: <1396878498-19887-16-git-send-email-mhagger@alum.mit.edu>
References: <1396878498-19887-1-git-send-email-mhagger@alum.mit.edu>
Cc: Brad King <brad.king@kitware.com>,
	Johan Herland <johan@herland.net>, Jeff King <peff@peff.net>,
	Vicent Marti <tanoku@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 07 15:50:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WX9wB-0003at-RJ
	for gcvg-git-2@plane.gmane.org; Mon, 07 Apr 2014 15:50:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755420AbaDGNuE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Apr 2014 09:50:04 -0400
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:47896 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755374AbaDGNsy (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 Apr 2014 09:48:54 -0400
X-AuditID: 12074414-f79d96d000002d2b-ce-5342acc57bfa
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id E7.9A.11563.5CCA2435; Mon,  7 Apr 2014 09:48:53 -0400 (EDT)
Received: from michael.fritz.box (p5B156B1D.dip0.t-ipconnect.de [91.21.107.29])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s37DmJaM026029
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Mon, 7 Apr 2014 09:48:51 -0400
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1396878498-19887-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrHIsWRmVeSWpSXmKPExsUixO6iqHt0jVOwwaGPIhY710lYdF3pZrJo
	6L3CbDHv7i4mi9sr5jNb/GjpYbb42LmA2YHd4+/7D0weO2fdZfe49PI7m8fHZ8vZPZ717mH0
	uHhJ2ePzJrkA9ihum6TEkrLgzPQ8fbsE7ozvU3ILzspVrNzbz9bAeFeii5GTQ0LAROLv/NXM
	ELaYxIV769m6GLk4hAQuM0qcPLQHyjnGJHHkwE4mkCo2AV2JRT3NYLaIgJrExLZDLCBFzAJX
	GCWufNwO5HBwCAskSmxZ7AlisgioSsxflApSzivgKnHx+GEWiGVyEiePTWYFsTmB4jMO3WIE
	sYUEXCTurznGMoGRdwEjwypGucSc0lzd3MTMnOLUZN3i5MS8vNQiXQu93MwSvdSU0k2MkLAT
	2cF45KTcIUYBDkYlHt4VhxyDhVgTy4orcw8xSnIwKYnyPl/mFCzEl5SfUpmRWJwRX1Sak1p8
	iFGCg1lJhJdrNVCONyWxsiq1KB8mJc3BoiTO+22xup+QQHpiSWp2ampBahFMVoaDQ0mC9yVI
	o2BRanpqRVpmTglCmomDE2Q4l5RIcWpeSmpRYmlJRjwoLuKLgZEBkuIB2jsXbG9xQWIuUBSi
	9RSjopQ4bwlIQgAkkVGaBzcWlkxeMYoDfSnM+xykigeYiOC6XwENZgIabOgKNrgkESEl1cDI
	fcPe71Vjs54ay9p9KtJFj70SD6m/+iiaxT5p7p3rNwoapWacPal3379cQ/vXL4sP05Ns4m1W
	2XAZ/tyy99z/16tPdm3w78r/JXTyYu+6Jxt/G9g5vQ89xzjNULjIuDIk46MDf9ZU 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245859>

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
index c61120f..6f3b909 100644
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
1.9.1
