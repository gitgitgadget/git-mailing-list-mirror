From: Jonas Fonseca <fonseca@diku.dk>
Subject: [PATCH Cogito] cg-diff: add -s option to summarize (diffstat) changes
Date: Sun, 2 Oct 2005 12:14:20 +0200
Message-ID: <20051002101419.GD9219@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 02 12:15:02 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EM0rQ-00052K-A5
	for gcvg-git@gmane.org; Sun, 02 Oct 2005 12:14:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751062AbVJBKOW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 2 Oct 2005 06:14:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751063AbVJBKOV
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Oct 2005 06:14:21 -0400
Received: from nhugin.diku.dk ([130.225.96.140]:12001 "EHLO nhugin.diku.dk")
	by vger.kernel.org with ESMTP id S1751061AbVJBKOV (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 2 Oct 2005 06:14:21 -0400
Received: by nhugin.diku.dk (Postfix, from userid 754)
	id EEBA26E1E1A; Sun,  2 Oct 2005 12:14:16 +0200 (CEST)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP
	id B0ACA6E193F; Sun,  2 Oct 2005 12:14:16 +0200 (CEST)
Received: by ask.diku.dk (Postfix, from userid 3873)
	id 2B95C60EF6; Sun,  2 Oct 2005 12:14:20 +0200 (CEST)
To: Petr Baudis <pasky@ucw.cz>
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
X-Spam-Checker-Version: SpamAssassin 2.60 (1.212-2003-09-23-exp) on 
	nhugin.diku.dk
X-Spam-Status: No, hits=-4.9 required=5.0 tests=BAYES_00 autolearn=ham 
	version=2.60
X-Spam-Level: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9613>

Pipes the diff output through git-apply --stat --summary.

Signed-off-by: Jonas Fonseca <fonseca@diku.dk>

---
commit 20282cdd610ecef03c8c97853bc0749ef3ab32b3
tree 6dd04a780217d116c44c1f78c5e831fc40a32df9
parent b41f8cafc556233613412ff3545e3507202b666a
author Jonas Fonseca <fonseca@diku.dk> Thu, 29 Sep 2005 15:09:42 +0200
committer Jonas Fonseca <fonseca@stud1-9.itu.dk> Thu, 29 Sep 2005 15:09:42 +0200

 cg-diff |   17 +++++++++++++++--
 1 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/cg-diff b/cg-diff
--- a/cg-diff
+++ b/cg-diff
@@ -17,6 +17,11 @@
 #	Instead of one ID denotes a parent commit to the specified ID
 #	(which must not be a tree, obviously).
 #
+# -s::
+#	Summarize the diff by showing a histogram for removed and added
+#	lines (similar to the output of diffstat(1)) and information
+#	about added and renamed files and mode changes.
+#
 # -r FROM_ID[:TO_ID]::
 #	Specify the revisions to diff using either '-r rev1:rev2' or
 #	'-r rev1 -r rev2'. If no revision is specified, the current
@@ -41,7 +46,7 @@
 #	to before invoking $PAGER. It defaults to $LESS concatenated
 #	with the `R` flag to allow displaying of colorized output.
 
-USAGE="cg-diff [-c] [-m] [-p] [-r FROM_ID[:TO_ID]] [FILE]..."
+USAGE="cg-diff [-c] [-m] [-s] [-p] [-r FROM_ID[:TO_ID]] [FILE]..."
 
 . ${COGITO_LIB}cg-Xlib || exit 1
 
@@ -65,7 +70,12 @@ setup_colors()
 
 colorize()
 {
-	if [ "$opt_color" ]; then
+	if [ "$opt_summary" ]; then
+		# Add an empty line so the diffstat indentation won't
+		# get messed up
+		echo
+		git-apply --summary --stat
+	elif [ "$opt_color" ]; then
 		gawk '
 		{ if (/^(diff --git) /)
 		    print "'$coldiffhdr'" $0 "'$coldefault'"
@@ -96,6 +106,7 @@ id2=" "
 parent=
 opt_color=
 mergebase=
+opt_summary=
 
 while optparse; do
 	if optparse -c; then
@@ -103,6 +114,8 @@ while optparse; do
 		setup_colors
 	elif optparse -p; then
 		parent=1
+	elif optparse -s; then
+		opt_summary=1
 	elif optparse -r=; then
 		if echo "$OPTARG" | fgrep -q '..'; then
 			id2=${OPTARG#*..}

-- 
Jonas Fonseca
