From: Jeff King <peff@peff.net>
Subject: Re: Bug: "git checkout -b" should be allowed in empty repo
Date: Mon, 6 Feb 2012 00:45:58 -0500
Message-ID: <20120206054558.GA7883@sigill.intra.peff.net>
References: <7vwr8bvvxj.fsf@alter.siamese.dyndns.org>
 <4F263AEE.4080409@alum.mit.edu>
 <7v39axc9gp.fsf@alter.siamese.dyndns.org>
 <7vaa55ar4v.fsf@alter.siamese.dyndns.org>
 <20120130215043.GB16149@sigill.intra.peff.net>
 <7vobtcbtqa.fsf@alter.siamese.dyndns.org>
 <20120206043012.GD29365@sigill.intra.peff.net>
 <7vty34a6fd.fsf@alter.siamese.dyndns.org>
 <20120206051834.GA5062@sigill.intra.peff.net>
 <7vk440a5qw.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 06 06:46:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RuHOw-0003OI-Qn
	for gcvg-git-2@plane.gmane.org; Mon, 06 Feb 2012 06:46:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752183Ab2BFFqB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Feb 2012 00:46:01 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:58581
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751930Ab2BFFqB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Feb 2012 00:46:01 -0500
Received: (qmail 23569 invoked by uid 107); 6 Feb 2012 05:53:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 06 Feb 2012 00:53:07 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 06 Feb 2012 00:45:58 -0500
Content-Disposition: inline
In-Reply-To: <7vk440a5qw.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190022>

On Sun, Feb 05, 2012 at 09:30:15PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Sure, that's one way to do it. But I don't see any point in not allowing
> > "git checkout -b" to be another way of doing it. Is there some other use
> > case for "git checkout -b" from an unborn branch? Or is there some
> > harmful outcome that can come from doing so that we need to be
> > protecting against? Am I missing something?
> 
> Mostly because it is wrong at the conceptual level to do so.
> 
> 	git checkout -b foo
> 
> is a short-hand for
> 
> 	git checkout -b foo HEAD
> 
> which is a short-hand for
> 
> 	git branch foo HEAD &&
>         git checkout foo
> 
> But the last one has no chance of working if you think about it, because
> "git branch foo $start" is a way to start a branch at $start and you need
> to have something to point at with refs/heads/foo.
> 
> So we are breaking the equivalence between these three only when HEAD
> points at an unborn branch.

I think it is only wrong at the conceptual level because you have
specified the concepts in such a way that it is so. That is how git does
it _now_, but the whole point of this is to change git's behavior to
handle a potentially useful special case. I could also say this: "git
checkout -b foo HEAD" does two things:

  1. create a new branch "foo" pointing to the current sha1 of HEAD

  2. point the HEAD symref at refs/heads/foo

And then the proposed behavior might amend the first point to say:

  1. if HEAD points to an existing ref, then create a new branch...

which is perfectly consistent and simple. It does violate your "X is a
short-hand for Y" above, but why is that a bad thing? It seems you are
arguing against a special case _because_ it is a special case, not
because it is not a reasonable thing to do or expect.

Anyway. I am still not convinced that this is even a useful thing to
want to do, so I am certainly not volunteering to write such a patch. So
perhaps there is no point arguing about it.

-Peff
