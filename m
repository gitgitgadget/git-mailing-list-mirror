From: Theodore Ts'o <tytso@mit.edu>
Subject: [PATCH] mergetool: Replace use of "echo -n" with printf(3) to be more portable
Date: Thu, 29 Mar 2007 11:44:16 -0400
Message-ID: <11751830651770-git-send-email-tytso@mit.edu>
References: <11751830653554-git-send-email-tytso@mit.edu> <11751830653871-git-send-email-tytso@mit.edu>
Cc: git@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Mar 29 17:45:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HWwoI-0004BP-60
	for gcvg-git@gmane.org; Thu, 29 Mar 2007 17:45:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030275AbXC2Pof (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 29 Mar 2007 11:44:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030268AbXC2Poe
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Mar 2007 11:44:34 -0400
Received: from thunk.org ([69.25.196.29]:36582 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932411AbXC2Po3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Mar 2007 11:44:29 -0400
Received: from root (helo=candygram.thunk.org)
	by thunker.thunk.org with local-esmtps 
	(tls_cipher TLS-1.0:RSA_AES_256_CBC_SHA:32)  (Exim 4.50 #1 (Debian))
	id 1HWwtd-0007Iz-TM; Thu, 29 Mar 2007 11:50:42 -0400
Received: from tytso by candygram.thunk.org with local (Exim 4.62)
	(envelope-from <tytso@thunk.org>)
	id 1HWwnZ-0000xR-Dx; Thu, 29 Mar 2007 11:44:25 -0400
X-Mailer: git-send-email 1.5.1.rc2.1.g8afe-dirty
In-Reply-To: <11751830653871-git-send-email-tytso@mit.edu>
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43451>

Signed-off-by: "Theodore Ts'o" <tytso@mit.edu>
---
 git-mergetool.sh |   26 +++++++++++++-------------
 1 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/git-mergetool.sh b/git-mergetool.sh
index 7942fd0..3cc428c 100755
--- a/git-mergetool.sh
+++ b/git-mergetool.sh
@@ -44,18 +44,18 @@ function describe_file () {
     branch="$2"
     file="$3"
 
-    echo -n "    "
+    printf "    "
     if test -z "$mode"; then
-	echo -n "'$path' was deleted"
+	printf  "'$path' was deleted"
     elif is_symlink "$mode" ; then
-	echo -n "'$path' is a symlink containing '"
+	printf "'$path' is a symlink containing '"
 	cat "$file"
-	echo -n "'"
+	printf "'"
     else
 	if base_present; then
-	    echo -n "'$path' was created"
+	    printf "'%s' was created" "$path"
 	else
-	    echo -n "'$path' was modified"
+	    printf "'%s' was modified" "$path"
 	fi
     fi
     echo " in the $branch branch"
@@ -64,7 +64,7 @@ function describe_file () {
 
 resolve_symlink_merge () {
     while /bin/true; do
-	echo -n "Use (r)emote or (l)ocal, or (a)bort? "
+	printf "Use (r)emote or (l)ocal, or (a)bort? "
 	read ans
 	case "$ans" in
 	    [lL]*)
@@ -88,7 +88,7 @@ resolve_symlink_merge () {
 
 resolve_deleted_merge () {
     while /bin/true; do
-	echo -n "Use (m)odified or (d)eleted file, or (a)bort? "
+	printf "Use (m)odified or (d)eleted file, or (a)bort? "
 	read ans
 	case "$ans" in
 	    [mM]*)
@@ -157,7 +157,7 @@ merge_file () {
     echo "Normal merge conflict for $path:"
     describe_file "$local_mode" "local" "$LOCAL"
     describe_file "$remote_mode" "remote" "$REMOTE"
-    echo -n "Hit return to start merge resolution tool ($merge_tool): "
+    printf "Hit return to start merge resolution tool ($merge_tool): "
     read ans
 
     case "$merge_tool" in
@@ -193,7 +193,7 @@ merge_file () {
 	    else
 		while true; do
 		    echo "$path seems unchanged."
-		    echo -n "Was the merge successful? [y/n] "
+		    printf "Was the merge successful? [y/n] "
 		    read answer < /dev/tty
 		    case "$answer" in
 			y*|Y*) status=0; break ;;
@@ -225,7 +225,7 @@ merge_file () {
 	    else
 		while true; do
 		    echo "$path seems unchanged."
-		    echo -n "Was the merge successful? [y/n] "
+		    printf "Was the merge successful? [y/n] "
 		    read answer < /dev/tty
 		    case "$answer" in
 			y*|Y*) status=0; break ;;
@@ -346,12 +346,12 @@ if test $# -eq 0 ; then
 	echo Merging the files: $files
 	git ls-files -u | sed -e 's/^[^	]*	//' | sort -u | while read i
 	do
-		echo ""
+		printf "\n"
 		merge_file "$i" < /dev/tty > /dev/tty
 	done
 else
 	while test $# -gt 0; do
-		echo ""
+		printf "\n"
 		merge_file "$1"
 		shift
 	done
-- 
1.5.1.rc2.1.g8afe-dirty
