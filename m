From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 6/7] prune_remote(): iterate using for_each_string_list_item()
Date: Tue, 25 Nov 2014 09:02:34 +0100
Message-ID: <1416902555-10748-7-git-send-email-mhagger@alum.mit.edu>
References: <1416902555-10748-1-git-send-email-mhagger@alum.mit.edu>
Cc: Stefan Beller <sbeller@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ronnie Sahlberg <sahlberg@google.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 25 09:10:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XtBCE-0007G2-H5
	for gcvg-git-2@plane.gmane.org; Tue, 25 Nov 2014 09:10:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752451AbaKYIJ6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Nov 2014 03:09:58 -0500
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:58831 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751913AbaKYIJ6 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 25 Nov 2014 03:09:58 -0500
X-Greylist: delayed 421 seconds by postgrey-1.27 at vger.kernel.org; Tue, 25 Nov 2014 03:09:58 EST
X-AuditID: 12074412-f79e46d0000036b4-d0-547437ae11b2
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id F4.6E.14004.EA734745; Tue, 25 Nov 2014 03:02:54 -0500 (EST)
Received: from michael.fritz.box (p5DDB361F.dip0.t-ipconnect.de [93.219.54.31])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id sAP82i0p027888
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Tue, 25 Nov 2014 03:02:53 -0500
X-Mailer: git-send-email 2.1.3
In-Reply-To: <1416902555-10748-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrPIsWRmVeSWpSXmKPExsUixO6iqLvOvCTEYPoVK4uuK91MFg29V5gt
	3t5cwmhxe8V8Zot/E2osNm9uZ3Fg8/j7/gOTx85Zd9k9Fmwq9bh4Sdnj8ya5ANYobpukxJKy
	4Mz0PH27BO6MW9O/MxfM4634fauNsYHxKVcXIyeHhICJxIQX91ghbDGJC/fWs3UxcnEICVxm
	lPj04zkzSEJI4DiTxLHPYiA2m4CuxKKeZiYQW0RATWJi2yEWkAZmgcOMEq93LmMHSQgLBEqs
	670L1swioCpxv+kUC4jNK+Ai8eX5J6AaDqBtchJb13mDhDkFXCVm7j3ECLHLRWLtvlb2CYy8
	CxgZVjHKJeaU5urmJmbmFKcm6xYnJ+blpRbpmunlZpbopaaUbmKEBJbQDsb1J+UOMQpwMCrx
	8DYcKw4RYk0sK67MPcQoycGkJMorYlgSIsSXlJ9SmZFYnBFfVJqTWnyIUYKDWUmEN2oeUDlv
	SmJlVWpRPkxKmoNFSZz352J1PyGB9MSS1OzU1ILUIpisDAeHkgSvvBnQUMGi1PTUirTMnBKE
	NBMHJ8hwLimR4tS8lNSixNKSjHhQZMQXA2MDJMUDtHe3KVA7b3FBYi5QFKL1FKOilDivJMhc
	AZBERmke3FhYunjFKA70pTCvL0gVDzDVwHW/AhrMBDQ4bmYhyOCSRISUVANjHOPptZXd362q
	3lldVJxfdF3W3MaISXFmmvyDZ9fzJdeePtSm2XM5rb5BTFG+/NMf/y0CewxlvrpeC3VN22vs
	vzjBK3/5xD3e3/8eES2dnrhdsjRP9qW75rw5b3Iu291c4h54RqLugtEZ/5ZNebzp 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260206>

Iterate over refs_to_prune using for_each_string_list_item() rather
than writing out the loop in longhand.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
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
