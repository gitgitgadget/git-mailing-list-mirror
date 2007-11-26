From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: What's cooking in git.git (topics)
Date: Mon, 26 Nov 2007 04:45:38 +0000
Message-ID: <20071126044538.GC21120@fieldses.org>
References: <7vve7tuz3a.fsf@gitster.siamese.dyndns.org> <20071123103003.GB6754@sigill.intra.peff.net> <Pine.LNX.4.64.0711231319220.27959@racer.site> <20071124113814.GA17861@sigill.intra.peff.net> <alpine.LFD.0.99999.0711241042011.9605@xanadu.home> <7vtznbqx2w.fsf@gitster.siamese.dyndns.org> <20071125215128.GC23820@fieldses.org> <alpine.LFD.0.99999.0711252029020.9605@xanadu.home> <20071126041521.GA21120@fieldses.org> <alpine.LFD.0.99999.0711252324360.9605@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Mon Nov 26 05:46:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IwVrK-0001Ko-7r
	for gcvg-git-2@gmane.org; Mon, 26 Nov 2007 05:46:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754355AbXKZEpz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Nov 2007 23:45:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754155AbXKZEpz
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Nov 2007 23:45:55 -0500
Received: from mail.fieldses.org ([66.93.2.214]:57499 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752090AbXKZEpy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Nov 2007 23:45:54 -0500
Received: from bfields by fieldses.org with local (Exim 4.68)
	(envelope-from <bfields@fieldses.org>)
	id 1IwVqk-0006Hz-7r; Mon, 26 Nov 2007 04:45:38 +0000
Content-Disposition: inline
In-Reply-To: <alpine.LFD.0.99999.0711252324360.9605@xanadu.home>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66043>

On Sun, Nov 25, 2007 at 11:29:56PM -0500, Nicolas Pitre wrote:
> On Mon, 26 Nov 2007, J. Bruce Fields wrote:
> 
> > I do find that trying to work on top of a constantly rebased branch is
> > annoying no matter how I do it.  So I sometimes wonder if we shouldn't
> > instead be finding ways to avoid the practice.
> 
> I don't think it can't be avoided in many cases.  Some stuff gets 
> rebased because it has to be refined before it is merged in a more 
> stable and more "official" repository.

Well, there is for example the option of doing things like:

	git checkout -b new-mywork mywork
	git fetch origin
	git rebase new-mywork origin
	# further reordering of commits, etc., as needed
	git merge -s ours mywork
	git branch -d mywork
	git push mypubrepo new-mywork:mywork

and if you do this each time, then the public branch named "mywork"
always fast-forwards.  Its first parent, mywork^, is always a clean
patch series against upstream, and is what you'll eventually submit.
The second parent leads to historical versions of the patch series.

> Working on top of a rebased 
> branch could be much easier if there was a dedicated command to perform 
> the local rebase of one's work after a fetch, just like the pull command 
> does a merge after a fetch, at which point both work flows would be 
> almost equivalent wrt ease of use.

I don't think that works if you have more than one branch built on top
of the branch you're fetching.

The problem is that you have to do the rebase at the same time as the
fetch, because it's only the fetch that knows what the old head of the
branch was.

You don't need to know what the old head of the branch was before if
you're fetching a branch that always fast-forwards.  But you do in the
case where it doesn't fast-forward, because in that case the old head
will be forgotten as soon as you're done.

--b.
