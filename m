From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH] Correct new compiler warnings in builtin-revert
Date: Mon, 12 Mar 2007 15:33:18 -0400
Message-ID: <20070312193318.GA16234@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Mar 12 20:33:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HQqGs-0000Np-AP
	for gcvg-git@gmane.org; Mon, 12 Mar 2007 20:33:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752568AbXCLTdX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Mar 2007 15:33:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752607AbXCLTdX
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Mar 2007 15:33:23 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:52137 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752568AbXCLTdW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Mar 2007 15:33:22 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HQqGe-0001GR-6I; Mon, 12 Mar 2007 15:33:12 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 08E5020FBAE; Mon, 12 Mar 2007 15:33:19 -0400 (EDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42066>

The new builtin-revert code introduces a few new compiler errors
when I'm building with my stricter set of checks enabled in CFLAGS.
These all just stem from trying to store a constant string into
a non-const char*.  Simple fix, make the variables const char*.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 builtin-revert.c |    4 ++--
 cache.h          |    2 +-
 environment.c    |    2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/builtin-revert.c b/builtin-revert.c
index 652eece..f3f3f5c 100644
--- a/builtin-revert.c
+++ b/builtin-revert.c
@@ -235,8 +235,8 @@ static int revert_or_cherry_pick(int argc, const char **argv)
 	unsigned char head[20];
 	struct commit *base, *next;
 	int i;
-	char *oneline, *encoding, *reencoded_message = NULL;
-	const char *message;
+	char *oneline, *reencoded_message = NULL;
+	const char *message, *encoding;
 
 	git_config(git_default_config);
 	me = action == REVERT ? "revert" : "cherry-pick";
diff --git a/cache.h b/cache.h
index f172d02..4f10667 100644
--- a/cache.h
+++ b/cache.h
@@ -449,7 +449,7 @@ extern int check_repository_format_version(const char *var, const char *value);
 extern char git_default_email[MAX_GITNAME];
 extern char git_default_name[MAX_GITNAME];
 
-extern char *git_commit_encoding;
+extern const char *git_commit_encoding;
 extern const char *git_log_output_encoding;
 
 extern int copy_fd(int ifd, int ofd);
diff --git a/environment.c b/environment.c
index 0151ad0..fff4a4d 100644
--- a/environment.c
+++ b/environment.c
@@ -20,7 +20,7 @@ int is_bare_repository_cfg = -1; /* unspecified */
 int log_all_ref_updates = -1; /* unspecified */
 int warn_ambiguous_refs = 1;
 int repository_format_version;
-char *git_commit_encoding;
+const char *git_commit_encoding;
 const char *git_log_output_encoding;
 int shared_repository = PERM_UMASK;
 const char *apply_default_whitespace;
-- 
1.5.0.3.985.gcf0b4
