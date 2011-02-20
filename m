From: Jay Soffian <jaysoffian@gmail.com>
Subject: [PATCH] git-checkout.txt: improve detached HEAD documentation
Date: Sun, 20 Feb 2011 00:21:50 -0500
Message-ID: <1298179310-46207-1-git-send-email-jaysoffian@gmail.com>
References: <7v7hcy9vrk.fsf@alter.siamese.dyndns.org>
Cc: Jay Soffian <jaysoffian@gmail.com>,
	Nicolas Pitre <nico@fluxnic.net>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 20 06:22:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pr1kV-0005Oq-GW
	for gcvg-git-2@lo.gmane.org; Sun, 20 Feb 2011 06:22:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750966Ab1BTFWR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Feb 2011 00:22:17 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:47518 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750846Ab1BTFWR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Feb 2011 00:22:17 -0500
Received: by qwd7 with SMTP id 7so1304783qwd.19
        for <git@vger.kernel.org>; Sat, 19 Feb 2011 21:22:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=U94c06CEgTasurq2KBq+F17km6CeNqKzpUay25IHsqI=;
        b=F4wLYizgm/NJLGO2CqIOHNEY5VprOHRY9UDuFyfQZ1nwILMyam2wr6/qygxlcviUrC
         Q7PokOTFMB8/+BMrZzwidTqpPMwCGW44oBm6aAq4gtQ31zDwvMEjh6TacME/Q4mA9t+D
         LG21S+iheUp5uPm3RBpXMdGsV+uN2NWSqd/Gg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=BDCx0pRZs2fYqigMXcPlAEKitYh+AD+vbJpBsVktz/TjpWG8tydKqjmjIFpl9i7Jfj
         5PjtCObcucTq7gZALR3Vi4R0J387EtpwllsH4oXmjTvBvIzv/Sw2u+1yKVRXDcoWOP2k
         vIr6w1uCzXCFcFeSeOAl33UmvgylK/AKC1aFY=
Received: by 10.224.67.19 with SMTP id p19mr6167qai.376.1298179335951;
        Sat, 19 Feb 2011 21:22:15 -0800 (PST)
Received: from localhost (cpe-071-077-014-091.nc.res.rr.com [71.77.14.91])
        by mx.google.com with ESMTPS id p13sm2802253qcu.29.2011.02.19.21.22.13
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 19 Feb 2011 21:22:15 -0800 (PST)
X-Mailer: git-send-email 1.7.4.1.52.g8e1b
In-Reply-To: <7v7hcy9vrk.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167400>

The detached HEAD state is a source of much confusion for users
new to git. Here we try to document it better.

Reworked from http://article.gmane.org/gmane.comp.version-control.git/138440

Requested-by: Nicolas Pitre <nico@fluxnic.net>
Signed-off-by: Jay Soffian <jaysoffian@gmail.com>
---
Incorporated Junio's feedback. Though this is a bit clearer, I think it's
starting to make the man page quite long due to the taller ascii
art (adding the tag plus the stem to the arrows adds 4 lines to each
picture).

I don't have any more time to allocate to this patch. I think it's a vast
improvement as is, and you should feel free to make any corrections/edits you
see fit so that it may be applied.

 Documentation/git-checkout.txt |  145 +++++++++++++++++++++++++++++++++------
 1 files changed, 122 insertions(+), 23 deletions(-)

diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
index 880763d..8a252dc 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -206,40 +206,139 @@ leave out at most one of `A` and `B`, in which case it defaults to `HEAD`.
 
 Detached HEAD
 -------------
+HEAD normally refers to a named branch (e.g. 'master'). Meanwhile, each
+branch refers to a specific commit. Let's look at a repo with three
+commits, one of them tagged, and with branch 'master' checked out:
 
-It is sometimes useful to be able to 'checkout' a commit that is
-not at the tip of one of your branches.  The most obvious
-example is to check out the commit at a tagged official release
-point, like this:
+------------
+           HEAD (refers to branch 'master')
+            |
+            v
+a---b---c  branch 'master' (refers to commit 'c')
+    ^
+    |
+  tag 'v2.0' (refers to commit 'b')
+------------
+
+When a commit is created in this state, the branch is updated to refer to
+the new commit. Specifically, 'git commit' creates a new commit 'd', whose
+parent is commit 'c', and then updates branch 'master' to refer to new
+commit 'd'. HEAD still refers to branch 'master' and so indirectly now refers
+to commit 'd':
 
 ------------
