From: Chuck Lever <cel@netapp.com>
Subject: [PATCH 18/22] teach diff.c to use cache_find_name()
Date: Mon, 12 Sep 2005 10:56:22 -0400
Message-ID: <20050912145622.28120.62972.stgit@dexter.citi.umich.edu>
References: <20050912145543.28120.7086.stgit@dexter.citi.umich.edu>
X-From: git-owner@vger.kernel.org Mon Sep 12 17:00:19 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EEpji-0000SG-2b
	for gcvg-git@gmane.org; Mon, 12 Sep 2005 16:56:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751310AbVILO4a (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Sep 2005 10:56:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751061AbVILO43
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Sep 2005 10:56:29 -0400
Received: from citi.umich.edu ([141.211.133.111]:2829 "EHLO citi.umich.edu")
	by vger.kernel.org with ESMTP id S1751305AbVILO4X (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 Sep 2005 10:56:23 -0400
Received: from dexter.citi.umich.edu (dexter.citi.umich.edu [141.211.133.33])
	by citi.umich.edu (Postfix) with ESMTP id C75731BAF3
	for <git@vger.kernel.org>; Mon, 12 Sep 2005 10:56:22 -0400 (EDT)
To: git@vger.kernel.org
In-Reply-To: <20050912145543.28120.7086.stgit@dexter.citi.umich.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8391>

Signed-off-by: Chuck Lever <cel@netapp.com>
---

 diff.c |    6 +-----
 1 files changed, 1 insertions(+), 5 deletions(-)

diff --git a/diff.c b/diff.c
--- a/diff.c
+++ b/diff.c
@@ -244,7 +244,6 @@ static int work_tree_matches(const char 
 {
 	struct cache_entry *ce;
 	struct stat st;
-	int pos, len;
 
 	/* We do not read the cache ourselves here, because the
 	 * benchmark with my previous version that always reads cache
@@ -261,11 +260,8 @@ static int work_tree_matches(const char 
 	if (read_cache_needed())
 		return 0;
 
-	len = strlen(name);
-	pos = cache_name_pos(name, len);
-	if (pos < 0)
+	if (!cache_find_entry(name, strlen(name), &ce))
 		return 0;
-	ce = active_cache[pos];
 	if ((lstat(name, &st) < 0) ||
 	    !S_ISREG(st.st_mode) || /* careful! */
 	    ce_match_stat(ce, &st) ||
