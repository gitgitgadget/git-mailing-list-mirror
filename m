From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] push: --follow-tag
Date: Tue, 5 Mar 2013 14:27:52 -0500
Message-ID: <20130305192752.GA13335@sigill.intra.peff.net>
References: <7vd2vewu24.fsf@alter.siamese.dyndns.org>
 <7v6216wtrk.fsf@alter.siamese.dyndns.org>
 <20130305082204.GB13552@sigill.intra.peff.net>
 <5135DBE5.6080909@alum.mit.edu>
 <20130305182255.GB10928@sigill.intra.peff.net>
 <7v6215u05k.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 05 20:28:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UCxXB-00051A-Kn
	for gcvg-git-2@plane.gmane.org; Tue, 05 Mar 2013 20:28:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757578Ab3CET1z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Mar 2013 14:27:55 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:35511 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756868Ab3CET1z (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Mar 2013 14:27:55 -0500
Received: (qmail 17501 invoked by uid 107); 5 Mar 2013 19:29:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 05 Mar 2013 14:29:32 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 05 Mar 2013 14:27:52 -0500
Content-Disposition: inline
In-Reply-To: <7v6215u05k.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217476>

On Tue, Mar 05, 2013 at 11:17:11AM -0800, Junio C Hamano wrote:

> I may have tentatively tagged the tip of 'master' as v1.8.2 in my
> private repository, started the integration testing, but may not be
> confident enough to push out the branch nor the tag yet.  I may have
> an experimental topic that I want to share with others before I am
> done with the release to unblock them, and the topic may build on
> the 'master' I may or may not want to redo before the release.
> 
> I can do so with "git push github jc/topic" (no --follow-tags).
> After doing such a "you may want to start with this" push, I can
> continue working on the release, and the 'master' branch may turn
> out to be good to go without redoing.
> 
> A later "git push github --follow-tags master" in such a case should
> send v1.8.2 out.  It is inexcuable to break it, saying "Oh, I've
> seen that commit already---it is part of the previous update to
> jc/topic".  That defeats the whole point of --follow-tags.

That depends on the specifics of the rule. If the rule is "any commit
that the server already has", then yes, it runs afoul of that problem.
But what if it is "any commit in the ref update being sent"? That is, we
would look at the range "origin/master..master" and send any tags that
point to commits in that range.

> The other "tags at the tip" is slightly less problematic than
> "ignore the commits the receiving end has already seen", but it will
> break if I tag the tip of 'maint' as v1.8.1.6, continue working
> without being able to push perhaps due to network disruption, and
> have already started building towards v1.8.1.7 when the network
> comes back.  'maint' may be past v1.8.1.6 and its tip won't be
> pointing at that tag, but it still is missing from the public
> repository.

Right, I think "tags at the tip" is too likely to miss things you did
want to send.

> While I agree with your goal to make it safer to use "push", both
> "ignore commits that the receiving end already saw" and "only look
> at the commits at the tip being sent" castrate the option too much
> to the point that it is meaningless.  The whole point of asking
> explicitly with the "--follow-tags" option to "push" to push out
> relevant tags is, eh, to push out relevant tags.  I do not think it
> is magical at all.  "backfill" is an integral part of the option.

I know, and I'm willing to accept that the right resolution is "we
should not have this feature" (or possibly "the documentation must warn
about caveats of the feature). I'm just worried about it accidentally
being misused and causing problems.

-Peff
