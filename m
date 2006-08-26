From: Jonas Fonseca <fonseca@diku.dk>
Subject: [PATCH] Use PATH_MAX instead of MAXPATHLEN
Date: Sat, 26 Aug 2006 16:09:17 +0200
Message-ID: <20060826140917.GA11601@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sat Aug 26 16:09:37 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GGyqr-0004Fi-Kf
	for gcvg-git@gmane.org; Sat, 26 Aug 2006 16:09:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750811AbWHZOJ1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 26 Aug 2006 10:09:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751079AbWHZOJ1
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Aug 2006 10:09:27 -0400
Received: from [130.225.96.91] ([130.225.96.91]:415 "EHLO mgw1.diku.dk")
	by vger.kernel.org with ESMTP id S1750811AbWHZOJ0 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 26 Aug 2006 10:09:26 -0400
Received: from localhost (localhost [127.0.0.1])
	by mgw1.diku.dk (Postfix) with ESMTP id 982E6770093
	for <git@vger.kernel.org>; Sat, 26 Aug 2006 16:09:18 +0200 (CEST)
Received: from mgw1.diku.dk ([127.0.0.1])
 by localhost (mgw1.diku.dk [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 13123-14 for <git@vger.kernel.org>; Sat, 26 Aug 2006 16:09:17 +0200 (CEST)
Received: from nhugin.diku.dk (nhugin.diku.dk [130.225.96.140])
	by mgw1.diku.dk (Postfix) with ESMTP id 685FE77008E
	for <git@vger.kernel.org>; Sat, 26 Aug 2006 16:09:17 +0200 (CEST)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP id 582556DF8AC
	for <git@vger.kernel.org>; Sat, 26 Aug 2006 16:07:57 +0200 (CEST)
Received: by ask.diku.dk (Postfix, from userid 3873)
	id 4EB3F62A02; Sat, 26 Aug 2006 16:09:17 +0200 (CEST)
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
X-Virus-Scanned: amavisd-new at diku.dk
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26047>

According to sys/paramh.h it's a "BSD name" for values defined in
<limits.h>. Besides PATH_MAX seems to be more commonly used.

Signed-off-by: Jonas Fonseca <fonseca@diku.dk>
---
 builtin-checkout-index.c |    2 +-
 dir.c                    |    2 +-
 entry.c                  |    4 +---
 git-compat-util.h        |    3 ---
 4 files changed, 3 insertions(+), 8 deletions(-)

diff --git a/builtin-checkout-index.c b/builtin-checkout-index.c
index 6b55f93..b097c88 100644
--- a/builtin-checkout-index.c
+++ b/builtin-checkout-index.c
@@ -45,7 +45,7 @@ #define CHECKOUT_ALL 4
 static int line_termination = '\n';
 static int checkout_stage; /* default to checkout stage0 */
 static int to_tempfile;
-static char topath[4][MAXPATHLEN+1];
+static char topath[4][PATH_MAX + 1];
 
 static struct checkout state;
 
diff --git a/dir.c b/dir.c
index 092d077..a686de6 100644
--- a/dir.c
+++ b/dir.c
@@ -293,7 +293,7 @@ static int read_directory_recursive(stru
 	if (fdir) {
 		int exclude_stk;
 		struct dirent *de;
-		char fullname[MAXPATHLEN + 1];
+		char fullname[PATH_MAX + 1];
 		memcpy(fullname, base, baselen);
 
 		exclude_stk = push_exclude_per_directory(dir, base, baselen);
diff --git a/entry.c b/entry.c
index 793724f..b2ea0ef 100644
--- a/entry.c
+++ b/entry.c
@@ -135,7 +135,7 @@ static int write_entry(struct cache_entr
 
 int checkout_entry(struct cache_entry *ce, struct checkout *state, char *topath)
 {
-	static char path[MAXPATHLEN+1];
+	static char path[PATH_MAX + 1];
 	struct stat st;
 	int len = state->base_dir_len;
 
@@ -172,5 +172,3 @@ int checkout_entry(struct cache_entry *c
 	create_directories(path, state);
 	return write_entry(ce, path, state, 0);
 }
-
-
diff --git a/git-compat-util.h b/git-compat-util.h
index b2e1895..91f2b0d 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -172,7 +172,4 @@ static inline int sane_case(int x, int h
 	return x;
 }
 
-#ifndef MAXPATHLEN
-#define MAXPATHLEN 256
-#endif
 #endif
-- 
1.4.2.GIT

-- 
Jonas Fonseca
