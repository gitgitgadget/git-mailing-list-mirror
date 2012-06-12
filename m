From: Ted Ts'o <tytso@mit.edu>
Subject: Re: Keeping unreachable objects in a separate pack instead of
 loose?
Date: Tue, 12 Jun 2012 15:43:56 -0400
Message-ID: <20120612194356.GD12161@thunk.org>
References: <20120612171048.GB12706@sigill.intra.peff.net>
 <alpine.LFD.2.02.1206121326490.23555@xanadu.home>
 <20120612173214.GA16014@sigill.intra.peff.net>
 <alpine.LFD.2.02.1206121345500.23555@xanadu.home>
 <20120612175438.GB16522@sigill.intra.peff.net>
 <alpine.LFD.2.02.1206121359260.23555@xanadu.home>
 <20120612183702.GD1803@thunk.org>
 <alpine.LFD.2.02.1206121509340.23555@xanadu.home>
 <20120612191929.GA12161@thunk.org>
 <alpine.LFD.2.02.1206121533370.23555@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Thomas Rast <trast@student.ethz.ch>,
	Hallvard B Furuseth <h.b.furuseth@usit.uio.no>,
	git@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Tue Jun 12 21:44:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SeX0a-0005kp-N3
	for gcvg-git-2@plane.gmane.org; Tue, 12 Jun 2012 21:44:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752399Ab2FLToE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jun 2012 15:44:04 -0400
Received: from li9-11.members.linode.com ([67.18.176.11]:49426 "EHLO
	imap.thunk.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751951Ab2FLToD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jun 2012 15:44:03 -0400
Received: from root (helo=tytso-glaptop.cam.corp.google.com)
	by imap.thunk.org with local-esmtp (Exim 4.72)
	(envelope-from <tytso@thunk.org>)
	id 1SeX0O-0007Lj-Mb; Tue, 12 Jun 2012 19:43:56 +0000
Received: from tytso by tytso-glaptop.cam.corp.google.com with local (Exim 4.71)
	(envelope-from <tytso@thunk.org>)
	id 1SeX0O-0003is-Ij; Tue, 12 Jun 2012 15:43:56 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.02.1206121533370.23555@xanadu.home>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199844>

On Tue, Jun 12, 2012 at 03:35:17PM -0400, Nicolas Pitre wrote:
> > 
> > The race condition you've pointed out exists today, with the git prune
> > racing against the git fetch.
> 
> Yes, however that race is trivial to fix when loose objects are used.

We can use the same trivial fix with the cruft pack, by touching the
mtime of the pack.  Yes, it will extend the lifetime of the cruft pack
by another 2 weeks but again, let me remind you: 244k versus 4.5
megabytes.  I can live with an extra 244k hanging around a wee bit
longer.  :-)

There are other fixes we could do involving flock() and removing the
cruft label once we add a reference to a cruft pack, that I don't
think would be that complicated.

						- Ted
