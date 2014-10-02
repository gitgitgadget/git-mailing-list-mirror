From: Jeff King <peff@peff.net>
Subject: Re: [PATCH/RFC 0/5] add "unset.variable" for unsetting previously
 set variables
Date: Thu, 2 Oct 2014 16:41:07 -0400
Message-ID: <20141002204106.GA4556@peff.net>
References: <1412256292-4286-1-git-send-email-tanayabh@gmail.com>
 <xmqq1tqqnud1.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Tanay Abhra <tanayabh@gmail.com>, git@vger.kernel.org,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 02 22:41:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XZnBf-0000ka-3q
	for gcvg-git-2@plane.gmane.org; Thu, 02 Oct 2014 22:41:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751676AbaJBUlK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Oct 2014 16:41:10 -0400
Received: from cloud.peff.net ([50.56.180.127]:54507 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751192AbaJBUlJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Oct 2014 16:41:09 -0400
Received: (qmail 7327 invoked by uid 102); 2 Oct 2014 20:41:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 02 Oct 2014 15:41:09 -0500
Received: (qmail 7902 invoked by uid 107); 2 Oct 2014 20:41:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 02 Oct 2014 16:41:08 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 02 Oct 2014 16:41:07 -0400
Content-Disposition: inline
In-Reply-To: <xmqq1tqqnud1.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257825>

On Thu, Oct 02, 2014 at 12:29:14PM -0700, Junio C Hamano wrote:

> Tanay Abhra <tanayabh@gmail.com> writes:
> 
> (just this point quick)
> 
> > 1> The name of the variable, I could not decide between "unset.variable"
> > and "config.unset", or may be some other name would be more appropriate.
> 
> I'd prefer to see this as [config] something.
> 
> I wish we did the include as "[config] include = path/to/filename",
> not as "[include] path = path/to/filename".  Perhaps we can deprecate
> and move it over time?

I chose [include] because I had intended there to be multiple include
variables (include.path, include.ref, etc). The others were shot down
for now. If we put it under [config], I'd still prefer to leave room by
calling it:

  [config]
  includePath = path/to/filename

I also wanted [include] as a section name to leave room for
conditional includes. We've sometimes discussed things like:

  [include "has-some-git-feature"]
  path = ...

to allow conditional inclusion only when git supports a certain
feature-set (so that your config doesn't cause git to blow up when you
use an old version of git). It's possible that I'm the only person in
the world who really wants that, because I run old git versions all the
time for testing and debugging. And it is kind of gross as a syntax. But
it would still be nice to leave room for it.

I don't think there's a reason we couldn't allow:

  [config "condition..."]
  includePath = ...

in the same way if we wanted to (though aside from includes, I do not
know of any other feature that would want the condition).

So I'm not _opposed_ to adding [config], deprecating [include], and
waiting a bit before dropping [include]. But I also don't really see the
current name as a particularly bad thing.

-Peff
