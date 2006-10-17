From: Andreas Ericsson <ae@op5.se>
Subject: Re: VCS comparison table
Date: Tue, 17 Oct 2006 09:50:54 +0200
Message-ID: <45348B5E.8000404@op5.se>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com> <egr3ud$nqm$1@sea.gmane.org> <45340713.6000707@utoronto.ca> <Pine.LNX.4.64.0610161625370.3962@g5.osdl.org> <45345AEF.6070107@utoronto.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@osdl.org>,
	Jakub Narebski <jnareb@gmail.com>,
	bazaar-ng@lists.canonical.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 17 09:51:11 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GZjj7-0005Qw-Nn
	for gcvg-git@gmane.org; Tue, 17 Oct 2006 09:51:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932092AbWJQHu7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Oct 2006 03:50:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932220AbWJQHu6
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Oct 2006 03:50:58 -0400
Received: from linux-server1.op5.se ([193.201.96.2]:55010 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S932092AbWJQHu6
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Oct 2006 03:50:58 -0400
Received: by smtp-gw1.op5.se (Postfix, from userid 588)
	id 9A9176BDE1; Tue, 17 Oct 2006 09:50:56 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.1.4 (2006-07-25) on 
	linux-server1.op5.se
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=5.0 tests=AWL,BAYES_00 autolearn=ham 
	version=3.1.4
Received: from [192.168.1.20] (unknown [213.88.215.14])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id 52F1A6BDE0; Tue, 17 Oct 2006 09:50:54 +0200 (CEST)
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
To: Aaron Bentley <aaron.bentley@utoronto.ca>
In-Reply-To: <45345AEF.6070107@utoronto.ca>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29031>

Aaron Bentley wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Linus Torvalds wrote:
>> On Mon, 16 Oct 2006, Aaron Bentley wrote:
>>> Bazaar's namespace is "simple" because all branches can be named by a
>>> URL, and all revisions can be named by a URL + a number.
> 
>> I pretty much _guarantee_ that a "number" is not a valid way to uniquely 
>> name a revision in a distributed environment, though. I bet the "number" 
>> really only names a revision in one _single_ repository, right?
> 
> Right.  That's why I said all revisions can be named by a URL + a
> number, because it's the combination of the URL + a number that is
> unique.  (In bzr, each branch has a URL.)
> 

The revision will change between different repos though, so 
random-contributor A that doesn't have his repo publicised needs to send 
patches and can't log his exact problem revision somewhere, which makes 
it hard for random contributor B that runs into a similar problem but on 
a different project sometime later to find the offending code. I prefer 
the git way, but I'm a git user and probably biased.

That said, it shouldn't be impossible to add fixed, user-friendly 
bazaar-like revision numbers for git. We just have to reverse the
<committish>[^~]<number> syntax to also accept <committish>+<number>.

This would work marvelously with serial development but breaks horribly 
with merges unless the first (or last) commit on each new branch gets 
given a tag or some such.

Either way, I'm fairly certain both bazaar and git needs to distribute 
information to the user in need of finding the revision (which url and 
which number vs which sha). I also imagine that the bazaar users, just 
like the git users, are sufficiently apt copy-paste people to never 
actually read the prerequisite information.

> 
>> If you give 
>> the SHA1 name, it's well-defined even between different repositories, and 
>> you can tell somebody that "revision XYZ is when the problem started", and 
>> they'll know _exactly_ which revision it is, even if they don't have your 
>> particular repository.
> 
> When two people have copies of the same revision, it's usually because
> they are each pulling from a common branch, and so the revision in that
> branch can be named.  Bazaar does use unique ids internally, but it's
> extremely rare that the user needs to use them.
> 

Well, if two people have the same revision in git, you *know* they have 
pulled from each other, because ALL objects are immutable. The point of 
"naming" the revision is moot, because it's something all SCM's can do.


>> Now _that_ is true simplicity. It does automatically mean that the names 
>> are a bit longer, but in this case, "longer" really _does_ mean "simpler".
>>
>> If you want a short, human-readable name, you _tag_ it. It takes all of a 
>> hundredth of a second to to or so.
> 
> But tags have local meaning only, unless someone has access to your
> repository, right?
> 

I imagine the bazaar-names with url+number only has local meaning unless 
someone has access to your repository too. One of the great benefits of 
git is that each revision is *always exactly the same* no matter in 
which repository it appears. This includes file-content, filesystem 
layout and, last but also most important, history.


>>>> About "checkouts", i.e. working directories with repository elsewhere:
>>>> you can use GIT_DIR environmental variable or "git --git-dir" option,
>>>> or symlinks, and if Nguyen Thai Ngoc D proposal to have .gitdir/.git
>>>> "symref"-like file to point to repository passes, we can use that.
>>> It sounds like the .gitdir/.git proposal would give Git "checkouts", by
>>> our meaning of the term.
>> Well, in the git world, it's really just one shared repository that has 
>> separate branch-namespaces, and separate working trees (aka "checkouts"). 
>> So yes, it probably matches what bazaar would call a checkout.
> 
> The key thing about a checkout is that it's stored in a different
> location from its repository.  This provides a few benefits:
> 
> - - you can publish a repository without publishing its working tree,
>   possibly using standard mirroring tools like rsync.
> 

Can't all scm's do this?

> - - you can have working trees on local systems while having the
>   repository on a remote system.  This makes it easy to work on one
>   logical branch from multiple locations, without getting out of sync.
> 

This I'm not so sure about. Anyone wanna fill out how shallow clones and 
all that jazz works?

> - - you can use a checkout to maintain a local mirror of a read-only
>   branch (I do this with http://bazaar-vcs.com/bzr/bzr.dev).
> 

Check. Well, actually, you just clone it as usual but with the --bare 
argument and it won't write out the working tree files.

>> Almost nobody seems to actually use it that way in git - it's mostly more 
>> efficient to just have five different branches in the same working tree, 
>> and switch between them. When you switch between branches in git, git only 
>> rewrites the part of your working tree that actually changed, so switching 
>> is extremely efficient even with a large repo.
> 
> You can operate that way in bzr too, but I find it nicer to have one
> checkout for each active branch, plus a checkout of bzr.dev.  Our switch
> command also rewrites only the changed part of the working tree.
> 

Works in git as well, but each "checkout" (actually, locally referenced 
repository clone) gets a separate branch/tag namespace.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
