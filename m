From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 15/26] update-ref --stdin: Improve the error message for unexpected EOF
Date: Mon, 10 Mar 2014 13:46:32 +0100
Message-ID: <1394455603-2968-16-git-send-email-mhagger@alum.mit.edu>
References: <1394455603-2968-1-git-send-email-mhagger@alum.mit.edu>
Cc: Brad King <brad.king@kitware.com>, Jeff King <peff@peff.net>,
	Vicent Marti <tanoku@gmail.com>,
	Johan Herland <johan@herland.net>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 10 13:47:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WMzcB-0007eS-Ct
	for gcvg-git-2@plane.gmane.org; Mon, 10 Mar 2014 13:47:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753585AbaCJMrY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Mar 2014 08:47:24 -0400
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:57598 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753524AbaCJMrT (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Mar 2014 08:47:19 -0400
X-AuditID: 1207440d-f79d86d0000043db-76-531db4563503
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id EB.47.17371.654BD135; Mon, 10 Mar 2014 08:47:18 -0400 (EDT)
Received: from michael.fritz.box (p57A2497B.dip0.t-ipconnect.de [87.162.73.123])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s2ACkjwd025479
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Mon, 10 Mar 2014 08:47:17 -0400
X-Mailer: git-send-email 1.9.0
In-Reply-To: <1394455603-2968-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrPIsWRmVeSWpSXmKPExsUixO6iqBu2RTbYoGO9mcXOdRIWXVe6mSwa
	eq8wW8y7u4vJ4vaK+cwWP1p6mC0+di5gdmD3+Pv+A5PHzll32T0uvfzO5vHx2XJ2j2e9exg9
	Ll5S9vi8SS6APYrbJimxpCw4Mz1P3y6BO+P+spKCSRIVU/6/Zm9g3CvcxcjBISFgIvH6ZU4X
	IyeQKSZx4d56ti5GLg4hgcuMEnNOz2aHcE4wSWzetJkJpIpNQFdiUU8zmC0ioCYxse0QC0gR
	s8AVRonPX3+xgySEBcIl5jYdZwaxWQRUJU7cnsMIYvMKuEjMOreAFWKdnMSU3wvA6jmB4tOv
	PACzhQScJV7uaWadwMi7gJFhFaNcYk5prm5uYmZOcWqybnFyYl5eapGukV5uZoleakrpJkZI
	4PHuYPy/TuYQowAHoxIP74G3MsFCrIllxZW5hxglOZiURHknrpUNFuJLyk+pzEgszogvKs1J
	LT7EKMHBrCTCm7kYKMebklhZlVqUD5OS5mBREudVW6LuJySQnliSmp2aWpBaBJOV4eBQkuCt
	3wzUKFiUmp5akZaZU4KQZuLgBBnOJSVSnJqXklqUWFqSEQ+KjPhiYGyApHiA9m4DaectLkjM
	BYpCtJ5iVJQS550DkhAASWSU5sGNhaWTV4ziQF8K87aCVPEAUxFc9yugwUxAg5uPS4EMLklE
	SEk1MErNDRGTzH8mWOtqGX0/1X/2unD2zk/vfHbzFhm+MZt9Y5rm7mfKl8vdCiqzWju4GS5G
	nVecPkPq4QnRz1xMKo+4iv95h97+f0nqx3XZ7DZlbkHFXPOSJdkB4UeULjQ8WJyz 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243739>

Distinguish this error from the error that an argument is missing for
another reason.  Update the tests accordingly.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 builtin/update-ref.c  |  4 ++--
 t/t1400-update-ref.sh | 10 +++++-----
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/builtin/update-ref.c b/builtin/update-ref.c
index 5937291..0a81a11 100644
--- a/builtin/update-ref.c
+++ b/builtin/update-ref.c
@@ -156,8 +156,8 @@ static int parse_next_sha1(struct strbuf *input, const char **next,
 
  eof:
 	die(old ?
-	    "%s %s missing <oldvalue>" :
-	    "%s %s missing <newvalue>",
+	    "%s %s: unexpected end of input when reading <oldvalue>" :
+	    "%s %s: unexpected end of input when reading <newvalue>",
 	    command, refname);
 }
 
diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
index 7332753..e9a0103 100755
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
@@ -733,13 +733,13 @@ test_expect_success 'stdin -z fails update with bad ref name' '
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
@@ -763,7 +763,7 @@ test_expect_success 'stdin -z fails delete with bad ref name' '
 test_expect_success 'stdin -z fails delete with no old value' '
 	printf $F "delete $a" >stdin &&
 	test_must_fail git update-ref -z --stdin <stdin 2>err &&
-	grep "fatal: delete $a missing <oldvalue>" err
+	grep "fatal: delete $a: unexpected end of input when reading <oldvalue>" err
 '
 
 test_expect_success 'stdin -z fails delete with too many arguments' '
@@ -781,7 +781,7 @@ test_expect_success 'stdin -z fails verify with too many arguments' '
 test_expect_success 'stdin -z fails verify with no old value' '
 	printf $F "verify $a" >stdin &&
 	test_must_fail git update-ref -z --stdin <stdin 2>err &&
-	grep "fatal: verify $a missing <oldvalue>" err
+	grep "fatal: verify $a: unexpected end of input when reading <oldvalue>" err
 '
 
 test_expect_success 'stdin -z fails option with unknown name' '
-- 
1.9.0
