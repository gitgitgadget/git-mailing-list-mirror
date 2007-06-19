From: Sergey Yanovich <ynvich@gmail.com>
Subject: [PATCH 2/3] 'git-svndump'
Date: Tue, 19 Jun 2007 09:54:36 +0300
Message-ID: <11822360772830-git-send-email-ynvich@gmail.com>
References: 11821688443683-git-send-email-ynvich@gmail.com
 <11822360772759-git-send-email-ynvich@gmail.com>
Cc: Sergey Yanovich <ynvich@gmail.com>
To: git@vger.kernel.org, normalperson@yhbt.net, J.Sixt@eudaptics.com,
	masterdriverz@gmail.com
X-From: git-owner@vger.kernel.org Tue Jun 19 08:53:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I0Xb6-0005SR-84
	for gcvg-git@gmane.org; Tue, 19 Jun 2007 08:53:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755997AbXFSGxk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Jun 2007 02:53:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755697AbXFSGxk
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Jun 2007 02:53:40 -0400
Received: from hu-out-0506.google.com ([72.14.214.230]:63012 "EHLO
	hu-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755902AbXFSGxh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jun 2007 02:53:37 -0400
Received: by hu-out-0506.google.com with SMTP id 19so874862hue
        for <git@vger.kernel.org>; Mon, 18 Jun 2007 23:53:36 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references:message-id:in-reply-to:references;
        b=V4Ao50TQLMva/DPcIZONAcyHXNFF8tWGPPx8zQvut8n5k6i4q2xESaZW10DL8lb98RvHks0EiNHhUaWMyBoTq/dQZUHniJUdqcCm8dqQI8EbiRPZ1F+QvPiooIaHfzMdDZjYjYpGKvqexLvcy1KpU7ceXrZwaQaE5dxvt+vcUmk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=pvtKynuZTL1sif2mVv3o4Z3jZJKdzOVI8rYdpm+zd1nxiaRyq46IMK4pNHJzvdrk5ravzRgNbkkB+W+28uG3Fwy17v9AFdRNib1Lf5uD3iGiYSl0/yBDuDoVnf4r3KEOLGAEEf0IlYHmVXkGsPmHEyWS8/z6EM7fBcHeKKXrx7A=
Received: by 10.78.130.6 with SMTP id c6mr2666473hud.1182236015512;
        Mon, 18 Jun 2007 23:53:35 -0700 (PDT)
Received: from host3 ( [87.252.237.202])
        by mx.google.com with ESMTP id 11sm3450895hug.2007.06.18.23.53.33
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 18 Jun 2007 23:53:34 -0700 (PDT)
Received: from sergei by host3 with local (Exim 4.63)
	(envelope-from <ynvich@gmail.com>)
	id 1I0Xbp-0003Tn-TC; Tue, 19 Jun 2007 09:54:37 +0300
X-Mailer: git-send-email 1.5.2.1
In-Reply-To: <11822360772759-git-send-email-ynvich@gmail.com>
Message-Id: <7d5543ebd8ac45e49a6d3f300e988189561512f1.1182235492.git.ynvich@gmail.com>
In-Reply-To: <cff8d32813e43d9e1c75ad50824d95dbcd6f669c.1182235491.git.ynvich@gmail.com>
References: <cff8d32813e43d9e1c75ad50824d95dbcd6f669c.1182235491.git.ynvich@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

A git tool to keep a subversion mirror

git-svndump is essentially a wrapper around 'git-svn commit-diff'. It
will work only when it is the sole method of committing to the
Subversion repository.

It is designed to export a linear git branch. However, thanks to the way
'git' handles source code, 'git-svndump' seems to work in other
conditions. For example, when branches are switched or merged.

git-svndump provides a solution when you need to export your source code
in Subversion format (who would need this with git :), but do not want
to have all the shackles that 'git-svn init' puts on your repository.

Signed-off-by: Sergey Yanovich <ynvich@gmail.com>
---
 Documentation/git-svndump.txt |   97 ++++++++++++++++++++++++++++++++++++++++
 Makefile                      |    1 +
 git-svndump-init.sh           |   85 +++++++++++++++++++++++++++++++++++
 git-svndump-sync.sh           |   98 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 281 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/git-svndump.txt
 create mode 100755 git-svndump-init.sh
 create mode 100755 git-svndump-sync.sh

diff --git a/Documentation/git-svndump.txt b/Documentation/git-svndump.txt
new file mode 100644
index 0000000..11e7e79
--- /dev/null
+++ b/Documentation/git-svndump.txt
@@ -0,0 +1,97 @@
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
+git-svndump provides a solution when you need to export your source code
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
+'sync'::
+	Commit git revisions to the Subversion repository. If a git
+	<tree-ish> is specified as an optional command-line argument,
+	than all commits between the last 'sync' and that <tree-ish> are
+	send. If the argument is omitted, the HEAD of the active branch
+	is used.
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
diff --git a/Makefile b/Makefile
index c09dfaf..ecf2803 100644
--- a/Makefile
+++ b/Makefile
@@ -211,6 +211,7 @@ SCRIPT_SH = \
 	git-am.sh \
 	git-merge.sh git-merge-stupid.sh git-merge-octopus.sh \
 	git-merge-resolve.sh git-merge-ours.sh \
+	git-svndump-init.sh git-svndump-sync.sh \
 	git-lost-found.sh git-quiltimport.sh git-submodule.sh
 
 SCRIPT_PERL = \
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
index 0000000..602af72
--- /dev/null
+++ b/git-svndump-sync.sh
@@ -0,0 +1,98 @@
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
+while true ; do
+
+list=`GIT_DIR=$GIT_DIR git-rev-list --topo-order $commit $start | tail -n 8`
+
+if test -z "$list" ; then
+	exit 0
+fi
+
+diffs=""
+for c in $list ; do
+	diffs="$c $diffs"
+done
+
+for c in $diffs ; do
+	GIT_DIR=$GIT_DIR git-svn commit-diff -r$rev $last $c $url
+	if test $? -ne 0 ; then
+		exit $?
+	fi
+	echo "$c" > $GIT_DIR/svndump/last
+	last=$c
+	let rev++
+done
+
+start=^$last
+
+done
-- 
1.5.2.1
