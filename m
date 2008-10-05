From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGit PATCH 5/6] Refresh the main stg man page
Date: Sun, 05 Oct 2008 18:01:57 +0200
Message-ID: <20081005160157.19886.7137.stgit@yoghurt>
References: <20081005155450.19886.43748.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 05 18:03:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KmW4h-0006DS-S5
	for gcvg-git-2@gmane.org; Sun, 05 Oct 2008 18:03:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754599AbYJEQCI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 5 Oct 2008 12:02:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754628AbYJEQCG
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Oct 2008 12:02:06 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:1880 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754569AbYJEQCD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Oct 2008 12:02:03 -0400
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1KmW3Q-0007YT-00; Sun, 05 Oct 2008 17:01:56 +0100
In-Reply-To: <20081005155450.19886.43748.stgit@yoghurt>
User-Agent: StGIT/0.14.3.236.g0c611
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97516>

Update the text to reflect what's happened in StGit in the last few
releases. Also, consistently capitalize the names "Git" and "StGit".

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>

---

 Documentation/asciidoc.conf |   22 +++++-
 Documentation/stg.txt       |  150 +++++++++++++++++++++++++----------=
--------
 stgit/argparse.py           |    2 -
 3 files changed, 107 insertions(+), 67 deletions(-)


diff --git a/Documentation/asciidoc.conf b/Documentation/asciidoc.conf
index 5f7a7af..f2c0ede 100644
--- a/Documentation/asciidoc.conf
+++ b/Documentation/asciidoc.conf
@@ -44,9 +44,23 @@ template::[header-declarations]
 endif::backend-docbook[]
 endif::doctype-manpage[]
=20
-## link: macro
+## htmllink: macro
 #
-# Usage: link:command[manpage-section]
+# Usage: htmllink:url[text]
+
+ifdef::backend-docbook[]
+[htmllink-inlinemacro]
+{0}
+endif::backend-docbook[]
+
+ifdef::backend-xhtml11[]
+[htmllink-inlinemacro]
+<a href=3D"{target}">{0}</a>
+endif::backend-xhtml11[]
+
+## manlink: macro
+#
+# Usage: manlink:command[manpage-section]
 #
 # Note, {0} is the manpage section, while {target} is the command.
 #
@@ -54,7 +68,7 @@ endif::doctype-manpage[]
 # show the command.
=20
 ifdef::backend-docbook[]
