From: David Rientjes <rientjes@google.com>
Subject: [PATCH 14/28] make do_reupdate void
Date: Mon, 14 Aug 2006 13:31:16 -0700 (PDT)
Message-ID: <Pine.LNX.4.63.0608141330340.19383@chino.corp.google.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Mon Aug 14 22:31:36 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GCj5u-0008WD-0a
	for gcvg-git@gmane.org; Mon, 14 Aug 2006 22:31:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932726AbWHNUb1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 Aug 2006 16:31:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932727AbWHNUb0
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Aug 2006 16:31:26 -0400
Received: from smtp-out.google.com ([216.239.45.12]:56468 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP id S932726AbWHNUb0
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Aug 2006 16:31:26 -0400
Received: from zps36.corp.google.com (zps36.corp.google.com [172.25.146.36])
	by smtp-out.google.com with ESMTP id k7EKVMXa021692
	for <git@vger.kernel.org>; Mon, 14 Aug 2006 13:31:22 -0700
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:date:from:x-x-sender:to:subject:message-id:
	mime-version:content-type;
	b=WFRaE+O0shWU5Pqr6Xh/9daXr0wd9xNKTcyOjP5d+yCUyQ+0rb8UrCP5PB7j/2H8M
	6gBtIEPqKFcu5AbSq+AEg==
Received: from localhost (chino.corp.google.com [172.24.88.221])
	by zps36.corp.google.com with ESMTP id k7EKVGWR019237
	for <git@vger.kernel.org>; Mon, 14 Aug 2006 13:31:16 -0700
Received: by localhost (Postfix, from userid 24081)
	id 0F04F87D71; Mon, 14 Aug 2006 13:31:16 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by localhost (Postfix) with ESMTP id 0CA2D87D70
	for <git@vger.kernel.org>; Mon, 14 Aug 2006 13:31:16 -0700 (PDT)
X-X-Sender: rientjes@chino.corp.google.com
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25394>

Makes do_reupdate void and cleans up function calls.

		David

Signed-off-by: David Rientjes <rientjes@google.com>
---
 builtin-update-index.c |   11 ++++-------
 1 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/builtin-update-index.c b/builtin-update-index.c
index d2556f3..010adcf 100644
--- a/builtin-update-index.c
+++ b/builtin-update-index.c
@@ -433,8 +433,8 @@ static int do_unresolve(int ac, const ch
 	return err;
 }
 
-static int do_reupdate(int ac, const char **av,
-		       const char *prefix, int prefix_length)
+static void do_reupdate(int ac, const char **av,
+			const char *prefix, int prefix_length)
 {
 	/* Read HEAD and run update-index on paths that are
 	 * merged and already different between index and HEAD.
@@ -473,7 +473,6 @@ static int do_reupdate(int ac, const cha
 		if (save_nr != active_nr)
 			goto redo;
 	}
-	return 0;
 }
 
 int cmd_update_index(int argc, const char **argv, const char *prefix)
@@ -596,10 +595,8 @@ int cmd_update_index(int argc, const cha
 				goto finish;
 			}
 			if (!strcmp(path, "--again")) {
-				has_errors = do_reupdate(argc - i, argv + i,
-							 prefix, prefix_length);
-				if (has_errors)
-					active_cache_changed = 0;
+				do_reupdate(argc - i, argv + i, prefix,
+					    prefix_length);
 				goto finish;
 			}
 			if (!strcmp(path, "--ignore-missing")) {
-- 
1.4.2.g89bb-dirty
