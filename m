From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] Document custom hunk header selection
Date: Sun, 08 Jul 2007 17:14:19 -0700
Message-ID: <7vir8uzb50.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 09 02:14:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I7gtd-0001AL-LQ
	for gcvg-git@gmane.org; Mon, 09 Jul 2007 02:14:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753953AbXGIAOV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 8 Jul 2007 20:14:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751280AbXGIAOV
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Jul 2007 20:14:21 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:43661 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753221AbXGIAOU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Jul 2007 20:14:20 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070709001419.FTMA3098.fed1rmmtao106.cox.net@fed1rmimpo01.cox.net>;
          Sun, 8 Jul 2007 20:14:19 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id MCEK1X0051kojtg0000000; Sun, 08 Jul 2007 20:14:19 -0400
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51936>

Since the external interface seems to have stabilized for this
new feature, let's document it properly.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/gitattributes.txt |   55 ++++++++++++++++++++++++++++++++++++---
 1 files changed, 51 insertions(+), 4 deletions(-)

diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index d3ac9c7..810df07 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -72,8 +72,8 @@ EFFECTS
 -------
 
 Certain operations by git can be influenced by assigning
-particular attributes to a path.  Currently, three operations
-are attributes-aware.
+particular attributes to a path.  Currently, the following
+operations are attributes-aware.
 
 Checking-out and checking-in
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
@@ -199,7 +199,9 @@ Generating diff text
 ~~~~~~~~~~~~~~~~~~~~
 
 The attribute `diff` affects if `git diff` generates textual
-patch for the path or just says `Binary files differ`.
+patch for the path or just says `Binary files differ`.  It also
+can affect what line is shown on the hunk header `@@ -k,l +n,m @@`
+line.
 
 Set::
 
@@ -224,7 +226,8 @@ String::
 	Diff is shown using the specified custom diff driver.
 	The driver program is given its input using the same
 	calling convention as used for GIT_EXTERNAL_DIFF
-	program.
+	program.  This name is also used for custom hunk header
+	selection.
 
 
 Defining a custom diff driver
@@ -249,6 +252,50 @@ parameters, just like `GIT_EXTERNAL_DIFF` program is called.
 See gitlink:git[7] for details.
 
 
+Defining a custom hunk-header
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+Each group of changes (called "hunk") in the textual diff output
+is prefixed with a line of the form:
+
+	@@ -k,l +n,m @@ TEXT
+
+The text is called 'hunk header', and by default a line that
+begins with an alphabet, an underscore or a dollar sign is used,
+which matches what GNU `diff -p` output uses.  This default
+selection however is not suited for some contents, and you can
+use customized pattern to make a selection.
+
+First in .gitattributes, you would assign the `diff` attribute
+for paths.
+
+------------------------
+*.tex	diff=tex
+------------------------
+
+Then, you would define "diff.tex.funcname" configuration to
+specify a regular expression that matches a line that you would
+want to appear as the hunk header, like this:
+
+------------------------
+[diff "tex"]
+	funcname = "^\\(\\\\\\(sub\\)*section{.*\\)$"
+------------------------
+
+Note.  A single level of backslashes are eaten by the
+configuration file parser, so you would need to double the
+backslashes; the pattern above picks a line that begins with a
+backslash, and zero or more occurences of `sub` followed by
+`section` followed by open brace, to the end of line.
+
+There are a few built-in patterns to make this easier, and `tex`
+is one of them, so you do not have to write the above in your
+configuration file (you still need to enable this with the
+attribute mechanism, via `.gitattributes`).  Another built-in
+pattern is defined for `java` that defines a pattern suitable
+for program text in Java language.
+
+
 Performing a three-way merge
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
