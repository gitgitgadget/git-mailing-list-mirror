From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: [PATCH] Proof-of-concept patch to remember what the detached
 HEAD was
Date: Fri, 16 Oct 2009 16:30:41 +0200
Message-ID: <20091016143041.GA11821@atjola.homenet>
References: <76718490910141156g440ee455t2e1db72ad72b7049@mail.gmail.com>
 <alpine.LNX.2.00.0910141509200.32515@iabervon.org>
 <alpine.LFD.2.00.0910141616530.20122@xanadu.home>
 <7v7huxbtbk.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.00.0910141647390.20122@xanadu.home>
 <7vws2xa9lu.fsf@alter.siamese.dyndns.org>
 <20091014230934.GC29664@coredump.intra.peff.net>
 <885649360910150036o72c3bd97ofad85d5316dc5b35@mail.gmail.com>
 <alpine.LNX.2.00.0910151523020.32515@iabervon.org>
 <alpine.LNX.2.00.0910161311460.28491@reaper.quantumfyre.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	James Pickens <jepicken@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	Nicolas Pitre <nico@fluxnic.net>,
	Jay Soffian <jaysoffian@gmail.com>, git@vger.kernel.org
To: Julian Phillips <julian@quantumfyre.co.uk>
X-From: git-owner@vger.kernel.org Fri Oct 16 16:34:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MynsJ-0004ff-6B
	for gcvg-git-2@lo.gmane.org; Fri, 16 Oct 2009 16:33:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760279AbZJPObf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 16 Oct 2009 10:31:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760235AbZJPObe
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Oct 2009 10:31:34 -0400
Received: from mail.gmx.net ([213.165.64.20]:53236 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1760234AbZJPObe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Oct 2009 10:31:34 -0400
Received: (qmail invoked by alias); 16 Oct 2009 14:30:46 -0000
Received: from i59F5487B.versanet.de (EHLO atjola.homenet) [89.245.72.123]
  by mail.gmx.net (mp060) with SMTP; 16 Oct 2009 16:30:46 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX1/5+rok7Vj50k12Y8E5pFITQIIDRirkZAOOFTGHdN
	esSnSwncWlOFtB
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.00.0910161311460.28491@reaper.quantumfyre.co.uk>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.57
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130499>

On 2009.10.16 13:15:35 +0100, Julian Phillips wrote:
> On Thu, 15 Oct 2009, Daniel Barkalow wrote:
>=20
> >On Thu, 15 Oct 2009, James Pickens wrote:
> >
> >>How about not detaching the head at all if the user checks out any =
ref, and
> >>reject commits if he checked out a tag or remote branch.  For examp=
le:
> >>
> >>$ git checkout origin/master
> >>$ git status
> >># On branch origin/master
> >>$ git commit ;# complain
> >
> >$ git checkout origin/master
> >$ git fetch
> >$ git checkout origin/next
> >Uncommited file '...' would be overwritten.
>=20
> How about:
>=20
> $ git checkout origin/master
> $ git fetch
> Refusing to fetch, as it would update a checkedout branch
> "git fetch -f" will force the update, but you will need to run "git
> reset --hard HEAD" to update your checkout to match.

That would redefine -f (currently means "allow non-fast-forward
updates"), the flag that allows the checked out branch head to be
updated is -u, --update-head-ok, and is for internal use only.

And suggesting "reset --hard" seems wrong, that just kills any
uncommitted changes.

And such uncommitted changes would be lost in the big "undo the fetch
update" diff. So you'd have to do:
git reset --soft HEAD@{1}
git checkout --merge HEAD@{1}

to keep them, while updating to the new state of the remote tracking
branch. Not quite intuitive, is it?

Bj=F6rn
