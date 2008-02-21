From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH 2/2] Add support for url aliases in config files
Date: Thu, 21 Feb 2008 00:04:38 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0802202351400.19024@iabervon.org>
References: <200802202203.m1KM37aR012221@mi1.bluebottle.com>  <alpine.LSU.1.00.0802202221130.17164@racer.site>  <7v4pc316gq.fsf@gitster.siamese.dyndns.org> <76718490802201726t677b1498ma3bdb3dbf25dd781@mail.gmail.com>
 <alpine.LFD.1.00.0802201735030.7833@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jay Soffian <jaysoffian@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	=?ISO-2022-JP?Q?=1B$B$7$i$$$7$J$J$3=1B=28J?= 
	<nanako3@bluebottle.com>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Feb 21 06:06:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JS3cT-0000pD-8j
	for gcvg-git-2@gmane.org; Thu, 21 Feb 2008 06:05:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751053AbYBUFEk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Feb 2008 00:04:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751019AbYBUFEk
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Feb 2008 00:04:40 -0500
Received: from iabervon.org ([66.92.72.58]:43295 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750957AbYBUFEj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Feb 2008 00:04:39 -0500
Received: (qmail 15683 invoked by uid 1000); 21 Feb 2008 05:04:38 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 21 Feb 2008 05:04:38 -0000
In-Reply-To: <alpine.LFD.1.00.0802201735030.7833@woody.linux-foundation.org>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74594>

On Wed, 20 Feb 2008, Linus Torvalds wrote:

> On Wed, 20 Feb 2008, Jay Soffian wrote:
> 
> > On Wed, Feb 20, 2008 at 7:47 PM, Junio C Hamano <gitster@pobox.com> wrote:
> > >
> > >  In either case, I think a good approach to take is to find a
> > >  wording that conveys the notion "I will use A to mean what some
> > >  other people might call B or C" unambiguously.
> > 
> > [url A]
> >   other_people_call_it = B
> >   other_people_call_it = C
> > 
> > [local_url A]
> >   external_url = B
> >   external_url = C
> 
> Well, realistically, what's really the use of this?
> 
> The only really sane use of this is the one that Daniel started out with: 
> you may have a "external" representation of a name, but for your own 
> purely local configuration reasons, you may want to map that name into 
> another one that works for you.
> 
> The reason may be some local protocol issue: let's say that you see all 
> these pointers to git://git.kernel.org/ flying around, because that is the 
> official home of the git repository itself, but you work at a company that 
> has a firewall that doesn't let git through. So you want to still *use* 
> those names that other people use, but you want to remap them through some 
> proxy server (or a local cache), or just to use ssh instead.
> 
> So it's generally *not* that it's an "alias" for another site, since it 
> isn't that in general - it may just be a very local configuration thing. 
> It's also not really that you would call it one thing and others would 
> call it another thing: you want to call it the *same* thing as others call 
> it, but you want to work around some specific site issue (or just use a 
> cache that is closer without having to think about it).
> 
> So I think it really boils down to the fact that you want to "rewrite" the 
> thing. Not aliases, not "also known as", but you're logically really 
> looking for something like 
> 
> 	[access "git://git.kernel.org/*"]
> 		proxy = proxy-program
> 		url = "ssh://master.kernel.org/*"
> 
> which admittedly looks rather strange too, but at the same time it does 
> make sense from a "what do we really want to do?" standpoint.
> 
> Of course, in this case Daniel didn't actually do that "proxy" part, but I 
> think the argument that we should try to make the config file syntax 
> describe what the user wants to do is still very true. So skip that 
> "proxy" part (maybe somebody wants to do that too some day), and leave the 
> 
> 	[access "original"]
> 		url = "rewritten"
> 
> kind of syntax.

I think it has to be:

	[something "rewritten"]
		something = "original"
		something = "other original"

Because you want to be able to take multiple "original"s for the same 
result in order to avoid duplicating that part (and leading to skew if you 
decide to change). But I like the idea of basing the naming on the 
rewriting operation rather than the relationship. Maybe:

[url "rewritten"]
	insteadOf = "original"

	-Daniel
*This .sig left intentionally blank*
