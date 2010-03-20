From: Ben Walton <bwalton@artsci.utoronto.ca>
Subject: [PATCH 2/2] Modernize git calling conventions in hook templates
Date: Sat, 20 Mar 2010 10:48:09 -0400
Message-ID: <1269096489-12750-3-git-send-email-bwalton@artsci.utoronto.ca>
References: <1269096489-12750-1-git-send-email-bwalton@artsci.utoronto.ca>
Cc: Ben Walton <bwalton@artsci.utoronto.ca>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 20 15:48:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nszyj-0001PB-Su
	for gcvg-git-2@lo.gmane.org; Sat, 20 Mar 2010 15:48:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753008Ab0CTOs1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Mar 2010 10:48:27 -0400
Received: from www.cquest.utoronto.ca ([192.82.128.5]:53020 "EHLO
	www.cquest.utoronto.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752947Ab0CTOsX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Mar 2010 10:48:23 -0400
Received: from pinkfloyd.chass.utoronto.ca ([128.100.160.254]:42663 ident=93)
	by www.cquest.utoronto.ca with esmtp (Exim 4.43)
	id 1NszyQ-0002x4-Kf; Sat, 20 Mar 2010 10:48:22 -0400
Received: from bwalton by pinkfloyd.chass.utoronto.ca with local (Exim 4.63)
	(envelope-from <bwalton@cquest.utoronto.ca>)
	id 1NszyQ-0003KI-Jo; Sat, 20 Mar 2010 10:48:22 -0400
X-Mailer: git-send-email 1.7.0
In-Reply-To: <1269096489-12750-1-git-send-email-bwalton@artsci.utoronto.ca>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142713>

The hook templates were still using/referencing 'git-foo' instead of
'git foo.'  This patch updates the sample hooks to use the modern
conventions instead.

Signed-off-by: Ben Walton <bwalton@artsci.utoronto.ca>
---
 templates/hooks--commit-msg.sample         |    2 +-
 templates/hooks--post-update.sample        |    2 +-
 templates/hooks--pre-commit.sample         |    4 ++--
 templates/hooks--pre-rebase.sample         |   18 +++++++++---------
 templates/hooks--prepare-commit-msg.sample |    2 +-
 templates/hooks--update.sample             |    4 ++--
 templates/info--exclude                    |    2 +-
 7 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/templates/hooks--commit-msg.sample b/templates/hooks--commit-msg.sample
index 6ef1d29..b58d118 100755
--- a/templates/hooks--commit-msg.sample
+++ b/templates/hooks--commit-msg.sample
@@ -1,7 +1,7 @@
 #!/bin/sh
 #
 # An example hook script to check the commit log message.
-# Called by git-commit with one argument, the name of the file
+# Called by "git commit" with one argument, the name of the file
 # that has the commit message.  The hook should exit with non-zero
 # status after issuing an appropriate message if it wants to stop the
 # commit.  The hook is allowed to edit the commit message file.
diff --git a/templates/hooks--post-update.sample b/templates/hooks--post-update.sample
index 5323b56..ec17ec1 100755
--- a/templates/hooks--post-update.sample
+++ b/templates/hooks--post-update.sample
@@ -5,4 +5,4 @@
 #
 # To enable this hook, rename this file to "post-update".
 
-exec git-update-server-info
+exec git update-server-info
diff --git a/templates/hooks--pre-commit.sample b/templates/hooks--pre-commit.sample
index 439eefd..b187c4b 100755
--- a/templates/hooks--pre-commit.sample
+++ b/templates/hooks--pre-commit.sample
@@ -1,13 +1,13 @@
 #!/bin/sh
 #
 # An example hook script to verify what is about to be committed.
-# Called by git-commit with no arguments.  The hook should
+# Called by "git commit" with no arguments.  The hook should
 # exit with non-zero status after issuing an appropriate message if
 # it wants to stop the commit.
 #
 # To enable this hook, rename this file to "pre-commit".
 
-if git-rev-parse --verify HEAD >/dev/null 2>&1
+if git rev-parse --verify HEAD >/dev/null 2>&1
 then
 	against=HEAD
 else
diff --git a/templates/hooks--pre-rebase.sample b/templates/hooks--pre-rebase.sample
index ab1c4c8..053f111 100755
--- a/templates/hooks--pre-rebase.sample
+++ b/templates/hooks--pre-rebase.sample
@@ -2,7 +2,7 @@
 #
 # Copyright (c) 2006, 2008 Junio C Hamano
 #
-# The "pre-rebase" hook is run just before "git-rebase" starts doing
+# The "pre-rebase" hook is run just before "git rebase" starts doing
 # its job, and can prevent the command from running by exiting with
 # non-zero status.
 #
@@ -43,7 +43,7 @@ git show-ref -q "$topic" || {
 }
 
 # Is topic fully merged to master?
-not_in_master=`git-rev-list --pretty=oneline ^master "$topic"`
+not_in_master=`git rev-list --pretty=oneline ^master "$topic"`
 if test -z "$not_in_master"
 then
 	echo >&2 "$topic is fully merged to master; better remove it."
@@ -51,11 +51,11 @@ then
 fi
 
 # Is topic ever merged to next?  If so you should not be rebasing it.
-only_next_1=`git-rev-list ^master "^$topic" ${publish} | sort`
-only_next_2=`git-rev-list ^master           ${publish} | sort`
+only_next_1=`git rev-list ^master "^$topic" ${publish} | sort`
+only_next_2=`git rev-list ^master           ${publish} | sort`
 if test "$only_next_1" = "$only_next_2"
 then
-	not_in_topic=`git-rev-list "^$topic" master`
+	not_in_topic=`git rev-list "^$topic" master`
 	if test -z "$not_in_topic"
 	then
 		echo >&2 "$topic is already up-to-date with master"
@@ -64,7 +64,7 @@ then
 		exit 0
 	fi
 else
-	not_in_next=`git-rev-list --pretty=oneline ^${publish} "$topic"`
+	not_in_next=`git rev-list --pretty=oneline ^${publish} "$topic"`
 	@PERL_PATH@ -e '
 		my $topic = $ARGV[0];
 		my $msg = "* $topic has commits already merged to public branch:\n";
@@ -157,13 +157,13 @@ B to be deleted.
 
 To compute (1):
 
-	git-rev-list ^master ^topic next
-	git-rev-list ^master        next
+	git rev-list ^master ^topic next
+	git rev-list ^master        next
 
 	if these match, topic has not merged in next at all.
 
 To compute (2):
 
-	git-rev-list master..topic
+	git rev-list master..topic
 
 	if this is empty, it is fully merged to "master".
diff --git a/templates/hooks--prepare-commit-msg.sample b/templates/hooks--prepare-commit-msg.sample
index e8d1754..86b8f22 100755
--- a/templates/hooks--prepare-commit-msg.sample
+++ b/templates/hooks--prepare-commit-msg.sample
@@ -1,7 +1,7 @@
 #!/bin/sh
 #
 # An example hook script to prepare the commit log message.
-# Called by git-commit with the name of the file that has the
+# Called by "git commit" with the name of the file that has the
 # commit message, followed by the description of the commit
 # message's source.  The hook's purpose is to edit the commit
 # message file.  If the hook fails with a non-zero status,
diff --git a/templates/hooks--update.sample b/templates/hooks--update.sample
index fd63b2d..71ab04e 100755
--- a/templates/hooks--update.sample
+++ b/templates/hooks--update.sample
@@ -1,7 +1,7 @@
 #!/bin/sh
 #
 # An example hook script to blocks unannotated tags from entering.
-# Called by git-receive-pack with arguments: refname sha1-old sha1-new
+# Called by "git receive-pack" with arguments: refname sha1-old sha1-new
 #
 # To enable this hook, rename this file to "update".
 #
@@ -64,7 +64,7 @@ zero="0000000000000000000000000000000000000000"
 if [ "$newrev" = "$zero" ]; then
 	newrev_type=delete
 else
-	newrev_type=$(git-cat-file -t $newrev)
+	newrev_type=$(git cat-file -t $newrev)
 fi
 
 case "$refname","$newrev_type" in
diff --git a/templates/info--exclude b/templates/info--exclude
index 2c87b72..a5196d1 100644
--- a/templates/info--exclude
+++ b/templates/info--exclude
@@ -1,4 +1,4 @@
-# git-ls-files --others --exclude-from=.git/info/exclude
+# git ls-files --others --exclude-from=.git/info/exclude
 # Lines that start with '#' are comments.
 # For a project mostly in C, the following would be a good set of
 # exclude patterns (uncomment them if you want to use them):
-- 
1.7.0
