From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [RFC] pull/fetch rename
Date: Wed, 21 Oct 2009 13:12:59 -0400 (EDT)
Message-ID: <alpine.LNX.2.00.0910211203230.14365@iabervon.org>
References: <200910201947.50423.trast@student.ethz.ch> <alpine.LNX.2.00.0910201912390.14365@iabervon.org> <20091021030608.GA18997@atjola.homenet> <alpine.LNX.2.00.0910202310070.14365@iabervon.org> <20091021115740.GA25049@atjola.homenet>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1547844168-1522354460-1256145116=:14365"
Cc: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: =?ISO-8859-15?Q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Wed Oct 21 19:13:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N0ekE-0003PM-W9
	for gcvg-git-2@lo.gmane.org; Wed, 21 Oct 2009 19:13:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754525AbZJURM4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Oct 2009 13:12:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754506AbZJURM4
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Oct 2009 13:12:56 -0400
Received: from iabervon.org ([66.92.72.58]:36238 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754479AbZJURMz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Oct 2009 13:12:55 -0400
Received: (qmail 16359 invoked by uid 1000); 21 Oct 2009 17:12:59 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 21 Oct 2009 17:12:59 -0000
In-Reply-To: <20091021115740.GA25049@atjola.homenet>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Content-ID: <alpine.LNX.2.00.0910211312560.14365@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130940>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1547844168-1522354460-1256145116=:14365
Content-Type: TEXT/PLAIN; CHARSET=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Content-ID: <alpine.LNX.2.00.0910211312561.14365@iabervon.org>

On Wed, 21 Oct 2009, Björn Steinbrink wrote:

> On 2009.10.21 00:22:18 -0400, Daniel Barkalow wrote:
> > On Wed, 21 Oct 2009, Björn Steinbrink wrote:
> > 
> > > 3) User expects "pull" to update all branch heads that have a configured
> > > upstream
> > > 
> > > 08:31 	dimsuz 	hi guys! suppose i'm currently on master. then run git
> > > 		fetch. which delivers updates to master and other
> > > 		branches. I don't merge anything, but do checkout some
> > > 		branch (which is not master).  Question: will these new
> > > 		updates get into this branch automatically after i check
> > > 		it out? question2: will branch master contain those
> > > 		updates when i ckeck it out later?
> > > 08:32 	Circuitsoft 	dimsuz. After a fetch, no.
> > > 08:33 	Circuitsoft 	However, if you pull, any branches that were set
> > > 			up as local tracking branches will get updated.
> > > 08:33 	Circuitsoft 	Otherwise, only remote tracking branches will be
> > > 			updated.
> > > 
> > > http://colabti.de/irclogger/irclogger_log/git?date=2009-10-20#l969
> > > (No idea about that one, have seen that once before, but it's definitely
> > > not even remotely as common as the others)
> > 
> > I'd guess that's due to having local branches with no local changes, just 
> > to avoid detached HEAD, and therefore thinking it's normal to have a bunch 
> > of local branches that could be updated without merges. But I'm on a crazy 
> > "everybody really wants detached HEAD and is needlessly scared" kick, and 
> > I'm probably reading too much into it.
> 
> Just to clarify: I didn't mean the question (which I didn't really
> understand) in this case, but the answer from Circuitsoft (second to
> last line). But maybe you also meant that? The question confuses me
> enough not to be able to follow.

Yeah. I think that Circuitsoft, and a lot of the people in these 
conversations, have local branches they never commit to, and only update 
with pull, and only use the --track feature to maintain these branches, 
and may not even ever use "git pull" for anything other than to maintain 
these branches. That would give the impression that "git pull" always 
leaves the current branch holding the commit that the remote branch is 
holding (i.e., "reset --hard") and the guess that this could apply to 
non-current branches.

But these local branches don't actually give the users any benefit, 
because they're always the same as the ref in remotes/ unless they're 
out-of-date.

