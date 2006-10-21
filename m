From: Aaron Bentley <aaron.bentley@utoronto.ca>
Subject: Re: VCS comparison table
Date: Sat, 21 Oct 2006 16:05:18 -0400
Message-ID: <453A7D7E.8060105@utoronto.ca>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com>	<Pine.LNX.4.64.0610171605440.3962@g5.osdl.org>	<45357411.20500@utoronto.ca>	<200610180246.18758.jnareb@gmail.com>	<45357CC3.4040507@utoronto.ca>	<Pine.LNX.4.64.0610172014250.3962@g5.osdl.org>	<4536EC93.9050305@utoronto.ca>	<87lkncev90.wl%cworth@cworth.org>	<453792A8.1010700@utoronto.ca>	<878xjc2qeb.wl%cworth@cworth.org>	<453803E6.2060309@utoronto.ca>	<87ods727pn.wl%cworth@cworth.org>	<45382120.9060702@utoronto.ca> <87irie1wvv.wl%cworth@cworth.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@osdl.org>,
	Jakub Narebski <jnareb@gmail.com>,
	Andreas Ericsson <ae@op5.se>, bazaar-ng@lists.canonical.com,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 21 22:05:36 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GbN67-0002fu-9H
	for gcvg-git@gmane.org; Sat, 21 Oct 2006 22:05:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161012AbWJUUF2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 Oct 2006 16:05:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161025AbWJUUF2
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Oct 2006 16:05:28 -0400
Received: from server4.panoramicfeedback.com ([66.216.124.41]:34224 "EHLO
	server4.panoramicfeedback.com") by vger.kernel.org with ESMTP
	id S1161012AbWJUUF1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Oct 2006 16:05:27 -0400
Received: from server4.panoramicfeedback.com ([66.216.124.41] helo=[127.0.0.1])
	by server4.panoramicfeedback.com with esmtp (Exim 3.36 #1 (Debian))
	id 1GbN5s-0003jE-00; Sat, 21 Oct 2006 16:05:21 -0400
User-Agent: Thunderbird 1.5.0.7 (X11/20060922)
To: Carl Worth <cworth@cworth.org>
In-Reply-To: <87irie1wvv.wl%cworth@cworth.org>
X-Enigmail-Version: 0.94.0.0
X-Panometrics-MailScanner: Found to be clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29669>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Carl Worth wrote:
> On Thu, 19 Oct 2006 21:06:40 -0400, Aaron Bentley wrote:
>> I understand your argument now.
>>                                  It's nothing to do with numbers per se,
>> and all about per-branch namespaces.  Correct?
> 
> The entire discussion is about how to name things in a distributed
> system. The premise that Linus has put forth in a very compelling way,
> is that attempting to use sequential numbers for names in a
> distributed system will break down. The breakdown could be that the
> names are not stable, or that the system is used in a centralized way
> to avoid the instability of the names.

So I'd say that revnos without the context of a location can only refer
to the current branch that the user is working on.  They don't refer to
the mainline, which typically has its own numbers that don't match the
user's.

If you're saying that bzr is "centralized" in that the user's current
branch is special, then I'll say "guilty as charged".

> But it really is fundamental and unavoidable that sequential numbers
> don't work as names in a distributed version control system.

Right.  You need something guaranteed to be unique.  It's the revno +
url combo that is unique.  That may not be permanent, but anyone can
create one of those names, so it is decentralized.

>> I meant that the active branch and a mirror of the abandoned branch
>> could be stored in the same repository, for ease of access.
> 
> Granted, everything can be stored in one repository. But that still
> doesn't change what I was trying to say with my example. One of the
> repositories would "win" (the names it published during the fork would
> still be valid). And the other repository would "lose" (the names it
> published would be not valid anymore). Right?

No.  It would be silly for the losing side to publish a mirror of the
winning branch at the same location where they had previously published
their own branch.  So the old number + URL combination would remain valid.

If the losing faction decided to maintain their own branch after the
merge, they'd have two options

1. continue to develop against the losing "branch", without updating its
numbers from the "winning" branch.  It would be hard to tell who had won
or lost in this case.

2. create a new mirror of the "winning" branch and develop against that.
 I'm not sure what this point of this would be.

I think the most realistic thing in this scenario is that they leave the
"losing" branch exactly where it was, and develop against the "winning"
branch.

>> Bazaar encourages you to stick lots and lots of branches in your
>> repository.  They don't even have to be related.  For example, my repo
>> contains branches of bzr, bzrtools, Meld, and BazaarInspect.
> 
> Git allows this just fine. And lots of branches belonging to a single
> project is definitely the common usage. It is not common (nor
> encouraged) for unrelated projects to share a repository, since a git
> clone will fetch every branch in the repository.

Right.  This is a difference between Bazaar and Git that's I'd
characterize as being "branch-oriented" vs "repository-oriented".  We'll
see more of this below.

> I'm noticing another terminology conflict here. The notion of "branch"
> in bzr is obviously very different than in git. For example the bzr
> man page has a sentence beginning with "if there is already a branch
> at the location but it has no working tree". I'm still not sure
> exactly what a bzr branch is, but it's clearly something different
> from a git branch, (which is absolutely nothing more than a name
> referencing a particular commit object).

I got the impression there was also a local ordering of revisions.  Is
that wrong?

A Bazaar branch is a directory inside a repository that contains:
 - a name referencing a particular revision
 - (optional) the location of the default branch to pull/merge from
 - (optional) the location of the default branch to push to
 - (optional) the policy for GPG signing
 - (optional) an alternate committer-id to use for this branch
 - (optional) a nickname for the branch
 - other configuration options

A Bazaar branch doesn't contain any commit objects ("revisions" in
Bazaar parlance).  Those are retrieved from the containing repository.

It doesn't contain any working files, but a branch and a working tree
may coexist in the same directory.  Similarly, a branch and a repository
may coexist in the same directory.

So this is one common layout:

Repository:
~/repo/

Branch:
~/repo/branch

Working Tree:
~/workingtee

This is another common layout:

Repository:
~/

Branch:
~/mybranch

Working Tree
~/mybranch

This layout is our default, a "standalone tree":

Repository:
~/mybranch

Branch:
~/mybranch

Working Tree:
~/mybranch

This layout is an imitation of Git, as I understand it:
Repository:
~/repo

Branches:
~/repo/origin
~/repo/master

Workingtree
~/repo

> Second, I'm not comfortable
> with any limit on usefulness of history. Would you willingly throw
> away commits, mailing list posts, or closed bug reports older than any
> given age for any projects that you care about?

I think the mailing list posts age the best, because they provide a
record of rationales for design decsions.  But I'd throw away old
commits if there were a good reason, like lack of disk space.  Not so
sure about bug reports.

> Second, I think that using the filesystem for separating branches is a
> really bad idea. 

The canonical way to name branches in Bazaar is with URLs, though we
support file paths where possible.  Part of the "simple namespace" thing
is that branches are simply URLs, so in order to retrieve a branch, all
you need is one URL.

> One, it intrudes on my branch namespace, (note that
> in many commands above I have to use things like "../b" where I'd like
> to just name my branch "b". 

While "bzr merge ../b" is a minor inconvenience, I think that "bzr merge
http://bazaar-vcs.org/bzr/bzr.dev" is a big win.

> Two, it prevents bzr from having any
> notion of "all branches" in places where git takes advantage of it,
> (such as git-clone and "gitk --all").

No, it doesn't.  Bazaar can easily list all the branches in a
repository, just by starting with the repository root, and recursing
through all the subdirectories, looking for branches.

That said, we do have mentality that branches, not repositories, are
what's important to users in day-to-day use.

> Three, it certainly encourages
> the storage problem I ran into above, (and I'd be interested to see a
> "corrected" version of the commands above to fix the storage
> inefficiencies).

$ bzr init-repo bzrtest --trees
$ bzr init bzrtest/master; cd bzrtest/master
$ touch a; bzr add a; bzr commit -m "Initial commit of a"
$ bzr branch . ../b; cd ../b
$ touch b; bzr add b; bzr commit -m "Commit b on b branch"
$ echo "change" > b; bzr commit -m "Change b on b branch"
$ bzr branch ../master ../c; cd ../c
$ touch c; bzr add c; bzr commit -m "Commit c on c branch"
$ echo "change" > c; bzr commit -m "Change c on c branch"
$ cd ../master
$ bzr merge ../b; bzr commit -m "Merge in b"
$ bzr merge ../c; bzr commit -m "Merge in c"

> I hadn't realized that the dotted decimal notation was so new that the
> community hadn't had a lot of experience with it yet. But, your
> description doesn't actually presume that notation. What you asked
> was:
> 
> 	> When you create a new branch from scratch, the number starts at zero.
> 	> If you copy a branch, you copy its number, too.
> 	>
> 	> Every time you commit, the number is incremented.  If you pull, your
> 	> numbers are adjusted to be identical to those of the branch you pulled from.
> 	>
> 	> Is that really complicated?
> 
> And to answer. That description doesn't describe at all what happens
> to the "simple" numbers of commits that are merged.

Nothing happens to them, because they were never part of this branch, so
they didn't ever exist in this context.

> I still don't
> understand how people can avoid number changing, (since pull seems the
> only way to synch up without infinite new merge commits being added
> back and forth).

Why would anyone commit if the merge introduced no changes?

>> What's nice is being able see the revno 753 and knowing that "diff -r
>> 752..753" will show the changes it introduced.  Checking the revo on a
>> branch mirror and knowing how out-of-date it is.
> 
> With git I get to see a revision number of b62710d4 and know that
> "diff b62710d4^ b62710d4" will show its changes, though much more
> likely just "show b62710d4". I really cannot fathom a place where
> arithmetic on revision numbers does something useful that git revision
> specifications don't do just as easily. Anybody have an example for
> me?

My understanding is that ^ is treated as a special metacharacter by some
shells, which is why bzr revision specs are more long-winded.

> PS. The "bzr branch" of bzr.dev did eventually finish. I can see the
> dotted-decimal numbers in my example now, (1.1.1 and 1.2.2 for the
> commits that came from branch b; 1.2.1 and 1.2.2 for the commits that
> came from branch c). At 5 characters a piece these are well on their
> way to getting just as "ugly" as git names, (once it's all
> cut-and-paste the difference in ugliness is negligible).

Yeah, I'm not sure I like those dotted numbers, either.

> And now, I see it's not just pull that does number rewriting. If I use
> the following command (after the chunk of commands above):
> 
> 	cd ..; bzr branch -r 1.2.2 master 1.2.2

It's not number rewriting, it's number writing.  It doesn't change the
numbers in master, or any other existing branch.  (Push also does number
rewriting, because it's mostly the inverse of pull).

> It appears to just create newly linearized revision numbers from whole
> cloth for the new branch (1, 2, and 3 corresponding to mainline 1,
> 1.2.1, and 1.2.2). That's totally surprising, very confusing, and
> would invalidate any use I wanted to make of published revision
> numbers for the mainline branch while I was working on this branch.

I think the intent of those numbers was for operations like "diff".  I
never branch from a revision, always from a branch, which will preserve
numbers.

> See? This stuff really doesn't work.

Our experience really is that it does work.

> Is there even a way to say "show me the change introduced by what is
> named '1.2.1' in the source branch in this scenario" ?

The revno:branch notation ought to work, but I guess there's a bug.  Not
surprising, since dotted revnos are new in this release.

> > Note: In #bzr I just learned that there is a way for me to do this
> _if_ I also happen to have a pull of the original branch somewhere on
> my machine. 

This should work with any URL, not just locations on your machine.

> But with bzr if I find "1.2.1" somewhere I'm likely to type:

The problem here is the "somewhere".  Since each branch has its own
revno namespace, you need to know where to use the revno effectively.

Aaron
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFOn190F+nu1YWqI0RAn1nAKCDqT8gbzm/xIMjbc3kTFCkpMbJvwCeJiWr
3fLtDo4uLwtAWi+pQOrgPLU=
=0GeT
-----END PGP SIGNATURE-----
