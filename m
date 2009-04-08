From: Jeff King <peff@peff.net>
Subject: Re: [PATCH RFC 1/6] Re: send-email: Add --delay for separating
	emails
Date: Wed, 8 Apr 2009 02:03:50 -0400
Message-ID: <20090408060350.GA26079@coredump.intra.peff.net>
References: <1239139522-24118-1-git-send-email-mfwitten@gmail.com> <20090407215143.GA18144@coredump.intra.peff.net> <20090407220854.GA12908@vidovic>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Witten <mfwitten@gmail.com>, git@vger.kernel.org
To: Nicolas Sebrecht <nicolas.s-dev@laposte.net>
X-From: git-owner@vger.kernel.org Wed Apr 08 08:06:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LrQuh-0006Od-N6
	for gcvg-git-2@gmane.org; Wed, 08 Apr 2009 08:05:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761728AbZDHGDz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Apr 2009 02:03:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761111AbZDHGDz
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Apr 2009 02:03:55 -0400
Received: from peff.net ([208.65.91.99]:60830 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759800AbZDHGDy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Apr 2009 02:03:54 -0400
Received: (qmail 14137 invoked by uid 107); 8 Apr 2009 06:03:53 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 08 Apr 2009 02:03:53 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 08 Apr 2009 02:03:50 -0400
Content-Disposition: inline
In-Reply-To: <20090407220854.GA12908@vidovic>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116039>

On Wed, Apr 08, 2009 at 12:08:54AM +0200, Nicolas Sebrecht wrote:

> > I think it may still be reasonable to implement a solution that only
> > covers some of the cases, but I what I am asking is if we know what
> > percentage of the cases that is. If we are preventing only 1% of
> > out-of-order deliveries with this, I question whether it is worth the
> > bother.
> 
> IMHO, this improvement is broken by design. We try to fix a
> receiver-only issue by a sender side fix.

I almost said the same thing: it is really the receiver's problem.
However, that doesn't mean the sender can't do simple things to help
hint the right thing to the receiver. For example, we already munge the
date fields to make sure the timestamp in each patch is increasing.

So there is precedent for giving hints to help the receiver sort the
patches. But munging the date fields is relatively transparent to the
sener. A multi-second delay is downright annoying. As a sender, I don't
think I would enable this option.

> If the receiver wants the patch series be in a good ordered _for sure_, he
> has to switch to a client mail supporting the In-Reply-To chains.

That's not enough for shallow-style patch series, like:

  PATCH 0/3
    \->PATCH 1/3
    \->PATCH 2/3
    \->PATCH 3/3

which is the proposed default for v1.6.3.

Many readers will sort by rfc822 date within a single thread level,
which is sufficient with what send-email currently generates. Sorting by
subject should also work fine.

But apparently many readers sort by date received. See this subthread:

  http://article.gmane.org/gmane.comp.version-control.git/110097

I am generally of the opinion that if it is a big problem for people,
they should get a better mail client. But I am also open to suggestions
for helping receivers on crappy mail clients as long as those
suggestions do not put a burden on the sender.

-Peff
