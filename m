From: Sjors Gielen <dazjorz@dazjorz.com>
Subject: Merging a commit from a distant branch, cherry-pick seems to fail
Date: Tue, 8 Jun 2010 00:46:10 +0200
Message-ID: <4C1009EE-3A67-4DF9-9F45-493CD463AEF9@dazjorz.com>
Mime-Version: 1.0 (Apple Message framework v1078)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Diederik van der Boor <vdboor@codindomain.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 08 00:46:30 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OLl5L-00019F-Kc
	for gcvg-git-2@lo.gmane.org; Tue, 08 Jun 2010 00:46:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753368Ab0FGWqS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jun 2010 18:46:18 -0400
Received: from mail-ew0-f223.google.com ([209.85.219.223]:56896 "EHLO
	mail-ew0-f223.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751967Ab0FGWqR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 Jun 2010 18:46:17 -0400
Received: by ewy23 with SMTP id 23so96808ewy.1
        for <git@vger.kernel.org>; Mon, 07 Jun 2010 15:46:14 -0700 (PDT)
Received: by 10.213.109.6 with SMTP id h6mr2952ebp.14.1275950774051;
        Mon, 07 Jun 2010 15:46:14 -0700 (PDT)
Received: from [192.168.1.110] (h91085.upc-h.chello.nl [62.194.91.85])
        by mx.google.com with ESMTPS id 16sm2943016ewy.11.2010.06.07.15.46.12
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 07 Jun 2010 15:46:12 -0700 (PDT)
X-Mailer: Apple Mail (2.1078)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148631>

Hi list,

I'm one of the lead developers for KMess. Recently, I've been doing some work regarding KMess on Mac, in a branch called 'noknotify' (because knotify works like shit on Mac). This branch was branched off of the master branch a few days ago. The master branch has had major development activity in the last half year, as the KMess version that will eventually be 2.1 or so. Before that, we released a kmess-2.0.x branch; this branch has been relatively silent since branching off from master.

Now, after those changes in noknotify, I want to merge them back into kmess-2.0.x. However, the two branches noknotify and kmess-2.0.x are hugely apart. The changes in the commit I want to merge are to files which haven't changed a lot (apart from the ChangeLog and CMakeLists.txt) and should apply somewhat cleanly.

So I switched branches, made sure my branch was clean, made sure I was taking the right commit, and cherry-picked the interesting commit from the other branch.

<<<<<<
sjors@smbp:~/Projecten/kmess/git$ git checkout kmess-2.0.x
Switched to branch 'kmess-2.0.x'
sjors@smbp:~/Projecten/kmess/git$ git status
# On branch kmess-2.0.x
nothing to commit (working directory clean)
sjors@smbp:~/Projecten/kmess/git$ git log -1 --name-only --oneline f9380fd43a2c1
f9380fd 2010-06-03 (Sjors) (noknotify branch)
ChangeLog
src/CMakeLists.txt
src/notification/macnotification.cpp
src/notification/macnotification.h
src/notification/notificationmanager.cpp
src/notification/notificationmanager.h
sjors@smbp:~/Projecten/kmess/git$ git cherry-pick -n f9380fd43a2c1cb75d97c7a667d652195e674824
Automatic cherry-pick failed.  After resolving the conflicts,
mark the corrected paths with 'git add <paths>' or 'git rm <paths>'
and commit the result with: 

        git commit -c f9380fd43a2c1cb75d97c7a667d652195e674824
<<<<<<<

Apparantly, this failed. The reason why: Instead of changing just those few files in the commit, git was apparantly trying to merge a lot more, see:

<<<<<<<
sjors@smbp:~/Projecten/kmess/git$ git status
# On branch kmess-2.0.x
# Changes to be committed:
#   (use "git reset HEAD <file>..." to unstage)
#
#	modified:   src/CMakeLists.txt
#	new file:   src/notification/macnotification.cpp
#	new file:   src/notification/macnotification.h
#	modified:   src/notification/notificationmanager.cpp
#
# Unmerged paths:
#   (use "git reset HEAD <file>..." to unstage)
#   (use "git add/rm <file>..." as appropriate to mark resolution)
#
#	both modified:      ChangeLog
#	added by us:        contrib/isf-qt
#	both modified:      src/notification/notificationmanager.h
#
sjors@smbp:~/Projecten/kmess/git$ git diff ChangeLog | head -n 20
diff --cc ChangeLog
index ef7223f,ca14ce8..0000000
--- a/ChangeLog
+++ b/ChangeLog
@@@ -1,134 -1,101 +1,148 @@@
++<<<<<<< HEAD
 +2010-05-31 (Adam)
 + * Fix bug in chatwindow.ui: use the global include for IsfInkCanvas.
++=======
+ 
+ 2010-06-03 (Sjors) (noknotify branch)
+  * Added MacNotification class, which currently makes the KMess icon in the
+    Dock 'jump' when its method is called.
+  * Made the NotificationManager use MacNotification instead when doing
+    notifications on the Mac.
+ 
+ 2010-05-29 (Adam)
+  * Update the use of the MsnSession API (no more "get" prefix).
+  * Disable meeting/invite/send file buttons if chatting to a Yahoo! contact
+  * Handle YahooMessage in Chat
<<<<<<<<

The lines added starting with "2010-05-29 (Adam)" are not from kmess-2.0.x, but from 'master' - the lines are also present in the snapshot of noknotify after commit f9380fd43, but weren't changed in that commit.

I'd have expected git cherry-pick to simply take the changes in commit f9380fd43 and apply them to kmess-2.0.x, without pulling along history in 'master'. Testing and debugging in the #git channel on Freenode didn't show what I was doing wrong (<http://git.pastebin.com/dUntbHDV>). Now I could just take the patch with 'git show' and use 'git apply' to apply it, but that doesn't seem like the Git way to do this. So the question is: does any of you know why this is happening, what I'm doing wrong, and what I should do instead?

BTW: my repository is a synchronised clone of http://gitorious.org/kmess/kmess, so you can all try stuff yourself :)

Thank you,
Sjors