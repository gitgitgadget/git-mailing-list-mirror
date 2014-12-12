From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 13/24] Rename expire_reflog_cb to expire_reflog_policy_cb
Date: Fri, 12 Dec 2014 09:56:52 +0100
Message-ID: <1418374623-5566-14-git-send-email-mhagger@alum.mit.edu>
References: <1418374623-5566-1-git-send-email-mhagger@alum.mit.edu>
Cc: Stefan Beller <sbeller@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 12 09:58:05 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XzM31-0004td-Hf
	for gcvg-git-2@plane.gmane.org; Fri, 12 Dec 2014 09:58:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965286AbaLLI5h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Dec 2014 03:57:37 -0500
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:58938 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S934685AbaLLI5f (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 12 Dec 2014 03:57:35 -0500
X-AuditID: 1207440c-f79376d00000680a-c1-548aadf9131d
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id 48.8E.26634.9FDAA845; Fri, 12 Dec 2014 03:57:29 -0500 (EST)
Received: from michael.fritz.box (p5DDB074C.dip0.t-ipconnect.de [93.219.7.76])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id sBC8v9nN023104
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Fri, 12 Dec 2014 03:57:28 -0500
X-Mailer: git-send-email 2.1.3
In-Reply-To: <1418374623-5566-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrAIsWRmVeSWpSXmKPExsUixO6iqPtzbVeIwelfWhZdV7qZLBp6rzBb
	vL25hNHi9or5zBa9fZ9YLTZvbmdxYPP4+/4Dk8fOWXfZPRZsKvW4eEnZ4/MmuQDWKG6bpMSS
	suDM9Dx9uwTujKvHHzAWPJKteLZkJVMD41yJLkZODgkBE4kfqxYwQ9hiEhfurWfrYuTiEBK4
	zCjxfNNOVgjnGJPE3d4zTCBVbAK6Eot6msFsEQE1iYlth1hAbGaBE4wSsxtCQGxhAR+Jpaf/
	sYHYLAKqEn9e7wazeQVcJFb83A1UzwG0TU5i6zpvkDAnUPhiyxOwMUICzhJbV3SyTmDkXcDI
	sIpRLjGnNFc3NzEzpzg1Wbc4OTEvL7VI11AvN7NELzWldBMjJLR4djB+WydziFGAg1GJh/dF
	aleIEGtiWXFl7iFGSQ4mJVHe75OBQnxJ+SmVGYnFGfFFpTmpxYcYJTiYlUR4/0YB5XhTEiur
	UovyYVLSHCxK4ryqS9T9hATSE0tSs1NTC1KLYLIyHBxKErxxa4AaBYtS01Mr0jJzShDSTByc
	IMO5pESKU/NSUosSS0sy4kGREV8MjA2QFA/Q3mCQdt7igsRcoChE6ylGRSlx3laQhABIIqM0
	D24sLGG8YhQH+lKYtw6kigeYbOC6XwENZgIavHxLB8jgkkSElFQDY1PsYj2+n2vefWtXULkx
	S1Mnknl771zNAlVOJpvmpmBNLecP0+qWxKfffCKv8mPCHe2evY92JM603Gu7o3ju1Ibna0Uu
	7vC/LM/Yqsts6qdp8WlG5JPt8xgVMhrPZ69d4RskzJp1cNOFm+of2Va4llit22nh 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261334>

This is the first step towards separating the data needed by the
policy code from the data needed by the reflog expiration machinery.

(In a moment we will add a *new* "struct expire_reflog_cb" for the use
of expire_reflog() itself, then move fields selectively from
expire_reflog_policy_cb to expire_reflog_cb.)

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
Reviewed-by: Stefan Beller <sbeller@google.com>
---
 builtin/reflog.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/builtin/reflog.c b/builtin/reflog.c
index e238fe0..94c34fc 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -35,7 +35,7 @@ struct cmd_reflog_expire_cb {
 	int recno;
 };
 
-struct expire_reflog_cb {
+struct expire_reflog_policy_cb {
 	FILE *newlog;
 	enum {
 		UE_NORMAL,
@@ -225,7 +225,7 @@ static int keep_entry(struct commit **it, unsigned char *sha1)
  * the expire_limit and queue them back, so that the caller can call
  * us again to restart the traversal with longer expire_limit.
  */
-static void mark_reachable(struct expire_reflog_cb *cb)
+static void mark_reachable(struct expire_reflog_policy_cb *cb)
 {
 	struct commit *commit;
 	struct commit_list *pending;
@@ -264,7 +264,7 @@ static void mark_reachable(struct expire_reflog_cb *cb)
 	cb->mark_list = leftover;
 }
 
-static int unreachable(struct expire_reflog_cb *cb, struct commit *commit, unsigned char *sha1)
+static int unreachable(struct expire_reflog_policy_cb *cb, struct commit *commit, unsigned char *sha1)
 {
 	/*
 	 * We may or may not have the commit yet - if not, look it
@@ -300,7 +300,7 @@ static int should_expire_reflog_ent(unsigned char *osha1, unsigned char *nsha1,
 				    const char *email, unsigned long timestamp, int tz,
 				    const char *message, void *cb_data)
 {
-	struct expire_reflog_cb *cb = cb_data;
+	struct expire_reflog_policy_cb *cb = cb_data;
 	struct commit *old, *new;
 
 	if (timestamp < cb->cmd->expire_total)
@@ -328,7 +328,7 @@ static int expire_reflog_ent(unsigned char *osha1, unsigned char *nsha1,
 		const char *email, unsigned long timestamp, int tz,
 		const char *message, void *cb_data)
 {
-	struct expire_reflog_cb *cb = cb_data;
+	struct expire_reflog_policy_cb *cb = cb_data;
 
 	if (cb->cmd->rewrite)
 		osha1 = cb->last_kept_sha1;
@@ -355,7 +355,8 @@ static int expire_reflog_ent(unsigned char *osha1, unsigned char *nsha1,
 	return 0;
 }
 
-static int push_tip_to_list(const char *refname, const unsigned char *sha1, int flags, void *cb_data)
+static int push_tip_to_list(const char *refname, const unsigned char *sha1,
+			    int flags, void *cb_data)
 {
 	struct commit_list **list = cb_data;
 	struct commit *tip_commit;
@@ -370,7 +371,7 @@ static int push_tip_to_list(const char *refname, const unsigned char *sha1, int
 
 static void reflog_expiry_prepare(const char *refname,
 				  const unsigned char *sha1,
-				  struct expire_reflog_cb *cb)
+				  struct expire_reflog_policy_cb *cb)
 {
 	if (!cb->cmd->expire_unreachable || !strcmp(refname, "HEAD")) {
 		cb->tip_commit = NULL;
@@ -402,7 +403,7 @@ static void reflog_expiry_prepare(const char *refname,
 	}
 }
 
-static void reflog_expiry_cleanup(struct expire_reflog_cb *cb)
+static void reflog_expiry_cleanup(struct expire_reflog_policy_cb *cb)
 {
 	if (cb->unreachable_expire_kind != UE_ALWAYS) {
 		if (cb->unreachable_expire_kind == UE_HEAD) {
@@ -420,7 +421,7 @@ static int expire_reflog(const char *refname, const unsigned char *sha1,
 			 unsigned int flags, struct cmd_reflog_expire_cb *cmd)
 {
 	static struct lock_file reflog_lock;
-	struct expire_reflog_cb cb;
+	struct expire_reflog_policy_cb cb;
 	struct ref_lock *lock;
 	char *log_file;
 	int status = 0;
-- 
2.1.3
