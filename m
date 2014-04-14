From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 13/25] lock_file(): exit early if lockfile cannot be opened
Date: Mon, 14 Apr 2014 15:54:43 +0200
Message-ID: <1397483695-10888-14-git-send-email-mhagger@alum.mit.edu>
References: <1397483695-10888-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Johannes Sixt <j.sixt@viscovery.net>,
	Jeff King <peff@peff.net>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 14 15:55:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WZhMG-0000Kw-Um
	for gcvg-git-2@plane.gmane.org; Mon, 14 Apr 2014 15:55:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755211AbaDNNzb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Apr 2014 09:55:31 -0400
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:63326 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755102AbaDNNz3 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Apr 2014 09:55:29 -0400
X-AuditID: 12074414-f79d96d000002d2b-c6-534be8d0c675
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id 3E.53.11563.0D8EB435; Mon, 14 Apr 2014 09:55:28 -0400 (EDT)
Received: from michael.fritz.box (p4FC96FF6.dip0.t-ipconnect.de [79.201.111.246])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s3EDt09D010903
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Mon, 14 Apr 2014 09:55:26 -0400
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1397483695-10888-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrOIsWRmVeSWpSXmKPExsUixO6iqHvhhXewQf92eYuuK91MFg29V5gt
	Vv6ssbi9Yj6zxa/DT9gtfrT0MFucedPIaNHZ8ZXRgcPj7/sPTB47Z91l93jWu4fR4+IlZY/F
	D7w8Pm+S87j7fyeTx+1n21gCOKK4bZISS8qCM9Pz9O0SuDNmNE9gL7jNUXFj1ibmBsafbF2M
	nBwSAiYSh67/ZYKwxSQu3FsPFOfiEBK4zCixs/EzO4Rzkkni1tKP7CBVbAK6Eot6msE6RATU
	JCa2HWIBKWIWaGeSOLSjFyjBwSEs4Cfxe4oTSA2LgKrEloa/rCBhXgFXiWXLeSCWyUmcPDYZ
	LMwJFF74IQskLCTgInH3yxTWCYy8CxgZVjHKJeaU5urmJmbmFKcm6xYnJ+blpRbpWujlZpbo
	paaUbmKEBKLIDsYjJ+UOMQpwMCrx8HbM8Q4WYk0sK67MPcQoycGkJMqbcQMoxJeUn1KZkVic
	EV9UmpNafIhRgoNZSYTXdStQjjclsbIqtSgfJiXNwaIkzvttsbqfkEB6YklqdmpqQWoRTFaG
	g0NJgnfrc6BGwaLU9NSKtMycEoQ0EwcnyHAuKZHi1LyU1KLE0pKMeFBcxBcDIwMkxQO0Nwmk
	nbe4IDEXKArReopRUUqctwQkIQCSyCjNgxsLSy+vGMWBvhTmvQ9SxQNMTXDdr4AGMwENZmkH
	G1ySiJCSamDs7leYeu9QV/UeO1mxO26F7Hqd7X+vGD8s1V6R3qW6QvoYy4TTD2webfDWPPNk
	9bRVgiyxYdtc1czlfpkpi5gGnM7dMdF7wxTt+og6jrv9T0pdLv4/8OIcY46j6JfF 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246227>

This is a bit easier to read than the old version, which nested part
of the non-error code in an "if" block.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 lockfile.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/lockfile.c b/lockfile.c
index 1ce0e87..ba791d5 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -204,16 +204,16 @@ static int lock_file(struct lock_file *lk, const char *path, int flags)
 		resolve_symlink(lk->filename, max_path_len);
 	strcat(lk->filename, LOCK_SUFFIX);
 	lk->fd = open(lk->filename, O_RDWR | O_CREAT | O_EXCL, 0666);
-	if (0 <= lk->fd) {
-		lk->owner = getpid();
-		if (adjust_shared_perm(lk->filename)) {
-			error("cannot fix permission bits on %s", lk->filename);
-			rollback_lock_file(lk);
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
+		error("cannot fix permission bits on %s", lk->filename);
+		rollback_lock_file(lk);
+		return -1;
+	}
 	return lk->fd;
 }
 
-- 
1.9.1
