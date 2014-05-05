From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/3] Revert "make error()'s constant return value more
 visible"
Date: Mon, 5 May 2014 17:29:39 -0400
Message-ID: <20140505212938.GA16715@sigill.intra.peff.net>
References: <1399183975-2346-1-git-send-email-felipe.contreras@gmail.com>
 <1399183975-2346-2-git-send-email-felipe.contreras@gmail.com>
 <20140505054901.GA19331@sigill.intra.peff.net>
 <5367257a857ce_2db613a731043@nysa.notmuch>
 <20140505060202.GA27360@sigill.intra.peff.net>
 <53672c53f2ed9_2e86acd30c6e@nysa.notmuch>
 <20140505062931.GA9311@sigill.intra.peff.net>
 <53673e0499ebe_78fd70f2ecb5@nysa.notmuch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 06 18:28:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WhiAE-0007Xo-Qd
	for gcvg-git-2@plane.gmane.org; Tue, 06 May 2014 18:24:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756757AbaEEV3m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 May 2014 17:29:42 -0400
Received: from cloud.peff.net ([50.56.180.127]:45543 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756324AbaEEV3l (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 May 2014 17:29:41 -0400
Received: (qmail 7028 invoked by uid 102); 5 May 2014 21:29:40 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 05 May 2014 16:29:40 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 05 May 2014 17:29:39 -0400
Content-Disposition: inline
In-Reply-To: <53673e0499ebe_78fd70f2ecb5@nysa.notmuch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248137>

On Mon, May 05, 2014 at 02:30:12AM -0500, Felipe Contreras wrote:

> If we have a) code that fixes a couple warnings with -O3 but introduces
> hundreds with -O2, vs. b) code that has only a comple warnings with -O3,
> I'd go for b) any day.

I agree. But my point was to ask whether we can fix both.

> Yes, I see the problem now with -O3. And yes, I looked at the patch you
> sent. I haven't tested it but I bet it would sove both problems.

Unfortunately, it does not work in all cases (and I obviously did
something wrong when testing it last night). I should have taken my own
advice and re-read the commit message for e208f9c more carefully, which
says:

    If we can make the compiler aware that error() will always
    return -1, it can do a better job of analysis. The simplest
    method would be to inline the error() function. However,
    this doesn't work, because gcc will not inline a variadc
    function. We can work around this by defining a macro.[...]

I cannot think of any other way to make the compiler aware of the
constant value, but perhaps somebody else is more clever than I am.
Another alternative is to write out "return error(...)" as "error(...);
return -1". In some ways that is more readable, though it is more
verbose (and would cause quite a bit of code churn).

So applying your patches may be the least-bad solution.

-Peff
