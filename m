From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 4/4] Add git-rewrite-commits
Date: Mon, 9 Jul 2007 13:57:10 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707091257470.5546@racer.site>
References: <11839118073186-git-send-email-skimo@liacs.nl>
 <1183911808787-git-send-email-skimo@liacs.nl> <Pine.LNX.4.64.0707090011070.4248@racer.site>
 <20070709094703.GP1528MdfPADPa@greensroom.kotnet.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: skimo@liacs.nl
X-From: git-owner@vger.kernel.org Mon Jul 09 15:04:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I7sv5-0002vO-U0
	for gcvg-git@gmane.org; Mon, 09 Jul 2007 15:04:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752633AbXGINEt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 Jul 2007 09:04:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752607AbXGINEt
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Jul 2007 09:04:49 -0400
Received: from mail.gmx.net ([213.165.64.20]:55866 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752519AbXGINEs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jul 2007 09:04:48 -0400
Received: (qmail invoked by alias); 09 Jul 2007 13:04:46 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp017) with SMTP; 09 Jul 2007 15:04:46 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18gERdrpZcgif6bsmcGdqW+UD5CoNwXyt8LYLwpwK
	GHDVb3n0lpHICO
X-X-Sender: gene099@racer.site
In-Reply-To: <20070709094703.GP1528MdfPADPa@greensroom.kotnet.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51989>

Hi,

On Mon, 9 Jul 2007, Sven Verdoolaege wrote:

> On Mon, Jul 09, 2007 at 12:56:04AM +0100, Johannes Schindelin wrote:
>
> > - you use a lot of what was in cg-admin-rewritehist (including 
> >   adjustments I made in the documentation for filter-branch), but you
> >   also make it more confusing for people used to that tool:
> > 
> > 	- instead of leaving the original branches as they are, you 
> > 	  overwrite them. That's okay. But then you put the originals into 
> > 	  refs/rewritten. Without cg-admin-rewritehist using that name 
> > 	  for the _result_, you could explain your way out of confusion. 
> > 	  As it is, you cannot.
> 
> I thought you had to specify the name of the new branch on the command
> line.  Anyway, I don't really care about the name of this hierarchy.
> I just picked a name that is somewhat related to "rewrite-commits".
> Suggestions are welcome.

How much more explicit should I formulate my suggestion?

> I could also just not create them.  The old values are also available in 
> reflog.

There are two types of convenience.  One for the programmer, and one for 
the user.  As a user I would definitely like to see which branches were 
actually changed.  So even if you _have_ to keep your current behaviour, 
namely that the results are stored under the original names, you should 
store the original refs in something like refs/original (overridable by a 
command line option), but _only if_ they actually changed.

> > 	- in spite of doing the same as cg-admin-rewritehist with filters, 
> > 	  you call them maps. But they are no maps. They are manipulators, 
> > 	  you can call them mutators or filters, too. Given what people 
> > 	  know of cg-admin-rewritehist, you really should keep the name 
> > 	  "filter".
> 
> Nonesense.

Quite a strong word.  Let's see if you can defend it:

