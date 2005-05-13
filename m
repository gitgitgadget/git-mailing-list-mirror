From: Jonas Fonseca <fonseca@diku.dk>
Subject: Re: [RFC] Embedding asciidoc manpages in the cg scripts
Date: Fri, 13 May 2005 20:48:57 +0200
Message-ID: <20050513184857.GB26263@diku.dk>
References: <20050511014445.GA14377@diku.dk> <20050511213217.GG22686@pasky.ji.cz> <4282851A.2010305@dgreaves.com> <20050511224806.GJ22686@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="82I3+IH0IqGh5yIs"
Cc: David Greaves <david@dgreaves.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 13 21:38:11 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DWfyf-0007bp-JO
	for gcvg-git@gmane.org; Fri, 13 May 2005 21:37:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262459AbVEMTov (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 13 May 2005 15:44:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262514AbVEMTog
	(ORCPT <rfc822;git-outgoing>); Fri, 13 May 2005 15:44:36 -0400
Received: from nhugin.diku.dk ([130.225.96.140]:4041 "EHLO nhugin.diku.dk")
	by vger.kernel.org with ESMTP id S262486AbVEMStA (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 13 May 2005 14:49:00 -0400
Received: by nhugin.diku.dk (Postfix, from userid 754)
	id 6CC306E120C; Fri, 13 May 2005 20:48:51 +0200 (CEST)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP
	id 84FC06DFFF8; Fri, 13 May 2005 20:48:50 +0200 (CEST)
Received: by ask.diku.dk (Postfix, from userid 3873)
	id CF06161FDE; Fri, 13 May 2005 20:48:57 +0200 (CEST)
To: Petr Baudis <pasky@ucw.cz>
Content-Disposition: inline
In-Reply-To: <20050511224806.GJ22686@pasky.ji.cz>
User-Agent: Mutt/1.5.6i
X-Spam-Status: No, hits=-4.1 required=5.0 tests=BAYES_00,REMOVE_REMOVAL_NEAR 
	autolearn=no version=2.60
X-Spam-Checker-Version: SpamAssassin 2.60 (1.212-2003-09-23-exp) on 
	nhugin.diku.dk
X-Spam-Level: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


--82I3+IH0IqGh5yIs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Petr Baudis <pasky@ucw.cz> wrote Thu, May 12, 2005:
> Dear diary, on Thu, May 12, 2005 at 12:20:10AM CEST, I got a letter
> where David Greaves <david@dgreaves.com> told me that...
> > Petr Baudis wrote:
> > 
> > >>+# NAME
> > >>+# ----
> > >>+# cg-add - add files to a GIT repository
> > >
> > >Half of this is useless, too.
> > >
> > >I think you should just keep the first paragraph of the files as it is
> > >now. Don't touch it, just parse it.
> > >  
> > A bit harsh Petr.
> 
> Sorry, I didn't mean to sound (too) harsh. ;-)

Don't mind that you are harsh if it makes sense and I must agree that
having a helper script really paid off reducing the added markup to
almost a half (in my initial patches). Plus, it is now easy to enhance
the manpages with links to referenced commands without having stuff like
'link:' markup in the script headers.

I ended up actually adding two scripts. One for lifting cg-* manpages
and one for generating a cogito manpage with an overview of commands and
information about command identifiers.

The generated manpages can be previewed at:

	http://www.nitro.dk/~jonas/cogito/manpages/cogito.html

-- 
Jonas Fonseca

--82I3+IH0IqGh5yIs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="cogito-manpages.patch"

[PATCH] Cogito manpages

Add asciidoc markup to Cogito script headers. Add a script to generate
asciidoc manpages from the cg-* command headers and a script for
generating a cogito(1) manpage. Finally, add build rules for making
Cogito manpages.

Notes:

* USAGE variables are added which can later be used by cg-help or die().

* The command identifiers are name wrapped in '<'/'>' like in the GIT
  manpages and are not similar to those in cg-help.

* The top-level Makefile is changed to add a script header to cg-version
  so it could also have a man pages. Don't know if that belongs there or
  in Documentation/cg-version.txt. Anyway, in order to minimize the
  patch I cleaned up the checking of .git/HEAD.

* I had trouble getting asciidoc to accept the line

	git+ssh://[user@]host/path

  I couldn't figure out how to escape it so I changed it to

	git+ssh://host/path or git+ssh://user@host/path

  Finally the example with referencing branches via #fragments I shortened
  the rsync URL so the line breaking '\' was not needed.

* The description of -r options should be carefully reviewed. I changed
  them to be more alike across cg-{diff,log,mkpatch} and some of the
  original ones looked wrong.

Signed-off-by: Jonas Fonseca <fonseca@diku.dk>

---
 Documentation/Makefile            |   11 ++
 Documentation/make-cg-manpage     |   65 ++++++++++++++++
 Documentation/make-cogito-manpage |  149 ++++++++++++++++++++++++++++++++++++++
 Makefile                          |   33 +++++---
 cg-add                            |   18 ++++
 cg-admin-lsobj                    |   35 +++++++-
 cg-admin-uncommit                 |   28 ++++---
 cg-branch-add                     |   44 ++++++-----
 cg-branch-ls                      |   19 ++++
 cg-cancel                         |   19 +++-
 cg-clone                          |   17 +++-
 cg-commit                         |   95 +++++++++++++++++++-----
 cg-diff                           |   29 +++++--
 cg-export                         |   15 +++
 cg-help                           |   17 ++++
 cg-init                           |   15 +++
 cg-log                            |   71 +++++++++++++-----
 cg-ls                             |   35 ++++++++
 cg-merge                          |   25 ++++--
 cg-mkpatch                        |   39 ++++++++-
 cg-patch                          |   11 ++
 cg-pull                           |   15 +++
 cg-restore                        |   24 ++++--
 cg-rm                             |   11 ++
 cg-seek                           |   26 ++++--
 cg-status                         |   30 +++++++
 cg-tag                            |   15 +++
 cg-tag-ls                         |    9 ++
 cg-update                         |   16 +++-
 29 files changed, 785 insertions(+), 151 deletions(-)

Index: Documentation/Makefile
===================================================================
--- de641904363cd3759f132ee7c0dfaf8a2ee58388/Documentation/Makefile  (mode:100644)
+++ uncommitted/Documentation/Makefile  (mode:100644)
@@ -1,4 +1,7 @@
-DOC_SRC=$(wildcard git*.txt)
+CG_IGNORE=$(wildcard ../cg-X*)
+CG_SRC=$(filter-out $(CG_IGNORE), $(wildcard ../cg-*))
+CG_TXT=cogito.txt $(patsubst ../cg-%,cg-%.txt,$(CG_SRC))
+DOC_SRC=$(wildcard git*.txt) $(CG_TXT)
 DOC_HTML=$(patsubst %.txt,%.html,$(DOC_SRC))
 DOC_MAN=$(patsubst %.txt,%.1,$(DOC_SRC))
 
@@ -22,3 +25,9 @@
 
 %.xml : %.txt
 	asciidoc -b docbook -d manpage $<
+
+cogito.txt : make-cogito-manpage
+	./make-cogito-manpage > $@
+
+cg-%.txt : ../cg-% make-cg-manpage
+	./make-cg-manpage $< > $@
Index: Documentation/make-cg-manpage
===================================================================
--- /dev/null  (tree:de641904363cd3759f132ee7c0dfaf8a2ee58388)
+++ uncommitted/Documentation/make-cg-manpage  (mode:100755)
@@ -0,0 +1,65 @@
+#!/usr/bin/env bash
+#
+# Generate asciidoc manpage markup from Cogito script header.
+# Copyright (c) Jonas Fonseca, 2005
+#
+# Takes a path to a Cogito script. Prints the manpage to stdout.
+
+. ${COGITO_LIB}cg-Xlib
+
+command=$1
+
+[ -e "$command" ] || die "$command does not exist"
+
+COMMAND=$(basename $command)
+
+# FIXME: Show the SHA1 of the command below the TITLELINE.
+
+# Generate the 'CG-COMMAND(1)' title from cg-command
+TITLE="$COMMAND(1)"
+# Asciidocs wants the title line ('====') to be as wide as the title.
+TITLELINE=$(echo "$TITLE" | sed 's/[0-9a-zA-Z-()]/=/g')
+
+# Get `USAGE="cg-command args..."` line and make it `cg-command args...`
+SYNOPSIS=$(grep 'USAGE=' $command | sed 's/^USAGE="\(.*\)"/\1/')
+
+# Extract the script header.
+HEADER=$(cat $command | sed -n '3,/^$/s/^# *//p')
+
+# Some scripts have copyright lines followed by 'Based on script by ...' lines.
+# Include them so they are also put in the COPYRIGHT section.
+COPYRIGHT=$(cat $command | sed -n '3,/^$/s/^# *//p' \
+			 | sed -n '/^Copyright (c)/,/^$/p' \
+			 | sed 's/(c)/(C)/')
+
+# First line of the header contains the caption. Normalize it by lowercasing the
+# start and stripping any punctuation.
+CAPTION=$(echo "$HEADER" | head -n 1 | tr '[A-Z]' '[a-z]' | sed 's/\.$//')
+
+# Get remaining sections and carefully insert links to cogito commands when they
+# were referenced as "`cg-command`". Note, we can't just do it for any cg-*
+# combo because code listings will ignore any asciidoc markup...."
+BODY=$(echo "$HEADER" | sed -n '/^DESCRIPTION$/,$p' \
+		      | sed 's/`\(cg-[a-z-]\+\)`/link:\1.html[`\1(1)`]/')
+
+echo "$TITLE"
+echo "$TITLELINE"
+echo
+echo "NAME"
+echo "----"
+echo "$COMMAND - $CAPTION"
+echo
+echo "SYNOPSIS"
+echo "--------"
+echo "$SYNOPSIS"
+echo
+echo "$BODY"
+echo
+echo "COPYRIGHT"
+echo "---------"
+echo "$COPYRIGHT"
+echo
+echo "SEE ALSO"
+echo "--------"
+echo "$COMMAND command is part of link:cogito.html[cogito(1)],"
+echo "a toolkit for managing link:git.html[git(1)] trees."
Index: Documentation/make-cogito-manpage
===================================================================
--- /dev/null  (tree:de641904363cd3759f132ee7c0dfaf8a2ee58388)
+++ uncommitted/Documentation/make-cogito-manpage  (mode:100755)
@@ -0,0 +1,149 @@
+#!/usr/bin/env bash
+#
+# Generate a quick reference asciidoc manpage for the Cogito.
+# Copyright (c) Jonas Fonseca, 2005
+
+# Shorthand for the link markup.
+link()
+{
+	command="$1"
+	echo "link:$command.html[\`$command(1)\`]"
+}
+
+# Print description list entry.
+print_command_info()
+{
+	command="$1"
+	caption=$(cat "$command" | head -n 3 | tail -n 1 | sed 's/# //')
+	usage=$(grep 'USAGE=' "$command" | sed 's/^USAGE="\(.*\)"/\1/')
+	cmdname=$(basename $command)
+
+	echo
+	case "$cmdname" in
+	cg-*)
+		link "$cmdname"
+		;;
+	*-id)
+		echo "$cmdname::"
+		;;
+	esac
+	echo "	$caption"
+	echo
+	echo "	$usage"
+}
+
+cat <<__END__
+cogito(1)
+=========
+
+NAME
+----
+cogito - SCM-like GIT layer
+
+SYNOPSIS
+--------
+cg-<command> <arg>...
+
+DESCRIPTION
+-----------
+
+Cogito is a revision control system for tracking changes to content in a
+highly distributed development environment. Amongst some of the noteworthy
+features, Cogito has support for branching, tagging and multiple backends for
+distributing repositories (local files, rsync, HTTP, ssh).
+
+Cogito is implemented as a series of \`bash(1)\` scripts on top of $(link git)
+(a stupid content tracker) with the goal of providing an interface for working
+with the GIT database in a manner similar to other SCM tools (like CVS,
+BitKeeper or Monotone).
+
+Commands Overview
+-----------------
+
+The Cogito commands can be split into regular commands and advanced commands.
+The regular commands are those used for normal interacting with the
+repository, while the advanced commands can be used for administrating the
+repository and should to some degree be regarded as low-level and in some
+cases dangerous.
+
+Below an overview of the available commands are listed. For details on
+individual commands, do e.g. \`cg-help cg-log\` or \`cg-log --help\`.
+
+Regular commands
+~~~~~~~~~~~~~~~~
+__END__
+
+for command in $(ls ../cg-* | grep -v cg-admin- | grep -v cg-X); do
+	print_command_info "$command"
+done
+
+cat <<__END__
+
+Advanced commands
+~~~~~~~~~~~~~~~~~
+__END__
+
+for command in $(ls ../cg-admin-*); do
+	print_command_info "$command"
+done
+
+cat <<__END__
+
+Helper commands
+~~~~~~~~~~~~~~~
+
+Cogito also provides various helper commands for resolving IDs for symbolic
+names etc. The commands are:
+__END__
+
+for command in $(ls ../*-id | grep -v git-); do
+	print_command_info "$command"
+done
+
+cat <<__END__
+
+Command Identifiers
+-------------------
+<branch>::
+	Indicates a branch name added with the $(link cg-branch-add) name.
+
+<command>::
+	Indicates a Cogito command. The \`cg-\` prefix is optional.
+
+<location>::
+	Indicates a local file path or a URI. See $(link cg-branch-add) for a
+	list of supported URI schemes.
+
+<revision>::
+	Indicates an ID resolving to a commit. The following expressions can
+	be used interchangably as IDs:
+	- empty string, 'this' or 'HEAD' (current HEAD)
+	- branch name (as registered with $(link cg-branch-add))
+	- tag name (as registered with $(link cg-tag))
+	- shortcut object hash (shorted unambiguous hash lead)
+	- commit object hash (as returned by \`commit-id\`)
+	- tree object hash (as returned by \`tree-id\`)
+
+<tag>::
+	Indicates a free form tag name.
+
+<type>::
+	Indicates a git object type i.e.: \`blob\`, \`commit\`, \`tree\` or
+	\`tag\`.
+
+<username>::
+	Indicates a free form user name.
+
+<file>::
+	Indicates a filename - always relative to the root of the repository.
+
+AUTHORS
+-------
+Cogito was written by Petr Baudis <pasky@ucw.cz>.
+This manpage was written by Jonas Fonseca <fonseca@diku.dk>.
+
+COPYRIGHT
+---------
+Copyright (C) Petr Baudis, 2005.
+Copyright (C) Jonas Fonseca, 2005.
+__END__
Index: Makefile
===================================================================
--- de641904363cd3759f132ee7c0dfaf8a2ee58388/Makefile  (mode:100644)
+++ uncommitted/Makefile  (mode:100644)
@@ -114,20 +114,33 @@
 
 
 ifneq (,$(wildcard .git))
-cg-version: $(VERSION) .git/HEAD
-	@echo Generating cg-version...
-	@rm -f $@
-	@echo "#!/bin/sh" > $@
-	@echo "echo \"$(shell cat $(VERSION)) ($(shell cat .git/HEAD))\"" >> $@
-	@chmod +x $@
-else
-cg-version: $(VERSION)
+GIT_HEAD=.git/HEAD
+GIT_HEAD_ID=" $(shell cat $(GIT_HEAD))"
+endif
+cg-version: $(VERSION) $(GITHEAD) Makefile
 	@echo Generating cg-version...
 	@rm -f $@
 	@echo "#!/bin/sh" > $@
-	@echo "echo \"$(shell cat $(VERSION))\"" >> $@
+	@echo "#" >> $@
+	@echo "# Show the version of the Cogito toolkit." >> $@
+	@echo "# Copyright (c) Petr Baudis, 2005" >> $@
+	@echo "#" >> $@
+	@echo "# DESCRIPTION" >> $@
+	@echo "# -----------" >> $@
+	@echo "# Show which version of Cogito is installed." >> $@
+	@echo "# Additionally, the 'HEAD' of the installed Cogito" >> $@
+	@echo "# is also shown if this information was available" >> $@
+	@echo "# at the build time." >> $@
+	@echo "#" >> $@
+	@echo "# OPTIONS" >> $@
+	@echo "# -------" >> $@
+	@echo "# -h, --help::" >> $@
+	@echo "#	Print usage help." >> $@
+	@echo >> $@
+	@echo "USAGE=\"cg-version\"" >> $@
+	@echo >> $@
+	@echo "echo \"$(shell cat $(VERSION))$(GIT_HEAD_ID)\"" >> $@
 	@chmod +x $@
-endif
 
 git.spec: git.spec.in $(VERSION)
 	sed -e 's/@@VERSION@@/$(shell cat $(VERSION) | cut -d"-" -f2)/g' < $< > $@
Index: cg-add
===================================================================
--- de641904363cd3759f132ee7c0dfaf8a2ee58388/cg-add  (mode:100755)
+++ uncommitted/cg-add  (mode:100755)
@@ -1,10 +1,26 @@
 #!/usr/bin/env bash
 #
-# Add new file to a GIT repository.
+# Add files to the GIT repository.
 # Copyright (c) Petr Baudis, 2005
 #
+# DESCRIPTION
+# -----------
 # Takes a list of file names at the command line, and schedules them
 # for addition to the GIT repository at the next commit.
+#
+# The command will fail if one of the given files does not exist.
+#
+# Note that cogito manage content. Which means it doesn't make sense
+# to `cg-add` stand-alone directories since directories have no content.
+# Instead add a file within the new directory and `cg-add` will create
+# a tree for managing the directory as needed.
+#
+# OPTIONS
+# -------
+# -h, --help::
+#	Print usage help.
+
+USAGE="cg-add <file>..."
 
 . ${COGITO_LIB}cg-Xlib
 
Index: cg-admin-lsobj
===================================================================
--- de641904363cd3759f132ee7c0dfaf8a2ee58388/cg-admin-lsobj  (mode:100755)
+++ uncommitted/cg-admin-lsobj  (mode:100755)
@@ -4,17 +4,44 @@
 # Copyright (c) Randy Dunlap, 2005
 # Copyright (c) Petr Baudis, 2005
 #
-# Lists IDs of all the objects of a given type (blob, tree, commit) found
-# in the dircache.
+# DESCRIPTION
+# -----------
+# Lists IDs of all the objects of a given type found in the dircache.
+# Takes the object type as the first parameter, defaults to all objects.
+#
+# The possible object types are:
+# `blob`::
+#	This object is a pure storage object containing some user data.
+#
+# `commit`::
+#	This object ties directory hierarchies together into a DAG
+#	of revisions.
+#
+# `tree`::
+#	This object is an object that ties one or more `blob` objects
+#	into a directory structure.
+#
+# `tag`::
+#	This object ties a symbolic release tag to an object in the
+#	database.
 #
-# Example usage:
+# See the git README for more information about the object types.
+#
+# EXAMPLE USAGE
+# -------------
 # Oh, I was messing with my HEADs and lost few commits, where on the earth
 # could they be...?
+#
 #	for i in `cg-admin-lsobj commit | cut -f 1`; do
 #		echo -e "\n==================\nme $i"; cat-file commit $i;
 #	done
 #
-# Takes the object type as the first parameter, defaults to all objects.
+# OPTIONS
+# -------
+# -h, --help::
+#	Print usage help.
+
+USAGE="cg-admin-lsobj [<type>]"
 
 . ${COGITO_LIB}cg-Xlib
 
Index: cg-admin-uncommit
===================================================================
--- de641904363cd3759f132ee7c0dfaf8a2ee58388/cg-admin-uncommit  (mode:100755)
+++ uncommitted/cg-admin-uncommit  (mode:100755)
@@ -1,18 +1,28 @@
 #!/usr/bin/env bash
 #
-# Undo a commit or a series of commits
+# Undo a commit or a series of commits.
 # Copyright (c) Matt Porter, 2005
 # Copyright (c) Petr Baudis, 2005
 #
-# Optional -t parameter makes cg-admin-uncommit to roll back the tree
-# as well to the previous commit. Without this option (by default)
-# Cogito keeps the tree in its current state, therefore generating
-# tree with local changes against the target commit, consisting of the
-# changes in the rolled back commits.
+# DESCRIPTION
+# -----------
+# Takes a commit ID which is the earliest commit to be removed from
+# the repository. If no parameter is passed, it uncommits the latest
+# commit ('HEAD').
 #
-# Takes a commit ID which is the earliest commit to be
-# removed from the repository. If no parameter is passed,
-# it uncommits the latest commit (HEAD).
+# OPTIONS
+# -------
+# -t::
+#	This optional parameter makes `cg-admin-uncommit` to roll back
+#	the tree as well to the previous commit. Without this option
+#	(by default) Cogito keeps the tree in its current state,
+#	therefore generating tree with local changes against the target
+#	commit, consisting of the changes in the rolled back commits.
+#
+# -h, --help::
+#	Print usage help.
+
+USAGE="cg-admin-uncommit [-t] [<commit>]"
 
 . ${COGITO_LIB}cg-Xlib
 
Index: cg-branch-add
===================================================================
--- de641904363cd3759f132ee7c0dfaf8a2ee58388/cg-branch-add  (mode:100755)
+++ uncommitted/cg-branch-add  (mode:100755)
@@ -3,35 +3,41 @@
 # Add new branch to the GIT repository.
 # Copyright (c) Petr Baudis, 2005
 #
-# After you add a branch, you can cg-pull it whenever you want
-# and it will keep your objects database in sync with it. Its latest
-# commit is accessible as .git/refs/heads/branchname (or - more conveniently
-# - as $(commit-id branchname)). For example, to make a diff between
-# Linus (after you added him) and your current tree, do
-#
-#	cg-pull linus
-#	cg-diff linus
+# DESCRIPTION
+# -----------
+# Takes the branch name and source location as parameters.
+# After you add a branch, you can `cg-pull` it whenever you want and
+# it will keep your objects database in sync with it. Its latest
+# commit is accessible as `.git/refs/heads/branchname` (or - more
+# conveniently - as `$(commit-id branchname)`). For example, to make a
+# diff between Linus (after you added him) and your current tree, do:
 #
+#	$ cg-pull linus
+#	$ cg-diff linus
 #
 # The possible location specifiers are:
 #
-# (1) Local path - note that pulling will hardlink the objects, not copy them.
-# (2) rsync - either rsync://host/path or host:/path (the latter can change)
-# (3) HTTP - http://host/path
-# (4) SSH - git+ssh://[user@]host/absolute/path
+# 1. Local path - note that pulling will hardlink the objects, not copy them.
+# 2. rsync - either `rsync://host/path` or `host:/path` (the latter can change)
+# 3. HTTP - `http://host/path`
+# 4. SSH - `git+ssh://host/path` or `git+ssh://user@host/path` - note that
+#    the path must be absolute.
 #
 # The URL can have a fragment part, which identifies a branch inside of
 # the repository. Therefore, if you have a repository
