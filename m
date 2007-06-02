From: Jonas Fonseca <fonseca@diku.dk>
Subject: [RFC PATCH] Add git quick reference
Date: Sat, 2 Jun 2007 20:24:23 +0200
Message-ID: <20070602182423.GC19952@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 02 20:31:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HuYOB-00064q-VB
	for gcvg-git@gmane.org; Sat, 02 Jun 2007 20:31:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760687AbXFBSbj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 2 Jun 2007 14:31:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761593AbXFBSbj
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Jun 2007 14:31:39 -0400
Received: from mgw1.diku.dk ([130.225.96.91]:54572 "EHLO mgw1.diku.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760687AbXFBSbi (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Jun 2007 14:31:38 -0400
Received: from localhost (localhost [127.0.0.1])
	by mgw1.diku.dk (Postfix) with ESMTP id 3A761F00E1
	for <git@vger.kernel.org>; Sat,  2 Jun 2007 20:31:36 +0200 (CEST)
X-Virus-Scanned: amavisd-new at diku.dk
Received: from mgw1.diku.dk ([127.0.0.1])
	by localhost (mgw1.diku.dk [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pkOFC6hOawpF for <git@vger.kernel.org>;
	Sat,  2 Jun 2007 20:31:33 +0200 (CEST)
Received: from nhugin.diku.dk (nhugin.diku.dk [130.225.96.140])
	by mgw1.diku.dk (Postfix) with ESMTP id 6EBD6F00EE
	for <git@vger.kernel.org>; Sat,  2 Jun 2007 20:24:23 +0200 (CEST)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP id 3C74D6DFD25
	for <git@vger.kernel.org>; Sat,  2 Jun 2007 20:22:17 +0200 (CEST)
Received: by ask.diku.dk (Postfix, from userid 3873)
	id 59A7762A5D; Sat,  2 Jun 2007 20:24:23 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48944>

It attempts to list some of the most commonly used commands, which should
give new users an idea of how to get started.

Available both as a manpage (generated via a script) and HTML page.
---
 Documentation/Makefile            |    8 ++-
 Documentation/asciidoc.conf       |    2 +
 Documentation/git-quick-ref.sh    |   67 ++++++++++++++++++++++
 Documentation/quick-reference.txt |  112 +++++++++++++++++++++++++++++++++++++
 4 files changed, 187 insertions(+), 2 deletions(-)
 create mode 100755 Documentation/git-quick-ref.sh
 create mode 100644 Documentation/quick-reference.txt

 This is "ported" from the Cogito quick reference that I made (inspired
 by svn-ref) to serve as something to hand out for new users--a kinda
 cheat sheet. I don't know if git even needs another document in this
 category. However, contrary to some of the others, this document tries
 to be very brief, which might help impatient users. ;)

 Also, I am, myself, quite new to the git porcelain so any feedback on
 which commands should be included would be very much appreciated! I'd
 like to keep the format to 2 pages max, so there is still room for a
 few additions.

 See the end result at:
 http://jonas.nitro.dk/git/quick-reference.{html,pdf}

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 3f92783..9dcabaf 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -3,7 +3,7 @@ MAN1_TXT= \
 		$(wildcard git-*.txt)) \
 	gitk.txt
 MAN5_TXT=gitattributes.txt
-MAN7_TXT=git.txt
+MAN7_TXT=git.txt git-quick-ref.txt
 
 DOC_HTML=$(patsubst %.txt,%.html,$(MAN1_TXT) $(MAN5_TXT) $(MAN7_TXT))
 
@@ -18,6 +18,7 @@ ARTICLES += hooks
 ARTICLES += everyday
 ARTICLES += git-tools
 ARTICLES += glossary
+ARTICLES += quick-reference
 # with their own formatting rules.
 SP_ARTICLES = howto/revert-branch-rebase user-manual
 
@@ -107,7 +108,7 @@ git.7 git.html: git.txt core-intro.txt
 
 clean:
 	rm -f *.xml *.xml+ *.html *.html+ *.1 *.5 *.7 howto-index.txt howto/*.html doc.dep
-	rm -f $(cmds_txt) *.made
+	rm -f $(cmds_txt) *.made git-quick-ref.txt
 
 %.html : %.txt
 	rm -f $@+ $@
@@ -129,6 +130,9 @@ clean:
 user-manual.xml: user-manual.txt user-manual.conf
 	$(ASCIIDOC) -b docbook -d book $<
 
+git-quick-ref.txt: quick-reference.txt
+	./git-quick-ref.sh $< > $@
+
 XSLT = http://docbook.sourceforge.net/release/xsl/current/html/docbook.xsl
 XSLTOPTS = --xinclude --stringparam html.stylesheet docbook-xsl.css
 
diff --git a/Documentation/asciidoc.conf b/Documentation/asciidoc.conf
index fa7dc94..546a074 100644
--- a/Documentation/asciidoc.conf
+++ b/Documentation/asciidoc.conf
@@ -12,6 +12,8 @@ caret=^
 startsb=&#91;
 endsb=&#93;
 tilde=&#126;
+# Five non breaking spaces used for option indentation in the quick reference
+qrefopt=&#160;&#160;&#160;&#160;&#160;
 
 ifdef::backend-docbook[]
 [gitlink-inlinemacro]
diff --git a/Documentation/git-quick-ref.sh b/Documentation/git-quick-ref.sh
new file mode 100755
index 0000000..65b02b3
--- /dev/null
+++ b/Documentation/git-quick-ref.sh
@@ -0,0 +1,67 @@
+#!/bin/sh
+#
+# Generate asciidoc manpage markup from Git quick reference file.
+# Copyright (c) Jonas Fonseca, 2007
+#
+# Takes the path to the reference file. Prints the manpage to stdout.
+
+reffile="$1"
+
+cat <<__END__
+git-quick-ref(7)
+================
+
+NAME
+----
+git-quick-ref - Git quick reference
+
+SYNOPSIS
+--------
+A list of frequently used commands grouped with related commands.
+
+DESCRIPTION
+-----------
+
+__END__
+
+sed '
+	0,/^$/d
+	/^`---/d
+	/frame="none"/,1d
+	s/\\$//
+	s/[*]\([^*]*\)[*]/\1/g
+	s/[`]\([^`]*\)[`]/\1/g
+	s/['\'']\([^'\'']*\)['\'']/\1/g
+' < "$reffile" | \
+while read line; do
+	col1=$(echo "$line" | cut -f 1)
+	case "$line" in
+	*":")
+		echo "$line"
+		echo "$line" | sed "s/[^~]/~/g"
+		echo
+		echo "[verse]"
+		continue
+		;;
+	"-----"*|"")
+		echo "$line" | sed 's/-/./g'
+		continue
+		;;
+	"{qrefopt}"*)
+		col1=$(echo "$col1" | sed 's/.*qrefopt}/   /')
+		;;
+	esac
+	col2=$(echo "$line" | sed 's/.*[	]\+//')
+	printf "%-30s  %s\n" "$col1" "$col2"
+done
+
+cat << __END__
+
+DOCUMENTATION
+-------------
+Documentation by Jonas Fonseca and the git-list <git@vger.kernel.org>.
+
+GIT
+---
+Part of the gitlink:git[7] suite
+__END__
diff --git a/Documentation/quick-reference.txt b/Documentation/quick-reference.txt
new file mode 100644
index 0000000..4ab8620
--- /dev/null
+++ b/Documentation/quick-reference.txt
@@ -0,0 +1,112 @@
+Git Quick Reference
+===================
+
+[frame="none"]
+`-------------------------------`---------------------------------------------
+Getting help:
+------------------------------------------------------------------------------
+*git help* 'command'		or
+*git* 'command' \--help		Show help for a command
+------------------------------------------------------------------------------
+
+[frame="none"]
+`-------------------------------`---------------------------------------------
+Repository creation:
+------------------------------------------------------------------------------
+*git init*			Create a repository in the current directory
+*git clone* 'url'		Clone a remote repository into a subdirectory
+------------------------------------------------------------------------------
+
+[frame="none"]
+`-------------------------------`---------------------------------------------
+File operations:
+------------------------------------------------------------------------------
+*git add* 'path'		Add file or files in directory recursively
+*git rm* 'path'			Remove file or directory from the working tree
+{qrefopt} -f			Force deletion of file(s) from disk
+*git mv* 'path' 'destination'	Move file or directory to new location
+{qrefopt} -f			Overwrite existing destination files
+*git checkout* '[rev]' 'file'	Restore file from current branch or revision
+{qrefopt} -f			Overwrite uncommitted local changes
+------------------------------------------------------------------------------
+
+[frame="none"]
+`-------------------------------`---------------------------------------------
+Working tree:
+------------------------------------------------------------------------------
+*git status*			Show status of the working tree
+*git diff* '[path]'		Show diff of changes in the working tree
+*git diff* HEAD 'path'		Show diff of stages and unstaged changes
+*git add* 'path'		Stage file for commit
+*git reset* HEAD 'path'		Unstage file for commit
+*git commit*			Commit files that has been staged (with git-add)
+{qrefopt} -a			Automatically stage all modified files
+*git reset* \--soft HEAD^	Undo commit & keep changes in the working tree
+*git reset* \--hard HEAD^	Reset the working tree to the last commit
+*git clean*			Clean unknown files from the working tree
+------------------------------------------------------------------------------
+
+[frame="none"]
+`-------------------------------`---------------------------------------------
+Examining History:
+------------------------------------------------------------------------------
+*git log* '[path]'		View commit log, optionally for specific path
+*git log* '[from[..to]]'	View commit log for a given revision range
+{qrefopt} \--stat		List diffstat for each revision
+{qrefopt} -S'pattern'		Search history for changes matching pattern
+*git blame* '[file]'		Show file annotated with line modifications
+------------------------------------------------------------------------------
+
+[frame="none"]
+`-------------------------------`---------------------------------------------
+Remote repositories - 'remotes':
+------------------------------------------------------------------------------
+*git fetch* '[remote]'		Fetch changes from a remote repository
+*git pull* '[remote]'		Fetch and merge changes from a remote repository
+*git push* '[remote]'		Push changes to a remote repository
+*git remote*			List remote repositories
+*git remote add* 'remote' 'url'	Add remote to list of tracked repositories
+------------------------------------------------------------------------------
+
+[frame="none"]
+`-------------------------------`---------------------------------------------
+Branches:
+------------------------------------------------------------------------------
+*git checkout* 'branch'		Switch working tree to branch
+{qrefopt} -b 'branch'		Create branch before switching to it
+*git branch*			List local branches
+*git branch* -f	'branch' 'rev'	Overwrite existing branch, start from revision
+*git merge* 'branch'		Merge changes from branch
+------------------------------------------------------------------------------
+
+[frame="none"]
+`-------------------------------`---------------------------------------------
+Exporting and importing:
+------------------------------------------------------------------------------
+*git apply* - < 'file'		Apply patch from stdin
+*git format-patch* 'from[..to]'	Format a patch with log message and diffstat
+*git archive* 'rev' > 'file'	Export snapshot of revision to file
+{qrefopt} \--prefix='dir'/	Nest all files in the snapshot in directory
+{qrefopt} \--format='[tar|zip]'	Specify archive format to use: 'tar' or 'zip'
+------------------------------------------------------------------------------
+
+[frame="none"]
+`-------------------------------`---------------------------------------------
+Tags:
+------------------------------------------------------------------------------
+*git tag* 'name' '[revision]'	Create tag for a given revision
+{qrefopt} -s			Sign tag with your private key using GPG
+{qrefopt} -l '[pattern]'	List tags, optionally matching pattern
+------------------------------------------------------------------------------
+
+[frame="none"]
+`-------------------------------`---------------------------------------------
+File status flags:
+------------------------------------------------------------------------------
+`M` modified			File has been modified
+`C` copy-edit			File has been copied and modified
+`R` rename-edit			File has been renamed and modified
+`A` added			File has been added
+`D` deleted			File has been deleted
+`U` unmerged			File has conflicts after a merge
+------------------------------------------------------------------------------
-- 
1.5.2.816.gc5560-dirty

-- 
Jonas Fonseca
