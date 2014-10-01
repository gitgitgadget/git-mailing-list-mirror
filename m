From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v7 16/38] commit_lock_file(): inline temporary variable
Date: Wed,  1 Oct 2014 12:28:20 +0200
Message-ID: <1412159322-2622-17-git-send-email-mhagger@alum.mit.edu>
References: <1412159322-2622-1-git-send-email-mhagger@alum.mit.edu>
Cc: Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Jeff King <peff@peff.net>,
	Ronnie Sahlberg <sahlberg@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 01 12:30:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XZHB3-00036i-02
	for gcvg-git-2@plane.gmane.org; Wed, 01 Oct 2014 12:30:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751808AbaJAKa1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Oct 2014 06:30:27 -0400
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:42563 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751653AbaJAK3a (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Oct 2014 06:29:30 -0400
X-AuditID: 12074414-f79446d000001f1d-7c-542bd77d2afe
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id 75.61.07965.D77DB245; Wed,  1 Oct 2014 06:29:17 -0400 (EDT)
Received: from michael.fritz.box (p5DDB1FCB.dip0.t-ipconnect.de [93.219.31.203])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s91ASk6F026827
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Wed, 1 Oct 2014 06:29:15 -0400
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1412159322-2622-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuphleLIzCtJLcpLzFFi42IRYndR1K29rh1i8PY7n0XXlW4mi4beK8wW
	T+beZbZ4e3MJo8XtFfOZLX609DBb/JtQY9HZ8ZXRgcPj7/sPTB47Z91l91iwqdTj4asudo9n
	vXsYPS5eUvb4vEnO4/azbSwBHFHcNkmJJWXBmel5+nYJ3Bn3dq1jLfjIWrHh0HmmBsYnLF2M
	nBwSAiYSjY+2MEPYYhIX7q1n62Lk4hASuMwoMX/FcWYI5ziTxJGPx8Gq2AR0JRb1NDOB2CIC
	ahIT2w6xgBQxCyxmkphwaBMbSEJYwF1i+fWz7CA2i4CqxMmvExlBbF4BF4nv3/awQ6yTk9iw
	+z9YnBMovvxyM9hJQgLOEjvufGWawMi7gJFhFaNcYk5prm5uYmZOcWqybnFyYl5eapGuhV5u
	ZoleakrpJkZIOIrsYDxyUu4QowAHoxIPr0KCdogQa2JZcWXuIUZJDiYlUd5Fl4BCfEn5KZUZ
	icUZ8UWlOanFhxglOJiVRHizDwDleFMSK6tSi/JhUtIcLErivN8Wq/sJCaQnlqRmp6YWpBbB
	ZGU4OJQkeBmuATUKFqWmp1akZeaUIKSZODhBhnNJiRSn5qWkFiWWlmTEg6IjvhgYHyApHqC9
	ziDtvMUFiblAUYjWU4zGHC1Nb3uZONZ1futnEmLJy89LlRLnzQQpFQApzSjNg1sES0SvGMWB
	/hbmDQep4gEmMbh5r4BWMQGtSl4DtqokESEl1cCoXRJe3HdlzvkJ2nysoieyl1xX/+pwdu9n
	dSvJ/aH9b48459fXe97iudCQ8dJ7q2Xfi6u/alvUfx+fsHfi1fRUcReOnDPRhTe/ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257725>

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 lockfile.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/lockfile.c b/lockfile.c
index f8205f6..e148227 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -300,12 +300,14 @@ int reopen_lock_file(struct lock_file *lk)
 int commit_lock_file(struct lock_file *lk)
 {
 	char result_file[PATH_MAX];
-	size_t i;
+
 	if (close_lock_file(lk))
 		return -1;
+
 	strcpy(result_file, lk->filename);
-	i = strlen(result_file) - LOCK_SUFFIX_LEN; /* .lock */
-	result_file[i] = 0;
+	/* remove ".lock": */
+	result_file[strlen(result_file) - LOCK_SUFFIX_LEN] = 0;
+
 	if (rename(lk->filename, result_file))
 		return -1;
 	lk->filename[0] = 0;
-- 
2.1.0
