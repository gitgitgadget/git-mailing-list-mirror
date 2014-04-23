From: Max Horn <max@quendi.de>
Subject: Re: [PATCH v2 2/3] remote-helpers: move out of contrib
Date: Thu, 24 Apr 2014 00:41:48 +0200
Message-ID: <EFCABE07-971C-4699-9A03-C5076B3B45ED@quendi.de>
References: <1398112633-23604-1-git-send-email-felipe.contreras@gmail.com> <1398112633-23604-3-git-send-email-felipe.contreras@gmail.com> <38F8C9C6-E186-4C42-B3F0-931AE73400FA@quendi.de> <5358286ba756e_24448772ec82@nysa.notmuch>
Mime-Version: 1.0 (Mac OS X Mail 6.6 \(1510\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 24 00:41:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wd5rZ-0005ho-8o
	for gcvg-git-2@plane.gmane.org; Thu, 24 Apr 2014 00:41:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751850AbaDWWlw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Apr 2014 18:41:52 -0400
Received: from wp256.webpack.hosteurope.de ([80.237.133.25]:58862 "EHLO
	wp256.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751752AbaDWWlu convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Apr 2014 18:41:50 -0400
Received: from ip-84-118-176-11.unity-media.net ([84.118.176.11] helo=zanovar.fritz.box); authenticated
	by wp256.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	id 1Wd5rR-0007dH-8U; Thu, 24 Apr 2014 00:41:49 +0200
In-Reply-To: <5358286ba756e_24448772ec82@nysa.notmuch>
X-Mailer: Apple Mail (2.1510)
X-bounce-key: webpack.hosteurope.de;max@quendi.de;1398292910;858b11f8;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246908>


On 23.04.2014, at 22:54, Felipe Contreras <felipe.contreras@gmail.com> wrote:

> Max Horn wrote:
>> On 21.04.2014, at 22:37, Felipe Contreras <felipe.contreras@gmail.com> wrote:
>> 
>>> The remote-helpers in contrib/remote-helpers have proved to work, be
>>> reliable, and stable. It's time to move them out of contrib, and be
>>> distributed by default.
>> 
>> Really? While I agree that git-remote-hg by now works quite well for basic
>> usage in simple situation, there are still unresolved bugs and fundamental
>> issues with it.
> 
> s/basic usage in simple situation/complex usage in the vast majority of situations/

Yeah, hm, no. We can agree to disagree, I guess. It might also depend on
what you call "basic" or "complex" usage...

For example, whenever I need to
- close a branch
- fix a branch with multiple heads
- deal with phases
I need to switch to hg. I am pretty sure there are more things that make
that necessary, but luckily they don't happen to me.

What does work, though (and what I count as basic usage, although I'd say it
probably is enough for 95% of people out there) is making a clone of "safe"
repository (i.e. no "bad" branch names like 'foo' together with 'foo/bar'),
push and pull with it; and if you are careful, you can even get branch
attribution right. This is great, but in day-to-day usage, I still regularly
need to work with a hg clone for some tasks. But I am not really complaining
about that: For most of my regular "developer" work, I can stay in git, and
that makes me happy.

Out of curiosity: How do you yourself use git-remote-hg in your daily work?
Many people I encountered are happy enough with the ability to quickly
clone a hg repository, prepare a fix / feature branch and then submit
it back to upstream. For this, git-remote-hg *usually* is good enough.
But I am worried about people hitting the edge cases where it does not
quite work -- and then people are lost. This is what concerns me -- and
this concern would be alleviate if there was a list of known things that
do not work (and perhaps cannot work, at least for now, due to fundamental
differences between hg and git which need major work to bridge over).

Anyway, despite my criticism, I'd like to emphasis that I am actually quite
happy and grateful that your git-remote-hg exists and that you continue
improving it and the surrounding infrastructure. I just wish you could do it
while not acting like an asshole most of the time, but I'll survive that,
too *shrug*.



> 
>> E.g. I recently showed you a reproducible use case involving git-remote-hg
>> that puts the helper into a broken state from which it is difficult for a
>> normal user to recover. Namely when a hg branch has multiple heads, then
>> git-remote-hg exports all of those to git, but only adds a git ref for one of
>> them; after pruning unreferenced commits, the fast-import marks file
>> references git commits that now are missing, prompting git fast-import to
>> crash and trash the marks file. Afterwards, attempts to push or pull from the
>> remote hg repository are answered with an error.
> 
> Yes, and how often does that happen? A normal user would only see this if a
> branch remains with multiple heads in Mercurial for more than one month or so.

There are projects who do exactly that, although I believe most of them use
bookmarks, so the issue should indeed not affect those. Anyway, they do the
wrong thing ;-). Still, if you are forced with such a repository, it's not
very helpful to be told that this is your own fault...

But this kind of issue also happens in any other scenario were heads are not
mapped to a git reference. At the very least, it also happens for closed hg
branches. These are quite common, and I also run into that in real life.

[And to reply to a claim you made in another mail: No, I am not deliberately
"hoarding" issues to make you look bad. But analyzing a breakage you run into
and then properly writing it up takes time; and when you know you will likely
be insulted when reporting it doesn't really help to motivate me to sit
down and do that...]


> 
> In practice that's very unlikely, and proof of that is that nobody has reported
> such issues.

No, that logic is flawed. For example, It could also mean that not many
people are using the tool, and of those not many bother to report issues via
your github bug tracker.

> 
> Either way, I just fixed it [1].

That's great to hear, thanks!

> 
>> There are more issues related to unresolved clashes between the git and hg
>> ways of naming things. E.g. I am collaborating on a hg repository that has
>> branches "foo" and "foo/bar" which git-remote-hg cannot handle because it
>> translates them to git branch names, and, well, git cannot handle that.
> 
> I don't see this as a limitation of git-remote-hg, ideally Git remote-helpers
> should have a standardized way to let users map external branch names.

Agreed. But in the meantime, I think users should still be warned about it.
Or perhaps git-remote-hg could detect this and print a more helpful message
that tells the user what is wrong...?

I did not actively know about this limitation of git and learned about it
when a hg repository I cloned caused git-remote-hg to print strange messages
I did not understand at first... ;-). For me that's OK as I am used to
debugging remote-helper issue by now, but "regular" users might not
fare quite so well...

> 
>> It may be hard to deal with some of them, and admittedly I wouldn't
>> necessarily expect that all of these are handled from the outset, i.e. "in
>> version 1.0". But I think at the very least, users should be warned about
>> these things.
>> 
>> More broadly speaking, there is currently no documentation at all in git.git
>> for those remote helpers, which I find worrisome.
> 
> Here is the documentation:
> https://github.com/felipec/git/wiki/git-remote-hg
> https://github.com/felipec/git/wiki/git-remote-hg

[I assume you meant one of the links to be for -bzr; but your point is clear in any case].

Great! But my point was not that there is no documentation, rather that
there is none in the git repository. Since you already have some
documentation, this should be easy enough to resolve; e.g. for starters,
those links could be included in the repository. Though I think that if the
helpers are moved out of contrib, they'd deserve a proper help page.

Reading through the git-remote-hg page, here are some suggestions:
- you already warn about octopus merges -- perhaps this would be a good
  place to also warn about e.g. "foo" vs "foo/bar", branches with multiple heads,
  closed branches, etc...
- you talk about "branch/next", shouldn't that be "branches/next"?
- indeed, branches deserve some extra attention. At the beginning of my usage
  of your git-remote-hg and of the gitifyhg fork, I run into the problem
  that commits I pushed to hg ended up on the wrong branch. This was because
  I added commits to one branch, say "branches/foo", then merged those
  into "branches/bar", then did a push -- and all commits I made ended
  up on the hg branch "bar". Now I know that I need to first push "foo",
  then afterwards push "foo".
  I am not asking for this to be "fixed" because it seems hard to "fix
  in the general case; just that users are warned about such pitfalls
  that do occur in basic usage in real life (and I know of other users
  who run into it, simply by the fact that I helped multiple people to
  get git-remote-hg or gitifyhg working and they come to me with their
  questions).



> 
>> That said, I don't know what the criteria are for moving something out of
>> contrib. Perhaps it is OK to move an undocumented remote-helper with known
>> bugs out of contrib.
> 
> There are no known bugs. This is the list of open bugs:
> 
> https://github.com/felipec/git/issues

At the time of writing, I was not aware that you had fixed the bug with the
marks file getting trashed. I did not yet have a chance to test your fix,
but I trust it works, so yeah, that resolve that. Excellent, thanks.

So, for now, there are just some "known limitations", but that's fine, I
guess.

Note that there are more limitations than those I listed above; not because
I want to "hoard" them, but because it seems rather trivial to come up with
those if one thinks about it for 5 minutes, so I simply assume(d?) you are
aware of most of them. Here's what I can think of right now; this still may
not be complete; nor do I mean to say those should hold up anything; I merely
want to get them out to prevent any future accusations about "hoarding"
stuff)

- close hg branches cannot be referenced from git, and thus not easily
  reopened (at least not from their old tip)
- multiple tips/heads of a hg branch cannot be referenced; only a single
  "random" head (in the sense that it is not documented how it is chosen)
  is visible
- more name clashes, e.g. the somewhat hypothetical case of having a hg
  branch "foo" and a hg bookmark "branches/foo"
- renaming remotes is a bit problematic (this is IMHO a shortcoming of the
  remote helpers interface, not of git-remote-{hg,bzr}). I.e. it
  can result in commits being re-exported, and hence in diverging history.
- Not sure if this is still a problem, but I was seeing some issues when
  a hg remote pruned some commits. Of course this is a bad thing to do in
  the first place, but sadly it sometimes happens. IIRC this resulted in a
  truncated marks file (which, as I understand, should be fixed already),
  but I am a bit fuzzy on the details (it was quite some time ago, and since
  something bad and exceptional was done on the hg side, I didn't bother to
  look closer at it.


Max