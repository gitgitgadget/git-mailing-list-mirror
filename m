From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: [PATCH v4] rebase: clarify "restore the original branch"
Date: Wed, 13 Jul 2011 23:47:06 -0400
Message-ID: <1310615226-3251-1-git-send-email-martin.von.zweigbergk@gmail.com>
References: <1310322661-24924-1-git-send-email-martin.von.zweigbergk@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Drew Northup <drew.northup@maine.edu>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 14 05:47:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QhCth-00067I-JM
	for gcvg-git-2@lo.gmane.org; Thu, 14 Jul 2011 05:47:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753787Ab1GNDrU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jul 2011 23:47:20 -0400
Received: from mail-qy0-f181.google.com ([209.85.216.181]:59471 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753771Ab1GNDrS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jul 2011 23:47:18 -0400
Received: by qyk9 with SMTP id 9so3759109qyk.19
        for <git@vger.kernel.org>; Wed, 13 Jul 2011 20:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=Fgm6Qruy7pKxLafdSkGYPnXbcUz3cG7pYG+pfFC5/dE=;
        b=YYJqjASISU2YvKT+GylJueiTmRfwt8ts9PNmCDQtd7iDSxwXPs5KP3WqKh4oNaayh5
         ire01hIBrWHQr/LKnAOWNHVsty9ddQtNPfjTkiCDGpVHb8YzVfwwexPWcLmduyRIM0Bg
         l9ZumWu/GXT+mqpOaoz+Uez46qCDNBgZlTlg4=
Received: by 10.224.208.135 with SMTP id gc7mr1493720qab.196.1310615237959;
        Wed, 13 Jul 2011 20:47:17 -0700 (PDT)
Received: from localhost.localdomain (modemcable151.183-178-173.mc.videotron.ca [173.178.183.151])
        by mx.google.com with ESMTPS id g7sm12468871qck.44.2011.07.13.20.47.16
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 13 Jul 2011 20:47:17 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.51.g07e0e
In-Reply-To: <1310322661-24924-1-git-send-email-martin.von.zweigbergk@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177098>

The description for 'git rebase --abort' currently says:

    Restore the original branch and abort the rebase operation.

The "restore" can be misinterpreted to imply that the original branch
was somehow in a broken state during the rebase operation. It is also
not completely clear what "the original branch" is --- is it the
branch that was checked out before the rebase operation was called or
is the the branch that is being rebased (it is the latter)? Although
both issues are made clear in the DESCRIPTION section, let us also
make the entry in the OPTIONS secion more clear.

Also remove the term "rebasing process" from the usage text, since the
user already knows that the text is about "git rebase".

Signed-off-by: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
---

While reading some sample output in an unrelated mail from Jeff, I
noticed that we actually use "restore" in a few more places (I had
originally seached for "abort" to find places to update). This patch
fixes those places.

I used the term "check out" instead of "reset HEAD to", because I
think the concept feels more familiar to many people, even though
"reset HEAD to" is technically more correct.

The phrase "restore the original branch" is also used in git-am, where
I think it makes even less sense. I rarely use git-am, but I think it
always applies the patches to the current branch, so there "restore
the original branch" really means "resets the (current) branch to the
original position (where it was when git-am was started)", doesn't it?


 Documentation/git-rebase.txt |    8 ++++++--
 git-rebase.sh                |   10 +++++-----
 2 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index a9e0e50..504945c 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -45,7 +45,7 @@ with a different commit message or timestamp will be skipped).
 It is possible that a merge failure will prevent this process from being
 completely automatic.  You will have to resolve any such merge failure
 and run `git rebase --continue`.  Another option is to bypass the commit
-that caused the merge failure with `git rebase --skip`.  To restore the
+that caused the merge failure with `git rebase --skip`.  To check out the
 original <branch> and remove the .git/rebase-apply working files, use the
 command `git rebase --abort` instead.
 
@@ -232,7 +232,11 @@ leave out at most one of A and B, in which case it defaults to HEAD.
 	Restart the rebasing process after having resolved a merge conflict.
 
 --abort::
-	Restore the original branch and abort the rebase operation.
+	Abort the rebase operation and reset HEAD to the original
+	branch. If <branch> was provided when the rebase operation was
+	started, then HEAD will be reset to <branch>. Otherwise HEAD
+	will be reset to where it was when the rebase operation was
+	started.
 
 --skip::
 	Restart the rebasing process by skipping the current patch.
diff --git a/git-rebase.sh b/git-rebase.sh
index d7855ea..38cbee7 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -13,7 +13,7 @@ It then attempts to create a new commit for each commit from the original
 It is possible that a merge failure will prevent this process from being
 completely automatic.  You will have to resolve any such merge failure
 and run git rebase --continue.  Another option is to bypass the commit
-that caused the merge failure with git rebase --skip.  To restore the
+that caused the merge failure with git rebase --skip.  To check out the
 original <branch> and remove the .git/rebase-apply working files, use the
 command git rebase --abort instead.
 
@@ -57,9 +57,9 @@ whitespace=!       passed to 'git apply'
 ignore-whitespace! passed to 'git apply'
 C=!                passed to 'git apply'
  Actions:
-continue!          continue rebasing process
-abort!             abort rebasing process and restore original branch
-skip!              skip current patch and continue rebasing process
+continue!          continue
+abort!             abort and check out the original branch
+skip!              skip current patch and continue
 "
 . git-sh-setup
 set_reflog_action rebase
@@ -72,7 +72,7 @@ ok_to_skip_pre_rebase=
 resolvemsg="
 When you have resolved this problem run \"git rebase --continue\".
 If you would prefer to skip this patch, instead run \"git rebase --skip\".
-To restore the original branch and stop rebasing run \"git rebase --abort\".
+To check out the original branch and stop rebasing run \"git rebase --abort\".
 "
 unset onto
 strategy=
-- 
1.7.6.51.g07e0e
