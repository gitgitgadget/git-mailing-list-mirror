From: Dan McGee <dpmcgee@gmail.com>
Subject: [PATCH] git-mergetool: Allow gvimdiff to be used as a mergetool
Date: Tue,  5 Jun 2007 21:38:02 -0400
Message-ID: <11810938823594-git-send-email-dpmcgee@gmail.com>
Cc: Dan McGee <dpmcgee@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 06 03:38:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HvkTU-0006Y7-U2
	for gcvg-git@gmane.org; Wed, 06 Jun 2007 03:38:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761068AbXFFBiK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 5 Jun 2007 21:38:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763383AbXFFBiK
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Jun 2007 21:38:10 -0400
Received: from py-out-1112.google.com ([64.233.166.177]:54690 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761068AbXFFBiG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jun 2007 21:38:06 -0400
Received: by py-out-1112.google.com with SMTP id a29so3201502pyi
        for <git@vger.kernel.org>; Tue, 05 Jun 2007 18:38:05 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:cc:subject:date:message-id:x-mailer;
        b=GaMfokKFl+1y1OpgkAcxvllvxm1PTmX1TLYe+e/nQcizdhhJwfRKmdZLoIM5SYKZcrkN2d74ZhWcUk/W/RAX81yTh9twmSqwv5g5B5RUIyxoqRgnQJC9mKGX5k8uZeYYKsi7bbKUmHL1G6F3wEePYdNBNfM8pvM+E2cwpyeWE38=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:cc:subject:date:message-id:x-mailer;
        b=LimMQJiNKojN+gwuEd/X+Dws8jlvVMPqZWxnOdKjb0a2+Grbgu1tlbc8AF1uYx9K9rEmYGgsHgZ+9rrGUuRy/W11DEx9ZX9sTxW2Pk68NnjbBMG//dsFK+irKngDUQMhP0JVqBnf1bbRMn/B6tID5YVSn5BIsY3vHHAHniOihyM=
Received: by 10.35.101.1 with SMTP id d1mr28891pym.1181093885090;
        Tue, 05 Jun 2007 18:38:05 -0700 (PDT)
Received: from localhost ( [71.205.59.244])
        by mx.google.com with ESMTP id f77sm4473682pyh.2007.06.05.18.38.03;
        Tue, 05 Jun 2007 18:38:04 -0700 (PDT)
X-Mailer: git-send-email 1.5.2.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49237>

Signed-off-by: Dan McGee <dpmcgee@gmail.com>
---
 Documentation/config.txt        |    2 +-
 Documentation/git-mergetool.txt |    2 +-
 git-mergetool.sh                |    6 +++---
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 5868d58..3ca01af 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -531,7 +531,7 @@ merge.summary::
 merge.tool::
 	Controls which merge resolution program is used by
 	gitlink:git-mergetool[l].  Valid values are: "kdiff3", "tkdiff",
-	"meld", "xxdiff", "emerge", "vimdiff", and "opendiff"
+	"meld", "xxdiff", "emerge", "vimdiff", "gvimdiff", and "opendiff".
 
 merge.verbosity::
 	Controls the amount of output shown by the recursive merge
diff --git a/Documentation/git-mergetool.txt b/Documentation/git-mergetool.txt
index add01e8..34c4c1c 100644
--- a/Documentation/git-mergetool.txt
+++ b/Documentation/git-mergetool.txt
@@ -25,7 +25,7 @@ OPTIONS
 -t or --tool=<tool>::
 	Use the merge resolution program specified by <tool>.
 	Valid merge tools are:
-	kdiff3, tkdiff, meld, xxdiff, emerge, vimdiff, and opendiff
+	kdiff3, tkdiff, meld, xxdiff, emerge, vimdiff, gvimdiff, and opendiff
 +
 If a merge resolution program is not specified, 'git mergetool'
 will use the configuration variable merge.tool.  If the
diff --git a/git-mergetool.sh b/git-mergetool.sh
index e62351b..1e4807b 100755
--- a/git-mergetool.sh
+++ b/git-mergetool.sh
@@ -209,7 +209,7 @@ merge_file () {
 	    status=$?
 	    save_backup
 	    ;;
-	meld|vimdiff)
+	meld|vimdiff|gvimdiff)
 	    touch "$BACKUP"
 	    $merge_tool -- "$LOCAL" "$path" "$REMOTE"
 	    check_unchanged
@@ -293,7 +293,7 @@ done
 if test -z "$merge_tool"; then
     merge_tool=`git-config merge.tool`
     case "$merge_tool" in
-	kdiff3 | tkdiff | xxdiff | meld | opendiff | emerge | vimdiff | "")
+	kdiff3 | tkdiff | xxdiff | meld | opendiff | emerge | vimdiff | gvimdiff | "")
 	    ;; # happy
 	*)
 	    echo >&2 "git config option merge.tool set to unknown tool: $merge_tool"
@@ -325,7 +325,7 @@ if test -z "$merge_tool" ; then
 fi
 
 case "$merge_tool" in
-    kdiff3|tkdiff|meld|xxdiff|vimdiff|opendiff)
+    kdiff3|tkdiff|meld|xxdiff|vimdiff|gvimdiff|opendiff)
 	if ! type "$merge_tool" > /dev/null 2>&1; then
 	    echo "The merge tool $merge_tool is not available"
 	    exit 1
-- 
1.5.2.1
