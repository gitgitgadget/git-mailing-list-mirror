From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 13/23] Rename expire_reflog_cb to expire_reflog_policy_cb
Date: Fri,  5 Dec 2014 00:08:25 +0100
Message-ID: <1417734515-11812-14-git-send-email-mhagger@alum.mit.edu>
References: <1417734515-11812-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri Dec 05 00:09:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XwfWL-0002yQ-9T
	for gcvg-git-2@plane.gmane.org; Fri, 05 Dec 2014 00:09:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933343AbaLDXJF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Dec 2014 18:09:05 -0500
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:65152 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754893AbaLDXJB (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 Dec 2014 18:09:01 -0500
X-AuditID: 1207440d-f79976d000005643-78-5480e98b254c
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id 61.16.22083.B89E0845; Thu,  4 Dec 2014 18:08:59 -0500 (EST)
Received: from michael.fritz.box (p5DDB0B3C.dip0.t-ipconnect.de [93.219.11.60])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id sB4N8deA027614
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Thu, 4 Dec 2014 18:08:58 -0500
X-Mailer: git-send-email 2.1.3
In-Reply-To: <1417734515-11812-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrIIsWRmVeSWpSXmKPExsUixO6iqNv9siHEoOOLqUXXlW4mi4beK8wW
	b28uYbS4vWI+s0Vv3ydWi82b21kc2Dz+vv/A5LFz1l12jwWbSj0uXlL2+LxJLoA1itsmKbGk
	LDgzPU/fLoE74/WEw+wF76Qrlh5uYG1gPC3WxcjJISFgIvHs8XkmCFtM4sK99WxdjFwcQgKX
	GSUuX10A5Rxjknj0fA0LSBWbgK7Eop5msA4RATWJmatmgxUxC5xglPg1uZsRJCEs4CnxpHEJ
	mM0ioCrxa1cXmM0r4Cpx+XcfUAMH0Do5ia3rvEHCnEDhqTNbwUqEBFwknm1ayD6BkXcBI8Mq
	RrnEnNJc3dzEzJzi1GTd4uTEvLzUIl0jvdzMEr3UlNJNjJDg4t3B+H+dzCFGAQ5GJR7egt31
	IUKsiWXFlbmHGCU5mJREec8+bQgR4kvKT6nMSCzOiC8qzUktPsQowcGsJMJrfAQox5uSWFmV
	WpQPk5LmYFES51Vbou4nJJCeWJKanZpakFoEk5Xh4FCS4OV6AdQoWJSanlqRlplTgpBm4uAE
	Gc4lJVKcmpeSWpRYWpIRD4qN+GJgdICkeID2loG08xYXJOYCRSFaTzEqSonzWoMkBEASGaV5
	cGNhKeMVozjQl8K8pSBVPMB0A9f9CmgwE9Dgsw21IINLEhFSUg2MTUnMJ0Ru9xhVXJtimhFx
	v3zr8SWrF+xjX1WRPPN76NW82iK+nPu6PY7nsoPv5adpuaX+Up/OpR4n4dzgrThha7uoEu+Z
	HjWu1j0/tKWmeyu0nboSOmf9BjZJHtUL7wVqnyUfbzwld7nno1PG0Usrgq2Onfv0 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260819>

This is the first step towards separating the data needed by the
policy code from the data needed by the reflog expiration machinery.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 builtin/reflog.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/builtin/reflog.c b/builtin/reflog.c
index 597c547..3538e4b 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -30,7 +30,7 @@ struct cmd_reflog_expire_cb {
 	int recno;
 };
 
-struct expire_reflog_cb {
+struct expire_reflog_policy_cb {
 	FILE *newlog;
 	enum {
 		UE_NORMAL,
@@ -220,7 +220,7 @@ static int keep_entry(struct commit **it, unsigned char *sha1)
  * the expire_limit and queue them back, so that the caller can call
  * us again to restart the traversal with longer expire_limit.
  */
-static void mark_reachable(struct expire_reflog_cb *cb)
+static void mark_reachable(struct expire_reflog_policy_cb *cb)
 {
 	struct commit *commit;
 	struct commit_list *pending;
@@ -259,7 +259,7 @@ static void mark_reachable(struct expire_reflog_cb *cb)
 	cb->mark_list = leftover;
 }
 
-static int unreachable(struct expire_reflog_cb *cb, struct commit *commit, unsigned char *sha1)
+static int unreachable(struct expire_reflog_policy_cb *cb, struct commit *commit, unsigned char *sha1)
 {
 	/*
 	 * We may or may not have the commit yet - if not, look it
@@ -295,7 +295,7 @@ static int should_expire_reflog_ent(unsigned char *osha1, unsigned char *nsha1,
 				    const char *email, unsigned long timestamp, int tz,
 				    const char *message, void *cb_data)
 {
-	struct expire_reflog_cb *cb = cb_data;
+	struct expire_reflog_policy_cb *cb = cb_data;
 	struct commit *old, *new;
 
 	if (timestamp < cb->cmd->expire_total)
@@ -323,7 +323,7 @@ static int expire_reflog_ent(unsigned char *osha1, unsigned char *nsha1,
 		const char *email, unsigned long timestamp, int tz,
 		const char *message, void *cb_data)
 {
-	struct expire_reflog_cb *cb = cb_data;
+	struct expire_reflog_policy_cb *cb = cb_data;
 
 	if (cb->cmd->rewrite)
 		osha1 = cb->last_kept_sha1;
@@ -350,7 +350,8 @@ static int expire_reflog_ent(unsigned char *osha1, unsigned char *nsha1,
 	return 0;
 }
 
-static int push_tip_to_list(const char *refname, const unsigned char *sha1, int flags, void *cb_data)
+static int push_tip_to_list(const char *refname, const unsigned char *sha1,
+			    int flags, void *cb_data)
 {
 	struct commit_list **list = cb_data;
 	struct commit *tip_commit;
@@ -365,7 +366,7 @@ static int push_tip_to_list(const char *refname, const unsigned char *sha1, int
 
 static void reflog_expiry_prepare(const char *refname,
 				  const unsigned char *sha1,
-				  struct expire_reflog_cb *cb)
+				  struct expire_reflog_policy_cb *cb)
 {
 	if (!cb->cmd->expire_unreachable || !strcmp(refname, "HEAD")) {
 		cb->tip_commit = NULL;
@@ -397,7 +398,7 @@ static void reflog_expiry_prepare(const char *refname,
 	}
 }
 
-static void reflog_expiry_cleanup(struct expire_reflog_cb *cb)
+static void reflog_expiry_cleanup(struct expire_reflog_policy_cb *cb)
 {
 	if (cb->unreachable_expire_kind != UE_ALWAYS) {
 		if (cb->unreachable_expire_kind == UE_HEAD) {
@@ -422,7 +423,7 @@ static int expire_reflog(const char *refname, const unsigned char *sha1,
 			 unsigned int flags, void *cb_data)
 {
 	struct cmd_reflog_expire_cb *cmd = cb_data;
-	struct expire_reflog_cb cb;
+	struct expire_reflog_policy_cb cb;
 	struct ref_lock *lock;
 	char *log_file;
 	int status = 0;
-- 
2.1.3
