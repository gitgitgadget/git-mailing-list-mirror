From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 18/23] Move newlog and last_kept_sha1 to "struct expire_reflog_cb"
Date: Fri,  5 Dec 2014 00:08:30 +0100
Message-ID: <1417734515-11812-19-git-send-email-mhagger@alum.mit.edu>
References: <1417734515-11812-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri Dec 05 00:09:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XwfWi-0003Cj-Rr
	for gcvg-git-2@plane.gmane.org; Fri, 05 Dec 2014 00:09:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933365AbaLDXJ3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Dec 2014 18:09:29 -0500
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:60076 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933331AbaLDXJH (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 Dec 2014 18:09:07 -0500
X-AuditID: 1207440e-f79d26d000001b6e-b5-5480e992d357
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id 10.77.07022.299E0845; Thu,  4 Dec 2014 18:09:06 -0500 (EST)
Received: from michael.fritz.box (p5DDB0B3C.dip0.t-ipconnect.de [93.219.11.60])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id sB4N8deF027614
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Thu, 4 Dec 2014 18:09:05 -0500
X-Mailer: git-send-email 2.1.3
In-Reply-To: <1417734515-11812-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrIIsWRmVeSWpSXmKPExsUixO6iqDvpZUOIwbMzShZdV7qZLBp6rzBb
	vL25hNHi9or5zBa9fZ9YLTZvbmdxYPP4+/4Dk8fOWXfZPRZsKvW4eEnZ4/MmuQDWKG6bpMSS
	suDM9Dx9uwTujG+nPrEUXBWrWNL3iqWBsVeoi5GTQ0LAROLr9vNsELaYxIV764FsLg4hgcuM
	EvefvGKFcI4xSdw4cpAFpIpNQFdiUU8zE4gtIqAmMXPVbLAOZoETjBK/JnczgiSEBYIkJs+f
	zw5iswioSqx4PJMVxOYVcJW4ee0ckM0BtE5OYus6b5AwJ1B46sxWsFYhAReJZ5sWsk9g5F3A
	yLCKUS4xpzRXNzcxM6c4NVm3ODkxLy+1SNdYLzezRC81pXQTIyS4+HYwtq+XOcQowMGoxMNb
	sLs+RIg1say4MvcQoyQHk5Io79mnDSFCfEn5KZUZicUZ8UWlOanFhxglOJiVRHiNjwDleFMS
	K6tSi/JhUtIcLErivGpL1P2EBNITS1KzU1MLUotgsjIcHEoSvKUvgBoFi1LTUyvSMnNKENJM
	HJwgw7mkRIpT81JSixJLSzLiQbERXwyMDpAUD9DeMpB23uKCxFygKETrKUZFKXFea5CEAEgi
	ozQPbiwsZbxiFAf6UhhiOw8w3cB1vwIazAQ0+GxDLcjgkkSElFQDY4dVfPOTJ+83vzF0kpPZ
	90b4/LMqeXHVX2/eT2aS7DG7f3ftomWM3/QvX9qkeGnCrIsf1bNPVaZl3/7WcZt147MVR1Oz
	rVda6DBdP/m/1MM2Yvt8eYFDOoX+mb3bN+7z73ntsqz06hwz3ZOasiGxUWzr7nOb 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260826>

These members are not needed by the policy functions.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 builtin/reflog.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/builtin/reflog.c b/builtin/reflog.c
index 6294406..01b76d0 100644
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
@@ -457,8 +457,8 @@ static int expire_reflog(const char *refname, const unsigned char *sha1,
 	if (!(flags & EXPIRE_REFLOGS_DRY_RUN)) {
 		if (hold_lock_file_for_update(&reflog_lock, log_file, 0) < 0)
 			goto failure;
-		policy_cb.newlog = fdopen_lock_file(&reflog_lock, "w");
-		if (!policy_cb.newlog)
+		cb.newlog = fdopen_lock_file(&reflog_lock, "w");
+		if (!cb.newlog)
 			goto failure;
 	}
 
@@ -474,7 +474,7 @@ static int expire_reflog(const char *refname, const unsigned char *sha1,
 					strerror(errno));
 		} else if ((flags & EXPIRE_REFLOGS_UPDATE_REF) &&
 			(write_in_full(lock->lock_fd,
-				sha1_to_hex(policy_cb.last_kept_sha1), 40) != 40 ||
+				sha1_to_hex(cb.last_kept_sha1), 40) != 40 ||
 			 write_str_in_full(lock->lock_fd, "\n") != 1 ||
 			 close_ref(lock) < 0)) {
 			status |= error("Couldn't write %s",
-- 
2.1.3