-# rsync://kernel.org/pub/scm/linux/kernel/mj/linux.git and you are interested
-# in its 'testing' branch, you can e.g.
-#
-#	cg-branch-add mj-testing \
-#		rsync://kernel.org/pub/scm/linux/kernel/mj/linux.git#testing
+# `rsync://host/path/repo.git` and you are interested in its 'testing'
+# branch, you can e.g.:
 #
-# and refer to it as 'mj-testing' anytime later.
+#	$ cg-branch-add repo-testing rsync://host/path/repo.git#testing
 #
+# and refer to it as 'repo-testing' anytime later.
 #
-# Takes the branch' name and location as parameters.
+# OPTIONS
+# -------
+# -h, --help::
+#	Print usage help.
+
+USAGE="cg-admin-uncommit <branch> <location>"
 
 . ${COGITO_LIB}cg-Xlib
 
Index: cg-branch-ls
===================================================================
--- de641904363cd3759f132ee7c0dfaf8a2ee58388/cg-branch-ls  (mode:100755)
+++ uncommitted/cg-branch-ls  (mode:100755)
@@ -3,7 +3,24 @@
 # List configured GIT branches.
 # Copyright (c) Steven Cole 2005
 #
-# Takes no parameters.
+# DESCRIPTION
+# -----------
+# Print a listing of all known branches.
+#
+# The output has the following format:
+#
+#	<branch> <location>
+# 
+# For example
+#
+#	origin  rsync://rsync.kernel.org/pub/scm/cogito/cogito.git
+#
+# OPTIONS
+# -------
+# -h, --help::
+#	Print usage help.
+
+USAGE="cg-branch-ls"
 
 . ${COGITO_LIB}cg-Xlib
 
