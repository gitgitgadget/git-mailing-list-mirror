From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] Add diff-option --ext-diff
Date: Sat, 30 Jun 2007 18:47:07 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0706301846580.4438@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Jun 30 19:47:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I4h2R-0001Zt-Mt
	for gcvg-git@gmane.org; Sat, 30 Jun 2007 19:47:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753993AbXF3RrO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 30 Jun 2007 13:47:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753925AbXF3RrN
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Jun 2007 13:47:13 -0400
Received: from mail.gmx.net ([213.165.64.20]:35285 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753742AbXF3RrM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jun 2007 13:47:12 -0400
Received: (qmail invoked by alias); 30 Jun 2007 17:47:10 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp042) with SMTP; 30 Jun 2007 19:47:10 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/N0NMIFQjNJEAtstQRiA9ZaIBRVHVS2k4LaIJvlu
	eV/CNMllgGP6ET
X-X-Sender: gene099@racer.site
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51232>


To prevent funky games with external diff engines, git-log and
friends prevent external diff engines from being called. That makes
sense in the context of git-format-patch or git-rebase.

However, for "git log -p" it is not so nice to get the message
that binary files cannot be compared, while "git diff" has no
problems with them, if you provided an external diff driver.

With this patch, "git log --ext-diff -p" will do what you expect,
and the option "--no-ext-diff" can be used to override that
setting.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Documentation/diff-options.txt |    8 ++++++++
 diff.c                         |    4 ++++
 2 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index 0f07c9c..3d2b9d0 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -168,5 +168,13 @@
 --quiet::
 	Disable all output of the program. Implies --exit-code.
 
+--ext-diff::
+	Allow an external diff helper to be executed. If you set an
+	external diff driver with gitlink:gitattributes(5), you need
+	to use this option with gitlink:git-log(1) and friends.
+
+--no-ext-diff::
+	Disallow external diff drivers.
+
 For more detailed explanation on these common options, see also
 link:diffcore.html[diffcore documentation].
diff --git a/diff.c b/diff.c
index e0edb98..a471c9e 100644
--- a/diff.c
+++ b/diff.c
@@ -2241,6 +2241,10 @@ int diff_opt_parse(struct diff_options *options, const char **av, int ac)
 		options->exit_with_status = 1;
 	else if (!strcmp(arg, "--quiet"))
 		options->quiet = 1;
+	else if (!strcmp(arg, "--ext-diff"))
+		options->allow_external = 1;
+	else if (!strcmp(arg, "--no-ext-diff"))
+		options->allow_external = 0;
 	else
 		return 0;
 	return 1;
-- 
1.5.2.2.3249.g33841
