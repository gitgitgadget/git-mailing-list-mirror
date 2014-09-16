From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v5 14/35] lock_file(): exit early if lockfile cannot be opened
Date: Tue, 16 Sep 2014 21:33:35 +0200
Message-ID: <1410896036-12750-15-git-send-email-mhagger@alum.mit.edu>
References: <1410896036-12750-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>, Ronnie Sahlberg <sahlberg@google.com>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Tue Sep 16 21:41:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XTydG-0003QP-DE
	for gcvg-git-2@plane.gmane.org; Tue, 16 Sep 2014 21:41:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755032AbaIPTlk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Sep 2014 15:41:40 -0400
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:47624 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754960AbaIPTli (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Sep 2014 15:41:38 -0400
X-AuditID: 1207440f-f79156d000006a5c-fb-541890cc1ed9
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id 38.84.27228.CC098145; Tue, 16 Sep 2014 15:34:36 -0400 (EDT)
Received: from michael.fritz.box (p5DDB27D9.dip0.t-ipconnect.de [93.219.39.217])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s8GJYBcI001163
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Tue, 16 Sep 2014 15:34:35 -0400
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1410896036-12750-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrFIsWRmVeSWpSXmKPExsUixO6iqHtmgkSIweZnOhZdV7qZLBp6rzBb
	PJl7l9ni9or5zBY/WnqYLf5NqLHo7PjK6MDu8ff9ByaPBZtKPR6+6mL3eNa7h9Hj4iVlj8+b
	5DxuP9vGEsAexW2TlFhSFpyZnqdvl8CdMWWvUEE3V8WJfXuZGhj/sXcxcnJICJhIXN56gQ3C
	FpO4cG89kM3FISRwmVHieONiKOcEk8TT1oNgVWwCuhKLepqZQBIiAm2MErsubmYFcZgFuhkl
	3p84zQRSJSzgJ3G6fREriM0ioCpxfc5pRhCbV8BVor3/KyvEPjmJDbv/A8U5ODiB4l/3FYCY
	QgIuEgfv+k1g5F3AyLCKUS4xpzRXNzcxM6c4NVm3ODkxLy+1SNdELzezRC81pXQTIyTs+Hcw
	dq2XOcQowMGoxMPr8Ug8RIg1say4MvcQoyQHk5Io779uiRAhvqT8lMqMxOKM+KLSnNTiQ4wS
	HMxKIrw/fIFyvCmJlVWpRfkwKWkOFiVxXvUl6n5CAumJJanZqakFqUUwWRkODiUJXvN+oEbB
	otT01Iq0zJwShDQTByfIcC4pkeLUvJTUosTSkox4UGTEFwNjAyTFA7S3AqSdt7ggMRcoCtF6
	ilGXY13nt34mIZa8/LxUKXFeG5AiAZCijNI8uBWwJPOKURzoY2Fea5AqHmCCgpv0CmgJE9CS
	sz1iIEtKEhFSUg2MVucXa9UpzpF8oJ0t/GqNpXTdFKOMQjEjvu0hgmvmXHn185Xxc+FP56Xq
	N+591ZJX8HDVwqNO5X3Nfm8b1VLbLGa8nfX46qXVpxv9d/ra+e74r5zXq343wOTy 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257163>

This is a bit easier to read than the old version, which nested part
of the non-error code in an "if" block.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
Reviewed-by: Ronnie Sahlberg <sahlberg@google.com>
---
 lockfile.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/lockfile.c b/lockfile.c
index 99a774b..911f123 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -212,19 +212,18 @@ static int lock_file(struct lock_file *lk, const char *path, int flags)
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
