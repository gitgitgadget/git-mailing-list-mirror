From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 2/3] push: introduce REJECT_FETCH_FIRST and
 REJECT_NEEDS_FORCE
Date: Thu, 24 Jan 2013 01:43:26 -0500
Message-ID: <20130124064326.GB610@sigill.intra.peff.net>
References: <20130121234002.GE17156@sigill.intra.peff.net>
 <1358836230-9197-1-git-send-email-gitster@pobox.com>
 <1358836230-9197-3-git-send-email-gitster@pobox.com>
 <20130123065640.GB10306@sigill.intra.peff.net>
 <7vip6nj22m.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Chris Rorvick <chris@rorvick.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 24 07:43:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TyGXS-0000Lw-64
	for gcvg-git-2@plane.gmane.org; Thu, 24 Jan 2013 07:43:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751282Ab3AXGnd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jan 2013 01:43:33 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:45777 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750819Ab3AXGnc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jan 2013 01:43:32 -0500
Received: (qmail 12152 invoked by uid 107); 24 Jan 2013 06:44:49 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 24 Jan 2013 01:44:49 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 24 Jan 2013 01:43:26 -0500
Content-Disposition: inline
In-Reply-To: <7vip6nj22m.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214397>

On Wed, Jan 23, 2013 at 08:28:49AM -0800, Junio C Hamano wrote:

> How about doing this?
> 
> For "needs force" cases, we say this instead:
> 
>  hint: you cannot update a ref that points at a non-commit object, or
>  hint: update a ref to point at a non-commit object, without --force.
> 
> Being explicit about "non-commit" twice will catch user's eyes and
> cause him to double check that it is not a mistyped LHS of the push
> refspec (if he is sending a non-commit) or mistyped RHS (if the ref
> is pointing at a non-commit).  If he _is_ trying to push a blob out,
> the advice makes it clear what to do next: he does want to force it.

Yeah, I think that is sensible.

> Note that you _could_ split the "needs force" case into two, namely,
> "cannot replace a non-commit" and "cannot push a non-commit".  You
> could even further split them [...etc...]

I do not think it is worth worrying too much about. This should really
not happen very often, and the user should be able to investigate and
figure out what is going on. I think making the error message extremely
specific is just going to end up making it harder to understand.

> If we did that, then we could loosen the "You should fetch first"
> case to say something like this:
> 
>  hint: you do not have the object at the tip of the remote ref;
>  hint: perhaps you want to pull from there first?

Yeah, better. I'll comment on the specific message you used in response
to the patch itself.

> This explicitly denies one of Chris's wish "we shouldn't suggest to
> merge something that we may not be able to", but in the "You should
> fetch first" case, we cannot fundamentally know if we can merge
> until we fetch.  I agree with you that the most common case is that
> the unknown object is a commit, and that suggesting to pull is a
> good compromise.

I thought the wish was more about "we shouldn't suggest to merge
something we _know_ we will not be able to", and you are still handling
that (i.e., the "needs force" case).

-Peff
