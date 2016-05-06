From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 28/33] ref_transaction_update(): check refname_is_safe() at a minimum
Date: Fri,  6 May 2016 18:14:09 +0200
Message-ID: <3da1f37d0476d477d0d640b00c0a1111bf2a8fc7.1462550456.git.mhagger@alum.mit.edu>
References: <cover.1462550456.git.mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Ramsay Jones <ramsay@ramsayjones.plus.com>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>,
	David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Fri May 06 18:15:33 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ayiPd-0000Bq-AM
	for gcvg-git-2@plane.gmane.org; Fri, 06 May 2016 18:15:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758715AbcEFQPP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 May 2016 12:15:15 -0400
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:48405 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758709AbcEFQPM (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 May 2016 12:15:12 -0400
X-AuditID: 12074414-62bff700000008e6-fb-572cc30ee0da
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id B7.12.02278.E03CC275; Fri,  6 May 2016 12:15:10 -0400 (EDT)
Received: from michael.fritz.box (p508EA663.dip0.t-ipconnect.de [80.142.166.99])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u46GEHVA031758
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Fri, 6 May 2016 12:15:09 -0400
X-Mailer: git-send-email 2.8.1
In-Reply-To: <cover.1462550456.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrPIsWRmVeSWpSXmKPExsUixO6iqMt/WCfcoHUyu8X8TScYLbqudDNZ
	NPReYba4vWI+s0X3lLeMFj9aepgtZl61dmD3+Pv+A5PHzll32T2e9e5h9Lh4Sdlj/9JtbB4L
	nt9n9/i8SS6APYrbJimxpCw4Mz1P3y6BO6P7zVnGgs98FZs7DjA1ME7n6WLk5JAQMJGY1fuX
	tYuRi0NIYCujxP9pq1ggnONMEqfXX2MHqWIT0JVY1NPMBGKLCERINLxqYexi5OBgFvjMKLGS
	GyQsDBT+f3UPG4jNIqAqMW/BITCbVyBKYv+fiWwQy+QkLk9/AGZzClhIHOo9DjZSSMBcomPt
	DfYJjDwLGBlWMcol5pTm6uYmZuYUpybrFicn5uWlFula6OVmluilppRuYoQEmMgOxiMn5Q4x
	CnAwKvHwZpzUDhdiTSwrrsw9xCjJwaQkyvu9QCdciC8pP6UyI7E4I76oNCe1+BCjBAezkgjv
	lX1AOd6UxMqq1KJ8mJQ0B4uSOO+3xep+QgLpiSWp2ampBalFMFkZDg4lCd7mQ0CNgkWp6akV
	aZk5JQhpJg5OkOFcUiLFqXkpqUWJpSUZ8aAIiC8GxgBIigdoLx9IO29xQWIuUBSi9RSjLseR
	/ffWMgmx5OXnpUqJ8849CFQkAFKUUZoHtwKWTl4xigN9LMx7GaSKB5iK4Ca9AlrCBLTk/VxN
	kCUliQgpqQZGxlWJH7gidz/4mWhclNshlNPjVLWZea3qs4gJrPX8DrFbQlq2rOb7VGjM/TxL
	PG8u7+m4Zd/VWtL4NyopSaiXcE2OmN534Exe0iS9ndWnihmqP3579rUppKfv/m9J 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293816>

If the user has asked that a new value be set for a reference, we use
check_refname_format() to verify that the reference name satisfies all
of the rules. But in other cases, at least check that refname_is_safe().

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c                  | 5 +++--
 t/t1400-update-ref.sh   | 2 +-
 t/t1430-bad-ref-name.sh | 2 +-
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/refs.c b/refs.c
index 7c4eeb1..842c5c7 100644
--- a/refs.c
+++ b/refs.c
@@ -805,8 +805,9 @@ int ref_transaction_update(struct ref_transaction *transaction,
 {
 	assert(err);
 
-	if (new_sha1 && !is_null_sha1(new_sha1) &&
-	    check_refname_format(refname, REFNAME_ALLOW_ONELEVEL)) {
+	if ((new_sha1 && !is_null_sha1(new_sha1)) ?
+	    check_refname_format(refname, REFNAME_ALLOW_ONELEVEL) :
+	    !refname_is_safe(refname)) {
 		strbuf_addf(err, "refusing to update ref with bad name '%s'",
 			    refname);
 		return -1;
diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
index 40b0cce..08bd8fd 100755
--- a/t/t1400-update-ref.sh
+++ b/t/t1400-update-ref.sh
@@ -23,7 +23,7 @@ test_expect_success setup '
 m=refs/heads/master
 n_dir=refs/heads/gu
 n=$n_dir/fixes
-outside=foo
+outside=refs/foo
 
 test_expect_success \
 	"create $m" \
diff --git a/t/t1430-bad-ref-name.sh b/t/t1430-bad-ref-name.sh
index 25ddab4..8937e25 100755
--- a/t/t1430-bad-ref-name.sh
+++ b/t/t1430-bad-ref-name.sh
@@ -285,7 +285,7 @@ test_expect_success 'update-ref -d cannot delete non-ref in .git dir' '
 	echo precious >expect &&
 	test_must_fail git update-ref -d my-private-file >output 2>error &&
 	test_must_be_empty output &&
-	test_i18ngrep -e "cannot lock .*: unable to resolve reference" error &&
+	test_i18ngrep -e "refusing to update ref with bad name" error &&
 	test_cmp expect .git/my-private-file
 '
 
-- 
2.8.1
