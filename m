From: John Keeping <john@keeping.me.uk>
Subject: [RFC/PATCH] rev-parse(1): logically group options
Date: Thu, 18 Jul 2013 20:07:29 +0100
Message-ID: <8ab5f3c276e6f623a8056674c9306334efc9fefe.1374174438.git.john@keeping.me.uk>
Cc: John Keeping <john@keeping.me.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 18 21:07:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UztYJ-00063s-6E
	for gcvg-git-2@plane.gmane.org; Thu, 18 Jul 2013 21:07:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964885Ab3GRTHm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jul 2013 15:07:42 -0400
Received: from jackal.aluminati.org ([72.9.247.210]:52933 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964817Ab3GRTHl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jul 2013 15:07:41 -0400
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id 08C2ACDA563;
	Thu, 18 Jul 2013 20:07:41 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -12.899
X-Spam-Level: 
X-Spam-Status: No, score=-12.899 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9,
	URIBL_BLOCKED=0.001] autolearn=ham
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MvG0d1OBJuy3; Thu, 18 Jul 2013 20:07:38 +0100 (BST)
Received: from river.lan (tg1.aluminati.org [10.0.16.53])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id AF758CDA5B3;
	Thu, 18 Jul 2013 20:07:34 +0100 (BST)
X-Mailer: git-send-email 1.8.3.3.972.gc83849e.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230723>

The options section of the git-rev-parse manual page has grown
organically so that there now does not seem to be much logic behind the
ordering of the options.  It also does not make it clear that certain
options must appear first on the command line.

Address this by reorganising the options into groups with subheadings.
The text of option descriptions does not change.

Signed-off-by: John Keeping <john@keeping.me.uk>
---
 Documentation/git-rev-parse.txt | 104 +++++++++++++++++++++++-----------------
 1 file changed, 61 insertions(+), 43 deletions(-)

diff --git a/Documentation/git-rev-parse.txt b/Documentation/git-rev-parse.txt
index 993903c..fa284b0 100644
--- a/Documentation/git-rev-parse.txt
+++ b/Documentation/git-rev-parse.txt
@@ -24,9 +24,35 @@ distinguish between them.
 
 OPTIONS
 -------
+
+Operation Modes
+~~~~~~~~~~~~~~~
+
+Each of these options must appear first on the command line.
+
+--local-env-vars::
+	List the GIT_* environment variables that are local to the
+	repository (e.g. GIT_DIR or GIT_WORK_TREE, but not GIT_EDITOR).
+	Only the names of the variables are listed, not their value,
+	even if they are set.
+
 --parseopt::
 	Use 'git rev-parse' in option parsing mode (see PARSEOPT section below).
 
+--resolve-git-dir <path>::
+	Check if <path> is a valid repository or a gitfile that
+	points at a valid repository, and print the location of the
+	repository.  If <path> is a gitfile then the resolved path
+	to the real repository is printed.
+
+--sq-quote::
+	Use 'git rev-parse' in shell quoting mode (see SQ-QUOTE
+	section below). In contrast to the `--sq` option below, this
+	mode does only quoting. Nothing else is done to command input.
+
+Options for --parseopt
+~~~~~~~~~~~~~~~~~~~~~~
+
 --keep-dashdash::
 	Only meaningful in `--parseopt` mode. Tells the option parser to echo
 	out the first `--` met instead of skipping it.
@@ -36,10 +62,8 @@ OPTIONS
 	the first non-option argument.  This can be used to parse sub-commands
 	that take options themselves.
 
---sq-quote::
-	Use 'git rev-parse' in shell quoting mode (see SQ-QUOTE
-	section below). In contrast to the `--sq` option below, this
-	mode does only quoting. Nothing else is done to command input.
+Options for Filtering
+~~~~~~~~~~~~~~~~~~~~~
 
 --revs-only::
 	Do not output flags and parameters not meant for
@@ -55,6 +79,9 @@ OPTIONS
 --no-flags::
 	Do not output flag parameters.
 
+Options for Output
+~~~~~~~~~~~~~~~~~~
+
 --default <arg>::
 	If there is no parameter given by the user, use `<arg>`
 	instead.
