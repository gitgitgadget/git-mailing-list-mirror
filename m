From: Jonas Fonseca <fonseca@diku.dk>
Subject: [PATCH] Cleanup cogito command usage reporting
Date: Mon, 30 May 2005 04:36:03 +0200
Message-ID: <20050530023603.GC10715@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 30 04:34:50 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dca6h-0002IW-GG
	for gcvg-git@gmane.org; Mon, 30 May 2005 04:34:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261501AbVE3Cgh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 29 May 2005 22:36:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261499AbVE3Cge
	(ORCPT <rfc822;git-outgoing>); Sun, 29 May 2005 22:36:34 -0400
Received: from nhugin.diku.dk ([130.225.96.140]:43473 "EHLO nhugin.diku.dk")
	by vger.kernel.org with ESMTP id S261501AbVE3CgE (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 29 May 2005 22:36:04 -0400
Received: by nhugin.diku.dk (Postfix, from userid 754)
	id 178AC6E2446; Mon, 30 May 2005 04:35:31 +0200 (CEST)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP
	id 8E6466E2435; Mon, 30 May 2005 04:35:31 +0200 (CEST)
Received: by ask.diku.dk (Postfix, from userid 3873)
	id 61DA661FE0; Mon, 30 May 2005 04:36:03 +0200 (CEST)
To: Petr Baudis <pasky@ucw.cz>
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
X-Spam-Status: No, hits=-4.9 required=5.0 tests=BAYES_00 autolearn=ham 
	version=2.60
X-Spam-Checker-Version: SpamAssassin 2.60 (1.212-2003-09-23-exp) on 
	nhugin.diku.dk
X-Spam-Level: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Add usage utility function which uses the recently introduced USAGE variables.
Minor fix and improvement of cg-clone documentation.

Signed-off-by: Jonas Fonseca <fonseca@diku.dk>
---

 cg-Xlib       |    3 +++
 cg-add        |    2 +-
 cg-branch-add |    2 +-
 cg-clone      |    5 +++--
 cg-export     |    2 +-
 cg-merge      |    4 ++--
 cg-rm         |    2 +-
 cg-tag        |    2 +-
 8 files changed, 13 insertions(+), 9 deletions(-)

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
diff --git a/cg-export b/cg-export
--- a/cg-export
+++ b/cg-export
@@ -22,7 +22,7 @@ USAGE="cg-export DESTINATION [TREE]"
 dest=$1
 id=$(tree-id $2)
 
-([ "$dest" ] && [ "$id" ]) || die "usage: cg-export DEST [TREE_ID]"
+([ "$dest" ] && [ "$id" ]) || usage
 
 [ -e "$dest" ] && die "$dest already exists."
 
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
