From: Brad Roberts <braddr@gameboy2.puremagic.com>
Subject: [PATCH 02/19] Add new api's to front the active_cache and active_nr cache internals
Date: Thu, 21 Apr 2005 11:34:57 -0700
Message-ID: <200504211834.j3LIYvBM027396@gameboy2.puremagic.com>
X-From: git-owner@vger.kernel.org Thu Apr 21 20:31:52 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DOgSA-0007mQ-H4
	for gcvg-git@gmane.org; Thu, 21 Apr 2005 20:31:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261622AbVDUSf1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Apr 2005 14:35:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261644AbVDUSf1
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Apr 2005 14:35:27 -0400
Received: from bellevue.puremagic.com ([209.189.198.108]:1416 "EHLO
	bellevue.puremagic.com") by vger.kernel.org with ESMTP
	id S261622AbVDUSe7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Apr 2005 14:34:59 -0400
Received: from gameboy2.puremagic.com (root@gameboy2.puremagic.com [209.189.198.109])
	by bellevue.puremagic.com (8.13.3/8.13.3/Debian-6) with ESMTP id j3LIYtAR027762
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <git@vger.kernel.org>; Thu, 21 Apr 2005 11:34:55 -0700
Received: from gameboy2.puremagic.com (braddr@localhost [127.0.0.1])
	by gameboy2.puremagic.com (8.13.3/8.13.3/Debian-3) with ESMTP id j3LIYvjk027398
	for <git@vger.kernel.org>; Thu, 21 Apr 2005 11:34:57 -0700
Received: (from braddr@localhost)
	by gameboy2.puremagic.com (8.13.3/8.13.3/Submit) id j3LIYvBM027396
	for git@vger.kernel.org; Thu, 21 Apr 2005 11:34:57 -0700
To: git@vger.kernel.org
X-Virus-Scanned: by amavisd-new
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

tree ebbf2c037e68116c4ff934f140ca12cdbe13311d
parent 77de9e0b7a81ddc22526c9415f0273171f631d3f
author Brad Roberts <braddr@puremagic.com> 1114073146 -0700
committer Brad Roberts <braddr@gameboy2.puremagic.com> 1114073146 -0700

[PATCH] Add new api's to front the active_cache and active_nr cache internals

Signed-off-by: Brad Roberts <braddr@puremagic.com>
---

 cache.h      |    3 +++
 read-cache.c |   15 +++++++++++++++
 2 files changed, 18 insertions(+)

Index: cache.h
===================================================================
--- 77de9e0b7a81ddc22526c9415f0273171f631d3f:1/cache.h  (mode:100644 sha1:a101870e4a002a2548d88544a77bedad21668203)
+++ 27fc41dcd4aecafdaf583f3962697a2fa3fb6480:1/cache.h  (mode:100644 sha1:9ad6e805eafcb213c6bb4b1f8ff4d4e053fa6067)
@@ -93,6 +93,9 @@
 extern int add_cache_entry(struct cache_entry *ce, int ok_to_add);
 extern int remove_file_from_cache(char *path);
 extern int cache_match_stat(struct cache_entry *ce, struct stat *st);
+extern int get_num_cache_entries();
+extern struct cache_entry * get_cache_entry(int pos);
+extern void set_cache_entry(struct cache_entry *ce, int pos);
 
 #define MTIME_CHANGED	0x0001
 #define CTIME_CHANGED	0x0002
Index: read-cache.c
===================================================================
--- 77de9e0b7a81ddc22526c9415f0273171f631d3f:1/read-cache.c  (mode:100644 sha1:349ebd1f8a0a95bf462bb1dfd3d9dfb50628829c)
+++ 27fc41dcd4aecafdaf583f3962697a2fa3fb6480:1/read-cache.c  (mode:100644 sha1:6689df59d5a93e0503d7c80c114efbd16de826f3)
@@ -110,6 +110,21 @@
 	return ce_namelen(b) == len && !memcmp(a->name, b->name, len);
 }
 
+int get_num_cache_entries()
+{
+	return active_nr;
+}
+
+struct cache_entry * get_cache_entry(int pos)
+{
+	return active_cache[pos];
+}
+
+void set_cache_entry(struct cache_entry *ce, int pos)
+{
+	active_cache[pos] = ce;
+}
+
 int add_cache_entry(struct cache_entry *ce, int ok_to_add)
 {
 	int pos;

