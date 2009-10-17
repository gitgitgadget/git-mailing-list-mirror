From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: [PATCH] Proof-of-concept patch to remember what the detached
 HEAD was
Date: Sat, 17 Oct 2009 19:04:21 +0200
Message-ID: <20091017170421.GA10490@atjola.homenet>
References: <20091014230934.GC29664@coredump.intra.peff.net>
 <885649360910150036o72c3bd97ofad85d5316dc5b35@mail.gmail.com>
 <alpine.LNX.2.00.0910151523020.32515@iabervon.org>
 <alpine.LNX.2.00.0910161311460.28491@reaper.quantumfyre.co.uk>
 <20091016143041.GA11821@atjola.homenet>
 <alpine.LNX.2.00.0910161821230.30589@reaper.quantumfyre.co.uk>
 <7vvdiftb0d.fsf@alter.siamese.dyndns.org>
 <alpine.LNX.2.00.0910162029460.31673@reaper.quantumfyre.co.uk>
 <alpine.LFD.2.00.0910161557500.20122@xanadu.home>
 <alpine.LNX.2.00.0910171606180.6644@reaper.quantumfyre.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nicolas Pitre <nico@fluxnic.net>,
	Junio C Hamano <gitster@pobox.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	James Pickens <jepicken@gmail.com>, Jeff King <peff@peff.net>,
	Jay Soffian <jaysoffian@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Julian Phillips <julian@quantumfyre.co.uk>
X-From: git-owner@vger.kernel.org Sat Oct 17 19:04:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MzChq-0001nO-9w
	for gcvg-git-2@lo.gmane.org; Sat, 17 Oct 2009 19:04:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752390AbZJQREX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 17 Oct 2009 13:04:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752117AbZJQREX
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Oct 2009 13:04:23 -0400
Received: from mail.gmx.net ([213.165.64.20]:44771 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751726AbZJQREW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Oct 2009 13:04:22 -0400
Received: (qmail invoked by alias); 17 Oct 2009 17:04:25 -0000
Received: from i59F5B216.versanet.de (EHLO atjola.homenet) [89.245.178.22]
  by mail.gmx.net (mp005) with SMTP; 17 Oct 2009 19:04:25 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX19Eu6swjKJEx/8LhCfxtJuGQbp2BGcs40qZcqGoCQ
	CvvlOhyvxKXkUU
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.00.0910171606180.6644@reaper.quantumfyre.co.uk>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.49
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130565>

On 2009.10.17 16:15:13 +0100, Julian Phillips wrote:
> On Fri, 16 Oct 2009, Nicolas Pitre wrote:
>=20
> >On Fri, 16 Oct 2009, Julian Phillips wrote:
> >
> >>My interest in this thread is solely that it might provide a mechan=
ism to find
> >>out which tag was checked out.  So, I'm just chucking in my $0.02 a=
s a user.
> >
> >Try this:
> >
> >$ git checkout v1.5.5
> >Note: moving to 'v1.5.5' which isn't a local branch
> >If you want to create a new branch from this checkout, you may do so
> >(now or later) by using -b with the checkout command again. Example:
> > git checkout -b <new_branch_name>
> >HEAD is now at 1d2375d... GIT 1.5.5
> >
> >[look around, and then ...]
> >
> >$ git checkout HEAD~2
> >Previous HEAD position was 1d2375d... GIT 1.5.5
> >HEAD is now at f61cc48... git-svn: fix following renamed paths when =
tracking a single path
> >
> >[go out for lunch ... and forget what this was about.]
> >
> >$ git reflog -3
> >f61cc48 HEAD@{0}: checkout: moving from 1d2375d... to HEAD~2
> >1d2375d HEAD@{1}: checkout: moving from master to v1.5.5
> >c274db7 HEAD@{2}: pull : Fast forward
> >
> >Here I have all the information to see what I did, and from what sta=
te.
> >I even know that I did a pull on the master branch before moving awa=
y
> >from it.  The -3 limits the log to 3 entries.  With no limit you get=
 it
> >all in your default pager.
> >
> >So there is no need for another mechanism to find out what tag was
> >actually checked out -- you have it all already.
>=20
> What I want is a way for my build process to reliably know what
> branch or tag is currently being built.  "git symbolic-ref HEAD"
> will give me the branch name, but doesn't work for tags.  "git
> describe" will find _a_ tag, but I can't tell if it's actually the
> one checked out.

Do you have multiple (annotated) tags for the same commit? Otherwise, I
don't see why "git describe HEAD" should print the wrong one. If there'=
s
a tag that can be resolved to the same commit that HEAD can be resolved=
,
then "git describe HEAD" must output that one. Otherwise, that'd be a
clear bug to me.

Bj=F6rn
