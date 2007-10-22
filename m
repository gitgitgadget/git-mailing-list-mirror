From: Scott R Parish <srp@srparish.net>
Subject: [PATCH] "git" calls help_unknown_cmd(""); "git help" and "git help
	-a" return 0
Date: Mon, 22 Oct 2007 01:32:39 -0700
Message-ID: <20071022083239.GA23428@srparish.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 22 10:32:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IjsiS-0004q6-FU
	for gcvg-git-2@gmane.org; Mon, 22 Oct 2007 10:32:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750964AbXJVIcm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Oct 2007 04:32:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751309AbXJVIcl
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Oct 2007 04:32:41 -0400
Received: from smtp-gw7.mailanyone.net ([208.70.128.55]:55609 "EHLO
	smtp-gw7.mailanyone.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750937AbXJVIcl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Oct 2007 04:32:41 -0400
Received: from mailanyone.net
	by smtp-gw7.mailanyone.net with esmtps (TLSv1:AES256-SHA:256)
	(MailAnyone extSMTP srp)
	id 1IjsiG-0001hT-1B
	for git@vger.kernel.org; Mon, 22 Oct 2007 03:32:40 -0500
Received: by srparish.net (nbSMTP-1.00) for uid 502
	(using TLSv1/SSLv3 with cipher AES256-SHA (256/256 bits))
	srp@srparish.net; Mon, 22 Oct 2007 01:32:40 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.15 (2007-04-06)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61971>

Signed-off-by: Scott R Parish <srp@srparish.net>
---
 git.c  |    5 ++---
 help.c |    4 ++--
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/git.c b/git.c
index 853e66c..e1c99e3 100644
--- a/git.c
+++ b/git.c
@@ -445,9 +445,8 @@ int main(int argc, const char **argv)
 		if (!prefixcmp(argv[0], "--"))
 			argv[0] += 2;
 	} else {
-		/* Default command: "help" */
-		argv[0] = "help";
-		argc = 1;
+		/* The user didn't specify a command; give them help */
+		help_unknown_cmd("");
 	}
 	cmd = argv[0];
 
diff --git a/help.c b/help.c
index 1cd33ec..b0d2dd4 100644
--- a/help.c
+++ b/help.c
@@ -204,14 +204,14 @@ int cmd_help(int argc, const char **argv, const char *prefix)
 	if (!help_cmd) {
 		printf("usage: %s\n\n", git_usage_string);
 		list_common_cmds_help();
-		exit(1);
+		exit(0);
 	}
 
 	else if (!strcmp(help_cmd, "--all") || !strcmp(help_cmd, "-a")) {
 		printf("usage: %s\n\n", git_usage_string);
 		if(exec_path)
 			list_commands(exec_path, "git-*");
-		exit(1);
+		exit(0);
 	}
 
 	else
-- 
1.5.3.4.209.g5d1ce-dirty
