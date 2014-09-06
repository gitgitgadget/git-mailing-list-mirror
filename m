From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v4 14/32] lock_file(): exit early if lockfile cannot be opened
Date: Sat,  6 Sep 2014 09:50:28 +0200
Message-ID: <1409989846-22401-15-git-send-email-mhagger@alum.mit.edu>
References: <1409989846-22401-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Sat Sep 06 09:59:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XQAuN-0005Dd-27
	for gcvg-git-2@plane.gmane.org; Sat, 06 Sep 2014 09:59:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751383AbaIFH7h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Sep 2014 03:59:37 -0400
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:64343 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751237AbaIFH7f (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 6 Sep 2014 03:59:35 -0400
X-Greylist: delayed 437 seconds by postgrey-1.27 at vger.kernel.org; Sat, 06 Sep 2014 03:59:35 EDT
X-AuditID: 12074412-f792e6d000005517-6f-540abd31fdda
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id 8F.8E.21783.13DBA045; Sat,  6 Sep 2014 03:52:17 -0400 (EDT)
Received: from michael.fritz.box (p5DDB3D26.dip0.t-ipconnect.de [93.219.61.38])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s867pFHD006967
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Sat, 6 Sep 2014 03:52:16 -0400
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1409989846-22401-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrMIsWRmVeSWpSXmKPExsUixO6iqGu4lyvE4M4xG4uuK91MFg29V5gt
	nsy9y2xxe8V8ZosfLT3MFp0dXxkd2Dz+vv/A5PHwVRe7x7PePYweFy8pe3zeJOdx+9k2lgC2
	KG6bpMSSsuDM9Dx9uwTujBOHBAquc1b0nfnM0sB4nr2LkZNDQsBEYs2/r4wQtpjEhXvr2boY
	uTiEBC4zSjxe9Z8ZwjnGJLF98nawDjYBXYlFPc1MIAkRgTZGiV0XN7OCJJgFUiQ6nneDjRIW
	8JM4+ecTG4jNIqAqsaj/NlicV8BV4sDRBiaIdXISG3b/B4tzAsWnN3WC2UICLhLtJ/uZJjDy
	LmBkWMUol5hTmqubm5iZU5yarFucnJiXl1qka6aXm1mil5pSuokREmhCOxjXn5Q7xCjAwajE
	w1vgwBUixJpYVlyZe4hRkoNJSZQ3bzlQiC8pP6UyI7E4I76oNCe1+BCjBAezkghvx2SgHG9K
	YmVValE+TEqag0VJnPfnYnU/IYH0xJLU7NTUgtQimKwMB4eSBK/LHqBGwaLU9NSKtMycEoQ0
	EwcnyHAuKZHi1LyU1KLE0pKMeFBsxBcDowMkxQO0lxWknbe4IDEXKArReopRl2Nd57d+JiGW
	vPy8VClxXiaQIgGQoozSPLgVsLTyilEc6GNhXjGQKh5gSoKb9ApoCRPQEvN0TpAlJYkIKakG
	Rra6tW8uCruyHVg0g3XpA7Pg3c1WXTePpwtxF1QFynAtNGqZ6OJrHbRnujuPZUpoy5bz/gtu
	2X17ztLtKbtOw+nQsUQ+J9+F7jdcpfpPSkufKu4Xj3QWMi8JZnOO0o0snnqlVfUF 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256575>

This is a bit easier to read than the old version, which nested part
of the non-error code in an "if" block.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 lockfile.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/lockfile.c b/lockfile.c
index bfea333..71786c9 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -207,19 +207,18 @@ static int lock_file(struct lock_file *lk, const char *path, int flags)
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
