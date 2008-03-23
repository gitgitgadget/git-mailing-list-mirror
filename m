From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 2/2] git-init: set receive.guardCurrentBranch = true for
 non-bare repositories
Date: Sun, 23 Mar 2008 21:44:20 +0100 (CET)
Message-ID: <alpine.LSU.1.00.0803232144070.4353@racer.site>
References: <alpine.LSU.1.00.0803232142460.4353@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Mar 23 21:45:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JdX42-0005p3-Vg
	for gcvg-git-2@gmane.org; Sun, 23 Mar 2008 21:45:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754475AbYCWUoZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Mar 2008 16:44:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754354AbYCWUoZ
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Mar 2008 16:44:25 -0400
Received: from mail.gmx.net ([213.165.64.20]:51389 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754185AbYCWUoY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Mar 2008 16:44:24 -0400
Received: (qmail invoked by alias); 23 Mar 2008 20:44:23 -0000
Received: from host86-148-26-43.range86-148.btcentralplus.com (EHLO racer.home) [86.148.26.43]
  by mail.gmx.net (mp037) with SMTP; 23 Mar 2008 21:44:23 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18Og0l0clwOw7ylaD5dwcwDjnMP+LoXqVGgAL2vGP
	J7fiR7RbGOi3v0
X-X-Sender: gene099@racer.site
In-Reply-To: <alpine.LSU.1.00.0803232142460.4353@racer.site>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77956>


When initializing a non-bare repositories, you most likely want to avoid
pushing into the current branch (because a push does not touch the
working tree at all).

Let's be nice to those users who have not read that part of the
manual, and just outright refuse updating the current branch.

To be nice to those users who wrote that part of the manual, let's do
that in git-init, so that existing repositories are not affected.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Documentation/git-init.txt |    4 ++++
 builtin-init-db.c          |    1 +
 2 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-init.txt b/Documentation/git-init.txt
index 62914da..03a4f0e 100644
--- a/Documentation/git-init.txt
+++ b/Documentation/git-init.txt
@@ -56,6 +56,10 @@ By default, the configuration flag receive.denyNonFastForwards is enabled
 in shared repositories, so that you cannot force a non fast-forwarding push
 into it.
 
+If you are initializing a non-bare repository, the config variable
+`receive.guardCurrentBranch` is set to true.  This avoids problems with
+pushing into the current branch, which does not touch the working tree.
+
 --
 
 
diff --git a/builtin-init-db.c b/builtin-init-db.c
index 4f93d03..4542054 100644
--- a/builtin-init-db.c
+++ b/builtin-init-db.c
@@ -243,6 +243,7 @@ static int create_default_files(const char *template_path)
 	else {
 		const char *work_tree = get_git_work_tree();
 		git_config_set("core.bare", "false");
+		git_config_set("receive.guardCurrentBranch", "true");
 		/* allow template config file to override the default */
 		if (log_all_ref_updates == -1)
 		    git_config_set("core.logallrefupdates", "true");
-- 
1.5.5.rc1.174.g591a9
