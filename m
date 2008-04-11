From: Gabriel <g2p.code@gmail.com>
Subject: [PATCH] Default to fetching a remote after adding it.
Date: Fri, 11 Apr 2008 21:29:29 +0200
Message-ID: <1207942169-2644-1-git-send-email-g2p.code@gmail.com>
References: <20080411203501.7095b866@localhost>
Cc: Gabriel <g2p.code@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 11 21:30:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JkOx0-0005ab-4v
	for gcvg-git-2@gmane.org; Fri, 11 Apr 2008 21:30:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758500AbYDKT3b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Apr 2008 15:29:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758305AbYDKT3b
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Apr 2008 15:29:31 -0400
Received: from smtp1-g19.free.fr ([212.27.42.27]:57338 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758040AbYDKT3a (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Apr 2008 15:29:30 -0400
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 88A2E1AB307;
	Fri, 11 Apr 2008 21:29:29 +0200 (CEST)
Received: from localhost (pro75-5-88-162-203-35.fbx.proxad.net [88.162.203.35])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 61A0A1AB2C0;
	Fri, 11 Apr 2008 21:29:29 +0200 (CEST)
Received: from g2p by localhost with local (Exim 4.67)
	(envelope-from <g2p@vapeur.no-ip.org>)
	id 1JkOwD-0000gz-Iw; Fri, 11 Apr 2008 21:29:29 +0200
X-Mailer: git-send-email 1.5.5.25.g9415
In-Reply-To: <20080411203501.7095b866@localhost>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79290>

This is what the user wants in 99% of cases.

Signed-off-by: Gabriel <g2p.code@gmail.com>
---

Also update some tests; disregard the previous patch.

 Documentation/git-remote.txt |    4 ++--
 builtin-remote.c             |    2 +-
 t/t5503-tagfollow.sh         |    2 +-
 t/t5512-ls-remote.sh         |    2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-remote.txt b/Documentation/git-remote.txt
index 2cbd1f7..04de972 100644
--- a/Documentation/git-remote.txt
+++ b/Documentation/git-remote.txt
@@ -10,7 +10,7 @@ SYNOPSIS
 --------
 [verse]
 'git-remote'
-'git-remote' add [-t <branch>] [-m <master>] [-f] [--mirror] <name> <url>
+'git-remote' add [-t <branch>] [-m <master>] [--no-fetch] [--mirror] <name> <url>
 'git-remote' rm <name>
 'git-remote' show <name>
 'git-remote' prune <name>
@@ -34,7 +34,7 @@ Adds a remote named <name> for the repository at
 <url>.  The command `git fetch <name>` can then be used to create and
 update remote-tracking branches <name>/<branch>.
 +
-With `-f` option, `git fetch <name>` is run immediately after
+Without the `--no-fetch` option, `git fetch <name>` is run immediately after
 the remote information is set up.
 +
 With `-t <branch>` option, instead of the default glob
diff --git a/builtin-remote.c b/builtin-remote.c
index 044215a..c0d7d96 100644
--- a/builtin-remote.c
+++ b/builtin-remote.c
@@ -54,7 +54,7 @@ static int fetch_remote(const char *name)
 
 static int add(int argc, const char **argv)
 {
-	int fetch = 0, mirror = 0;
+	int fetch = 1, mirror = 0;
 	struct path_list track = { NULL, 0, 0 };
 	const char *master = NULL;
 	struct remote *remote;
diff --git a/t/t5503-tagfollow.sh b/t/t5503-tagfollow.sh
index 86e5b9b..fd075d9 100755
--- a/t/t5503-tagfollow.sh
+++ b/t/t5503-tagfollow.sh
@@ -134,7 +134,7 @@ test_expect_success 'new clone fetch master and tags' '
 		mkdir clone2 &&
 		cd clone2 &&
 		git init &&
-		git remote add origin .. &&
+		git remote add origin .. --no-fetch &&
 		GIT_DEBUG_SEND_PACK=3 git fetch 3>../$U &&
 		test $B = $(git rev-parse --verify origin/master) &&
 		test $S = $(git rev-parse --verify tag2) &&
diff --git a/t/t5512-ls-remote.sh b/t/t5512-ls-remote.sh
index c0dc949..08855ed 100755
--- a/t/t5512-ls-remote.sh
+++ b/t/t5512-ls-remote.sh
@@ -17,7 +17,7 @@ test_expect_success setup '
 		git show-ref -d	| sed -e "s/ /	/"
 	) >expected.all &&
 
-	git remote add self $(pwd)/.git
+	git remote add self $(pwd)/.git --no-fetch
 
 '
 
-- 
1.5.5.25.g9415
