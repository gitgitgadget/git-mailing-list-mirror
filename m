From: Alan Jenkins <alan.christopher.jenkins@googlemail.com>
Subject: [GUILT 5/6] Allow guilt scripts to be run from a directory which contains spaces
Date: Wed, 28 Sep 2011 15:15:23 +0100
Message-ID: <1317219324-10319-5-git-send-email-alan.christopher.jenkins@googlemail.com>
References: <1317219324-10319-1-git-send-email-alan.christopher.jenkins@googlemail.com>
Cc: git@vger.kernel.org,
	Alan Jenkins <alan.christopher.jenkins@googlemail.com>
To: jeffpc@josefsipek.net
X-From: git-owner@vger.kernel.org Wed Sep 28 16:17:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R8uwj-0007QS-5T
	for gcvg-git-2@lo.gmane.org; Wed, 28 Sep 2011 16:17:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754666Ab1I1ORD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Sep 2011 10:17:03 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:57348 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752643Ab1I1OQ4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Sep 2011 10:16:56 -0400
Received: by mail-wy0-f174.google.com with SMTP id 34so31170wyg.19
        for <git@vger.kernel.org>; Wed, 28 Sep 2011 07:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=MjXJFszCJOxoLn6p5QmunTnAYiaNmG3TV9pZqNTPRY4=;
        b=xU7jnt/KwTJq9D7ZBwnmrYNuJJmWPSVSCJiBCLllnJRLg9btr2CXC/VjeWMlGU3CsU
         ZMj1OEnadPt0t5LR0yeG6lauUW9fN27wB7KN9lMgXv2GA738VZWDymu/9kUVJ1X93Z/b
         jLBZ9qy82o1l2fYWRWyYbd5AvrKkxWMHOaHuc=
Received: by 10.216.220.209 with SMTP id o59mr820695wep.0.1317219415243;
        Wed, 28 Sep 2011 07:16:55 -0700 (PDT)
Received: from localhost.localdomain ([86.53.68.233])
        by mx.google.com with ESMTPS id n21sm40795936wbp.2.2011.09.28.07.16.53
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 28 Sep 2011 07:16:54 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <1317219324-10319-1-git-send-email-alan.christopher.jenkins@googlemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182324>

`dirname $0` breaks if $0 includes spaces.

I don't need this; it was the result of a mis-understanding.
But here it is anyway; take it if you think it's useful.

Signed-off-by: Alan Jenkins <alan.christopher.jenkins@googlemail.com>
---
 guilt               |   22 +++++++++++++---------
 guilt-add           |    2 +-
 guilt-applied       |    2 +-
 guilt-branch        |    2 +-
 guilt-commit        |    2 +-
 guilt-delete        |    2 +-
 guilt-diff          |    2 +-
 guilt-export        |    2 +-
 guilt-files         |    2 +-
 guilt-fold          |    2 +-
 guilt-fork          |    2 +-
 guilt-graph         |    2 +-
 guilt-guard         |    2 +-
 guilt-header        |    2 +-
 guilt-help          |    2 +-
 guilt-import        |    2 +-
 guilt-import-commit |    2 +-
 guilt-init          |    2 +-
 guilt-new           |    2 +-
 guilt-next          |    2 +-
 guilt-patchbomb     |    2 +-
 guilt-pop           |    2 +-
 guilt-prev          |    2 +-
 guilt-push          |    2 +-
 guilt-rebase        |    2 +-
 guilt-refresh       |    2 +-
 guilt-repair        |    2 +-
 guilt-rm            |    2 +-
 guilt-select        |    2 +-
 guilt-series        |    2 +-
 guilt-status        |    2 +-
 guilt-top           |    2 +-
 guilt-unapplied     |    2 +-
 33 files changed, 45 insertions(+), 41 deletions(-)

diff --git a/guilt b/guilt
index 9f06b41..45bdb66 100755
--- a/guilt
+++ b/guilt
@@ -6,12 +6,14 @@
 GUILT_VERSION="0.35"
 GUILT_NAME="Gloria"
 
+GUILT="$(basename "$0")"
+
 # If the first argument is one of the below, display the man page instead of
 # the rather silly and mostly useless usage string
 case $1 in
 	-h|--h|--he|--hel|--help)
 	shift
-	exec "guilt help" "`basename $0`"
+	exec "guilt help" "$GUILT"
 	exit
 	;;
 	-V|--ver|--versi|--versio|--version)