-$ git checkout v2.6.18
+$ edit; git add; git commit
+
+               HEAD (refers to branch 'master')
+                |
+                v
+a---b---c---d  branch 'master' (refers to commit 'd')
+    ^
+    |
+  tag 'v2.0' (refers to commit 'b')
 ------------
 
-Earlier versions of git did not allow this and asked you to
-create a temporary branch using the `-b` option, but starting from
-version 1.5.0, the above command 'detaches' your HEAD from the
-current branch and directly points at the commit named by the tag
-(`v2.6.18` in the example above).
+It is sometimes useful to be able to checkout a commit that is not at
+the tip of any named branch, or even to create a new commit that is not
+referenced by a named branch. Let's look at what happens when we
+checkout commit 'b' (here we show three ways this may be done):
 
-You can use all git commands while in this state.  You can use
-`git reset --hard $othercommit` to further move around, for
-example.  You can make changes and create a new commit on top of
-a detached HEAD.  You can even create a merge by using `git
-merge $othercommit`.
+------------
+$ git checkout v2.0  # or
+$ git checkout b     # or
+$ git checkout master^^
+
+   HEAD (refers to commit 'b')
+    |
+    v
+a---b---c---d  branch 'master' (refers to commit 'd')
+    ^
+    |
+  tag 'v2.0' (refers to commit 'b')
+------------
 
-The state you are in while your HEAD is detached is not recorded
-by any branch (which is natural --- you are not on any branch).
-What this means is that you can discard your temporary commits
-and merges by switching back to an existing branch (e.g. `git
-checkout master`), and a later `git prune` or `git gc` would
-garbage-collect them.  If you did this by mistake, you can ask
-the reflog for HEAD where you were, e.g.
+Notice that regardless of which checkout command we use, HEAD now refers
+directly to commit 'b'. This is known as being in detached HEAD state.
+It means simply that HEAD refers to a specific commit, as opposed to
+referring to a named branch. Let's see what happens when we create a commit:
 
 ------------
-$ git log -g -2 HEAD
+$ edit; git add; git commit
+
+     HEAD (refers to commit 'e')
+      |
+      v
+      e
+     /
+a---b---c---d  branch 'master' (refers to commit 'd')
+    ^
+    |
+  tag 'v2.0' (refers to commit 'b')
 ------------
 
+There is now a new commit 'e', but it is referenced only by HEAD. We can
+of course add yet another commit in this state:
+
+------------
+$ edit; git add; git commit
+
+         HEAD (refers to commit 'f')
+          |
+          v
+      e---f
+     /
+a---b---c---d  branch 'master' (refers to commit 'd')
+    ^
+    |
+  tag 'v2.0' (refers to commit 'b')
+------------
+
+In fact, we can perform all the normal git operations. But, let's look
+at what happens when we then checkout master:
+
+------------
+$ git checkout master
+
+               HEAD (refers to branch 'master')
+      e---f     |
+     /          v
+a---b---c---d  branch 'master' (refers to commit 'd')
+    ^
+    |
+  tag 'v2.0' (refers to commit 'b')
+------------
+
+It is important to realize that at this point nothing refers to commit
+'f'. Eventually commit 'f' (and by extension commit 'e') will be deleted
+by the routine git garbage collection process, unless we create a reference
+before that happens. If we have not yet moved away from commit 'f',
+any of these will create a reference to it:
+
+------------
+$ git checkout -b foo   <1>
+$ git branch foo        <2>
+$ git tag foo           <3>
+------------
+
+<1> creates a new branch 'foo', which refers to commit 'f', and then
+updates HEAD to refer to branch 'foo'. In other words, we'll no longer
+be in detached HEAD state after this command.
+
+<2> similarly creates a new branch 'foo', which refers to commit 'f',
+but leaves HEAD detached.
+
+<3> creates a new tag 'foo', which refers to commit 'f',
+leaving HEAD detached.
+
+If we have moved away from commit 'f', then we must first recover its object
+name (typically by using git reflog), and then we can create a reference to
+it. For example, to see the last two commits to which HEAD referred, we
+can use either of these commands:
+
+------------
+$ git reflog -2 HEAD # or
+$ git log -g -2 HEAD
+------------
 
 EXAMPLES
 --------
-- 
1.7.4.1.52.g8e1b
