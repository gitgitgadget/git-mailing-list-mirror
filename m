From: Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH 1/2] Export relative path handling "prefix_path()" function
Date: Wed, 17 Aug 2005 13:31:49 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0508171331060.3553@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Wed Aug 17 22:33:25 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E5UZz-0006oJ-73
	for gcvg-git@gmane.org; Wed, 17 Aug 2005 22:32:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751253AbVHQUcA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 17 Aug 2005 16:32:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751254AbVHQUcA
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Aug 2005 16:32:00 -0400
Received: from smtp.osdl.org ([65.172.181.4]:58076 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751253AbVHQUcA (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 17 Aug 2005 16:32:00 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j7HKVojA001112
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 17 Aug 2005 13:31:51 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j7HKVn2V008302;
	Wed, 17 Aug 2005 13:31:50 -0700
To: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.114 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


Not all programs necessarily have a pathspec array of pathnames, some of
them (like git-update-cache) want to do things one file at a time.  So
export the single-path interface too.

Signed-off-by: Linus Torvalds <torvalds@osdl.org>
---

 cache.h |    1 +
 setup.c |    2 +-
 2 files changed, 2 insertions(+), 1 deletions(-)

c06157a36e49182c34e1e92aa7b329bde5dca3f9
diff --git a/cache.h b/cache.h
--- a/cache.h
+++ b/cache.h
@@ -142,6 +142,7 @@ extern char *get_graft_file(void);
 
 extern const char **get_pathspec(const char *prefix, char **pathspec);
 extern const char *setup_git_directory(void);
+extern char *prefix_path(const char *prefix, int len, char *path);
 
 #define alloc_nr(x) (((x)+16)*3/2)
 
diff --git a/setup.c b/setup.c
--- a/setup.c
+++ b/setup.c
@@ -1,6 +1,6 @@
 #include "cache.h"
 
-static char *prefix_path(const char *prefix, int len, char *path)
+char *prefix_path(const char *prefix, int len, char *path)
 {
 	char *orig = path;
 	for (;;) {
