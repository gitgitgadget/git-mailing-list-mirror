From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH v2 2/5] git-am: take advantage of gettextln and eval_gettextln.
Date: Sun,  7 Aug 2011 21:58:14 +1000
Message-ID: <1312718297-10999-3-git-send-email-jon.seymour@gmail.com>
References: <1312718297-10999-1-git-send-email-jon.seymour@gmail.com>
Cc: avarab@gmail.com, Jens.Lehmann@web.de, gitster@pobox.com,
	Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 07 13:58:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qq20F-0007uK-7x
	for gcvg-git-2@lo.gmane.org; Sun, 07 Aug 2011 13:58:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752735Ab1HGL6i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Aug 2011 07:58:38 -0400
Received: from mail-pz0-f42.google.com ([209.85.210.42]:53879 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752346Ab1HGL6f (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Aug 2011 07:58:35 -0400
Received: by mail-pz0-f42.google.com with SMTP id 37so6636287pzk.1
        for <git@vger.kernel.org>; Sun, 07 Aug 2011 04:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=5Q6gbUUjPU0OLOlE4ftdooxKTsz4YQnzR6H1zFudSqU=;
        b=bDYTOs8eSPAETmyDkrA/M27pLlkWAPM5b8GNqWYp2cABdqUhuZ35ndjwuCRfu4HR5v
         XsOS7aic5Uiehg34i6ldAswoKWWx5vSUwQ/vE3k0zCxzAEGdYIYjvJlWEexBpqkFf9KL
         Pu2VS6CLXsC8QXCF9LRnLS7+FtdXrV5XH7+Rc=
Received: by 10.142.186.3 with SMTP id j3mr3918316wff.321.1312718315396;
        Sun, 07 Aug 2011 04:58:35 -0700 (PDT)
Received: from localhost.localdomain (124-169-144-208.dyn.iinet.net.au [124.169.144.208])
        by mx.google.com with ESMTPS id s7sm2183465pbj.5.2011.08.07.04.58.32
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 07 Aug 2011 04:58:34 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.363.g9b380.dirty
In-Reply-To: <1312718297-10999-1-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178903>

Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
---
 git-am.sh |   31 ++++++++++++++-----------------
 1 files changed, 14 insertions(+), 17 deletions(-)

diff --git a/git-am.sh b/git-am.sh
index 463c741..6177567 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -89,11 +89,8 @@ safe_to_abort () {
 	then
 		return 0
 	fi
-	(
-		gettext "You seem to have moved HEAD since the last 'am' failure.
-Not rewinding to ORIG_HEAD" &&
-		echo
-	) >&2
+		gettextln "You seem to have moved HEAD since the last 'am' failure.
+Not rewinding to ORIG_HEAD" >&2
 	return 1
 }
 
@@ -102,9 +99,9 @@ stop_here_user_resolve () {
 	    printf '%s\n' "$resolvemsg"
 	    stop_here $1
     fi
-    eval_gettext "When you have resolved this problem run \"\$cmdline --resolved\".
+    eval_gettextln "When you have resolved this problem run \"\$cmdline --resolved\".
 If you would prefer to skip this patch, instead run \"\$cmdline --skip\".
-To restore the original branch and stop patching run \"\$cmdline --abort\"."; echo
+To restore the original branch and stop patching run \"\$cmdline --abort\"."
 
     stop_here $1
 }
@@ -118,7 +115,7 @@ go_next () {
 
 cannot_fallback () {
 	echo "$1"
-	gettext "Cannot fall back to three-way merge."; echo
+	gettextln "Cannot fall back to three-way merge."
 	exit 1
 }
 
@@ -611,9 +608,9 @@ do
 			go_next && continue
 
 		test -s "$dotest/patch" || {
-			eval_gettext "Patch is empty.  Was it split wrong?
+			eval_gettextln "Patch is empty.  Was it split wrong?
 If you would prefer to skip this patch, instead run \"\$cmdline --skip\".
-To restore the original branch and stop patching run \"\$cmdline --abort\"."; echo
+To restore the original branch and stop patching run \"\$cmdline --abort\"."
 			stop_here $this
 		}
 		rm -f "$dotest/original-commit" "$dotest/author-script"
@@ -648,7 +645,7 @@ To restore the original branch and stop patching run \"\$cmdline --abort\"."; ec
 
 	if test -z "$GIT_AUTHOR_EMAIL"
 	then
-		gettext "Patch does not have a valid e-mail address."; echo
+		gettextln "Patch does not have a valid e-mail address."
 		stop_here $this
 	fi
 
@@ -699,7 +696,7 @@ To restore the original branch and stop patching run \"\$cmdline --abort\"."; ec
 	    action=again
 	    while test "$action" = again
 	    do
-		gettext "Commit Body is:"; echo
+		gettextln "Commit Body is:"
 		echo "--------------------------"
 		cat "$dotest/final-commit"
 		echo "--------------------------"
@@ -763,16 +760,16 @@ To restore the original branch and stop patching run \"\$cmdline --abort\"."; ec
 		# working tree.
 		resolved=
 		git diff-index --quiet --cached HEAD -- && {
-			gettext "No changes - did you forget to use 'git add'?
+			gettextln "No changes - did you forget to use 'git add'?
 If there is nothing left to stage, chances are that something else
-already introduced the same changes; you might want to skip this patch."; echo
+already introduced the same changes; you might want to skip this patch."
 			stop_here_user_resolve $this
 		}
 		unmerged=$(git ls-files -u)
 		if test -n "$unmerged"
 		then
-			gettext "You still have unmerged paths in your index
-did you forget to use 'git add'?"; echo
+			gettextln "You still have unmerged paths in your index
+did you forget to use 'git add'?"
 			stop_here_user_resolve $this
 		fi
 		apply_status=0
@@ -797,7 +794,7 @@ did you forget to use 'git add'?"; echo
 	fi
 	if test $apply_status != 0
 	then
-		eval_gettext 'Patch failed at $msgnum $FIRSTLINE'; echo
+		eval_gettextln 'Patch failed at $msgnum $FIRSTLINE'
 		stop_here_user_resolve $this
 	fi
 
-- 
1.7.6.363.g9b380.dirty
