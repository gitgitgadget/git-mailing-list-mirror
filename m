From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 10/20] log_ref_write_1(): don't depend on logfile
Date: Thu, 25 Feb 2016 14:16:09 +0100
Message-ID: <0f2ae0f9766d36b697291cea21c517a3c53c9c69.1456405699.git.mhagger@alum.mit.edu>
References: <cover.1456405698.git.mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Karl Moskowski <kmoskowski@me.com>,
	Jeff King <peff@peff.net>, Mike Hommey <mh@glandium.org>,
	David Turner <dturner@twopensource.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 25 14:23:56 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYvtb-0008Bi-N5
	for gcvg-git-2@plane.gmane.org; Thu, 25 Feb 2016 14:23:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760686AbcBYNXw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Feb 2016 08:23:52 -0500
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:46576 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1760171AbcBYNXv (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 25 Feb 2016 08:23:51 -0500
X-Greylist: delayed 426 seconds by postgrey-1.27 at vger.kernel.org; Thu, 25 Feb 2016 08:23:51 EST
X-AuditID: 12074412-b07ff70000006da4-f1-56cefebe8cee
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id BA.A8.28068.EBEFEC65; Thu, 25 Feb 2016 08:16:46 -0500 (EST)
Received: from michael.fritz.box (p548D63F1.dip0.t-ipconnect.de [84.141.99.241])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u1PDGPro024973
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Thu, 25 Feb 2016 08:16:45 -0500
X-Mailer: git-send-email 2.7.0
In-Reply-To: <cover.1456405698.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrCIsWRmVeSWpSXmKPExsUixO6iqLvv37kwg7d/9S3mbzrBaNF1pZvJ
	oqH3CrPFh7WH2Cx6J/eyWtxeMZ/Z4kdLD7MDu8ff9x+YPJ5un8Ls8eJ8hcez3j2MHhcvKXss
	eH6f3ePzJrkA9ihum6TEkrLgzPQ8fbsE7oxvj5awFrzlrHg/pZ2xgfErexcjB4eEgInEubOl
	XYxcHEICWxklOqatYIFwTjBJPFyxibGLkZODTUBXYlFPMxOILSKgJjGx7RBYEbPAI0aJrv3b
	wYqEBVwknn7cxw5iswioShy/fp0VxOYViJJo+/QbrFlCQE6i5cdusDingIXExZPTmUFsIQFz
	iVU39rBPYORZwMiwilEuMac0Vzc3MTOnODVZtzg5MS8vtUjXTC83s0QvNaV0EyMkxIR2MK4/
	KXeIUYCDUYmHN+L32TAh1sSy4srcQ4ySHExKorx7np8LE+JLyk+pzEgszogvKs1JLT7EKMHB
	rCTCu+IvUI43JbGyKrUoHyYlzcGiJM77c7G6n5BAemJJanZqakFqEUxWhoNDSYKXGRhLQoJF
	qempFWmZOSUIaSYOTpDhXFIixal5KalFiaUlGfGgGIgvBkYBSIoHaK8iSDtvcUFiLlAUovUU
	o6KUOO9ykIMEQBIZpXlwY2GJ4xWjONCXwrxmIFU8wKQD1/0KaDAT0OCZG8AGlyQipKQaGBMe
	neFi+LE4+w+/Ukfpuqru/wpz8xb+47s/06qXJe9VadXUGT53Qo88nMPeMyto4jllMb60JbWS
	JYk6Dt+SD25Y2hk0qWLj7xZ+A1/526zN97a2ei50EdowPWDxhxMt5ZYiYe0RVcnq 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287383>

It's unnecessary to pass a strbuf holding the reflog path up and down
the call stack now that it is hardly needed by the callers. Remove the
places where log_ref_write_1() uses it, in preparation for making it
internal to log_ref_setup().

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/files-backend.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 5937099..4f25932 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2705,14 +2705,14 @@ static int log_ref_write_1(const char *refname, const unsigned char *old_sha1,
 	result = log_ref_write_fd(logfd, old_sha1, new_sha1,
 				  git_committer_info(0), msg);
 	if (result) {
-		strbuf_addf(err, "unable to append to %s: %s", logfile->buf,
-			    strerror(errno));
+		strbuf_addf(err, "unable to append to %s: %s",
+			    git_path("logs/%s", refname), strerror(errno));
 		close(logfd);
 		return -1;
 	}
 	if (close(logfd)) {
-		strbuf_addf(err, "unable to append to %s: %s", logfile->buf,
-			    strerror(errno));
+		strbuf_addf(err, "unable to append to %s: %s",
+			    git_path("logs/%s", refname), strerror(errno));
 		return -1;
 	}
 	return 0;
-- 
2.7.0