@@ -69,10 +71,12 @@ silent()
 
 ########
 
+GUILT_PATH="$(dirname "$0")"
+
 guilt_commands()
 {
-	find "`dirname $0`/../lib/guilt" -maxdepth 1 -name "guilt-*" -type f -perm +111 2> /dev/null | sed -e "s/.*\\/`basename $0`-//"
-	find "`dirname $0`" -maxdepth 1 -name "guilt-*" -type f -perm +111 | sed -e "s/.*\\/`basename $0`-//"
+	find "$GUILT_PATH/../lib/guilt" -maxdepth 1 -name "guilt-*" -type f -perm +111 2> /dev/null | sed -e "s/.*\\/$GUILT-//"
+	find "$GUILT_PATH" -maxdepth 1 -name "guilt-*" -type f -perm +111 | sed -e "s/.*\\/$GUILT-//"
 }
 
 # by default, we shouldn't fail
@@ -82,8 +86,8 @@ if [ $# -ne 0 ]; then
 	# take first arg, and try to execute it
 
 	arg="$1"
-	dir=`dirname $0`
-	libdir="`dirname $0`/../lib/guilt"
+	dir="$GUILT_PATH"
+	libdir="$GUILT_PATH/../lib/guilt"
 
 	if [ -x "$dir/guilt-$arg" ]; then
 		cmd="$dir/guilt-$arg"
@@ -870,10 +874,10 @@ pager="more"
 
 UNAME_S=`uname -s`
 
-if [ -r "`dirname $0`/os.$UNAME_S" ]; then
-	. "`dirname $0`/os.$UNAME_S"
-elif [ -r "`dirname $0`/../lib/guilt/os.$UNAME_S" ]; then
-	. "`dirname $0`/../lib/guilt/os.$UNAME_S"
+if [ -r "$GUILT_PATH/os.$UNAME_S" ]; then
+	. "$GUILT_PATH/os.$UNAME_S"
+elif [ -r "$GUILT_PATH/../lib/guilt/os.$UNAME_S" ]; then
+	. "$GUILT_PATH/../lib/guilt/os.$UNAME_S"
 else
 	die "Unsupported operating system: $UNAME_S"
 fi
diff --git a/guilt-add b/guilt-add
index 6529949..8a6b5a7 100755
--- a/guilt-add
+++ b/guilt-add
@@ -5,7 +5,7 @@
 
 USAGE="<file>..."
 if [ -z "$GUILT_VERSION" ]; then
-	echo "Invoking `basename $0` directly is no longer supported." >&2
+	echo "Invoking $GUILT directly is no longer supported." >&2
 	exit 1
 fi
 
diff --git a/guilt-applied b/guilt-applied
index a1f684a..a84f1f7 100755
--- a/guilt-applied
+++ b/guilt-applied
@@ -5,7 +5,7 @@
 
 USAGE="[-c]"
 if [ -z "$GUILT_VERSION" ]; then
-	echo "Invoking `basename $0` directly is no longer supported." >&2
+	echo "Invoking $GUILT directly is no longer supported." >&2
 	exit 1
 fi
 
diff --git a/guilt-branch b/guilt-branch
index 909f740..3e88321 100755
--- a/guilt-branch
+++ b/guilt-branch
@@ -5,7 +5,7 @@
 
 USAGE="[<new_name>]"
 if [ -z "$GUILT_VERSION" ]; then
-	echo "Invoking `basename $0` directly is no longer supported." >&2
+	echo "Invoking $GUILT directly is no longer supported." >&2
 	exit 1
 fi
 
diff --git a/guilt-commit b/guilt-commit
index 4228be6..4ef6605 100755
--- a/guilt-commit
+++ b/guilt-commit
@@ -5,7 +5,7 @@
 
 USAGE="-n <num> | -a | --all"
 if [ -z "$GUILT_VERSION" ]; then
-	echo "Invoking `basename $0` directly is no longer supported." >&2
+	echo "Invoking $GUILT directly is no longer supported." >&2
 	exit 1
 fi
 
diff --git a/guilt-delete b/guilt-delete
index 4ab9c94..551e6a4 100755
--- a/guilt-delete
+++ b/guilt-delete
@@ -5,7 +5,7 @@
 
 USAGE="[-f] <patchname>"
 if [ -z "$GUILT_VERSION" ]; then
-	echo "Invoking `basename $0` directly is no longer supported." >&2
+	echo "Invoking $GUILT directly is no longer supported." >&2
 	exit 1
 fi
 
diff --git a/guilt-diff b/guilt-diff
index 0061926..182fa59 100755
--- a/guilt-diff
+++ b/guilt-diff
@@ -5,7 +5,7 @@
 
 USAGE="[-z] [<path>...]"
 if [ -z "$GUILT_VERSION" ]; then
-	echo "Invoking `basename $0` directly is no longer supported." >&2
+	echo "Invoking $GUILT directly is no longer supported." >&2
 	exit 1
 fi
 
diff --git a/guilt-export b/guilt-export
index 8361902..62c1ef6 100755
--- a/guilt-export
+++ b/guilt-export
@@ -5,7 +5,7 @@
 
 USAGE="[<target_dir>]"
 if [ -z "$GUILT_VERSION" ]; then
-	echo "Invoking `basename $0` directly is no longer supported." >&2
+	echo "Invoking $GUILT directly is no longer supported." >&2
 	exit 1
 fi
 
diff --git a/guilt-files b/guilt-files
index f31a94c..aab35d5 100755
--- a/guilt-files
+++ b/guilt-files
@@ -5,7 +5,7 @@
 
 USAGE="[-v] [-a] [-l]"
 if [ -z "$GUILT_VERSION" ]; then
-	echo "Invoking `basename $0` directly is no longer supported." >&2
+	echo "Invoking $GUILT directly is no longer supported." >&2
 	exit 1
 fi
 
diff --git a/guilt-fold b/guilt-fold
index 06fbb7f..07d77a1 100755
--- a/guilt-fold
+++ b/guilt-fold
@@ -5,7 +5,7 @@
 
 USAGE="[-k] <patchname>"
 if [ -z "$GUILT_VERSION" ]; then
-	echo "Invoking `basename $0` directly is no longer supported." >&2
+	echo "Invoking $GUILT directly is no longer supported." >&2
 	exit 1
 fi
 
diff --git a/guilt-fork b/guilt-fork
index 8d58ffd..5677e1b 100755
--- a/guilt-fork
+++ b/guilt-fork
@@ -5,7 +5,7 @@
 
 USAGE="[<new_name>]"
 if [ -z "$GUILT_VERSION" ]; then
-	echo "Invoking `basename $0` directly is no longer supported." >&2
+	echo "Invoking $GUILT directly is no longer supported." >&2
 	exit 1
 fi
 
diff --git a/guilt-graph b/guilt-graph
index 496a831..1c9fade 100755
--- a/guilt-graph
+++ b/guilt-graph
@@ -5,7 +5,7 @@
 
 USAGE="[<patchname>]"
 if [ -z "$GUILT_VERSION" ]; then
-	echo "Invoking `basename $0` directly is no longer supported." >&2
+	echo "Invoking $GUILT directly is no longer supported." >&2
 	exit 1
 fi
 
diff --git a/guilt-guard b/guilt-guard
index 2c12fca..ada7f45 100755
--- a/guilt-guard
+++ b/guilt-guard
@@ -5,7 +5,7 @@
 
 USAGE="[-l | --list | -n | --none | [<patchname>] [(+|-)<guard>...]]"
 if [ -z "$GUILT_VERSION" ]; then
-	echo "Invoking `basename $0` directly is no longer supported." >&2
+	echo "Invoking $GUILT directly is no longer supported." >&2
 	exit 1
 fi
 
diff --git a/guilt-header b/guilt-header
index 9910708..19cfd45 100755
--- a/guilt-header
+++ b/guilt-header
@@ -5,7 +5,7 @@
 
 USAGE="[-eE] [<patchname>]"
 if [ -z "$GUILT_VERSION" ]; then
-	echo "Invoking `basename $0` directly is no longer supported." >&2
+	echo "Invoking $GUILT directly is no longer supported." >&2
 	exit 1
 fi
 
diff --git a/guilt-help b/guilt-help
index e1807a8..001ddfb 100755
--- a/guilt-help
+++ b/guilt-help
@@ -7,7 +7,7 @@ DO_NOT_CHECK_BRANCH_EXISTENCE=1
 
 USAGE="[<command> | <topic>]"
 if [ -z "$GUILT_VERSION" ]; then
-	echo "Invoking `basename $0` directly is no longer supported." >&2
+	echo "Invoking $GUILT directly is no longer supported." >&2
 	exit 1
 fi
 
diff --git a/guilt-import b/guilt-import
index 72ba7c3..041d20a 100755
--- a/guilt-import
+++ b/guilt-import
@@ -5,7 +5,7 @@
 
 USAGE="[-P <patch> ] <patch_file>"
 if [ -z "$GUILT_VERSION" ]; then
-	echo "Invoking `basename $0` directly is no longer supported." >&2
+	echo "Invoking $GUILT directly is no longer supported." >&2
 	exit 1
 fi
 
diff --git a/guilt-import-commit b/guilt-import-commit
index 3045a5f..1784f26 100755
--- a/guilt-import-commit
+++ b/guilt-import-commit
@@ -5,7 +5,7 @@
 
 USAGE="[<hash> | <since>..[<until>] | ..<until>]"
 if [ -z "$GUILT_VERSION" ]; then
-	echo "Invoking `basename $0` directly is no longer supported." >&2
+	echo "Invoking $GUILT directly is no longer supported." >&2
 	exit 1
 fi
 
diff --git a/guilt-init b/guilt-init
index 646e24b..148699c 100755
--- a/guilt-init
+++ b/guilt-init
@@ -7,7 +7,7 @@ DO_NOT_CHECK_BRANCH_EXISTENCE=1
 
 USAGE=""
 if [ -z "$GUILT_VERSION" ]; then
-	echo "Invoking `basename $0` directly is no longer supported." >&2
+	echo "Invoking $GUILT directly is no longer supported." >&2
 	exit 1
 fi
 
diff --git a/guilt-new b/guilt-new
index 402104e..0803063 100755
--- a/guilt-new
+++ b/guilt-new
@@ -5,7 +5,7 @@
 
 USAGE="[-f] [-s] [-e|-m message] <patchname>"
 if [ -z "$GUILT_VERSION" ]; then
-	echo "Invoking `basename $0` directly is no longer supported." >&2
+	echo "Invoking $GUILT directly is no longer supported." >&2
 	exit 1
 fi
 
diff --git a/guilt-next b/guilt-next
index a0941fc..c7263f1 100755
--- a/guilt-next
+++ b/guilt-next
@@ -5,7 +5,7 @@
 
 USAGE="[-p|--path]"
 if [ -z "$GUILT_VERSION" ]; then
-	echo "Invoking `basename $0` directly is no longer supported." >&2
+	echo "Invoking $GUILT directly is no longer supported." >&2
 	exit 1
 fi
 
diff --git a/guilt-patchbomb b/guilt-patchbomb
index b72a706..c61cd1b 100755
--- a/guilt-patchbomb
+++ b/guilt-patchbomb
@@ -7,7 +7,7 @@ DO_NOT_CHECK_BRANCH_EXISTENCE=1
 
 USAGE="[-n] [-s] [--in-reply-to <msgid>] [--git] [--subject-prefix <prefix>] [<hash> | <since>..[<until>] | ..<until>]"
 if [ -z "$GUILT_VERSION" ]; then
-	echo "Invoking `basename $0` directly is no longer supported." >&2
+	echo "Invoking $GUILT directly is no longer supported." >&2
 	exit 1
 fi
 
diff --git a/guilt-pop b/guilt-pop
index df466c7..1e36f00 100755
--- a/guilt-pop
+++ b/guilt-pop
@@ -5,7 +5,7 @@
 
 USAGE="[-f] [-a | --all | -n <num> | <patchname>]"
 if [ -z "$GUILT_VERSION" ]; then
-	echo "Invoking `basename $0` directly is no longer supported." >&2
+	echo "Invoking $GUILT directly is no longer supported." >&2
 	exit 1
 fi
 
diff --git a/guilt-prev b/guilt-prev
index d454030..31c054c 100755
--- a/guilt-prev
+++ b/guilt-prev
@@ -5,7 +5,7 @@
 
 USAGE="[-p|--path]"
 if [ -z "$GUILT_VERSION" ]; then
-	echo "Invoking `basename $0` directly is no longer supported." >&2
+	echo "Invoking $GUILT directly is no longer supported." >&2
 	exit 1
 fi
 
diff --git a/guilt-push b/guilt-push
index d9a8590..4a54d07 100755
--- a/guilt-push
+++ b/guilt-push
@@ -5,7 +5,7 @@
 
 USAGE="[ -f ] [-a | --all | -n <num> | <patchname>]"
 if [ -z "$GUILT_VERSION" ]; then
-	echo "Invoking `basename $0` directly is no longer supported." >&2
+	echo "Invoking $GUILT directly is no longer supported." >&2
 	exit 1
 fi
 
diff --git a/guilt-rebase b/guilt-rebase
index 614ba22..c33022f 100755
--- a/guilt-rebase
+++ b/guilt-rebase
@@ -7,7 +7,7 @@
 
 USAGE="<upstream>"
 if [ -z "$GUILT_VERSION" ]; then
-	echo "Invoking `basename $0` directly is no longer supported." >&2
+	echo "Invoking $GUILT directly is no longer supported." >&2
 	exit 1
 fi
 
diff --git a/guilt-refresh b/guilt-refresh
index f764937..4e22929 100755
--- a/guilt-refresh
+++ b/guilt-refresh
@@ -5,7 +5,7 @@
 
 USAGE="[--git] [--diffstat]"
 if [ -z "$GUILT_VERSION" ]; then
-	echo "Invoking `basename $0` directly is no longer supported." >&2
+	echo "Invoking $GUILT directly is no longer supported." >&2
 	exit 1
 fi
 
diff --git a/guilt-repair b/guilt-repair
index 77ad223..99df731 100755
--- a/guilt-repair
+++ b/guilt-repair
@@ -7,7 +7,7 @@ DO_NOT_CHECK_STATUS_FILE_FORMAT=1
 
 USAGE="--full | --status"
 if [ -z "$GUILT_VERSION" ]; then
-	echo "Invoking `basename $0` directly is no longer supported." >&2
+	echo "Invoking $GUILT directly is no longer supported." >&2
 	exit 1
 fi
 
diff --git a/guilt-rm b/guilt-rm
index 351ec93..d68622b 100755
--- a/guilt-rm
+++ b/guilt-rm
@@ -5,7 +5,7 @@
 
 USAGE="<file>..."
 if [ -z "$GUILT_VERSION" ]; then
-	echo "Invoking `basename $0` directly is no longer supported." >&2
+	echo "Invoking $GUILT directly is no longer supported." >&2
 	exit 1
 fi
 
diff --git a/guilt-select b/guilt-select
index 8b139d4..fb7941b 100755
--- a/guilt-select
+++ b/guilt-select
@@ -5,7 +5,7 @@
 
 USAGE="[ -n | --none | -s | --series | [--pop|--reapply] <guards...> ]"
 if [ -z "$GUILT_VERSION" ]; then
-	echo "Invoking `basename $0` directly is no longer supported." >&2
+	echo "Invoking $GUILT directly is no longer supported." >&2
 	exit 1
 fi
 
diff --git a/guilt-series b/guilt-series
index c87b31e..f8cd7c7 100755
--- a/guilt-series
+++ b/guilt-series
@@ -5,7 +5,7 @@
 
 USAGE="[-v | -g | -e]"
 if [ -z "$GUILT_VERSION" ]; then
-	echo "Invoking `basename $0` directly is no longer supported." >&2
+	echo "Invoking $GUILT directly is no longer supported." >&2
 	exit 1
 fi
 
diff --git a/guilt-status b/guilt-status
index c701fd1..b4cd1eb 100755
--- a/guilt-status
+++ b/guilt-status
@@ -5,7 +5,7 @@
 
 USAGE="[-a|-A] [-c|-C] [-d|-D] [-m|-M] [-r|-R] [-t|-T] [-u|-U] [-x|-X] [-n]"
 if [ -z "$GUILT_VERSION" ]; then
-	echo "Invoking `basename $0` directly is no longer supported." >&2
+	echo "Invoking $GUILT directly is no longer supported." >&2
 	exit 1
 fi
 
diff --git a/guilt-top b/guilt-top
index 3b1d596..6215009 100755
--- a/guilt-top
+++ b/guilt-top
@@ -5,7 +5,7 @@
 
 USAGE="[-p|--path]"
 if [ -z "$GUILT_VERSION" ]; then
-	echo "Invoking `basename $0` directly is no longer supported." >&2
+	echo "Invoking $GUILT directly is no longer supported." >&2
 	exit 1
 fi
 
diff --git a/guilt-unapplied b/guilt-unapplied
index e703408..9aec87a 100755
--- a/guilt-unapplied
+++ b/guilt-unapplied
@@ -5,7 +5,7 @@
 
 USAGE=""
 if [ -z "$GUILT_VERSION" ]; then
-	echo "Invoking `basename $0` directly is no longer supported." >&2
+	echo "Invoking $GUILT directly is no longer supported." >&2
 	exit 1
 fi
 
-- 
1.7.4.1
