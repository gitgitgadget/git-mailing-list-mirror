From: Jeff King <peff@peff.net>
Subject: Re: Listing commits that are _exclusively_ available on a given
 branch
Date: Fri, 23 Mar 2012 13:50:07 -0400
Message-ID: <20120323175007.GA13410@sigill.intra.peff.net>
References: <CALKQrge-=XExhwxuC14uynpuuO3W+f4YO4=X7kFUx33F3HtnyQ@mail.gmail.com>
 <20120323170640.GA12881@sigill.intra.peff.net>
 <7vaa37usiv.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johan Herland <johan@herland.net>,
	Git mailing list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 23 18:50:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SB8cz-00066d-NG
	for gcvg-git-2@plane.gmane.org; Fri, 23 Mar 2012 18:50:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757736Ab2CWRuL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Mar 2012 13:50:11 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:57602
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755685Ab2CWRuK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Mar 2012 13:50:10 -0400
Received: (qmail 16921 invoked by uid 107); 23 Mar 2012 17:50:26 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 23 Mar 2012 13:50:26 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 23 Mar 2012 13:50:07 -0400
Content-Disposition: inline
In-Reply-To: <7vaa37usiv.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193782>

On Fri, Mar 23, 2012 at 10:38:32AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > No, I think that is the only way to do it. The algorithm run by rev-list
> > in that case should be optimal, so there is nothing to improve there.
> > Syntactically, it's a little bit of a pain because there is no way to
> > tell rev-list "--all, except for this one branch" short of using grep.
> > We could add a new syntax for that, but I'm not sure what it would look
> > like (or if it would be any easier on the eyes than what you have).
> 
> We discussed --exclude-refs="refs/tags/expermental-*" that would affect
> how --all, --heads, and friends are processed several weeks ago, didn't
> we?

Gmane seems to be down at the moment, but I think the thread you are
talking about can be found here:

  http://mid.gmane.org/7v4nuvghfk.fsf@alter.siamese.dyndns.org
  http://mid.gmane.org/4F391F5C.1000400@alum.mit.edu
  http://mid.gmane.org/7vaa4meat5.fsf@alter.siamese.dyndns.org

It talks about excluding from the positive side, like:

  git rev-list --all --exclude-ref=refs/heads/foo

That can also be extended to the negative side, like:

  git rev-list refs/heads/foo --not --all --exclude-ref=refs/heads/foo

though it is slightly confusing to read due to the double negation (you
are "--not" "--exclude"-ing the ref). However, I think the double
negation is necessary (i.e., you could not say "--include-ref"), because
the two negations are talking about two different things (one is about
limiting the list of items fed to the graph traversal, and the other is
about limiting the graph traversal itself).

So yeah, I think that would work. But AFAIK, there has been no other
activity on that topic.

-Peff
