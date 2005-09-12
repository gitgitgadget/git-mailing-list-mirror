From: Chuck Lever <cel@netapp.com>
Subject: [PATCH 17/22] teach checkout-index.c to use cache_find_name()
Date: Mon, 12 Sep 2005 10:56:20 -0400
Message-ID: <20050912145620.28120.86534.stgit@dexter.citi.umich.edu>
References: <20050912145543.28120.7086.stgit@dexter.citi.umich.edu>
X-From: git-owner@vger.kernel.org Mon Sep 12 16:59:47 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EEpjg-0000SG-BY
	for gcvg-git@gmane.org; Mon, 12 Sep 2005 16:56:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751063AbVILO40 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Sep 2005 10:56:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751301AbVILO4Z
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Sep 2005 10:56:25 -0400
Received: from citi.umich.edu ([141.211.133.111]:45922 "EHLO citi.umich.edu")
	by vger.kernel.org with ESMTP id S1751061AbVILO4U (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 Sep 2005 10:56:20 -0400
Received: from dexter.citi.umich.edu (dexter.citi.umich.edu [141.211.133.33])
	by citi.umich.edu (Postfix) with ESMTP id 998141BAF3
	for <git@vger.kernel.org>; Mon, 12 Sep 2005 10:56:20 -0400 (EDT)
To: git@vger.kernel.org
In-Reply-To: <20050912145543.28120.7086.stgit@dexter.citi.umich.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8385>

Signed-off-by: Chuck Lever <cel@netapp.com>
---

 checkout-index.c |   11 +++++------
 1 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/checkout-index.c b/checkout-index.c
--- a/checkout-index.c
+++ b/checkout-index.c
@@ -45,20 +45,19 @@ static struct checkout state = {
 
 static int checkout_file(const char *name)
 {
-	int pos = cache_name_pos(name, strlen(name));
-	if (pos < 0) {
+	struct cache_entry *ce;
+
+	if (!cache_find_entry(name, strlen(name), &ce)) {
 		if (!state.quiet) {
-			pos = -pos - 1;
 			fprintf(stderr,
 				"git-checkout-index: %s is %s.\n",
 				name,
-				(pos < active_nr &&
-				 !strcmp(active_cache[pos]->name, name)) ?
+				!strcmp(ce->name, name) ?
 				"unmerged" : "not in the cache");
 		}
 		return -1;
 	}
-	return checkout_entry(active_cache[pos], &state);
+	return checkout_entry(ce, &state);
 }
 
 static int checkout_one(struct cache_cursor *cc, struct cache_entry *ce)
