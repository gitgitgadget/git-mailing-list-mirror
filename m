From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: RFC: Flat directory for notes, or fan-out?  Both!
Date: Tue, 10 Feb 2009 14:32:22 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0902101427490.10279@pacific.mpi-cbg.de>
References: <alpine.DEB.1.00.0902092200170.10279@pacific.mpi-cbg.de> <20090210121833.GC15491@coredump.intra.peff.net> <alpine.DEB.1.00.0902101357140.10279@pacific.mpi-cbg.de> <20090210131029.GC17305@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, spearce@spearce.org
To: Jeff King <peff@peff.net>, gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Feb 10 14:33:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWsja-0005QP-Px
	for gcvg-git-2@gmane.org; Tue, 10 Feb 2009 14:33:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754076AbZBJNbk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Feb 2009 08:31:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753942AbZBJNbj
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Feb 2009 08:31:39 -0500
Received: from mail.gmx.net ([213.165.64.20]:49454 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753896AbZBJNbj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Feb 2009 08:31:39 -0500
Received: (qmail invoked by alias); 10 Feb 2009 13:31:37 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp058) with SMTP; 10 Feb 2009 14:31:37 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX199lQZprLt9XTQiiYs8/HebGmc3EktZP29qrm90fy
	0l8OPbrp6ZFla8
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <20090210131029.GC17305@coredump.intra.peff.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.59
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109238>

Hi,

[Junio: seems like both Peff and me would like to hold the notes out of 
1.6.2, would you mind?]

On Tue, 10 Feb 2009, Jeff King wrote:

> On Tue, Feb 10, 2009 at 01:59:06PM +0100, Johannes Schindelin wrote:
> 
> > > Hmm. Do we really care about how easy it is to generate? Are we
> > > expecting people to not use the command interface and instead check out
> > > a notes tree and start putting stuff into $commit/foo?
> > 
> > I wanted to be nice to existing users of the feature (it is in 'next', 
> > after all, and Thomas has produced some awesome examples, that will 
> > hopefully show the scalability of the thing).
> > 
> > But you're right, it almost, but not quite, too late to switch.
> 
> OK. I think if you are seeing performance benefits from a 2-character
> fanout, then we should standardize on that (do you have new performance
> numbers somewhere?).

The thing is: Shawn is correct when he says that a tree object to hold the 
notes of all commits (which is not an unlikely scenario if you are 
thinking about corporate processes) would be huge.

> The notes implementation is now in master. If it's about to change in an 
> incompatible way, how do you want to handle it? I'm wary of a quick 
> patch to change the format this late in the release cycle. We could hold 
> it back from 1.6.2. Alternatively, we could let it release with a "this 
> is probably going to change" warning.
> 
> I think I favor holding it back, but I am not picky.

Yes, I am also in favor of holding it back.

> > > multiple notes some sane semantics (one trumps the other, or they are a
> > > list, or whatever), but there is still an inconsistency: B's notes and
> > > C's notes behave differently. So now A has to start caring about how
> > > other people generate their notes.
> > > [...]
> > 
> > You're correct.  This buys all kinds of trouble.
> 
> One other thing to note: I think we discussed in the past other kinds of
> "more than one way to store it" strategies (e.g., letting a blob note be
> the same as a tree note containing a blob "default"). They suffer from
> some of the same issues (though not quite as badly, since you would at
> least see that there was a conflict).

Actually, I do not see much of a problem there.  If the entry 
(corresponding to the commit name) in the notes tree points to a blob, 
then that is that, if it points to a tree, then we just read all of the 
objects therein (or maybe at a later stage we allow restricting to a 
certain file basename).

The point you raised earlier, that there would be a lot of ambiguity if 
we allow both flat and fan-out directory structures, is a valid point, 
though.

Ciao,
Dscho
