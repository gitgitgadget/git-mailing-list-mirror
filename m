From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 10/11] resove_gitlink_packed_ref(): inline function
Date: Wed, 15 Oct 2014 17:06:22 +0200
Message-ID: <1413385583-4872-11-git-send-email-mhagger@alum.mit.edu>
References: <1413385583-4872-1-git-send-email-mhagger@alum.mit.edu>
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Ronnie Sahlberg <sahlberg@google.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 15 17:07:09 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XeQAO-0002a7-Tc
	for gcvg-git-2@plane.gmane.org; Wed, 15 Oct 2014 17:07:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751854AbaJOPHE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Oct 2014 11:07:04 -0400
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:65305 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751824AbaJOPHA (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 15 Oct 2014 11:07:00 -0400
X-AuditID: 1207440d-f793e6d000000cb1-08-543e8d8504d6
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id 7D.73.03249.58D8E345; Wed, 15 Oct 2014 11:06:45 -0400 (EDT)
Received: from michael.fritz.box (p4FC96250.dip0.t-ipconnect.de [79.201.98.80])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s9FF6SNc020034
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Wed, 15 Oct 2014 11:06:44 -0400
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1413385583-4872-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrGIsWRmVeSWpSXmKPExsUixO6iqNvaaxdicGeilEXXlW4mi4beK8wW
	t1fMZ7bonvKW0eLfhBqLM28aGR3YPP6+/8DksXPWXXaPBZtKPS5eUvZY/MDL4/MmuQC2KG6b
	pMSSsuDM9Dx9uwTujKWd55kKPvFUrJrazdbAOJmri5GTQ0LAROLA0yfMELaYxIV769m6GLk4
	hAQuM0pce3+MGcI5ziSxe8UMNpAqNgFdiUU9zUwgCRGBBkaJQ68WgrUwCyxilGhfdQVslrCA
	m8STjZ+YQGwWAVWJXQueg8V5BVwkPsz8ygixT05i7+TVLCA2J1D818ttYHEhAWeJBUsns0xg
	5F3AyLCKUS4xpzRXNzcxM6c4NVm3ODkxLy+1SNdILzezRC81pXQTIyTMeHcw/l8nc4hRgINR
	iYd3w17bECHWxLLiytxDjJIcTEqivAt67EKE+JLyUyozEosz4otKc1KLDzFKcDArifDOTwDK
	8aYkVlalFuXDpKQ5WJTEedWWqPsJCaQnlqRmp6YWpBbBZGU4OJQkePeBDBUsSk1PrUjLzClB
	SDNxcIIM55ISKU7NS0ktSiwtyYgHxUd8MTBCQFI8QHvB2nmLCxJzgaIQracYFaXEebNAEgIg
	iYzSPLixsOTxilEc6Eth3lMgVTzAxAPX/QpoMBPQ4ImhtiCDSxIRUlINjJlO6kbf3l+ZmyJl
	krTS+gP3HmmZraXZvxqtivYEdBu2rxbZ/kYg8/il2fw62y5HaLdc4/y7ecp6xgbzE3OeGitf
	WjuVaemvtxn5vpl+x6bzXvqS05SUW9S//9L8zOQ7LC/X3LCIOFR+L0o2Rt1/7rXz 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c | 31 +++++++++++--------------------
 1 file changed, 11 insertions(+), 20 deletions(-)

diff --git a/refs.c b/refs.c
index a7c8abd..8edcc3b 100644
--- a/refs.c
+++ b/refs.c
@@ -1280,25 +1280,6 @@ static struct ref_dir *get_loose_refs(struct ref_cache *refs)
 /* We allow "recursive" symbolic refs. Only within reason, though */
 #define MAXDEPTH 5
 
-/*
- * Called by resolve_gitlink_ref_recursive() after it failed to read
- * from the loose refs in ref_cache refs. Find <refname> in the
- * packed-refs file for the submodule.
- */
-static int resolve_gitlink_packed_ref(struct ref_cache *refs,
-				      const char *refname, unsigned char *sha1)
-{
-	struct ref_entry *ref;
-	struct ref_dir *dir = get_packed_refs(refs);
-
-	ref = find_ref(dir, refname);
-	if (ref == NULL)
-		return -1;
-
-	hashcpy(sha1, ref->u.value.sha1);
-	return 0;
-}
-
 int resolve_gitlink_ref(const char *path, const char *refname, unsigned char *sha1)
 {
 	struct strbuf result = STRBUF_INIT;
@@ -1331,7 +1312,17 @@ int resolve_gitlink_ref(const char *path, const char *refname, unsigned char *sh
 	if (parseval == 1) {
 		ret = 0;
 	} else if (parseval == -2) {
-		ret = resolve_gitlink_packed_ref(refs, result.buf, sha1) ? -1 : 0;
+		/* Loose ref doesn't exist; check for a packed ref */
+		struct ref_entry *entry;
+		struct ref_dir *dir = get_packed_refs(refs);
+
+		entry = find_ref(dir, result.buf);
+		if (entry) {
+			hashcpy(sha1, entry->u.value.sha1);
+			ret = 0;
+		} else {
+			ret = -1;
+		}
 	} else {
 		ret = -1;
 	}
-- 
2.1.1