Index: cg-cancel
===================================================================
--- de641904363cd3759f132ee7c0dfaf8a2ee58388/cg-cancel  (mode:100755)
+++ uncommitted/cg-cancel  (mode:100755)
@@ -3,16 +3,23 @@
 # Cancels current edits in the working tree.
 # Copyright (c) Petr Baudis, 2005
 #
-# This script reverts the working tree to a consistent state before
-# any changes to it (including merges etc) were done.
+# DESCRIPTION
+# -----------
+# Reverts the working tree to a consistent state before any changes to it
+# (including merges etc.) were done.
 #
-# Basically, this is the opposite of cg-commit in some sense.
+# Basically, this is the opposite of `cg-commit` in some sense.
 #
-# Takes no arguments and the evil changes from the tree.
-#
-# This command is complementary to cg-restore, which only brings
+# This command is complementary to `cg-restore`, which only brings
 # individual files in sync with their state at the time of the
 # last commit.
+#
+# OPTIONS
+# -------
+# -h, --help::
+#	Print usage help
+
+USAGE="cg-cancel"
 
 . ${COGITO_LIB}cg-Xlib
 
Index: cg-clone
===================================================================
--- de641904363cd3759f132ee7c0dfaf8a2ee58388/cg-clone  (mode:100755)
+++ uncommitted/cg-clone  (mode:100755)
@@ -3,16 +3,25 @@
 # Clone a remote GIT repository.
 # Copyright (c) Petr Baudis, 2005
 #
