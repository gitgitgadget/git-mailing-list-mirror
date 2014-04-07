From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 12/27] update-ref --stdin: simplify error messages for missing oldvalues
Date: Mon,  7 Apr 2014 15:48:03 +0200
Message-ID: <1396878498-19887-13-git-send-email-mhagger@alum.mit.edu>
References: <1396878498-19887-1-git-send-email-mhagger@alum.mit.edu>
Cc: Brad King <brad.king@kitware.com>,
	Johan Herland <johan@herland.net>, Jeff King <peff@peff.net>,
	Vicent Marti <tanoku@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 07 15:49:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WX9vE-0002r5-Pf
	for gcvg-git-2@plane.gmane.org; Mon, 07 Apr 2014 15:49:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755385AbaDGNtE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Apr 2014 09:49:04 -0400
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:57528 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755333AbaDGNss (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 Apr 2014 09:48:48 -0400
X-AuditID: 12074411-f79ab6d000002f0e-bc-5342acbfcb84
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id C9.AF.12046.FBCA2435; Mon,  7 Apr 2014 09:48:47 -0400 (EDT)
Received: from michael.fritz.box (p5B156B1D.dip0.t-ipconnect.de [91.21.107.29])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s37DmJaJ026029
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Mon, 7 Apr 2014 09:48:45 -0400
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1396878498-19887-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrAIsWRmVeSWpSXmKPExsUixO6iqLt/jVOwwYwtihY710lYdF3pZrJo
	6L3CbDHv7i4mi9sr5jNb/GjpYbb42LmA2YHd4+/7D0weO2fdZfe49PI7m8fHZ8vZPZ717mH0
	uHhJ2ePzJrkA9ihum6TEkrLgzPQ8fbsE7oz5s14wFnySrPh1dj5jA+NK0S5GTg4JAROJpmcL
	WSBsMYkL99azdTFycQgJXGaU2Nu6ignCOcYkMfH8SrAqNgFdiUU9zUwgtoiAmsTEtkMsIEXM
	AlcYJa583A5WJCwQLfG9Yz57FyMHB4uAqsTUu0EgYV4BV4mNXxcwQmyTkzh5bDIriM0JFJ9x
	6BZYXEjAReL+mmMsExh5FzAyrGKUS8wpzdXNTczMKU5N1i1OTszLSy3SNdXLzSzRS00p3cQI
	CT3BHYwzTsodYhTgYFTi4V1xyDFYiDWxrLgy9xCjJAeTkijv82VOwUJ8SfkplRmJxRnxRaU5
	qcWHGCU4mJVEeLlWA+V4UxIrq1KL8mFS0hwsSuK8fEvU/YQE0hNLUrNTUwtSi2CyMhwcShK8
	60EaBYtS01Mr0jJzShDSTBycIMO5pESKU/NSUosSS0sy4kGxEV8MjA6QFA/Q3rlge4sLEnOB
	ohCtpxgVpcR5S0ASAiCJjNI8uLGwhPKKURzoS2HeDSBVPMBkBNf9CmgwE9BgQ1ewwSWJCCmp
	BsYarg03Z6yf8XyyUUVDE097G//3ukVitl92b1h2S+a8oNsVS4MDTg2vS10+fLpps1/pYPH+
	HbarozcdSZIpO3awb/HEPRWrX6xy+bhRsnKXhcmtNV8FHG23Nx9Mj1BYnuAd7G4g 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245845>

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
index ef61fe3..a2015d0 100755
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
1.9.1
