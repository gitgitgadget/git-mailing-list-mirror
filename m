From: Ted Ts'o <tytso@mit.edu>
Subject: Re: Keeping unreachable objects in a separate pack instead of
 loose?
Date: Tue, 12 Jun 2012 15:19:29 -0400
Message-ID: <20120612191929.GA12161@thunk.org>
References: <20120611222308.GA10476@sigill.intra.peff.net>
 <alpine.LFD.2.02.1206112024110.23555@xanadu.home>
 <20120612171048.GB12706@sigill.intra.peff.net>
 <alpine.LFD.2.02.1206121326490.23555@xanadu.home>
 <20120612173214.GA16014@sigill.intra.peff.net>
 <alpine.LFD.2.02.1206121345500.23555@xanadu.home>
 <20120612175438.GB16522@sigill.intra.peff.net>
 <alpine.LFD.2.02.1206121359260.23555@xanadu.home>
 <20120612183702.GD1803@thunk.org>
 <alpine.LFD.2.02.1206121509340.23555@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Thomas Rast <trast@student.ethz.ch>,
	Hallvard B Furuseth <h.b.furuseth@usit.uio.no>,
	git@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Tue Jun 12 21:19:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SeWct-0001ab-Ii
	for gcvg-git-2@plane.gmane.org; Tue, 12 Jun 2012 21:19:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753444Ab2FLTTf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jun 2012 15:19:35 -0400
Received: from li9-11.members.linode.com ([67.18.176.11]:49406 "EHLO
	imap.thunk.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752104Ab2FLTTf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jun 2012 15:19:35 -0400
Received: from root (helo=tytso-glaptop.cam.corp.google.com)
	by imap.thunk.org with local-esmtp (Exim 4.72)
	(envelope-from <tytso@thunk.org>)
	id 1SeWcj-0007KB-82; Tue, 12 Jun 2012 19:19:29 +0000
Received: from tytso by tytso-glaptop.cam.corp.google.com with local (Exim 4.71)
	(envelope-from <tytso@thunk.org>)
	id 1SeWcj-0003Aa-3K; Tue, 12 Jun 2012 15:19:29 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.02.1206121509340.23555@xanadu.home>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199837>

On Tue, Jun 12, 2012 at 03:15:46PM -0400, Nicolas Pitre wrote:
> > But the old packs are huge; in my case, a full set of packs was around
> > 16 megabytes.  Right now, git gc *increased* my disk usage by 4.5
> > megabytes.  If we don't delete the old backs, then git gc would
> > increase disk usage by 16 megabytes --- which is far, far worse.
> > 
> > Writing a 244k cruft pack is a soooooo much preferable.
> 
> But as you might have noticed, there are a bunch of semantic problems 
> with that as well.

I've proposed something (explicitly labelled cruft packs) which is no
worse than before.  The one potential problem is that objects in the
cruft pack might have their lifespan extended by two weeks (or
whatever the expire timeout might be), but Peff has agreed that it's
simple enough to ignore that, since the benefits far outweigh the
potential that some objects in cruft packs will get to live a bit
longer.

The race condition you've pointed out exists today, with the git prune
racing against the git fetch.

					- Ted
