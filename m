From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH] config doc: rewrite push.default section
Date: Sun, 16 Jun 2013 15:36:28 +0530
Message-ID: <1371377188-18938-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jun 16 12:08:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uo9st-0003bU-CJ
	for gcvg-git-2@plane.gmane.org; Sun, 16 Jun 2013 12:08:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755159Ab3FPKIT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Jun 2013 06:08:19 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:54022 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754899Ab3FPKIS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Jun 2013 06:08:18 -0400
Received: by mail-pa0-f53.google.com with SMTP id tj12so1928652pac.40
        for <git@vger.kernel.org>; Sun, 16 Jun 2013 03:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=F145GHNtv3DZcYceqpwX69xwgn7m9ESSuq1Q7cC3DUs=;
        b=ARoUjk/ugZ8LUIanpJKd+W5mTXNTRsPaeIVBGLA+/NupmpFifRNiYDwhZ1REEeLxch
         fLatpJl1J8wVzPzX150iJFD1hqXhNi1CNcPMR7wxnKiCA96BZwG79pJP2EKzR0Tvuymy
         CP+UD4DwMO13ySXeQhM1VkJxsx+X8eyKyRiRDSLfdh7QmjDHLVgactZBGUWqV1iea6XB
         SdDqJGIgMvApVf1NYafyTC60Vo5YSX5bNV6XI77Iz0Rc3VBgClPoTk6B7cN5Vn2i43ms
         UtmGzUNEAeMro6ke5wEeE6N6yigWfkNFkFeUBSSqPPIDwJ1aYdn1Q34il3YHmVZFtNCU
         puww==
X-Received: by 10.68.160.226 with SMTP id xn2mr8832782pbb.174.1371377297689;
        Sun, 16 Jun 2013 03:08:17 -0700 (PDT)
Received: from localhost.localdomain ([122.164.213.38])
        by mx.google.com with ESMTPSA id qi1sm10122328pac.21.2013.06.16.03.08.15
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 16 Jun 2013 03:08:17 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1.443.g4fd77b9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228004>

Design by Junio.

By detaching descriptions from the implementation, we're only confusing
users.  I've chosen to use the term "central workflow" to make the
descriptions terse and readable, although I've stayed way from
"triangular workflow" (referred to as non-central workflow).

Yes, I hate writing documentation but I have no choice if I want to
update the implementations to do something sane in triangular workflows.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 I'll send in the implementation once we can agree that this is what
 we want.

 Documentation/config.txt | 51 ++++++++++++++++++++++++------------------------
 1 file changed, 25 insertions(+), 26 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 7fd4035..30350a3 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1832,33 +1832,32 @@ push.default::
 	line. Possible values are:
 +
 --
-* `nothing` - do not push anything.
-* `matching` - push all branches having the same name in both ends.
-  This is for those who prepare all the branches into a publishable
-  shape and then push them out with a single command.  It is not
-  appropriate for pushing into a repository shared by multiple users,
-  since locally stalled branches will attempt a non-fast forward push
-  if other users updated the branch.
-  +
-  This is currently the default, but Git 2.0 will change the default
-  to `simple`.
-* `upstream` - push the current branch to its upstream branch
-  (`tracking` is a deprecated synonym for this).
-  With this, `git push` will update the same remote ref as the one which
-  is merged by `git pull`, making `push` and `pull` symmetrical.
-  See "branch.<name>.merge" for how to configure the upstream branch.
-* `simple` - like `upstream`, but refuses to push if the upstream
-  branch's name is different from the local one. This is the safest
-  option and is well-suited for beginners. It will become the default
-  in Git 2.0.
-* `current` - push the current branch to a branch of the same name.
+* `nothing` - error out unless a refspec is explicitly given.
+
+* `current` - push the refspec "$HEAD".  HEAD is resolved early to a
+  branch name (referred to as $HEAD).  In other words, push the
+  current branch to update a branch with the same name on the pushing
+  side.
+
+* `upstream` - push the refspec "$HEAD:branch.$HEAD.merge", and error
+  out if the push destination is not the same as branch.$HEAD.remote.
+  The name "upstream" refers to the revision "@{u[pstream]}" in
+  linkgit:gitrevisions[7].  It is useful in central workflows, to make
+  the `push` symmetrical to `pull`.
+
+* `simple` - in central workflows, behaves like `upstream`, except
+  that it errors out unless branch.$HEAD.merge is equal to $HEAD.  In
+  non-central workflows, behaves like `current`.  It will become the
+  default in Git 2.0.
+
+* `matching` - push the refspec ":".  In other words, push all
+  branches having the same name in both ends, even if it means
+  non-fast-forward updates.  This is for those who prepare all the
+  branches into a publishable shape and then push them out with a
+  single command.  Dangerous, and inappropriate unless you are the
+  only person updating your push destination.  This is currently the
+  default, but Git 2.0 will change the default to `simple`.
 --
-+
-The `simple`, `current` and `upstream` modes are for those who want to
-push out a single branch after finishing work, even when the other
-branches are not yet ready to be pushed out. If you are working with
-other people to push into the same shared repository, you would want
-to use one of these.
 
 rebase.stat::
 	Whether to show a diffstat of what changed upstream since the last
-- 
1.8.3.1.443.g4fd77b9
