From: Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCH] remote: add new sync command
Date: Mon, 14 Nov 2011 07:25:56 -0500
Message-ID: <20111114122556.GB19746@sigill.intra.peff.net>
References: <20111107172218.GB3621@sigill.intra.peff.net>
 <CAMP44s358k4EsCg+K6MeLEU4eLbb4mWyX9AdAf4P9CHvf9Lrwg@mail.gmail.com>
 <20111107183938.GA5155@sigill.intra.peff.net>
 <CAMP44s0M-qnZeHCUadSJJCYO=t881sUOi11G3fCG2vaAakPyBQ@mail.gmail.com>
 <20111107210134.GA7380@sigill.intra.peff.net>
 <CAMP44s089xbEo4VT8rqgS=BJMUu=qsb8Hm5z8bTR2akU8-5QhA@mail.gmail.com>
 <20111108181442.GA17317@sigill.intra.peff.net>
 <CAMP44s2RjcFtdO2jft0Hg9RtqK-DRK47gX8By-dBFSBcSA+yFA@mail.gmail.com>
 <20111111181352.GA16055@sigill.intra.peff.net>
 <CAMP44s06p+KyJAu4ddiCa8CFRq5eogbqxxJU16Z-SUb3GSp67Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 14 13:26:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RPvbw-0001zg-8m
	for gcvg-git-2@lo.gmane.org; Mon, 14 Nov 2011 13:26:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752281Ab1KNMZ7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Nov 2011 07:25:59 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:41079
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751413Ab1KNMZ6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Nov 2011 07:25:58 -0500
Received: (qmail 28950 invoked by uid 107); 14 Nov 2011 12:26:02 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 14 Nov 2011 07:26:02 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 14 Nov 2011 07:25:56 -0500
Content-Disposition: inline
In-Reply-To: <CAMP44s06p+KyJAu4ddiCa8CFRq5eogbqxxJU16Z-SUb3GSp67Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185381>

On Sun, Nov 13, 2011 at 12:07:19AM +0200, Felipe Contreras wrote:

> > So in that sense, it is poorly named, and "--branches" (or "--heads")
> > would be more accurate. At the same time, it is probably more likely
> > what the user wants to do (you almost never want to push "refs/remotes",
> > for example).
> 
> But you do want to push tags, and --all --tags doesn't sound right; if
> I'm pushing everything, why do I specify I want to push more stuff.
> And then, why it --all --tags disallowed?

I agree that "--all --tags" looks silly. I don't know why it's
disallowed; from my reading, it should be a perfectly sensible
operation. You might try digging in the history or the mailing list.

> > So I am a little hesitant to suggest changing it, even
> > with a warning and deprecation period.
> 
> It is confusing and wrong, what more reason do you need?

Because I am worried that "--all" pushing refs/remotes will also be
confusing; it's not what most people are going to want.

If your suggestion is to deprecate the name "--all" and start calling it
"--branches" or "--heads", then that is an improvement. But making
"refs/*:refs/*" easier to accidentally use might not be.

> > Right. It looks like that is just spelled "--mirror" (which gives you
> > pruning also), or "refs/*:refs/*" (without pruning). The latter is even
> > more flexible, as you could do "refs/*:refs/foo/*" to keep several
> > related backups in one upstream repo.
> 
> So, we agree that --all is the same as 'refs/heads/*'. Therefore we
> already have this mixture of refspecs and options.

True. I wonder why there has been so much confusion over "--tags", and
so little over "--all".

> > and then it really is just a special way of spelling "refs/heads/*". But
> > then, I also think it's good for users to understand that the options
> > are refspecs, and what that means. It's not a hard concept, and then
> > when they inevitably say "how can I do BRANCHES, except put the result
> > somewhere else in the remote namespace", it's a very natural extension
> > to learn about the right-hand side o the refspec.
> >
> > Of course I also think BRANCHES looks ugly, and people should just learn
> > "refs/heads/*".
> 
> Look, I'm all in favor of people learning stuff, but I have been
> involved in Git since basically day 1, and up to this day I was (am?)
> not familiar with refspecs, I don't use them regularly, and never
> really had a need to, and that's fine. People are already complaining
> about the learning curve of git, and what you are suggesting is that:
> 
> Instead of doing:
> % git push remote --branches --tags
> 
> They should do:
> % git push remote 'refs/heads/*' 'refs/tags/*'

