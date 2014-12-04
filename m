From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 16/23] expire_reflog(): move verbose to flags argument
Date: Fri,  5 Dec 2014 00:08:28 +0100
Message-ID: <1417734515-11812-17-git-send-email-mhagger@alum.mit.edu>
References: <1417734515-11812-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri Dec 05 00:09:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XwfWi-0003Cj-8s
	for gcvg-git-2@plane.gmane.org; Fri, 05 Dec 2014 00:09:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933367AbaLDXJa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Dec 2014 18:09:30 -0500
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:60076 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933324AbaLDXJE (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 Dec 2014 18:09:04 -0500
X-AuditID: 1207440e-f79d26d000001b6e-ab-5480e98fa2f2
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id 7E.67.07022.F89E0845; Thu,  4 Dec 2014 18:09:03 -0500 (EST)
Received: from michael.fritz.box (p5DDB0B3C.dip0.t-ipconnect.de [93.219.11.60])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id sB4N8deD027614
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Thu, 4 Dec 2014 18:09:02 -0500
X-Mailer: git-send-email 2.1.3
In-Reply-To: <1417734515-11812-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrAIsWRmVeSWpSXmKPExsUixO6iqNv/siHE4OYBE4uuK91MFg29V5gt
	3t5cwmhxe8V8Zovevk+sFps3t7M4sHn8ff+ByWPnrLvsHgs2lXpcvKTs8XmTXABrFLdNUmJJ
	WXBmep6+XQJ3xrJ3u9kL1opXvPnyg6mB8apQFyMHh4SAicTHBdpdjJxAppjEhXvr2boYuTiE
	BC4zSkx78JoJwjnGJPFp0xpGkCo2AV2JRT3NTCC2iICaxMxVs8E6mAVOMEr8mtwNViQs4CbR
	97KBDcRmEVCVuP/sHDuIzSvgKrHx31V2iM1yElvXeYOEOYHCU2e2grUKCbhIPNu0kH0CI+8C
	RoZVjHKJOaW5urmJmTnFqcm6xcmJeXmpRbrGermZJXqpKaWbGCGhxbeDsX29zCFGAQ5GJR7e
	gt31IUKsiWXFlbmHGCU5mJREec8+bQgR4kvKT6nMSCzOiC8qzUktPsQowcGsJMJrfAQox5uS
	WFmVWpQPk5LmYFES51Vbou4nJJCeWJKanZpakFoEk5Xh4FCS4C19AdQoWJSanlqRlplTgpBm
	4uAEGc4lJVKcmpeSWpRYWpIRD4qM+GJgbICkeID2loG08xYXJOYCRSFaTzEqSonzWoMkBEAS
	GaV5cGNhCeMVozjQl8IQ23mAyQau+xXQYCagwWcbakEGlyQipKQaGN3XPr6kzWNRf8x2oujy
	hT9XHL3Jk9lwXX2O8fx/t+OfB3jFL1r7c6tqbDP/tkYHvc8JQkfPxi9znV3Ye/7XxaubJtha
	aW4+f8LtX9ui0IdbTuRN/nEnKukDb9r6FcWXmWP5rlTMPHOCP/rf6b9PZzRzvJfe 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260825>

The policy objects don't care about "--verbose". So move it to
expire_reflog()'s flags parameter.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 builtin/reflog.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/builtin/reflog.c b/builtin/reflog.c
index 1512b67..cc7a220 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -20,11 +20,16 @@ static const char reflog_delete_usage[] =
 static unsigned long default_reflog_expire;
 static unsigned long default_reflog_expire_unreachable;
 
+enum expire_reflog_flags {
+	EXPIRE_REFLOGS_DRY_RUN = 1 << 0,
+	EXPIRE_REFLOGS_UPDATE_REF = 1 << 1,
+	EXPIRE_REFLOGS_VERBOSE = 1 << 2
+};
+
 struct cmd_reflog_expire_cb {
 	struct rev_info revs;
 	int stalefix;
 	int rewrite;
-	int verbose;
 	unsigned long expire_total;
 	unsigned long expire_unreachable;
 	int recno;
@@ -339,7 +344,7 @@ static int expire_reflog_ent(unsigned char *osha1, unsigned char *nsha1,
 				     message, policy_cb)) {
 		if (!policy_cb->newlog)
 			printf("would prune %s", message);
-		else if (policy_cb->cmd->verbose)
+		else if (cb->flags & EXPIRE_REFLOGS_VERBOSE)
 			printf("prune %s", message);
 	} else {
 		if (policy_cb->newlog) {
@@ -351,7 +356,7 @@ static int expire_reflog_ent(unsigned char *osha1, unsigned char *nsha1,
 				message);
 			hashcpy(policy_cb->last_kept_sha1, nsha1);
 		}
-		if (policy_cb->cmd->verbose)
+		if (cb->flags & EXPIRE_REFLOGS_VERBOSE)
 			printf("keep %s", message);
 	}
 	return 0;
@@ -421,11 +426,6 @@ static void reflog_expiry_cleanup(struct expire_reflog_policy_cb *cb)
 
 static struct lock_file reflog_lock;
 
-enum expire_reflog_flags {
-	EXPIRE_REFLOGS_DRY_RUN = 1 << 0,
-	EXPIRE_REFLOGS_UPDATE_REF = 1 << 1
-};
-
 static int expire_reflog(const char *refname, const unsigned char *sha1,
 			 unsigned int flags, void *cb_data)
 {
@@ -679,7 +679,7 @@ static int cmd_reflog_expire(int argc, const char **argv, const char *prefix)
 		else if (!strcmp(arg, "--all"))
 			do_all = 1;
 		else if (!strcmp(arg, "--verbose"))
-			cb.verbose = 1;
+			flags |= EXPIRE_REFLOGS_VERBOSE;
 		else if (!strcmp(arg, "--")) {
 			i++;
 			break;
@@ -697,10 +697,10 @@ static int cmd_reflog_expire(int argc, const char **argv, const char *prefix)
 	 */
 	if (cb.stalefix) {
 		init_revisions(&cb.revs, prefix);
-		if (cb.verbose)
+		if (flags & EXPIRE_REFLOGS_VERBOSE)
 			printf("Marking reachable objects...");
 		mark_reachable_objects(&cb.revs, 0, 0, NULL);
-		if (cb.verbose)
+		if (flags & EXPIRE_REFLOGS_VERBOSE)
 			putchar('\n');
 	}
 
@@ -759,7 +759,7 @@ static int cmd_reflog_delete(int argc, const char **argv, const char *prefix)
 		else if (!strcmp(arg, "--updateref"))
 			flags |= EXPIRE_REFLOGS_UPDATE_REF;
 		else if (!strcmp(arg, "--verbose"))
-			cb.verbose = 1;
+			flags |= EXPIRE_REFLOGS_VERBOSE;
 		else if (!strcmp(arg, "--")) {
 			i++;
 			break;
-- 
2.1.3
