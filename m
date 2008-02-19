From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: RE: [PATCH(TIC)] push: annoy all users by deprecating the default
 semantics
Date: Tue, 19 Feb 2008 16:41:28 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802191638520.30505@racer.site>
References: <E7DE807861E8474E8AC3DC7AC2C75EE50542F2F1@34093-EVS2C1.exchange.rackspace.com> <20080219043353.GA23239@sigill.intra.peff.net> <76718490802190509k20225092o66853916f48e08b1@mail.gmail.com> <20080219150826.GA24499@sigill.intra.peff.net>
 <76718490802190718t5e70abb2x8f96fc7154576594@mail.gmail.com> <20080219152549.GC24499@sigill.intra.peff.net> <alpine.LSU.1.00.0802191610480.30505@racer.site> <E7DE807861E8474E8AC3DC7AC2C75EE50542F7F6@34093-EVS2C1.exchange.rackspace.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jeff King <peff@peff.net>, Jay Soffian <jaysoffian@gmail.com>,
	git@vger.kernel.org
To: Jason Garber <jgarber@ionzoft.com>
X-From: git-owner@vger.kernel.org Tue Feb 19 17:42:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JRVY4-0007H7-Rr
	for gcvg-git-2@gmane.org; Tue, 19 Feb 2008 17:42:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753996AbYBSQlo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Feb 2008 11:41:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755180AbYBSQlo
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Feb 2008 11:41:44 -0500
Received: from mail.gmx.net ([213.165.64.20]:33212 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752944AbYBSQln (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Feb 2008 11:41:43 -0500
Received: (qmail invoked by alias); 19 Feb 2008 16:41:41 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp048) with SMTP; 19 Feb 2008 17:41:41 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19pOQEBKJ1phRs9o0Ox96wOQ69nKP/3R5ZoFDPn3Z
	BJFWfmE/yMdd0K
X-X-Sender: gene099@racer.site
In-Reply-To: <E7DE807861E8474E8AC3DC7AC2C75EE50542F7F6@34093-EVS2C1.exchange.rackspace.com>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74432>

Hi,

On Tue, 19 Feb 2008, Jason Garber wrote:

> +	if (!all && argc < 2)
> +		warning("Pushing without branch names is deprecated.\n"
> +			"Too many users just assumed what it should
> do\n"
> +			"according to them, got burned, and blamed
> us,\n"
> +			"the good git developers.\n\n"
> +			"So everybody has to suffer now, and get used
> to\n"
> +			"new semantics.\n\n"
> +			"Thank you for your time.\n");
> 
> 
> Quite accurate... lol.

Heh.  FWIW I think I might just go on with that patch, until those who 
_should_ care deeply enough about it shut me up with code...

Note that even if I vent here a bit, there's a good side to it: my patch 
should be a good start (actually, I think it is more than just a start, 
but hey, it's not like I want my patch to _really_ go into mainline).

This is my current state:

 Documentation/git-push.txt |   16 +++++++++++++---
 builtin-push.c             |   18 ++++++++++++++++++
 2 files changed, 31 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index 5f24944..d373d05 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -9,8 +9,10 @@ git-push - Update remote refs along with associated objects
 SYNOPSIS
 --------
 [verse]
-'git-push' [--all] [--dry-run] [--tags] [--receive-pack=<git-receive-pack>]
-           [--repo=all] [-f | --force] [-v | --verbose] [<repository> <refspec>...]
+'git-push' [--all] [-m | --matching] [--dry-run] [--tags]
+	   [--receive-pack=<git-receive-pack>]
+	   [--repo=all] [-f | --force] [-v | --verbose]
+	   [<repository> <refspec>...]
 
 DESCRIPTION
 -----------
@@ -49,7 +51,8 @@ Note: If no explicit refspec is found, (that is neither
 on the command line nor in any Push line of the
 corresponding remotes file---see below), then all the
 heads that exist both on the local side and on the remote
-side are updated.
+side are updated.  This behavior is DEPRECATED and will go
+away in the future.  Use the `--matching` option in the future.
 +
 `tag <tag>` means the same as `refs/tags/<tag>:refs/tags/<tag>`.
 +
@@ -63,6 +66,13 @@ the remote repository.
 	Instead of naming each ref to push, specifies that all
 	refs under `$GIT_DIR/refs/heads/` be pushed.
 
+-m, \--matching::
+	Push all refs that are present both locally and remotely.
+	This used to be the default action if no ref was specified,
+	until a few users who cannot read man pages prevailed in
+	their assumption that the default action should not be what
+	it was documented to be.
+
 \--mirror::
 	Instead of naming each ref to push, specifies that all
 	refs under `$GIT_DIR/refs/heads/` and `$GIT_DIR/refs/tags/`
diff --git a/builtin-push.c b/builtin-push.c
index c8cb63e..1194800 100644
--- a/builtin-push.c
+++ b/builtin-push.c
@@ -104,6 +104,7 @@ int cmd_push(int argc, const char **argv, const char *prefix)
 	int dry_run = 0;
 	int force = 0;
 	int tags = 0;
+	int matching = 0;
 	const char *repo = NULL;	/* default repository */
 
 	struct option options[] = {
@@ -117,6 +118,7 @@ int cmd_push(int argc, const char **argv, const char *prefix)
 		OPT_BOOLEAN( 0 , "thin", &thin, "use thin pack"),
 		OPT_STRING( 0 , "receive-pack", &receivepack, "receive-pack", "receive pack program"),
 		OPT_STRING( 0 , "exec", &receivepack, "receive-pack", "receive pack program"),
+		OPT_BOOLEAN('m', "matching", &matching, "push matching refs"),
 		OPT_END()
 	};
 
@@ -134,6 +136,22 @@ int cmd_push(int argc, const char **argv, const char *prefix)
 		flags |= TRANSPORT_PUSH_ALL;
 	if (mirror)
 		flags |= (TRANSPORT_PUSH_MIRROR|TRANSPORT_PUSH_FORCE);
+	if (all && argc > 1)
+		die ("Do you want to push explicit refs or --all?");
+	if (matching && all)
+		die ("--matching and --all are mutually exclusive");
+	if (matching && argc > 1)
+		die ("--matching and explicit refs are mutually exclusive");
+	if (!matching && !all && argc < 2)
+		warning("Pushing without branch names is deprecated.\n"
+			"Too many users just assumed what it should do\n"
+			"according to them, got burned, and blamed us,\n"
+			"the good git developers.\n\n"
+			"So everybody has to suffer now, and get used to\n"
+			"new semantics.\n\n"
+			"What used to be default will need the --matching\n"
+			"option in the future.\n\n"
+			"Thank you for your time.\n");
 
 	if (argc > 0) {
 		repo = argv[0];
