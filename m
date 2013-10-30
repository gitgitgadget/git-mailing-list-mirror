From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 12/19] rev-list: add bitmap mode to speed up object lists
Date: Wed, 30 Oct 2013 04:12:01 -0400
Message-ID: <20131030081201.GL11317@sigill.intra.peff.net>
References: <20131024175915.GA23398@sigill.intra.peff.net>
 <20131024180627.GL24180@sigill.intra.peff.net>
 <CAJo=hJvKG2sjWasO4YfExbbSN+U-q_it6gb43v_YJoL60XKwUg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git <git@vger.kernel.org>, Vicent Marti <vicent@github.com>
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Oct 30 09:12:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VbQsu-0000r6-CF
	for gcvg-git-2@plane.gmane.org; Wed, 30 Oct 2013 09:12:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753210Ab3J3IMI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Oct 2013 04:12:08 -0400
Received: from cloud.peff.net ([50.56.180.127]:58309 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752700Ab3J3IMF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Oct 2013 04:12:05 -0400
Received: (qmail 17816 invoked by uid 102); 30 Oct 2013 08:12:04 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 30 Oct 2013 03:12:04 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 30 Oct 2013 04:12:01 -0400
Content-Disposition: inline
In-Reply-To: <CAJo=hJvKG2sjWasO4YfExbbSN+U-q_it6gb43v_YJoL60XKwUg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237000>

On Fri, Oct 25, 2013 at 02:00:48PM +0000, Shawn O. Pearce wrote:

> On Thu, Oct 24, 2013 at 6:06 PM, Jeff King <peff@peff.net> wrote:
> > Note that most of the time we spend for --count invocations is on
> > generating the pack revindex. It may be worth storing a revidx (either
> > in a separate file, as part of the .idx, or as an optional section in
> > the .bitmap file).
> 
> This was discussed before, and it may make sense to cache the revidx.
> I'm glad to see the timings are already better with bitmaps, even
> though the revidx has to be computed on the fly for each invocation.

The radix sort makes a _huge_ difference there. But I would still like
an mmap-able .revidx cache. I think we can get at least another
order-of-magnitude speedup.

I'm intentionally leaving that out for now, though. I want to get this
series merged before trying to go much further.

-Peff