+# DESCRIPTION
+# -----------
 # This is like cg-init, but it will create a new directory where it will do
 # the checkout.
 #
-# If you pass it an optional -s parameter, it does the clone in the current
-# directory instead of creating a new one.
-#
 # Takes a parameter specifying the location of the source repository and an
-# optional second parameter specifying the destination.  If the second
+# optional second parameter specifying the destination. If the second
 # parameter is omitted, the basename of the source repository is used as the
 # destination.
+#
+# OPTIONS
+# -------
+# -s::
+#	Clone in the current directory instead of creating a new one.
+#
+# -h, --help::
+#	Print usage help
+
+USAGE="cg-clone [-s] <location> [<directory>]"
 
 . ${COGITO_LIB}cg-Xlib
 
Index: cg-commit
===================================================================
--- de641904363cd3759f132ee7c0dfaf8a2ee58388/cg-commit  (mode:100755)
+++ uncommitted/cg-commit  (mode:100755)
@@ -4,26 +4,81 @@
 # Copyright (c) Petr Baudis, 2005
 # Based on an example script fragment sent to LKML by Linus Torvalds.
 #
-# Ignores any parameters for now, excepts changelog entry on stdin.
-# -C makes cg-commit ignore cache and just commit the thing as-is;
-# this is for internal purposes (merging).
-# -m"log message" specifies the commit message, which is used instead
-# of starting up an editor (if the input is not stdin, the input is
-# appended after all the -m messages). Multiple -m parameters are
-# appended to a single commit message, each as separate paragraph.
-# -e forces the editor to be brought up even when -m parameters were
-# passed to cg-commit.
-# -E forces the editor to be brought up and it will do the commit
-# even if the default commit message is not changed.
-#
-# These git environment variables are used in case values other than
-# that returned by getpwuid(getuid()) are desired when performing a commit:
-#
-# GIT_AUTHOR_NAME       Author's name
-# GIT_AUTHOR_EMAIL      Author's e-mail address
-# GIT_AUTHOR_DATE       Date, perhaps from a patch e-mail
-# GIT_COMMITTER_NAME    Committer's name
-# GIT_COMMITTER_EMAIL   Committer's e-mail address
+#
+# DESCRIPTION
+# -----------
+# Commits changes to a GIT repository. Accepts the commit message from
+# `stdin`. If the commit message is not modified the commit will be
+# aborted.
+#
+# The `GIT_AUTHOR_NAME`, `GIT_AUTHOR_EMAIL`, `GIT_AUTHOR_DATE`,
+# `GIT_COMMITTER_NAME` and `GIT_COMMITTER_EMAIL` environment variables
+# are used in case values other than that returned by `getpwuid(getuid())`
+# are desired when performing a commit.
+#
+# OPTIONS
+# -------
+# -C::
+#	Make `cg-commit` ignore the cache and just commit the thing as-is.
+#	Note, this is used internally by Cogito when merging. This option
+#	does not make sense when files are given on the command line.
+#
+# -m<message>::
+#	Specify the commit message, which is used instead of starting
+#	up an editor (if the input is not `stdin`, the input is appended
+#	after all the '-m' messages). Multiple '-m' parameters are appended
+#	to a single commit message, each as separate paragraph.
+#
+# -e::
+#	Force the editor to be brought up even when '-m' parameters were
+#	passed to `cg-commit`.
+#
+# -E::
+#	Force the editor to be brought up and do the commit even if
+#	the default commit message is not changed.
+#
+# -h, --help::
+#	Print usage help.
+#
+# FILES
+# -----
+# $GIT_DIR/commit-template::
+#	If the file exists it will be used as a template when creating
+#	the commit message. The template file makes it possible to
+#	automatically add `Signed-off-by` line to the log message.
+#
+# $GIT_DIR/hooks/commit-post::
+#	If the file exists and is executable it will be executed upon
+#	completion of the commit. The script is passed two arguments.
+#	The first argument is the commit ID and the second is the
+#	branchname. A sample `commit-post` script might look like:
+#
+#	#!/bin/sh
+#	id=$1
+#	branch=$2
+#	echo "Committed $id in $branch" | mail user@host
+#
+# ENVIRONMENT VARIABLES
+# ---------------------
+# GIT_AUTHOR_NAME::
+#	Author's name
+#
+# GIT_AUTHOR_EMAIL::
+#	Author's e-mail address
+#
+# GIT_AUTHOR_DATE::
+#	Date, useful when applying patches an e-mail
+#
+# GIT_COMMITTER_NAME::
+#	Committer's name
+#
+# GIT_COMMITTER_EMAIL::
+#	Committer's e-mail address
+#
+# EDITOR::
+#	The editor used for entering revision log information.
+
+USAGE="cg-commit [-m<message>]... [-e | -E] [<file>]..."
 
 . ${COGITO_LIB}cg-Xlib
 
