From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v2 07/16] revision: remove unused _oid helper.
Date: Wed, 22 Apr 2015 23:24:12 +0000
Message-ID: <1429745061-295908-8-git-send-email-sandals@crustytoothpaste.net>
References: <1429745061-295908-1-git-send-email-sandals@crustytoothpaste.net>
Cc: Jeff King <peff@peff.net>, Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>,
	"Kyle J. McKay" <mackyle@gmail.com>,
	Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 23 01:24:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yl40l-0003ns-De
	for gcvg-git-2@plane.gmane.org; Thu, 23 Apr 2015 01:24:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758596AbbDVXYj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Apr 2015 19:24:39 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:44769 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758575AbbDVXYb (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 22 Apr 2015 19:24:31 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [172.16.2.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 7A741282A7;
	Wed, 22 Apr 2015 23:24:30 +0000 (UTC)
X-Mailer: git-send-email 2.3.5
In-Reply-To: <1429745061-295908-1-git-send-email-sandals@crustytoothpaste.net>
X-Spam-Score: -2.5 ALL_TRUSTED,BAYES_00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267660>

Now that all the callers of handle_refs are gone, rename handle_refs_oid
to handle_refs and update the callers accordingly.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 revision.c | 22 +++++++---------------
 1 file changed, 7 insertions(+), 15 deletions(-)

diff --git a/revision.c b/revision.c
index 825fbba..6fb499f 100644
--- a/revision.c
+++ b/revision.c
@@ -1264,14 +1264,6 @@ void add_ref_exclusion(struct string_list **ref_excludes_p, const char *exclude)
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
@@ -2116,21 +2108,21 @@ static int handle_revision_pseudo_opt(const char *submodule,
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
2.3.5
