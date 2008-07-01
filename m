From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [OT] Your branch is ahead of the tracked remote branch
	'origin/master' by 50 commits.
Date: Tue, 1 Jul 2008 12:07:25 +0200
Message-ID: <20080701100725.GE31309@elte.hu>
References: <20080701091347.GA11817@elte.hu> <7vlk0mne5d.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 01 12:08:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KDcmy-0001xG-Gr
	for gcvg-git-2@gmane.org; Tue, 01 Jul 2008 12:08:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753140AbYGAKHr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Jul 2008 06:07:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753187AbYGAKHr
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Jul 2008 06:07:47 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:45568 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753078AbYGAKHq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jul 2008 06:07:46 -0400
Received: from elvis.elte.hu ([157.181.1.14])
	by mx2.mail.elte.hu with esmtp (Exim)
	id 1KDclp-0003gI-Dx
	from <mingo@elte.hu>; Tue, 01 Jul 2008 12:07:44 +0200
Received: by elvis.elte.hu (Postfix, from userid 1004)
	id E29653E2205; Tue,  1 Jul 2008 12:07:23 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7vlk0mne5d.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Received-SPF: neutral (mx2: 157.181.1.14 is neither permitted nor denied by domain of elte.hu) client-ip=157.181.1.14; envelope-from=mingo@elte.hu; helo=elvis.elte.hu;
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -1.5
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-1.5 required=5.9 tests=BAYES_00 autolearn=no SpamAssassin version=3.2.3
	-1.5 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87020>

* Junio C Hamano <gitster@pobox.com> wrote:

> Ingo Molnar <mingo@elte.hu> writes:
> 
> > i recently switched to 1.5.6.1.89.gd5446 and i'm getting this:
> >
> >   Switched to branch "master"
> >   Your branch is ahead of the tracked remote branch 'origin/master' by 50 commits.
> >
> > it's a very useful detail! It's especially useful when two branches 
> > diverge in a non-trivial way.
> > ...
> > but having a reminder at checkout time is even better (and faster as 
> > well). Kudos.
> 
> Thanks for a rare positive usability feedback.  When I started reading 
> your message, I almost expected that I'd hear you say "I am getting 
> this useless cruft and it wastes extra cycles."

Git usability is certainly very good. (And what matters even more to me 
than absolute usability, Git's usability is improving in a monotonic 
way.)

[ You normally only hear from me if i find one of those rare outliers
  that confuse me somewhere. So by reading my feedback you must be
  getting an impression of problems only - that is far from the truth :) ]

> Somebody must have had a very bright idea that day in late February 
> this year.

:)

There's a small detail i was thinking about: is there a way to get this 
extra output without actually switching branches? Right now i do this:

 earth4:~/tip> git-checkout tip; git-checkout master
 Checking out files: 100% (2437/2437), done.
 Switched to branch "tip"
 Switched to branch "master"
 Your branch is ahead of the tracked remote branch 'origin/master' by 50 commits.

(Which is an admitted lame solution but the best i could figure.)

Also, and let me hijack this thread, i sometimes feel adventurous and 
try out git/pu for kicks. I tried it two days ago and it was quite OK, 
with some fallout:

- the git-dash changes broke half of our scripts around git. (We've got
  about 50 tip-* scripts around various git details, about 2200 lines). 

I did a mass changeover:

   31 files changed, 150 insertions(+), 150 deletions(-)

... and that broke things too - see the two fixes below. I can 
understand your desire for a git-dash-less world though, but it's 
causing some pain :-) Also, i kept typoing "git-" commands all the time 
so i switched back to git/master. Maybe there should be a transition 
period where the dash scripts warn if used interactively? Dunno.

[ and there's also a git-rerere Heisenbug i have been fighting with a 
  lot with git-1.5.5. It's quite hard to reproduce and unfortunately i 
  cannot create a reproducer: but it resulted in git-rerere confusing 
  conflict resolutions and putting arch/x86/kernel/process_64.c 
  postimage entry into the entry for arch/x86/kernel/process_32.c's 
  postimage file, corrupting the integration run on the _next_ run.

  Was there a bug in this area fixed recently that would show up with 
  such symptoms? The weirdness first showed up when i did a git-rerere 
  after having done a git-add arch/x86/kernel/process_64.c, git-rerere 
  printed that it added a new resolution for 
  arch/x86/kernel/process_32.c. ]

and i like this warning at the end of master/pu make install:

!! You have installed git-* commands to new gitexecdir.
!! Old version git-* commands still remain in bindir.
!! Mixing two versions of Git will lead to problems.
!! Please remove old version commands in bindir now.

that's an easily overlooked detail.

	Ingo

--------------->
commit e87616175691dd7154cad049aae2b1bc1385bb7a
Author: Ingo Molnar <mingo@elte.hu>
Date:   Mon Jun 30 09:29:36 2008 +0200

    - fix more git-dash fallout
    
    Signed-off-by: Ingo Molnar <mingo@elte.hu>

diff --git a/.tip/bin/tip-backup b/.tip/bin/tip-backup
index edd7991..682d68d 100755
--- a/.tip/bin/tip-backup
+++ b/.tip/bin/tip-backup
@@ -7,7 +7,7 @@ check_master
 echo "backing up the full -tip repo ..."
 mkdir -p ~/tip-backups || exit -1
 
-FILE=~/tip-backups/tip-git $(get_date_for_tag).tar.bz2
+FILE=~/tip-backups/tip-git-$(get_date_for_tag).tar.bz2
 
 tar cjf $FILE .git || exit -1
 
commit 1bcce26cf0ba00ea62c051772f66d3e1c616e165
Author: H. Peter Anvin <hpa@zytor.com>
Date:   Fri Jun 27 17:05:59 2008 -0700

    tip-sync-remote: quote multiword commands in variables
    
    When assigning a multiword command to a variable, it needs to be
    quoted.

diff --git a/.tip/bin/tip-sync-remote b/.tip/bin/tip-sync-remote
index 6421e55..aeeb883 100755
--- a/.tip/bin/tip-sync-remote
+++ b/.tip/bin/tip-sync-remote
@@ -65,9 +65,9 @@ do
     then
 	echo "Branch "$B" has local modifications"
 	echo "Rebasing local modifications to remote"
-	CMD=git rebase
+	CMD='git rebase'
     else
-	CMD=git merge
+	CMD='git merge'
     fi
 
     $CMD origin/$B || {
