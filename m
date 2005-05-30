From: Jonas Fonseca <fonseca@diku.dk>
Subject: Re: [PATCH] Cleanup cogito command usage reporting
Date: Mon, 30 May 2005 05:05:21 +0200
Message-ID: <20050530030521.GA13232@diku.dk>
References: <20050530023603.GC10715@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 30 05:04:03 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DcaYz-0005Ow-Sh
	for gcvg-git@gmane.org; Mon, 30 May 2005 05:03:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261507AbVE3DF7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 29 May 2005 23:05:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261506AbVE3DF7
	(ORCPT <rfc822;git-outgoing>); Sun, 29 May 2005 23:05:59 -0400
Received: from nhugin.diku.dk ([130.225.96.140]:45268 "EHLO nhugin.diku.dk")
	by vger.kernel.org with ESMTP id S261507AbVE3DFX (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 29 May 2005 23:05:23 -0400
Received: by nhugin.diku.dk (Postfix, from userid 754)
	id 2E4D26E249E; Mon, 30 May 2005 05:04:50 +0200 (CEST)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP
	id C83116E2492; Mon, 30 May 2005 05:04:49 +0200 (CEST)
Received: by ask.diku.dk (Postfix, from userid 3873)
	id A4F1D61FE0; Mon, 30 May 2005 05:05:21 +0200 (CEST)
To: Petr Baudis <pasky@ucw.cz>
Content-Disposition: inline
In-Reply-To: <20050530023603.GC10715@diku.dk>
User-Agent: Mutt/1.5.6i
X-Spam-Status: No, hits=-4.9 required=5.0 tests=BAYES_00 autolearn=ham 
	version=2.60
X-Spam-Checker-Version: SpamAssassin 2.60 (1.212-2003-09-23-exp) on 
	nhugin.diku.dk
X-Spam-Level: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

[ Sorry for the resend. This should bring all usage strings in sync. I
  forgot to add the new options. ]

 - Synchronize usage strings with those in cg-help. The command
   identifiers are still not as descriptive, though.
 - Add usage utility function which uses the recently introduced USAGE
   variables.
 - Minor fix and improvement of cg-clone documentation.

Signed-off-by: Jonas Fonseca <fonseca@diku.dk>

---

 cg-Xlib       |    3 +++
 cg-add        |    2 +-
 cg-branch-add |    2 +-
 cg-clone      |    5 +++--
 cg-commit     |    4 ++--
 cg-diff       |    2 +-
 cg-export     |    2 +-
 cg-help       |    2 +-
 cg-log        |    2 +-
 cg-merge      |    4 ++--
 cg-mkpatch    |    2 +-
 cg-rm         |    2 +-
 cg-tag        |    2 +-
 13 files changed, 19 insertions(+), 15 deletions(-)

diff --git a/cg-Xlib b/cg-Xlib
--- a/cg-Xlib
+++ b/cg-Xlib
@@ -17,6 +17,9 @@ die () {
 	exit 1
 }
 
+usage() {
+	die "usage: $USAGE"
+}
 
 mktemp () {
 	if [ ! "$BROKEN_MKTEMP" ]; then
diff --git a/cg-add b/cg-add
--- a/cg-add
+++ b/cg-add
@@ -22,7 +22,7 @@ USAGE="cg-add FILE..."
 
 . ${COGITO_LIB}cg-Xlib
 
-[ "$1" ] || die "usage: cg-add FILE..."
+[ "$1" ] || usage
 
 TMPFILE=$(mktemp -t gitadd.XXXXXX)
 find "$@" -type f > $TMPFILE || die "not all files exist, nothing added"
diff --git a/cg-branch-add b/cg-branch-add
--- a/cg-branch-add
+++ b/cg-branch-add
@@ -42,7 +42,7 @@ USAGE="cg-branch-add BRANCH LOCATION"
 name=$1
 location=$2
 
-([ "$name" ] && [ "$location" ]) || die "usage: cg-branch-add NAME SOURCE_LOC"
+([ "$name" ] && [ "$location" ]) || usage
 (echo $name | egrep -qv '[^a-zA-Z0-9_.@!:-]') || \
 	die "name contains invalid characters"
 if [ "$name" = "this" ] || [ "$name" = "HEAD" ]; then
diff --git a/cg-clone b/cg-clone
--- a/cg-clone
+++ b/cg-clone
@@ -15,11 +15,12 @@
 # -------
 # -s::
 #	Clone in the current directory instead of creating a new one.
+#	Specifying both -s and a desination directory makes no sense.
 #
 # -h, --help::
 #	Print usage help
 
-USAGE="cg-clone [-s] LOCATION [<directory>]"
+USAGE="cg-clone [-s] LOCATION [DESTINATION]"
 
 . ${COGITO_LIB}cg-Xlib
 
@@ -30,7 +31,7 @@ if [ "$1" = "-s" ]; then
 fi
 
 location=$1
-[ "$location" ] || die "usage: cg-clone [-s] SOURCE_LOC [DESTDIR]"
+[ "$location" ] || usage
 location=${location%/}
 
 destdir=$2
diff --git a/cg-commit b/cg-commit
--- a/cg-commit
+++ b/cg-commit
@@ -20,7 +20,7 @@
 #	Note, this is used internally by Cogito when merging. This option
 #	does not make sense when files are given on the command line.
 #
-# -m<message>::
+# -mMESSAGE::
 #	Specify the commit message, which is used instead of starting
 #	up an editor (if the input is not `stdin`, the input is appended
 #	after all the '-m' messages). Multiple '-m' parameters are appended
@@ -75,7 +75,7 @@
 # EDITOR::
 #	The editor used for entering revision log information.
 
-USAGE="cg-commit [-m<message>]... [-C] [-e | -E] [FILE]..."
+USAGE="cg-commit [-mMESSAGE]... [-C] [-e | -E] [FILE]..."
 
 . ${COGITO_LIB}cg-Xlib
 
diff --git a/cg-diff b/cg-diff
--- a/cg-diff
+++ b/cg-diff
@@ -30,7 +30,7 @@
 # -h, --help::
 #	Print usage help.
 
-USAGE="cg-diff [-p] [-r REVISION[:REVISION]] [FILE]..."
+USAGE="cg-diff [-c] [-m] [-p] [-r REVISION[:REVISION]] [FILE]..."
 
 . ${COGITO_LIB}cg-Xlib
 
diff --git a/cg-export b/cg-export
--- a/cg-export
+++ b/cg-export
@@ -22,7 +22,7 @@ USAGE="cg-export DESTINATION [TREE]"
 dest=$1
 id=$(tree-id $2)
 
-([ "$dest" ] && [ "$id" ]) || die "usage: cg-export DEST [TREE_ID]"
+([ "$dest" ] && [ "$id" ]) || usage
 
 [ -e "$dest" ] && die "$dest already exists."
 
diff --git a/cg-help b/cg-help
--- a/cg-help
+++ b/cg-help
@@ -43,7 +43,7 @@ Available commands:
 	cg-export	DEST [TREE_ID]
 	cg-help		[COMMAND]
 	cg-init
-	cg-log		[-c] [-f] [-m] [-r FROM_ID[:TO_ID]] [FILE]...
+	cg-log		[-c] [-f] [-m] [-uUSERNAME] [-r FROM_ID[:TO_ID]] [FILE]...
 	cg-ls		[TREE_ID]
 	cg-merge	[-c] [-b BASE_ID] FROM_ID
 	cg-mkpatch	[-m] [-s] [-r FROM_ID[:TO_ID]]
diff --git a/cg-log b/cg-log
--- a/cg-log
+++ b/cg-log
@@ -58,7 +58,7 @@
 #
 #	$ cg-log -r releasetag-0.9:releasetag-0.10
 
-USAGE="cg-log [-c] [-f] [-uUSERNAME] [-r REVISION[:REVISION]] FILE..."
+USAGE="cg-log [-c] [-f] [-m] [-uUSERNAME] [-r REVISION[:REVISION]] FILE..."
 
 . ${COGITO_LIB}cg-Xlib
 # Try to fix the annoying "Broken pipe" output. May not help, but apparently
diff --git a/cg-merge b/cg-merge
--- a/cg-merge
+++ b/cg-merge
@@ -38,11 +38,11 @@ fi
 base=
 if [ "$1" = "-b" ]; then
 	shift
-	[ "$1" ] || die "usage: cg-merge [-c] [-b BASE_ID] FROM_ID"
+	[ "$1" ] || usage
 	base=$(commit-id "$1") || exit 1; shift
 fi
 
-[ "$1" ] || die "usage: cg-merge [-c] [-b BASE_ID] FROM_ID"
+[ "$1" ] || usage
 branchname="$1"
 branch=$(commit-id "$branchname") || exit 1
 
diff --git a/cg-mkpatch b/cg-mkpatch
--- a/cg-mkpatch
+++ b/cg-mkpatch
@@ -37,7 +37,7 @@
 # the line
 # `!-------------------------------------------------------------flip-`
 
-USAGE="cg-mkpatch [-s] [-r REVISION[:REVISION]]"
+USAGE="cg-mkpatch [-m] [-s] [-r REVISION[:REVISION]]"
 
 . ${COGITO_LIB}cg-Xlib
 
diff --git a/cg-rm b/cg-rm
--- a/cg-rm
+++ b/cg-rm
@@ -15,7 +15,7 @@ USAGE="cg-rm FILE..."
 
 . ${COGITO_LIB}cg-Xlib
 
-[ "$1" ] || die "usage: cg-rm FILE..."
+[ "$1" ] || usage
 
 rm -f "$@"
 git-update-cache --remove -- "$@"
diff --git a/cg-tag b/cg-tag
--- a/cg-tag
+++ b/cg-tag
@@ -20,7 +20,7 @@ USAGE="cg-tag TAG [REVISION]"
 name=$1
 id=$2
 
-[ "$name" ] || die "usage: cg-tag TNAME [COMMIT_ID]"
+[ "$name" ] || usage
 [ "$id" ] || id=$(commit-id)
 
 (echo $name | egrep -qv '[^a-zA-Z0-9_.@!:-]') || \
-- 
Jonas Fonseca
