From: Sergey Yanovich <ynvich@gmail.com>
Subject: [PATCH 2/3] 'git-svndump'
Date: Mon, 18 Jun 2007 15:14:03 +0300
Message-ID: <11821688462290-git-send-email-ynvich@gmail.com>
References: vpqhcp6b85c.fsf@bauges.imag.fr
 <11821688443683-git-send-email-ynvich@gmail.com>
 <11821688461828-git-send-email-ynvich@gmail.com>
Cc: Sergey Yanovich <ynvich@gmail.com>
To: git@vger.kernel.org, normalperson@yhbt.net, Matthieu.Moy@imag.fr
X-From: git-owner@vger.kernel.org Mon Jun 18 14:14:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I0G84-00085F-RH
	for gcvg-git@gmane.org; Mon, 18 Jun 2007 14:14:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761612AbXFRMNQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 18 Jun 2007 08:13:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761571AbXFRMNP
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Jun 2007 08:13:15 -0400
Received: from mu-out-0910.google.com ([209.85.134.185]:46621 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761488AbXFRMNJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jun 2007 08:13:09 -0400
Received: by mu-out-0910.google.com with SMTP id i10so2145418mue
        for <git@vger.kernel.org>; Mon, 18 Jun 2007 05:13:07 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references:message-id:in-reply-to:references;
        b=CucOVl80LpQ+pAijiVdPafziM5W4O4sgvY5Ze24aBZUq76rrUx6OoE2iZQEk/qMJ7kYUMKrvpAbwGGVCjuHNk1YUb7jwt7qcHfBpMJF0zt4/ExNguiYtHsKOGWFEMKd8jgAGMQi7T4Seck8/VXarUfkRRVqbQt7IRmcNjBgBdr8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=geWXtysg9sZanDVEyQqylIruzfXx1zug5/RLjaYcXvLyGDn57cCuIIMNoybgAr25PEd/f+DRlQlVTcZN577KfteBdoHjnDSSeqjRalJ7LoOWPy/0urBRX2nv3adqmp7K7cnyFQS0UtbrwLBqDHdzErZ79hXnEvJOiwRBjklzv4A=
Received: by 10.82.127.14 with SMTP id z14mr11099356buc.1182168786415;
        Mon, 18 Jun 2007 05:13:06 -0700 (PDT)
Received: from host3 ( [87.252.237.202])
        by mx.google.com with ESMTP id z40sm9529978ikz.2007.06.18.05.13.03
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 18 Jun 2007 05:13:05 -0700 (PDT)
Received: from sergei by host3 with local (Exim 4.63)
	(envelope-from <ynvich@gmail.com>)
	id 1I0G7S-0001Ry-NJ; Mon, 18 Jun 2007 15:14:06 +0300
X-Mailer: git-send-email 1.5.2.1
In-Reply-To: <11821688461828-git-send-email-ynvich@gmail.com>
Message-Id: <98e24b3eb0a0d34100d5ab9db052efaaa140c4ac.1182168501.git.ynvich@gmail.com>
In-Reply-To: <4e79874760c3773448d886608d6db7bbda3c97f2.1182168501.git.ynvich@gmail.com>
References: <4e79874760c3773448d886608d6db7bbda3c97f2.1182168501.git.ynvich@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


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
