From: Jeff King <peff@peff.net>
Subject: Re: feature suggestion: optimize common parts for checkout
 --conflict=diff3
Date: Thu, 7 Mar 2013 13:50:46 -0500
Message-ID: <20130307185046.GA11622@sigill.intra.peff.net>
References: <CALWbr2xDYuCN4nd-UNxkAY8-EguYjHBYgfu1fLtOGhYZyRQg_A@mail.gmail.com>
 <20130306200347.GA20312@sigill.intra.peff.net>
 <7vvc94p8hb.fsf@alter.siamese.dyndns.org>
 <20130306205400.GA29604@sigill.intra.peff.net>
 <7vr4jsp756.fsf@alter.siamese.dyndns.org>
 <7vmwugp637.fsf@alter.siamese.dyndns.org>
 <20130307080411.GA25506@sigill.intra.peff.net>
 <7v1ubrnmtu.fsf@alter.siamese.dyndns.org>
 <20130307180157.GA6604@sigill.intra.peff.net>
 <7vfw07m4sx.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Antoine Pelisse <apelisse@gmail.com>,
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
	<u.kleine-koenig@pengutronix.de>, git <git@vger.kernel.org>,
	kernel@pengutronix.de
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 07 19:51:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UDfuS-0005Pv-4p
	for gcvg-git-2@plane.gmane.org; Thu, 07 Mar 2013 19:51:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932694Ab3CGSuv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Mar 2013 13:50:51 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:40238 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933237Ab3CGSus (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Mar 2013 13:50:48 -0500
Received: (qmail 8785 invoked by uid 107); 7 Mar 2013 18:52:26 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 07 Mar 2013 13:52:26 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 07 Mar 2013 13:50:46 -0500
Content-Disposition: inline
In-Reply-To: <7vfw07m4sx.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217611>

On Thu, Mar 07, 2013 at 10:40:46AM -0800, Junio C Hamano wrote:

> Where we differ is if such information loss is a good thing to have.
>
> We could say "both sides added, identically" is auto-resolved when
> you use the zealous option, and do so regardless of how the merge
> conflicts are presented.  Then it becomes perfectly fine to eject
> "A" and "E" out of the conflicted block and merge them to be part of
> pre/post contexts.  The same goes for reducing "<C|=C>" to "C".  As
> long as we clearly present the users what the option does and what
> its implications are, it is not bad to have such an option, I think.

Exactly. I do think it has real-world uses (see the example script I
posted yesterday), but it would never replace diff3. I'm going to try it
out for a bit. As I mentioned yesterday, I see those sorts of
cherry-pick-with-something-on-top conflicts when I am rebasing onto or
merging my topics into what you have picked up from the same topic on
the list.

I think the code in Uwe's patch looked fine, but it definitely needs a
documentation change to explain the new mode and its caveats. I'd also
be happy with a different name, if you think it implies that it is too
related to zdiff3, but I cannot think of anything better at the moment.

> > The wrong thing to me is the arbitrary choice about how to distribute
> > the preimage lines.
> 
> Yeah, but that is not "diff3 -m" vs "zealous-diff3" issue, is it?
> If you value the original and want to show it somewhere, you cannot
> avoid making the choice whether you are zealous or not if you split
> such a hunk.

Right, but I meant that we would never split a hunk like that with
diff3, because we would not do any hunk refinement at all.  Splitting a
hunk with "merge" is OK, because the "where does the preimage go"
problem does not exist there. zdiff3 is the only problematic case,
because it would be the only one that (potentially) splits and cares
about how the preimage maps to each hunk. But we can deal with that if
and when we ever do such splitting.

-Peff
