From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH] Proof-of-concept patch to remember what the detached
 HEAD was
Date: Fri, 16 Oct 2009 02:02:09 -0400 (EDT)
Message-ID: <alpine.LNX.2.00.0910160128400.32515@iabervon.org>
References: <alpine.LFD.2.00.0910141616530.20122@xanadu.home> <7v7huxbtbk.fsf@alter.siamese.dyndns.org> <alpine.LFD.2.00.0910141647390.20122@xanadu.home> <7vws2xa9lu.fsf@alter.siamese.dyndns.org> <20091014230934.GC29664@coredump.intra.peff.net>
 <885649360910150036o72c3bd97ofad85d5316dc5b35@mail.gmail.com> <alpine.LFD.2.00.0910151436180.20122@xanadu.home> <7v1vl45t9k.fsf@alter.siamese.dyndns.org> <20091015212632.GA13180@coredump.intra.peff.net> <7v1vl42uid.fsf@alter.siamese.dyndns.org>
 <20091016042955.GA9233@atjola.homenet>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1547844168-623731613-1255672929=:32515"
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Nicolas Pitre <nico@fluxnic.net>,
	James Pickens <jepicken@gmail.com>,
	Jay Soffian <jaysoffian@gmail.com>, git@vger.kernel.org
To: =?ISO-8859-15?Q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Fri Oct 16 08:02:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Myftv-0006Ru-5a
	for gcvg-git-2@lo.gmane.org; Fri, 16 Oct 2009 08:02:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753449AbZJPGCr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Oct 2009 02:02:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753410AbZJPGCr
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Oct 2009 02:02:47 -0400
Received: from iabervon.org ([66.92.72.58]:42110 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753226AbZJPGCq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Oct 2009 02:02:46 -0400
Received: (qmail 19225 invoked by uid 1000); 16 Oct 2009 06:02:09 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 16 Oct 2009 06:02:09 -0000
In-Reply-To: <20091016042955.GA9233@atjola.homenet>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130458>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1547844168-623731613-1255672929=:32515
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT

On Fri, 16 Oct 2009, Björn Steinbrink wrote:

> On 2009.10.15 14:54:18 -0700, Junio C Hamano wrote:
> > If it is very important to support:
> > 
> >     $ git checkout --look-but-not-touch origin/next^
> > 
> > then James's approach would not be very useful, as we do have to detach
> > HEAD and implement the "do not touch" logic for detached HEAD state
> > anyway, so we might just use the same logic we would use for origin/next^
> > when checking out origin/next itself.
> 
> I don't have any numbers backing this up, but my gut feeling says that
> most cases of "Where have my commits gone?" that I have seen on #git
> were due to "git checkout HEAD~2"-like actions. Either because the user
> assumed SVN-like behaviour (you can't commit until you do "svn up", like
> "git reset --merge HEAD@{1}") or thought that "git checkout
> <committish>" would act like "git reset --hard <committish>".
> 
> For the latter I fail to envision any solution except for
> education (and I have no idea why the user expected checkout to work
> like reset).
> 
> The former can be solved by the proposed extra information in HEAD,
> forbidding changes to HEAD that make it reference a commit that's not
> reachable through the head stored in the extra information[*1*] and providing
> some command that acts like "svn up".
> 
> This seems quite different from the plain "forbid committing" or "detach
> and know how you get there", but more like "detach and know where you're
> coming from".

What's the state before the "git checkout HEAD~2"?

If it's:

$ git checkout origin/some-obscure-branch
(get curious about the commit a bit back)
$ git checkout HEAD~2

And then the user doesn't know how to get back to where they were, then it 
should work if git had stored "origin/some-obscure-branch~2" at this point 
(having substituted "origin/some-obscure-branch" (the previous extra info) 
for HEAD). Then we could have a "git up" that would discard modifiers from 
the extra info and check that out. Or users might find "git checkout 
origin/some-obscure-branch" obvious enough if git is reporting something 
related.

I know I often find my git.git repos on "* (no branch)", and I don't 
remember if I checked that out as origin/master or origin/next. And that's 
an important clue as to when I'd been doing there previously, and what I 
might want to do next. Perhaps these users are having a similar problem, 
where they're relying on git to remember what they were doing?

	-Daniel
*This .sig left intentionally blank*
--1547844168-623731613-1255672929=:32515--
