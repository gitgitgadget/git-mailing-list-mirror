From: Sergey Yanovich <ynvich@gmail.com>
Subject: [PATCH 2/2] 'git-svndump'
Date: Sun, 17 Jun 2007 22:38:57 +0300
Message-ID: <11821091382770-git-send-email-ynvich@gmail.com>
References: 11821061823423-git-send-email-ynvich@gmail.com
 <11821091373273-git-send-email-ynvich@gmail.com>
 <11821091373927-git-send-email-ynvich@gmail.com>
Cc: Sergey Yanovich <ynvich@gmail.com>
To: git@vger.kernel.org, normalperson@yhbt.net
X-From: git-owner@vger.kernel.org Sun Jun 17 21:38:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I00Zg-0004hm-GI
	for gcvg-git@gmane.org; Sun, 17 Jun 2007 21:38:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760021AbXFQTiE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Jun 2007 15:38:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755107AbXFQTiD
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Jun 2007 15:38:03 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:37613 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759721AbXFQTiA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Jun 2007 15:38:00 -0400
Received: by ug-out-1314.google.com with SMTP id j3so1243060ugf
        for <git@vger.kernel.org>; Sun, 17 Jun 2007 12:37:59 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=rwfGvxZJjjBjq7F6J2sNbKPXx8GL2Sl9nO1JnBR2RW/ghkZFzcL3G0Wm4qGKHHFMRY9sibH75OihD+tXCH68EUnCyfbJeOJKEjLHtdda1dc7ueSsPvgxzOOPw1N0oKo/zcUXHDLOSToURPWTDHkgFMt16VseZtJpdsN9EFD3BiQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=bJ+oxbTx9S1mtNsAvWc4ymNIlKA+ws3hOOVJNTdFSz6+pkn3VkTPIUWVqYK2SHsTe8UOCc7kV42uf3+4lEyVCUk5HpaVYfP2CPB7HF2vX+lOvGJ6hZbY5KdNgkWLkpg2wJg3FoZVMEof+zCIFahG/fYoHyJS45nZyn1fLhbGglA=
Received: by 10.66.252.18 with SMTP id z18mr2300458ugh.1182109078574;
        Sun, 17 Jun 2007 12:37:58 -0700 (PDT)
Received: from host3 ( [87.252.237.202])
        by mx.google.com with ESMTP id y7sm8636856ugc.2007.06.17.12.37.55
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 17 Jun 2007 12:37:57 -0700 (PDT)
Received: from sergei by host3 with local (Exim 4.63)
	(envelope-from <ynvich@gmail.com>)
	id 1I00aQ-0002mq-4X; Sun, 17 Jun 2007 22:38:58 +0300
X-Mailer: git-send-email 1.5.2.1
In-Reply-To: <11821091373927-git-send-email-ynvich@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50369>


Signed-off-by: Sergey Yanovich <ynvich@gmail.com>
---
 Documentation/git-svndump.txt |  106 +++++++++++++++++++++++++++++++++++++++++
 git-svndump-init.sh           |   85 +++++++++++++++++++++++++++++++++
 git-svndump-sync.sh           |   85 +++++++++++++++++++++++++++++++++
 3 files changed, 276 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/git-svndump.txt
 create mode 100755 git-svndump-init.sh
 create mode 100755 git-svndump-sync.sh

