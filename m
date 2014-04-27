From: Johan Herland <johan@herland.net>
Subject: Re: Recording the current branch on each commit?
Date: Mon, 28 Apr 2014 01:39:26 +0200
Message-ID: <CALKQrgdFLc=k9i1+N2458amLMGQa99q55A=N785VfMRwfOH6Rg@mail.gmail.com>
References: <535C47BF.2070805@game-point.net>
	<CALKQrgfmBByMwMhxu3HkJqJGWy2Rwvij6Hi1_4npjfsxcSgpaQ@mail.gmail.com>
	<535D4085.4040707@game-point.net>
	<CALKQrgemFx=2JaC1BaRqCwEV+knC8QftxcZ7K0AsT9azzuyVdA@mail.gmail.com>
	<535D6EB1.9080208@game-point.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git mailing list <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>
To: Jeremy Morton <admin@game-point.net>
X-From: git-owner@vger.kernel.org Mon Apr 28 01:40:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WeYgK-0000hM-96
	for gcvg-git-2@plane.gmane.org; Mon, 28 Apr 2014 01:40:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751661AbaD0Xjj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Apr 2014 19:39:39 -0400
Received: from mail12.copyleft.no ([188.94.218.224]:36764 "EHLO
	mail12.copyleft.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751430AbaD0Xji (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Apr 2014 19:39:38 -0400
Received: from locusts.copyleft.no ([188.94.218.116] helo=mail.mailgateway.no)
	by mail12.copyleft.no with esmtp (Exim 4.76)
	(envelope-from <johan@herland.net>)
	id 1WeYfX-0002h0-RH
	for git@vger.kernel.org; Mon, 28 Apr 2014 01:39:36 +0200
Received: from mail-pd0-f176.google.com ([209.85.192.176])
	by mail.mailgateway.no with esmtpsa (TLSv1:RC4-SHA:128)
	(Exim 4.72 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1WeYfS-000KHp-JB
	for git@vger.kernel.org; Mon, 28 Apr 2014 01:39:30 +0200
Received: by mail-pd0-f176.google.com with SMTP id y10so71973pdj.21
        for <git@vger.kernel.org>; Sun, 27 Apr 2014 16:39:26 -0700 (PDT)
X-Received: by 10.68.189.232 with SMTP id gl8mr21868579pbc.89.1398641966304;
 Sun, 27 Apr 2014 16:39:26 -0700 (PDT)
Received: by 10.70.48.232 with HTTP; Sun, 27 Apr 2014 16:39:26 -0700 (PDT)
In-Reply-To: <535D6EB1.9080208@game-point.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247231>

On Sun, Apr 27, 2014 at 10:55 PM, Jeremy Morton <admin@game-point.net> wrote:
> On 27/04/2014 20:33, Johan Herland wrote:
>> On Sun, Apr 27, 2014 at 7:38 PM, Jeremy Morton<admin@game-point.net>
>> wrote:
>>> On 27/04/2014 10:09, Johan Herland wrote:
>>> As far as I can tell from that discussion, the general opposition to
>>> encoding the branch name as a structural part of the commit object is
>>> that,
>>> for some people's workflows, it would be unhelpful and/or misleading.
>>> Well
>>> fair enough then - why don't we make it a setting that is off by default,
>>> and can easily be switched on?  That way the people for whom tagging the
>>> branch name would be useful have a very easy way to switch it on.
>>
>> Therefore, the most pragmatic and constructive thing to do at this
>> point, is IMHO to work within the confines of the existing commit
>> object structure. I actually believe using commit message trailers
>> like "Made-on-branch: frotz" in addition to some helpful
>> infrastructure (hooks, templates, git-interpret-trailers, etc.) should
>> get you pretty much exactly what you want. And if this feature turns
>> out to be extremely useful for a lot of users, we can certainly
>> consider changing the commit object format in the future.
>
> OK, fair enough.  So I guess what I'd like to see, then, is good built-in
> functionality in Git for these commit message trailers, so that they are
> very easy to turn on.  I'd like to be able to tell co-developers to add a
> one-liner to their git config file rather than some post-commit script.

I think this is what the interpret-trailers effort is about.
Unfortunately I have not followed it closely enough to say if your use
case is already covered by Christian's (CCed) work. Christian: With
your current patch series, is it possible for Jeremy to configure
interpret-trailers to automatically append a "Made-on-branch:
<current_branch>" trailer whenever he creates a commit?

[...]

> What I'd like to see, then, is this trailer functionality built in to Git so
> that a very minimal amount of setup is needed to get everybody using it.
> We're basically talking about hijacking the commit messages and tacking on
> information that they weren't really intended to hold (ie. stuff the
> developer hasn't manually typed in as a commit message), because of the
> limitation of the Git commit format.  In hindsight, I guess it would've been
> better to have the Git commit format be more flexible in terms of what
> headers it allows, so that new headers could easily be added and some
> headers could be optional.

Which - if you squint at it a little - is sort of what the
interpret-trailers effort does. AFAIK, it (combined with hooks) allows
you to configure a set of optional s/headers/trailers/ and the
policies surrounding those.

>>> Only if it's a non-ff merge, which results in less tidy commit trees, and
>>> hence is often recommended against.
>>
>> Not at all. If you're developing a series of commits with a common
>> purpose (a.k.a. a topic branch) I would very much argue for
>> non-ff-merging this, _exactly_ because the merge commit allows you to
>> introduce the entire topic as a single entity. The merge commit
>> message (in addition to containing the branch name) is also the
>> natural place to describe more general things about the topic as a
>> whole - sort of like the cover letter to a patch series.
>
> Would you recommend that every single commit be made in a branch that gets
> merged into master, then?  So, no direct commits to master?

There are a lot of variables here, and it really comes down to your
(team's) preferred workflow. Different teams/people prefer different
workflows, and git's toolbox allows a wide (probably the widest among
any VCS) variety of workflows to be expressed. So I really cannot make
any sweeping/simple recommendations that will apply to all cases.

Although I prefer collecting related commits on a topic branch that
are then (non-ff) merged into master, I also see the value of
performing a quick single-commit bugfix directly on master. In the
latter case, the commit should obviously be self-sufficient and
self-explanatory. However, once your work start spanning more than a
few commits, you should really think about putting it on a separate
branch, where it can be (re)organized in a way that is logical and
reviewable (interactive rebase FTW).

When I think about it, this might only apply to centralized workflows
where team members (typically co-workers) push their own work to a
shared repository/branch. As a counterexample: in git.git, pretty much
every change (whether it consists of a single patch, or a series of
patches) gets its own "$who/$what" branch in Junio's tree, and are
then merged to 'pu'. When deemed worthy, they are merged to 'next' and
- later - to 'master'. So here, even single-commit changes get their
own branch and subsequent merge commit. Likewise, with GitHub's
pull-request workflow, you make changes on a branch in one repo, and
then request that branch to be pulled (i.e. merged) into another repo,
regardless of whether it consists of one or many commits.

However, one sweeping recommendation that I _can_ make across all
workflows is this: _Think_ about your commit history. Treat it with
the same respect and attention to quality as your code (or whatever
your "main" work product is). A well-organized history with good
commit messages is an invaluable tool in grokking how the current
state of a project has come to be, and it encodes a great deal of
knowledge about the project from its developers, and can be of great
help when debugging.

>> The problem is not really "less tidy commit trees" - by which I gather
>> you mean history graphs that are non-linear. IMHO, the history graph
>> should reflect parallel/branched development when that is useful.
>> Blindly rebasing everything into a single line is IMHO just as bad as
>> doing all your work directly on master and blindly running "git pull"
>> between each of your own commits (which results in a lot of useless
>> merges). The merge commits themselves are not the problem. Merge
>> commits are a tool, and when used properly (to introduce topics to the
>> master branch like described above) they are a good tool. When abused
>> (like blindly running "git pull" and accepting useless "merge
>> bubbles") they create more problems than they solve.
>
> Sounds like the default behaviour of "git pull" might not be ideal if it
> easily causes these problems.

Agreed, and I believe Junio has also stated that the default behavior
of "git pull" is better suited for maintainers (like Junio and Linus)
that pull from downstreams, rather than regular
contributors/co-workers that more often pull from their upstream. "git
pull --rebase" (or branch.<name>.rebase, or even
branch.autosetuprebase) is one way to work around that, but even that
can also be abused if you do in indiscriminately (can lead to
different topics being interleaved in-line on master, which makes it
hard to identify which commits belong to which topic). Again, the
ideal is for people to think about what they're doing, and not just
run commands blindly...

>>>   Whatsmore, tracking down which branch a
>>> commit pertains to is still rather difficult using this approach.  You
>>> can
>>> go back through the history and find "Merge branch 'pacman-minigame'",
>>> but
>>> how do you know which commit was the *start* of that branch, if they are
>>> not
>>> tagged with the branch name?
>>
>> Once you have found the merge commit (M), git log M^1..M^2 should list
>> all the commits that were made on that branch. The parent of the last
>> in that list can be considered the starting point for the branch.
>
> I don't quite understand this; your suggestion would only work on the
> assumption that no merges have been made from master to that branch; git log
> M^1..M^2 will get the most recent common ancestor of the two and show the
> commits between them, but if there has been a merge from master to branch,
> it will not show the commits to the branch before that merge...

Actually no, "git log M^1..M^2" shows you all commits reachable from
M^2 that are not reachable from M^1, and assuming your merge went
_from_ master and _to_ the branch (NOT the other way), it will show
all the commits to the branch (3 x A + 3 x B). Illustration:

   o---o---o---o---o---o---o---M     <-- master
    \           \             /
     A---A---A---m---B---B---B       <-- branch

The initial commits (3 x A) on the branch before the intermediate
merge from master (m) are not reachable from M^1 (the last 'o' before
M), thus they _will_ show up in "git log M^1..M^2". This holds no
matter how many merges are done from master to branch.

Obviously, if the merge had gone the other way, like this:

   o---o---o---m---o---o---M     <-- master
    \         /           /
     A---A---A---B---B---B       <-- branch

then the initial branch commits (3 x A) preceding 'm', will not be
shown by "git log M^1..M^2", but that is because they have already
entered the master branch (at m). Whether you still consider them part
of the same branch as the 3 x B commits is really a philosophical
question at that point.


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