> They are not filters 
> (http://en.wikipedia.org/wiki/Filter_%28higher-order_function%29). They 
> are maps (http://en.wikipedia.org/wiki/Map_%28higher-order_function%29).

Aha.  Functional programming.  Since when do we do functional programming 
here?  C++ is much closer to what we do.  So let's see:

http://en.wikipedia.org/wiki/Map_%28C%2B%2B_container%29

Does not apply at all here.  But does something else apply?  Ah, there is 
something about mathematics.  The basis of programming.  Maybe it is 
helpful:

http://en.wikipedia.org/wiki/Map_%28mathematics%29

Ah, no!  It only says that it is a function.  But there is a mention about 
partial maps!  And you said something about that:

> (In cg-admin-rewritehist some of them are (partial) filters,
> but the ones I have are not filters).

Alas, Wikipedia says about a partial function that it is a function which 
maps from one space into another space (not necessarily different spaces, 
though), but does not necessarily have a result for every input.

But in that sense, everything is a map.  Even rewrite-commits.  And 
commits. (Maybe you should rename that to map-maps?)

So maybe more luck with "filter"?  Since we still do not write in Haskell 
or something similar obscure, let's see if Wikipedia has something which 
is more likely applying to us.  Yes.  Software.  That surely 
must apply:

http://en.wikipedia.org/wiki/Filter_%28software%29

and even more to the point: UNIX filters:

http://en.wikipedia.org/wiki/Filter_%28Unix%29

You will see that both definitions apply _perfectly_ to what you do here.  
You pipe the commit into the "map" and write it out as a new commit!  
The _perfect_ example for a UNIX filter.

> I could extend the commit-map to remove the commit it the output is 
> empty, but it'd still be closer to a map than to a filter. (You can map 
> a commit to nothing, but a filter can't alter the elements of a list, it 
> only determines which elements are kept.)

This is not what the commit-filter of cg-admin-rewritehist does.  If at 
all, your commit-map is a better example for a filter than rewritehist's 
commit-filter is.

So, you cannot defend that bold statement.

Enough ranted about an unmerited rant, let's get back to the interesting 
stuff:

All you demonstrated here is that the way "commit-map"s work right now is 
not sufficient to make more complicated rewrite rules.  You cannot split 
one commit in two, and you cannot skip it.

> > 	- the name "map" itself is used in cg-admin-rewritehist, to map 
> > 	  commit names from old to new. By using that name differently, 
> > 	  again you contribute to confusion, for no good reason.
> 
> There is a good reason to call what I call maps maps.  They _are_ maps.
> Still, I'm open for suggestions.

Are you?  Well, my suggestion still stands...  I mean, the suggestion I 
already gave in the post you quoted.  You know, to keep the name as it was 
in the program you based your work on?  Okay, I'll be explicit for once: 
Filter.

> > - get_one_line() is a misnomer. It wants to be named get_linelen().
> 
> Hmmm... I guess you missed Linus' mistake when he introduced it
> in commit.c (e3bc7a3bc7b77f44d686003f5a9346a135529f73).

Yes.  But finger pointing will not help you here.  I reviewed _your_ code.

> Do you want me to rename that one as well?

Be my guest.  But let's do that independently, will ya?

> > - instead of spawning read-tree, you could use unpack_trees() to boost
> >   performance even more. But I guess it is probably left for later, to 
> >   make it easier to review the patch.
> 
> Yeah, it looked a bit tricky for an initial implementation, especially
> where I move the HEAD forward.

Later.

> > - The example you give with "git update-index --remove" can fail, right? 
> 
> Yes.  Spectacularly, even.

Does that mean you acknowledge that the man page should tell about this?  
And probably also reveal the "|| :" remedy?

> > - The commit filter again deviates from the usage in cg-admin-rewritehist. 
> >   I can see that you wanted to make it more versatile. However, it makes 
> >   the tool potentially also a bit more cumbersome to use. Besides, you use 
> >   a temporary file where there is no need to.
> 
> Are you saying I should use two pipes?

Umm.  Why not?

> What if the commit message is larger than the pipe buffer?

You start_command().  Then you write() until it is all written, or the 
pipe is broken.  Then you get the output via index_pipe().  Which is a 
single sha1.  I do not understand your question.

> > - the more fundamental problem with the missing "map", I do not see a 
> >   reasonable way to get the same functionality from any of the code 
> >   snippets passed to rewrite-commits. Indeed, even the workaround of 
> >   cg-admin-rewritehist, to read $TEMP/map/$sha1, does not work, since you 
> >   are keeping it all in memory. On IRC, gitster suggested to use a 
> >   bidirectional pipe (such as stdin/stdout) to get at the new commit 
> >   names, but because of buffering, I guess this is no joy.
> 
> I could add an option to write $TEMP/map/$sha1, but it's not clear
> to me when such a map would be useful.  Please enlighten me.

To be flexible, you have to have a way to ask "what was this commit 
rewritten to?" from within a filter.

Example: maybe you expect the rewritten commit to have a tree identical to 
commits in a certain branch, which was _also_ possibly rewritten.  Maybe 
you want to mark these pairs, for example by a tag.  Then you need to get 
the sha1 of the rewritten commits.

> > As commented on IRC, the env/tree/parent/msg filters of 
> > cg-admin-rewritehist could be all emulated by commit filters. However, 
> > that would be really inconvenient. So at a later stage, these would 
> > have to be integrated into rewrite-commits (even if it would be 
> > possible to drive rewrite-commits by a shell porcelain, but I guess 
> > you are opposed to that idea, since you want to do everything else in 
> > C, too).
> 
> I'm not opposed to running a few commands and connecting stuff in shell. 
> (See git-submodule add, although I admit that I would have preferred to 
> do all of it in C.)

Yes, but your original version was very intrusive and hard to review.  In 
contrast, the simple shell script we have now is hackable by many, and 
easily reviewed.  Indeed, it takes but a couple of minutes to verify that 
it does what it should do and has no side effects.

But I agree, it is easy enough to run the commands from rewrite-commits.c.  
The harder part is to provide an infrastructure which makes it useful.

To enhance on the above example: you're rewriting the commit messages so 
that commit names are rewritten to match the rewritten commits.  That is 
possible by a message filter in cg-admin-rewritehist.

But now somebody comes along, and says "I have a history I need to 
rewrite.  All bug fixes.  The commit names were all abbreviated in the 
commit messages, but they always had 'commit ' in front of them.  I want 
to rewrite them, too."

No chance without a "map" function.  Except to bug you to change the C 
code for this very special need.

By contrast, filter-branch does not need to be changed for that at all.

> > However, the biggest and very real problem is that your filters do not 
> > have a "map" function to get the rewritten sha1 for a given sha1. That 
> > is what makes the filters so versatile, though, since you can skip 
> > revisions by much more complex rules than just greps on the commit 
> > message or header.
> 
> I thought your were opposed to the idea of skipping commits, since
> you still carry along the changes in those commits.

Are you trying to misunderstand me?

You can tell the user how to skip single commits.  But you have to warn 
them that they might be wanting something different, because the word 
"commit" not only implies a "revision", which you would skip in this 
context, but also a "commit diff", which you would _not_.

The "much more complex" rules clearly are for other use cases, which 
brings me to your next question:

> Do you have a use case?

_You_ already mentioned it.  Subdirectory filters.

And if you think a little further, you can easily see that for this to 
become useful, you _have_ to have a "map" function, too.  Because you are 
likely wanting to use rewrite-commits, or filter-branch, to transform big 
repositories into super/subprojects.

> > But hey, maybe it _is_ time to rethink the whole filter business, and 
> > introduce some kind of regular expression based action language. 
> > Something like
> > 
> > 	git rewrite-commits -e '/^author Darl McBribe/skip-commit' \
> 
> What's wrong with --author='!Darl McBribe' ?

It is a very special use case.  Not always will you be able to get all the 
information from the commit object you need for conditional operations.  
My example only showed that you can do the same with that syntax.  But 
imagine what you could do if we just added a small syntactical sugar:

	-e '?has-path:README?substitute/v2/v3/'

> > 		-e 'substitute/^author Joahnnes/author Johannes/header' \
> > 		-e 'substitute/poreclain/porcelain/body' \
> > 		-e 'rewrite-commit-names'
> 
> Hmmm... some of these would basically need a builtin sed. I was thinking 
> about adding --remove and --rename, though.

IMHO you will not get happy by introducing ever more, but still restricted 
functionality.

At the moment, cg-admin-rewritehist can do much more than what 
rewrite-commits can do, because the eval'ed filters give you a much 
greater freedom in what you can do (since "map" is available, and you can 
even modify the commit name mapping by the filters on the go: they can 
edit .git-rewrite/!), and how you can do it (no need to work around 
certain limitations by using temporary files).

A lot of the speed of rewrite-commits stems from the fact that it is 
limited in that way.

Don't get me wrong.  I _want_ rewrite-commits to replace filter-branch.  
But there are fundamental problems with filter-branch, and there are 
fundamental problems with having the same functionality from within C.  
And it appears to me that you do not even try to address the latter 
fundamental problems.

Ciao,
Dscho