Index: cg-diff
===================================================================
--- de641904363cd3759f132ee7c0dfaf8a2ee58388/cg-diff  (mode:100755)
+++ uncommitted/cg-diff  (mode:100755)
@@ -3,18 +3,29 @@
 # Make a diff between two GIT trees.
 # Copyright (c) Petr Baudis, 2005
 #
+# DESCRIPTION
+# -----------
+# Outputs a diff for converting the first tree to the second one.
 # By default compares the current working tree to the state at the
-# last commit. You can specify -r rev1:rev2 or -r rev1 -r rev2 to
-# tell it to make a diff between the specified revisions. If you
-# do not specify a revision, the current working tree is implied
-# (note that no revision is different from empty revision - -r rev:
-# compares between rev and HEAD, while -r rev compares between rev
-# and working tree).
+# last commit.
 #
-# -p instead of one ID denotes a parent commit to the specified ID
-# (which must not be a tree, obviously).
+# OPTIONS
+# -------
+# -p::
+#	Instead of one ID denotes a parent commit to the specified ID
+#	(which must not be a tree, obviously).
 #
-# Outputs a diff converting the first tree to the second one.
+# -r <commit>[:<commit>]::
+#	Specify the revisions to diff using either '-r rev1:rev2' or
+#	'-r rev1 -r rev2'. If no revision is specified, the current
+#	working tree is implied. Note that no revision is different from
+#	empty revision which means '-r rev:' compares between 'rev' and
+#	'HEAD', while '-r rev' compares between 'rev' and working tree.
+#
+# -h, --help::
+#	Print usage help.
+
+USAGE="cg-diff [-p] [-r <commit>[:<commit>]] [<file>]..."
 
 . ${COGITO_LIB}cg-Xlib
 
Index: cg-export
===================================================================
--- de641904363cd3759f132ee7c0dfaf8a2ee58388/cg-export  (mode:100755)
+++ uncommitted/cg-export  (mode:100755)
@@ -3,12 +3,21 @@
 # Exports a particular revision from a GIT repository.
 # Copyright (c) Johannes E. Schindelin, 2005
 #
