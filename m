From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH] fetch/parse-remote: refs/remotes/* support
Date: Thu, 9 Mar 2006 03:54:52 -0800
Message-ID: <20060309115452.GA13369@localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Thu Mar 09 12:55:52 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FHJk9-0002xN-G2
	for gcvg-git@gmane.org; Thu, 09 Mar 2006 12:55:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751857AbWCILzn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 9 Mar 2006 06:55:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751867AbWCILzm
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Mar 2006 06:55:42 -0500
Received: from hand.yhbt.net ([66.150.188.102]:8642 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S1751859AbWCILzm (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Mar 2006 06:55:42 -0500
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id 991997DC005;
	Thu,  9 Mar 2006 03:55:40 -0800 (PST)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Thu,  9 Mar 2006 03:54:52 -0800
To: git <git@vger.kernel.org>, Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060126
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17413>

Signed-off-by: Eric Wong <normalperson@yhbt.net>

---

 git-fetch.sh        |    5 ++++-
 git-parse-remote.sh |    8 ++++----
 2 files changed, 8 insertions(+), 5 deletions(-)

34f9d6c64bd686f29db4cd410882aab607e1b628
diff --git a/git-fetch.sh b/git-fetch.sh
index 0346d4a..2748573 100755
--- a/git-fetch.sh
+++ b/git-fetch.sh
@@ -103,6 +103,9 @@ append_fetch_head () {
     refs/tags/*)
 	note_="$(expr "$remote_name_" : 'refs/tags/\(.*\)')"
 	note_="tag '$note_' of " ;;
+    refs/remotes/*)
+	note_="$(expr "$remote_name_" : 'refs/remotes/\(.*\)')"
+	note_="remote branch '$note_' of " ;;
     *)
 	note_="$remote_name of " ;;
     esac
@@ -150,7 +153,7 @@ fast_forward_local () {
 	git-update-ref "$1" "$2" 
 	;;
 
-    refs/heads/*)
+    refs/heads/* | refs/remotes/*)
 	# $1 is the ref being updated.
 	# $2 is the new value for the ref.
 	local=$(git-rev-parse --verify "$1^0" 2>/dev/null)
diff --git a/git-parse-remote.sh b/git-parse-remote.sh
index 5f158c6..63f2281 100755
--- a/git-parse-remote.sh
+++ b/git-parse-remote.sh
@@ -86,14 +86,14 @@ canon_refs_list_for_fetch () {
 		local=$(expr "$ref" : '[^:]*:\(.*\)')
 		case "$remote" in
 		'') remote=HEAD ;;
-		refs/heads/* | refs/tags/*) ;;
-		heads/* | tags/* ) remote="refs/$remote" ;;
+		refs/heads/* | refs/tags/* | refs/remotes/*) ;;
+		heads/* | tags/* | remotes/* ) remote="refs/$remote" ;;
 		*) remote="refs/heads/$remote" ;;
 		esac
 		case "$local" in
 		'') local= ;;
-		refs/heads/* | refs/tags/*) ;;
-		heads/* | tags/* ) local="refs/$local" ;;
+		refs/heads/* | refs/tags/* | refs/remotes/*) ;;
+		heads/* | tags/* | remotes/* ) local="refs/$local" ;;
 		*) local="refs/heads/$local" ;;
 		esac
 
-- 
1.2.4.ga2910
