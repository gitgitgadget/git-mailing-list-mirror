From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [RFC/PATCH] push: introduce implicit push
Date: Sun, 14 Apr 2013 18:59:06 +0530
Message-ID: <CALkWK0k6bmjFxTSMAutgu2EjWRZ_cyTU9jZ3Er-aaV78T16RtQ@mail.gmail.com>
References: <1365780835-2853-1-git-send-email-artagnon@gmail.com>
 <7v38uvcrjl.fsf@alter.siamese.dyndns.org> <CALkWK0=-GcOF17Q-y-Aqj0ThX5pPQFrriDqoJ2qsr=CS+wUNGA@mail.gmail.com>
 <7vehed7ilu.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Apr 14 15:30:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URN0M-0002HP-0i
	for gcvg-git-2@plane.gmane.org; Sun, 14 Apr 2013 15:30:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751631Ab3DNN3r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Apr 2013 09:29:47 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:49432 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751485Ab3DNN3r (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Apr 2013 09:29:47 -0400
Received: by mail-ie0-f174.google.com with SMTP id 10so115994ied.19
        for <git@vger.kernel.org>; Sun, 14 Apr 2013 06:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=o3kWqRTNt7Zjtv7nAoi7bZQ39lBtX1RKyF8LrPCQ/BU=;
        b=oZvvUyeJoPr6XVuK7QpP4F/8UfW4URdKVuCf1wS+pAnLFWuchwnO4E035ucK3Xn0bm
         cpRWSF31Ka/CVlIuKRZW9Y8VIrG9W1f2wgeQG4imK02ubqDeNtxlyfBxskZlHdQT6hTY
         j43tHxg5q4esk8pMjT8E3zlFA41pq2pejkqLr+iNGcxD+mmZlbr27Mo8JK3L0awXNqRu
         nR0nipYKbG6g0EhCfPsxkJTBQ8j5i8TtgYhQei1HnYG0pWvb54ELuXq1wlOreRIJ4Cvk
         rUM2ujL190yHbtmqJtVoE5jKmFBbWGmFT6tuUvvDyqt53YDuWWxLFFwlQrJhYxCoR6o1
         SlWg==
X-Received: by 10.50.17.166 with SMTP id p6mr3177266igd.12.1365946186265; Sun,
 14 Apr 2013 06:29:46 -0700 (PDT)
Received: by 10.64.34.80 with HTTP; Sun, 14 Apr 2013 06:29:06 -0700 (PDT)
In-Reply-To: <7vehed7ilu.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221136>

Junio C Hamano wrote:
> [...]
> In any case, dispelling a misplaced blame on "matching" is not the
> main point of this message.

I _thought_ "matching" was a good scapegoat to blame current user
expectations on.  However, it's okay if you think that we're
misplacing the blame.  As long as we can agree that user expectations
are aligned with "choosing the remote based on the current branch",
we're good.  Let's not waste time attempting to dissect the reason for
this.

> I do not necessarily think that the best course is to devise an
> unintuitive (to unsuspecting users) set of rules and force users to
> understand it. That is where my secondary unhappiness comes from,
> and that was why I said that limiting the magic only to a very
> simple and easy to understand case might make it more sellable.

Note that I'm not married to the interface I'm proposing: we can
always have a git branch --set-destination-to, corresponding to git
branch --set-upstream-to.  I'm not sure what interface to come up for
tweaking remote.pushdefault though (since we have deemed that a
remote.default counterpart is unnecessary, we've never really thought
about the problem).

> The new branch.*.pushremote does not alleviate this confusion. It
> gives the same "when on this branch, we push out to that remote"
> (and not "when pushing this branch out, it goes there" impression.

branch.*.pushremote is a very new feature, and I doubt it's even
available to users yet (distribution package); therefore there is no
meaning set-in-stone that we cannot change quickly.  If you think
about it, it's completely illogical for branch.* options to depend on
the state of the worktree; I really think we should push for them to
be inherent branch properties: we can update the documentation
accordingly, if we agree on this.

I think the main point of disagreement is that I'm in favor of
respecting logic, while you're in favor of respecting user
expectations set by (what we acknowledge now as) historical mistakes.
 I'm not saying that we should _not_ respect user expectations, but
rather that we should find some way to mould our users' expectations
to align with the logical choice without causing unpleasantness.

> The last one is also the same.  The "guess destination" magic should
> kick in only when we can verify _all_ the refs we are pushing out
> are simple ones (branch names, and possibly tag names), and the
> behaviour should not depend on the order. Anything more complex is
> too confusing.

Okay, no problem.  Just so we're clear: the "guess destination magic"
will only kick in when all the refspecs specified are either tags or
branches, and are missing the :<dst> counterpart.  So, git push master
+implicit-push should work just fine.

> I personally think it is much more sellable to use an even simpler
> rule than what Jeff suggested, to make
>
>         git push -- <refspec>
>
> go to the remote.pushdefault (falling back to remote.default that is
> "origin"), without even paying attention to what branch you are on,
> and ignoring branch.*.remote/pushremote configuration.
>
> That is sufficient to support the triangular, the publish-to-mine,
> and the centralized workflows, no?  In any of these cases, the
> repository you push out to is _one_, even though it may be a
> different one from where you pull from.  If you have a very special
> branch that goes to a different place than all the other branches,
> you can always push out while on that branch without any refspec,
> anyway.

This is logically incorrect: you're essentially making branches and
tags equivalent, while this is clearly not the case.  Will I ever
create "throwaway tags" just on my local machine for ease of working,
that I desire not to publish anywhere?  Now, replace "tags" with
"branches" in that sentence, and you have a completely different
answer.  Will I ever want to send certain specific "tags" to a special
destination (for review, for instance)?  Again, "branches" gives you a
different answer.  Can I attach properties to tags?  Are there tag.*
variables that I can set?  Why, then, do branches have these
variables?  Because they're not tags!  The way we work with branches
is completely different from the way we work with tags.

Let me try to drive this point in even harder:

My local clone is never one repository, but a "composite repository"
containing object stores from multiple remotes mixed in.  The
fantastic thing about git is that I can use the same worktree/ index/
local refs to work with this composite, as if it were a single
repository.  However, I need a way to sort through this mixed object
store/ multiple remotes madness: and for this, I have different remote
refs, and local branch specific configuration variables.  Again, I
don't think of my repository as a whole, but rather as a collection of
related branches that each have a specific source and destination.  I
do _not_ have one global source, or one global destination: that's
just the two-remote case, and git allows me to have N remotes in the
general case.  What I meant by "triangular workflows" was not the
reduced case of a repository-wide triangle, but about many little
triangles associated with every branch.

What is the practical application for all this?  What if I always want
to send some specific branches to a different destination (say Gerrit
review, or my friend's "integration server")?  What if I never want to
publish some branches (say they contain sensitive information such as
private keys)?  What if my upstream gave me write access to some
specific branches (in which case, I don't want to push those branches
to my usual "fork destination")?  Why are you proposing to
artificially limit the implicit-push topic to not support these cases?
 They're not special or fringe cases, but the general case that git
was always designed for.

Moreover, in your attempt to design a compromise, you're inventing a
different precedence order!  Wait a minute: why should we compromise
in the first place?  We're not an old enterprise trying to satisfy a
myopic client specification for a living; developing git is our
full-time hobby (today is a Sunday, by the way), and we should not
build something that we're less-than-elated with.  In my proposal, the
precedence order branch.<name>.pushremote, remote.pushdefault,
branch.<name>.remote, remote.default, origin, remains the same: we
just want to change which branch that <name> refers to.  In my
opinion, it is a much more subtle change than the entirely new
precedence order that you're inventing.
