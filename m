From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v4] gc: call "prune --expire 2.weeks.ago" by default
Date: Wed, 12 Mar 2008 21:56:31 +0100 (CET)
Message-ID: <alpine.LSU.1.00.0803122156080.1656@racer.site>
References: <alpine.LSU.1.00.0803112157560.3873@racer.site> <7vskywadum.fsf@gitster.siamese.dyndns.org> <alpine.LFD.1.00.0803112234470.2947@xanadu.home> <alpine.LSU.1.00.0803121833210.1656@racer.site> <47D8193B.901@nrlssc.navy.mil> <m3prtzyens.fsf@localhost.localdomain>
 <47D83532.70103@nrlssc.navy.mil> <alpine.LSU.1.00.0803122058430.1656@racer.site> <47D83C53.7000602@nrlssc.navy.mil> <7vejaf65q0.fsf@gitster.siamese.dyndns.org> <alpine.LSU.1.00.0803122153440.1656@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Brandon Casey <casey@nrlssc.navy.mil>,
	Jakub Narebski <jnareb@gmail.com>,
	Nicolas Pitre <nico@cam.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 12 21:57:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZY0X-0000G5-6g
	for gcvg-git-2@gmane.org; Wed, 12 Mar 2008 21:57:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752131AbYCLU40 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Mar 2008 16:56:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752075AbYCLU4Z
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Mar 2008 16:56:25 -0400
Received: from mail.gmx.net ([213.165.64.20]:55630 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752051AbYCLU4Z (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Mar 2008 16:56:25 -0400
Received: (qmail invoked by alias); 12 Mar 2008 20:56:23 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp041) with SMTP; 12 Mar 2008 21:56:23 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+Szd0KAj+StbHTQKLJgRdqwJQeqMeBQMGTaTQGAL
	9nb38IxrXeGeDd
X-X-Sender: gene099@racer.site
In-Reply-To: <alpine.LSU.1.00.0803122153440.1656@racer.site>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76988>

And here is the interdiff:

 Documentation/config.txt |    5 ++---
 Documentation/git-gc.txt |   23 +++++------------------
 builtin-gc.c             |    9 ++-------
 3 files changed, 9 insertions(+), 28 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index db5b2dc..a2f1df2 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -591,9 +591,8 @@ gc.packrefs::
 	prevent `git pack-refs` from being run from `git gc`.
 
 gc.pruneexpire::
-	When `git gc` is run without `--prune`, it will still call
-	`prune`, but with `--expire 2.weeks.ago`.  Override the value
-	with this config variable.
+	When `git gc` is run, it will call `prune --expire 2.weeks.ago`.
+	Override the grace period with this config variable.
 
 gc.reflogexpire::
 	`git reflog expire` removes reflog entries older than
diff --git a/Documentation/git-gc.txt b/Documentation/git-gc.txt
index 2042d9f..229a7c9 100644
--- a/Documentation/git-gc.txt
+++ b/Documentation/git-gc.txt
@@ -8,7 +8,7 @@ git-gc - Cleanup unnecessary files and optimize the local repository
 
 SYNOPSIS
 --------
-'git-gc' [--prune] [--aggressive] [--auto] [--quiet]
+'git-gc' [--aggressive] [--auto] [--quiet]
 
 DESCRIPTION
 -----------
@@ -25,23 +25,6 @@ operating performance. Some git commands may automatically run
 OPTIONS
 -------
 
---prune::
-	Usually `git-gc` packs refs, expires old reflog entries,
-	packs loose objects,
-	and removes old 'rerere' records.  Unilateral removal
-	of unreferenced loose objects is an unsafe operation
-	while other git operations are in progress, so it is not
-	done by default.
-+
-Instead, `git-prune` is called with an option telling it to expire
-only unreferenced loose objects that are at least 2 weeks old.  Set
-the config variable `gc.pruneexpire` to override this grace period.
-+
-Pass `--prune` to expire all unreferenced loose objects, but only
-when you know nobody else is creating new objects in the
-repository at the same time (e.g. never use this option
-in a cron script).
-
 --aggressive::
 	Usually 'git-gc' runs very quickly while providing good disk
 	space utilization and performance.  This option will cause
@@ -110,6 +93,10 @@ the value, the more time is spent optimizing the delta compression.  See
 the documentation for the --window' option in linkgit:git-repack[1] for
 more details.  This defaults to 10.
 
+The optional configuration variable 'gc.pruneExpire' controls how old
+the unreferenced loose objects have to be before they are pruned.  The
+default is "2 weeks ago".
+
 See Also
 --------
 linkgit:git-prune[1]
diff --git a/builtin-gc.c b/builtin-gc.c
index 9663fae..8bd54d8 100644
--- a/builtin-gc.c
+++ b/builtin-gc.c
@@ -32,7 +32,7 @@ static char *prune_expire = "2.weeks.ago";
 static const char *argv_pack_refs[] = {"pack-refs", "--all", "--prune", NULL};
 static const char *argv_reflog[] = {"reflog", "expire", "--all", NULL};
 static const char *argv_repack[MAX_ADD] = {"repack", "-d", "-l", NULL};
-static const char *argv_prune[] = {"prune", NULL, NULL, NULL};
+static const char *argv_prune[] = {"prune", "--expire", NULL, NULL};
 static const char *argv_rerere[] = {"rerere", "gc", NULL};
 
 static int gc_config(const char *var, const char *value)
@@ -245,12 +245,7 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
 	if (run_command_v_opt(argv_repack, RUN_GIT_CMD))
 		return error(FAILED_RUN, argv_repack[0]);
 
-	if (!prune) {
-		argv_prune[1] = "--expire";
-		argv_prune[2] = prune_expire;
-		argv_prune[3] = NULL;
-	}
-
+	argv_prune[2] = prune_expire;
 	if (run_command_v_opt(argv_prune, RUN_GIT_CMD))
 		return error(FAILED_RUN, argv_prune[0]);
 
