From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 12/20] log_ref_write_1(): inline function
Date: Tue, 16 Feb 2016 14:22:25 +0100
Message-ID: <5c317eec82b3da3cd4f4a2bba276afe6ef2603d9.1455626201.git.mhagger@alum.mit.edu>
References: <cover.1455626201.git.mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Karl Moskowski <kmoskowski@me.com>,
	Jeff King <peff@peff.net>, Mike Hommey <mh@glandium.org>,
	David Turner <dturner@twopensource.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 16 14:30:42 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVfiD-0003Ac-LN
	for gcvg-git-2@plane.gmane.org; Tue, 16 Feb 2016 14:30:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932370AbcBPNaa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Feb 2016 08:30:30 -0500
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:52078 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932351AbcBPNa2 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Feb 2016 08:30:28 -0500
X-AuditID: 12074412-b07ff70000006da4-51-56c322b9c896
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id 58.4D.28068.9B223C65; Tue, 16 Feb 2016 08:23:06 -0500 (EST)
Received: from michael.fritz.box (p548D6919.dip0.t-ipconnect.de [84.141.105.25])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u1GDMfOY028717
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Tue, 16 Feb 2016 08:23:04 -0500
X-Mailer: git-send-email 2.7.0
In-Reply-To: <cover.1455626201.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrKIsWRmVeSWpSXmKPExsUixO6iqLtL6XCYwb8+Zov5m04wWnRd6Way
	aOi9wmzxYe0hNoveyb2sFrdXzGe2+NHSw+zA7vH3/Qcmj6fbpzB7vDhf4fGsdw+jx8VLyh4L
	nt9n9/i8SS6APYrbJimxpCw4Mz1P3y6BO2PmuV+MBV/5KrY/7mJqYGzj6WLk5JAQMJE4tX0b
	YxcjF4eQwFZGiXObm9ggnBNMEuf7+hhBqtgEdCUW9TQzgdgiAmoSE9sOsYAUMQs8YpTo2r8d
	rEhYwFJi7ZqjbCA2i4CqxLfp28AaeAWiJLYd/swKsU5OouXHbjCbU8BC4mRLLwuILSRgLnHn
	yx6mCYw8CxgZVjHKJeaU5urmJmbmFKcm6xYnJ+blpRbpmunlZpbopaaUbmKEBJnQDsb1J+UO
	MQpwMCrx8G5wPRQmxJpYVlyZe4hRkoNJSZSXh/twmBBfUn5KZUZicUZ8UWlOavEhRgkOZiUR
	3n+vgMp5UxIrq1KL8mFS0hwsSuK8Pxer+wkJpCeWpGanphakFsFkZTg4lCR4OxSBhgoWpaan
	VqRl5pQgpJk4OEGGc0mJFKfmpaQWJZaWZMSDoiC+GBgHICkeoL1pIO28xQWJuUBRiNZTjIpS
	4rwuIAkBkERGaR7cWFjqeMUoDvSlMG83SBUPMO3Adb8CGswENDjnEshDxSWJCCmpBkavp4+d
	lld8NteKFNHUPmAYv/LIC1mlP8Gen4QCLrClRi5ct94wsTj8X/D06TXlDfrvy59P6jyulRoz
	t168bsURhdercp6zOcYlntkzOUujVLv9k3Ji/60rk24b2xRlK5ft+Rvxx6/+t8Sn 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286378>

Now log_ref_write_1() doesn't do anything, so inline it.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/files-backend.c | 29 +++++++++++------------------
 1 file changed, 11 insertions(+), 18 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 120189c..9c13653 100644
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