-# Takes a destination and optionally an id as a parameter,
-# defaulting to HEAD.
+# DESCRIPTION
+# -----------
+# Takes a destination and optionally a tree ID as a parameter,
+# defaulting to 'HEAD'.
 #
-# The destination can be either a .tar, .tar.gz, .tar.bz2 or .tgz
+# The destination can be either a `.tar`, `.tar.gz`, `.tar.bz2` or `.tgz`
 # for generating a tarball. Other destination specifiers are assumed
 # to be directory names, and the tree is exported to the given directory.
+#
+# OPTIONS
+# -------
+# -h, --help::
+#	Print usage help.
+
+USAGE="cg-export <destination> [<tree>]"
 
 . ${COGITO_LIB}cg-Xlib
 
Index: cg-help
===================================================================
--- de641904363cd3759f132ee7c0dfaf8a2ee58388/cg-help  (mode:100755)
+++ uncommitted/cg-help  (mode:100755)
@@ -1,9 +1,24 @@
 #!/usr/bin/env bash
 #
-# The help for the Cogito toolkit.
+# Show help for Cogito commands.
 # Copyright (c) Petr Baudis, 2005
 #
+# DESCRIPTION
+# -----------
 # Takes an optional argument describing the command to show the help for.
+# The command can be specified either as '<command>' or 'cg-<command>'.
+# If the argument is left out an overview of all the Cogito commands will
+# be shown.
+#
+# Note help for a command is also available by passing `--help` or `-h`
+# to the command.
+#
+# OPTIONS
+# -------
+# -h, --help::
+#	Print usage help
+
+USAGE="cg-help [<command>]"
 
 . ${COGITO_LIB}cg-Xlib
 
Index: cg-init
===================================================================
--- de641904363cd3759f132ee7c0dfaf8a2ee58388/cg-init  (mode:100755)
+++ uncommitted/cg-init  (mode:100755)
@@ -3,10 +3,19 @@
 # Initialize a GIT repository.
 # Copyright (c) Petr Baudis, 2005
 #
+# DESCRIPTION
+# -----------
 # Takes an optional parameter which will make it "clone" a specified
-# remote repository. Note that this usage is DEPRECATED - use cg-clone
-# (possibly with the -s parameter) for doing this. This functionality
-# will go away from cg-init soon.
+# remote repository. Note that this usage is 'DEPRECATED'. Instead use
+# `cg-clone` (possibly with the `-s` parameter) for doing this. This
+# functionality will go away from `cg-init` soon.
+#
+# OPTIONS
+# -------
+# -h, --help::
+#	Print usage help.
+
+USAGE="cg-init"
 
 . ${COGITO_LIB}cg-Xlib
 
Index: cg-log
===================================================================
--- de641904363cd3759f132ee7c0dfaf8a2ee58388/cg-log  (mode:100755)
+++ uncommitted/cg-log  (mode:100755)
@@ -4,26 +4,59 @@
 # Copyright (c) Petr Baudis, 2005.
 # Copyright (c) David Woodhouse, 2005.
 #
-# Takes a -c option to add color to the output.
-# Currently, the colors are:
+# DESCRIPTION
+# -----------
+# Display log information for files or a range of commits. The output
+# will automatically be displayed in a pager unless it is piped to
+# a program.
+#
+# OPTIONS
+# -------
+# Arguments not interpreted as options will be interpreted as filenames;
+# cg-log then displays only changes in those files.
+#
+# -c::
+#	Add color to the output. Currently, the colors are:
+#	- `author`:	'cyan'
+#	- `committer`:	'magenta'
+#	- `header`:	'green'
+#	- `files`:	'blue'
+#	- `signoff`:	'yellow'
+#
+# -f::
+#	List which files changed.
+#
+# -r <commit>[:<commit>]::
+#	Limit the log information to a set of revisions using either
+#	'-r FROM_ID[:TO_ID]' or '-r FROM_ID -r TO_ID'. In both cases the
+#	option expects IDs which resolve to commits and will include the
+#	specified IDs. If 'TO_ID' is omitted all commits from 'FROM_ID'
+#	to the initial commit is shown. If no revisions is specified,
+#	the log information starting from 'HEAD' will be shown.
+#
+# -u<username>::
+#	List only commits where author or committer contains '<username>'.
+#	The search for '<username>' is case-insensitive.
+#
+# -h, --help::
+#	Print usage help.
+#
+# EXAMPLE USAGE
+# -------------
+# To show a log of changes between two releases tagged as 'releasetag-0.9'
+# and 'releasetag-0.10' do:
+#
+#	$ cg-log -r releasetag-0.9:releasetag-0.10
+#
+# ENVIRONMENT VARIABLES
+# ---------------------
+# PAGER::
+#	The pager to display log information in, defaults to `less`.
 #
-#	header		Green	
-#	author 		Cyan
-#	committer	Magenta
-#	files		Blue
-#	signoff		Yellow
-#
-# Takes an -f option to list which files was changed.
-#
-# Takes -u"username" to list only commits where author or
-# committer contains username.
-#
-# Takes an -r followed with id resolving to a commit to start from
-# (HEAD by default), or id1:id2 representing an (id1;id2] range
-# of commits to show.
-#
-# The rest of arguments are took as filenames; cg-log then displays
-# only changes in those files.
+# PAGER_FLAGS::
+#	Flags to pass to the pager, defaults to `--R`
+
+USAGE="cg-log [-c] [-f] [-u<username>] [-r <commit>[:<commit>]] <file>..."
 
 . ${COGITO_LIB}cg-Xlib
 # Try to fix the annoying "Broken pipe" output. May not help, but apparently
Index: cg-ls
===================================================================
--- de641904363cd3759f132ee7c0dfaf8a2ee58388/cg-ls  (mode:100755)
+++ uncommitted/cg-ls  (mode:100755)
@@ -3,7 +3,40 @@
 # List contents of a particular tree in a GIT repository.
 # Copyright (c) Petr Baudis, 2005
 #
-# Optionally takes commit or tree id as a parameter, defaulting to HEAD.
+# DESCRIPTION
+# -----------
+# Optionally takes a commit or tree ID as a parameter, defaulting to
+# 'HEAD'.
+#
+# Each line in the output has the following format:
+#
+#	<mode>	<type>	<sha1>	<name>
+#
+# where
+#
+# '<mode>'::
+#	The file permission information in octal format.
+#
+# '<type>'::
+#	The type can be the following: `blob` refers to files
+#	and `tree` refers to directories.
+#
+# '<sha1>'::
+#	The object ID.
+#
+# '<name>'::
+#	The file or directory name.
+#
+# An example line might look like:
+#
+#	100644  blob    c7dacd0ea28994e3c754ca4eadb2e08c011ee3d3        README
+#
+# OPTIONS
+# -------
+# -h, --help::
+#	Print usage help.
+
+USAGE="cg-ls [<tree>]"
 
 . ${COGITO_LIB}cg-Xlib
 
