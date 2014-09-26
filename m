From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v6 03/39] close_lock_file(): exit (successfully) if file is already closed
Date: Fri, 26 Sep 2014 12:08:03 +0200
Message-ID: <1411726119-31598-4-git-send-email-mhagger@alum.mit.edu>
References: <1411726119-31598-1-git-send-email-mhagger@alum.mit.edu>
Cc: Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Jeff King <peff@peff.net>,
	Ronnie Sahlberg <sahlberg@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 26 12:09:08 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XXSSZ-0003Vh-2x
	for gcvg-git-2@plane.gmane.org; Fri, 26 Sep 2014 12:09:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755643AbaIZKJE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Sep 2014 06:09:04 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:61410 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755131AbaIZKI4 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 26 Sep 2014 06:08:56 -0400
X-AuditID: 12074413-f79ed6d000002501-cb-54253b374784
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 80.C9.09473.73B35245; Fri, 26 Sep 2014 06:08:56 -0400 (EDT)
Received: from michael.berhq.github.net ([178.19.210.163])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s8QA8lLm013914
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Fri, 26 Sep 2014 06:08:54 -0400
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1411726119-31598-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpjleLIzCtJLcpLzFFi42IRYndR1LWwVg0xWLmV0aLrSjeTRUPvFWaL
	J3PvMlu8vbmE0eL2ivnMFj9aepgt/k2osejs+MrowOHx9/0HJo+ds+6yeyzYVOrx8FUXu8ez
	3j2MHhcvKXt83iTncfvZNpYAjihum6TEkrLgzPQ8fbsE7ozzS/6yFEzkqvjx4QRrA+MMji5G
	Tg4JAROJFTMfMUPYYhIX7q1n62Lk4hASuMwosaVlLjOEs4lJ4ufhHnaQKjYBXYlFPc1MILaI
	gJrExLZDLCBFzAKLmSQmHNrEBpIQFoiS+NT1B2wsi4CqxOYTfSwgNq+Ai8SaA/tYIdbJSWzY
	/Z8RxOYUcJVo3H4NzBYCqmlZP5llAiPvAkaGVYxyiTmlubq5iZk5xanJusXJiXl5qUW65nq5
	mSV6qSmlmxgh4Si8g3HXSblDjAIcjEo8vDfWqYQIsSaWFVfmHmKU5GBSEuX9YqEaIsSXlJ9S
	mZFYnBFfVJqTWnyIUYKDWUmE944RUI43JbGyKrUoHyYlzcGiJM6rtkTdT0ggPbEkNTs1tSC1
	CCYrw8GhJMF70RKoUbAoNT21Ii0zpwQhzcTBCTKcS0qkODUvJbUosbQkIx4UHfHFwPgASfEA
	7eWyAtlbXJCYCxSFaD3FqMuxrvNbP5MQS15+XqqUOO8RkB0CIEUZpXlwK2DJ5xWjONDHwrw3
	QKp4gIkLbtIroCVMQEuUjiiDLClJREhJNTDWu5rLCZ6+ObG2dOvdtBd3zs3xuL77bktVqtXt
	B980Td8WfdE3lEuYmvJOKFrgO0/LC2O/GVe+27hc6nt5/krmMZfi2oDVf0/cOKkV 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257505>

Suggested-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 lockfile.c   | 6 +++++-
 read-cache.c | 2 +-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/lockfile.c b/lockfile.c
index f1ce154..d02c3bf 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -233,6 +233,10 @@ int hold_lock_file_for_append(struct lock_file *lk, const char *path, int flags)
 int close_lock_file(struct lock_file *lk)
 {
 	int fd = lk->fd;
+
+	if (fd < 0)
+		return 0;
+
 	lk->fd = -1;
 	return close(fd);
 }
@@ -251,7 +255,7 @@ int commit_lock_file(struct lock_file *lk)
 {
 	char result_file[PATH_MAX];
 	size_t i;
-	if (lk->fd >= 0 && close_lock_file(lk))
+	if (close_lock_file(lk))
 		return -1;
 	strcpy(result_file, lk->filename);
 	i = strlen(result_file) - 5; /* .lock */
diff --git a/read-cache.c b/read-cache.c
index 2fc1182..5ffb1d7 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -2042,7 +2042,7 @@ void set_alternate_index_output(const char *name)
 static int commit_locked_index(struct lock_file *lk)
 {
 	if (alternate_index_output) {
-		if (lk->fd >= 0 && close_lock_file(lk))
+		if (close_lock_file(lk))
 			return -1;
 		if (rename(lk->filename, alternate_index_output))
 			return -1;
-- 
2.1.0
