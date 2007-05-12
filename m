From: Yann Dirson <ydirson@altern.org>
Subject: Re: Merging commits together into a super-commit
Date: Sat, 12 May 2007 13:34:30 +0200
Message-ID: <20070512113430.GL19253@nan92-1-81-57-214-146.fbx.proxad.net>
References: <1178794261.5806.98.camel@murta.transitives.com> <4643049C.3D5F30D8@eudaptics.com> <alpine.LFD.0.98.0705100857450.3986@woody.linux-foundation.org> <87wszg39cp.wl%cworth@cworth.org> <20070510171457.GK13719@fieldses.org> <87vef0350y.wl%cworth@cworth.org> <20070510192106.GB4489@pasky.or.cz> <87tzuk31fu.wl%cworth@cworth.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@suse.cz>,
	"J. Bruce Fields" <bfields@fieldses.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Sixt <J.Sixt@eudaptics.com>, git@vger.kernel.org
To: Carl Worth <cworth@cworth.org>
X-From: git-owner@vger.kernel.org Sat May 12 13:35:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hmpt0-0007SW-A2
	for gcvg-git@gmane.org; Sat, 12 May 2007 13:35:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754323AbXELLfi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 12 May 2007 07:35:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756059AbXELLfi
	(ORCPT <rfc822;git-outgoing>); Sat, 12 May 2007 07:35:38 -0400
Received: from smtp3-g19.free.fr ([212.27.42.29]:46509 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754323AbXELLfh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 May 2007 07:35:37 -0400
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp3-g19.free.fr (Postfix) with ESMTP id 640E85E1B4;
	Sat, 12 May 2007 13:35:36 +0200 (CEST)
Received: by gandelf.nowhere.earth (Postfix, from userid 1000)
	id D8E401F161; Sat, 12 May 2007 13:34:30 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <87tzuk31fu.wl%cworth@cworth.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47041>

On Thu, May 10, 2007 at 12:48:05PM -0700, Carl Worth wrote:
> On Thu, 10 May 2007 21:21:06 +0200, Petr Baudis wrote:
> > I think you are underestimating stg here.
> 
> Yes, maybe I didn't learn to use it well enough.
> 
> > You can stg init just once per branch (ever), I think.
> 
> I don't have details now, but I know I ran into some difficulty when
> leaving the extra stg state around.

I really think we should have a "stg uninit" command.  Note that
currently "stg branch --delete" on master will just do that instead of
really deleting the branch, but that is a known bug (#8732 on gna).

> It seems that it added stuff that
> resulted in some reference of mine becoming ambiguous, ("refspec <foo>
> matches more than one" perhaps?). What I do remember is that I couldn't
> get one of my standard git push commands to work until I deleted all
> of .git/refs/bases and .git/refs/patches and then things started to
> work again.

I remember quite some time ago that cg-push exhibited this behaviour.
However, nowadays I frequently push stgit stacks with git-push without
a problem.

> > 	stg uncommit -n N
> > 	stg pop -n N-1
> > 	..hack..
> > 	stg refresh
> > 	stg push -a
> >
> > It seems to be a bit shorter than the sequence you've presented above,
> > and overally working with volatile commits using StGIT feels much more
> > natural to me - and I haven't even ever used quilt seriously! (I have
> > special antipathy to the git reset UI, too.)
> 
> The -n option is something I hadn't noticed, and that helps, (except
> that what I've got to start with is a git revision name, not a
> number).

While "uncommit to named commit" that Karl implemented helps here, and
that "stg goto <patchname>" may be a viable alternative to "pop -n",
you may also want to try:

	stg uncommit -t <commit>
	..hack..
	stg refresh -p <patchname>

There are still some rough edges with "refresh -p", though[*], but
when it works I love this comfort :)

Best regards,
-- 
Yann.

[*] most notably, it does not work yet if any patch above the one you
want to modify changes the same file)
