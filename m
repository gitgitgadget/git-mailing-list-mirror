From: Sam Vilain <sam@vilain.net>
Subject: Re: [PATCH] Documentation: add a planning document for the next
	CLI revamp
Date: Thu, 30 Oct 2008 23:40:38 -0700
Message-ID: <1225435238.20883.18.camel@maia.lan>
References: <20081030002239.D453B21D14E@mail.utsl.gen.nz>
	 <20081031003154.GA5745@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Sam Vilain <samv@vilain.net>, git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Scott Chacon <schacon@gmail.com>,
	Tom Preston-Werner <tom@github.com>,
	"J.H." <warthog19@eaglescrag.net>,
	Christian Couder <chriscool@tuxfamily.org>,
	Kai Blin <kai@samba.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Oct 31 07:42:48 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KvniR-0008GY-7T
	for gcvg-git-2@gmane.org; Fri, 31 Oct 2008 07:42:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754032AbYJaGk7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Oct 2008 02:40:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752396AbYJaGk7
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Oct 2008 02:40:59 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:47010 "EHLO mail.utsl.gen.nz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751701AbYJaGk5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Oct 2008 02:40:57 -0400
Received: by mail.utsl.gen.nz (Postfix, from userid 1004)
	id 28D7821C50D; Fri, 31 Oct 2008 19:40:53 +1300 (NZDT)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on
	mail.musashi.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=5.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.5
Received: from [127.0.0.1] (longdrop.musashi.utsl.gen.nz [192.168.253.12])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.utsl.gen.nz (Postfix) with ESMTPSA id A0B1121C21D;
	Fri, 31 Oct 2008 19:40:42 +1300 (NZDT)
In-Reply-To: <20081031003154.GA5745@sigill.intra.peff.net>
X-Mailer: Evolution 2.22.3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99554>

On Thu, 2008-10-30 at 20:31 -0400, Jeff King wrote:
> >  Some suggestions, which have been briefly scanned over by some of the
> >  (remaining) GitTogether attendees.  Please keep it constructive!  :)
> Thanks for putting this together.

No problem!  Thanks for responding.  I've been amazed that it seems to
have been largely taken well :)  But there are still very important
changes required.

> > +  * 'git status' would encourage the user to use
> > +    'git diff --staged' to see staged changes as a patch
> 
> I notice the commit template message getting longer and longer. Maybe it
> is time for status.verbosetemplate (which could default to true, I just
> want to be able to turn it off).

Right.  We'll have to work through that when we look at how 'git status'
output is displayed.  There may be some people who parse the existing
output, but they should get to read the release notes about the proper
ways to do that.  I think the whole output could do with a shake-up.

> > +  * 'git undo' would do what 'git checkout HEAD --' does now
> This is an awful name, IMHO. It doesn't point out _what_ you're undoing,

As others have said, yes.

> So I think with your stage/unstage, we have:
> 
>   W->S: stage
>   H->S: unstage
>   S->W: ?
>   S->H: commit (no paths)
>   W->H: commit (paths or -a)
>   H->W: ?
> 
> So I think we can note something: movement commands are related based on
> their _destination_. So since both of the missing ones impact the
> working tree, they should have a related name.

An interesting observation.

I still think it's OK to use 'git revert-files' for this; it just seems
so long.  Switches could specify where to and from.

> Side note: there are actually _other_ places you might want to move
> content. Like a stash. So now you can think of it as:
> 
>                  stash
>                   ^  ^
>                  /    \
>                 /      \
>                v        v
>   HEAD <--> stage <--> working tree
> 
> So maybe we just need a "git content" command. And then you can "git
> content --from=HEAD --to=tree <paths>" or "git content --from=tree
> --to=stash", with all equally supporting "--interactive".  And of course
> I am kidding, because typing that would be awful. But I think
> conceptually, it makes sense. To me, anyway.