> > > 4) User expects "pull" to create branches
> > > 
> > > 07:25 	fynn 	Hey, I just pulled a branch from remote, and I don't see
> > > 		it in "git branch"
> > > 07:25 	doener 	fynn: if you "pull" that means "fetch this and merge it
> > > 		to what I have checked out"
> > > 07:25 	fynn 	doener: hm, I just did "git pull" and it showed the new
> > > 		branch
> > > 07:26 	fynn 	but I don't see it in my branches...
> > > 07:26 	fynn 	doener: should I create that branch as a tracking branch
> > > 		first?
> > > 07:26 	doener 	fynn: you're looking at "git branch -r" or "git branch
> > > 		-a", right?
> > > 07:26 	fynn 	doener: yeah, I'm seeing it in origin/foo, but not
> > > 		local.
> > > 07:26 	doener 	fynn: the "git fetch" should have created a remote
> > > 		tracking branch, as usual, not a local branch head
> > > 		(which would be shown by just "git branch")
> > > 07:27 	fynn 	doener: OK, what should I do to create it locally then?
> > > 07:28 	doener 	fynn: just the usual "git branch foo origin/foo", or to
> > > 		checkout at the same time: "git checkout -b foo
> > > 		origin/foo" or "git checkout -t origin/foo" (shortcut)
> > > 
> > > http://colabti.de/irclogger/irclogger_log/git?date=2009-10-19#l830
> > > (Note how my "fetch this and merge it" is actually inaccurate for just
> > > "git pull", there is no "this" and that case. I took "pulled a branch"
> > > to mean that he did "git pull <remote> <branch>", which wouldn't have
> > > created/update the remote tracking branch [or did patches for that go
> > > in? I lost track...])
> > 
> > That sounds like a real converse of "push", including creating like-named 
> > local branches. Or, perhaps, this is someone expecting that "pull" is like 
> > "clone" in creating an initial local branch with the name and value of a 
> > specified remote branch.
> 
> Reading that one again, I realize that I've still been confused by the
> "pulled a branch". What happened was that the user did "git pull", which
> ran "git fetch <remote>", which fetched a new branch head and has shown
> that. At that point, the user (and me) got confused for maybe two reasons:
> 
> a) He didn't clearly distinguish between the fetch and the merge part.
> The new branch wasn't pulled, but just fetched. That caused the user to
> think that he "pulled the branch" (wrong terminology), which in term
> confused me (wrong use-case assumed).

Right; when pull shows a branch, it's the fetching step. But I think that 
shouldn't have been confusing to you; the merging step certainly doesn't 
show anything interesting.

> b) He expected local branch heads to be created, instead of remote
> tracking branches. If my memory doesn't play tricks on me, that's
> actually not to be expected from that specific user (I think we told him
> about remote tracking branches before, and the last part of the
> conversation actually suggests that, too). If I don't forget, I'll try
> to get feedback from him the next time he's around.

He seems to get the thing about remote tracking branches (he says that got 
created); he's fine on the "pull = fetch + (X)" portion, but he's got (X) 
wrong, and thinks that creates a local branch.

That's why I think he may be confused by clone's behavior, because clone 
does: (create a repo), fetch something, and create a co-named local 
branch. If clone were init + pull (wrong, but a reasonable guess), then 
clone - init = fetch + checkout -b; so I think he's not totally lost but 
rather just wrong about what compound operations "pull" is.

> > > 5) User possibly expecting "pull" to be able to act as "reset --hard"
> > > 
> > > 21:01 	aidan 	What do I do about this: html/config/core.php: needs
> > > 		update
> > > 21:02 	aidan 	git pull (gives that)
> > > 21:02 	Ilari 	aidan: You have uncommitted changes to that file...
> > > 21:15 	aidan 	Ilari: how can I just pull master and overwrite any
> > > 		changes?
> > > 
> > > http://colabti.de/irclogger/irclogger_log/git?date=2009-10-18#l2130
> > > (I'm not sure about that one, "overwrite any changes" might mean "drop
> > > uncommitted changes and merge" or "just get me the remote's state,
> > > dropping my commits and uncommitted changes". Most of the time I've seen
> > > similar requests, the user wanted the latter).
> > 
> > So I think that's a desire for "git checkout ." first of all (with the 
> > assumption that the content without modifications has to come from 
> > somewhere remote). I don't know what's up with people not wanting to save 
> > their commits, though.
> 
> You haven't seen the multitude of "I have merge conflicts and just want
> to take theirs/mine" requests. That often gets more weird than just
> "drop my commits" ;-)

Ah, okay; I tend to think of those as content-focused, rather than 
history-focused. Like, I think people often run into: "I reformatted files 
A and B and made important changes to file A; someone else made important 
changes to file B; I get a awful merge conflict in file B." I bet it's 
common to want to keep your commit history, but throw away their 
conflicting changes in the resulting content.

There's also the occasional case where the right solution is to rename a 
branch to "things-that-seemed-like-a-good-idea-at-the-time", create a new 
branch from upstream with the old name, and never speak of it again.

But this is all a different topic.

