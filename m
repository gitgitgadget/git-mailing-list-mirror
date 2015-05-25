From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v3 16/56] add_branch_for_removal(): don't set "util" field of string_list entries
Date: Mon, 25 May 2015 18:38:42 +0000
Message-ID: <1432579162-411464-17-git-send-email-sandals@crustytoothpaste.net>
References: <1432579162-411464-1-git-send-email-sandals@crustytoothpaste.net>
Cc: Jeff King <peff@peff.net>, Michael Haggerty <mhagger@alum.mit.edu>,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 25 20:42:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YwxKx-0002Ab-D4
	for gcvg-git-2@plane.gmane.org; Mon, 25 May 2015 20:42:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751761AbbEYSmg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 May 2015 14:42:36 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:50599 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751338AbbEYSkM (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 May 2015 14:40:12 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [172.16.2.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 6ED282809B;
	Mon, 25 May 2015 18:40:11 +0000 (UTC)
X-Mailer: git-send-email 2.4.0
In-Reply-To: <1432579162-411464-1-git-send-email-sandals@crustytoothpaste.net>
X-Spam-Score: -2.5 ALL_TRUSTED,BAYES_00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269904>

From: Michael Haggerty <mhagger@alum.mit.edu>

They were never used.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/remote.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/builtin/remote.c b/builtin/remote.c
index 1986e98..ab39fea 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -513,7 +513,6 @@ static int add_branch_for_removal(const char *refname,
 {
 	struct branches_for_remote *branches = cb_data;
 	struct refspec refspec;
-	struct string_list_item *item;
 	struct known_remote *kr;
 
 	memset(&refspec, 0, sizeof(refspec));
@@ -543,9 +542,7 @@ static int add_branch_for_removal(const char *refname,
 	if (flags & REF_ISSYMREF)
 		return unlink(git_path("%s", refname));
 
-	item = string_list_append(branches->branches, refname);
-	item->util = xmalloc(20);
-	hashcpy(item->util, oid->hash);
+	string_list_append(branches->branches, refname);
 
 	return 0;
 }
@@ -828,7 +825,7 @@ static int rm(int argc, const char **argv)
 
 	if (!result)
 		result = remove_branches(&branches);
-	string_list_clear(&branches, 1);
+	string_list_clear(&branches, 0);
 
 	if (skipped.nr) {
 		fprintf_ln(stderr,
-- 
2.4.0