Index: cg-merge
===================================================================
--- de641904363cd3759f132ee7c0dfaf8a2ee58388/cg-merge  (mode:100755)
+++ uncommitted/cg-merge  (mode:100755)
@@ -3,15 +3,28 @@
 # Merge a branch to the current tree.
 # Copyright (c) Petr Baudis, 2005
 #
+# DESCRIPTION
+# -----------
 # Takes a parameter identifying the branch to be merged.
-# Optional "-b base_commit" parameter specifies the base for the merge.
-# Optional "-c" parameter specifies that you want to have tree merge
-# never autocomitted, but want to review and commit it manually.
 #
-# You have to examine the tree after the merge and then do cg-commit.
+# You have to examine the tree after the merge and then do `cg-commit`.
 #
-# Alternatively, it will just bring the HEAD forward, if your current
-# HEAD is also the merge base.
+# Alternatively, it will just bring the 'HEAD' forward, if your current
+# 'HEAD' is also the merge base.
+#
+# OPTIONS
+# -------
+# -b <commit>::
+#	Parameter specifies the base commit for the merge.
+#
+# -c::
+#	Parameter specifies that you want to have tree merge never
+#	autocomitted, but want to review and commit it manually.
+#
+# -h, --help::
+#	Print usage help.
+
+USAGE="cg-merge [-c] [-b <commit>] <branch>"
 
 . ${COGITO_LIB}cg-Xlib
 
Index: cg-mkpatch
===================================================================
--- de641904363cd3759f132ee7c0dfaf8a2ee58388/cg-mkpatch  (mode:100755)
+++ uncommitted/cg-mkpatch  (mode:100755)
@@ -1,14 +1,41 @@
 #!/usr/bin/env bash
 #
-# Make a patch from a given commit.
+# Make a patch from one or several commits.
 # Copyright (c) Petr Baudis, 2005
 #
-# Takes an -s option which specifies whether to print a short
-# version of the patch without a patch header with meta info such
-# as author and committer.
+# DESCRIPTION
+# -----------
+# Generate a patch with diff statistics and meta info about each commit.
 #
-# Takes an -r followed with ID defaulting to HEAD, or id1:id2, forming
-# a range (id1;id2]. (Use "id1:" to take just everything from id1 to HEAD.)
+# OPTIONS
+# -------
+# -s::
+#	Specify whether to print a short version of the patch without
+#	a patch header with meta info such as author and committer.
+#
+# -r <commit>[:<commit>]::
+#	Specify a set of commits to make patches from using either
+#	'-r FROM_ID[:TO_ID]' or '-r FROM_ID -r TO_ID'. In both cases the
+#	option expects IDs which resolve to commits and will include the
+#	specified IDs. If 'TO_ID' is omitted patches for all commits
+#	from 'FROM_ID' to the initial commit will be generated. If no
+#	`-r` option is given the commit ID defaults to 'HEAD'.
+#
+# -h, --help::
+#	Print usage help.
+#
+# EXAMPLE USAGE
+# -------------
+# To make patches for all commits between two releases tagged as
+# 'releasetag-0.9' and 'releasetag-0.10' do:
+#
+#	$ cg-mkpatch -r releasetag-0.9:releasetag-0.10
+#
+# The output will be a contionuos dump of patches each separated by
+# the line
+# `!-------------------------------------------------------------flip-`
+
+USAGE="cg-mkpatch [-s] [-r <commit>[:<commit>]]"
 
 . ${COGITO_LIB}cg-Xlib
 
Index: cg-patch
===================================================================
--- de641904363cd3759f132ee7c0dfaf8a2ee58388/cg-patch  (mode:100755)
+++ uncommitted/cg-patch  (mode:100755)
@@ -1,12 +1,21 @@
 #!/usr/bin/env bash
 #
-# Apply a diff generated by git diff.
+# Apply a diff generated by cg-diff.
 # Copyright (c) Petr Baudis, 2005
 #
+# DESCRIPTION
+# -----------
 # This is basically just a smart patch wrapper. It handles stuff like
 # mode changes, removal of files vs. zero-size files etc.
 #
 # Takes the diff on stdin.
+#
+# OPTIONS
+# -------
+# -h, --help::
+#	Print usage help.
+
+USAGE="cg-patch < patch on stdin"
 
 . ${COGITO_LIB}cg-Xlib
 
Index: cg-pull
===================================================================
--- de641904363cd3759f132ee7c0dfaf8a2ee58388/cg-pull  (mode:100755)
+++ uncommitted/cg-pull  (mode:100755)
@@ -1,11 +1,20 @@
 #!/usr/bin/env bash
 #
-# Pulls changes from remote branch to the local GIT repository.
-# Copyright (c) Petr Baudis, 2005
+# Pull changes from a remote branch to the local GIT repository.
+# Copyright (c) Petr Baudis, 2005.
+#
+# DESCRIPTION
+# -----------
+# Takes the branch name as an argument, defaulting to "origin".
 #
 # See cg-branch-add for some description.
 #
-# Takes the branch' name, defaulting to "origin".
+# OPTIONS
+# -------
+# -h, --help::
+#	Print usage help.
+
+USAGE="cg-pull [<branch>]"
 
 . ${COGITO_LIB}cg-Xlib
 
Index: cg-restore
===================================================================
--- de641904363cd3759f132ee7c0dfaf8a2ee58388/cg-restore  (mode:100755)
+++ uncommitted/cg-restore  (mode:100755)
@@ -1,21 +1,29 @@
 #!/usr/bin/env bash
 #
-# Restores files removed/changed in the working tree.
+# Restore removed/changed files in the working tree.
 # Copyright (c) Petr Baudis, 2005
 #
-# This script restores given files to their original state.
-#
-# Without any parameters, it recovers any files removed locally
-# whose removal was not recorded by cg-rm.
+# DESCRIPTION
+# -----------
+# Restore given files to their original state. Without any parameters,
+# it recovers any files removed locally whose removal was not recorded
+# by `cg-rm`.
 #
 # If passed a set of file names, it restores those files to their
-# state as of the last commit (including bringing cg-rm'd files
-# back to life; FIXME: does not do that part yet).
+# state as of the last commit (including bringing files removed with
+# `cg-rm` back to life; FIXME: does not do that part yet).
 #