@@ -110,6 +137,17 @@ can be used.
 	strip '{caret}' prefix from the object names that already have
 	one.
 
+--abbrev-ref[=(strict|loose)]::
+	A non-ambiguous short name of the objects name.
+	The option core.warnAmbiguousRefs is used to select the strict
+	abbreviation mode.
+
+--short::
+--short=number::
+	Instead of outputting the full SHA-1 values of object names try to
+	abbreviate them to a shorter unique name. When no length is specified
+	7 is used. The minimum length is 4.
+
 --symbolic::
 	Usually the object names are output in SHA-1 form (with
 	possible '{caret}' prefix); this option makes them output in a
@@ -123,16 +161,8 @@ can be used.
 	unfortunately named tag "master"), and show them as full
 	refnames (e.g. "refs/heads/master").
 
---abbrev-ref[=(strict|loose)]::
-	A non-ambiguous short name of the objects name.
-	The option core.warnAmbiguousRefs is used to select the strict
-	abbreviation mode.
-
---disambiguate=<prefix>::
-	Show every object whose name begins with the given prefix.
-	The <prefix> must be at least 4 hexadecimal digits long to
-	avoid listing each and every object in the repository by
-	mistake.
+Options for Input
+~~~~~~~~~~~~~~~~~
 
 --all::
 	Show all refs found in `refs/`.
@@ -155,18 +185,11 @@ shown.  If the pattern does not contain a globbing character (`?`,
 	character (`?`, `*`, or `[`), it is turned into a prefix
 	match by appending `/*`.
 
---show-toplevel::
-	Show the absolute path of the top-level directory.
-
---show-prefix::
-	When the command is invoked from a subdirectory, show the
-	path of the current directory relative to the top-level
-	directory.
-
---show-cdup::
-	When the command is invoked from a subdirectory, show the
-	path of the top-level directory relative to the current
-	directory (typically a sequence of "../", or an empty string).
+--disambiguate=<prefix>::
+	Show every object whose name begins with the given prefix.
+	The <prefix> must be at least 4 hexadecimal digits long to
+	avoid listing each and every object in the repository by
+	mistake.
 
 --git-dir::
 	Show `$GIT_DIR` if defined. Otherwise show the path to
@@ -177,6 +200,14 @@ If `$GIT_DIR` is not defined and the current directory
 is not detected to lie in a Git repository or work tree
 print a message to stderr and exit with nonzero status.
 
+--show-toplevel::
+	Show the absolute path of the top-level directory.
+
+--show-cdup::
+	When the command is invoked from a subdirectory, show the
+	path of the top-level directory relative to the current
+	directory (typically a sequence of "../", or an empty string).
+
 --is-inside-git-dir::
 	When the current working directory is below the repository
 	directory print "true", otherwise "false".
@@ -188,17 +219,10 @@ print a message to stderr and exit with nonzero status.
 --is-bare-repository::
 	When the repository is bare print "true", otherwise "false".
 
---local-env-vars::
-	List the GIT_* environment variables that are local to the
-	repository (e.g. GIT_DIR or GIT_WORK_TREE, but not GIT_EDITOR).
-	Only the names of the variables are listed, not their value,
-	even if they are set.
-
---short::
---short=number::
-	Instead of outputting the full SHA-1 values of object names try to
-	abbreviate them to a shorter unique name. When no length is specified
-	7 is used. The minimum length is 4.
+--show-prefix::
+	When the command is invoked from a subdirectory, show the
+	path of the current directory relative to the top-level
+	directory.
 
 --since=datestring::
 --after=datestring::
@@ -213,12 +237,6 @@ print a message to stderr and exit with nonzero status.
 <args>...::
 	Flags and parameters to be parsed.
 
---resolve-git-dir <path>::
-	Check if <path> is a valid repository or a gitfile that
-	points at a valid repository, and print the location of the
-	repository.  If <path> is a gitfile then the resolved path
-	to the real repository is printed.
-
 
 include::revisions.txt[]
 
-- 
1.8.3.3.972.gc83849e.dirty
