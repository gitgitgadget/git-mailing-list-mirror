From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 16/24] expire_reflog(): move verbose to flags argument
Date: Fri, 12 Dec 2014 09:56:55 +0100
Message-ID: <1418374623-5566-17-git-send-email-mhagger@alum.mit.edu>
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
	id 1XzM2d-0004NQ-6j
	for gcvg-git-2@plane.gmane.org; Fri, 12 Dec 2014 09:57:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934687AbaLLI5f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Dec 2014 03:57:35 -0500
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:59926 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S934683AbaLLI5e (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 12 Dec 2014 03:57:34 -0500
X-AuditID: 12074414-f797f6d000004084-d6-548aadfdc11a
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id 33.13.16516.DFDAA845; Fri, 12 Dec 2014 03:57:33 -0500 (EST)
Received: from michael.fritz.box (p5DDB074C.dip0.t-ipconnect.de [93.219.7.76])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id sBC8v9nQ023104
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Fri, 12 Dec 2014 03:57:32 -0500
X-Mailer: git-send-email 2.1.3
In-Reply-To: <1418374623-5566-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrLIsWRmVeSWpSXmKPExsUixO6iqPt3bVeIweFnGhZdV7qZLBp6rzBb
	vL25hNHi9or5zBa9fZ9YLTZvbmdxYPP4+/4Dk8fOWXfZPRZsKvW4eEnZ4/MmuQDWKG6bpMSS
	suDM9Dx9uwTujGd30go2iFT8XP2IuYFxlkAXIweHhICJxMrjhV2MnECmmMSFe+vZQGwhgcuM
	Eg+Xu3YxcgHZx5gk/r/4yAySYBPQlVjU08wEYosIqElMbDvEAmIzC5xglJjdEAJiCwt4Sux5
	9IcdxGYRUJXYNfMC2FBeAReJ9bNmMUPslZPYus4bJMwJFL7Y8oQFYq+zxNYVnawTGHkXMDKs
	YpRLzCnN1c1NzMwpTk3WLU5OzMtLLdK10MvNLNFLTSndxAgJKpEdjEdOyh1iFOBgVOLhfZHa
	FSLEmlhWXJl7iFGSg0lJlPf7ZKAQX1J+SmVGYnFGfFFpTmrxIUYJDmYlEd6/UUA53pTEyqrU
	onyYlDQHi5I477fF6n5CAumJJanZqakFqUUwWRkODiUJ3qNrgBoFi1LTUyvSMnNKENJMHJwg
	w7mkRIpT81JSixJLSzLiQTERXwyMCpAUD9BetrUge4sLEnOBohCtpxgVpcR5T4PMFQBJZJTm
	wY2FpYpXjOJAXwrzOoJU8QDTDFz3K6DBTECDl2/pABlckoiQkmpgzC178+az6JotfEXVO/IX
	3ZQt0fVdWVvM9rWDgXnJudvLvmZkvz8ctEvEaknuZafFVmFhJX/s2CIupbspGz/a+9zsKquN
	kpsBV3BK46sN6rv/b6ie81jMdvEdfa/SM3scbl4QPRZTIGFic97C6n7AiUeqt0XZ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261324>

The policy objects don't care about "--verbose". So move it to
expire_reflog()'s flags parameter.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
Reviewed-by: Stefan Beller <sbeller@google.com>
---
 builtin/reflog.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/builtin/reflog.c b/builtin/reflog.c
index 08867a2..15d3cd5 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -22,14 +22,14 @@ static unsigned long default_reflog_expire_unreachable;
 
 enum expire_reflog_flags {
 	EXPIRE_REFLOGS_DRY_RUN = 1 << 0,
-	EXPIRE_REFLOGS_UPDATE_REF = 1 << 1
+	EXPIRE_REFLOGS_UPDATE_REF = 1 << 1,
+	EXPIRE_REFLOGS_VERBOSE = 1 << 2
 };
 
 struct cmd_reflog_expire_cb {
 	struct rev_info revs;
 	int stalefix;
 	int rewrite;
-	int verbose;
 	unsigned long expire_total;
 	unsigned long expire_unreachable;
 	int recno;
@@ -344,7 +344,7 @@ static int expire_reflog_ent(unsigned char *osha1, unsigned char *nsha1,
 				     message, policy_cb)) {
 		if (!policy_cb->newlog)
 			printf("would prune %s", message);
-		else if (policy_cb->cmd->verbose)
+		else if (cb->flags & EXPIRE_REFLOGS_VERBOSE)
 			printf("prune %s", message);
 	} else {
 		if (policy_cb->newlog) {
@@ -356,7 +356,7 @@ static int expire_reflog_ent(unsigned char *osha1, unsigned char *nsha1,
 				message);
 			hashcpy(policy_cb->last_kept_sha1, nsha1);
 		}
-		if (policy_cb->cmd->verbose)
+		if (cb->flags & EXPIRE_REFLOGS_VERBOSE)
 			printf("keep %s", message);
 	}
 	return 0;
@@ -693,7 +693,7 @@ static int cmd_reflog_expire(int argc, const char **argv, const char *prefix)
 		else if (!strcmp(arg, "--all"))
 			do_all = 1;
 		else if (!strcmp(arg, "--verbose"))
-			cb.verbose = 1;
+			flags |= EXPIRE_REFLOGS_VERBOSE;
 		else if (!strcmp(arg, "--")) {
 			i++;
 			break;
@@ -711,10 +711,10 @@ static int cmd_reflog_expire(int argc, const char **argv, const char *prefix)
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
 
@@ -773,7 +773,7 @@ static int cmd_reflog_delete(int argc, const char **argv, const char *prefix)
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
