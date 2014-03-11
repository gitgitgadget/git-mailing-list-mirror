From: Jeff King <peff@peff.net>
Subject: Re: [GSoC14][RFC] Proposal Draft: Refactor tempfile handling
Date: Tue, 11 Mar 2014 14:05:59 -0400
Message-ID: <20140311180559.GB28154@sigill.intra.peff.net>
References: <CAN7MxmVQuk96dmXfxZ5kRZPTXNwpz2RY=y8HyqX4mZzrZUVbNg@mail.gmail.com>
 <531F3959.4060608@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Brian Gesiak <modocache@gmail.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Mar 11 19:06:09 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WNR44-0004cK-0I
	for gcvg-git-2@plane.gmane.org; Tue, 11 Mar 2014 19:06:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753752AbaCKSGB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Mar 2014 14:06:01 -0400
Received: from cloud.peff.net ([50.56.180.127]:37508 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752834AbaCKSGB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Mar 2014 14:06:01 -0400
Received: (qmail 19645 invoked by uid 102); 11 Mar 2014 18:06:00 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 11 Mar 2014 13:06:00 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 11 Mar 2014 14:05:59 -0400
Content-Disposition: inline
In-Reply-To: <531F3959.4060608@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243875>

On Tue, Mar 11, 2014 at 05:27:05PM +0100, Michael Haggerty wrote:

> Thanks for your proposal.  I have a technical point that I think your
> proposal should address:
> 
> Currently the linked list of lockfiles only grows, never shrinks.  Once
> an object has been linked into the list, there is no way to remove it
> again even after the lock has been released.  So if a lock needs to be
> created dynamically at a random place in the code, its memory is
> unavoidably leaked.

Thanks, I remember thinking about this when I originally conceived of
the idea, but I forgot to mention it in the idea writeup.

In most cases the potential leaks are finite and small, but object
creation and diff tempfiles could both be unbounded. So this is
definitely something to consider. In both cases we have a bounded number
of _simultaneous_ tempfiles, so one strategy could be to continue using
static objects. But it should not be hard to do it dynamically, and I
suspect the resulting API will be a lot easier to comprehend.

-Peff
