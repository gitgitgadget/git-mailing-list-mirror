From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 13/26] update-ref --stdin: Simplify error messages for missing oldvalues
Date: Mon, 10 Mar 2014 13:46:30 +0100
Message-ID: <1394455603-2968-14-git-send-email-mhagger@alum.mit.edu>
References: <1394455603-2968-1-git-send-email-mhagger@alum.mit.edu>
Cc: Brad King <brad.king@kitware.com>, Jeff King <peff@peff.net>,
	Vicent Marti <tanoku@gmail.com>,
	Johan Herland <johan@herland.net>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 10 13:47:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WMzc7-0007c1-Fy
	for gcvg-git-2@plane.gmane.org; Mon, 10 Mar 2014 13:47:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753571AbaCJMrS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Mar 2014 08:47:18 -0400
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:57764 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753524AbaCJMrP (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Mar 2014 08:47:15 -0400
X-AuditID: 12074412-f79d46d000002e58-c0-531db4528e81
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id 03.41.11864.254BD135; Mon, 10 Mar 2014 08:47:14 -0400 (EDT)
Received: from michael.fritz.box (p57A2497B.dip0.t-ipconnect.de [87.162.73.123])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s2ACkjwb025479
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Mon, 10 Mar 2014 08:47:13 -0400
X-Mailer: git-send-email 1.9.0
In-Reply-To: <1394455603-2968-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrAIsWRmVeSWpSXmKPExsUixO6iqBu0RTbYoO2TscXOdRIWXVe6mSwa
	eq8wW8y7u4vJ4vaK+cwWP1p6mC0+di5gdmD3+Pv+A5PHzll32T0uvfzO5vHx2XJ2j2e9exg9
	Ll5S9vi8SS6APYrbJimxpCw4Mz1P3y6BO2PTkcfMBZ8kK77evsrWwLhStIuRk0NCwETi8/yv
	TBC2mMSFe+vZuhi5OIQELjNKLN9/lBnCOcEksf/idnaQKjYBXYlFPc1gHSICahIT2w6xgBQx
	C1xhlPj89RdYkbBAhMSDf4vBbBYBVYmmWTOAbA4OXgEXiWu3PSG2yUlM+b0ArIQTKDz9ygMw
	W0jAWeLlnmbWCYy8CxgZVjHKJeaU5urmJmbmFKcm6xYnJ+blpRbpmunlZpbopaaUbmKEhJ7Q
	Dsb1J+UOMQpwMCrx8B54KxMsxJpYVlyZe4hRkoNJSZR34lrZYCG+pPyUyozE4oz4otKc1OJD
	jBIczEoivJmLgXK8KYmVValF+TApaQ4WJXHen4vV/YQE0hNLUrNTUwtSi2CyMhwcShK8vpuB
	GgWLUtNTK9Iyc0oQ0kwcnCDDuaREilPzUlKLEktLMuJBsRFfDIwOkBQP0N5tIO28xQWJuUBR
	iNZTjIpS4rxzQBICIImM0jy4sbCE8opRHOhLYd5WkCoeYDKC634FNJgJaHDzcSmQwSWJCCmp
	BsbKnwd3PfLVCIix3Fv+N/72WyV/uc/Ku76qJq8+WHn1/LKO83bLQiZP1m4vr2YWeOVXdmdV
	0xWh935/js9b+ujtv3P/rkqJr1AvniK83afuWdD9D6bbAh8+8Z7zcGfL3LNPTIy6 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243738>

Instead of, for example,

    fatal: update refs/heads/master missing [<oldvalue>] NUL

emit

    fatal: update refs/heads/master missing <oldvalue>

Update the tests accordingly.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 builtin/update-ref.c  | 6 +++---
 t/t1400-update-ref.sh | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/builtin/update-ref.c b/builtin/update-ref.c
index e4c0854..a9eb5fe 100644
--- a/builtin/update-ref.c
+++ b/builtin/update-ref.c
@@ -176,7 +176,7 @@ static const char *parse_cmd_update(struct strbuf *input, const char *next)
 		if (*next != line_termination)
 			die("update %s has extra input: %s", update->ref_name, next);
 	} else if (!line_termination)
-		die("update %s missing [<oldvalue>] NUL", update->ref_name);
+		die("update %s missing <oldvalue>", update->ref_name);
 
 	return next;
 }
@@ -222,7 +222,7 @@ static const char *parse_cmd_delete(struct strbuf *input, const char *next)
 		if (update->have_old && is_null_sha1(update->old_sha1))
 			die("delete %s given zero <oldvalue>", update->ref_name);
 	} else if (!line_termination)
-		die("delete %s missing [<oldvalue>] NUL", update->ref_name);
+		die("delete %s missing <oldvalue>", update->ref_name);
 
 	if (*next != line_termination)
 		die("delete %s has extra input: %s", update->ref_name, next);
@@ -245,7 +245,7 @@ static const char *parse_cmd_verify(struct strbuf *input, const char *next)
 		update_store_old_sha1("verify", update, value.buf);
 		hashcpy(update->new_sha1, update->old_sha1);
 	} else if (!line_termination)
-		die("verify %s missing [<oldvalue>] NUL", update->ref_name);
+		die("verify %s missing <oldvalue>", update->ref_name);
 
 	if (*next != line_termination)
 		die("verify %s has extra input: %s", update->ref_name, next);
diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
index 3045ae7..42fec4e 100755
--- a/t/t1400-update-ref.sh
+++ b/t/t1400-update-ref.sh
@@ -739,7 +739,7 @@ test_expect_success 'stdin -z fails update with no new value' '
 test_expect_success 'stdin -z fails update with no old value' '
 	printf $F "update $a" "$m" >stdin &&
 	test_must_fail git update-ref -z --stdin <stdin 2>err &&
-	grep "fatal: update $a missing \\[<oldvalue>\\] NUL" err
+	grep "fatal: update $a missing <oldvalue>" err
 '
 
 test_expect_success 'stdin -z fails update with too many arguments' '
@@ -763,7 +763,7 @@ test_expect_success 'stdin -z fails delete with bad ref name' '
 test_expect_success 'stdin -z fails delete with no old value' '
 	printf $F "delete $a" >stdin &&
 	test_must_fail git update-ref -z --stdin <stdin 2>err &&
-	grep "fatal: delete $a missing \\[<oldvalue>\\] NUL" err
+	grep "fatal: delete $a missing <oldvalue>" err
 '
 
 test_expect_success 'stdin -z fails delete with too many arguments' '
@@ -781,7 +781,7 @@ test_expect_success 'stdin -z fails verify with too many arguments' '
 test_expect_success 'stdin -z fails verify with no old value' '
 	printf $F "verify $a" >stdin &&
 	test_must_fail git update-ref -z --stdin <stdin 2>err &&
-	grep "fatal: verify $a missing \\[<oldvalue>\\] NUL" err
+	grep "fatal: verify $a missing <oldvalue>" err
 '
 
 test_expect_success 'stdin -z fails option with unknown name' '
-- 
1.9.0