-# This command is complementary to the cg-cancel command, which
+# This command is complementary to the `cg-cancel` command, which
 # forcefully abandons all the changes in the working tree and
 # restores everything to a proper state (including unseeking,
 # cancelling merge in progress and rebuilding indexes).
+#
+# OPTIONS
+# -------
+# -h, --help::
+#	Print usage help.
+
+USAGE="cg-restore [<file>]..."
 
 . ${COGITO_LIB}cg-Xlib
 
Index: cg-rm
===================================================================
--- de641904363cd3759f132ee7c0dfaf8a2ee58388/cg-rm  (mode:100755)
+++ uncommitted/cg-rm  (mode:100755)
@@ -1,10 +1,19 @@
 #!/usr/bin/env bash
 #
-# Remove a file from a GIT repository.
+# Remove files from a GIT repository.
 # Copyright (c) Petr Baudis, 2005
 #
+# DESCRIPTION
+# -----------
 # Takes a list of file names at the command line, and schedules them
 # for removal from the GIT repository at the next commit.
+#
+# OPTIONS
+# -------
+# -h, --help::
+#	Print usage help.
+
+USAGE="cg-rm <file>..."
 
 . ${COGITO_LIB}cg-Xlib
 
Index: cg-seek
===================================================================
--- de641904363cd3759f132ee7c0dfaf8a2ee58388/cg-seek  (mode:100755)
+++ uncommitted/cg-seek  (mode:100755)
@@ -3,22 +3,30 @@
 # Seek the working tree to a given commit.
 # Copyright (c) Petr Baudis, 2005
 #
-# This will bring the working tree from its current HEAD to a given
-# commit. Note that it changes just the HEAD of the working tree, not
-# the branch it is corresponding to. It will return to the HEAD of
+# DESCRIPTION
+# -----------
+# Takes the target commit ID to seek to as an argument.
+# Seeking will bring the working tree from its current 'HEAD' to a given
+# commit. Note that it changes just the 'HEAD' of the working tree, not
+# the branch it is corresponding to. It will return to the 'HEAD' of
 # the appropriate branch if passed no arguments.
 #
 # Therefore, for a quick excurse to the past of the 'master' branch:
 #
-#	cg-seek git-pasky-0.1
-#	cg-diff this master # will do the correct thing
-#	cg-seek # will restore what we had before
+#	$ cg-seek git-pasky-0.1
+#	$ cg-diff this master	# will do the correct thing
+#	$ cg-seek		# will restore what we had before
 #
-# For intuitiveness, specifying the branch name (cg-seek master) will do
+# For intuitiveness, specifying the branch name (`cg-seek master`) will do
 # the right thing too. If you want to migrate your working tree to another
-# branch, use cg-fork.
+# branch, use `cg-fork`.
 #
-# Takes the target commit ID.
+# OPTIONS
+# -------
+# -h, --help::
+#	Print usage help.
+
+USAGE="cg-seek <commit>"
 
 . ${COGITO_LIB}cg-Xlib
 
Index: cg-status
===================================================================
--- de641904363cd3759f132ee7c0dfaf8a2ee58388/cg-status  (mode:100755)
+++ uncommitted/cg-status  (mode:100755)
@@ -3,7 +3,35 @@
 # Show status of entries in your working tree.
 # Copyright (c) Petr Baudis, 2005
 #
-# Takes no arguments.
+# DESCRIPTION
+# -----------
+# Print of files in the working tree.
+#
+# The output has the following format:
+#
+#	<status flag> <file>
+#
+# where '<status flag>' can be one of the following:
+#
+# `?`::
+#	'<file>' is unknown.
+# `M`::
+#	'<file>' has been touched or modified.
+#
+# OPTIONS
+# -------
+# -h, --help::
+#	Print usage help.
+#
+# FILES
+# -----
+# $GIT_DIR/exclude::
+#	If the file exists it will be used to prune which files to
+#	show status for. The format is similar to the `dontdiff` file;
+#	each line contains a pattern for a file or group of files
+#	to exclude.
+
+USAGE="cg-status"
 
 . ${COGITO_LIB}cg-Xlib
 
Index: cg-tag
===================================================================
--- de641904363cd3759f132ee7c0dfaf8a2ee58388/cg-tag  (mode:100755)
+++ uncommitted/cg-tag  (mode:100755)
@@ -3,10 +3,19 @@
 # Mark certain commit by a tag.
 # Copyright (c) Petr Baudis, 2005
 #
-# Creates a tag referencing the given commit (or HEAD). You can then
-# use the tag anywhere you specify a commit/tree ID.
+# DESCRIPTION
+# -----------
+# Creates a tag referencing the given commit (or 'HEAD'). You can then
+# use the tag anywhere you specify a commit or tree ID.
 #
-# Takes the tag's name and optionally the associated ID.
+# Takes the tag name and optionally the associated ID as arguments.
+#
+# OPTIONS
+# -------
+# -h, --help::
+#	Print usage help.
+
+USAGE="cg-tag <tag> [<commit>]"
 
 . ${COGITO_LIB}cg-Xlib
 
Index: cg-tag-ls
===================================================================
--- de641904363cd3759f132ee7c0dfaf8a2ee58388/cg-tag-ls  (mode:100755)
+++ uncommitted/cg-tag-ls  (mode:100755)
@@ -3,7 +3,16 @@
 # List stored GIT tags.
 # Copyright (c) Steve Hoelzer 2005
 #
+# DESCRIPTION
+# -----------
 # Takes no parameters.
+#
+# OPTIONS
+# -------
+# -h, --help::
+#	Print usage help.
+
+USAGE="cg-tag-ls"
 
 . ${COGITO_LIB}cg-Xlib
 
Index: cg-update
===================================================================
--- de641904363cd3759f132ee7c0dfaf8a2ee58388/cg-update  (mode:100755)
+++ uncommitted/cg-update  (mode:100755)
@@ -1,9 +1,21 @@
 #!/usr/bin/env bash
 #
-# Pulls changes from another branch to the local repository and merge changes.
+# Pull and merge changes from a branch to the local repository.
 # Copyright (c) Petr Baudis, 2005
 #
-# Takes the branch' name, defaulting to "origin".
+# DESCRIPTION
+# -----------
+# Takes the branch name as an argument, defaulting to 'origin'.
+#
+# If local changes conflict with those of the branch updated from the
+# merge will be blocked.
+#
+# OPTIONS
+# -------
+# -h, --help::
+#	Print usage help.
+
+USAGE="cg-update [<branch>]"
 
 . ${COGITO_LIB}cg-Xlib
 

--82I3+IH0IqGh5yIs--
