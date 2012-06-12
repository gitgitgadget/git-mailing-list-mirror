From: Jeff King <peff@peff.net>
Subject: Re: Keeping unreachable objects in a separate pack instead of loose?
Date: Tue, 12 Jun 2012 13:32:14 -0400
Message-ID: <20120612173214.GA16014@sigill.intra.peff.net>
References: <20120611160824.GB12773@sigill.intra.peff.net>
 <20120611172732.GB16086@thunk.org>
 <20120611183414.GD20134@sigill.intra.peff.net>
 <20120611211401.GA21775@thunk.org>
 <20120611213948.GB32061@sigill.intra.peff.net>
 <20120611221439.GE21775@thunk.org>
 <20120611222308.GA10476@sigill.intra.peff.net>
 <alpine.LFD.2.02.1206112024110.23555@xanadu.home>
 <20120612171048.GB12706@sigill.intra.peff.net>
 <alpine.LFD.2.02.1206121326490.23555@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Ted Ts'o <tytso@mit.edu>, Thomas Rast <trast@student.ethz.ch>,
	Hallvard B Furuseth <h.b.furuseth@usit.uio.no>,
	git@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Tue Jun 12 19:32:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SeUx2-0000aW-WD
	for gcvg-git-2@plane.gmane.org; Tue, 12 Jun 2012 19:32:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753729Ab2FLRcR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jun 2012 13:32:17 -0400
Received: from 99-108-225-23.lightspeed.iplsin.sbcglobal.net ([99.108.225.23]:51192
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752628Ab2FLRcQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jun 2012 13:32:16 -0400
Received: (qmail 22753 invoked by uid 107); 12 Jun 2012 17:32:18 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 12 Jun 2012 13:32:18 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 12 Jun 2012 13:32:14 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.02.1206121326490.23555@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199816>

On Tue, Jun 12, 2012 at 01:30:07PM -0400, Nicolas Pitre wrote:

> > > To make it "safe", the cruft packs would have to be searchable for 
> > > object retrieval, but not during object creation.  That nuance would 
> > > affect the core code in subtle ways and I'm not sure if that would be 
> > > worth it ... just for the safe handling of cruft.
> > 
> > Why is that? If you do a "repack -Ad", then any referenced objects will
> > have been retrieved and put into the new all-in-one pack. At that point,
> > by deleting the cruft pack, you are guaranteed to be deleting only
> > objects that are either unreferenced, or are duplicated in another pack.
> 
> Now what if you fetch and a bunch of objects are already found in your 
> cruft pack?  Right now, we search for the existence of any object before 
> creating them, and if the cruft packs are searchable then such objects 
> won't get uncruftified.

Then those objects will remain in the cruft pack. Which is why, as I
said, it is not generally safe to just delete a cruft pack. However,
when you do a full repack, those objects will be copied into the new
pack (because they are referenced). Which is why I am claiming that it
is safe to remove cruft packs at that point.

-Peff
