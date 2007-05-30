From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] Make git-k an alias to gitk
Date: Wed, 30 May 2007 04:03:53 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0705300402050.4011@racer.site>
References: <1dbc01c79432$b4400a80$0200a8c0@AMD2500>  <f3a2ke$9s7$1@sea.gmane.org>
 <465C064F.B9CE9379@eudaptics.com>  <465C1252.9020801@trolltech.com> 
 <Pine.LNX.4.64.0705291305540.4648@racer.site>  <465C2516.7040607@trolltech.com>
  <Pine.LNX.4.64.0705291446170.4648@racer.site>  <465C3502.BE134BC9@eudaptics.com>
  <fcaeb9bf0705290828j3703cfa9g11f2f7afb17a8c91@mail.gmail.com> 
 <465C4B0E.C34795B@eudaptics.com> <fcaeb9bf0705291145q6a0d276o6a94ded3c3e0b6d1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Sixt <J.Sixt@eudaptics.com>,
	Marius Storm-Olsen <marius@trolltech.com>, git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 30 05:05:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HtEVQ-0008WE-9q
	for gcvg-git@gmane.org; Wed, 30 May 2007 05:05:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750744AbXE3DFk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 29 May 2007 23:05:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750839AbXE3DFk
	(ORCPT <rfc822;git-outgoing>); Tue, 29 May 2007 23:05:40 -0400
Received: from mail.gmx.net ([213.165.64.20]:42808 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750744AbXE3DFk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 May 2007 23:05:40 -0400
Received: (qmail invoked by alias); 30 May 2007 03:05:38 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp035) with SMTP; 30 May 2007 05:05:38 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+JBYhGSROJ5RT4EdojT4IDJfvAU8BmPmGqr/MT01
	SU5bDOq8I1NLiT
X-X-Sender: gene099@racer.site
In-Reply-To: <fcaeb9bf0705291145q6a0d276o6a94ded3c3e0b6d1@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48728>


Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

On Tue, 29 May 2007, Nguyen Thai Ngoc Duy wrote:

	> On 5/29/07, Johannes Sixt <J.Sixt@eudaptics.com> wrote:
	> > Nguyen Thai Ngoc Duy wrote:
	> > > I'd suggest create a small C wrapper to launch gitk. It 
	> > > would be much easier that way IMHO.
	> > 
	> > Doh! You're right! It's even there already, right before our 
	> > eyes:
	> > 
	> > pointy..clicky..pointy..clicky  (aka: cp gitk git-k)
	> > 
	> > $ git k
	> > 
	> > :)
	> 
	> Maybe we should teach git.c to try gitk if git-k is not found ;)

	Something like this?

 Makefile |    2 +-
 git.c    |    6 ++++++
 2 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/Makefile b/Makefile
index 5f94630..01ab1ff 100644
--- a/Makefile
+++ b/Makefile
@@ -262,7 +262,7 @@ EXTRA_PROGRAMS =
 BUILT_INS = \
 	git-format-patch$X git-show$X git-whatchanged$X git-cherry$X \
 	git-get-tar-commit-id$X git-init$X git-repo-config$X \
-	git-fsck-objects$X git-cherry-pick$X \
+	git-fsck-objects$X git-cherry-pick$X git-k$X \
 	$(patsubst builtin-%.o,git-%$X,$(BUILTIN_OBJS))
 
 # what 'all' will build and 'install' will install, in gitexecdir
diff --git a/git.c b/git.c
index 04eb344..53d81e9 100644
--- a/git.c
+++ b/git.c
@@ -216,6 +216,11 @@ static int handle_alias(int *argcp, const char ***argv)
 	return ret;
 }
 
+static int cmd_gitk(int argc, const char **argv, const char *prefix)
+{
+	return execv("gitk", (char *const *)argv);
+}
+
 const char git_version_string[] = GIT_VERSION;
 
 #define RUN_SETUP	(1<<0)
@@ -274,6 +279,7 @@ static void handle_internal_command(int argc, const char **argv, char **envp)
 		{ "help", cmd_help },
 		{ "init", cmd_init_db },
 		{ "init-db", cmd_init_db },
+		{ "k", cmd_gitk },
 		{ "log", cmd_log, RUN_SETUP | USE_PAGER },
 		{ "ls-files", cmd_ls_files, RUN_SETUP },
 		{ "ls-tree", cmd_ls_tree, RUN_SETUP },
-- 
1.5.2.2641.g404de-dirty
