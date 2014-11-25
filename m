From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 2/7] prune_remote(): initialize both delete_refs lists in a single loop
Date: Tue, 25 Nov 2014 09:02:30 +0100
Message-ID: <1416902555-10748-3-git-send-email-mhagger@alum.mit.edu>
References: <1416902555-10748-1-git-send-email-mhagger@alum.mit.edu>
Cc: Stefan Beller <sbeller@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ronnie Sahlberg <sahlberg@google.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 25 09:02:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XtB5M-0001l0-Kt
	for gcvg-git-2@plane.gmane.org; Tue, 25 Nov 2014 09:02:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752076AbaKYICx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Nov 2014 03:02:53 -0500
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:62867 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752054AbaKYICv (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 25 Nov 2014 03:02:51 -0500
X-AuditID: 1207440e-f79d26d000001b6e-d6-547437a9cdef
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id 6A.BA.07022.9A734745; Tue, 25 Nov 2014 03:02:49 -0500 (EST)
Received: from michael.fritz.box (p5DDB361F.dip0.t-ipconnect.de [93.219.54.31])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id sAP82i0l027888
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Tue, 25 Nov 2014 03:02:48 -0500
X-Mailer: git-send-email 2.1.3
In-Reply-To: <1416902555-10748-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrAIsWRmVeSWpSXmKPExsUixO6iqLvSvCTEYOsfZYuuK91MFg29V5gt
	3t5cwmhxe8V8Zot/E2osNm9uZ3Fg8/j7/gOTx85Zd9k9Fmwq9bh4Sdnj8ya5ANYobpukxJKy
	4Mz0PH27BO6MR19nshX08lU8m/+brYHxCHcXIyeHhICJRPuLZSwQtpjEhXvr2boYuTiEBC4z
	Spz/N4sZwjnOJHH00wcmkCo2AV2JRT3NYLaIgJrExLZDLCBFzAKHGSVe71zGDpIQFoiSaHz2
	Fmwsi4CqxMnTu9hAbF4BF4lXXY1AcQ6gdXISW9d5g4Q5BVwlZu49xAhiCwGVrN3Xyj6BkXcB
	I8MqRrnEnNJc3dzEzJzi1GTd4uTEvLzUIl1jvdzMEr3UlNJNjJDQ4tvB2L5e5hCjAAejEg9v
	w7HiECHWxLLiytxDjJIcTEqivCKGJSFCfEn5KZUZicUZ8UWlOanFhxglOJiVRHij5gGV86Yk
	VlalFuXDpKQ5WJTEedWWqPsJCaQnlqRmp6YWpBbBZGU4OJQkeCebAQ0VLEpNT61Iy8wpQUgz
	cXCCDOeSEilOzUtJLUosLcmIB8VGfDEwOkBSPEB7i0DaeYsLEnOBohCtpxgVpcR5J4IkBEAS
	GaV5cGNhCeMVozjQl8K8E0CqeIDJBq77FdBgJqDBcTMLQQaXJCKkpBoYxZrf2crV7BEP8bz/
	6OiK9OOfW78ekpqat2Pj6ur5YpcEOYIexvT9MbaSPa45L/Zwdr1JTnj4Ohm/2hzBDPUn3qu4
	lFc7ZCzg8zkf8M9DUUTzvYbv3gpOLqZ5KU1xs8OdVt2Mvai709pi89Xj7klSTtVh 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260200>

Also free them together at the end of the function.

In a moment, the array version will become redundant. Managing them
together makes later steps more obvious.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
---
 builtin/remote.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/builtin/remote.c b/builtin/remote.c
index d2b684c..d5a5a16 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -1337,8 +1337,13 @@ static int prune_remote(const char *remote, int dry_run)
 		  : _("(no URL)"));
 
 	delete_refs = xmalloc(states.stale.nr * sizeof(*delete_refs));
-	for (i = 0; i < states.stale.nr; i++)
-		delete_refs[i] = states.stale.items[i].util;
+	for (i = 0; i < states.stale.nr; i++) {
+		const char *refname = states.stale.items[i].util;
+
+		delete_refs[i] = refname;
+		string_list_insert(&delete_refs_list, refname);
+	}
+
 	if (!dry_run) {
 		struct strbuf err = STRBUF_INIT;
 		if (repack_without_refs(delete_refs, states.stale.nr,
@@ -1346,13 +1351,10 @@ static int prune_remote(const char *remote, int dry_run)
 			result |= error("%s", err.buf);
 		strbuf_release(&err);
 	}
-	free(delete_refs);
 
 	for (i = 0; i < states.stale.nr; i++) {
 		const char *refname = states.stale.items[i].util;
 
-		string_list_insert(&delete_refs_list, refname);
-
 		if (!dry_run)
 			result |= delete_ref(refname, NULL, 0);
 
@@ -1365,8 +1367,9 @@ static int prune_remote(const char *remote, int dry_run)
 	}
 
 	warn_dangling_symrefs(stdout, dangling_msg, &delete_refs_list);
-	string_list_clear(&delete_refs_list, 0);
 
+	free(delete_refs);
+	string_list_clear(&delete_refs_list, 0);
 	free_remote_ref_states(&states);
 	return result;
 }
-- 
2.1.3
