From: Scott R Parish <srp@srparish.net>
Subject: [PATCH 7/7] shell should call the new setup_path() to setup $PATH
Date: Sat, 27 Oct 2007 01:36:55 -0700
Message-ID: <1193474215-6728-7-git-send-email-srp@srparish.net>
References: <1193474215-6728-1-git-send-email-srp@srparish.net>
 <1193474215-6728-2-git-send-email-srp@srparish.net>
 <1193474215-6728-3-git-send-email-srp@srparish.net>
 <1193474215-6728-4-git-send-email-srp@srparish.net>
 <1193474215-6728-5-git-send-email-srp@srparish.net>
 <1193474215-6728-6-git-send-email-srp@srparish.net>
Cc: Scott R Parish <srp@srparish.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 27 10:37:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IlhB2-00089y-7f
	for gcvg-git-2@gmane.org; Sat, 27 Oct 2007 10:37:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752172AbXJ0IhN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Oct 2007 04:37:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751976AbXJ0IhL
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Oct 2007 04:37:11 -0400
Received: from smtp-gw5.mailanyone.net ([208.70.128.56]:45298 "EHLO
	smtp-gw5.mailanyone.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751653AbXJ0Ig7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Oct 2007 04:36:59 -0400
Received: from mailanyone.net
	by smtp-gw5.mailanyone.net with esmtp (MailAnyone extSMTP srp)
	id 1IlhAA-000575-FG; Sat, 27 Oct 2007 03:36:58 -0500
Received: by maple.srparish.net (Postfix, from userid 501)
	id C38834F21D1; Sat, 27 Oct 2007 01:36:56 -0700 (PDT)
X-Mailer: git-send-email gitgui.0.8.4.11179.g60ba
In-Reply-To: <1193474215-6728-6-git-send-email-srp@srparish.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62477>

Shell currently does its own manual thing for setting up the $PATH;
it can now call setup_path().

Signed-off-by: Scott R Parish <srp@srparish.net>
---
 shell.c |    8 +-------
 1 files changed, 1 insertions(+), 7 deletions(-)

diff --git a/shell.c b/shell.c
index cfe372b..9826109 100644
--- a/shell.c
+++ b/shell.c
@@ -24,17 +24,11 @@ static int do_cvs_cmd(const char *me, char *arg)
 	const char *cvsserver_argv[3] = {
 		"cvsserver", "server", NULL
 	};
-	const char *oldpath = getenv("PATH");
-	struct strbuf newpath = STRBUF_INIT;
 
 	if (!arg || strcmp(arg, "server"))
 		die("git-cvsserver only handles server: %s", arg);
 
-	strbuf_addstr(&newpath, git_exec_path());
-	strbuf_addch(&newpath, ':');
-	strbuf_addstr(&newpath, oldpath);
-
-	setenv("PATH", strbuf_detach(&newpath, NULL), 1);
+	setup_path(NULL);
 
 	return execv_git_cmd(cvsserver_argv);
 }
-- 
gitgui.0.8.4.11178.g9a1bf-dirty
