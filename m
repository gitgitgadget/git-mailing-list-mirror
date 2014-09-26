From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v6 15/39] lock_file(): exit early if lockfile cannot be opened
Date: Fri, 26 Sep 2014 12:08:15 +0200
Message-ID: <1411726119-31598-16-git-send-email-mhagger@alum.mit.edu>
References: <1411726119-31598-1-git-send-email-mhagger@alum.mit.edu>
Cc: Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Jeff King <peff@peff.net>,
	Ronnie Sahlberg <sahlberg@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 26 12:10:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XXSU4-0004vv-Fa
	for gcvg-git-2@plane.gmane.org; Fri, 26 Sep 2014 12:10:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755454AbaIZKKd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Sep 2014 06:10:33 -0400
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:61732 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755736AbaIZKJP (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 26 Sep 2014 06:09:15 -0400
X-AuditID: 12074414-f79446d000001f1d-c6-54253b4b7f0f
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id B9.0F.07965.B4B35245; Fri, 26 Sep 2014 06:09:15 -0400 (EDT)
Received: from michael.berhq.github.net ([178.19.210.163])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s8QA8lM0013914
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Fri, 26 Sep 2014 06:09:13 -0400
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1411726119-31598-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpmleLIzCtJLcpLzFFi42IRYndR1PW2Vg0xaHzOb9F1pZvJoqH3CrPF
	k7l3mS3e3lzCaHF7xXxmix8tPcwW/ybUWHR2fGV04PD4+/4Dk8fOWXfZPRZsKvV4+KqL3eNZ
	7x5Gj4uXlD0+b5LzuP1sG0sARxS3TVJiSVlwZnqevl0Cd8ap+YtZC/ZxVSxYfoKlgXENRxcj
	J4eEgIlEy7EHTBC2mMSFe+vZQGwhgcuMEof74rsYuYDsTUwSUxecYwRJsAnoSizqaQZrEBFQ
	k5jYdogFpIhZYDGTxIRDm4C6OTiEBfwkepYZgtSwCKhK7Du5mgUkzCvgKjFpYgjELjmJDbv/
	g43kBAo3br/GCLHXRaJl/WSWCYy8CxgZVjHKJeaU5urmJmbmFKcm6xYnJ+blpRbpWujlZpbo
	paaUbmKEBKLIDsYjJ+UOMQpwMCrx8N5YpxIixJpYVlyZe4hRkoNJSZT3i4VqiBBfUn5KZUZi
	cUZ8UWlOavEhRgkOZiUR3jtGQDnelMTKqtSifJiUNAeLkjjvt8XqfkIC6YklqdmpqQWpRTBZ
	GQ4OJQnei5ZAjYJFqempFWmZOSUIaSYOTpDhXFIixal5KalFiaUlGfGguIgvBkYGSIoHaO8U
	kHbe4oLEXKAoROspRl2OdZ3f+pmEWPLy81KlxHmPgBQJgBRllObBrYClnVeM4kAfC/PeAKni
	AaYsuEmvgJYwAS1ROqIMsqQkESEl1cBoVG36aebiRcURt1au1rGev2FJSJOxVpOv14W0F69D
	czlv77Lf4F6YbXn9tLDEcZ8Fs09KnHCLun3SSOSJt8Xh3qb7a6++/DlN7OT/m2da 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257523>

This is a bit easier to read than the old version, which nested part
of the non-error code in an "if" block.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
Reviewed-by: Ronnie Sahlberg <sahlberg@google.com>
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
---
 lockfile.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/lockfile.c b/lockfile.c
index 23847fc..a8f32e5 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -197,19 +197,18 @@ static int lock_file(struct lock_file *lk, const char *path, int flags)
 		resolve_symlink(lk->filename, max_path_len);
 	strcat(lk->filename, LOCK_SUFFIX);
 	lk->fd = open(lk->filename, O_RDWR | O_CREAT | O_EXCL, 0666);
-	if (0 <= lk->fd) {
-		lk->owner = getpid();
-		if (adjust_shared_perm(lk->filename)) {
-			int save_errno = errno;
-			error("cannot fix permission bits on %s",
-			      lk->filename);
-			rollback_lock_file(lk);
-			errno = save_errno;
-			return -1;
-		}
-	}
-	else
+	if (lk->fd < 0) {
 		lk->filename[0] = 0;
+		return -1;
+	}
+	lk->owner = getpid();
+	if (adjust_shared_perm(lk->filename)) {
+		int save_errno = errno;
+		error("cannot fix permission bits on %s", lk->filename);
+		rollback_lock_file(lk);
+		errno = save_errno;
+		return -1;
+	}
 	return lk->fd;
 }
 
-- 
2.1.0
