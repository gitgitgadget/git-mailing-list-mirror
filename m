From: Jonas Fonseca <fonseca@diku.dk>
Subject: [PATCH 1/7] git-apply(1): document missing options and improve existing ones
Date: Fri, 25 Aug 2006 02:56:55 +0200
Message-ID: <20060825005655.GB4069@diku.dk>
References: <20060818084545.GB4717@diku.dk> <7virkqbcq3.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 25 02:57:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GGQ0k-0003ze-FP
	for gcvg-git@gmane.org; Fri, 25 Aug 2006 02:57:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932243AbWHYA5E (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 24 Aug 2006 20:57:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932261AbWHYA5E
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Aug 2006 20:57:04 -0400
Received: from [130.225.96.91] ([130.225.96.91]:18884 "EHLO mgw1.diku.dk")
	by vger.kernel.org with ESMTP id S932243AbWHYA5B (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 24 Aug 2006 20:57:01 -0400
Received: from localhost (localhost [127.0.0.1])
	by mgw1.diku.dk (Postfix) with ESMTP id CC9A2770079;
	Fri, 25 Aug 2006 02:56:57 +0200 (CEST)
Received: from mgw1.diku.dk ([127.0.0.1])
 by localhost (mgw1.diku.dk [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 26103-08; Fri, 25 Aug 2006 02:56:55 +0200 (CEST)
Received: from nhugin.diku.dk (nhugin.diku.dk [130.225.96.140])
	by mgw1.diku.dk (Postfix) with ESMTP id DFFFC770076;
	Fri, 25 Aug 2006 02:56:55 +0200 (CEST)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP
	id BFFA86DF89F; Fri, 25 Aug 2006 02:55:37 +0200 (CEST)
Received: by ask.diku.dk (Postfix, from userid 3873)
	id C2DF0629FB; Fri, 25 Aug 2006 02:56:55 +0200 (CEST)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7virkqbcq3.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.6i
X-Virus-Scanned: amavisd-new at diku.dk
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25984>

Signed-off-by: Jonas Fonseca <fonseca@diku.dk>
---
 Documentation/git-apply.txt |   45 ++++++++++++++++++++++++++++++++-----------
 1 files changed, 33 insertions(+), 12 deletions(-)

Junio C Hamano <junkio@cox.net> wrote Fri, Aug 18, 2006:
> Jonas Fonseca <fonseca@diku.dk> writes:
> > [ On top of next if that matters. ]
> 
> I'd appreciate if you can hold this off for a while;
> I'll be updating git-apply a bit further [...]

I don't know if it's been a while, but I see that some of the changes
you mentioned has migrated to 'next', so here's an updated patch plus
a few other documentation updates that I did in the train today.

Changes to the former patch includes adding --verbose description and
removing the part about subdirectories from the patch.

> > I'm not sure if I got the --exclude note right, which says that
> > running apply from a subdirectory automatically excludes files
> > outside the subdirectory.
> 
> I was thinking about dropping the exclude altogether, actually.

It does sound a bit special and mostly suited for batch work.

diff --git a/Documentation/git-apply.txt b/Documentation/git-apply.txt
index 11641a9..20e12ce 100644
--- a/Documentation/git-apply.txt
+++ b/Documentation/git-apply.txt
@@ -10,10 +10,10 @@ SYNOPSIS
 --------
 [verse]
 'git-apply' [--stat] [--numstat] [--summary] [--check] [--index] [--apply]
-	  [--no-add] [--index-info] [--allow-binary-replacement]
-	  [--reverse] [--reject] [-z] [-pNUM]
-	  [-CNUM] [--whitespace=<nowarn|warn|error|error-all|strip>]
-	  [<patch>...]
+	  [--no-add] [--index-info] [--allow-binary-replacement | --binary]
+	  [-R | --reverse] [--reject] [-z] [-pNUM] [-CNUM] [--inaccurate-eof]
+	  [--whitespace=<nowarn|warn|error|error-all|strip>] [--exclude=PATH]
+	  [--cached] [--verbose] [<patch>...]
 
 DESCRIPTION
 -----------
@@ -56,6 +56,11 @@ OPTIONS
 	up-to-date, it is flagged as an error.  This flag also
 	causes the index file to be updated.
 
+--cached::
+	Apply a patch without touching the working tree. Instead, take the
+	cached data, apply the patch, and store the result in the index,
+	without using the working tree. This implies '--index'.
+
 --index-info::
 	Newer git-diff output has embedded 'index information'
 	for each blob to help identify the original version that
@@ -63,14 +68,14 @@ OPTIONS
 	the original version of the blob is available locally,
 	outputs information about them to the standard output.
 
---reverse::
+-R, --reverse::
 	Apply the patch in reverse.
 
 --reject::
-	For atomicity, `git apply` fails the whole patch and
+	For atomicity, gitlink:git-apply[1] by default fails the whole patch and
 	does not touch the working tree when some of the hunks
-	do not apply by default.  This option makes it apply
-	parts of the patch that are applicable, and send the
+	do not apply.  This option makes it apply
+	the parts of the patch that are applicable, and send the
 	rejected hunks to the standard output of the command.
 
 -z::
@@ -91,8 +96,8 @@ OPTIONS
 	ever ignored.
 
 --apply::
-	If you use any of the options marked ``Turns off
-	"apply"'' above, git-apply reads and outputs the
+	If you use any of the options marked "Turns off
+	'apply'" above, gitlink:git-apply[1] reads and outputs the
 	information you asked without actually applying the
 	patch.  Give this flag after those flags to also apply
 	the patch.
@@ -104,7 +109,7 @@ OPTIONS
 	the result with this option, which would apply the
 	deletion part but not addition part.
 
---allow-binary-replacement::
+--allow-binary-replacement, --binary::
 	When applying a patch, which is a git-enhanced patch
 	that was prepared to record the pre- and post-image object
 	name in full, and the path being patched exactly matches
@@ -115,13 +120,18 @@ OPTIONS
 	result.  This allows binary files to be patched in a
 	very limited way.
 
+--exclude=<path-pattern>::
+	Don't apply changes to files matching the given path pattern. This can
+	be useful when importing patchsets, where you want to exclude certain
+	files or directories.
+
 --whitespace=<option>::
 	When applying a patch, detect a new or modified line
 	that ends with trailing whitespaces (this includes a
 	line that solely consists of whitespaces).  By default,
 	the command outputs warning messages and applies the
 	patch.
-	When `git-apply` is used for statistics and not applying a
+	When gitlink:git-apply[1] is used for statistics and not applying a
 	patch, it defaults to `nowarn`.
 	You can use different `<option>` to control this
 	behavior:
@@ -135,6 +145,17 @@ OPTIONS
 * `strip` outputs warnings for a few such errors, strips out the
   trailing whitespaces and applies the patch.
 
+--inacurate-eof::
+	Under certain circumstances, some versions of diff do not correctly
+	detect a missing new-line at the end of the file. As a result, patches
+	created by such diff programs do not record incomplete lines
+	correctly. This option adds support for applying such patches by
+	working around this bug.
+
+--verbose::
+	Report progress to stderr. By default, only a message about the
+	current patch being applied will be printed. This option will cause
+	additional information to be reported.
 
 Configuration
 -------------
-- 
1.4.2.GIT


-- 
Jonas Fonseca
