From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 04/17] builtin_diff_tree(): make it obvious that function wants two entries
Date: Sun, 19 May 2013 22:26:59 +0200
Message-ID: <1368995232-11042-5-git-send-email-mhagger@alum.mit.edu>
References: <1368995232-11042-1-git-send-email-mhagger@alum.mit.edu>
Cc: Junio C Hamano <gitster@pobox.com>,
	Johan Herland <johan@herland.net>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun May 19 22:28:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UeADq-0004mK-Nv
	for gcvg-git-2@plane.gmane.org; Sun, 19 May 2013 22:28:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754856Ab3ESU2s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 May 2013 16:28:48 -0400
Received: from ALUM-MAILSEC-SCANNER-2.MIT.EDU ([18.7.68.13]:61200 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754692Ab3ESU2D (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 19 May 2013 16:28:03 -0400
X-AuditID: 1207440d-b7fd06d000000905-8c-519935d16109
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id B3.1A.02309.1D539915; Sun, 19 May 2013 16:28:01 -0400 (EDT)
Received: from michael.fritz.box (p57A25040.dip0.t-ipconnect.de [87.162.80.64])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r4JKRX5N026019
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 19 May 2013 16:28:00 -0400
X-Mailer: git-send-email 1.8.2.3
In-Reply-To: <1368995232-11042-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrBIsWRmVeSWpSXmKPExsUixO6iqHvRdGagwa+nRhZdV7qZLBp6rzBb
	zLu7i8ni9or5zBY/WnqYHVg9/r7/wORx6eV3No9nvXsYPS5eUvb4vEkugDWK2yYpsaQsODM9
	T98ugTujbf9+5oI/ghUzP7xja2CczdfFyMkhIWAisX/lVHYIW0ziwr31bF2MXBxCApcZJY5+
	eMYC4Zxnklg05R4zSBWbgK7Eop5mJhBbREBW4vvhjYwgNrPABEaJpf2FILawQLTEzEWPWLsY
	OThYBFQl7p0OAgnzCrhI7J90iQlimYLE5VlrwEZyCrhKbGnfxQpiCwHV/Ou/zTqBkXcBI8Mq
	RrnEnNJc3dzEzJzi1GTd4uTEvLzUIl0jvdzMEr3UlNJNjJCQ4t3B+H+dzCFGAQ5GJR5ejXfT
	A4VYE8uKK3MPMUpyMCmJ8i5XnRkoxJeUn1KZkVicEV9UmpNafIhRgoNZSYR3jxBQjjclsbIq
	tSgfJiXNwaIkzqu2RN1PSCA9sSQ1OzW1ILUIJivDwaEkwetuAtQoWJSanlqRlplTgpBm4uAE
	Gc4lJVKcmpeSWpRYWpIRD4qM+GJgbICkeID2LgJp5y0uSMwFikK0nmLU5bjzbfI7RiGWvPy8
	VClx3n6QIgGQoozSPLgVsATyilEc6GNh3k6QKh5g8oGb9ApoCRPQEtZrU0GWlCQipKQaGBd4
	rVVTvyn8PoA/9339yRpn1zNPgw+uqf55sdU8SyF8uv66nMfAOFscd72XNW9at9JF1Vcuuxqe
	+1gzLVC4zx5baVXIFXk511K37NTz7XPVl+eu2N758rllROQqaXeLWp2L/DOP7fZ7 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224922>

Instead of accepting an array and using exactly two elements from the
array, take two single (struct object_array_entry *) arguments.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 builtin/diff.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/builtin/diff.c b/builtin/diff.c
index 8c2af6c..ba68c6c 100644
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
@@ -161,13 +162,13 @@ static int builtin_diff_tree(struct rev_info *revs,
 	if (argc > 1)
 		usage(builtin_diff_usage);
 
-	/* We saw two trees, ent[0] and ent[1].
-	 * if ent[1] is uninteresting, they are swapped
+	/* We saw two trees, ent0 and ent1.
+	 * if ent1 is uninteresting, they are swapped
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
@@ -403,7 +404,7 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
 	else if (ents == 1)
 		result = builtin_diff_index(&rev, argc, argv);
 	else if (ents == 2)
-		result = builtin_diff_tree(&rev, argc, argv, ent);
+		result = builtin_diff_tree(&rev, argc, argv, &ent[0], &ent[1]);
 	else if (ent[0].item->flags & UNINTERESTING) {
 		/*
 		 * diff A...B where there is at least one merge base
@@ -412,8 +413,7 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
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
