From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: Using StGIT for tweaking already-committed stuff
Date: Sat, 12 May 2007 13:09:55 +0200
Message-ID: <20070512110955.GB22735@diana.vm.bytemark.co.uk>
References: <87wszg39cp.wl%cworth@cworth.org> <20070510171457.GK13719@fieldses.org> <87vef0350y.wl%cworth@cworth.org> <20070510192106.GB4489@pasky.or.cz> <87tzuk31fu.wl%cworth@cworth.org> <20070510200253.GD4489@pasky.or.cz> <20070510222347.GB12366@diana.vm.bytemark.co.uk> <20070511204016.GH19253@nan92-1-81-57-214-146.fbx.proxad.net> <20070511224325.GA13310@diana.vm.bytemark.co.uk> <20070512071023.GD16903@nan92-1-81-57-214-146.fbx.proxad.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Petr Baudis <pasky@suse.cz>, Carl Worth <cworth@cworth.org>,
	"J. Bruce Fields" <bfields@fieldses.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Sixt <J.Sixt@eudaptics.com>,
	catalin.marinas@gmail.com, git@vger.kernel.org
To: Yann Dirson <ydirson@altern.org>
X-From: git-owner@vger.kernel.org Sat May 12 13:10:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HmpV2-00044R-T0
	for gcvg-git@gmane.org; Sat, 12 May 2007 13:10:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754323AbXELLKv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sat, 12 May 2007 07:10:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756159AbXELLKv
	(ORCPT <rfc822;git-outgoing>); Sat, 12 May 2007 07:10:51 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:1351 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754323AbXELLKu (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 May 2007 07:10:50 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1HmpU3-00062S-00; Sat, 12 May 2007 12:09:55 +0100
Mail-Followup-To: Yann Dirson <ydirson@altern.org>,
	Petr Baudis <pasky@suse.cz>, Carl Worth <cworth@cworth.org>,
	"J. Bruce Fields" <bfields@fieldses.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Sixt <J.Sixt@eudaptics.com>, catalin.marinas@gmail.com,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20070512071023.GD16903@nan92-1-81-57-214-146.fbx.proxad.net>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47036>

On 2007-05-12 09:10:23 +0200, Yann Dirson wrote:

> On Sat, May 12, 2007 at 12:43:25AM +0200, Karl Hasselstr=F6m wrote:
>
> > It shouldn't be necessary with a manual "assimilate" step. If
> > stgit finds that there are unadorned git commits on top of the
> > patch stack, it should do the assimilation automatically. With
> > that in place, "stg new" and "stg refresh" would be nearly
> > superfluous, since git-commit with and without --amend does the
> > same thing -- the only thing they won't do is give the user the
> > option of manually choosing the patch name.
>
> Hm. I'm not that convinced :)
>
> Eg, imagine a merge commit somewhere in the stack. What would stgit
> do with that ?

There are two cases:

  1. The merge commit is below the bottommost patch. This is perfectly
     OK, and nothing special has to be done. The only restriction is
     that we can't uncommit past the merge.

  2. The merge commit is above the topmost patch. (There may or may
     not also be other not-yet-stgitified commits above the topmost
     patch, below or above the merge commit.) In this case, stgit
     should not auto-assimilate the commits on top of the stack (since
     it can't be done for the merge commit), and a number of stgit
     commands (push, pop, new, ...) should refuse to work until the
     user has either reset the branch so that the merge disappears, or
     done "stg commit" on all the patches below the merge.

Note that these are the only cases: stgit should (and does) enforce
the invariant that the applied patches form a consecutive series of
commits, without "holes". This is why "stg new" would be forbidden in
case (2).

The point is not that you should commit merges on top of your patches,
of course. The point is that if you do, stgit should handle it
gracefully. Right now you can commit all your patches and do a merge,
but if you try to do it the other way around, stgit will break down on
you -- but there's no real reason why it should.

> I quite like the idea of makeing it easier to mix them, and removing
> the real duplicates from stgit, but I think that we should be
> careful not to remove power from stgit while doing this.

I agree.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