Again interesting, you could look at the stash as a whole bunch of
staged commits yet to happen.  Of course, adding a file when the version
in HEAD doesn't match the version in the base of the stash is a bit
insane, so should probably be an error.

I'll have a ponder over this and whether there is a simple word for this
all.

> > +  * 'git branch --switch' : alternative to checkout
> 
> Blech. I think switching branches is the one thing that checkout does
> unconfusedly. And this is much more typing. Not to mention that So I
> would rather see "git switch" if checkout is somehow unpalatable.
>
> But I don't know that it is. This seems like an attempt to say "branch
> operations should all be part of 'git branch'". But checkout isn't
> necessarily a branch operation. Consider detaching HEAD to a tag. Should
> it be "git tag --switch"?

You're right with all that.  I don't think that it is necessarily wrong
to have two ways to get at functionality, depending on whether you start
with the noun or the verb first; so long as it doesn't introduce
confusion.  And if anything, I think --switch is wrong; --checkout is
probably more consistent.

I think I might have to mark this one as [maybe], and make it --checkout
- as you say, it would need to go on all the other commands that are
nouns and able to be checked out to be consistent.  Let's see how that
looks in round 2.

> > +  * 'git push --matching' does what 'git push' does today (without
> > +    explicit configuration)
> 
> I think this is reasonable even without other changes, just to override
> any configuration.

Excellent, I have another vote towards this push sanity!  :)

> > +  * 'git push' with no ref args and no 'push =' configuration does
> > +    what:
> > +    'git push origin $(git symbolic-ref HEAD | sed "s!refs/heads/!!")'
> > +    does today.  ie, it only pushes the current branch.
> > +    If a branch was defined in branch.<name>.push, push to that ref
> > +    instead of the matching one.  If there is no matching ref, and
> > +    there is a branch.<name>.merge, push back there.
> 
> There was a thread between me and Junio some months ago that touched on
> this. I don't remember all of the arguments, but it was resolved to keep
> the current behavior. Any proposal along these lines should at least
> revisit and respond to those arguments.

Right.  So, before round 2, I'll read and attempt to summarise that
thread - assuming I can find it!  :)

> > +  * 'git push' to checked out branch of non-bare repository not
> > +    allowed without special configuration.  Configuration available
> I have this patch done and sitting in my repo, but I need to add the
> "without special configuration" bit and add tests and docs.

Looking forward to that!  Thanks.

> > +  * 'git branch' should default to '--color=auto -v'
> This should at least be configurable (even if it defaults to "on"). "-v"
> is more expensive, and not always wanted.
> 
> I, for one, just use "git branch" to get the current branch. I don't
> know of a more obvious way to ask for it (and please don't mention an
> ever-changing bash prompt).

What's wrong with 'git symbolic-ref HEAD' ?  *ducks*

Of course 'git branch -q' would then be the quick version, or 'git
br' (after git config --global alias.br 'branch -q')

Another command people often want is 'git info' to tell them stuff like
they might get from 'git status' or 'git remote' but without all the
file details...

> > +  * 'git tag -l' should show more information
> 
> I remember somebody talking about this, but not the details. Which
> information?

Oh, good point.  Basically the same stuff that 'git branch -v' shows; in
any case, its behaviour should be relatively consistent compared to 'git
branch'.

> > +  * 'git init --server' (or similar) should do everything required for
> > +    exporting::
> > +----
> > +chmod -R a+rX
> > +touch git-daemon-export-ok
> > +git gc
> > +git update-server-info
> > +chmod u+x .git/hooks/post-update
> > +git config core.sharedrepository=1
> > +----
> 
> But not all of those things are necessarily related, and some of them
> have security implications. I would hate to get a bug report like "I
> used --server because I wanted to share my content via dumb http, but my
> repo was p0wned because of too-loose group permissions."

ok.  That should come down to the detail of how '--server' is specified,
I think.  I'll expand on that during round 2.

Sam.
