From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] compat: move unaligned helpers to bswap.h
Date: Thu, 23 Jan 2014 14:44:01 -0500
Message-ID: <20140123194401.GA31412@sigill.intra.peff.net>
References: <20140123183320.GA22995@sigill.intra.peff.net>
 <20140123183522.GA26447@sigill.intra.peff.net>
 <20140123194118.GT18964@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 23 20:44:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W6QC9-0000ac-HV
	for gcvg-git-2@plane.gmane.org; Thu, 23 Jan 2014 20:44:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753337AbaAWToE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Jan 2014 14:44:04 -0500
Received: from cloud.peff.net ([50.56.180.127]:37681 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752317AbaAWToD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jan 2014 14:44:03 -0500
Received: (qmail 26288 invoked by uid 102); 23 Jan 2014 19:44:02 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 23 Jan 2014 13:44:02 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 23 Jan 2014 14:44:01 -0500
Content-Disposition: inline
In-Reply-To: <20140123194118.GT18964@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240930>

On Thu, Jan 23, 2014 at 11:41:18AM -0800, Jonathan Nieder wrote:

> Jeff King wrote:
> 
> > Commit d60c49c (read-cache.c: allow unaligned mapping of the
> > index file, 2012-04-03) introduced helpers to access
> > unaligned data. Let's factor them out to make them more
> > widely available.
> >
> > While we're at it, we'll give the helpers more readable
> > names, add a helper for the "ntohll" form, and add the
> > appropriate Makefile knob.
> 
> Weird.  Why wasn't git broken on the relevant platforms before (given
> that no one has been setting NEEDS_ALIGNED_ACCESS for them)?

Because most of our data structures support aligned access. Thomas
mentioned this as a potential issue earlier, and I said in a re-roll
cover letter:

  I did not include the NEEDS_ALIGNED_ACCESS patch. I note that we do
  not even have a Makefile knob for this, and the code in read-cache.c
  has probably never actually been used. Are there real systems that
  have a problem? The read-cache code was in support of the index v4
  experiment, which did away with the 8-byte padding. So it could be
  that we simply don't see it, because everything is currently aligned.

I think it was a bug waiting to surface if index v4 ever got wide use.

-Peff
