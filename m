From: David Rientjes <rientjes@google.com>
Subject: [PATCH 17/28] makes diff_cache void
Date: Mon, 14 Aug 2006 13:33:42 -0700 (PDT)
Message-ID: <Pine.LNX.4.63.0608141333030.19383@chino.corp.google.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Mon Aug 14 22:34:04 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GCj8H-0000dh-HS
	for gcvg-git@gmane.org; Mon, 14 Aug 2006 22:33:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932730AbWHNUdz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 Aug 2006 16:33:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932731AbWHNUdz
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Aug 2006 16:33:55 -0400
Received: from smtp-out.google.com ([216.239.45.12]:19350 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP id S932730AbWHNUdy
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Aug 2006 16:33:54 -0400
Received: from zps37.corp.google.com (zps37.corp.google.com [172.25.146.37])
	by smtp-out.google.com with ESMTP id k7EKXhwK025771
	for <git@vger.kernel.org>; Mon, 14 Aug 2006 13:33:43 -0700
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:date:from:x-x-sender:to:subject:message-id:
	mime-version:content-type;
	b=iVjoj4eYo0yxJloLAT+aX/A0vUPTwunbWyL7xXpIbyRmL4fQs//w7mBL64FgheVKO
	lEdF3y34qX1B6XrzY22NA==
Received: from localhost (chino.corp.google.com [172.24.88.221])
	by zps37.corp.google.com with ESMTP id k7EKXg2Q010115
	for <git@vger.kernel.org>; Mon, 14 Aug 2006 13:33:42 -0700
Received: by localhost (Postfix, from userid 24081)
	id 92F7387D71; Mon, 14 Aug 2006 13:33:42 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by localhost (Postfix) with ESMTP id 9085087D70
	for <git@vger.kernel.org>; Mon, 14 Aug 2006 13:33:42 -0700 (PDT)
X-X-Sender: rientjes@chino.corp.google.com
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25398>

Makes diff_cache void and cleans up function calls.

		David

Signed-off-by: David Rientjes <rientjes@google.com>
---
 diff-lib.c |   16 +++++++---------
 1 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/diff-lib.c b/diff-lib.c
index 116b5a9..3c42b09 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -227,10 +227,10 @@ static int show_modified(struct rev_info
 	return 0;
 }
 
-static int diff_cache(struct rev_info *revs,
-		      struct cache_entry **ac, int entries,
-		      const char **pathspec,
-		      int cached, int match_missing)
+static void diff_cache(struct rev_info *revs,
+		       struct cache_entry **ac, int entries,
+		       const char **pathspec,
+		       int cached, int match_missing)
 {
 	while (entries) {
 		struct cache_entry *ce = *ac;
@@ -292,7 +292,6 @@ skip_entry:
 			entries--;
 		} while (entries && ce_same_name(ce, ac[0]));
 	}
-	return 0;
 }
 
 /*
@@ -313,7 +312,6 @@ static void mark_merge_entries(void)
 
 int run_diff_index(struct rev_info *revs, int cached)
 {
-	int ret;
 	struct object *ent;
 	struct tree *tree;
 	const char *tree_name;
@@ -339,9 +337,9 @@ int run_diff_index(struct rev_info *revs
 		return error("bad tree object %s", tree_name);
 	if (read_tree(tree, 1, revs->prune_data))
 		return error("unable to read tree object %s", tree_name);
-	ret = diff_cache(revs, active_cache, active_nr, revs->prune_data,
-			 cached, match_missing);
+	diff_cache(revs, active_cache, active_nr, revs->prune_data,
+		   cached, match_missing);
 	diffcore_std(&revs->diffopt);
 	diff_flush(&revs->diffopt);
-	return ret;
+	return 0;
 }
-- 
1.4.2.g89bb-dirty