-[link-inlinemacro]
+[manlink-inlinemacro]
 {0%{target}}
 {0#<citerefentry>}
 {0#<refentrytitle>{target}</refentrytitle><manvolnum>{0}</manvolnum>}
@@ -62,7 +76,7 @@ ifdef::backend-docbook[]
 endif::backend-docbook[]
=20
 ifdef::backend-xhtml11[]
-[link-inlinemacro]
+[manlink-inlinemacro]
 <a href=3D"{target}.html">{target}{0?({0})}</a>
 endif::backend-xhtml11[]
=20
diff --git a/Documentation/stg.txt b/Documentation/stg.txt
index d8f7d01..9c6b267 100644
--- a/Documentation/stg.txt
+++ b/Documentation/stg.txt
@@ -1,11 +1,10 @@
 stg(1)
 =3D=3D=3D=3D=3D=3D
 Yann Dirson <ydirson@altern.org>
-v0.12.1, February 2007
=20
 NAME
 ----
-stg - manage stacks of patches using the GIT content tracker
+stg - Manage stacks of patches using the Git content tracker
=20
 SYNOPSIS
 --------
@@ -17,86 +16,113 @@ SYNOPSIS
 DESCRIPTION
 -----------
=20
-StGIT (Stacked GIT) is an application providing similar functionality
-to Quilt (i.e. pushing/popping patches to/from a stack), on top of
-GIT. These operations are performed using GIT commands and the patches
-are stored as GIT commit objects, allowing easy merging of the StGIT
-patches into other repositories using standard GIT functionality.
+StGit (Stacked Git) is an application that provides a convenient way
+to maintain a 'patch stack' on top of a Git branch:
=20
-An StGIT stack is a GIT branch with additional information to help
-making changes to individual patches you already committed, rather
-than making changes by adding new commits.  It is thus a
-non-forwarding, or rewinding branch: the old head of the branch is
-often not reachable as one of the new head's ancestors.
+  * The topmost (most recent) commits of a branch are given names.
+    Such a named commit is called a 'patch'.
=20
-Typical uses of StGIT include:
+  * After making changes to the worktree, you can incorporate the
+    changes into an existing patch; this is called 'refreshing'. You
+    may refresh any patch, not just the topmost one.
+
+  * You can 'pop' a patch: temporarily putting it aside, so that the
+    patch below it becomes the topmost patch. Later you may 'push' it
+    onto the stack again. Pushing and popping can be used to reorder
+    patches.
+
+  * You can easily 'rebase' your patch stack on top of any other Git
+    branch. (The 'base' of a patch stack is the most recent Git commit
+    that is not an StGit patch.) For example, if you started making
+    patches on top of someone else's branch, and that person publishes
+    an updated branch, you can take all your patches and apply them on
+    top of the updated branch.
+
+  * The patch stack is just some extra metadata attached to regular
+    Git commits, so you can continue to use Git tools along with
+    StGit.
+
+Typical uses
+~~~~~~~~~~~~
=20
 Tracking branch::
-	Tracking changes from a remote branch, while maintaining local
-	modifications against that branch, possibly with the intent of
-	sending some patches upstream.  StGIT assists in preparing and
-	cleaning up patches until they are acceptable upstream, as
-	well as maintaining local patches not meant to be sent
-	upstream.
+
+  Tracking changes from a remote branch, while maintaining local
+  modifications against that branch, possibly with the intent of
+  sending some patches upstream. You can modify your patch stack as
+  much as you want, and when your patches are finally accepted
+  upstream, the permanent recorded Git history will contain just the
+  final sequence of patches, and not the messy sequence of edits that
+  produced them.
 +
-In such a setup, typically all commits on your branch are StGIT
-patches; the stack base is the branch point where your changes "fork"
-off their parent branch.
+Commands of interest in this workflow are e.g. stgsublink:rebase[] and
+stgsublink:mail[].
=20
 Development branch::
-	Preparing and testing your commits before publishing them,
-	separating your features from unrelated bugfixes collected
-	while developping.
+
+  Even if you have no "upstream" to send patches to, you can use StGit
+  as a convenient way to modify the recent history of a Git branch.
+  For example, instead of first committing change 'A', then change
+  'B', and then 'A2' to fix 'A' because it wasn't quite right, you
+  could incorporate the fix directly into 'A'. This way of working
+  results in a much more readable Git history than if you had
+  immortalized every misstep you made on your way to the right
+  solution.
 +
-In such a setup, not all commits on your branch need to be StGIT
-patches; there may be regular GIT commits below your stack base.
+Commands of interest in this workflow are e.g. stgsublink:uncommit[],
+which can be used to move the patch stack base downwards -- i.e., turn
+Git commits into StGit patches after the fact -- and
+stgsublink:commit[], its inverse.
+
+For more information, see htmllink:tutorial.html[the tutorial].
=20
-Patches
-~~~~~~~
+Specifying patches
+~~~~~~~~~~~~~~~~~~
=20
-Many StGIT commands take references to StGIT patches as arguments.
+Many StGit commands take references to StGit patches as arguments.
 Patches in the stack are identified with short names, each of which
 must be unique in the stack.
=20
-Patches in the current stack are just referred to by their name.  Some
-commands allow you to specify a patch in another stack of the reposito=
ry;
-this is done by suffixing the patch name with an '@' sign followed by =
the
-branch name (eg. 'thispatch@otherbranch').
+Patches in the current branch are simply referred to by their name.
+Some commands allow you to specify a patch in another branch of the
+repository; this is done by prefixing the patch name with the branch
+name and a colon (e.g. +otherbranch:thatpatch+).
+
+Specifying commits
+~~~~~~~~~~~~~~~~~~
+
+Some StGit commands take Git commits as arguments. StGit accepts all
+commit expressions that Git does; and in addition, a patch name
+(optionally prefixed by a branch name and a colon) is allowed in this
+context. The usual Git modifiers $$^$$ and $$~$$ are also allowed;
+e.g., +abranch:apatch~2+ is the grandparent of the commit that is the
+patch +apatch+ on branch +abranch+.
=20
-A number of positions in the stack related to the patch are also
-accessible through '//' suffixes.  For example, 'patch//top' is
-equivalent to 'patch', and 'patch//bottom' refers to the commit below
-'patch' (i.e. the patch below, or the stack base if this is the
-bottom-most patch).  Similarly '//top.old' and '//bottom.old'
-refer to the previous version of the patch (before the last
-stglink:push[] or stglink:refresh[] operation).  When referring to the
-current patch, its name can be omitted (eg. 'currentpatch//bottom.old'
-can be abbreviated as 'bottom.old').
+Instead of a patch name, you can say +$${base}$$+ to refer to the
+stack base (the commit just below the bottommost patch); so,
++abranch:$${base}$$+ is the base of the stack in branch +abranch+.
=20
-If you need to pass a given StGIT reference to a git command,
-stglink:id[] will convert it to a git commit id.
+If you need to pass a given StGit reference to a Git command,
+stglink:id[] will convert it to a Git commit id for you.
=20
 OPTIONS
 -------
=20
-The following generic option flags are available.  Additional options
-are available per-command, and documented in the command-specific
-documentation.
+The following generic option flags are available. Additional options
+are available for (and documented with) the different subcommands.
=20
 --version::
-	Prints the StGIT suite version that the 'stg' program came
-	from, as well as version of other components used, such as GIT
-	and Python.
+  Prints the StGit version, as well as version of other components
+  used, such as Git and Python.
=20
 --help::
-	Prints the synopsis and a list of all commands.  If a git
-	command is given this option will display the specific help
-	for that command.
+  Prints the synopsis and a list of all subcommands. If an StGit
+  subcommand is given, prints the synposis for that subcommand.
=20
 STGIT COMMANDS
 --------------
=20
-We divide StGIT commands in thematic groups, according to the primary
+We divide StGit commands in thematic groups, according to the primary
 type of object they create or change.
=20
 ifdef::backend-docbook[]
@@ -110,16 +136,16 @@ include::command-list.txt[]
 CONFIGURATION MECHANISM
 -----------------------
=20
-Starting with 0.12, StGIT uses the same configuration mechanism as
-GIT.  See link:git[7] for more details.
+StGit uses the same configuration mechanism as Git. See manlink:git[7]
+for more details.
=20
 TEMPLATES
 ---------
=20
-A number of StGIT commands make use of template files to provide
-useful default texts to be edited by the user.  These '<name>.tmpl'
+A number of StGit commands make use of template files to provide
+useful default texts to be edited by the user. These +<name>.tmpl+
 template files are searched in the following directories:
=20
-	$GITDIR/
-	$HOME/.stgit/templates/
-	/usr/share/stgit/templates/
+  . +$GITDIR/+ (in practice, the +.git/+ directory in your repository)
+  . +$HOME/.stgit/templates/+
+  . +/usr/share/stgit/templates/+
diff --git a/stgit/argparse.py b/stgit/argparse.py
index 406ada3..0adb8ff 100644
--- a/stgit/argparse.py
+++ b/stgit/argparse.py
@@ -103,7 +103,7 @@ def write_asciidoc(cmd, f):
             o.write_asciidoc(f)
             f.write('\n')
     _write_underlined('StGit', '-', f)
-    f.write('Part of the StGit suite - see link:stg[1]\n')
+    f.write('Part of the StGit suite - see manlink:stg[1]\n')
=20
 def sign_options():
     def callback(option, opt_str, value, parser, sign_str):
