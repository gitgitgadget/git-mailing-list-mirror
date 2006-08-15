From: David Rientjes <rientjes@google.com>
Subject: [PATCH] remove unused pager_in_use
Date: Tue, 15 Aug 2006 13:49:07 -0700 (PDT)
Message-ID: <Pine.LNX.4.63.0608151348310.2687@chino.corp.google.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Tue Aug 15 22:49:45 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GD5qi-0005fC-HG
	for gcvg-git@gmane.org; Tue, 15 Aug 2006 22:49:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750729AbWHOUtR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 15 Aug 2006 16:49:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750776AbWHOUtR
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Aug 2006 16:49:17 -0400
Received: from smtp-out.google.com ([216.239.45.12]:52572 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1750729AbWHOUtR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Aug 2006 16:49:17 -0400
Received: from zps38.corp.google.com (zps38.corp.google.com [172.25.146.38])
	by smtp-out.google.com with ESMTP id k7FKnAaR001883
	for <git@vger.kernel.org>; Tue, 15 Aug 2006 13:49:11 -0700
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:date:from:x-x-sender:to:subject:message-id:
	mime-version:content-type;
	b=FBmBOKN7oNbU4VhX0vbv3C2mgpAmDrSsCrAunYQVQg119X0CKLNBe1XHUDuTr7aNE
	Dkw6bBb0kDHLanGLUrxaQ==
Received: from localhost (chino.corp.google.com [172.24.88.221])
	by zps38.corp.google.com with ESMTP id k7FKn8lP015920
	for <git@vger.kernel.org>; Tue, 15 Aug 2006 13:49:08 -0700
Received: by localhost (Postfix, from userid 24081)
	id 4BB7487D71; Tue, 15 Aug 2006 13:49:07 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by localhost (Postfix) with ESMTP id EE02387D70
	for <git@vger.kernel.org>; Tue, 15 Aug 2006 13:49:07 -0700 (PDT)
X-X-Sender: rientjes@chino.corp.google.com
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25481>

There's no need to honor pager_in_use because it's unused.

		David

Signed-off-by: David Rientjes <rientjes@google.com>
---
 cache.h       |    1 -
 diff.c        |    2 +-
 environment.c |    1 -
 pager.c       |    2 --
 4 files changed, 1 insertions(+), 5 deletions(-)

diff --git a/cache.h b/cache.h
index c738299..7a34728 100644
--- a/cache.h
+++ b/cache.h
@@ -391,7 +391,6 @@ extern int receive_keep_pack(int fd[2], 
 
 /* pager.c */
 extern void setup_pager(void);
-extern int pager_in_use;
 extern int pager_use_color;
 
 /* base85 */
diff --git a/diff.c b/diff.c
index 6a8c0c9..a7eefa8 100644
--- a/diff.c
+++ b/diff.c
@@ -175,7 +175,7 @@ int git_diff_ui_config(const char *var, 
 			diff_use_color_default = 1; /* bool */
 		else if (!strcasecmp(value, "auto")) {
 			diff_use_color_default = 0;
-			if (isatty(1) || (pager_in_use && pager_use_color)) {
+			if (isatty(1) || pager_use_color) {
 				char *term = getenv("TERM");
 				if (term && strcmp(term, "dumb"))
 					diff_use_color_default = 1;
diff --git a/environment.c b/environment.c
index 87162b2..c889816 100644
--- a/environment.c
+++ b/environment.c
@@ -22,7 +22,6 @@ char git_commit_encoding[MAX_ENCODING_LE
 int shared_repository = PERM_UMASK;
 const char *apply_default_whitespace = NULL;
 int zlib_compression_level = Z_DEFAULT_COMPRESSION;
-int pager_in_use;
 int pager_use_color = 1;
 
 static char *git_dir, *git_object_dir, *git_index_file, *git_refs_dir,
diff --git a/pager.c b/pager.c
index dcb398d..40ec566 100644
--- a/pager.c
+++ b/pager.c
@@ -26,8 +26,6 @@ void setup_pager(void)
 	else if (!*pager || !strcmp(pager, "cat"))
 		return;
 
-	pager_in_use = 1; /* means we are emitting to terminal */
-
 	if (pipe(fd) < 0)
 		return;
 	pid = fork();
-- 
1.4.2.g460c-dirty
