From: Jeff King <peff@peff.net>
Subject: Re: [GSoC] Designing a faster index format
Date: Fri, 20 Apr 2012 13:02:43 -0700
Message-ID: <20120420200243.GA12578@sigill.intra.peff.net>
References: <1604FE70-8B77-4EC1-823A-DC1F0334CD3A@gmail.com>
 <4F7ABA19.7040408@alum.mit.edu>
 <C15BAB9A-EAFA-4EA4-85B2-0E0C5FF473E9@gmail.com>
 <alpine.DEB.2.02.1204031313170.10782@asgard.lang.hm>
 <D97085E6-2B9F-42C5-A06D-B53422034071@gmail.com>
 <87r4w1vofu.fsf@thomas.inf.ethz.ch>
 <878vi18eqd.fsf@thomas.inf.ethz.ch>
 <83571955-9256-4032-9182-FA9062D28B9D@gmail.com>
 <8D2805A4-9C5F-43A9-B3ED-0DB77341A03C@gmail.com>
 <877gxcoron.fsf@thomas.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Thomas Gummerer <t.gummerer@gmail.com>,
	Thomas Rast <trast@student.ethz.ch>, david@lang.hm,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	"Shawn O.Pearce" <spearce@spearce.org>,
	David Barr <davidbarr@google.com>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Fri Apr 20 22:02:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SLK2f-0005T0-EW
	for gcvg-git-2@plane.gmane.org; Fri, 20 Apr 2012 22:02:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751022Ab2DTUCt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Apr 2012 16:02:49 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:39320
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750770Ab2DTUCs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Apr 2012 16:02:48 -0400
Received: (qmail 14020 invoked by uid 107); 20 Apr 2012 20:02:57 -0000
Received: from c-67-169-43-61.hsd1.ca.comcast.net (HELO sigill.intra.peff.net) (67.169.43.61)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 20 Apr 2012 16:02:57 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 20 Apr 2012 13:02:43 -0700
Content-Disposition: inline
In-Reply-To: <877gxcoron.fsf@thomas.inf.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196016>

On Thu, Apr 19, 2012 at 02:02:32PM +0200, Thomas Rast wrote:

> > At the midterm, there will be a python prototype for the conversion of the old
> > index format to the new "future-proof" index format and a faster reader for the
> > new format. The native write part will be completed in the second part of the
> > Summer of Code.
> 
> I think this is the most important bit, and I'm curious if there are any
> objections/concerns on this.
> 
> It basically splits the project into
> 
> - first half: design, reader, raciness/locking issues
> - second half: writer, changes to take advantage of partial writing

I am OK with prototyping, and I'm OK with doing a throw-away prototype
in a different language. But doing a throw-away prototype that lasts
through the whole first half of the project makes me a little nervous.
I'm worried that the conversion from a python prototype to actual git
code in the second half is going to go badly and end up in either:

  1. A half-finished implementation, because the integration means we
     have to go back and re-visit assumptions made in the prototype that
     aren't valid in git itself.

  2. A conversion from python to C that is rushed and ends up doing
     things in a way that makes the conversion easier, but long term
     maintenance hard. Merge-recursive was originally written in python
     and converted to C, and it shows in the code. It's brittle, buggy,
     and hard to maintain (though that is just one data point; maybe it
     was just poorly written in the first place).

So I'd be more comfortable with the prototype being just for the design
phase, and developing the real reader and writer simultaneously in C.
Those implementations will also start as prototypes, but they can be
iterated on, rather than being throw-aways.

-Peff
