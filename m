From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 04/26] parse_arg(): Really test that argument is properly terminated
Date: Mon, 10 Mar 2014 13:46:21 +0100
Message-ID: <1394455603-2968-5-git-send-email-mhagger@alum.mit.edu>
References: <1394455603-2968-1-git-send-email-mhagger@alum.mit.edu>
Cc: Brad King <brad.king@kitware.com>, Jeff King <peff@peff.net>,
	Vicent Marti <tanoku@gmail.com>,
	Johan Herland <johan@herland.net>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 10 13:47:08 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WMzbm-0007Bi-1y
	for gcvg-git-2@plane.gmane.org; Mon, 10 Mar 2014 13:47:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753537AbaCJMrC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Mar 2014 08:47:02 -0400
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:57330 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753524AbaCJMq5 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Mar 2014 08:46:57 -0400
X-AuditID: 1207440f-f79326d000003c9f-da-531db44068c8
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id 5D.EA.15519.044BD135; Mon, 10 Mar 2014 08:46:57 -0400 (EDT)
Received: from michael.fritz.box (p57A2497B.dip0.t-ipconnect.de [87.162.73.123])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s2ACkjwS025479
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Mon, 10 Mar 2014 08:46:55 -0400
X-Mailer: git-send-email 1.9.0
In-Reply-To: <1394455603-2968-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrIIsWRmVeSWpSXmKPExsUixO6iqOu4RTbY4PV3Joud6yQsuq50M1k0
	9F5htph3dxeTxe0V85ktfrT0MFt87FzA7MDu8ff9ByaPnbPusntcevmdzePjs+XsHs969zB6
	XLyk7PF5k1wAexS3TVJiSVlwZnqevl0Cd8a5CR/YC5YKV/xZc4qtgfEGfxcjJ4eEgInEnfZ2
	dghbTOLCvfVsXYxcHEIClxkljn95xgrhnGCSmPT6MBNIFZuArsSinmYwW0RATWJi2yEWkCJm
	gSuMEp+//gIbJSwQItH54BSYzSKgKvHtxwJWEJtXwFlie98XJoh1chJTfi8Aq+EUcJGYfuUB
	mC0EVPNyTzPrBEbeBYwMqxjlEnNKc3VzEzNzilOTdYuTE/PyUot0TfRyM0v0UlNKNzFCgo9/
	B2PXeplDjAIcjEo8vAfeygQLsSaWFVfmHmKU5GBSEuWduFY2WIgvKT+lMiOxOCO+qDQntfgQ
	owQHs5IIb+ZioBxvSmJlVWpRPkxKmoNFSZxXfYm6n5BAemJJanZqakFqEUxWhoNDSYL38Gag
	RsGi1PTUirTMnBKENBMHJ8hwLimR4tS8lNSixNKSjHhQdMQXA+MDJMUDtHcbSDtvcUFiLlAU
	ovUUo6KUOO8ckIQASCKjNA9uLCylvGIUB/pSmLcVpIoHmI7gul8BDWYCGtx8XApkcEkiQkqq
	gTFjjxFTvLi0VFpl9IwVVlNWvubaEF+Zt9iSW/De5PSPHSbGFw52/T+i/YOhaWGPy+nkGyvU
	TSexu7CZ7dQWTtrjNenmNJaLFwzO2B4IF5qUvlKVM2hVsKSbjUPPqxW+15ka1Ofq 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243734>

Add a docstring to the function incorporating the comments that were
formerly within the function plus some added information.  Test that
the argument is properly terminated by either whitespace or a NUL
character, even if it is quoted, to be consistent with the non-quoted
case.  Adjust the tests to expect the new error message.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 builtin/update-ref.c  | 20 +++++++++++++++-----
 t/t1400-update-ref.sh |  4 ++--
 2 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/builtin/update-ref.c b/builtin/update-ref.c
index 1292cfe..02b5f95 100644
--- a/builtin/update-ref.c
+++ b/builtin/update-ref.c
@@ -62,16 +62,26 @@ static void update_store_old_sha1(struct ref_update *update,
 	update->have_old = *oldvalue || line_termination;
 }
 
+/*
+ * Parse one whitespace- or NUL-terminated, possibly C-quoted argument
+ * and append the result to arg.  Return a pointer to the terminator.
+ * Die if there is an error in how the argument is C-quoted.  This
+ * function is only used if not -z.
+ */
 static const char *parse_arg(const char *next, struct strbuf *arg)
 {
-	/* Parse SP-terminated, possibly C-quoted argument */
-	if (*next != '"')
+	if (*next == '"') {
+		const char *orig = next;
+
+		if (unquote_c_style(arg, next, &next))
+			die("badly quoted argument: %s", orig);
+		if (*next && !isspace(*next))
+			die("unexpected character after quoted argument: %s", orig);
+	} else {
 		while (*next && !isspace(*next))
 			strbuf_addch(arg, *next++);
-	else if (unquote_c_style(arg, next, &next))
-		die("badly quoted argument: %s", next);
+	}
 
-	/* Return position after the argument */
 	return next;
 }
 
diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
index e2f1dfa..5836842 100755
--- a/t/t1400-update-ref.sh
+++ b/t/t1400-update-ref.sh
@@ -356,10 +356,10 @@ test_expect_success 'stdin fails on badly quoted input' '
 	grep "fatal: badly quoted argument: \\\"master" err
 '
 
-test_expect_success 'stdin fails on arguments not separated by space' '
+test_expect_success 'stdin fails on junk after quoted argument' '
 	echo "create \"$a\"master" >stdin &&
 	test_must_fail git update-ref --stdin <stdin 2>err &&
-	grep "fatal: expected SP but got: master" err
+	grep "fatal: unexpected character after quoted argument: \\\"$a\\\"master" err
 '
 
 test_expect_success 'stdin fails create with no ref' '
-- 
1.9.0
