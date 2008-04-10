From: Gabriel <g2p.code@gmail.com>
Subject: [PATCH] When a remote is added but not fetched, tell the user.
Date: Fri, 11 Apr 2008 01:25:46 +0200
Message-ID: <1207869946-17013-1-git-send-email-g2p.code@gmail.com>
References: <20080409101428.GA2637@elte.hu>
Cc: Gabriel <g2p.code@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 11 01:26:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jk6AE-0008Vl-FH
	for gcvg-git-2@gmane.org; Fri, 11 Apr 2008 01:26:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758414AbYDJXZu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Apr 2008 19:25:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758413AbYDJXZu
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Apr 2008 19:25:50 -0400
Received: from smtp1-g19.free.fr ([212.27.42.27]:55232 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753061AbYDJXZt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Apr 2008 19:25:49 -0400
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 9BD251AB2B2;
	Fri, 11 Apr 2008 01:25:46 +0200 (CEST)
Received: from localhost (pro75-5-88-162-203-35.fbx.proxad.net [88.162.203.35])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 824CE1AB2B1;
	Fri, 11 Apr 2008 01:25:46 +0200 (CEST)
Received: from g2p by localhost with local (Exim 4.67)
	(envelope-from <g2p@vapeur.no-ip.org>)
	id 1Jk69K-0004Qk-QQ; Fri, 11 Apr 2008 01:25:46 +0200
X-Mailer: git-send-email 1.5.5.24.geb27
In-Reply-To: <20080409101428.GA2637@elte.hu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79255>

A helpful message tells the user when a remote was added
without being fetched, and how to fetch it.

Our default of not fetching is breaking the users' workflow
in the common "let me access this repo" use case.
This message alleviates the problem.

Signed-off-by: Gabriel <g2p.code@gmail.com>
---
 builtin-remote.c |   12 ++++++++++--
 1 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/builtin-remote.c b/builtin-remote.c
index d77f10a..044215a 100644
--- a/builtin-remote.c
+++ b/builtin-remote.c
@@ -111,8 +111,16 @@ static int add(int argc, const char **argv)
 			return 1;
 	}
 
-	if (fetch && fetch_remote(name))
-		return 1;
+	if (fetch) {
+		if (fetch_remote(name))
+			return 1;
+	}
+	else {
+		printf ("Added remote repository `%s' without fetching it.\n"
+			"Before accessing the branches of this "
+			"remote, run `git fetch %s' "
+			"or `git remote update'.\n", name, name);
+	}
 
 	if (master) {
 		strbuf_reset(&buf);
-- 
1.5.5.24.geb27
