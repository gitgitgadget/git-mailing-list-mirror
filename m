From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 03/29] refname_is_safe(): use skip_prefix()
Date: Wed, 27 Apr 2016 18:57:20 +0200
Message-ID: <b1ad00ad0962210fe1746012640312b40b22fa99.1461768689.git.mhagger@alum.mit.edu>
References: <cover.1461768689.git.mhagger@alum.mit.edu>
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Jeff King <peff@peff.net>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org, David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Wed Apr 27 18:58:15 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avSn0-0003be-OK
	for gcvg-git-2@plane.gmane.org; Wed, 27 Apr 2016 18:58:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752885AbcD0Q6J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Apr 2016 12:58:09 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:59397 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752710AbcD0Q6I (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Apr 2016 12:58:08 -0400
X-AuditID: 12074413-487ff700000008c7-84-5720ef9fd3f3
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id E5.48.02247.F9FE0275; Wed, 27 Apr 2016 12:58:07 -0400 (EDT)
Received: from michael.fritz.box (p548D622A.dip0.t-ipconnect.de [84.141.98.42])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u3RGvw6G022189
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Wed, 27 Apr 2016 12:58:06 -0400
X-Mailer: git-send-email 2.8.1
In-Reply-To: <cover.1461768689.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrAIsWRmVeSWpSXmKPExsUixO6iqDv/vUK4wd8uA4v5m04wWnRd6Way
	aOi9wmxxe8V8ZovuKW8ZLX609DBbzLxq7cDu8ff9ByaPnbPusns8693D6HHxkrLH/qXb2DwW
	PL/P7vF5k1wAexS3TVJiSVlwZnqevl0Cd0bPpOtsBe/YKm61/GNpYFzH2sXIwSEhYCLx+59A
	FyMXh5DAVkaJvwcesEA4x5kk5s/9BORwcrAJ6Eos6mlmArFFBBwklq/8xQ5SxCzQxCTxfXkT
	WJGwgLXEhbZ+VhCbRUBVovfkfnYQm1cgSmJh538wW0JATuLy9AdsIDangIXEl9a3jCC2kIC5
	xJIHq9knMPIsYGRYxSiXmFOaq5ubmJlTnJqsW5ycmJeXWqRrrpebWaKXmlK6iRESYsI7GHed
	lDvEKMDBqMTDWyChEC7EmlhWXJl7iFGSg0lJlHfJWaAQX1J+SmVGYnFGfFFpTmrxIUYJDmYl
	Ed7pb4ByvCmJlVWpRfkwKWkOFiVxXrUl6n5CAumJJanZqakFqUUwWRkODiUJ3vJ3QI2CRanp
	qRVpmTklCGkmDk6Q4VxSIsWpeSmpRYmlJRnxoBiILwZGAUiKB2hvKUg7b3FBYi5QFKL1FKMu
	x4Ift9cyCbHk5eelSonzLgApEgApyijNg1sBSyivGMWBPhbmnQpSxQNMRnCTXgEtYQJacvmQ
	LMiSkkSElFQD4yyuLe2c8xN4j90vKdgVf+GzL4cZf88iNhbptoPx/7adnvpp0j+l/wHPbAUt
	TNxXMrO297hvqr36ji2ePWbu1oSE/rU8Yhc2VkpuUDx+YuYnHbH+/NN/feZJGk2f 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292744>

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/refs.c b/refs.c
index 87dc82f..5789152 100644
--- a/refs.c
+++ b/refs.c
@@ -120,17 +120,19 @@ int check_refname_format(const char *refname, int flags)
 
 int refname_is_safe(const char *refname)
 {
-	if (starts_with(refname, "refs/")) {
+	const char *rest;
+
+	if (skip_prefix(refname, "refs/", &rest)) {
 		char *buf;
 		int result;
 
-		buf = xmallocz(strlen(refname));
 		/*
 		 * Does the refname try to escape refs/?
 		 * For example: refs/foo/../bar is safe but refs/foo/../../bar
 		 * is not.
 		 */
-		result = !normalize_path_copy(buf, refname + strlen("refs/"));
+		buf = xmallocz(strlen(rest));
+		result = !normalize_path_copy(buf, rest);
 		free(buf);
 		return result;
 	}
-- 
2.8.1
