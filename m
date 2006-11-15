X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Nicolas Pitre <nico@cam.org>
Subject: Re: Cleaning up git user-interface warts
Date: Tue, 14 Nov 2006 23:32:06 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0611142048350.2591@xanadu.home>
References: <87k61yt1x2.wl%cworth@cworth.org> <455A1137.8030301@shadowen.org>
 <87hcx1u934.wl%cworth@cworth.org>
 <Pine.LNX.4.64.0611141518590.2591@xanadu.home>
 <87bqn9u43s.wl%cworth@cworth.org> <7vr6w5y7to.fsf@assigned-by-dhcp.cox.net>
 <7virhhy76h.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
NNTP-Posting-Date: Wed, 15 Nov 2006 04:32:20 +0000 (UTC)
Cc: git@vger.kernel.org, Andy Whitcroft <apw@shadowen.org>,
	Carl Worth <cworth@cworth.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-reply-to: <7virhhy76h.fsf@assigned-by-dhcp.cox.net>
X-X-Sender: nico@xanadu.home
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31412>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GkCRZ-0001vc-W8 for gcvg-git@gmane.org; Wed, 15 Nov
 2006 05:32:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S966585AbWKOEcJ (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 14 Nov 2006
 23:32:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966586AbWKOEcJ
 (ORCPT <rfc822;git-outgoing>); Tue, 14 Nov 2006 23:32:09 -0500
Received: from relais.videotron.ca ([24.201.245.36]:26687 "EHLO
 relais.videotron.ca") by vger.kernel.org with ESMTP id S966585AbWKOEcI (ORCPT
 <rfc822;git@vger.kernel.org>); Tue, 14 Nov 2006 23:32:08 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005)) with ESMTP id
 <0J8R00IHE8LICO50@VL-MH-MR002.ip.videotron.ca> for git@vger.kernel.org; Tue,
 14 Nov 2006 23:32:07 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

On Tue, 14 Nov 2006, Junio C Hamano wrote:

> Junio C Hamano <junkio@cox.net> writes:
> 
> >  - I think it would be sensible to make remote tracking branches
> >    less visible.  For example:
> >...
> >  - "git merge" to merge another branch into the current would
> >    make sense.  "git pull . remotes/origin/next" is showing too
> >    much implementation detail.  It should just be:
> >
> > 	git merge origin#next
> 
> This and other examples in "making remote tracking branches less
> visible" are hard to read because I used the word "origin" in
> two different sense.  So here is a needed clarification.
> 
> If you have remotes/upstream that says:
> 
> 	URL: git://git.xz/repo.git
>         Pull: refs/heads/master:remotes/origin/master
>         Pull: refs/heads/next:remotes/origin/next
> 
> Then, currently the users need to say:
> 
> 	git diff remotes/origin/master
>         git merge remotes/origin/next
> 
> By "making tracking branches less visible", what I mean is to
> let the users say this instead:
> 
> 	git diff upstream
>         git merge upstream#next

What is the point of hiding tracking branches?  Why just not making them 
easier to use instead?  There are currently so many ways to specify 
remote branches that even I get confused.

OK..... let's pretend this is my follow-up to your "If I were redoing 
git from scratch" query.  Actually I would not redo it from scratch 
since the vast majority of it is rather sane already.  But here's some 
changes that I would do:

1) make "git init" an alias for "git init-db".

What's the point of "-db"?  Sure we're initializing the GIT database.  
But who cares?  The user doesn't care if GIT uses a "database" or 
whatever.  And according to some people's definition of a "database" it 
could be argued that GIT doesn't use a database at all in the purist 
sense of it. What the user wants is to get started and "init" (without 
the "-db" is so much more to the point. Doesn't matter if incidentally 
it happens to be the same keyword HG uses for the same operation because 
we are not afflicted by the NIH disease, right? And it has 3 chars less 
to type which is for sure a premium improvement to the very first GIT 
user experience!

2) "pull" and "push" should be symmetrical operations

They are symmetrical in the dictionary and in people's mind.  OK but what 
if I merge content from another _local_ branch into the current one?  
Isn't that kind of a pull as well?  Answer: NO IT IS NOT!  Reason: 
because we already have "merge" for that very operation for damn sake!  
And because "merging" isn't a synonym for "pulling" at all, we cannot 
pretend it should sort of become more true if taken the other way 
around.

Actually, if we _merge_ stuff together, we certainly have to /pull/ some 
of it, meaning that "merge" might imply a "pull", even in real life 
situations outside of the GIT context (think merging Vodka and Kahlua in 
a glass where you might have to pull the Vodka bottle out of the freezer 
before you can merge it). And thankfully we got it right with git-merge 
which can take either a branch or an URL as argument which in the later 
case will perform a pull implicitly (OK currently a fetch but you know 
what I mean).

