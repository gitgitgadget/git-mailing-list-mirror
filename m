From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 06/14] strtoul_ui(), strtol_i(): remove functions
Date: Tue, 17 Mar 2015 17:00:08 +0100
Message-ID: <1426608016-2978-7-git-send-email-mhagger@alum.mit.edu>
References: <1426608016-2978-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.org>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 17 17:00:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YXtv9-00015M-On
	for gcvg-git-2@plane.gmane.org; Tue, 17 Mar 2015 17:00:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932409AbbCQQAf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Mar 2015 12:00:35 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:44997 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754115AbbCQQAa (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Mar 2015 12:00:30 -0400
X-AuditID: 12074413-f79f26d0000030e7-a8-55084f9ef664
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id E1.3C.12519.E9F48055; Tue, 17 Mar 2015 12:00:30 -0400 (EDT)
Received: from michael.fritz.box (p4FC96AAE.dip0.t-ipconnect.de [79.201.106.174])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t2HG0LSh023811
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Tue, 17 Mar 2015 12:00:29 -0400
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1426608016-2978-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrPIsWRmVeSWpSXmKPExsUixO6iqDvPnyPUYEIzi0XXlW4mi4beK8wW
	t1fMZ7Z4fGsCkwOLx9/3H5g85t639Lh4Sdnj8ya5AJYobpukxJKy4Mz0PH27BO6M67+9Cm5w
	VBy4s5q9gfE2WxcjJ4eEgInE+xPnmCBsMYkL99YDxbk4hAQuM0o0nt3NCpIQEjjJJNG2yBHE
	ZhPQlVjU0wzWICKgJjGx7RALiM0skCLR+ecOO4gtLOAocedvG3MXIwcHi4CqxPK7gSBhXgFn
	iXNXzrNC7JKTOH/8JzOIzSngIvHiz2tGiFXOEmunTWabwMi7gJFhFaNcYk5prm5uYmZOcWqy
	bnFyYl5eapGuuV5uZoleakrpJkZI4AjvYNx1Uu4QowAHoxIPb0Mee6gQa2JZcWXuIUZJDiYl
	Ud48D45QIb6k/JTKjMTijPii0pzU4kOMEhzMSiK8d9yBcrwpiZVVqUX5MClpDhYlcV61Jep+
	QgLpiSWp2ampBalFMFkZDg4lCV4dP6BGwaLU9NSKtMycEoQ0EwcnyHAuKZHi1LyU1KLE0pKM
	eFBUxBcD4wIkxQO0twKknbe4IDEXKArReopRUUqcNwgkIQCSyCjNgxsLSwevGMWBvhTmVQap
	4gGmErjuV0CDmYAGt7SzgQwuSURISTUwbt/XKWR08F2eb+ddf5HVLXt8lny/uUQv/aDv0bNv
	+u3l/2aUPf8n5HDh8JoPxTWrf1SeVmWZ2Oi58fpl+Y67TN9nWgUbVH056vrET6NHbsKchCeb
	l74/zqYR/g2YElbm3BdkXMPy/c+x8PeBV7taPhQsntpmF5mr/vawn+6ScxWPTN89 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265636>

Their callers have been changed to use the numparse module.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 git-compat-util.h | 26 --------------------------
 1 file changed, 26 deletions(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index a3095be..cbe7f16 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -751,32 +751,6 @@ static inline int sane_iscase(int x, int is_lower)
 		return (x & 0x20) == 0;
 }
 
-static inline int strtoul_ui(char const *s, int base, unsigned int *result)
-{
-	unsigned long ul;
-	char *p;
-
-	errno = 0;
-	ul = strtoul(s, &p, base);
-	if (errno || *p || p == s || (unsigned int) ul != ul)
-		return -1;
-	*result = ul;
-	return 0;
-}
-
-static inline int strtol_i(char const *s, int base, int *result)
-{
-	long ul;
-	char *p;
-
-	errno = 0;
-	ul = strtol(s, &p, base);
-	if (errno || *p || p == s || (int) ul != ul)
-		return -1;
-	*result = ul;
-	return 0;
-}
-
 #ifdef INTERNAL_QSORT
 void git_qsort(void *base, size_t nmemb, size_t size,
 	       int(*compar)(const void *, const void *));
-- 
2.1.4
