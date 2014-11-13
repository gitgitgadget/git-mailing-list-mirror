From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] approxidate: allow ISO-like dates far in the future
Date: Thu, 13 Nov 2014 16:36:48 -0500
Message-ID: <20141113213647.GB7563@peff.net>
References: <20141113110325.GD8329@peff.net>
 <20141113110722.GB4386@peff.net>
 <xmqqr3x6ztyl.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Colin Smith <colin.webdev@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 13 22:36:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xp24Y-0005dX-BK
	for gcvg-git-2@plane.gmane.org; Thu, 13 Nov 2014 22:36:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934612AbaKMVgv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Nov 2014 16:36:51 -0500
Received: from cloud.peff.net ([50.56.180.127]:40123 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S934233AbaKMVgu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Nov 2014 16:36:50 -0500
Received: (qmail 17399 invoked by uid 102); 13 Nov 2014 21:36:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 13 Nov 2014 15:36:49 -0600
Received: (qmail 32014 invoked by uid 107); 13 Nov 2014 21:37:00 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 13 Nov 2014 16:37:00 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 13 Nov 2014 16:36:48 -0500
Content-Disposition: inline
In-Reply-To: <xmqqr3x6ztyl.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 13, 2014 at 01:11:46PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> >  		if (c != '.' &&
> > -		    is_date(num3, num, num2, refuse_future, now, tm))
> > +		    is_date(num3, num, num2, refuse_future, now, tm, 0))
> >  			break;
> 
> Doesn't the new argument '0', which is "allow-future", look somewhat
> strange when we are already passing refuse_future?

To be honest, I had trouble figuring out what the name "refuse_future"
really meant. We do skip the future check, but it also means that
is_date will munge the "struct tm" directly, even if we do not find a
valid date. That worried me a bit.

But yeah, in theory, the callers I wanted to tweak can just pass in a
NULL refuse_future.

-Peff
