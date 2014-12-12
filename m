From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 18/24] Move newlog and last_kept_sha1 to "struct expire_reflog_cb"
Date: Fri, 12 Dec 2014 09:56:57 +0100
Message-ID: <1418374623-5566-19-git-send-email-mhagger@alum.mit.edu>
References: <1418374623-5566-1-git-send-email-mhagger@alum.mit.edu>
Cc: Stefan Beller <sbeller@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 12 09:58:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XzM3A-00052F-Q9
	for gcvg-git-2@plane.gmane.org; Fri, 12 Dec 2014 09:58:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934694AbaLLI6D (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Dec 2014 03:58:03 -0500
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:58938 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S965237AbaLLI5g (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 12 Dec 2014 03:57:36 -0500
X-AuditID: 1207440c-f79376d00000680a-e9-548aae00ee74
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id 1A.8E.26634.00EAA845; Fri, 12 Dec 2014 03:57:36 -0500 (EST)
Received: from michael.fritz.box (p5DDB074C.dip0.t-ipconnect.de [93.219.7.76])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id sBC8v9nS023104
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Fri, 12 Dec 2014 03:57:35 -0500
X-Mailer: git-send-email 2.1.3
In-Reply-To: <1418374623-5566-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrHIsWRmVeSWpSXmKPExsUixO6iqMuwrivE4MIEAYuuK91MFg29V5gt
	3t5cwmhxe8V8Zovevk+sFps3t7M4sHn8ff+ByWPnrLvsHgs2lXpcvKTs8XmTXABrFLdNUmJJ
	WXBmep6+XQJ3xpoNK9gLJohX7Flc08C4U6iLkZNDQsBE4u6fe6wQtpjEhXvr2UBsIYHLjBKv
	j4p0MXIB2ceYJNpW/mcESbAJ6Eos6mlmArFFBNQkJrYdYgGxmQVOMErMbggBsYUFQiXWnFkG
	Vs8ioCpxsfEfM4jNK+Aicercb6BlHEDL5CS2rvMGCXMChS+2PGGB2OsssXVFJ+sERt4FjAyr
	GOUSc0pzdXMTM3OKU5N1i5MT8/JSi3QN9XIzS/RSU0o3MULCimcH47d1MocYBTgYlXh4X6R2
	hQixJpYVV+YeYpTkYFIS5f0+GSjEl5SfUpmRWJwRX1Sak1p8iFGCg1lJhPdvFFCONyWxsiq1
	KB8mJc3BoiTOq7pE3U9IID2xJDU7NbUgtQgmK8PBoSTBG7cGqFGwKDU9tSItM6cEIc3EwQky
	nEtKpDg1LyW1KLG0JCMeFBXxxcC4AEnxAO0NBmnnLS5IzAWKQrSeYlSUEudtBUkIgCQySvPg
	xsKSxStGcaAvhXnrQKp4gIkGrvsV0GAmoMHLt3SADC5JREhJNTAWfJj9Wmbh35hjNQZiLHZC
	J95PXLngjZnZQWG2N7FCDv7MjPaifC87nFcZ55xb0/Dr1neVx3LsD698C9gT67ao2FVDXKZI
	fluV+oo+Tt+re1M2JltWvTFqcG7fcl8/V6IhbClvs/tO44dBd6YYtXFs5nZ/6Z58 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261337>

These members are not needed by the policy functions.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
Reviewed-by: Stefan Beller <sbeller@google.com>
---
 builtin/reflog.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/builtin/reflog.c b/builtin/reflog.c
index f86e7de..d36c2c6 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -36,7 +36,6 @@ struct cmd_reflog_expire_cb {
 };
 
 struct expire_reflog_policy_cb {
-	FILE *newlog;
 	enum {
 		UE_NORMAL,
 		UE_ALWAYS,
@@ -45,7 +44,6 @@ struct expire_reflog_policy_cb {
 	struct commit_list *mark_list;
 	unsigned long mark_limit;
 	struct cmd_reflog_expire_cb *cmd;
-	unsigned char last_kept_sha1[20];
 	struct commit *tip_commit;
 	struct commit_list *tips;
 };
@@ -53,6 +51,8 @@ struct expire_reflog_policy_cb {
 struct expire_reflog_cb {
 	unsigned int flags;
 	void *policy_cb;
+	FILE *newlog;
+	unsigned char last_kept_sha1[20];
 };
 
 struct collected_reflog {
@@ -338,23 +338,23 @@ static int expire_reflog_ent(unsigned char *osha1, unsigned char *nsha1,
 	struct expire_reflog_policy_cb *policy_cb = cb->policy_cb;
 
 	if (cb->flags & EXPIRE_REFLOGS_REWRITE)
-		osha1 = policy_cb->last_kept_sha1;
+		osha1 = cb->last_kept_sha1;
 
 	if (should_expire_reflog_ent(osha1, nsha1, email, timestamp, tz,
 				     message, policy_cb)) {
-		if (!policy_cb->newlog)
+		if (!cb->newlog)
 			printf("would prune %s", message);
 		else if (cb->flags & EXPIRE_REFLOGS_VERBOSE)
 			printf("prune %s", message);
 	} else {
-		if (policy_cb->newlog) {
+		if (cb->newlog) {
 			char sign = (tz < 0) ? '-' : '+';
 			int zone = (tz < 0) ? (-tz) : tz;
-			fprintf(policy_cb->newlog, "%s %s %s %lu %c%04d\t%s",
+			fprintf(cb->newlog, "%s %s %s %lu %c%04d\t%s",
 				sha1_to_hex(osha1), sha1_to_hex(nsha1),
 				email, timestamp, sign, zone,
 				message);
-			hashcpy(policy_cb->last_kept_sha1, nsha1);
+			hashcpy(cb->last_kept_sha1, nsha1);
 		}
 		if (cb->flags & EXPIRE_REFLOGS_VERBOSE)
 			printf("keep %s", message);
@@ -468,8 +468,8 @@ static int expire_reflog(const char *refname, const unsigned char *sha1,
 			strbuf_release(&err);
 			goto failure;
 		}
-		policy_cb.newlog = fdopen_lock_file(&reflog_lock, "w");
-		if (!policy_cb.newlog) {
+		cb.newlog = fdopen_lock_file(&reflog_lock, "w");
+		if (!cb.newlog) {
 			error("cannot fdopen %s (%s)",
 			      reflog_lock.filename.buf, strerror(errno));
 			goto failure;
@@ -488,7 +488,7 @@ static int expire_reflog(const char *refname, const unsigned char *sha1,
 					strerror(errno));
 		} else if ((flags & EXPIRE_REFLOGS_UPDATE_REF) &&
 			(write_in_full(lock->lock_fd,
-				sha1_to_hex(policy_cb.last_kept_sha1), 40) != 40 ||
+				sha1_to_hex(cb.last_kept_sha1), 40) != 40 ||
 			 write_str_in_full(lock->lock_fd, "\n") != 1 ||
 			 close_ref(lock) < 0)) {
 			status |= error("couldn't write %s",
-- 
2.1.3
