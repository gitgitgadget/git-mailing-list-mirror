From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 14/24] struct expire_reflog_cb: a new callback data type
Date: Fri, 12 Dec 2014 09:56:53 +0100
Message-ID: <1418374623-5566-15-git-send-email-mhagger@alum.mit.edu>
References: <1418374623-5566-1-git-send-email-mhagger@alum.mit.edu>
Cc: Stefan Beller <sbeller@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 12 09:57:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XzM2c-0004NQ-IX
	for gcvg-git-2@plane.gmane.org; Fri, 12 Dec 2014 09:57:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934681AbaLLI5d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Dec 2014 03:57:33 -0500
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:47533 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S964914AbaLLI5b (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 12 Dec 2014 03:57:31 -0500
X-AuditID: 12074412-f79e46d0000036b4-48-548aadfaea8c
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id 25.5F.14004.AFDAA845; Fri, 12 Dec 2014 03:57:31 -0500 (EST)
Received: from michael.fritz.box (p5DDB074C.dip0.t-ipconnect.de [93.219.7.76])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id sBC8v9nO023104
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Fri, 12 Dec 2014 03:57:29 -0500
X-Mailer: git-send-email 2.1.3
In-Reply-To: <1418374623-5566-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrHIsWRmVeSWpSXmKPExsUixO6iqPt7bVeIQX+FRdeVbiaLht4rzBZv
	by5htLi9Yj6zRW/fJ1aLzZvbWRzYPP6+/8DksXPWXXaPBZtKPS5eUvb4vEkugDWK2yYpsaQs
	ODM9T98ugTvj0rmjjAW3FSquz3rG2MC4QKqLkZNDQsBEYuPUb0wQtpjEhXvr2boYuTiEBC4z
	Skw8fI0dwjnGJHHx/2Z2kCo2AV2JRT3NYB0iAmoSE9sOsYDYzAInGCVmN4R0MXJwCAt4S5xd
	5gESZhFQlbg7bz1YK6+Ai8TLGT/ZQUokBOQktq7zBglzAoUvtjwBmyIk4CyxdUUn6wRG3gWM
	DKsY5RJzSnN1cxMzc4pTk3WLkxPz8lKLdM30cjNL9FJTSjcxQsJKaAfj+pNyhxgFOBiVeHhf
	pHaFCLEmlhVX5h5ilORgUhLl/T4ZKMSXlJ9SmZFYnBFfVJqTWnyIUYKDWUmE928UUI43JbGy
	KrUoHyYlzcGiJM77c7G6n5BAemJJanZqakFqEUxWhoNDSYI3bg1Qo2BRanpqRVpmTglCmomD
	E2Q4l5RIcWpeSmpRYmlJRjwoLuKLgZEBkuIB2hsM0s5bXJCYCxSFaD3FqCglztsKkhAASWSU
	5sGNhSWLV4ziQF8K854BqeIBJhq47ldAg5mABi/f0gEyuCQRISXVwLhi2/WNcv8+JFjLVZz6
	mnWxR+bMwpdMknk2TF5uHh9n3187YcKzb70FOWx9C86JXC2cvsnm35l9sxb42lcs1NtTl7Wd
	7ZFV3G6XmRd/i0ousTykcnzqzg2rVi/z/cS41Wm57btEX5mT72bWX9Tc/3tG5JaV 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261325>

Add a new data type, "struct expire_reflog_cb", for holding the data
that expire_reflog() passes to expire_reflog_ent() via
for_each_reflog_ent(). For now it only holds a pointer to a "struct
expire_reflog_policy_cb", which still contains all of the actual data.
In future commits we will move some fields from the latter to the
former.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
Reviewed-by: Stefan Beller <sbeller@google.com>
---
 builtin/reflog.c | 43 ++++++++++++++++++++++++++-----------------
 1 file changed, 26 insertions(+), 17 deletions(-)

diff --git a/builtin/reflog.c b/builtin/reflog.c
index 94c34fc..9ee66d4 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -50,10 +50,15 @@ struct expire_reflog_policy_cb {
 	struct commit_list *tips;
 };
 
+struct expire_reflog_cb {
+	void *policy_cb;
+};
+
 struct collected_reflog {
 	unsigned char sha1[20];
 	char reflog[FLEX_ARRAY];
 };
+
 struct collect_reflog_cb {
 	struct collected_reflog **e;
 	int alloc;
@@ -328,28 +333,29 @@ static int expire_reflog_ent(unsigned char *osha1, unsigned char *nsha1,
 		const char *email, unsigned long timestamp, int tz,
 		const char *message, void *cb_data)
 {
-	struct expire_reflog_policy_cb *cb = cb_data;
+	struct expire_reflog_cb *cb = cb_data;
+	struct expire_reflog_policy_cb *policy_cb = cb->policy_cb;
 
-	if (cb->cmd->rewrite)
-		osha1 = cb->last_kept_sha1;
+	if (policy_cb->cmd->rewrite)
+		osha1 = policy_cb->last_kept_sha1;
 
 	if (should_expire_reflog_ent(osha1, nsha1, email, timestamp, tz,
-				     message, cb_data)) {
-		if (!cb->newlog)
+				     message, policy_cb)) {
+		if (!policy_cb->newlog)
 			printf("would prune %s", message);
-		else if (cb->cmd->verbose)
+		else if (policy_cb->cmd->verbose)
 			printf("prune %s", message);
 	} else {
-		if (cb->newlog) {
+		if (policy_cb->newlog) {
 			char sign = (tz < 0) ? '-' : '+';
 			int zone = (tz < 0) ? (-tz) : tz;
-			fprintf(cb->newlog, "%s %s %s %lu %c%04d\t%s",
+			fprintf(policy_cb->newlog, "%s %s %s %lu %c%04d\t%s",
 				sha1_to_hex(osha1), sha1_to_hex(nsha1),
 				email, timestamp, sign, zone,
 				message);
-			hashcpy(cb->last_kept_sha1, nsha1);
+			hashcpy(policy_cb->last_kept_sha1, nsha1);
 		}
-		if (cb->cmd->verbose)
+		if (policy_cb->cmd->verbose)
 			printf("keep %s", message);
 	}
 	return 0;
@@ -421,12 +427,15 @@ static int expire_reflog(const char *refname, const unsigned char *sha1,
 			 unsigned int flags, struct cmd_reflog_expire_cb *cmd)
 {
 	static struct lock_file reflog_lock;
-	struct expire_reflog_policy_cb cb;
+	struct expire_reflog_cb cb;
+	struct expire_reflog_policy_cb policy_cb;
 	struct ref_lock *lock;
 	char *log_file;
 	int status = 0;
 
 	memset(&cb, 0, sizeof(cb));
+	memset(&policy_cb, 0, sizeof(policy_cb));
+	cb.policy_cb = &policy_cb;
 
 	/*
 	 * The reflog file is locked by holding the lock on the
@@ -457,19 +466,19 @@ static int expire_reflog(const char *refname, const unsigned char *sha1,
 			strbuf_release(&err);
 			goto failure;
 		}
-		cb.newlog = fdopen_lock_file(&reflog_lock, "w");
-		if (!cb.newlog) {
+		policy_cb.newlog = fdopen_lock_file(&reflog_lock, "w");
+		if (!policy_cb.newlog) {
 			error("cannot fdopen %s (%s)",
 			      reflog_lock.filename.buf, strerror(errno));
 			goto failure;
 		}
 	}
 
-	cb.cmd = cmd;
+	policy_cb.cmd = cmd;
 
-	reflog_expiry_prepare(refname, sha1, &cb);
+	reflog_expiry_prepare(refname, sha1, &policy_cb);
 	for_each_reflog_ent(refname, expire_reflog_ent, &cb);
-	reflog_expiry_cleanup(&cb);
+	reflog_expiry_cleanup(&policy_cb);
 
 	if (!(flags & EXPIRE_REFLOGS_DRY_RUN)) {
 		if (close_lock_file(&reflog_lock)) {
@@ -477,7 +486,7 @@ static int expire_reflog(const char *refname, const unsigned char *sha1,
 					strerror(errno));
 		} else if ((flags & EXPIRE_REFLOGS_UPDATE_REF) &&
 			(write_in_full(lock->lock_fd,
-				sha1_to_hex(cb.last_kept_sha1), 40) != 40 ||
+				sha1_to_hex(policy_cb.last_kept_sha1), 40) != 40 ||
 			 write_str_in_full(lock->lock_fd, "\n") != 1 ||
 			 close_ref(lock) < 0)) {
 			status |= error("couldn't write %s",
-- 
2.1.3
