From: Jeff King <peff@peff.net>
Subject: Re: Keeping unreachable objects in a separate pack instead of loose?
Date: Tue, 12 Jun 2012 13:10:48 -0400
Message-ID: <20120612171048.GB12706@sigill.intra.peff.net>
References: <87vcixaoxe.fsf@thomas.inf.ethz.ch>
 <20120611153103.GA16086@thunk.org>
 <20120611160824.GB12773@sigill.intra.peff.net>
 <20120611172732.GB16086@thunk.org>
 <20120611183414.GD20134@sigill.intra.peff.net>
 <20120611211401.GA21775@thunk.org>
 <20120611213948.GB32061@sigill.intra.peff.net>
 <20120611221439.GE21775@thunk.org>
 <20120611222308.GA10476@sigill.intra.peff.net>
 <alpine.LFD.2.02.1206112024110.23555@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Ted Ts'o <tytso@mit.edu>, Thomas Rast <trast@student.ethz.ch>,
	Hallvard B Furuseth <h.b.furuseth@usit.uio.no>,
	git@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Tue Jun 12 19:11:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SeUcR-0007oj-Pt
	for gcvg-git-2@plane.gmane.org; Tue, 12 Jun 2012 19:11:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753818Ab2FLRKx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jun 2012 13:10:53 -0400
Received: from 99-108-225-23.lightspeed.iplsin.sbcglobal.net ([99.108.225.23]:51173
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753400Ab2FLRKv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jun 2012 13:10:51 -0400
Received: (qmail 22370 invoked by uid 107); 12 Jun 2012 17:10:52 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 12 Jun 2012 13:10:52 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 12 Jun 2012 13:10:48 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.02.1206112024110.23555@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199814>

On Mon, Jun 11, 2012 at 08:41:03PM -0400, Nicolas Pitre wrote:

> > On Mon, Jun 11, 2012 at 06:14:39PM -0400, Ted Ts'o wrote:
> > 
> > > One last thought: if a sysadmin is really hard up for space, (and if
> > > the cruft objects include some really big sound or video files) one
> > > advantage of labelling the cruft packs explicitly is that someone who
> > > really needs the space could potentially find the oldest cruft files
> > > and delete them, since they would be tagged for easy findability.
> > 
> > No! That's exactly what I was worried about with the name. It is _not_
> > safe to do so. It's only safe after you have done a full repack to
> > rescue any non-cruft objects.
> 
> To make it "safe", the cruft packs would have to be searchable for 
> object retrieval, but not during object creation.  That nuance would 
> affect the core code in subtle ways and I'm not sure if that would be 
> worth it ... just for the safe handling of cruft.

Why is that? If you do a "repack -Ad", then any referenced objects will
have been retrieved and put into the new all-in-one pack. At that point,
by deleting the cruft pack, you are guaranteed to be deleting only
objects that are either unreferenced, or are duplicated in another pack.

-Peff