But trying to put in people's head that "pulling" implies a "merge"?  No 
that doesn't work really well.  OK if you pull too hard on the Vodka 
bottle that might imply a merge at some point but it would certainly be 
accidental.  And it is not without coincidence that some people had 
accidental GIT merges by using git-pull.

Conclusion:  git-pull must not perform any merge.  It is the symmetrical 
operation of a push meaning that it pulls content from a remote branch 
and does no more.  People understands that pretty well, .  This makes 
git-fetch redundant (or an alias to git-pull) in that case, and again we 
don't mind it becoming similar to in HG because we admit HG was right 
about it.

3) remote branch handling should become more straight forward.

OK! Now that we've solved the pull issue and that everybody agrees with 
me (how can't you all agree with me anyway) let's have a look at remote 
branches.  It should be simple:

a)	git-pull git://repo.com/time_machine.git

This pulls every branches from the time_machine.git repository and 
create identically named branches locally, except for the remote 
master becoming origin locally.  All those branches are marked read-only 
(i.e. cannot commit to them) and _each_ of those branches get an URL 
associated to them somehow (the association is an implementation 
detail).

If then you do:

b)	git-pull origin

Then it will pull the git://repo.com/time_machine.git:master branch into 
the local "origin" branch.  IOW, local tracking branches becomes 
synonyms for their remote URLs after they've been pulled once.  If the 
remote branch "next" became a local "next" with the first pull (because 
it didn't specify any branch meaning that they were all pulled), doing 
a:

c)	git-pull next

would actually be the same as:

d)	git-pull git://repo.com/time_machine.git:next

Now to have different remote and local names for those tracking 
branches:

e)	git-pull git://repo.com/time_machine.git:master upstream

would be a variation where a remote branch gets a different local name. 
This pulls the remote master branch but calls it "upstream" locally.  
If that "upstream" branch does exist locally already then fail with 
appropriate error message, unless the local branch happens to have the 
same URL attribute already.  You then have two local branches tracking 
the same remote branch which is weird but still fine if someone wants
to have different views (today's pull and yesterday's pull).  This is 
not necessarily something to encourage but only a fallout of the branch 
semantic.  And again a simple:

f)	git-pull upstream

would update the "upstream" branch from the remote master branch.

I think the concept of "branch group" should be preserved too.  So if 
you create a group called "warp", then add "origin", "next", and 
"upstream" to it, then:

g)	git-pull warp

would pull all the included branches.  One way to create a branch group 
with the initial pull is not to specify the remote branch but only the 
repository URL, like:

h)	git-pull git://repo.com/time_machine.git warp

Because no specific branch in the remote repository was specified just 
like in (a) then all branches are pulled, but because a local name was 
provided then this becomes a branch group.

Branch groups could be used to extend the branch namespace as well to 
avoid clashes with different remote repositories.  In this case the 
branch groups could be a way to arrange branches in a hierarchy so 
"warp" refer to all branches included in the warp group while 
"warp/upstream" refer to only one branch. In this case "upstream" and 
"warp/upstream" would be the same branch if "upstream" was effectively 
added to the "warp" group, but it doesn't need to be so.  And branches 
in a group don't have to come from the same remote repository either 
since the source of each branch (the URL) is a per branch attribute.

To make it "easy" on the user, I think that any branch (or tag) down the 
hierarchy should be used without the "path" leading to it if there is no 
conflict.  We already do that with heads and tags, So if for example the 
"warp" group contained a branch named "lightspeed" but no such branch 
(or tag) existed anywhere else then it could be referenced with simply 
"lightspeed" or "warp/lightspeed".

Then you don't need any strange scheme for diff and merge.  Just using 
"git-diff upstream" or "git-merge origin next" suffice.  Oh and I don't 
think it would be a good idea to have a completely separate namespace 
for local vs remote aka tracking branches.  Maybe in .git/refs/ they 
should be separate to distinguish which ones are read-only remote 
tracking ones and which ones are local, but that must not be forced on 
the UI.

Thinking about it some more, maybe (a) should create a default branch 
group if the remote repository has more than one branches, say "origin".  
This way, git-pull without any argument would be the same as 
"git-pull origin" by default.  If "origin" is a single branch then 
(git-pull" would pull only one branch, but if "origin" is a branch group 
then all included branches would be pulled.

This becomes formalized as:

	git_pull [<URL>] [<local_name>]

If <URL> includes a branch name then <local_name> is a single branch 
name.  If <URL> doesn't include any branch name then <local_name> 
becomes a local branch group name containing all branches in the remote 
repository. If <URL> is specified but not <local_name> then <local_name> 
is set to "origin" by default, unless it already exists in which case it 
is an error and the pull fails.  If <URL> is not specified then the URL 
attribute to the specified branch(es) is used.  If nothing is specified 
then "origin" is used for <local_name> by default and URL attribute of 
the origin branch or the origin branch group is/are used.

*****

OK I think this is enough for now. I know that parts of what I've said 
can already be found in GIT, but I wanted the explanation to be 
complete and therefore tentatively coherent.


