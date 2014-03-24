From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 17/27] update-ref --stdin: Improve the error message for unexpected EOF
Date: Mon, 24 Mar 2014 18:56:50 +0100
Message-ID: <1395683820-17304-18-git-send-email-mhagger@alum.mit.edu>
References: <1395683820-17304-1-git-send-email-mhagger@alum.mit.edu>
Cc: Brad King <brad.king@kitware.com>,
	Johan Herland <johan@herland.net>, Jeff King <peff@peff.net>,
	Vicent Marti <tanoku@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 24 18:57:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WS98B-00018N-Aa
	for gcvg-git-2@plane.gmane.org; Mon, 24 Mar 2014 18:57:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753827AbaCXR5p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Mar 2014 13:57:45 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:54325 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753818AbaCXR5o (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 24 Mar 2014 13:57:44 -0400
X-AuditID: 12074413-f79076d000002d17-ba-533072174a21
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 83.F5.11543.71270335; Mon, 24 Mar 2014 13:57:43 -0400 (EDT)
Received: from michael.fritz.box (p57A25F6C.dip0.t-ipconnect.de [87.162.95.108])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s2OHv4xn028070
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Mon, 24 Mar 2014 13:57:41 -0400
X-Mailer: git-send-email 1.9.0
In-Reply-To: <1395683820-17304-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrPIsWRmVeSWpSXmKPExsUixO6iqCteZBBs0D9V3mLnOgmLrivdTBYN
	vVeYLebd3cVkcXvFfGaLHy09zBYfOxcwO7B7/H3/gclj56y77B6XXn5n8/j4bDm7x7PePYwe
	Fy8pe3zeJBfAHsVtk5RYUhacmZ6nb5fAnTHlxEaWgtfSFcfb1jM2MO4R62Lk5JAQMJGYfmcL
	O4QtJnHh3nq2LkYuDiGBy4wS1+acYIFwTjBJdB2cygZSxSagK7Gop5kJxBYRUJOY2HYIrIhZ
	4AqjxJWP24EcDg5hgSiJaXu4QWpYBFQlbn24zggS5hVwlfj1Jw1imZzElN8LwBZzAoW3th9m
	BrGFBFwkdnzsZZrAyLuAkWEVo1xiTmmubm5iZk5xarJucXJiXl5qka65Xm5miV5qSukmRkjg
	Ce9g3HVS7hCjAAejEg/vBlODYCHWxLLiytxDjJIcTEqivGy5QCG+pPyUyozE4oz4otKc1OJD
	jBIczEoivJbhQDnelMTKqtSifJiUNAeLkjiv2hJ1PyGB9MSS1OzU1ILUIpisDAeHkgRvVgFQ
	o2BRanpqRVpmTglCmomDE2Q4l5RIcWpeSmpRYmlJRjwoMuKLgbEBkuIB2utQCLK3uCAxFygK
	0XqKUVFKnPcayFwBkERGaR7cWFg6ecUoDvSlMK8aSDsPMBXBdb8CGswENDi8SQ9kcEkiQkqq
	gdF7Spv3k4T3WyVmHG2dFbvhuPVJdRmO25fFTx/cmvZvnp7rRX2bZxWHshIXaVvxTV58sG8f
	K4fS2bt2V8VT98RVbwiepBw+a/d3A0bfeTIfZk1r9pnm+HD277rkQMFKwcCgv/15 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244839>

Distinguish this error from the error that an argument is missing for
another reason.  Update the tests accordingly.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 builtin/update-ref.c  |  4 ++--
 t/t1400-update-ref.sh | 12 ++++++------
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/builtin/update-ref.c b/builtin/update-ref.c
index eef7537..b49a5b0 100644
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
1.9.0
