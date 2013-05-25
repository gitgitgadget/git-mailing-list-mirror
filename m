From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 04/25] builtin_diff_tree(): make it obvious that function wants two entries
Date: Sat, 25 May 2013 11:08:03 +0200
Message-ID: <1369472904-12875-5-git-send-email-mhagger@alum.mit.edu>
References: <1369472904-12875-1-git-send-email-mhagger@alum.mit.edu>
Cc: Johan Herland <johan@herland.net>, Thomas Rast <trast@inf.ethz.ch>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat May 25 11:09:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UgATS-00052T-Qj
	for gcvg-git-2@plane.gmane.org; Sat, 25 May 2013 11:09:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753275Ab3EYJJH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 May 2013 05:09:07 -0400
Received: from ALUM-MAILSEC-SCANNER-4.MIT.EDU ([18.7.68.15]:47590 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752567Ab3EYJI7 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 25 May 2013 05:08:59 -0400
X-AuditID: 1207440f-b7f0e6d000000957-6c-51a07faaffe4
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id C7.4B.02391.AAF70A15; Sat, 25 May 2013 05:08:58 -0400 (EDT)
Received: from michael.fritz.box (p4FDD49F3.dip0.t-ipconnect.de [79.221.73.243])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r4P98gue000489
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sat, 25 May 2013 05:08:57 -0400
X-Mailer: git-send-email 1.8.2.3
In-Reply-To: <1369472904-12875-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrAIsWRmVeSWpSXmKPExsUixO6iqLuqfkGgwe5+A4uuK91MFg29V5gt
	5t3dxWRxe8V8ZosfLT3MFncvr2J3YPP4+/4Dk8ell9/ZPG6/ns/s8ax3D6PHxUvKHp83yQWw
	RXHbJCWWlAVnpufp2yVwZzRPCS/4L1jxq+E6YwPjLL4uRg4OCQETicfd7F2MnECmmMSFe+vZ
	uhi5OIQELjNKTH32ixkkISRwgUmi93QEiM0moCuxqKeZCcQWEXCUOPHgOitIA7NAL6PEw0ff
	wRLCAnESv3a3sYDYLAKqEjfefAWzeQVcJG6+ecMCsU1B4vKsNcwgR3AKuEq8PcEJsctF4vmn
	c6wTGHkXMDKsYpRLzCnN1c1NzMwpTk3WLU5OzMtLLdI10cvNLNFLTSndxAgJMf4djF3rZQ4x
	CnAwKvHwCpbPDxRiTSwrrsw9xCjJwaQkystfuyBQiC8pP6UyI7E4I76oNCe1+BCjBAezkggv
	QwpQjjclsbIqtSgfJiXNwaIkzqu+RN1PSCA9sSQ1OzW1ILUIJivDwaEkwbu3DqhRsCg1PbUi
	LTOnBCHNxMEJMpxLSqQ4NS8ltSixtCQjHhQV8cXAuABJ8QDtPQvSzltckJgLFIVoPcWoy3Hn
	2+R3jEIsefl5qVLivDdBigRAijJK8+BWwBLKK0ZxoI+Fee+CVPEAkxHcpFdAS5iAltzMnQ+y
	pCQRISXVwGh+t6G/5UjDXMPc5lm712nF8X3+zaJusezQzFCzZPNJHz41nn2z8+TXyzccNTq+
	/dv3SvjK2fDHctdYb/CG1T5iX3Pvrt/mXxwr+//7Bt7Uc4lZc+Mae6DGyrYdP3Jz 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225494>

Instead of accepting an array and using exactly two elements from the
array, take two single (struct object_array_entry *) arguments.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 builtin/diff.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/builtin/diff.c b/builtin/diff.c
index 8c2af6c..abdd613 100644
--- a/builtin/diff.c
+++ b/builtin/diff.c
@@ -153,7 +153,8 @@ static int builtin_diff_index(struct rev_info *revs,
 
 static int builtin_diff_tree(struct rev_info *revs,
 			     int argc, const char **argv,
-			     struct object_array_entry *ent)
+			     struct object_array_entry *ent0,
+			     struct object_array_entry *ent1)
 {
 	const unsigned char *(sha1[2]);
 	int swap = 0;
@@ -161,13 +162,14 @@ static int builtin_diff_tree(struct rev_info *revs,
 	if (argc > 1)
 		usage(builtin_diff_usage);
 
-	/* We saw two trees, ent[0] and ent[1].
-	 * if ent[1] is uninteresting, they are swapped
+	/*
+	 * We saw two trees, ent0 and ent1.  If ent1 is uninteresting,
+	 * swap them.
 	 */
-	if (ent[1].item->flags & UNINTERESTING)
+	if (ent1->item->flags & UNINTERESTING)
 		swap = 1;
-	sha1[swap] = ent[0].item->sha1;
-	sha1[1-swap] = ent[1].item->sha1;
+	sha1[swap] = ent0->item->sha1;
+	sha1[1-swap] = ent1->item->sha1;
 	diff_tree_sha1(sha1[0], sha1[1], "", &revs->diffopt);
 	log_tree_diff_flush(revs);
 	return 0;
@@ -403,7 +405,7 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
 	else if (ents == 1)
 		result = builtin_diff_index(&rev, argc, argv);
 	else if (ents == 2)
-		result = builtin_diff_tree(&rev, argc, argv, ent);
+		result = builtin_diff_tree(&rev, argc, argv, &ent[0], &ent[1]);
 	else if (ent[0].item->flags & UNINTERESTING) {
 		/*
 		 * diff A...B where there is at least one merge base
@@ -412,8 +414,7 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
 		 * between the base and B.  Note that we pick one
 		 * merge base at random if there are more than one.
 		 */
-		ent[1] = ent[ents-1];
-		result = builtin_diff_tree(&rev, argc, argv, ent);
+		result = builtin_diff_tree(&rev, argc, argv, &ent[0], &ent[ents-1]);
 	} else
 		result = builtin_diff_combined(&rev, argc, argv,
 					       ent, ents);
-- 
1.8.2.3
