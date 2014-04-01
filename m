From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 08/22] struct lock_file: replace on_list field with flags field
Date: Tue,  1 Apr 2014 17:58:16 +0200
Message-ID: <1396367910-7299-9-git-send-email-mhagger@alum.mit.edu>
References: <1396367910-7299-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 01 17:59:06 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WV15d-0004hY-Q1
	for gcvg-git-2@plane.gmane.org; Tue, 01 Apr 2014 17:59:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751881AbaDAP6x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Apr 2014 11:58:53 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:56291 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751868AbaDAP6s (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 Apr 2014 11:58:48 -0400
X-AuditID: 12074413-f79076d000002d17-c8-533ae2386908
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 49.58.11543.832EA335; Tue,  1 Apr 2014 11:58:48 -0400 (EDT)
Received: from michael.fritz.box (p57A2460D.dip0.t-ipconnect.de [87.162.70.13])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s31FwWbC027325
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Tue, 1 Apr 2014 11:58:47 -0400
X-Mailer: git-send-email 1.9.0
In-Reply-To: <1396367910-7299-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrDIsWRmVeSWpSXmKPExsUixO6iqGvxyCrYoGOukEXXlW4mi4beK8wW
	t1fMZ7b4dfgJu8WPlh5mB1aPv+8/MHnsnHWX3eNZ7x5Gj4uXlD0+b5ILYI3itklKLCkLzkzP
	07dL4M64NTWxYAZXRd+V90wNjO0cXYycHBICJhIH5/5kh7DFJC7cW8/WxcjFISRwmVGie840
	KOcYk8SFVUsZQarYBHQlFvU0M4HYIgJqEhPbDrGA2MwCKRKv/u4Cs4UF/CX2/pjBCmKzCKhK
	nOmcBWbzCjhLHH53nhlim5zElN8LwDZzCrhIXHqwB6xGCKjm9JvFzBMYeRcwMqxilEvMKc3V
	zU3MzClOTdYtTk7My0st0jXXy80s0UtNKd3ECAkp4R2Mu07KHWIU4GBU4uE9cN4qWIg1say4
	MvcQoyQHk5Io74+7QCG+pPyUyozE4oz4otKc1OJDjBIczEoivLNuAuV4UxIrq1KL8mFS0hws
	SuK8akvU/YQE0hNLUrNTUwtSi2CyMhwcShK8UQ+BGgWLUtNTK9Iyc0oQ0kwcnCDDuaREilPz
	UlKLEktLMuJBkRFfDIwNkBQP0N7pIO28xQWJuUBRiNZTjIpS4rwhIAkBkERGaR7cWFiieMUo
	DvSlMO9ikCoeYJKB634FNJgJaDD3OrDBJYkIKakGRoGHR37IyVgFcbQ+ecIT4s1bLCfKmhZ4
	Zvf5BmsW+zUP1+xtDPvMtGn9ujurtWxebTyiw1/X+YKpv2nF/vXaMZOYHAMqolY/nP3k4Wue
	8BnSTYam6jOX714k9zaOYUX67ij152/OaWTdmah1L0/9eKLfN5tlbM3OS5+XqMQX 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245594>

This makes space for other bits.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 cache.h    | 2 +-
 lockfile.c | 9 +++++++--
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/cache.h b/cache.h
index 107ac61..08d0e48 100644
--- a/cache.h
+++ b/cache.h
@@ -537,7 +537,7 @@ struct lock_file {
 	struct lock_file *next;
 	int fd;
 	pid_t owner;
-	char on_list;
+	unsigned char flags;
 	char filename[PATH_MAX];
 };
 #define LOCK_DIE_ON_ERROR 1
diff --git a/lockfile.c b/lockfile.c
index c989f6c..33325a4 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -4,6 +4,11 @@
 #include "cache.h"
 #include "sigchain.h"
 
+/* Values for lock_file::flags: */
+
+/* This lock_file instance is in the lock_file_list */
+#define LOCK_FLAGS_ON_LIST 0x01
+
 static struct lock_file *lock_file_list;
 static const char *alternate_index_output;
 
@@ -137,10 +142,10 @@ static int lock_file(struct lock_file *lk, const char *path, int flags)
 	}
 
 	lk->owner = getpid();
-	if (!lk->on_list) {
+	if (!(lk->flags & LOCK_FLAGS_ON_LIST)) {
 		/* Initialize *lk and add it to lock_file_list: */
 		lk->fd = -1;
-		lk->on_list = 1;
+		lk->flags |= LOCK_FLAGS_ON_LIST;
 		lk->filename[0] = 0;
 		lk->next = lock_file_list;
 		lock_file_list = lk;
-- 
1.9.0
