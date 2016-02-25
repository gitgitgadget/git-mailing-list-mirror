From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 12/20] log_ref_write_1(): inline function
Date: Thu, 25 Feb 2016 14:16:11 +0100
Message-ID: <cc99e0c3c2f939abc9d7c3822c181e54213e15a3.1456405699.git.mhagger@alum.mit.edu>
References: <cover.1456405698.git.mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Karl Moskowski <kmoskowski@me.com>,
	Jeff King <peff@peff.net>, Mike Hommey <mh@glandium.org>,
	David Turner <dturner@twopensource.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 25 14:17:00 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYvmq-0003nQ-1Q
	for gcvg-git-2@plane.gmane.org; Thu, 25 Feb 2016 14:16:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760406AbcBYNQw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Feb 2016 08:16:52 -0500
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:57352 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1760327AbcBYNQv (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 25 Feb 2016 08:16:51 -0500
X-AuditID: 12074411-fe7ff700000071cf-57-56cefec2d6a6
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id 80.8D.29135.2CEFEC65; Thu, 25 Feb 2016 08:16:50 -0500 (EST)
Received: from michael.fritz.box (p548D63F1.dip0.t-ipconnect.de [84.141.99.241])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u1PDGPrq024973
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Thu, 25 Feb 2016 08:16:48 -0500
X-Mailer: git-send-email 2.7.0
In-Reply-To: <cover.1456405698.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrKIsWRmVeSWpSXmKPExsUixO6iqHvo37kwgz0fhC3mbzrBaNF1pZvJ
	oqH3CrPFh7WH2Cx6J/eyWtxeMZ/Z4kdLD7MDu8ff9x+YPJ5un8Ls8eJ8hcez3j2MHhcvKXss
	eH6f3ePzJrkA9ihum6TEkrLgzPQ8fbsE7ozlJ9YxFXzlq3h3qJ+tgbGNp4uRk0NCwERi/ZFW
	9i5GLg4hga2MEjd6X7NBOCeYJI6/28YOUsUmoCuxqKeZCcQWEVCTmNh2iAWkiFngEaNE1/7t
	jCAJYQEbiSm968EaWARUJY71nWQDsXkFoiRe317GCLFOTqLlx25WEJtTwELi4snpzCC2kIC5
	xKobe9gnMPIsYGRYxSiXmFOaq5ubmJlTnJqsW5ycmJeXWqRrqpebWaKXmlK6iRESZII7GGec
	lDvEKMDBqMTDG/H7bJgQa2JZcWXuIUZJDiYlUd49z8+FCfEl5adUZiQWZ8QXleakFh9ilOBg
	VhLhXfEXKMebklhZlVqUD5OS5mBREuflW6LuJySQnliSmp2aWpBaBJOV4eBQkuBlBkaTkGBR
	anpqRVpmTglCmomDE2Q4l5RIcWpeSmpRYmlJRjwoCuKLgXEAkuIB2hsD0s5bXJCYCxSFaD3F
	qCglzrsc5CABkERGaR7cWFjqeMUoDvSlMK8ZSBUPMO3Adb8CGswENHjmBrDBJYkIKakGxshH
	ey9OnO7cM1PofcY8kxO8h/dZR/XzhFf0RkzvTUvQNyqOzz3bO2nfxYJXSfK3Tpw0ORfUujal
	h+f90Xu2k2YLLo24l7xhdsX7NzPnHTrcMqWzet+8xEdx/8qVJn7uzXJ5IGun+Knv 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287371>

Now log_ref_write_1() doesn't do anything, so inline it.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/files-backend.c | 29 +++++++++++------------------
 1 file changed, 11 insertions(+), 18 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 49713b3..bd25ae2 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2681,9 +2681,17 @@ static int log_ref_write_fd(int fd, const unsigned char *old_sha1,
 	return 0;
 }
 
-static int log_ref_write_1(const char *refname, const unsigned char *old_sha1,
-			   const unsigned char *new_sha1, const char *msg,
-			   int flags, struct strbuf *err)
+static int log_ref_write(const char *refname, const unsigned char *old_sha1,
+			 const unsigned char *new_sha1, const char *msg,
+			 int flags, struct strbuf *err)
+{
+	return files_log_ref_write(refname, old_sha1, new_sha1, msg, flags,
+				   err);
+}
+
+int files_log_ref_write(const char *refname, const unsigned char *old_sha1,
+			const unsigned char *new_sha1, const char *msg,
+			int flags, struct strbuf *err)
 {
 	int logfd, result;
 
@@ -2714,21 +2722,6 @@ static int log_ref_write_1(const char *refname, const unsigned char *old_sha1,
 	return 0;
 }
 
-static int log_ref_write(const char *refname, const unsigned char *old_sha1,
-			 const unsigned char *new_sha1, const char *msg,
-			 int flags, struct strbuf *err)
-{
-	return files_log_ref_write(refname, old_sha1, new_sha1, msg, flags,
-				   err);
-}
-
-int files_log_ref_write(const char *refname, const unsigned char *old_sha1,
-			const unsigned char *new_sha1, const char *msg,
-			int flags, struct strbuf *err)
-{
-	return log_ref_write_1(refname, old_sha1, new_sha1, msg, flags, err);
-}
-
 /*
  * Write sha1 into the open lockfile, then close the lockfile. On
  * errors, rollback the lockfile, fill in *err and
-- 
2.7.0
