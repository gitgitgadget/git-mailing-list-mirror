From: Linus Torvalds <torvalds@osdl.org>
Subject: Fix sparse warnings
Date: Mon, 1 Aug 2005 12:11:53 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0508011208280.3341@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Aug 02 14:12:38 2005
Return-path: <git-owner@vger.kernel.org>
Received: from mail-relay.eunet.no ([193.71.71.242])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dzvc0-0006YE-Sw
	for gcvg-git@gmane.org; Tue, 02 Aug 2005 14:11:12 +0200
Received: from vger.kernel.org (vger.kernel.org [12.107.209.244])
	by mail-relay.eunet.no (8.13.1/8.13.1/GN) with ESMTP id j71JCema055638
	for <gcvg-git@gmane.org>; Mon, 1 Aug 2005 21:12:41 +0200 (CEST)
	(envelope-from git-owner@vger.kernel.org)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261153AbVHATML (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 1 Aug 2005 15:12:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261155AbVHATML
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Aug 2005 15:12:11 -0400
Received: from smtp.osdl.org ([65.172.181.4]:40335 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261153AbVHATMK (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 1 Aug 2005 15:12:10 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j71JBsjA007573
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 1 Aug 2005 12:11:54 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j71JBre1026720;
	Mon, 1 Aug 2005 12:11:54 -0700
To: Junio C Hamano <junkio@cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.113 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


A few sparse warnings have crept in again since I checked last time:  
undeclared variables with global scope.

Fix them by marking the private variables properly "static".

Signed-off-by: Linus Torvalds <torvalds@osdl.org>
----
Btw, sparse also warns about the "return 0" in receive-pack.c: unpack(), 
since that function is supposed to return void. I think somebody else 
already sent a patch for that one.


diff --git a/daemon.c b/daemon.c
--- a/daemon.c
+++ b/daemon.c
@@ -71,13 +71,13 @@ static int max_connections = 25;
 
 /* These are updated by the signal handler */
 static volatile unsigned int children_reaped = 0;
-pid_t dead_child[MAX_CHILDREN];
+static pid_t dead_child[MAX_CHILDREN];
 
 /* These are updated by the main loop */
 static unsigned int children_spawned = 0;
 static unsigned int children_deleted = 0;
 
-struct child {
+static struct child {
 	pid_t pid;
 	socklen_t addrlen;
 	struct sockaddr_storage address;
diff --git a/rev-cache.c b/rev-cache.c
--- a/rev-cache.c
+++ b/rev-cache.c
@@ -5,7 +5,7 @@
 struct rev_cache **rev_cache;
 int nr_revs, alloc_revs;
 
-struct rev_list_elem *rle_free;
+static struct rev_list_elem *rle_free;
 
 #define BATCH_SIZE 512
 
diff --git a/server-info.c b/server-info.c
--- a/server-info.c
+++ b/server-info.c
@@ -62,7 +62,7 @@ static int update_info_refs(int force)
 }
 
 /* packs */
-struct pack_info {
+static struct pack_info {
 	unsigned long latest;
 	struct packed_git *p;
 	int old_num;
