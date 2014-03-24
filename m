From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 12/27] update-ref --stdin: Simplify error messages for missing oldvalues
Date: Mon, 24 Mar 2014 18:56:45 +0100
Message-ID: <1395683820-17304-13-git-send-email-mhagger@alum.mit.edu>
References: <1395683820-17304-1-git-send-email-mhagger@alum.mit.edu>
Cc: Brad King <brad.king@kitware.com>,
	Johan Herland <johan@herland.net>, Jeff King <peff@peff.net>,
	Vicent Marti <tanoku@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 24 18:57:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WS988-00018N-Vx
	for gcvg-git-2@plane.gmane.org; Mon, 24 Mar 2014 18:57:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753808AbaCXR5g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Mar 2014 13:57:36 -0400
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:43467 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753745AbaCXR5e (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 24 Mar 2014 13:57:34 -0400
X-AuditID: 1207440c-f79656d000003eba-96-5330720de10e
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id 84.AF.16058.D0270335; Mon, 24 Mar 2014 13:57:33 -0400 (EDT)
Received: from michael.fritz.box (p57A25F6C.dip0.t-ipconnect.de [87.162.95.108])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s2OHv4xi028070
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Mon, 24 Mar 2014 13:57:31 -0400
X-Mailer: git-send-email 1.9.0
In-Reply-To: <1395683820-17304-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrAIsWRmVeSWpSXmKPExsUixO6iqMtbZBBs0HxJy2LnOgmLrivdTBYN
	vVeYLebd3cVkcXvFfGaLHy09zBYfOxcwO7B7/H3/gclj56y77B6XXn5n8/j4bDm7x7PePYwe
	Fy8pe3zeJBfAHsVtk5RYUhacmZ6nb5fAnXH+ziamgk+SFUs3/WBuYFwp2sXIySEhYCKxcupU
	ZghbTOLCvfVsXYxcHEIClxklGjqXMkM4J5gkNm7/yQZSxSagK7Gop5kJxBYRUJOY2HaIBaSI
	WeAKo8SVj9tZQBLCAtESXfv+sIPYLAKqEkvWTWDtYuTg4BVwlfix0RBim5zElN8LwEo4gcJb
	2w+DXSEk4CKx42Mv0wRG3gWMDKsY5RJzSnN1cxMzc4pTk3WLkxPz8lKLdA31cjNL9FJTSjcx
	QkKPZwfjt3UyhxgFOBiVeHgjjA2ChVgTy4orcw8xSnIwKYnysuUChfiS8lMqMxKLM+KLSnNS
	iw8xSnAwK4nwWoYD5XhTEiurUovyYVLSHCxK4ryqS9T9hATSE0tSs1NTC1KLYLIyHBxKErxh
	hUCNgkWp6akVaZk5JQhpJg5OkOFcUiLFqXkpqUWJpSUZ8aDYiC8GRgdIigdorwNIO29xQWIu
	UBSi9RSjopQ477UCoIQASCKjNA9uLCyhvGIUB/pSmDcBpJ0HmIzgul8BDWYCGhzepAcyuCQR
	ISXVwNjE/U3w556+u+2bXvRxfBCb6xHmyir8VNc6h0VlGq/91OsbVu2ZLqflEurveVN10nUX
	g0n7lh+dw/4qaI1C2M4jCvP/t0XHCJYkiyqaXvjgtnPngW/T8x7ySdz8vVGsqM5H 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244835>

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
1.9.0
