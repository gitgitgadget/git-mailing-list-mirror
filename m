From: Jeff King <peff@peff.net>
Subject: Re: Idea: "git format-patch" should get more information out of git
Date: Tue, 30 Aug 2011 11:22:17 -0400
Message-ID: <20110830152217.GA13022@sigill.intra.peff.net>
References: <4E587CC0.4090508@alum.mit.edu>
 <7vippiaduw.fsf@alter.siamese.dyndns.org>
 <7v1uw69h96.fsf@alter.siamese.dyndns.org>
 <20110829185546.GD756@sigill.intra.peff.net>
 <4E5CD5B9.80306@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org,
	Johan Herland <johan@herland.net>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Aug 30 17:22:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QyQ8y-0004Yy-MJ
	for gcvg-git-2@lo.gmane.org; Tue, 30 Aug 2011 17:22:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755200Ab1H3PWX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Aug 2011 11:22:23 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:43308
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754998Ab1H3PWW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Aug 2011 11:22:22 -0400
Received: (qmail 26656 invoked by uid 107); 30 Aug 2011 15:23:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 30 Aug 2011 11:23:06 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 30 Aug 2011 11:22:17 -0400
Content-Disposition: inline
In-Reply-To: <4E5CD5B9.80306@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180411>

On Tue, Aug 30, 2011 at 02:21:13PM +0200, Michael J Gruber wrote:

> > After playing around a bit with my earlier series, I made the
> > realization (perhaps obvious to others :) ), that if you are in a
> > pure-patch workflow, keeping the "---" in your commit message locally is
> > much simpler. It follows the commit around through rebases
> > automatically, it gets put into format-patch output automatically, and
> > so forth.
> 
> I'm confused: Does format-patch keep it or strip it as you say above?

Format-patch will include the whole commit message, including "---" and
what comes after. But an "am" recipient will strip it out of the commit
message. IOW, you locally treat your "---" notes as part of the commit
message, but in a pure-patch workflow, upstream treats it as something
to be stripped out.

So there is asymmetry in what is in your commit versus what is in
upstream's commit. But that's OK, because how you treat the commit
(something to be tweaked and rebased, and then mailed out) and how
upstream treats it (something to go into the long-term project history)
are different.

But that breaks down if you ever want to share actual commit objects
with upstream.

> Anyways, notes survive rebase etc.

You still have to manually configure:

  git config notes.rewriteRef refs/notes/commits

Perhaps that is something that should be changed.

> and at format-patch time you can decide whether you want to include
> them or not (with my patch).

Yeah. Don't get me wrong, I think putting "---" notes into git-notes is
way more flexible. It's just that it's also more complex, and
unnecessarily so for many use cases.

We have some patches to hide that complexity, but I was at one point
wondering if all of the complexity was worthwhile. But as I mentioned
above, if you want to build anything more complex than a pure-patch
workflow, the simple solution breaks down. So it probably is worth
pursuing.

-Peff
