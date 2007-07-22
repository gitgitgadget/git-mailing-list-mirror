From: David Kastrup <dak@gnu.org>
Subject: Re: [RFC PATCH] Re: Empty directories...
Date: Sun, 22 Jul 2007 15:53:19 +0200
Message-ID: <857iosmto0.fsf@lola.goethe.zz>
References: <85lkdezi08.fsf@lola.goethe.zz> <f7uap7$eo1$1@sea.gmane.org>
	<85myxpp67k.fsf@lola.goethe.zz> <200707221406.25541.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 22 15:53:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ICbsS-0000HB-4K
	for gcvg-git@gmane.org; Sun, 22 Jul 2007 15:53:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751363AbXGVNxZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Jul 2007 09:53:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751348AbXGVNxZ
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Jul 2007 09:53:25 -0400
Received: from mail-in-02.arcor-online.net ([151.189.21.42]:34688 "EHLO
	mail-in-02.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751265AbXGVNxY (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 22 Jul 2007 09:53:24 -0400
Received: from mail-in-09-z2.arcor-online.net (mail-in-09-z2.arcor-online.net [151.189.8.21])
	by mail-in-02.arcor-online.net (Postfix) with ESMTP id C4C341A72FA;
	Sun, 22 Jul 2007 15:53:21 +0200 (CEST)
Received: from mail-in-07.arcor-online.net (mail-in-07.arcor-online.net [151.189.21.47])
	by mail-in-09-z2.arcor-online.net (Postfix) with ESMTP id AFEA828EBDA;
	Sun, 22 Jul 2007 15:53:21 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-022-107.pools.arcor-ip.net [84.61.22.107])
	by mail-in-07.arcor-online.net (Postfix) with ESMTP id 76BAC28ABA7;
	Sun, 22 Jul 2007 15:53:21 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id E31E71D1E182; Sun, 22 Jul 2007 15:53:19 +0200 (CEST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
X-Virus-Scanned: ClamAV 0.91.1/3728/Sun Jul 22 07:07:30 2007 on mail-in-07.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53270>


Jakub, this mail is too long already, and it does not make sense to
tack a changed proposal to its end since then the readers will be
exhausted at the time they come there.  So I'll instead tack a
followup to the "big picture" mail instead where I outline a modified
approach which is presumably easier to understand and completely
backwards-compatible, incorporating your feedback.

There is probably little sense in wasting your time on a detailed
response: feel free to point out where you don't see myself making
sense.  I have no problem with people coming to different conclusions
that I do, but I would prefer it if it is not because they consider
myself a raving lunatic, but because they have different opinions
regarding the details.

"I can follow you, but I disagree with your conclusion" is perfectly
fine for now since I am going to propose something else, anyway.

Thanks for the feedback.  It gave me some good ideas.

Jakub Narebski <jnareb@gmail.com> writes:

> On Sun, 22 July 2007, David Kastrup wrote:
>> Jakub Narebski <jnareb@gmail.com> writes:
>>> David Kastrup wrote:
>>>
>>>> I must be really bad at explaining things, or I am losing a fight
>>>> against preconceptions fixed beyond my imagination.
>
> Or you are wrong...

Well, there is little reason for you to take my word on it, but I
happen to have a history of designing and implementing systems where I
have been responsible for every single byte, bootloader, firmware,
applications, target compiler, assembler, whatever.  I have been
exposed to Unix and working with it several years before Linux even
existed.  I also have a track record of being not exactly stupid.

So I pretty much can rule out that I am wrong on the factual side.

But where I may be wrong is in estimating the how obvious the design
can appear to others, and how useful and maintainable for others it
may be in the long run.  Linus says "code talks", but that's actually
not half the story.  If my code says that it works and the evidence is
there, but nobody is able to understand _why_ it works, it has no
place in a project where I am not permanently around.

If smart people don't get what I am talking about, it does not matter
that the patch is surprisingly well-contained: it will be a
maintenance nightmare because people will never figure out why
something stopped working after some particular change.

>> I disagree here.  The object database _can_ represent an _empty_
>> directory that has been added explicitly, because up to now no
>> operations existed that actually left an empty tree.  But it can't
>> distinguish a _non_-empty directory that has been added explicitly
>> from non-empty directory that has not been added explicitly.
>
> True. I forgot about that.

Thanks.  It is almost a revelation that anybody can agree on any point
with me at the moment.

> IMHO it would be best to first provide plumbing infrastructure (as
> e.g.  it was the case of submodule support), then add option to
> git-update-index to change the "stickiness"/"autoremoval" status of
> a directory (of a tree), and _last_ think about how to change the
> porcelain (git-add and git-rm).

Sure.  It does no harm to think about reducing the amount of breaking
porcelain, though.

> [...]
>
>> And a perfectly consistent way is to make those trees with an
>> explicitly added directory _non-empty_, by virtue of putting a file
>> "." in them.  This file, of course, exists in every physical
>> directory, but we may or may not decide to let it be tracked by
>> git, using the gitignore mechanism on the pattern ".".  Perfectly
>> expedient.
>
> Here we disagree. I think putting "." in a tree as marker of having
> it not be automatically deleted when empty, as opposed to marking
> tree using filemode in the parent, is not a good idea.

Well, "not a good idea" is a far step forward from "stupid idiot
babbling nonsense", so we may make progress towards actually being
able to _weigh_ different options.  I can actually associate with "not
a good idea", not least because nobody else seems to get the idea, and
that makes it infeasible for maintenance.

So I'll address some points and then propose a different way of
implementing what will in the end amount to rather similar semantics,
but with a different view of looking at those semantics, one that
corresponds well with the implementation.

> The only advantage to the "." idea is that it can use gitignore
> mechanism (both in-tree .gitignore, tracked or not, and info/exclude
> file). But I also think that the fact that gitignore mechanism is
> recursive is more of disadvantage than advantage.
>
> First, it is _not_ consistent. Working directory trees _always_ have
> '.'  in them, while trees would have or would have not it, depending
> if they would be "sticky" or "autoremoved".

Let me point out again that this inconsistency is already present in
the difference of tracked and untracked _files_: they are always in
the working directory, while trees have or not have them, depending on
whether they are "registered" or "not".

There is no inconsistency involved here, but it seems to make people
_very_ uncomfortable to factor out the "stays around even if empty"
functionality and call it "dir/." from the "can hold content"
functionality which is in effect called "dir/", and basically
associate tracked physical existence just with the former.

The recursiveness of the gitignore mechanism has the advantage that
when maintaining a large repository with actual or logical
subprojects, one does not need to pick a single policy for all
subprojects.  I think that is quite important.  It could possibly be
achieved with some other method of having per-subproject
configuration, but I see little wrong in using what is there and
documented already.

> Second, the "easy implementation" is anything but easy. "git add ."
> as a way to mark directory as "sticky" is not backward compatibile:
> currently it mean to add _all contents_ of current directory.
> Implementation is tricky: as we have seen trying to unlink '.' or
> create '.' can unfortunately succeed on [some Sun OS, and UFS
> filesystem] (which follows POSIX stupidly to the letter) f**king up
> the filesystem.

I was not suggesting actually leaving any such calls in place: after
all, they would presumably lead to error messages.  But I agree that
this could lead to nasty surprises when somebody with a legacy version
of git worked with a repository containing "." as explicit entries of
some file type.

> The alternative proposal of adding "magic mode" to mark directory as
> "not remove when empty" is largely tested; it is very similar to the
> subproject support.

Good.  Because it is what I converged to last night.

> Third, is contrary to the git philosophy of tracking contents.
> "Stickiness" is an attribute; the fact that directory is explicitely
> tracked or not does not change contents of a directory. Compare to
> 'blob' which contains only contents of a file: not a filename, not a
> pathname, not [subset of] filemode.
>
> Fourth, is very artificial. What would you put for filemode for '.'?
> 040000 (i.e. directory)?

Taken already.  By something very artificial, namely a tree...  Yes,
this was a wart in my proposal.

> What would you put for sha1?  Sha1 of an empty directory?

Some fixed value.  Everywhere the same.  Not really relevant.

>> That basically implies that no information about directories could
>> be tracked in the repository.  And yes, we need appropriate
>> information in the index.  Again, the information whether a
>> directory was added explicitly.
>
> Whether directory is automatically managed by git (automatically
> removed or untracked). But we need directory entry in index for
> git-diff, for example to recognize if there is or there is not empty
> directory, or if a directory is automanaged or not.

One conclusion that I have come to (and I think I am in agreement with
Linus here) is that the information "empty or not" is actually useless
separately: when I add files below a directory to the repository, the
directory _can't_ be empty.  And git has no way of knowing whether it
is non-empty because I wanted the directory to be there, or whether it
is non-empty because I could not have checked in the files into the
tree below it otherwise.

>> And the repository is a versioned and hierarchically hashed version
>> of the index, but its trees contain _no_ information that is not
>> already inherently represented by the files alone. [...]
>
> The above sentence is nonsensical. Index is helper for repository,
> and can be derived from repository. Not vice versa.
>
> Trees do contain information which is not inherently present by the 
> blobs.

Could you give examples for such information?  As long as we are not
talking about _history_, I am at a loss at what else you mean.  File
names and permissions?

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
