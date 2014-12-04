From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 17/23] expire_reflog(): move rewrite to flags argument
Date: Fri,  5 Dec 2014 00:08:29 +0100
Message-ID: <1417734515-11812-18-git-send-email-mhagger@alum.mit.edu>
References: <1417734515-11812-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri Dec 05 00:09:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XwfWL-0002yQ-UO
	for gcvg-git-2@plane.gmane.org; Fri, 05 Dec 2014 00:09:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933349AbaLDXJI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Dec 2014 18:09:08 -0500
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:60076 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933344AbaLDXJG (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 Dec 2014 18:09:06 -0500
X-AuditID: 1207440e-f79d26d000001b6e-b1-5480e9919e2c
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id 9F.67.07022.199E0845; Thu,  4 Dec 2014 18:09:05 -0500 (EST)
Received: from michael.fritz.box (p5DDB0B3C.dip0.t-ipconnect.de [93.219.11.60])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id sB4N8deE027614
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Thu, 4 Dec 2014 18:09:04 -0500
X-Mailer: git-send-email 2.1.3
In-Reply-To: <1417734515-11812-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrAIsWRmVeSWpSXmKPExsUixO6iqDvxZUOIwb5fghZdV7qZLBp6rzBb
	vL25hNHi9or5zBa9fZ9YLTZvbmdxYPP4+/4Dk8fOWXfZPRZsKvW4eEnZ4/MmuQDWKG6bpMSS
	suDM9Dx9uwTujGcXd7IW/Oav2HWgl7mBsYW3i5GTQ0LAROLFpg2sELaYxIV769lAbCGBy4wS
	p77UdjFyAdnHmCTeT93HDpJgE9CVWNTTzARiiwioScxcNZsNpIhZ4ASjxK/J3YwgCWEBN4lf
	K+aC2SwCqhIzu7cyg9i8Aq4Stw98BmrgANomJ7F1nTdImBMoPHVmKyPEYheJZ5sWsk9g5F3A
	yLCKUS4xpzRXNzcxM6c4NVm3ODkxLy+1SNdYLzezRC81pXQTIyS0+HYwtq+XOcQowMGoxMNb
	sLs+RIg1say4MvcQoyQHk5Io79mnDSFCfEn5KZUZicUZ8UWlOanFhxglOJiVRHiNjwDleFMS
	K6tSi/JhUtIcLErivGpL1P2EBNITS1KzU1MLUotgsjIcHEoSvKUvgBoFi1LTUyvSMnNKENJM
	HJwgw7mkRIpT81JSixJLSzLiQZERXwyMDZAUD9DeMpB23uKCxFygKETrKUZFKXFea5CEAEgi
	ozQPbiwsYbxiFAf6UhhiOw8w2cB1vwIazAQ0+GxDLcjgkkSElFQDo5/5X8YF3rcc/Gt/Ma23
	ue32SJiR4UzT3i21X7jdzk2+0pFYZ61mMPn6yUkd+t1PXnMukZ6++f3UKYvnXTvHVCCws2jC
	wpvufCn+CyumnvnccW/WPDtTtm9Rq3eozDGaUdn0e+3ZLrMraj+Ni60Omaktqmhb 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260818>

The policy objects don't care about "--rewrite". So move it to
expire_reflog()'s flags parameter.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 builtin/reflog.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/builtin/reflog.c b/builtin/reflog.c
index cc7a220..6294406 100644
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
@@ -673,7 +673,7 @@ static int cmd_reflog_expire(int argc, const char **argv, const char *prefix)
 		else if (!strcmp(arg, "--stale-fix"))
 			cb.stalefix = 1;
 		else if (!strcmp(arg, "--rewrite"))
-			cb.rewrite = 1;
+			flags |= EXPIRE_REFLOGS_REWRITE;
 		else if (!strcmp(arg, "--updateref"))
 			flags |= EXPIRE_REFLOGS_UPDATE_REF;
 		else if (!strcmp(arg, "--all"))
@@ -755,7 +755,7 @@ static int cmd_reflog_delete(int argc, const char **argv, const char *prefix)
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
