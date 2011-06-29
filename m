From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 1/2 maint] Documentation: quote double-dash for AsciiDoc
Date: Wed, 29 Jun 2011 00:35:10 -0500
Message-ID: <20110629053510.GC28690@elie>
References: <20110628171748.GA11485@elie>
 <20110629053133.GB28690@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 29 07:35:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QbnQp-0000Hn-8O
	for gcvg-git-2@lo.gmane.org; Wed, 29 Jun 2011 07:35:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752340Ab1F2FfR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Jun 2011 01:35:17 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:43919 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751862Ab1F2FfP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jun 2011 01:35:15 -0400
Received: by iwn6 with SMTP id 6so749101iwn.19
        for <git@vger.kernel.org>; Tue, 28 Jun 2011 22:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=10r9xQ9eZqzoNfz/GlGkxQMd//lZGKQZ609F1XmO+k8=;
        b=WngUa25pjtD+ILsXfzH/6hNPaf9w81HQqtFXvpiUXSxu1Tity7yL1BLOIHFII09yYp
         G/oWlj3J/9LycR1rykokkO57FENz09YjTwwF7en1Ql6Pc+It9lFTsX+PrzmtKdIdqrmh
         BTZUQqU3kTOei9/J7KgzELML9XAr7qTHMGIz0=
Received: by 10.42.197.3 with SMTP id ei3mr399533icb.78.1309325715085;
        Tue, 28 Jun 2011 22:35:15 -0700 (PDT)
Received: from elie (adsl-69-209-66-254.dsl.chcgil.ameritech.net [69.209.66.254])
        by mx.google.com with ESMTPS id s2sm779902icw.5.2011.06.28.22.35.13
        (version=SSLv3 cipher=OTHER);
        Tue, 28 Jun 2011 22:35:14 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110629053133.GB28690@elie>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176435>

AsciiDoc versions since 5.0.6 treat a double-dash surrounded by spaces
(outside of verbatim environments) as a request to insert an em dash.
Such versions also treat the three-character sequence "\--", when not
followed by another dash, as a request to insert two literal minus
signs.  Thus from time to time there have been patches to add
backslashes to AsciiDoc markup to escape double-dashes that are meant
to be represent '--' characters used literally on the command line;
see v1.4.0-rc1~174, Fix up docs where "--" isn't displayed correctly,
2006-05-05, for example.

AsciiDoc 6.0.3 (2005-04-20) made life harder by also treating
double-dashes without surrounding whitespace as markup for an em dash,
though only when formatting for backends other than the manpages
(e.g., HTML).  Many pages needed to be changed to use a backslash
before the "--" in names of command-line flags like "--add" (see
v0.99.6~37, Update tutorial, 2005-08-30).

AsciiDoc 8.3.0 (2008-11-29) refined the em-dash rule to avoid that
requirement.  Double-dashes without surrounding spaces are not
rendered as em dashes any more unless bordered on both sides by
alphanumeric characters.  The unescaped markup for option names (e.g.,
"--add") works fine, and many instances of this style have leaked into
Documentation/; git's HTML documentation contains many spurious em
dashes when formatted by an older toolchain.  (This patch will not
change that.)

The upshot: "--" as an isolated word and in phrases like "git
web--browse" must be escaped if it is not to be rendered as an em dash
by current asciidoc.  Use "\--" to avoid such misformatting in
sentences in which "--" represents a literal double-minus command line
argument that separates options and revs from pathspecs, and use
"{litdd}" in cases where the double-dash is embedded in the command
name.  The latter is just for consistency with v1.7.3-rc0~13^2 (Work
around em-dash handling in newer AsciiDoc, 2010-08-23).

List of lines to fix found by grepping manpages for "(em".

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Improved-by: Junio C Hamano <gitster@pobox.com>
Improved-by: Jeff King <peff@peff.net>
---
Changes since v1:

 - clearer description
 - using "git checkout <commit> \-- <filename>" instead of litdd
   for easier reading (but still git-web{litdd}browse for consistency
   with existing markup)

