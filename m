From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH 07/16] revision: remove unused _oid helper.
Date: Fri, 20 Mar 2015 19:28:27 +0000
Message-ID: <1426879716-47835-8-git-send-email-sandals@crustytoothpaste.net>
References: <1426879716-47835-1-git-send-email-sandals@crustytoothpaste.net>
Cc: Andreas Schwab <schwab@linux-m68k.org>,
	"Kyle J. McKay" <mackyle@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>, David Kastrup <dak@gnu.org>,
	James Denholm <nod.helm@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 20 20:29:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YZ2bs-0001va-RS
	for gcvg-git-2@plane.gmane.org; Fri, 20 Mar 2015 20:29:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751748AbbCTT33 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Mar 2015 15:29:29 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:50652 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751286AbbCTT2u (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 Mar 2015 15:28:50 -0400
Received: from vauxhall.crustytoothpaste.net (wsip-184-177-1-73.no.no.cox.net [184.177.1.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 4896128098;
	Fri, 20 Mar 2015 19:28:49 +0000 (UTC)
X-Mailer: git-send-email 2.2.1.209.g41e5f3a
In-Reply-To: <1426879716-47835-1-git-send-email-sandals@crustytoothpaste.net>
X-Spam-Score: 0.163 () BAYES_00,RDNS_DYNAMIC
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265949>

Now that all the callers of handle_refs are gone, rename handle_refs_oid
to handle_refs and update the callers accordingly.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 revision.c | 22 +++++++---------------
 1 file changed, 7 insertions(+), 15 deletions(-)

diff --git a/revision.c b/revision.c
index c2d8b1c..1fea8c5 100644
--- a/revision.c
+++ b/revision.c
@@ -1249,14 +1249,6 @@ void add_ref_exclusion(struct string_list **ref_excludes_p, const char *exclude)
 }
 
 static void handle_refs(const char *submodule, struct rev_info *revs, unsigned flags,
-		int (*for_each)(const char *, each_ref_fn, void *))
-{
-	struct all_refs_cb cb;
-	init_all_refs_cb(&cb, revs, flags);
-	for_each(submodule, handle_one_ref, &cb);
-}
-
-static void handle_refs_oid(const char *submodule, struct rev_info *revs, unsigned flags,
 		int (*for_each)(const char *, each_ref_fn_oid, void *))
 {
 	struct all_refs_cb cb;
@@ -2099,21 +2091,21 @@ static int handle_revision_pseudo_opt(const char *submodule,
 	 * register it in the list at the top of handle_revision_opt.
 	 */
 	if (!strcmp(arg, "--all")) {
-		handle_refs_oid(submodule, revs, *flags, for_each_ref_submodule);
-		handle_refs_oid(submodule, revs, *flags, head_ref_submodule);
+		handle_refs(submodule, revs, *flags, for_each_ref_submodule);
+		handle_refs(submodule, revs, *flags, head_ref_submodule);
 		clear_ref_exclusion(&revs->ref_excludes);
 	} else if (!strcmp(arg, "--branches")) {
-		handle_refs_oid(submodule, revs, *flags, for_each_branch_ref_submodule);
+		handle_refs(submodule, revs, *flags, for_each_branch_ref_submodule);
 		clear_ref_exclusion(&revs->ref_excludes);
 	} else if (!strcmp(arg, "--bisect")) {
-		handle_refs_oid(submodule, revs, *flags, for_each_bad_bisect_ref);
-		handle_refs_oid(submodule, revs, *flags ^ (UNINTERESTING | BOTTOM), for_each_good_bisect_ref);
+		handle_refs(submodule, revs, *flags, for_each_bad_bisect_ref);
+		handle_refs(submodule, revs, *flags ^ (UNINTERESTING | BOTTOM), for_each_good_bisect_ref);
 		revs->bisect = 1;
 	} else if (!strcmp(arg, "--tags")) {
-		handle_refs_oid(submodule, revs, *flags, for_each_tag_ref_submodule);
+		handle_refs(submodule, revs, *flags, for_each_tag_ref_submodule);
 		clear_ref_exclusion(&revs->ref_excludes);
 	} else if (!strcmp(arg, "--remotes")) {
-		handle_refs_oid(submodule, revs, *flags, for_each_remote_ref_submodule);
+		handle_refs(submodule, revs, *flags, for_each_remote_ref_submodule);
 		clear_ref_exclusion(&revs->ref_excludes);
 	} else if ((argcount = parse_long_opt("glob", argv, &optarg))) {
 		struct all_refs_cb cb;
-- 
2.2.1.209.g41e5f3a
