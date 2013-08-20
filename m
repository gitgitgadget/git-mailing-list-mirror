From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/2] git-config and large integers
Date: Tue, 20 Aug 2013 18:48:30 -0400
Message-ID: <20130820224830.GC24766@sigill.intra.peff.net>
References: <20130820223953.GA3429@sigill.intra.peff.net>
 <5213F146.1010509@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Stefan Beller <stefanbeller@googlemail.com>
X-From: git-owner@vger.kernel.org Wed Aug 21 00:48:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VBuj8-0007mF-Ts
	for gcvg-git-2@plane.gmane.org; Wed, 21 Aug 2013 00:48:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751378Ab3HTWsf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Aug 2013 18:48:35 -0400
Received: from cloud.peff.net ([50.56.180.127]:41102 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751275Ab3HTWse (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Aug 2013 18:48:34 -0400
Received: (qmail 13829 invoked by uid 102); 20 Aug 2013 22:48:34 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 20 Aug 2013 17:48:34 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 20 Aug 2013 18:48:30 -0400
Content-Disposition: inline
In-Reply-To: <5213F146.1010509@googlemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232664>

On Wed, Aug 21, 2013 at 12:44:22AM +0200, Stefan Beller wrote:

> On 08/21/2013 12:39 AM, Jeff King wrote:
> > I was playing with a hook for file size limits that wanted to store the
> > limit in git-config. It turns out we don't do a very good job of big
> > integers:
> > 
> >   $ git config foo.size 2g
> >   $ git config --int foo.size
> >   -2147483648
> > 
> > Oops. After this series, we properly notice the error:
> > 
> >   $ git config --int foo.size
> >   fatal: bad config value for 'foo.size' in .git/config
> > 
> > and even better, provide a way to access large values:
> > 
> >   $ git config --ulong foo.size
> >   2147483648
> > 
> 
> int, ulong...
> How large will those be, I'd guess they are machine dependent?
> So int being 32 bits as usual, but not on all machines.
> (Those, which don't have 32 bits, are maybe not relevant anyways?)

Yes, machine dependent. See the discussion in the patches themselves.
It's kind of ugly, but it matches what git does internally (and we
properly detect range errors at runtime).

-Peff
