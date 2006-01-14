From: Junio C Hamano <junkio@cox.net>
Subject: Re: My first git success [not quite]
Date: Sat, 14 Jan 2006 12:31:18 -0800
Message-ID: <7vzmlyft61.fsf@assigned-by-dhcp.cox.net>
References: <dq8epd$k28$1@sea.gmane.org>
	<Pine.LNX.4.64.0601130909290.3535@g5.osdl.org>
	<dqb5vg$a09$1@sea.gmane.org>
	<BAYC1-PASMTP10B423DC1B2FC1F8C9992BAE190@CEZ.ICE>
	<dqbbo9$s49$1@sea.gmane.org> <86acdyu2dz.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, walt <wa1ter@myrealbox.com>
X-From: git-owner@vger.kernel.org Sat Jan 14 21:31:30 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Exs3Y-0005oN-Li
	for gcvg-git@gmane.org; Sat, 14 Jan 2006 21:31:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751081AbWANUbW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 14 Jan 2006 15:31:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751083AbWANUbW
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Jan 2006 15:31:22 -0500
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:41350 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S1751081AbWANUbV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Jan 2006 15:31:21 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060114202843.PDCW20050.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 14 Jan 2006 15:28:43 -0500
To: merlyn@stonehenge.com (Randal L. Schwartz)
In-Reply-To: <86acdyu2dz.fsf@blue.stonehenge.com> (Randal L. Schwartz's
	message of "14 Jan 2006 09:48:24 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14680>

merlyn@stonehenge.com (Randal L. Schwartz) writes:

> Well, I'm a developer and *I* also had that problem while working
> on my "ajax" branch.
>
> Maybe git-checkout should by default *warn* when it is leaving
> things in the tree that are indexed but not updated in the index...

What Linus already said.  But you may find this on top of the
current "master" branch useful.

Likes, dislikes?

-- >8 --
[PATCH] checkout: show dirty state upon switching branches.

This shows your working file state when you switch branches.  As
a side effect, "git checkout" without any branch name (i.e. stay
on the current branch) becomes a more concise shorthand for the
"git status" command.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
diff --git a/git-checkout.sh b/git-checkout.sh
index bd7f007..d99688f 100755
--- a/git-checkout.sh
+++ b/git-checkout.sh
@@ -164,6 +164,9 @@ else
 	esac
 	exit 0
     )
+    saved_err=$?
+    git diff-files --name-status
+    (exit $saved_err)
 fi
 
 # 
