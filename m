From: Junio C Hamano <junkio@cox.net>
Subject: Re: sending changesets from the middle of a git tree
Date: Tue, 16 Aug 2005 17:55:51 -0700
Message-ID: <7v1x4t5qlk.fsf@assigned-by-dhcp.cox.net>
References: <20050817001308.ED487353CFD@atlas.denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Petr Baudis <pasky@suse.cz>,
	Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Wed Aug 17 02:56:33 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E5CDz-0006FI-KB
	for gcvg-git@gmane.org; Wed, 17 Aug 2005 02:56:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750785AbVHQAzy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 16 Aug 2005 20:55:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750786AbVHQAzy
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Aug 2005 20:55:54 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:47835 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1750785AbVHQAzy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Aug 2005 20:55:54 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050817005553.FXFZ12158.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 16 Aug 2005 20:55:53 -0400
To: Wolfgang Denk <wd@denx.de>
In-Reply-To: <20050817001308.ED487353CFD@atlas.denx.de> (Wolfgang Denk's
	message of "Wed, 17 Aug 2005 02:13:08 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Wolfgang Denk <wd@denx.de> writes:

> 	external diff died, stopping at common/cmd_nand.c.
> 	Some commits could not be rebased, check by hand:
> 	67a002cbe2b2850d76d797e679bc290a76666df6
>
> OK, I can edit the file to resolve the conflicts. But what  do  I  do
> then to continue?

Your rebase failed while processing 67a002... and fortunately
(well, if you are really fortunate you would not have seem it)
"some commits could not be" message says that was the only one
left.  At that point, everything up to that commit should be
migrated on top of your head.  Run gitk or git show-branches to
see where the "master" head is.  It should be pointing at the
last successful commit the rebase process has made.  I guess in
your example you had one commit between master and testing-NAND,
in which case the master head does not have moved?

Anyway, you manually resolve conflicts and make an commit from
there, which would migrate the failed 67a002... commit on top of
your master branch.  If "some commits could not be rebased"
message says more than one commit, you need to deal with the
rest of them by hand; sorry there is no automated way currently.

You have to repeat for each such commit:

 (1) Run "git-diff-tree -p <commit-id> | git-apply --index" (or
     what is in git-rebase-script which uses git-apply-patch-script);
 (2) Resolve conflict if there is one;
 (3) Run "git commit -C <commit-id>".
