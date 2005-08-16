From: Kalle Valo <Kalle.Valo@iki.fi>
Subject: [PATCH] Change git-branch to list branches
Date: Tue, 16 Aug 2005 20:58:10 +0300
Message-ID: <87d5odlq6l.fsf_-_@litku.valo.iki.fi>
References: <20050815204430.GA77829@rossby.metr.ou.edu>
	<87hddplqdu.fsf@litku.valo.iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: junkio@cox.net, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 16 19:56:07 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E55dd-0007WB-4G
	for gcvg-git@gmane.org; Tue, 16 Aug 2005 19:54:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030269AbVHPRyG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 16 Aug 2005 13:54:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030270AbVHPRyG
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Aug 2005 13:54:06 -0400
Received: from fep31-0.kolumbus.fi ([193.229.0.35]:15522 "EHLO
	fep31-app.kolumbus.fi") by vger.kernel.org with ESMTP
	id S1030269AbVHPRyF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Aug 2005 13:54:05 -0400
Received: from litku.valo.iki.fi ([81.197.35.21]) by fep31-app.kolumbus.fi
          with ESMTP
          id <20050816175403.DVJO4404.fep31-app.kolumbus.fi@litku.valo.iki.fi>;
          Tue, 16 Aug 2005 20:54:03 +0300
To: Amos Waterland <apw@rossby.metr.ou.edu>
In-Reply-To: <87hddplqdu.fsf@litku.valo.iki.fi> (Kalle Valo's message of
 "Tue, 16 Aug 2005 20:53:49 +0300")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

If no argument provided to `git branch`, show available branches and
mark current branch with star.

This is based on patch written by Amos Waterland <apw@rossby.metr.ou.edu>.

Signed-off-by: Kalle Valo <Kalle.Valo@iki.fi>
---

 git-branch-script |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

38aca3bb4ad4e6b0e10e295a87a9f5ce37ff5be4
diff --git a/git-branch-script b/git-branch-script
--- a/git-branch-script
+++ b/git-branch-script
@@ -11,7 +11,13 @@ case "$2" in
 esac
 rev=$(git-rev-parse --revs-only --verify "$head") || exit
 
-[ -z "$branchname" ] && die "git branch: I want a branch name"
+if [ -z "$branchname" ]; then
+    current=$(basename $(readlink $GIT_DIR/HEAD))
+    cd $GIT_DIR/refs/heads &&
+    ls | sed -e "s/^/  /" -e "s/  $current/* $current/"
+    exit
+fi
+
 [ -e "$GIT_DIR/refs/heads/$branchname" ] && die "$branchname already exists"
 
 echo $rev > "$GIT_DIR/refs/heads/$branchname"