Sorry, I should have been more clear with what I wrote. My "of
course..." was more of a tangential "well, this is so far from what my
gut tells me is reasonable that I'm not sure my definition of ugly is
even relevant here".

For me personally as a user, I prefer learning how a tool actually works
at its core (in this case, refspecs), and then applying syntactic sugar
to simplify usage. But I also respect that not everybody feels that way.

> I'm not going to investigate the subtleties of these different setups,
> I'm going to put my common user hat and ask; how do I fetch as a
> mirror?

The problem with that question is that you haven't defined mirror. Does
that mean you just want pruning, or does it mean that you want your
local ref namespace to match that of the remote?

Git should be able to do each of those cases. And I think it's fine to
have a less cumbersome syntax to specify them. But it's also important
that we don't over-simplify the terms so much that they get option A
when they wanted B.

BTW, right now there is "git remote add --mirror ...", which sets up the
fetch refspec for you (in this case, mirror is "make your refs look like
the remote's"). Perhaps rather than adding syntactic sugar to fetch, it
would be best to channel users into configuring a remote that selects
from one of a few common setups (including different types of mirrors).

It's not as flexible (I can't do a one-off mirrored push without using
actual refspecs), but my guess is that most users would want to set up
an actual remote, and picking from a set of configuration recipes would
be the ideal interface for them.

> > And "--prune-local" doesn't seem like a fetch operation to me. Either
> > you are mirroring, and --prune already handles it as above. Or you are
> > interested in getting rid of branches whose upstream has gone away. But
> > that's not a fetch operation; that's a branch operation.
> 
> This would make things more confusing to the user.
> 
> Say on one side I do this push?
> % git push test --prune 'refs/heads/*' 'refs/tags/*'
> 
> What do I do in the other side to synchronize the repo?
> % git fetch test --prune-local 'refs/heads/*:refs/heads/*'
> 'refs/tags/*:refs/tags/*'

No, you would just do "--prune", because your refspecs are _already_
indicating that you are writing into the local namespace, and anything
you have locally would be deleted by the prune operation. I.e., there is
no need for --prune-local in this scenario; --prune already does what we
want.

> I would prefer this of course:
> % git fetch test --all --prune-local
> 
> But you are saying it should be:
> % git fetch test 'refs/heads/*:refs/heads/*' 'refs/tags/*:refs/tags/*'
> % git branch --prune-remote test
> 
> That doesn't sound right to me; mixing branch operations with a specific remote?

I was trying to outline a situation where "--prune" wouldn't be
sufficient, which is:

  : we make some topic branch based on another branch
  $ git checkout -b topic-Y origin/topic-X

  : later, we (or someone else) deletes topic-X upstream
  $ git push origin :topic-X

  : now we fetch using the regular default refspecs, which put
  : everything in a separate remote. But we ask to prune, so that
  : deleted branches will go away.
  $ git fetch --prune origin

Now origin/topic-X doesn't exist, even though it's configured as the
upstream of topic-Y. Fetch doesn't enter into the picture, because it is
configured to only touch items in refs/remotes/.

As a user, how do I resolve the situation? I might say topic-Y is
obsolete and get rid of it. I might rebase it onto another branch. Or I
might declare it to have no upstream. But all of those are branch
operations, not fetch operations.

So what I was trying to say was that either your fetch refspecs tell
fetch to write into your local branch namespace, or not. If they do,
then --prune is sufficient (with no -local variant required). If not,
then touching your local branch namespace is outside the scope of fetch.

-Peff