Simplifications to the above description would be very welcome.

 Documentation/config.txt             |    2 +-
 Documentation/git-commit.txt         |    2 +-
 Documentation/git-mergetool--lib.txt |    2 +-
 Documentation/git-revert.txt         |    2 +-
 Documentation/git-submodule.txt      |    2 +-
 Documentation/git-web--browse.txt    |    2 +-
 Documentation/rev-list-options.txt   |    2 +-
 7 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index d1613621..4682fbbb 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -674,7 +674,7 @@ branch.<name>.rebase::
 browser.<tool>.cmd::
 	Specify the command to invoke the specified browser. The
 	specified command is evaluated in shell with the URLs passed
-	as arguments. (See linkgit:git-web--browse[1].)
+	as arguments. (See linkgit:git-web{litdd}browse[1].)
 
 browser.<tool>.path::
 	Override the path for the given tool that may be used to
diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index d0534b8c..872cb04a 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -276,7 +276,7 @@ When recording your own work, the contents of modified files in
 your working tree are temporarily stored to a staging area
 called the "index" with 'git add'.  A file can be
 reverted back, only in the index but not in the working tree,
-to that of the last commit with `git reset HEAD -- <file>`,
+to that of the last commit with `git reset HEAD \-- <file>`,
 which effectively reverts 'git add' and prevents the changes to
 this file from participating in the next commit.  After building
 the state to be committed incrementally with these commands,
diff --git a/Documentation/git-mergetool--lib.txt b/Documentation/git-mergetool--lib.txt
index 63ededec..5b0d51f7 100644
--- a/Documentation/git-mergetool--lib.txt
+++ b/Documentation/git-mergetool--lib.txt
@@ -7,7 +7,7 @@ git-mergetool--lib - Common git merge tool shell scriptlets
 
 SYNOPSIS
 --------
-'TOOL_MODE=(diff|merge) . "$(git --exec-path)/git-mergetool--lib"'
+'TOOL_MODE=(diff|merge) . "$(git --exec-path)/git-mergetool{litdd}lib"'
 
 DESCRIPTION
 -----------
diff --git a/Documentation/git-revert.txt b/Documentation/git-revert.txt
index ac10cfbb..6a21b37f 100644
--- a/Documentation/git-revert.txt
+++ b/Documentation/git-revert.txt
@@ -23,7 +23,7 @@ throw away all uncommitted changes in your working directory, you
 should see linkgit:git-reset[1], particularly the '--hard' option.  If
 you want to extract specific files as they were in another commit, you
 should see linkgit:git-checkout[1], specifically the `git checkout
-<commit> -- <filename>` syntax.  Take care with these alternatives as
+<commit> \-- <filename>` syntax.  Take care with these alternatives as
 both will discard uncommitted changes in your working directory.
 
 OPTIONS
diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index 1a16ff60..6ae6fd88 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -172,7 +172,7 @@ sync::
 	repositories accordingly.
 +
 "git submodule sync" synchronizes all submodules while
-"git submodule sync -- A" synchronizes submodule "A" only.
+"git submodule sync \-- A" synchronizes submodule "A" only.
 
 OPTIONS
 -------
diff --git a/Documentation/git-web--browse.txt b/Documentation/git-web--browse.txt
index 69d92fa0..9b0d1fe3 100644
--- a/Documentation/git-web--browse.txt
+++ b/Documentation/git-web--browse.txt
@@ -68,7 +68,7 @@ browser.<tool>.path
 You can explicitly provide a full path to your preferred browser by
 setting the configuration variable 'browser.<tool>.path'. For example,
 you can configure the absolute path to firefox by setting
-'browser.firefox.path'. Otherwise, 'git web--browse' assumes the tool
+'browser.firefox.path'. Otherwise, 'git web{litdd}browse' assumes the tool
 is available in PATH.
 
 browser.<tool>.cmd
diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index 73111bb0..5b29ad39 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -309,7 +309,7 @@ that you are filtering for a file `foo` in this commit graph:
 	 \   /   /   /   /
 	  `-------------'
 -----------------------------------------------------------------------
-The horizontal line of history A--P is taken to be the first parent of
+The horizontal line of history A---P is taken to be the first parent of
 each merge.  The commits are:
 
 * `I` is the initial commit, in which `foo` exists with contents
-- 
1.7.6
