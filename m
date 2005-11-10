From: Petr Baudis <pasky@suse.cz>
Subject: Re: Expected Behavior?
Date: Thu, 10 Nov 2005 21:10:28 +0100
Message-ID: <20051110201027.GW30496@pasky.or.cz>
References: <7vwtjjllw4.fsf@assigned-by-dhcp.cox.net> <20051108210332.GB23265@c165.ib.student.liu.se> <20051109112452.GD30496@pasky.or.cz> <46a038f90511091504l7218df18k251bec75491891e9@mail.gmail.com> <20051109231248.GL16061@pasky.or.cz> <46a038f90511091543h520f6a84k3e3b14c2e502989f@mail.gmail.com> <20051109234925.GL30496@pasky.or.cz> <46a038f90511091847t70567e50o2303f1dc7ada2464@mail.gmail.com> <20051110193430.GU30496@pasky.or.cz> <46a038f90511101154p4ef99cddv82d56272921a80ac@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Fredrik Kuivinen <freku045@student.liu.se>,
	Junio C Hamano <junkio@cox.net>,
	Jon Loeliger <jdl@freescale.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 10 21:11:52 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EaIkj-0002Jv-ON
	for gcvg-git@gmane.org; Thu, 10 Nov 2005 21:10:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751075AbVKJUKa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 10 Nov 2005 15:10:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751062AbVKJUKa
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Nov 2005 15:10:30 -0500
Received: from w241.dkm.cz ([62.24.88.241]:52455 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1750812AbVKJUKa (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 10 Nov 2005 15:10:30 -0500
Received: (qmail 27586 invoked by uid 2001); 10 Nov 2005 21:10:28 +0100
To: Martin Langhoff <martin.langhoff@gmail.com>
Content-Disposition: inline
In-Reply-To: <46a038f90511101154p4ef99cddv82d56272921a80ac@mail.gmail.com>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11517>

Dear diary, on Thu, Nov 10, 2005 at 08:54:43PM CET, I got a letter
where Martin Langhoff <martin.langhoff@gmail.com> said that...
> On 11/11/05, Petr Baudis <pasky@suse.cz> wrote:
> > Well, basically like right now ;-).
> 
> Exactly. Which isn't documented, and has several subtleties that I
> don't know of.

Yes - from the user standpoint it is supposed to be a foolproof (for a
reasonable value of 'fool') and should always guide you around. From a
developer's standpoint it might not be entirely crystal-clear, though.
;-)

> There are some semantics to exchange info between cg-merge and
> cg-commit and for handling the index while the user is resolving
> conflicts or reviewing the merge before committing. I'm not familiar
> with them, and I'm unsure what the design is...

The design is "keep arbitrary bunch of files in .git recording our state
wrt. merging". I want to tidy that up and keep all that in
.git/cg-merge-state/ or something.

>  - how do cg-merge and cg-commit pass around the parents, commit msg,
> files being merged vs dirty files on tree, etc? (easy: those lowercase
> temp files in .git)

Yes, lowercase temp files. Well, the commit msg itself is composed only
in cg-commit.

>  - how do you run cg-status/cg-diff without messing up the index? does
> running cg-status or cg-diff stand any risk of accidentally marking
> for inclusion dirty files that are not part of the merge? hopefully
> not, and then what's the technique?

cg-status and cg-diff are safe anytime, being basically read-only
commands wrt. the interesting index information.

Well, they _do_ touch your index (but only modifying the stat
information), and that may get you into some trouble, but only in case
of some seemingly quite rare permission problem, I think (and that will
trash your index anytime, not just during a merge). There was a thread
about that about a month or two ago, IIRC.

>  - should cg-status show more about the status of the index ?

In what sense? It shows if merge is in progress. It doesn't show
conflicts, but that's because...

>  - how does cg-commit know whether conflicts have been resolved at
> all? (perhaps it doesn't even try!)

...we don't actually track them yet. That's considered a bug, I want to
fix it, and it even has some non-zero priority.

>  - how do you reset the 'we are merging' status?

cg-reset (except when you were merging over a dirty state; hmm, we don't
have a direct command for cancelling that, it seems).

cg-merge will now hint you about cg-reset.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
