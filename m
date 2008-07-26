From: Lars Hjemli <hjemli@gmail.com>
Subject: [PATCH 1/3] builtin-branch: remove duplicated code
Date: Sat, 26 Jul 2008 12:27:23 +0200
Message-ID: <1217068045-3575-2-git-send-email-hjemli@gmail.com>
References: <1217068045-3575-1-git-send-email-hjemli@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 26 13:31:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMhze-0004s2-Tp
	for gcvg-git-2@gmane.org; Sat, 26 Jul 2008 13:31:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750934AbYGZLaT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Jul 2008 07:30:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751408AbYGZLaT
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Jul 2008 07:30:19 -0400
Received: from mail49.e.nsc.no ([193.213.115.49]:51027 "EHLO mail49.e.nsc.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750870AbYGZLaS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Jul 2008 07:30:18 -0400
Received: from localhost.localdomain (ti0025a380-0241.bb.online.no [88.89.68.241])
	by mail49.nsc.no (8.13.8/8.13.5) with ESMTP id m6QARRQi019909
	for <git@vger.kernel.org>; Sat, 26 Jul 2008 12:27:27 +0200 (MEST)
X-Mailer: git-send-email 1.6.0.rc0.79.gb0320
In-Reply-To: <1217068045-3575-1-git-send-email-hjemli@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90209>

The previous optimization to --[no-]merged ended up with some duplicated
code which this patch removes.

Signed-off-by: Lars Hjemli <hjemli@gmail.com>
---
 builtin-branch.c |    9 ++-------
 1 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/builtin-branch.c b/builtin-branch.c
index 5db8ad8..675a9b1 100644
--- a/builtin-branch.c
+++ b/builtin-branch.c
@@ -214,7 +214,6 @@ static int append_ref(const char *refname, const unsigned char *sha1, int flags,
 	struct commit *commit;
 	int kind;
 	int len;
-	static struct commit_list branch;
 
 	/* Detect kind */
 	if (!prefixcmp(refname, "refs/heads/")) {
@@ -238,13 +237,9 @@ static int append_ref(const char *refname, const unsigned char *sha1, int flags,
 	if ((kind & ref_list->kinds) == 0)
 		return 0;
 
-	if (merge_filter != NO_FILTER) {
-		branch.item = lookup_commit_reference_gently(sha1, 1);
-		if (!branch.item)
-			die("Unable to lookup tip of branch %s", refname);
+	if (merge_filter != NO_FILTER)
 		add_pending_object(&ref_list->revs,
-				   (struct object *)branch.item, refname);
-	}
+				   (struct object *)commit, refname);
 
 	/* Resize buffer */
 	if (ref_list->index >= ref_list->alloc) {
-- 
1.6.0.rc0.79.gb0320
