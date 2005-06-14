From: Sven Verdoolaege <skimo@liacs.nl>
Subject: [PATCH] ssh-push: Don't add '/' to pathname
Date: Tue, 14 Jun 2005 12:37:38 +0200
Message-ID: <20050614103738.GA14483@pc117b.liacs.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Tue Jun 14 12:33:58 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Di8jo-00072s-J1
	for gcvg-git@gmane.org; Tue, 14 Jun 2005 12:33:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261174AbVFNKig (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 14 Jun 2005 06:38:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261177AbVFNKig
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Jun 2005 06:38:36 -0400
Received: from rhodium.liacs.nl ([132.229.131.16]:8599 "EHLO rhodium.liacs.nl")
	by vger.kernel.org with ESMTP id S261174AbVFNKi3 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 14 Jun 2005 06:38:29 -0400
Received: from pc117b.liacs.nl (pc117b.liacs.nl [132.229.129.143])
	by rhodium.liacs.nl (8.13.0/8.13.0/LIACS 1.4) with ESMTP id j5EAbcMJ005888;
	Tue, 14 Jun 2005 12:37:44 +0200
Received: by pc117b.liacs.nl (Postfix, from userid 17122)
	id C2BFA6FE9; Tue, 14 Jun 2005 12:37:38 +0200 (CEST)
To: git@vger.kernel.org, Daniel Barkalow <barkalow@iabervon.org>,
	Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

ssh-push: Don't add '/' to pathname

Paths in the host:path notation are usually interpreted
relative to the login directory rather than relative to
the root directory.

Signed-off-by: Sven Verdoolaege <skimo@liacs.nl>

---
commit 508f3a7ad9d940529ad6736763108fe5c7729171
tree 7332f4cd8f29f0548821f1d0501b2e9a45ae502a
parent 200b82de27633d2c85a4358e1be5ae7fab1b077f
author Sven Verdoolaege <skimo@liacs.nl> Tue, 14 Jun 2005 12:34:49 +0200
committer Sven Verdoolaege <skimo@liacs.nl> Tue, 14 Jun 2005 12:34:49 +0200

 rsh.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/rsh.c b/rsh.c
--- a/rsh.c
+++ b/rsh.c
@@ -31,14 +31,15 @@ int setup_connection(int *fd_in, int *fd
 	} else {
 		host = url;
 		path = strchr(host, ':');
+		if (path)
+			*(path++) = '\0';
 	}
 	if (!path) {
 		return error("Bad URL: %s", url);
 	}
-	*(path++) = '\0';
-	/* ssh <host> 'cd /<path>; stdio-pull <arg...> <commit-id>' */
+	/* ssh <host> 'cd <path>; stdio-pull <arg...> <commit-id>' */
 	snprintf(command, COMMAND_SIZE, 
-		 "%s='/%s' %s",
+		 "%s='%s' %s",
 		 GIT_DIR_ENVIRONMENT, path, remote_prog);
 	posn = command + strlen(command);
 	for (i = 0; i < rmt_argc; i++) {
