From: Brad Roberts <braddr@gameboy2.puremagic.com>
Subject: [PATCH 07/19] migrate merge-cache.c over to the new cache api's
Date: Thu, 21 Apr 2005 11:36:14 -0700
Message-ID: <200504211836.j3LIaEUV027527@gameboy2.puremagic.com>
X-From: git-owner@vger.kernel.org Thu Apr 21 20:33:35 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DOgTJ-0007wi-CT
	for gcvg-git@gmane.org; Thu, 21 Apr 2005 20:32:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261661AbVDUSgk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Apr 2005 14:36:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261670AbVDUSgk
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Apr 2005 14:36:40 -0400
Received: from bellevue.puremagic.com ([209.189.198.108]:23176 "EHLO
	bellevue.puremagic.com") by vger.kernel.org with ESMTP
	id S261661AbVDUSgP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Apr 2005 14:36:15 -0400
Received: from gameboy2.puremagic.com (root@gameboy2.puremagic.com [209.189.198.109])
	by bellevue.puremagic.com (8.13.3/8.13.3/Debian-6) with ESMTP id j3LIaCp5027896
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <git@vger.kernel.org>; Thu, 21 Apr 2005 11:36:12 -0700
Received: from gameboy2.puremagic.com (braddr@localhost [127.0.0.1])
	by gameboy2.puremagic.com (8.13.3/8.13.3/Debian-3) with ESMTP id j3LIaEm3027529
	for <git@vger.kernel.org>; Thu, 21 Apr 2005 11:36:14 -0700
Received: (from braddr@localhost)
	by gameboy2.puremagic.com (8.13.3/8.13.3/Submit) id j3LIaEUV027527
	for git@vger.kernel.org; Thu, 21 Apr 2005 11:36:14 -0700
To: git@vger.kernel.org
X-Virus-Scanned: by amavisd-new
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

tree 8140acee0f9c57bfd87f40d1f99242c772afcdf2
parent 32efd81a3292a923ce5b5ae2e39ffefd0b08664d
author Brad Roberts <braddr@puremagic.com> 1114074631 -0700
committer Brad Roberts <braddr@gameboy2.puremagic.com> 1114074631 -0700

[PATCH] migrate merge-cache.c over to the new cache api's

Signed-off-by: Brad Roberts <braddr@puremagic.com>
---

 merge-cache.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

Index: merge-cache.c
===================================================================
--- 32efd81a3292a923ce5b5ae2e39ffefd0b08664d:1/merge-cache.c  (mode:100644 sha1:35a0d588178aa5371399458b1a15519cffd645b8)
+++ e2acfff5e544a8c6769a9e665927092b3edd7579:1/merge-cache.c  (mode:100644 sha1:c2f96e7652a2aea9417c3790bfe9ab14ffcdb12f)
@@ -30,7 +30,7 @@
 {
 	int found;
 	
-	if (pos >= active_nr)
+	if (pos >= get_num_cache_entries())
 		die("merge-cache: %s not in the cache", path);
 	arguments[0] = pgm;
 	arguments[1] = "";
@@ -40,7 +40,7 @@
 	found = 0;
 	do {
 		static char hexbuf[4][60];
-		struct cache_entry *ce = active_cache[pos];
+		struct cache_entry *ce = get_cache_entry(pos);
 		int stage = ce_stage(ce);
 
 		if (strcmp(ce->name, path))
@@ -48,7 +48,7 @@
 		found++;
 		strcpy(hexbuf[stage], sha1_to_hex(ce->sha1));
 		arguments[stage] = hexbuf[stage];
-	} while (++pos < active_nr);
+	} while (++pos < get_num_cache_entries());
 	if (!found)
 		die("merge-cache: %s not in the cache", path);
 	run_program();
@@ -70,8 +70,8 @@
 static void merge_all(void)
 {
 	int i;
-	for (i = 0; i < active_nr; i++) {
-		struct cache_entry *ce = active_cache[i];
+	for (i = 0; i < get_num_cache_entries(); i++) {
+		struct cache_entry *ce = get_cache_entry(i);
 		if (!ce_stage(ce))
 			continue;
 		i += merge_entry(i, ce->name)-1;

