From: Jeff King <peff@peff.net>
Subject: Re: [PATCH RFC 1/6] send-email: Add --delay for separating emails
Date: Tue, 7 Apr 2009 17:51:43 -0400
Message-ID: <20090407215143.GA18144@coredump.intra.peff.net>
References: <1239139522-24118-1-git-send-email-mfwitten@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Michael Witten <mfwitten@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 07 23:53:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LrJEN-0002Cf-AI
	for gcvg-git-2@gmane.org; Tue, 07 Apr 2009 23:53:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753121AbZDGVvr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Apr 2009 17:51:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752356AbZDGVvr
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Apr 2009 17:51:47 -0400
Received: from peff.net ([208.65.91.99]:49442 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752138AbZDGVvq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Apr 2009 17:51:46 -0400
Received: (qmail 9717 invoked by uid 107); 7 Apr 2009 21:51:45 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 07 Apr 2009 17:51:45 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 07 Apr 2009 17:51:43 -0400
Content-Disposition: inline
In-Reply-To: <1239139522-24118-1-git-send-email-mfwitten@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115998>

On Tue, Apr 07, 2009 at 04:25:17PM -0500, Michael Witten wrote:

> When sending a patch series, the emails often arrive at the final
> destination out of order; though these emails should be chained
> via the In-Reply-To headers, some mail-viewing systems display
> by order of arrival instead.
> 
> The --delay option provides a means for specifying that there
> should be a certain number of seconds of delay between sending
> emails, so that the arrival order can be controlled better.
> 
> Signed-off-by: Michael Witten <mfwitten@gmail.com>

I'm a little dubious how well this works in practice. Have you done any
experiments?

The reason I am dubious is that you are presumably delaying only a few
seconds (since anything more would be quite annoying to the user). This
may deal with a short race condition in your local mail server. But what
is the real cause of out-of-order delivery? Is it the local mail server
seeing two messages essentially "simultaneously" and then reordering
them randomly? Or is it other random delays that happen _after_ that,
like network congestion, DNS lookups, down or congested servers, time it
takes to deliver the actual message body (e.g., if your mail server
sends two simultaneously, but the first one is much larger and takes
longer to complete), etc.

Those delays can be much larger than a few seconds, and this won't help
at all there.

I think it may still be reasonable to implement a solution that only
covers some of the cases, but I what I am asking is if we know what
percentage of the cases that is. If we are preventing only 1% of
out-of-order deliveries with this, I question whether it is worth the
bother.

-Peff
