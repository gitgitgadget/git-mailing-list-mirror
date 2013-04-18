From: Jeff King <peff@peff.net>
Subject: Re: What's cooking in git.git (Apr 2013, #05; Mon, 15)
Date: Thu, 18 Apr 2013 16:30:35 -0400
Message-ID: <20130418203035.GB24690@sigill.intra.peff.net>
References: <7vd2ttgoyr.fsf@alter.siamese.dyndns.org>
 <87wqs1xi9h.fsf@hexa.v.cablecom.net>
 <7vk3o1f5kb.fsf@alter.siamese.dyndns.org>
 <7vwqs1dnxp.fsf@alter.siamese.dyndns.org>
 <20130417201056.GA2914@sigill.intra.peff.net>
 <7va9owd3d1.fsf@alter.siamese.dyndns.org>
 <20130418172714.GA24690@sigill.intra.peff.net>
 <7vd2tr6833.fsf@alter.siamese.dyndns.org>
 <20130418180017.GA5714@sigill.intra.peff.net>
 <7v61zj66wu.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Thomas Rast <trast@inf.ethz.ch>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 18 22:30:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1USvTg-0007Qn-6s
	for gcvg-git-2@plane.gmane.org; Thu, 18 Apr 2013 22:30:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936549Ab3DRUak (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Apr 2013 16:30:40 -0400
Received: from cloud.peff.net ([50.56.180.127]:43514 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S936524Ab3DRUaj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Apr 2013 16:30:39 -0400
Received: (qmail 15716 invoked by uid 102); 18 Apr 2013 20:30:43 -0000
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (75.15.5.89)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 18 Apr 2013 15:30:43 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 18 Apr 2013 16:30:35 -0400
Content-Disposition: inline
In-Reply-To: <7v61zj66wu.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221692>

On Thu, Apr 18, 2013 at 11:16:33AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > could work for both cases. Something like "not considering" (or another
> > synonym for "considering") might be even more accurate. It is not just
> > that we did not stage it; it is what we did not even consider it an item
> > for staging under the current rules.
> 
> Yes, "not considering" is much more sensible, while side-stepping
> the dryrun issue.  Or
> 
>        warning("ignoring removal of '%s'")

I like that much better than either of my suggestions.

> > Note that the "not staging" warnings may potentially be interspersed
> > with the normal dry-run output. I think that's OK.
> 
> As long as the top-text makes it clear what "not considering" (or
> "ignoring") in the following text means, I think it is fine.

Agreed, and I think the current text is fine for that (though neither of
us is the best judge at this point of how a less familiar user would
interpret it).

> But I think we are doing users a disservice by listing tons of
> paths.  Where the difference of versions matters _most_ is when the
> user has tons of removed paths in the working tree.  Either with one
> warning per path, or a block of collected paths at the end, we are
> scrolling the more important part of the message up.

I'm not sure I agree. Even with a handful, it made me wonder why one was
mentioned and not others. That _could_ be cleared up by rewording (i.e.,
making it clear that this is an example, and there may be more). But
somehow listing them is what I would expect. Perhaps because it gives
the user a clue about what to do next; they ask themselves "did I want
those updated or not?".

In the orphaned-commit message when leaving a detached HEAD, we collect
the answer, say "you are leaving N commits", and show the first 5 five
of them, with an ellipsis at the end if we didn't show them all.  Would
it makes sense to do that here?

Yet another alternative would be to print a warning for each path, but
hold the main warning for the end, so that it is the first thing the
user sees.  That has the added bonus that regular "--dry-run" output
will not scroll it away, either.

-Peff
