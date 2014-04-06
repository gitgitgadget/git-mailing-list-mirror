From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 08/25] struct lock_file: replace on_list field with flags field
Date: Mon,  7 Apr 2014 01:33:50 +0200
Message-ID: <1396827247-28465-9-git-send-email-mhagger@alum.mit.edu>
References: <1396827247-28465-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 07 01:35:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WWwbP-000602-AS
	for gcvg-git-2@plane.gmane.org; Mon, 07 Apr 2014 01:35:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754690AbaDFXfl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Apr 2014 19:35:41 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:64144 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754608AbaDFXe6 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 6 Apr 2014 19:34:58 -0400
X-AuditID: 12074413-f79076d000002d17-e5-5341e4a1a18c
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id D0.08.11543.1A4E1435; Sun,  6 Apr 2014 19:34:57 -0400 (EDT)
Received: from michael.fritz.box (p4FDD47DB.dip0.t-ipconnect.de [79.221.71.219])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s36NYbWt011578
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Sun, 6 Apr 2014 19:34:55 -0400
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1396827247-28465-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrHIsWRmVeSWpSXmKPExsUixO6iqLvwiWOwwYaZohZdV7qZLBp6rzBb
	3F4xn9ni1+En7BY/WnqYLc68aWS06Oz4yujA7vH3/Qcmj52z7rJ7POvdw+hx8ZKyx+IHXh6f
	N8l53H62jSWAPYrbJimxpCw4Mz1P3y6BO+P/knWsBSe4Kq60X2FsYFzL0cXIySEhYCIxe1IX
	K4QtJnHh3nq2LkYuDiGBy4wSk072gyWEBI4zSTzd7w5iswnoSizqaWYCsUUE1CQmth1iAWlg
	FrjBKPFu32Egh4NDWCBIYu/rYpAaFgFVifUT3jKDhHkFXCQ6n1ZC7JKTOHlsMth4TgFXiXWT
	57JArHIBmnKPbQIj7wJGhlWMcok5pbm6uYmZOcWpybrFyYl5ealFuuZ6uZkleqkppZsYIWEn
	vINx10m5Q4wCHIxKPLwrDzkGC7EmlhVX5h5ilORgUhLltbwHFOJLyk+pzEgszogvKs1JLT7E
	KMHBrCTCe+AGUI43JbGyKrUoHyYlzcGiJM6rtkTdT0ggPbEkNTs1tSC1CCYrw8GhJMF79DFQ
	o2BRanpqRVpmTglCmomDE2Q4l5RIcWpeSmpRYmlJRjwoLuKLgZEBkuIB2nsRpJ23uCAxFygK
	0XqKUVFKnJcdmA6EBEASGaV5cGNhyeQVozjQl8K8j0HaeYCJCK77FdBgJqDBDWF2IINLEhFS
	Ug2MNREhf24aH+l6sKnuxAP+cz3ZiXPOzpw3rbGxSrY72CCr4sHKKVKxrA9tX9ivb2JiTs4z
	ztFg23e4tPPLpCsB338+t3bs4nuavotxck9/lAWjZN+c227+fc4STjv+dqz89bd/ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245810>

This makes space for other bits, which will arrive soon.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 cache.h    | 2 +-
 lockfile.c | 9 +++++++--
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/cache.h b/cache.h
index 3a873a4..59ce5cd 100644
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
index 120a6d6..0486c58 100644
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
 
@@ -136,11 +141,11 @@ static int lock_file(struct lock_file *lk, const char *path, int flags)
 		atexit(remove_lock_file);
 	}
 
-	if (!lk->on_list) {
+	if (!(lk->flags & LOCK_FLAGS_ON_LIST)) {
 		/* Initialize *lk and add it to lock_file_list: */
 		lk->fd = -1;
 		lk->owner = 0;
-		lk->on_list = 1;
+		lk->flags |= LOCK_FLAGS_ON_LIST;
 		lk->filename[0] = 0;
 		lk->next = lock_file_list;
 		lock_file_list = lk;
-- 
1.9.1
