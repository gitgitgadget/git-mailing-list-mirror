From: Jeff King <peff@peff.net>
Subject: Re: Friendly refspecs (Was: Re: git annoyances)
Date: Wed, 9 Apr 2008 18:51:12 -0400
Message-ID: <20080409225112.GB12103@sigill.intra.peff.net>
References: <20080409101428.GA2637@elte.hu> <20080409145758.GB20874@sigill.intra.peff.net> <20080409200836.GA19248@mithlond> <20080409203453.GA10370@sigill.intra.peff.net> <20080409222500.GB19248@mithlond>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 10 00:52:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jjj95-0000VR-9c
	for gcvg-git-2@gmane.org; Thu, 10 Apr 2008 00:51:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753888AbYDIWvP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Apr 2008 18:51:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753155AbYDIWvP
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Apr 2008 18:51:15 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3272 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752439AbYDIWvO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Apr 2008 18:51:14 -0400
Received: (qmail 19022 invoked by uid 111); 9 Apr 2008 22:51:12 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Wed, 09 Apr 2008 18:51:12 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 09 Apr 2008 18:51:12 -0400
Content-Disposition: inline
In-Reply-To: <20080409222500.GB19248@mithlond>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79145>

On Thu, Apr 10, 2008 at 01:25:00AM +0300, Teemu Likonen wrote:

> Hmm, maybe. I recently wanted to join two purely local repos together.
> Both of them had just one branch. Totally different histories so no
> actual mergin would happen; just two branches in the same repo. I don't
> know why but "git fetch /the/other/repo/" just happened to be the one
> I tried first. I saw it fetched something but as no new branch appeared
> and I had never heard of this FETCH_HEAD thing it was a "didn't work,
> what should I try next?" thing. I think your idea of showing

Ah, OK. In that case, I think the right thing to do would not be to set
up a remote, but to fetch explicitly into a local branch. I assume when
you say "joining" you mean "so I can get rid of the individual ones".
So something like:

  cd repo1
  git fetch ../repo2 master:repo2-topic

which creates refs/heads/repo2 in repo1, and you can safely delete
repo2.

If you _did_ want to keep repo2 around indefinitely, and you are
"joining" so that you can do diffs, then you probably do want a remote
with tracking branches.

  cd repo1
  git remote add repo2 ../repo2
  git fetch repo2
  git diff repo2/master...master

> >   From git://host/path/to/repo
> >    * [new branch]      foo -> FETCH_HEAD
> 
> would be really good. At least to me this would have been enough
> information. As I'm starting to see the "point of doing fetch <URL>"
> I take back what I proposed. Just a bit more information would be nice.

I wonder if people like Linus who do a lot of one-off pulls would find
that too cluttery. I guess we can post a patch and see. ;)

> I have to agree with Ingo Molnar that sometimes Git is a bit un- or even
> disinformative about what happened. One example is this "git fetch
> <URL>". Maybe it's not a "sane thing to do" but users are like this. We
> just try something and learn from it. To me "git fetch <URL>" was
> a broken command (UI-wise) until I read your message (thanks again!). If
> Git had told me that it created FETCH_HEAD I had learned fetch's habits
> myself and likely wouldn't have come up with this "broken command"
> conclusion.

Sure. In my other message I talked about workflows not to imply "how
dare you explore the commands!" but rather to see where you were coming
from. I agree that a lot of git messages could be improved. So I think
the take-away lesson is not that there needs to be some huge change in
behavior or what input is accepted, but that git-fetch without tracking
branches should probably give a clue that it did _something_.

> Another thing I spoke of was this refs/ stuff. I know my way around with
> them now, so maybe they are not actually confusing to me anymore. It's
> just that I have noticed a pattern: I always use refs/heads/... in
> certain places and refs/remotes/ in certain places. If such a pattern is
> very common (well, I don't know if it is) one starts to think that maybe
> the pattern can/should be hidden and made part of the tool. Just
> thoughts.

I almost never use refs/remotes/ or refs/heads/. Some effort has been
put into doing the right thing with partial refnames (which you can of
course override by being more specific). Do you have specific examples
of where you use the full refname? I suspect it is either not required
(and documentation may be out of date), or it is a bug we could fix. :)

-Peff
