From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 09/14] opt_arg(): val is always non-NULL
Date: Tue, 17 Mar 2015 17:00:11 +0100
Message-ID: <1426608016-2978-10-git-send-email-mhagger@alum.mit.edu>
References: <1426608016-2978-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.org>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 17 17:01:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YXtvd-0001Om-Ol
	for gcvg-git-2@plane.gmane.org; Tue, 17 Mar 2015 17:01:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932557AbbCQQBI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Mar 2015 12:01:08 -0400
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:62618 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932183AbbCQQAd (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Mar 2015 12:00:33 -0400
X-AuditID: 1207440f-f792a6d000001284-a2-55084fa1aea2
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id F6.79.04740.1AF48055; Tue, 17 Mar 2015 12:00:33 -0400 (EDT)
Received: from michael.fritz.box (p4FC96AAE.dip0.t-ipconnect.de [79.201.106.174])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t2HG0LSk023811
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Tue, 17 Mar 2015 12:00:32 -0400
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1426608016-2978-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrHIsWRmVeSWpSXmKPExsUixO6iqLvQnyPUoHG2oEXXlW4mi4beK8wW
	t1fMZ7Z4fGsCkwOLx9/3H5g85t639Lh4Sdnj8ya5AJYobpukxJKy4Mz0PH27BO6MlicPWQsm
	sVb07L7A1sD4i7mLkZNDQsBE4tbXFihbTOLCvfVsXYxcHEIClxklZmy7yAjhnGSSONX5iAmk
	ik1AV2JRTzOYLSKgJjGx7RALiM0skCLR+ecOO4gtLGAhMfvfNVYQm0VAVWLyzXlsIDavgItE
	3+1LrBDb5CTOH/8JtpkTKP7iz2tGEFtIwFli7bTJbBMYeRcwMqxilEvMKc3VzU3MzClOTdYt
	Tk7My0st0jXRy80s0UtNKd3ECAkf/h2MXetlDjEKcDAq8fA25LGHCrEmlhVX5h5ilORgUhLl
	zfPgCBXiS8pPqcxILM6ILyrNSS0+xCjBwawkwnvHHSjHm5JYWZValA+TkuZgURLnVV+i7ick
	kJ5YkpqdmlqQWgSTleHgUJLg1fEDahQsSk1PrUjLzClBSDNxcIIM55ISKU7NS0ktSiwtyYgH
	xUZ8MTA6QFI8QHsrQNp5iwsSc4GiEK2nGHU57kz5v4hJiCUvPy9VSpw3CKRIAKQoozQPbgUs
	WbxiFAf6WJh3DkgVDzDRwE16BbSECWhJSzsbyJKSRISUVAPjqop55ouDjj/K6mLTzv0XlWsv
	pRh9OJqP9+GSexJWr7kUQvcyFcuz/JOZ3qA4sejvraUWvLGxlfLnujYWHb+hnj5pxTXvXdY/
	Z7JsT4oQyFHyOGstvna+ptr9SxMf+Ef8bOx3D5M6m3ngiLVt0oSNR1OdAiYWbHMU 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265645>

opt_arg() is never called with val set to NULL, so remove the code for
handling that eventuality (which anyway wasn't handled consistently in
the function).

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 diff.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/diff.c b/diff.c
index a350677..6e3f498 100644
--- a/diff.c
+++ b/diff.c
@@ -3367,7 +3367,7 @@ static int opt_arg(const char *arg, int arg_short, const char *arg_long, int *va
 		c = *++arg;
 		if (!c)
 			return 1;
-		if (val && isdigit(c)) {
+		if (isdigit(c)) {
 			char *end;
 			int n = strtoul(arg, &end, 10);
 			if (*end)
-- 
2.1.4
