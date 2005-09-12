From: Chuck Lever <cel@netapp.com>
Subject: [PATCH 16/22] teach apply.c to use cache_find_name()
Date: Mon, 12 Sep 2005 10:56:18 -0400
Message-ID: <20050912145618.28120.90781.stgit@dexter.citi.umich.edu>
References: <20050912145543.28120.7086.stgit@dexter.citi.umich.edu>
X-From: git-owner@vger.kernel.org Mon Sep 12 17:00:11 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EEpji-0000SG-KY
	for gcvg-git@gmane.org; Mon, 12 Sep 2005 16:56:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751306AbVILO4X (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Sep 2005 10:56:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751301AbVILO4V
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Sep 2005 10:56:21 -0400
Received: from citi.umich.edu ([141.211.133.111]:53141 "EHLO citi.umich.edu")
	by vger.kernel.org with ESMTP id S1751304AbVILO4S (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 Sep 2005 10:56:18 -0400
Received: from dexter.citi.umich.edu (dexter.citi.umich.edu [141.211.133.33])
	by citi.umich.edu (Postfix) with ESMTP id 6FC911BAF3
	for <git@vger.kernel.org>; Mon, 12 Sep 2005 10:56:18 -0400 (EDT)
To: git@vger.kernel.org
In-Reply-To: <20050912145543.28120.7086.stgit@dexter.citi.umich.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8389>

Signed-off-by: Chuck Lever <cel@netapp.com>
---

 apply.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/apply.c b/apply.c
--- a/apply.c
+++ b/apply.c
@@ -1021,10 +1021,10 @@ static int check_patch(struct patch *pat
 		if (lstat(old_name, &st) < 0)
 			return error("%s: %s", old_name, strerror(errno));
 		if (check_index) {
-			int pos = cache_name_pos(old_name, strlen(old_name));
-			if (pos < 0)
+			struct cache_entry *ce;
+			if (!cache_find_entry(old_name, strlen(old_name), &ce))
 				return error("%s: does not exist in index", old_name);
-			changed = ce_match_stat(active_cache[pos], &st);
+			changed = ce_match_stat(ce, &st);
 			if (changed)
 				return error("%s: does not match index", old_name);
 		}
@@ -1041,7 +1041,7 @@ static int check_patch(struct patch *pat
 	}
 
 	if (new_name && (patch->is_new | patch->is_rename | patch->is_copy)) {
-		if (check_index && cache_name_pos(new_name, strlen(new_name)) >= 0)
+		if (check_index && cache_find_entry(new_name, strlen(new_name), NULL))
 			return error("%s: already exists in index", new_name);
 		if (!lstat(new_name, &st))
 			return error("%s: already exists in working directory", new_name);
