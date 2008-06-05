From: Jeff King <peff@peff.net>
Subject: Re: [RFC PATCH] git-add--interactive: manual hunk editing mode v2
Date: Thu, 5 Jun 2008 04:56:06 -0400
Message-ID: <20080605085605.GA16624@sigill.intra.peff.net>
References: <200805232221.45406.trast@student.ethz.ch> <200805291737.53291.trast@student.ethz.ch> <20080529185808.GA2140@sigill.intra.peff.net> <200806010241.51464.trast@student.ethz.ch> <20080605014618.GA27381@sigill.intra.peff.net> <7vprqw2t64.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 05 10:57:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4BHL-0005sW-RV
	for gcvg-git-2@gmane.org; Thu, 05 Jun 2008 10:57:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752875AbYFEI4L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Jun 2008 04:56:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752755AbYFEI4L
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Jun 2008 04:56:11 -0400
Received: from peff.net ([208.65.91.99]:2462 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752488AbYFEI4K (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jun 2008 04:56:10 -0400
Received: (qmail 18740 invoked by uid 111); 5 Jun 2008 08:56:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Thu, 05 Jun 2008 04:56:08 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 05 Jun 2008 04:56:06 -0400
Content-Disposition: inline
In-Reply-To: <7vprqw2t64.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83883>

On Thu, Jun 05, 2008 at 01:16:19AM -0700, Junio C Hamano wrote:

> > So perhaps manual hunk editing is simply something for advanced users
> > who are comfortable with the patch format.
> 
> Exactly.  To them, "git diff >patch && vi patch && git apply --cached <patch"
> would likely to be much handier, quicker and a more familiar way. That is
> one of the reasons I somewhat doubt that we would want to have this patch.

I'm not so sure. I think this patch buys you two things:

 1. It munges the hunk headers as appropriate.

 2. It fits more naturally into the "git add -p" workflow. That is, I
    don't start by saying "I need to edit this patch." Instead, I am
    staging bits of changes, and looking at a hunk I say "Oh, this needs
    to be tweaked"; this patch provides an easy route from looking at
    the hunk to editing the hunk.

    Granted, 99% of the time my tweak is "these adjacent lines are
    actually unrelated, so split them into two hunks." So maybe that is
    an argument for something like Thomas' original patch.

> For the rest of your comments, I agree with the Perl style (use of map and
> grep instead of repeated push in loops).  The end user input, what the
> code needs to parse and accept, can screw you up royally and your parsing
> needs to be careful, and the code looks fragile.

I think there are two extremes here:

 1. We provide a very limited interface. E.g., you pick a line to
    arbitrarily split the hunk.

 2. We provide a very flexible interface. You get dumped in your editor
    with the hunk text, and we try to apply the result. Powerful, but
    easy to shoot yourself in the foot.

And there is probably room for both. But I think it is important not to
fall into the middle, where we have a hard-to-use but featureless
interface. That is, if we dump the user in an editor, doing anything
besides (2) doesn't make sense; trying to infer what happened in the
user's editing session is a waste of time.

So I think we need to be not so much careful in parsing, as accepting.
Or we need to dump the idea of letting the user make arbitrary edits.

-Peff