> > > 6) User says "pull" but probably means "fetch"
> > > 
> > > 14:08 	Alien_Freak 	once I have a clone of a repo I know you can do
> > > 			a checkout tag but is there anyway to pull just
> > > 			the tag?
> > > 
> > > http://colabti.de/irclogger/irclogger_log/git?date=2009-10-16#l1664
> > > (There was no answer, thus it's hard to tell, but I guess he wanted
> > > something like:
> > > git init; git fetch --no-tags url tag <tag>; git checkout <tag>
> > > At least I'm quite sure he didn't mean "pull" as in "git pull")
> > 
> > I don't know; you can actually do:
> > 
> > $ git init; git pull --no-tags <url> tag <tag>
> > 
> > It updates the master branch and working directory from (nothing) to the 
> > fetched tag.
> 
> Hm, yeah, that works (didn't think of it), but it's a rather special
> case. Teaching that might lead to misunderstandings about what "pull"
> does, I think. It would look somewhat like "fetch + reset --hard".

Well, "merge" looks like "reset --hard" any time it's a fast forward.

I don't think this is a good thing to teach, but if the answer to what the 
user wants to do when saying "How can I just pull a tag in a single 
command" is "pull tag <foo>", it's hard to say that's a misuse of the 
term.

> > > 8) "reset --hard" again
> > > 
> > > 20:10 	roger_padactor 	i commited then did a pull how do i get back to
> > > 			my commit. the pull over wrote the files
> > > 20:11 	merlin83 	roger_padactor: you can't, pull == fetch + hard
> > > 			reset to latest commit
> > > 
> > > http://colabti.de/irclogger/irclogger_log/git?date=2009-10-14#l2306
> > > (Someone being told that pull is fetch + reset --hard is actually new to
> > > me. Only saw that as an expectation previously.)
> > 
> > That's odd. How could you not notice that it doesn't actually do that, 
> > even if you try to get it to?
> 
> Hm? roger_padactor noticed that "pull" changed his files and wants to go
> back. And merlin83 says that that is impossible because pull supposedly
> does reset --hard. There's nothing in there (I could see) that suggests
> that anyone tried to make "pull" do "reset --hard".

I'm surprised that merlin83 can think that pull = fetch + reset --hard; 
people often seem to try to do fetch + reset --hard with pull, but it 
doesn't actually work for them. 

> merlin83 basically made three mistakes, I think:
> 1) Assume that roger_padactor was talking about uncommitted changes
> 2) Assume that pull is fetch + reset --hard
> 3) Assume that you can't undo a reset --hard for committed changes
> 
> (OK, 3) isn't actually valid when you consider 1), but 1) is so invalid
> that I kept 3). After all, "pull" would complain about a dirty tree...)
> 
> 
> > Actually, I wonder if the right formula is update = fetch + checkout. 
> > There are a lot of people (IMHO) want "git fetch origin; git checkout 
> > origin/master", and I think their first idea is "git update", but that 
> > doesn't exist, and they find "pull" as the closest thing.
> 
> That has a precondition that the user is already using a detached HEAD.
> Otherwise that fetch + checkout would likely mean that the get baffled
> when they do:
> git checkout master
> git update
> git checkout foo
> git checkout master
> 
> Seeing that "master" is out of date "again".

Agreed; I think:

$ git checkout master
$ git update
You are on a local branch. Local branches are under your complete control, 
so there is nowhere to get updates from. If you would like to merge remote 
commits into your local branch, you could use "git pull". If you would 
rather look at a remote branch, you could use "git checkout <some 
plausible remote branch>".

Of course, without this message:

$ git checkout master
$ git update

would be the same as:

$ git chekcout master
$ git fetch
$ git checkout master

which would already not show any changes. (I'm thinking of the target of 
the checkout in update-with-no-target as being whatever you typed last 
time, and the fetch being whatever fetch normally updates that target.)

Personally, I often run:

$ git fetch; git checkout origin/next

This suggests that this is a useful combination of commands.

> I agree though, that users might look for "git update" and because it is
> missing, they just look for the closest thing. Adding Junio's statement
> that users seem to want recipes instead of flexibility (and seeing
> "update" as just "get me new stuff from upstream" without meaning any
> specific method of updating), I think that "git update" could be a "recipe
> collection" tool. I'll hack that into my proof-of-concept thing (which
> I hope to have ready for a RFC next week).

I'll be interested to see that.

	-Daniel
*This .sig left intentionally blank*
--1547844168-1522354460-1256145116=:14365--
