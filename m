From: Jeff King <peff@peff.net>
Subject: Re: feature suggestion: optimize common parts for checkout
 --conflict=diff3
Date: Wed, 6 Mar 2013 15:54:00 -0500
Message-ID: <20130306205400.GA29604@sigill.intra.peff.net>
References: <20130306150548.GC15375@pengutronix.de>
 <CALWbr2xDYuCN4nd-UNxkAY8-EguYjHBYgfu1fLtOGhYZyRQg_A@mail.gmail.com>
 <20130306200347.GA20312@sigill.intra.peff.net>
 <7vvc94p8hb.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Antoine Pelisse <apelisse@gmail.com>,
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
	<u.kleine-koenig@pengutronix.de>, git <git@vger.kernel.org>,
	kernel@pengutronix.de
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 06 21:54:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UDLM7-0001jD-KD
	for gcvg-git-2@plane.gmane.org; Wed, 06 Mar 2013 21:54:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755150Ab3CFUyE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Mar 2013 15:54:04 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:38372 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753547Ab3CFUyD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Mar 2013 15:54:03 -0500
Received: (qmail 29617 invoked by uid 107); 6 Mar 2013 20:55:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 06 Mar 2013 15:55:40 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 06 Mar 2013 15:54:00 -0500
Content-Disposition: inline
In-Reply-To: <7vvc94p8hb.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217544>

On Wed, Mar 06, 2013 at 12:40:48PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > then it will produce the output that Uwe expects. While it can be
> > misleading,...
> 
> Misleading is one thing but in this case isn't it outright wrong?
> 
> If you remove <<< ours ||| portion from the combined diff output,
> I would expect that the hunk will apply to the base, but that is no
> longer true, no?

It shifts the concept of what is the "base" and what is the "conflict".
In Uwe's example, no, it would not apply to the single-line file that is
the true 3-way base. But it would apply to the content that is outside
of the hunk marker; we have changed the concept of what is in the base
and what is in the conflict by shrinking the conflict to its smallest
size. The same is true of the conflict markers produced in the non-diff3
case. It is a property of XDL_MERGE_ZEALOUS, not of the conflict style.

If your argument is "diff3 means something different than regular
conflict markers; it should have the property of being
machine-convertible into a patch, but regular markers do not", I'm not
sure I agree. It may be used that way, but I think it is mostly used in
git to give the reader more context when making a resolution. And
anyway, I think the proposed change would not be to change diff3, but to
introduce a new diff3-like format that also shrinks the hunk size, so it
would not hurt existing users of diff3.

-Peff