diff --git a/Documentation/git-svndump.txt b/Documentation/git-svndump.txt
new file mode 100644
index 0000000..9caf02b
--- /dev/null
+++ b/Documentation/git-svndump.txt
@@ -0,0 +1,106 @@
+git-svndump(1)
+==========
+
+NAME
+----
+git-svndump - Exporting from git to a single Subversion branch
+
+SYNOPSIS
+--------
+'git-svndump' <command> [options] [arguments]
+
+DESCRIPTION
+-----------
+git-svndump is essentially a wrapper around 'git-svn commit-diff'. It
+will work only when it is the sole method of committing to the
+Subversion repository.
+
+It is designed to export a linear git branch. However, thanks to the way
+'git' handles source code, 'git-svndump' seems to work in other
+conditions. For example, when branches are switched or merged.
+
+git-svndump provides a solution when you need to export you source code
+in Subversion format (who would need this with git :), but do not want
+to have all the shackles that 'git-svn init' puts on your repository.
+
+COMMANDS
+--------
+--
+
+'init'::
+	Initialize an existing git repository with additional
+	metadata directories for git-svndump.  The Subversion URL
+	must be specified as the first non-optional command-line
+	argument. 'git' tree-ish that correspond to the HEAD of
+	that Subversion URL may be specified as the second optional
+	command-line argument.
+
+-f;;
+	git-svndump normally declines to reinitialize the same git
+	repository. With the '-f' option that behavior is overridden.
+
+-A<filename>;;
+--authors-file=<filename>;;
+	The filename is stored, and provided as an argument to 'git-svn'
+	on calls of 'git-svndump sync'.
+
+'sync'::
+	Commit git revisions to the Subversion repository. If a git
+	<tree-ish> is specified as an optional command-line argument,
+	than all commits between the last 'sync' and that <tree-ish> are
+	send. If the argument is omitted, the HEAD of the active branch
+	is used.
+
+-A<filename>;;
+--authors-file=<filename>;;
+	The filename is provided as an argument to 'git-svn'.
+
+--
+
+BASIC EXAMPLE
+--------------
+
+Contributing to a Subversion repository:
+
+------------------------------------------------------------------------
+# Create your git repository, do some work and commit your  changes
+# You are working on a computer A (git.foo.org)
+# Prepare your git repository for export (you are in the top dir)
+	git-svndump-init -A .auth http://svn.foo.org/project
+# Commit the whole branch:
+	git-svndump-sync
+# Now you go a different computer B
+# Clone a git repo:
+	git clone git.foo.org:/path/to/project.git
+# Enter the newly cloned directory:
+	cd project
+# Immediately prepare the new repository for export
+	git-svndump-init -A .auth http://svn.foo.org/project HEAD
+# Do some work and commit both locally and to A:
+	git commit ...
+	git push
+# Commit the new work:
+	git-svndump-sync
+# Now you return to the computer A
+# Reinit your repository for export!
+	git-svndump-init -f -A .auth http://svn.foo.org/project HEAD
+------------------------------------------------------------------------
+
+BUGS
+----
+
+The HEAD of the Subversion repository is not tracked. If your
+git-svndump repository goes out-of-sync with the Subversion mirror,
+the latter will most probably be corrupted.
+
+SEE ALSO
+--------
+gitlink:git-svn[1]
+
+Author
+------
+Written by Sergey Yanovich <ynvich@gmail.com>.
+
+Documentation
+-------------
+Written by Sergey Yanovich <ynvich@gmail.com>.
diff --git a/git-svndump-init.sh b/git-svndump-init.sh
new file mode 100755
index 0000000..4cf61b8
--- /dev/null
+++ b/git-svndump-init.sh
@@ -0,0 +1,85 @@
+#!/bin/sh
+
+usage()
+{
+	cat << EOF
+Usage: git-svndump-init [-f] subversion-url [<commit>]
+  subversion-url -- URL of the subversion repository to which you want
+                    to dump the current git repository
+  <commit>       -- git <commit> that correspond to the latest revision
+                    in the subversion repository
+OPTIONS
+  -f
+  		 do not stop, if the git repository is already initialized.
+EOF
+	exit 1
+}
+
+if test x$GIT_DIR = x ; then
+	if test -d ./.git ; then
+		GIT_DIR=`pwd`/.git
+	fi
+fi
+
+if test ! -d $GIT_DIR ; then
+	usage
+fi
+
+if test x$1 = x ; then
+	usage 
+fi
+
+if test x$1 = x-f; then
+	shift
+	rm -rf $GIT_DIR/svndump
+fi
+
+if test -d $GIT_DIR/svndump ; then
+	echo git-svndump-init: error: This git repository is already initialized
+	exit 1
+fi
+
+mkdir $GIT_DIR/svndump
+if test ! -d $GIT_DIR/svndump ; then
+	echo git-svndump-init: error: Failed to create $GIT_DIR/svndump
+	exit 1
+fi
+
+rev=`svn info $1 >$GIT_DIR/svndump/error.log`
+if test $? -ne 0 ; then
+	echo git-svndump-init: error: While quering $1
+	rm -rf $GIT_DIR/svndump
+	exit 1
+fi
+
+rev=`cat $GIT_DIR/svndump/error.log | sed -ne "/Revision/s/.* //p"`
+rm $GIT_DIR/svndump/error.log
+
+if test x$rev = x ; then
+	echo "git-svndump-init: error: Cannot determine the latest revision"
+	echo "                         at $1"
+	rm -rf $GIT_DIR/svndump
+	exit 1
+fi
+
+if test $rev -eq 0 ; then
+	mkdir -p $GIT_DIR/svndump/import && cd $GIT_DIR/svndump/import &&
+	svn import . $1 -m "Initial import by git-svndump"
+	if test $? -ne 0 ; then
+		echo "git-svndump-init: error: Failed to init $1"
+		rm -rf $GIT_DIR/svndump
+		exit 1
+	fi
+	rmdir $GIT_DIR/svndump/import
+fi
+
+echo "$1" > $GIT_DIR/svndump/url
+
+if test x$2 != x ; then
+	commit=`GIT_DIR=$GIT_DIR git-rev-list --max-count=1 $2`
+	if test $? -ne 0 ; then
+		echo "git-svndump-init: warning: Bad commit $2 ignored"
+	else
+		echo $commit >> $GIT_DIR/svndump/last
+	fi
+fi
diff --git a/git-svndump-sync.sh b/git-svndump-sync.sh
new file mode 100755
index 0000000..e1c04e1
--- /dev/null
+++ b/git-svndump-sync.sh
@@ -0,0 +1,85 @@
+#!/bin/sh
+
+usage()
+{
+	cat << EOF
+Usage: git-svndump-sync [<commit>]
+  <commit>       -- git <commit> that correspond to the latest revision
+                    to be dumped to the subversion repository
+EOF
+	exit 1
+}
+
+if test x$GIT_DIR = x ; then
+	if test -d ./.git ; then
+		GIT_DIR=`pwd`/.git
+	fi
+fi
+
+if test ! -d $GIT_DIR ; then
+	usage
+fi
+
+if test ! -d $GIT_DIR/svndump ; then
+	echo "git-svndump-sync: error: This git repository is not initialized"
+	echo "                         Run git-svndump-init first"
+	exit 1
+fi
+
+if test ! -f $GIT_DIR/svndump/url ; then
+	echo "git-svndump-sync: error: Cannot read url"
+	exit 1
+fi
+
+url=`cat $GIT_DIR/svndump/url`
+rev=`svn info $url >$GIT_DIR/svndump/error.log`
+if test $? -ne 0 ; then
+	echo git-svndump-sync: error: While quering $url
+	rm -rf $GIT_DIR/svndump/error.log
+	exit 1
+fi
+
+rev=`cat $GIT_DIR/svndump/error.log | sed -ne "/Revision/s/.* //p"`
+rm $GIT_DIR/svndump/error.log
+
+if test x$rev = x ; then
+	echo "git-svndump-init: error: Cannot determine the latest revision"
+	echo "                         at $url"
+	exit 1
+fi
+
+if test x$1 = x ; then
+	commit=HEAD
+else
+	commit=`GIT_DIR=$GIT_DIR git-rev-list --max-count=1 $1`
+	if test $? -ne 0 ; then
+		echo "git-svndump-sync: error: Bad commit '$1'"
+		exit 1
+	fi
+fi
+
+start=""
+last=0000000000000000000000000000000000000000
+if test -f $GIT_DIR/svndump/last ; then
+	last=`cat $GIT_DIR/svndump/last`
+	start=^`GIT_DIR=$GIT_DIR git-rev-list --max-count=1 $last`
+	if test $? -ne 0 ; then
+		echo "git-svndump-sync: warning: Ignoring bad commit '$last'"
+		start=""
+		last=0000000000000000000000000000000000000000
+	fi
+fi
+
+list=`GIT_DIR=$GIT_DIR git-rev-list $commit $start`
+
+diffs=""
+for c in $list ; do
+	diffs="$c $diffs"
+done
+
+for c in $diffs ; do
+	GIT_DIR=$GIT_DIR git-svn commit-diff -r$rev $last $c $url
+	echo "$c" > $GIT_DIR/svndump/last
+	last=$c
+	let rev++
+done
-- 
1.5.2.1
