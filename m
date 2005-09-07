From: Fredrik Kuivinen <freku045@student.liu.se>
Subject: [PATCH 1/2] Add '-i' flag to read-tree to make it ignore whats in the working directory.
Date: Wed, 7 Sep 2005 18:50:12 +0200
Message-ID: <20050907165012.GA20392@c165.ib.student.liu.se>
References: <20050907164734.GA20198@c165.ib.student.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: junkio@cox.net
X-From: git-owner@vger.kernel.org Wed Sep 07 18:53:58 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ED37r-0000wo-5A
	for gcvg-git@gmane.org; Wed, 07 Sep 2005 18:50:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932180AbVIGQuP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Sep 2005 12:50:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932181AbVIGQuP
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Sep 2005 12:50:15 -0400
Received: from [85.8.31.11] ([85.8.31.11]:29407 "EHLO mail6.wasadata.com")
	by vger.kernel.org with ESMTP id S932180AbVIGQuN (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 7 Sep 2005 12:50:13 -0400
Received: from c165 (unknown [85.8.2.189])
	by mail6.wasadata.com (Postfix) with ESMTP
	id 65D3B4116; Wed,  7 Sep 2005 18:54:55 +0200 (CEST)
Received: from ksorim by c165 with local (Exim 3.36 #1 (Debian))
	id 1ED37k-0005K2-00; Wed, 07 Sep 2005 18:50:12 +0200
To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20050907164734.GA20198@c165.ib.student.liu.se>
User-Agent: Mutt/1.5.6+20040907i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8170>

This will be used by the merge code.

Signed-off-by: Fredrik Kuivinen <freku@ida.liu.se>


---

 read-tree.c |   13 +++++++++++--
 1 files changed, 11 insertions(+), 2 deletions(-)

12d226103dc278c5d5aaf6b2dc776af3170ed233
diff --git a/read-tree.c b/read-tree.c
--- a/read-tree.c
+++ b/read-tree.c
@@ -7,6 +7,7 @@
 
 static int stage = 0;
 static int update = 0;
+static int ignore_working_dir = 0;
 
 static int unpack_tree(unsigned char *sha1)
 {
@@ -80,7 +81,10 @@ static void verify_uptodate(struct cache
 {
 	struct stat st;
 
-	if (!lstat(ce->name, &st)) {
+        if (ignore_working_dir)
+            return;
+
+        if (!lstat(ce->name, &st)) {
 		unsigned changed = ce_match_stat(ce, &st);
 		if (!changed)
 			return;
@@ -510,7 +514,7 @@ static int read_cache_unmerged(void)
 	return deleted;
 }
 
-static const char read_tree_usage[] = "git-read-tree (<sha> | -m [-u] <sha1> [<sha2> [<sha3>]])";
+static const char read_tree_usage[] = "git-read-tree (<sha> | -m [-u] [-i] <sha1> [<sha2> [<sha3>]])";
 
 static struct cache_file cache_file;
 
@@ -535,6 +539,11 @@ int main(int argc, char **argv)
 			continue;
 		}
 
+                if (!strcmp(arg, "-i")) {
+                        ignore_working_dir = 1;
+                        continue;
+                }
+
 		/* This differs from "-m" in that we'll silently ignore unmerged entries */
 		if (!strcmp(arg, "--reset")) {
 			if (stage || merge || emu23)
