From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [wishlist] graphical diff
Date: Mon, 19 Mar 2007 00:09:06 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0703182342110.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <1174223784.5987.6.camel@localhost> <200703181606.20678.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1148973799-385039752-1174259346=:22628"
Cc: Raimund Bauer <ray007@gmx.net>, git <git@vger.kernel.org>
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Mon Mar 19 00:09:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HT4VC-0004Rf-IQ
	for gcvg-git@gmane.org; Mon, 19 Mar 2007 00:09:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933368AbXCRXJM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 18 Mar 2007 19:09:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751722AbXCRXJM
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Mar 2007 19:09:12 -0400
Received: from mail.gmx.net ([213.165.64.20]:44302 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750740AbXCRXJL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Mar 2007 19:09:11 -0400
Received: (qmail invoked by alias); 18 Mar 2007 23:09:09 -0000
X-Provags-ID: V01U2FsdGVkX18HyNo8OPsH+CJCJm9FLFcPlph8UYwbIexrafzQ4k
	jrXKpM3jXLXLzT
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <200703181606.20678.robin.rosenberg.lists@dewire.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42539>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1148973799-385039752-1174259346=:22628
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT

Hi,

On Sun, 18 Mar 2007, Robin Rosenberg wrote:

> söndag 18 mars 2007 14:16 skrev Raimund Bauer:
> > I think it would be really helpful (especially for newbies like me) to
> > have an option like
> > 
> > git diff --gui [revisions] <singe path spec>

And how do you set _what_ gui you want? Everybody has her pet diff-viewer 
(mine is less, BTW).

> Fine, except it is not likely to be my favourite gui. But you don't have 
> to wait, you can get a gui easily today.
>
> [...] 
> 
> git diff HEAD^..HEAD | kompare -

BTW here, "kompare -" does not work as expected. It shows an empty diff. 
At any rate, have you tried something like "GIT_PAGER='kompare -' git diff 
HEAD^..HEAD"?

This reminds me that I always wanted to be able to set the pager from the 
command line, so I can set an alias easily:

-- snipsnap --
[PATCH] Allow setting the pager from the command line

The command `git` already allows piping the output into a pager with
`-p`. Now also allow to set the pager with `-p=<pager-cmd>`.

With this, it is possible to make an alias of command/pager combos, like
this:

	$ git config alias.showmore '-p=more show'

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Documentation/git.txt |    8 +++++---
 git.c                 |    7 ++++++-
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/Documentation/git.txt b/Documentation/git.txt
index 0b1203e..5634b30 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -9,7 +9,7 @@ git - the stupid content tracker
 SYNOPSIS
 --------
 [verse]
-'git' [--version] [--exec-path[=GIT_EXEC_PATH]] [-p|--paginate]
+'git' [--version] [--exec-path[=GIT_EXEC_PATH]] [-p|--paginate][=<pager-cmd>]
 	[-n|--name-rev] [-t|--name-rev-by-tags] [--bare]
 	[--git-dir=GIT_DIR] [--help] COMMAND [ARGS]
 
@@ -75,8 +75,10 @@ OPTIONS
 	environment variable. If no path is given 'git' will print
 	the current setting and then exit.
 
--p|--paginate::
-	Pipe all output into 'less' (or if set, $PAGER).
+-p|--paginate[=<pager-cmd>]::
+	Pipe all output into 'less'. You can override this by
+	"=<pager-cmd>", or setting the environment variables $GIT_PAGER
+	or $PAGER (in that order).
 
 -n|--name-rev:
 	Try naming all SHA1s, and page the result (see
diff --git a/git.c b/git.c
index fca1dfb..76b126d 100644
--- a/git.c
+++ b/git.c
@@ -4,7 +4,7 @@
 #include "quote.h"
 
 const char git_usage_string[] =
-	"git [--version] [--exec-path[=GIT_EXEC_PATH]] [-p|--paginate] [--bare] [--git-dir=GIT_DIR] [--help] COMMAND [ARGS]";
+	"git [--version] [--exec-path[=GIT_EXEC_PATH]] [-p|--paginate][=pager_cmd] [--bare] [--git-dir=GIT_DIR] [--help] COMMAND [ARGS]";
 
 static void prepend_to_path(const char *dir, int len)
 {
@@ -58,6 +58,11 @@ static int handle_options(const char*** argv, int* argc)
 			}
 		} else if (!strcmp(cmd, "-p") || !strcmp(cmd, "--paginate")) {
 			setup_pager();
+		} else if (!prefixcmp(cmd, "-p=") ||
+				!prefixcmp(cmd, "--paginate=")) {
+			const char *equal = strchr(cmd, '=');
+			setenv("GIT_PAGER", equal + 1, 1);
+			setup_pager();
 		} else if (!strcmp(cmd, "-n") || !strcmp(cmd, "--name-rev"))
 			setup_name_rev_pager(0);
 		else if (!strcmp(cmd, "-t") ||
-- 
1.5.0.4.2713.g4ff1

---1148973799-385039752-1174259346=:22628--
