From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 17/24] expire_reflog(): move rewrite to flags argument
Date: Fri, 12 Dec 2014 09:56:56 +0100
Message-ID: <1418374623-5566-18-git-send-email-mhagger@alum.mit.edu>
References: <1418374623-5566-1-git-send-email-mhagger@alum.mit.edu>
Cc: Stefan Beller <sbeller@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 12 09:57:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XzM2o-0004eU-Dn
	for gcvg-git-2@plane.gmane.org; Fri, 12 Dec 2014 09:57:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934689AbaLLI5i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Dec 2014 03:57:38 -0500
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:58938 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S964914AbaLLI5g (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 12 Dec 2014 03:57:36 -0500
X-AuditID: 1207440c-f79376d00000680a-e4-548aadfea59f
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id 79.8E.26634.EFDAA845; Fri, 12 Dec 2014 03:57:34 -0500 (EST)
Received: from michael.fritz.box (p5DDB074C.dip0.t-ipconnect.de [93.219.7.76])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id sBC8v9nR023104
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Fri, 12 Dec 2014 03:57:33 -0500
X-Mailer: git-send-email 2.1.3
In-Reply-To: <1418374623-5566-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrAIsWRmVeSWpSXmKPExsUixO6iqPtvbVeIwf+71hZdV7qZLBp6rzBb
	vL25hNHi9or5zBa9fZ9YLTZvbmdxYPP4+/4Dk8fOWXfZPRZsKvW4eEnZ4/MmuQDWKG6bpMSS
	suDM9Dx9uwTujGfTdjIXrBGo2D53ElMD4wbeLkZODgkBE4n1XdOZIGwxiQv31rN1MXJxCAlc
	ZpRouf6IEcI5xiRx+/wCsCo2AV2JRT3NYLaIgJrExLZDLCA2s8AJRonZDSEgtrCAp8TdaZfY
	QGwWAVWJY7vPM4PYvAIuEge7nwPFOYC2yUlsXecNEuYECl9seQI2RkjAWWLrik7WCYy8CxgZ
	VjHKJeaU5urmJmbmFKcm6xYnJ+blpRbpGurlZpbopaaUbmKEhBbPDsZv62QOMQpwMCrx8L5I
	7QoRYk0sK67MPcQoycGkJMr7fTJQiC8pP6UyI7E4I76oNCe1+BCjBAezkgjv3yigHG9KYmVV
	alE+TEqag0VJnFd1ibqfkEB6YklqdmpqQWoRTFaGg0NJgjduDVCjYFFqempFWmZOCUKaiYMT
	ZDiXlEhxal5KalFiaUlGPCgy4ouBsQGS4gHaGwzSzltckJgLFIVoPcWoKCXO2wqSEABJZJTm
	wY2FJYxXjOJAXwrz1oFU8QCTDVz3K6DBTECDl2/pABlckoiQkmpgZOI7vTRi3vwDb02MExn7
	NfmiK5hL1AWfJiqppDom73JOdmO6Ivn044vDzpZ2dQ6VrS+rDzissVE7plNQbJ4fnC5czHJe
	eZGYqMXRSRanM0siepmY+s8pnlp4K8R6TZFOgbZPzZ6PstP6UxdMTk5pueHxLZ/Z 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261329>

The policy objects don't care about "--rewrite". So move it to
expire_reflog()'s flags parameter.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
Reviewed-by: Stefan Beller <sbeller@google.com>
---
 builtin/reflog.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/builtin/reflog.c b/builtin/reflog.c
index 15d3cd5..f86e7de 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -23,13 +23,13 @@ static unsigned long default_reflog_expire_unreachable;
 enum expire_reflog_flags {
 	EXPIRE_REFLOGS_DRY_RUN = 1 << 0,
 	EXPIRE_REFLOGS_UPDATE_REF = 1 << 1,
-	EXPIRE_REFLOGS_VERBOSE = 1 << 2
+	EXPIRE_REFLOGS_VERBOSE = 1 << 2,
+	EXPIRE_REFLOGS_REWRITE = 1 << 3
 };
 
 struct cmd_reflog_expire_cb {
 	struct rev_info revs;
 	int stalefix;
-	int rewrite;
 	unsigned long expire_total;
 	unsigned long expire_unreachable;
 	int recno;
@@ -337,7 +337,7 @@ static int expire_reflog_ent(unsigned char *osha1, unsigned char *nsha1,
 	struct expire_reflog_cb *cb = cb_data;
 	struct expire_reflog_policy_cb *policy_cb = cb->policy_cb;
 
-	if (policy_cb->cmd->rewrite)
+	if (cb->flags & EXPIRE_REFLOGS_REWRITE)
 		osha1 = policy_cb->last_kept_sha1;
 
 	if (should_expire_reflog_ent(osha1, nsha1, email, timestamp, tz,
@@ -687,7 +687,7 @@ static int cmd_reflog_expire(int argc, const char **argv, const char *prefix)
 		else if (!strcmp(arg, "--stale-fix"))
 			cb.stalefix = 1;
 		else if (!strcmp(arg, "--rewrite"))
-			cb.rewrite = 1;
+			flags |= EXPIRE_REFLOGS_REWRITE;
 		else if (!strcmp(arg, "--updateref"))
 			flags |= EXPIRE_REFLOGS_UPDATE_REF;
 		else if (!strcmp(arg, "--all"))
@@ -769,7 +769,7 @@ static int cmd_reflog_delete(int argc, const char **argv, const char *prefix)
 		if (!strcmp(arg, "--dry-run") || !strcmp(arg, "-n"))
 			flags |= EXPIRE_REFLOGS_DRY_RUN;
 		else if (!strcmp(arg, "--rewrite"))
-			cb.rewrite = 1;
+			flags |= EXPIRE_REFLOGS_REWRITE;
 		else if (!strcmp(arg, "--updateref"))
 			flags |= EXPIRE_REFLOGS_UPDATE_REF;
 		else if (!strcmp(arg, "--verbose"))
-- 
2.1.3
