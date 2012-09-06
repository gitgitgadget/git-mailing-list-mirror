From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 3/8] absolute_path(): reject the empty string
Date: Fri,  7 Sep 2012 00:40:59 +0200
Message-ID: <1346971264-23744-4-git-send-email-mhagger@alum.mit.edu>
References: <1346971264-23744-1-git-send-email-mhagger@alum.mit.edu>
Cc: Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org,
	Orgad and Raizel Shaneh <orgads@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 07 00:41:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T9kle-0007OG-8L
	for gcvg-git-2@plane.gmane.org; Fri, 07 Sep 2012 00:41:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754256Ab2IFWlk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Sep 2012 18:41:40 -0400
Received: from ALUM-MAILSEC-SCANNER-5.MIT.EDU ([18.7.68.17]:63977 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753343Ab2IFWlj (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 6 Sep 2012 18:41:39 -0400
X-AuditID: 12074411-b7fa36d0000008cc-97-504926a2af4f
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id 65.82.02252.2A629405; Thu,  6 Sep 2012 18:41:38 -0400 (EDT)
Received: from michael.berlin.jpk.com (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id q86MfGJV025515
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 6 Sep 2012 18:41:36 -0400
X-Mailer: git-send-email 1.7.11.3
In-Reply-To: <1346971264-23744-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNIsWRmVeSWpSXmKPExsUixO6iqLtIzTPAYH2ToEXXlW4mi4beK8wW
	T+beZba4vWI+s8X6RQ2sFt1T3jI6sHn8ff+ByWPnrLvsHg9fdbF7XLyk7PF5k1wAaxS3TVJi
	SVlwZnqevl0Cd8bjKU8ZCy5wVEyY2sHcwPifrYuRk0NCwERi2px9TBC2mMSFe+uB4lwcQgKX
	GSU2TlrNCuGcZpI4feQPK0gVm4CuxKKeZrAOEQE1iYlth1hAbGaB84wSf26yg9jCAg4SM669
	ZAaxWQRUJQ43/QSL8wq4SGw8cIsFYpuixI/va4BqODg4BVwlpi2QAwkLAZXMe3+bbQIj7wJG
	hlWMcok5pbm6uYmZOcWpybrFyYl5ealFuqZ6uZkleqkppZsYIcEluINxxkm5Q4wCHIxKPLxG
	Zz0ChFgTy4orcw8xSnIwKYny/lPyDBDiS8pPqcxILM6ILyrNSS0+xCjBwawkwjvxF1A5b0pi
	ZVVqUT5MSpqDRUmcl2+Jup+QQHpiSWp2ampBahFMVoaDQ0mCd6Yq0FDBotT01Iq0zJwShDQT
	ByeI4ALZwAO0IQCkkLe4IDG3ODMdougUo6KUOG8RSEIAJJFRmgc3AJYGXjGKA/0jzNsFUsUD
	TCFw3a+ABjMBDRZ5BnJ6cUkiQkqqgbFik4aYe72zo9Qvhys8ufOv1q3JvR3t1jqVdwdvCrfJ
	Q8+vMXHcqRyy55W/blsyu6zp0AS7fxfsrlX+UAqZtvuYx7P7MbKnn21ljBO/9lp3+zz/900f
	Hj6TTBEJ9bpq2vwzP2ti5Q+f/rDDJxn7hJPNVc9uaN/654vMxjX7yr0XHJxwawP3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204932>


Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 abspath.c             | 4 +++-
 t/t0060-path-utils.sh | 2 +-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/abspath.c b/abspath.c
index f04ac18..5d62430 100644
--- a/abspath.c
+++ b/abspath.c
@@ -123,7 +123,9 @@ const char *absolute_path(const char *path)
 {
 	static char buf[PATH_MAX + 1];
 
-	if (is_absolute_path(path)) {
+	if (!*path) {
+		die("The empty string is not a valid path");
+	} else if (is_absolute_path(path)) {
 		if (strlcpy(buf, path, PATH_MAX) >= PATH_MAX)
 			die("Too long path: %.*s", 60, path);
 	} else {
diff --git a/t/t0060-path-utils.sh b/t/t0060-path-utils.sh
index d91e516..924aa60 100755
--- a/t/t0060-path-utils.sh
+++ b/t/t0060-path-utils.sh
@@ -140,7 +140,7 @@ test_expect_success 'strip_path_suffix' '
 		c:/msysgit/libexec//git-core libexec/git-core)
 '
 
-test_expect_failure 'absolute path rejects the empty string' '
+test_expect_success 'absolute path rejects the empty string' '
 	test_must_fail test-path-utils absolute_path ""
 '
 
-- 
1.7.11.3
