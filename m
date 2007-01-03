From: Brian Gernhardt <benji@silverinsanity.com>
Subject: [PATCH] Add documentation for git-branch's color configuration.
Date: Wed, 3 Jan 2007 10:36:29 -0500
Message-ID: <20070103153629.GA9754@182.242.249.10.in-addr.arpa>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Wed Jan 03 16:37:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H28AM-0007TU-F6
	for gcvg-git@gmane.org; Wed, 03 Jan 2007 16:36:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750876AbXACPgb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 3 Jan 2007 10:36:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750872AbXACPgb
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Jan 2007 10:36:31 -0500
Received: from vs072.rosehosting.com ([216.114.78.72]:50237 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750873AbXACPga (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jan 2007 10:36:30 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by silverinsanity.com (Postfix) with ESMTP id F09581FFC02B
	for <git@vger.kernel.org>; Wed,  3 Jan 2007 15:36:29 +0000 (UTC)
Received: from Mutt by mutt-smtp-wrapper.pl 1.2  (www.zdo.com/articles/mutt-smtp-wrapper.shtml)
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35873>

Added color.branch and color.branch.<slot> to configuration list.
Style copied from color.status and meanings derived from the code.

Moved the color meanings from color.diff.<slot> to color.branch.<slot>
since the latter comes first alphabetically.

Added --color and --no-color to git-branch's usage and documentation.

Signed-off-by: Brian Gernhardt <benji@silverinsanity.com>
---

 When looking through the code, I noticed that git-branch had color
 options.  Who knew?  Not me.

 I checked, but couldn't find, any other color options to document.

 Documentation/config.txt     |   24 ++++++++++++++++++------
 Documentation/git-branch.txt |    9 ++++++++-
 builtin-branch.c             |    2 +-
 3 files changed, 27 insertions(+), 8 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 2f4fc25..4318bf9 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -145,6 +145,21 @@ branch.<name>.merge::
 	this option, `git pull` defaults to merge the first refspec fetched.
 	Specify multiple values to get an octopus merge.
 
+color.branch::
+	A boolean to enable/disable color in the output of
+	gitlink:git-branch[1]. May be set to `true` (or `always`),
+	`false` (or `never`) or `auto`, in which case colors are used
+	only when the output is to a terminal. Defaults to false.
+
+color.branch.<slot>::
+	Use customized color for branch coloration. `<slot>` is one of
+	`current` (the current branch), `local` (a local branch),
+	`remote` (a tracking branch in refs/remotes/), `plain` (other
+	refs), or `reset` (the normal terminal color).  The value for
+	these configuration variables can be one of: `normal`, `bold`,
+	`dim`, `ul`, `blink`, `reverse`, `reset`, `black`, `red`,
+	`green`, `yellow`, `blue`, `magenta`, `cyan`, or `white`.
+
 color.diff::
 	When true (or `always`), always use colors in patch.
 	When false (or `never`), never.  When set to `auto`, use
@@ -155,11 +170,8 @@ color.diff.<slot>::
 	specifies which part of the patch to use the specified
 	color, and is one of `plain` (context text), `meta`
 	(metainformation), `frag` (hunk header), `old` (removed
-	lines), or `new` (added lines).  The value for these
-	configuration variables can be one of: `normal`, `bold`,
-	`dim`, `ul`, `blink`, `reverse`, `reset`, `black`,
-	`red`, `green`, `yellow`, `blue`, `magenta`, `cyan`, or
-	`white`.
+	lines), or `new` (added lines).  The values of these
+	variables may be specified as in color.branch.<slot>.
 
 color.pager::
 	A boolean to enable/disable colored output when the pager is in
@@ -177,7 +189,7 @@ color.status.<slot>::
 	`added` or `updated` (files which are added but not committed),
 	`changed` (files which are changed but not added in the index),
 	or `untracked` (files which are not tracked by git). The values of
-	these variables may be specified as in color.diff.<slot>.
+	these variables may be specified as in color.branch.<slot>.
 
 diff.renameLimit::
 	The number of files to consider when performing the copy/rename
diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
index c464bd2..e872fc8 100644
--- a/Documentation/git-branch.txt
+++ b/Documentation/git-branch.txt
@@ -8,7 +8,7 @@ git-branch - List, create, or delete branches.
 SYNOPSIS
 --------
 [verse]
-'git-branch' [-r | -a] [-v [--abbrev=<length>]]
+'git-branch' [--color | --no-color] [-r | -a] [-v [--abbrev=<length>]]
 'git-branch' [-l] [-f] <branchname> [<start-point>]
 'git-branch' (-m | -M) [<oldbranch>] <newbranch>
 'git-branch' (-d | -D) [-r] <branchname>...
@@ -60,6 +60,13 @@ OPTIONS
 -M::
 	Move/rename a branch even if the new branchname already exists.
 
+--color::
+	Color branches to highlight current, local, and remote branches.
+
+--no-color::
+	Turn off branch colors, even when the configuration file gives the
+	default to color output.
+
 -r::
 	List or delete (if used with -d) the remote-tracking branches.
 
diff --git a/builtin-branch.c b/builtin-branch.c
index 745ee04..1ed0fa9 100644
--- a/builtin-branch.c
+++ b/builtin-branch.c
@@ -12,7 +12,7 @@
 #include "builtin.h"
 
 static const char builtin_branch_usage[] =
-  "git-branch [-r] (-d | -D) <branchname> | [-l] [-f] <branchname> [<start-point>] | (-m | -M) [<oldbranch>] <newbranch> | [-r | -a] [-v [--abbrev=<length>]]";
+  "git-branch [-r] (-d | -D) <branchname> | [-l] [-f] <branchname> [<start-point>] | (-m | -M) [<oldbranch>] <newbranch> | [--color | --no-color] [-r | -a] [-v [--abbrev=<length>]]";
 
 #define REF_UNKNOWN_TYPE    0x00
 #define REF_LOCAL_BRANCH    0x01
-- 
1.5.0.rc0.g825ce
