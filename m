From: Paul Campbell <pcampbell@kemitix.net>
Subject: [PATCH v2 10/23] contrib/subtree: Add command diff
Date: Sun, 10 Mar 2013 23:41:18 +0000
Message-ID: <1362958891-26941-11-git-send-email-pcampbell@kemitix.net>
References: <1362958891-26941-1-git-send-email-pcampbell@kemitix.net>
Cc: David Greene <greened@obbligato.org>,
	Matt Hoffman <matt.hoffman@quantumretail.com>,
	Paul Campbell <pcampbell@kemitix.net>,
	"Peter Jaros" <pjaros@pivotallabs.com>,
	"Avery Pennarun" <apenwarr@gmail.com>, "bibendi" <bibendi@bk.ru>,
	"Wayne Walter" <wayne@tickzoom.com>
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Mar 11 00:45:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UEpvJ-0004Q8-4y
	for gcvg-git-2@plane.gmane.org; Mon, 11 Mar 2013 00:45:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753443Ab3CJXoe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Mar 2013 19:44:34 -0400
Received: from mail-wi0-f180.google.com ([209.85.212.180]:65020 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753316Ab3CJXod (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Mar 2013 19:44:33 -0400
Received: by mail-wi0-f180.google.com with SMTP id hi8so610213wib.1
        for <git@vger.kernel.org>; Sun, 10 Mar 2013 16:44:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:x-gm-message-state;
        bh=y8ngB0xLa9BrI1Ksj1erJ3SaDj3qOdUQMI2jz8gWQTg=;
        b=KVL6FhGFX8jL0FMkIOAPKGYYhviJqC69iQLjjYkl89xP6PRq9hO0lOcLA4NydUC3gj
         uJtn2NTIMYc+G1pQKzn/4XebzoEeSdPkRXhuBKItVIbt5yOhFCT433p/MhqiAIWwfCJo
         hOsVbvhaaWosxVEWfI27FlbKoed2eRXSlMOGgj9fFYlaky8kmFURZnYGLeuaCtlnH/mX
         LvQCY8I642GbkQmXAgKrBjSWKzpolD7dPYVFSLkteuf2ikyCqBH8uhvp+nPZz/25v6Of
         hI5p1v+yCwHiyVIl5mQ/2qBvUSirWmoc8cXEV1l01LOxLxA6Rv8eM5LbvpVItf6tRQkC
         Q3/Q==
X-Received: by 10.194.57.137 with SMTP id i9mr15654936wjq.18.1362959072668;
        Sun, 10 Mar 2013 16:44:32 -0700 (PDT)
Received: from coyote.home (host-2-102-87-75.as13285.net. [2.102.87.75])
        by mx.google.com with ESMTPS id r7sm13757148wiz.2.2013.03.10.16.44.27
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sun, 10 Mar 2013 16:44:31 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.rc1
In-Reply-To: <1362958891-26941-1-git-send-email-pcampbell@kemitix.net>
X-Gm-Message-State: ALoCoQkmZKHhCEmb9TRXCJ1hf3yPWk4KJvKKqAhziUxJCzYoDUEMwOVUXd3DO3hjXcwZoR7v14Gy
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217830>

From: Matt Hoffman <matt.hoffman@quantumretail.com>

Fetches the remote repo as a temporary git-remote then uses
git-diff-tree to do comparison before removing the temporary
git-remote.

Signed-off-by: Paul Campbell <pcampbell@kemitix.net>

Conflicts:
	git-subtree.sh
---
 contrib/subtree/git-subtree.sh | 34 +++++++++++++++++++++++++++++++++-
 1 file changed, 33 insertions(+), 1 deletion(-)

diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
index ae9f87f..4c3f3c0 100755
--- a/contrib/subtree/git-subtree.sh
+++ b/contrib/subtree/git-subtree.sh
@@ -16,6 +16,7 @@ git subtree pull-all
 git subtree push-all
 git subtree push  --prefix=<prefix> <repository> <refspec...>
 git subtree split --prefix=<prefix> <commit...>
+git subtree diff  --prefix=<prefix> [<repository> [<refspec>...]]
 git subtree from-submodule --prefix=<prefix>
 --
 h,help        show the help
@@ -105,8 +106,8 @@ command="$1"
 shift
 case "$command" in
 	add|merge|pull|from-submodule|pull-all|push-all) default= ;;
-	split|push) default="--default HEAD" ;;
 	*) die "Unknown command '$command'" ;;
+    split|push|diff) default="--default HEAD" ;;
 esac
 
 if [ -z "$prefix" -a "$command" != "pull-all" -a "$command" != "push-all" ]; then
@@ -737,6 +738,37 @@ cmd_pull()
 	fi
 }
 
+cmd_diff() 
+{
+    if [ -e "$dir" ]; then
+        if [ $# -eq 1 ]; then 
+            repository=$(git config -f .gittrees subtree.$prefix.url)
+            refspec=$1
+        elif [ $# -eq 2 ]; then 
+            repository=$1
+            refspec=$2
+        else
+            repository=$(git config -f .gittrees subtree.$prefix.url)
+            refspec=$(git config -f .gittrees subtree.$prefix.branch)
+        fi
+        # this is ugly, but I don't know of a better way to do it. My git-fu is weak. 
+        # git diff-tree expects a treeish, but I have only a repository and branch name.
+        # I don't know how to turn that into a treeish without creating a remote.
+        # Please change this if you know a better way! 
+        tmp_remote=__diff-tmp
+        git remote rm $tmp_remote > /dev/null 2>&1
+        git remote add -t $refspec $tmp_remote $repository > /dev/null
+        # we fetch as a separate step so we can pass -q (quiet), which isn't an option for "git remote"
+        # could this instead be "git fetch -q $repository $refspec" and leave aside creating the remote?
+        # Still need a treeish for the diff-tree command...
+        git fetch -q $tmp_remote 
+        git diff-tree -p refs/remotes/$tmp_remote/$refspec
+        git remote rm $tmp_remote > /dev/null 2>&1
+    else 
+        die "Cannot resolve directory '$dir'. Please point to an existing subtree directory to diff. Try 'git subtree add' to add a subtree."
+    fi
+}
+
 cmd_push()
 {
 	if [ $# -gt 2 ]; then
-- 
1.8.2.rc1
