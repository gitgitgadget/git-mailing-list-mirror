From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 17/27] update-ref --stdin: improve the error message for unexpected EOF
Date: Mon,  7 Apr 2014 15:48:08 +0200
Message-ID: <1396878498-19887-18-git-send-email-mhagger@alum.mit.edu>
References: <1396878498-19887-1-git-send-email-mhagger@alum.mit.edu>
Cc: Brad King <brad.king@kitware.com>,
	Johan Herland <johan@herland.net>, Jeff King <peff@peff.net>,
	Vicent Marti <tanoku@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 07 15:49:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WX9vU-00034G-Pl
	for gcvg-git-2@plane.gmane.org; Mon, 07 Apr 2014 15:49:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755327AbaDGNtV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Apr 2014 09:49:21 -0400
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:64179 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754790AbaDGNs6 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 Apr 2014 09:48:58 -0400
X-AuditID: 1207440f-f79326d000003c9f-38-5342acc94b84
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id 1C.40.15519.9CCA2435; Mon,  7 Apr 2014 09:48:57 -0400 (EDT)
Received: from michael.fritz.box (p5B156B1D.dip0.t-ipconnect.de [91.21.107.29])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s37DmJaO026029
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Mon, 7 Apr 2014 09:48:55 -0400
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1396878498-19887-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrAIsWRmVeSWpSXmKPExsUixO6iqHtyjVOwwetL3BY710lYdF3pZrJo
	6L3CbDHv7i4mi9sr5jNb/GjpYbb42LmA2YHd4+/7D0weO2fdZfe49PI7m8fHZ8vZPZ717mH0
	uHhJ2ePzJrkA9ihum6TEkrLgzPQ8fbsE7ozDT5uYC15LV9zetpupgXGPWBcjJ4eEgInExnO9
	7BC2mMSFe+vZuhi5OIQELjNKrJpxlxXCOcYkMbNnFgtIFZuArsSinmYmEFtEQE1iYtshFpAi
	ZoErjBJXPm4HKxIWiJI4vq4HbCyLgKrEzvnLmLsYOTh4BVwlum9HQWyTkzh5bDIriM0JFJ5x
	6BYjiC0k4CJxf80xlgmMvAsYGVYxyiXmlObq5iZm5hSnJusWJyfm5aUW6Zro5WaW6KWmlG5i
	hIQe/w7GrvUyhxgFOBiVeHhXHHIMFmJNLCuuzD3EKMnBpCTK+3yZU7AQX1J+SmVGYnFGfFFp
	TmrxIUYJDmYlEV6u1UA53pTEyqrUonyYlDQHi5I4r/oSdT8hgfTEktTs1NSC1CKYrAwHh5IE
	70uQRsGi1PTUirTMnBKENBMHJ8hwLimR4tS8lNSixNKSjHhQbMQXA6MDJMUDtHcu2N7igsRc
	oChE6ylGRSlx3hKQhABIIqM0D24sLKG8YhQH+lKY9zlIFQ8wGcF1vwIazAQ02NAVbHBJIkJK
	qoFxneJ5rp+1xoFCcVte2G19mF8j/rzBJCJhqQln8a/o+Rx93x4ueSz6RXn1YuZknsrX4ktj
	Twq8EHCclxZdVTmRWfWxfiPfn6Dlzatmbc143fzskLRfWezR8ujuTReDj4Qz9xTE 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245848>

Distinguish this error from the error that an argument is missing for
another reason.  Update the tests accordingly.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 builtin/update-ref.c  |  4 ++--
 t/t1400-update-ref.sh | 12 ++++++------
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/builtin/update-ref.c b/builtin/update-ref.c
index 6f3b909..0d5f1d0 100644
--- a/builtin/update-ref.c
+++ b/builtin/update-ref.c
@@ -178,8 +178,8 @@ static int parse_next_sha1(struct strbuf *input, const char **next,
 
  eof:
 	die(flags & PARSE_SHA1_OLD ?
-	    "%s %s missing <oldvalue>" :
-	    "%s %s missing <newvalue>",
+	    "%s %s: unexpected end of input when reading <oldvalue>" :
+	    "%s %s: unexpected end of input when reading <newvalue>",
 	    command, refname);
 }
 
diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
index 6b21e45..1db0689 100755
--- a/t/t1400-update-ref.sh
+++ b/t/t1400-update-ref.sh
@@ -709,7 +709,7 @@ test_expect_success 'stdin -z fails create with bad ref name' '
 test_expect_success 'stdin -z fails create with no new value' '
 	printf $F "create $a" >stdin &&
 	test_must_fail git update-ref -z --stdin <stdin 2>err &&
-	grep "fatal: create $a missing <newvalue>" err
+	grep "fatal: create $a: unexpected end of input when reading <newvalue>" err
 '
 
 test_expect_success 'stdin -z fails create with too many arguments' '
@@ -727,7 +727,7 @@ test_expect_success 'stdin -z fails update with no ref' '
 test_expect_success 'stdin -z fails update with too few args' '
 	printf $F "update $a" "$m" >stdin &&
 	test_must_fail git update-ref -z --stdin <stdin 2>err &&
-	grep "fatal: update $a missing <oldvalue>" err
+	grep "fatal: update $a: unexpected end of input when reading <oldvalue>" err
 '
 
 test_expect_success 'stdin -z fails update with bad ref name' '
@@ -747,13 +747,13 @@ test_expect_success 'stdin -z emits warning with empty new value' '
 test_expect_success 'stdin -z fails update with no new value' '
 	printf $F "update $a" >stdin &&
 	test_must_fail git update-ref -z --stdin <stdin 2>err &&
-	grep "fatal: update $a missing <newvalue>" err
+	grep "fatal: update $a: unexpected end of input when reading <newvalue>" err
 '
 
 test_expect_success 'stdin -z fails update with no old value' '
 	printf $F "update $a" "$m" >stdin &&
 	test_must_fail git update-ref -z --stdin <stdin 2>err &&
-	grep "fatal: update $a missing <oldvalue>" err
+	grep "fatal: update $a: unexpected end of input when reading <oldvalue>" err
 '
 
 test_expect_success 'stdin -z fails update with too many arguments' '
@@ -777,7 +777,7 @@ test_expect_success 'stdin -z fails delete with bad ref name' '
 test_expect_success 'stdin -z fails delete with no old value' '
 	printf $F "delete $a" >stdin &&
 	test_must_fail git update-ref -z --stdin <stdin 2>err &&
-	grep "fatal: delete $a missing <oldvalue>" err
+	grep "fatal: delete $a: unexpected end of input when reading <oldvalue>" err
 '
 
 test_expect_success 'stdin -z fails delete with too many arguments' '
@@ -795,7 +795,7 @@ test_expect_success 'stdin -z fails verify with too many arguments' '
 test_expect_success 'stdin -z fails verify with no old value' '
 	printf $F "verify $a" >stdin &&
 	test_must_fail git update-ref -z --stdin <stdin 2>err &&
-	grep "fatal: verify $a missing <oldvalue>" err
+	grep "fatal: verify $a: unexpected end of input when reading <oldvalue>" err
 '
 
 test_expect_success 'stdin -z fails option with unknown name' '
-- 
1.9.1
