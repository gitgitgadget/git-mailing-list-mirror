From: Jeff King <peff@peff.net>
Subject: Re: Git commit generation numbers
Date: Fri, 15 Jul 2011 17:54:16 -0400
Message-ID: <20110715215416.GB2117@sigill.intra.peff.net>
References: <20110714190844.GA26918@sigill.intra.peff.net>
 <CA+55aFx=ACnVBGU8_9wa=9xTbxVoOWKnsqfmBvzq7qzOeMGSNA@mail.gmail.com>
 <20110714200144.GE26918@sigill.intra.peff.net>
 <69e0ad24-32b7-4e14-9492-6d0c3d653adf@email.android.com>
 <20110714203141.GA28548@sigill.intra.peff.net>
 <CA+55aFyDzr+SfgSzWMr9pQuQUXTw9mcjZ-00NZof74PKZzbGPA@mail.gmail.com>
 <20110715074656.GA31301@sigill.intra.peff.net>
 <CA+55aFzS3KDNvKt-dXvYpuAQwFwD3+GCj8y8bRQCycPvrynT8Q@mail.gmail.com>
 <20110715194807.GA356@sigill.intra.peff.net>
 <CA+55aFx0KyAZRsy7gZ3Z4woWC-uWcLu11gcUrR+9MJR5NOSkrA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Jul 15 23:54:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QhqL3-0005bJ-Pt
	for gcvg-git-2@lo.gmane.org; Fri, 15 Jul 2011 23:54:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751077Ab1GOVyU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jul 2011 17:54:20 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:59321
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750765Ab1GOVyT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jul 2011 17:54:19 -0400
Received: (qmail 27506 invoked by uid 107); 15 Jul 2011 21:54:44 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 15 Jul 2011 17:54:44 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 15 Jul 2011 17:54:16 -0400
Content-Disposition: inline
In-Reply-To: <CA+55aFx0KyAZRsy7gZ3Z4woWC-uWcLu11gcUrR+9MJR5NOSkrA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177238>

On Fri, Jul 15, 2011 at 02:17:26PM -0700, Linus Torvalds wrote:

> > Having the information in two different places is my concern, too. And I
> > think the fundamental difference between putting it inside or outside
> > the commit sha1 (where outside encompasses putting it in a cache, in the
> > pack-index, or whatever), is that I see the commit sha1 as somehow more
> > "definitive". That is, it is the sole data we pass from repo to repo
> > during pushes and pulls, and it is the thing that is consistency-checked
> > by hashes.
> 
> Sure. That is also the data that is the same for everybody.
> 
> That's a big deal, in the sense that it's the only thing we should
> rely on if we want consistent behavior. Immediately if core
> functionality starts using any other data, behavior becomes "local".
> And I think that's really *really* dangerous.

Yes, I see your argument. I just don't think it's all that big a deal,
because the information is so easily derived from data that _is_ the
same for everybody (and when you _do_ want it to be different locally,
because you are grafting, that is easy to do).

But I think at this point we have both said all there is to say. There
is no actual data to be brought forth in this argument, and we obviously
disagree on this point. So I think we may have to agree to disagree.

And as I said before, I am willing to concede generation numbers in the
commit header. But we need the rest of the solution, too.

> So I really don't see why you harp on that. If the generation counters
> are in the objects THEY BY DEFINITION CANNOT BE INCONSISTENT.
> 
> That's a big issue.
> 
> Sure, they may be LYING, but that's a different thing entirely. They
> will be lying to everybody consistently. There would never be any
> question about what the generation number of a commit is.
>
> See what I'm trying to say? There's no way that they would cause
> different behavior for different people. Everything is 100%
> consistent.

Read my email again. I am clearly talking about inconsistency between
two data items in the sha1-checked DAG itself. You then proceed to yell
at me that they are not inconsistent, now talking about inconsistency
between different people with the same DAG, but different caches. In
other words, you are talking about an entirely different type of
inconsistency. And then you proceed to say that the generation numbers
may be lying, which is _exactly_ what I meant when I said inconsistency.

I don't mind arguing with you, even if I think you use capital letters
too frequently; but when you do use them, please take care that I really
am being a bonehead, and it is not you misrepresenting what I said.

As to lying (aka inconsistency between items within the DAG), you say:

> And btw, having "incorrect" data in the git objects is not the end of
> the world. You can generate merge commits that simply have the wrong
> parents. That will be confusing as hell to the user, and it will make
> future merges not work very well, but it's a bug in the archive, and
> that's "ok". The developers may not be very happy about it. In fact,
> afaik we've had a few cases like that in the kernel tree, because
> early git had bugs where it would not properly forget parents after a
> failed merge. Most of them are ARM-related, because the ARM tree was
> one of the first users of git (outside of me, but I had fewer issues
> with what happens when things go wrong).

No, it's not the end of the world. I just think it's worse than the
possibility of inconsistency between two users' idea of the graph,
because the bug stays with you for all of history, instead of getting
fixed with a new version of git.

> That said, I'm not 100% sure at all that we want generation numbers at
> all. Their use is pretty limited. If we had had them from the
> beginning, I think we would simply have replaced the date-based commit
> list sorting with a generation-number-based one, and it should have
> been possible to guarantee that we never output a parent before the
> commit in rev-parse.
> 
> As it is, I have to admit that looking at it, I shudder at changing
> the current date-based logic and replacing it with a "date or
> generation number".
> 
> The date-based one, despite all its fuzziness and not being very well
> defined ("Global clock in a distributed system? You're a moron") and
> up being a *nice* heuristic for certain human interaction. So it's not
> a wonderful solution from a technical standpoint, but it does have (I
> think) some nice UI advantages.

That is the conclusion I am coming to, also. I don't find the external
cache as odious as you obviously do. But that was why I posted the
patches with an RFC tag. I wanted to see how painful people found the
concept. But if it's too ugly a concept, I think the path of least
resistance is just making timestamps suck less (by using more consistent
and robust skew avoidance[1] in our various algorithms, and by perhaps
taking more care to notify the user of skew early, before commits are
published).

And then we don't really need generation numbers anymore.  As elegant as
they might have been if they were there from day one, it's just not
worth the hassle of maintaining the dual solution.

[1] We use "N slop commits" in some places and "allow 86400 seconds of
    skew" in other places. We should probably use both, and apply them
    consistently.

> > Those are serious questions that I think should be considered if we are
> > going to put a generation header into the commit object, and I haven't
> > seen answers for them yet.
> 
> I do agree that the really *big* question is "do we even need it at
> all". I do like perhaps just tightening the commit timestamp rules.
> Because I do think they would probably work very well for the
> "contains" problem too.
> 
> With the exact same fuzzy downsides, of course. Timestamps aren't
> perfect, and they need that annoying fuzz factor thing.

Yeah. But in practice, that fuzz is really easy to implement, has worked
pretty well so far, and doesn't actually hurt performance measurably,
because skew is rare, and a constant, small timestamp tends to equate to
a constant, small number of commits.

> > Sure, I would be fine with that. When you say "packfile", do you mean
> > the the general concept, as in it could go in the pack index as opposed
> > to the packfile itself? Or specifically in the packfile? The latter
> > seems a lot more problematic to me in terms of implementation.
> 
> I was thinking the "general" issue - it might make most sense to put
> them in the index.

If we were to go the cache route, I think I am leaning that way, too, if
only because we don't duplicate the 20-byte sha1 per commit, which keeps
our I/O down.

> > OK, so let's say we add generation headers to each commit. What happens
> > next? Are we going to convert algorithms that use timestamps to use
> > commit generations? How are we going to handle performance issues when
> > dealing with older parts of history that don't have generations?
> 
> So I do think the _initial_ question need to be the other way around:
> do we have to have generation numbers at all?

No, we don't need them. My "contains" patches were already implemented
using timestamps, and it's pretty fast. They fall down only in the face
lying timestamps (i.e., skew). The whole reason to switch to generation
headers was that we could assume they would be correct, and our
algorithms using them would be more likely to be correct.

And I do think a generation header would be more likely to be correct
than a timestamp, if only because timestamps are harder to get right.

> I think it's likely a design misfeature not to have them, but
> considering that we don't, and have been able to make do without for
> so long, I'm also perfectly willing to believe that we could speed up
> "contains" dramatically with the same kind of (crazy and inexact)
> tricks we use for merge bases.

Already done. I can point you to the patches if you want.

> For example, for the "git tag --contains" thing, what's the
> performance effect of just skipping tags that are much older than the
> commit we ask for?

It's as fast as using generations. See these two patches:

  http://article.gmane.org/gmane.comp.version-control.git/150261

  http://article.gmane.org/gmane.comp.version-control.git/150262

-Peff
