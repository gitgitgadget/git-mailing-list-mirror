From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 23/67] add_packed_git: convert strcpy into xsnprintf
Date: Wed, 16 Sep 2015 16:24:00 -0400
Message-ID: <20150916202400.GB3915@sigill.intra.peff.net>
References: <20150915152125.GA27504@sigill.intra.peff.net>
 <20150915154143.GW29753@sigill.intra.peff.net>
 <xmqq8u86qk62.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 16 22:24:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZcJFW-0005in-MU
	for gcvg-git-2@plane.gmane.org; Wed, 16 Sep 2015 22:24:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752252AbbIPUYK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Sep 2015 16:24:10 -0400
Received: from cloud.peff.net ([50.56.180.127]:60320 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752145AbbIPUYJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Sep 2015 16:24:09 -0400
Received: (qmail 24394 invoked by uid 102); 16 Sep 2015 20:24:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 16 Sep 2015 15:24:09 -0500
Received: (qmail 22952 invoked by uid 107); 16 Sep 2015 20:24:12 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 16 Sep 2015 16:24:12 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 16 Sep 2015 16:24:00 -0400
Content-Disposition: inline
In-Reply-To: <xmqq8u86qk62.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278061>

On Wed, Sep 16, 2015 at 11:43:49AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > +	alloc = path_len + strlen(".pack") + 1;
> > +	p = alloc_packed_git(alloc);
> > +	memcpy(p->pack_name, path, path_len); /* NUL from zero-ed struct */
> 
> This comment is confusing, isn't it?  Yes, there is a NUL, but you
> will going to overwrite it with "." in ".keep" immediately and more
> importantly, that overwriting does not depend on NUL being there.

Yeah, you're right. I was blindly making sure that the behavior did not
change from the original, without noticing that the original did not
care about the NUL either way.

> What's more important to comment on would probably be the line that
> computes the "alloc".  It uses ".pack" but that is because it knows
> that is the longest suffix we care about, and that deserves mention
> more than the NUL termination of intermediate result that does not
> matter, no?

Agreed. I'll add a comment to that effect.

-Peff
