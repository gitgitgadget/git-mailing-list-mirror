From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v6 05/39] rollback_lock_file(): exit early if lock is not active
Date: Fri, 26 Sep 2014 12:08:05 +0200
Message-ID: <1411726119-31598-6-git-send-email-mhagger@alum.mit.edu>
References: <1411726119-31598-1-git-send-email-mhagger@alum.mit.edu>
Cc: Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Jeff King <peff@peff.net>,
	Ronnie Sahlberg <sahlberg@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 26 12:16:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XXSZP-00023G-OA
	for gcvg-git-2@plane.gmane.org; Fri, 26 Sep 2014 12:16:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755292AbaIZKQE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Sep 2014 06:16:04 -0400
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:47264 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755990AbaIZKQB (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 26 Sep 2014 06:16:01 -0400
X-Greylist: delayed 422 seconds by postgrey-1.27 at vger.kernel.org; Fri, 26 Sep 2014 06:16:01 EDT
X-AuditID: 1207440d-f797f6d000000a4a-c0-54253b3bb4b1
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id 7B.5E.02634.B3B35245; Fri, 26 Sep 2014 06:08:59 -0400 (EDT)
Received: from michael.berhq.github.net ([178.19.210.163])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s8QA8lLo013914
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Fri, 26 Sep 2014 06:08:57 -0400
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1411726119-31598-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuphleLIzCtJLcpLzFFi42IRYndR1LW2Vg0x6DogYtF1pZvJoqH3CrPF
	k7l3mS3e3lzCaHF7xXxmix8tPcwW/ybUWHR2fGV04PD4+/4Dk8fOWXfZPRZsKvV4+KqL3eNZ
	7x5Gj4uXlD0+b5LzuP1sG0sARxS3TVJiSVlwZnqevl0Cd8bVrpOMBavZKr68+c7cwDidtYuR
	k0NCwETi0Jl7TBC2mMSFe+vZuhi5OIQELjNK3H61gxnC2cQkcfTUCzaQKjYBXYlFPc1gHSIC
	ahIT2w6xgBQxCyxmkphwaBNYkbBAgMS/RZ3MIDaLgKrE898nWUBsXgEXiYYZU9kh1slJbNj9
	nxHE5hRwlWjcfg3MFgKqaVk/mWUCI+8CRoZVjHKJOaW5urmJmTnFqcm6xcmJeXmpRbpGermZ
	JXqpKaWbGCHhyLuD8f86mUOMAhyMSjy8N9aphAixJpYVV+YeYpTkYFIS5f1ioRoixJeUn1KZ
	kVicEV9UmpNafIhRgoNZSYT3jhFQjjclsbIqtSgfJiXNwaIkzqu2RN1PSCA9sSQ1OzW1ILUI
	JivDwaEkwXvREqhRsCg1PbUiLTOnBCHNxMEJMpxLSqQ4NS8ltSixtCQjHhQd8cXA+ABJ8QDt
	5bIC2VtckJgLFIVoPcVozNHS9LaXiWNd57d+JiGWvPy8VClx3iMgmwRASjNK8+AWwRLRK0Zx
	oL+FeW+AVPEAkxjcvFdAq5iAVikdUQZZVZKIkJJqYLSIt+wMvttxWMWlcFOX3p59jEe+i4sH
	qF1bf+JO6MVApXW8vy5v7t/dKHrB4MCTO8vEUud/ulltvvuIlGvxKcOukhbRhrqv 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257528>

Eliminate a layer of nesting.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
Reviewed-by: Ronnie Sahlberg <sahlberg@google.com>
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
---
 lockfile.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/lockfile.c b/lockfile.c
index 5330d6a..e55149a 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -276,10 +276,11 @@ int hold_locked_index(struct lock_file *lk, int die_on_error)
 
 void rollback_lock_file(struct lock_file *lk)
 {
-	if (lk->filename[0]) {
-		if (lk->fd >= 0)
-			close(lk->fd);
-		unlink_or_warn(lk->filename);
-		lk->filename[0] = 0;
-	}
+	if (!lk->filename[0])
+		return;
+
+	if (lk->fd >= 0)
+		close(lk->fd);
+	unlink_or_warn(lk->filename);
+	lk->filename[0] = 0;
 }
-- 
2.1.0
