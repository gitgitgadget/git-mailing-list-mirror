From: Jeff King <peff@peff.net>
Subject: Re: git rebase --skip
Date: Thu, 8 Nov 2007 22:22:29 -0500
Message-ID: <20071109032227.GA31760@sigill.intra.peff.net>
References: <20071107222105.GA31666@glandium.org> <20071108032308.GA5638@sigill.intra.peff.net> <20071108102412.GA31187@atjola.homenet> <4732E5A8.3020101@op5.se> <20071108104403.GB31187@atjola.homenet> <20071108231632.GC29840@sigill.intra.peff.net> <7vir4cz45z.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>,
	Andreas Ericsson <ae@op5.se>, Mike Hommey <mh@glandium.org>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 09 04:23:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqKSS-0000qg-I8
	for gcvg-git-2@gmane.org; Fri, 09 Nov 2007 04:23:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753475AbXKIDWp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Nov 2007 22:22:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752991AbXKIDWo
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Nov 2007 22:22:44 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1144 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751925AbXKIDWo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Nov 2007 22:22:44 -0500
Received: (qmail 20454 invoked by uid 111); 9 Nov 2007 03:22:36 -0000
Received: from c-24-125-35-113.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (24.125.35.113)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Thu, 08 Nov 2007 22:22:36 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 08 Nov 2007 22:22:29 -0500
Content-Disposition: inline
In-Reply-To: <7vir4cz45z.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64123>

On Thu, Nov 08, 2007 at 03:52:08PM -0800, Junio C Hamano wrote:

> The user is explicitly saying --skip, so I do not think it is
> dangerous even if we unconditionally did "reset --hard" at that
> point.

Sure, I think the complaint is not that "reset --hard" is the wrong
behavior, but that people are prone to type --skip in error. Right now
we handle that error in a data-preserving way (we complain, and the user
has to think and issue a "throw away this data" command), but automatic
reset is less safe (even though there are fewer times when somebody
meant to commit instead of just reset, the consequences are harder to
recover from).

I've never personally run into this, but I think it is a reasonable
thing to think about, and if it is easy to add an additional safety
valve (either stashing the index/wt state, or checking before automatic
"reset --hard" whether any work has been done towards resolving), then
we probably should.

So I am fine with the original patch (unconditional reset --hard), but
it would be nice to see the people who care submit concrete proposals
for such a safety valve.

> Or we could introduce a new option "--drop" (that's "drop the
> current commit and continue") to do so, if people find that the
> word "skip" does not sound like a scary destructive operation.

I don't think the problem is "users don't realize how scary --skip can
be", but rather "I use --skip to resolve this situation 99% of the time,
so in the other 1%, I soetimes use it accidentally."

-Peff
