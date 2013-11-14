From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 0/21] pack bitmaps
Date: Thu, 14 Nov 2013 16:33:20 -0500
Message-ID: <20131114213320.GA16466@sigill.intra.peff.net>
References: <20131114124157.GA23784@sigill.intra.peff.net>
 <5285224A.2070606@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org,
	Vicent =?utf-8?B?TWFydMOt?= <vicent@github.com>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Thu Nov 14 22:33:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vh4XX-0000LR-7R
	for gcvg-git-2@plane.gmane.org; Thu, 14 Nov 2013 22:33:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757446Ab3KNVdY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Nov 2013 16:33:24 -0500
Received: from cloud.peff.net ([50.56.180.127]:39419 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757096Ab3KNVdW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Nov 2013 16:33:22 -0500
Received: (qmail 6759 invoked by uid 102); 14 Nov 2013 21:33:22 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 14 Nov 2013 15:33:22 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 14 Nov 2013 16:33:20 -0500
Content-Disposition: inline
In-Reply-To: <5285224A.2070606@ramsay1.demon.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237878>

On Thu, Nov 14, 2013 at 07:19:38PM +0000, Ramsay Jones wrote:

> Unfortunately, I didn't find time this weekend to finish the msvc build
> fixes. However, after a quick squint at these patches, I think you have
> almost done it for me! :-D
> 
> I must have misunderstood the previous discussion, because my patch was
> written on the assumption that the ewah directory wouldn't be "git-ified"
> (e.g. #include git-compat-util.h).

I think it was up for debate at some point, but we did decide to go
ahead and git-ify. Please feel free to submit further fixups if you need
them.

> >   - the ewah code used gcc's __builtin_ctzll, but did not provide a
> >     suitable fallback. We now provide a fallback in C.
> 
> ... here.
> 
> I was messing around with several implementations (including the use of
> msvc compiler intrinsics) with the intention of doing some timing tests
> etc. [I suspected my C fallback function (a different implementation to
> yours) would be slightly faster.]

Yeah, I looked around for several implementations, and ultimately wrote
one that was the most readable to me. The one I found shortest and most
inscrutable was:

  return popcount((x & -x) - 1);

the details of which I still haven't worked through in my head. ;)

I do think on most platforms that intrinsics or inline assembler are the
way to go. My main goal was to get something correct that would let it
compile everywhere, and then people can use that as a base for
optimizing. Patches welcome. :)

-Peff
