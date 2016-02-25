From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 02/20] safe_create_leading_directories(): set errno on SCLD_EXISTS
Date: Thu, 25 Feb 2016 14:16:01 +0100
Message-ID: <bf790258cb69fc63fd6ebaddd249face1ff2bdf6.1456405698.git.mhagger@alum.mit.edu>
References: <cover.1456405698.git.mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Karl Moskowski <kmoskowski@me.com>,
	Jeff King <peff@peff.net>, Mike Hommey <mh@glandium.org>,
	David Turner <dturner@twopensource.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 25 14:23:42 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYvtN-00084a-Li
	for gcvg-git-2@plane.gmane.org; Thu, 25 Feb 2016 14:23:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760667AbcBYNXh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Feb 2016 08:23:37 -0500
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:46575 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759948AbcBYNXg (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 25 Feb 2016 08:23:36 -0500
X-Greylist: delayed 422 seconds by postgrey-1.27 at vger.kernel.org; Thu, 25 Feb 2016 08:23:36 EST
X-AuditID: 12074412-af3ff70000006da4-d2-56cefeb0c2d4
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id 18.A8.28068.0BEFEC65; Thu, 25 Feb 2016 08:16:32 -0500 (EST)
Received: from michael.fritz.box (p548D63F1.dip0.t-ipconnect.de [84.141.99.241])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u1PDGPrg024973
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Thu, 25 Feb 2016 08:16:31 -0500
X-Mailer: git-send-email 2.7.0
In-Reply-To: <cover.1456405698.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrKIsWRmVeSWpSXmKPExsUixO6iqLvh37kwg4/ntSzmbzrBaNF1pZvJ
	oqH3CrPFh7WH2Cx6J/eyWtxeMZ/Z4kdLD7MDu8ff9x+YPJ5un8Ls8eJ8hcez3j2MHhcvKXss
	eH6f3ePzJrkA9ihum6TEkrLgzPQ8fbsE7ozpv9+zFKwTrHj45h5rA+N93i5GTg4JAROJG4+W
	MHcxcnEICWxllFh0/SaUc4JJ4ujZ9WwgVWwCuhKLepqZQGwRATWJiW2HWECKmAUeMUp07d/O
	CJIQFgiV+LhjHpjNIqAqsXrfK2YQm1cgSuLS7uMsEOvkJFp+7GYFsTkFLCQunpwOViMkYC6x
	6sYe9gmMPAsYGVYxyiXmlObq5iZm5hSnJusWJyfm5aUW6Zrp5WaW6KWmlG5ihASZ0A7G9Sfl
	DjEKcDAq8fBG/D4bJsSaWFZcmXuIUZKDSUmUd8/zc2FCfEn5KZUZicUZ8UWlOanFhxglOJiV
	RHhX/AXK8aYkVlalFuXDpKQ5WJTEeX8uVvcTEkhPLEnNTk0tSC2CycpwcChJ8DIDo0lIsCg1
	PbUiLTOnBCHNxMEJMpxLSqQ4NS8ltSixtCQjHhQF8cXAOABJ8QDtVQRp5y0uSMwFikK0nmJU
	lBLnXQ5ykABIIqM0D24sLHW8YhQH+lKY1wykigeYduC6XwENZgIaPHMD2OCSRISUVAMjC1fZ
	igiO29bHtQrfsZ86xbB8vsMy6Z8Bug3KepfX+TxatrP6/slP3jccX+uKVmd3zfWT/fddvTlB
	5aRdzrPKltPqVzyi/Thvi3GK3Fqn0nrr8OuUG6EGTC2lzxxk+HnDFeY8u3h0e4KA 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287380>

The exit path for SCLD_EXISTS wasn't setting errno, which some callers
use to generate error messages for the user. Fix the problem and
document that the function sets errno correctly to help avoid similar
regressions in the future.

While we're at it, document the difference between
safe_create_leading_directories() and
safe_create_leading_directories_const().

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 cache.h     | 10 ++++++++--
 sha1_file.c |  4 +++-
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/cache.h b/cache.h
index 26640b4..7d3f80c 100644
--- a/cache.h
+++ b/cache.h
@@ -950,8 +950,9 @@ int adjust_shared_perm(const char *path);
 
 /*
  * Create the directory containing the named path, using care to be
- * somewhat safe against races.  Return one of the scld_error values
- * to indicate success/failure.
+ * somewhat safe against races. Return one of the scld_error values to
+ * indicate success/failure. On error, set errno to describe the
+ * problem.
  *
  * SCLD_VANISHED indicates that one of the ancestor directories of the
  * path existed at one point during the function call and then
@@ -959,6 +960,11 @@ int adjust_shared_perm(const char *path);
  * directory while we were working.  To be robust against this kind of
  * race, callers might want to try invoking the function again when it
  * returns SCLD_VANISHED.
+ *
+ * The non _const version of this function temporarily modifies its
+ * path parameter while it is working but restores it before exiting.
+ * The _const version does not modify path (at the cost of having to
+ * make a temporary scratch copy).
  */
 enum scld_error {
 	SCLD_OK = 0,
diff --git a/sha1_file.c b/sha1_file.c
index 568120e..94c6779 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -135,8 +135,10 @@ enum scld_error safe_create_leading_directories(char *path)
 		*slash = '\0';
 		if (!stat(path, &st)) {
 			/* path exists */
-			if (!S_ISDIR(st.st_mode))
+			if (!S_ISDIR(st.st_mode)) {
+				errno = ENOTDIR;
 				ret = SCLD_EXISTS;
+			}
 		} else if (mkdir(path, 0777)) {
 			if (errno == EEXIST &&
 			    !stat(path, &st) && S_ISDIR(st.st_mode))
-- 
2.7.0
