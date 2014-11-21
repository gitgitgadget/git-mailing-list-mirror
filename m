From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 6/6] prune_remote(): iterate using for_each_string_list_item()
Date: Fri, 21 Nov 2014 15:09:10 +0100
Message-ID: <1416578950-23210-7-git-send-email-mhagger@alum.mit.edu>
References: <1416423000-4323-1-git-send-email-sbeller@google.com>
 <1416578950-23210-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Ronnie Sahlberg <sahlberg@google.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Stefan Beller <sbeller@google.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 21 15:09:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xrou5-0000PW-I6
	for gcvg-git-2@plane.gmane.org; Fri, 21 Nov 2014 15:09:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758312AbaKUOJ3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Nov 2014 09:09:29 -0500
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:58165 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758266AbaKUOJ0 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 21 Nov 2014 09:09:26 -0500
X-AuditID: 12074411-f79fa6d000006b8a-07-546f47959a3a
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id 22.8A.27530.5974F645; Fri, 21 Nov 2014 09:09:25 -0500 (EST)
Received: from michael.fritz.box (p5DDB272E.dip0.t-ipconnect.de [93.219.39.46])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id sALE9EqU000733
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Fri, 21 Nov 2014 09:09:24 -0500
X-Mailer: git-send-email 2.1.3
In-Reply-To: <1416578950-23210-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrPIsWRmVeSWpSXmKPExsUixO6iqDvVPT/E4MclbouuK91MFg29V5gt
	3t5cwmhxe8V8Zot/E2osNm9uZ3Fg8/j7/gOTx85Zd9k9Fmwq9bh4Sdnj8ya5ANYobpukxJKy
	4Mz0PH27BO6M/ltb2Qpe81Q8nf2dpYFxO1cXIyeHhICJxIb7f1ghbDGJC/fWs3UxcnEICVxm
	lLj3qZsZwjnOJLHm3zx2kCo2AV2JRT3NTCC2iICXxKl1M8CKmAXmM0rMXjeTESQhLOAnsW7F
	ISCbg4NFQFXicHcISJhXwEVi376rrCBhCQE5ia3rvEHCnAKuEk9X9IGNFxKokbjSt51tAiPv
	AkaGVYxyiTmlubq5iZk5xanJusXJiXl5qUW6pnq5mSV6qSmlmxghgSW4g3HGSblDjAIcjEo8
	vCsW54UIsSaWFVfmHmKU5GBSEuU1dMsPEeJLyk+pzEgszogvKs1JLT7EKMHBrCTCWy4MlONN
	SaysSi3Kh0lJc7AoifPyLVH3ExJITyxJzU5NLUgtgsnKcHAoSfD6gwwVLEpNT61Iy8wpQUgz
	cXCCDOeSEilOzUtJLUosLcmIB0VGfDEwNkBSPEB7bUHaeYsLEnOBohCtpxgVpcR5fUESAiCJ
	jNI8uLGwdPGKURzoS2Heb65AVTzAVAPX/QpoMBPQ4L9Lc0EGlyQipKQaGHUFn8QtUYgtq71y
	zXpdUOzCsoPbBQxW7ZGeN43hw8s3TdkKHf0hMz7G9enevGq/iOPpprUGob9dXokembw6ydf8
	cWctl+pf35XFTO3RU34u+5CS4d/QrBLHsSKZ8UNGvpa953T7ECWV8rYt8RkW3Etu 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Iterate over refs_to_prune using for_each_string_list_item() rather
than writing out the loop in longhand.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 builtin/remote.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/builtin/remote.c b/builtin/remote.c
index efbf5fb..7fec170 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -1309,9 +1309,10 @@ static int set_head(int argc, const char **argv)
 
 static int prune_remote(const char *remote, int dry_run)
 {
-	int result = 0, i;
+	int result = 0;
 	struct ref_states states;
 	struct string_list refs_to_prune = STRING_LIST_INIT_NODUP;
+	struct string_list_item *item;
 	const char *dangling_msg = dry_run
 		? _(" %s will become dangling!")
 		: _(" %s has become dangling!");
@@ -1330,11 +1331,8 @@ static int prune_remote(const char *remote, int dry_run)
 		  ? states.remote->url[0]
 		  : _("(no URL)"));
 
-	for (i = 0; i < states.stale.nr; i++) {
-		const char *refname = states.stale.items[i].util;
-
-		string_list_append(&refs_to_prune, refname);
-	}
+	for_each_string_list_item(item, &states.stale)
+		string_list_append(&refs_to_prune, item->util);
 	sort_string_list(&refs_to_prune);
 
 	if (!dry_run) {
@@ -1344,8 +1342,8 @@ static int prune_remote(const char *remote, int dry_run)
 		strbuf_release(&err);
 	}
 
-	for (i = 0; i < states.stale.nr; i++) {
-		const char *refname = states.stale.items[i].util;
+	for_each_string_list_item(item, &states.stale) {
+		const char *refname = item->util;
 
 		if (!dry_run)
 			result |= delete_ref(refname, NULL, 0);
-- 
2.1.3
