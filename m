From: linux@horizon.com
Subject: Re: as promised, docs: git for the confused
Date: 9 Dec 2005 00:43:04 -0500
Message-ID: <20051209054304.3908.qmail@science.horizon.com>
References: <7vbqzrcmgr.fsf@assigned-by-dhcp.cox.net>
Cc: git@vger.kernel.org, linux@horizon.com
X-From: git-owner@vger.kernel.org Fri Dec 09 06:44:21 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ekb2c-0004DJ-2e
	for gcvg-git@gmane.org; Fri, 09 Dec 2005 06:43:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751287AbVLIFnM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 9 Dec 2005 00:43:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751288AbVLIFnM
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Dec 2005 00:43:12 -0500
Received: from science.horizon.com ([192.35.100.1]:61486 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S1751287AbVLIFnL
	(ORCPT <rfc822;git@vger.kernel.org>); Fri, 9 Dec 2005 00:43:11 -0500
Received: (qmail 3909 invoked by uid 1000); 9 Dec 2005 00:43:04 -0500
To: alan@chandlerfamily.org.uk, hpa@zytor.com,
	Josef.Weidendorfer@gmx.de, junkio@cox.net, pasky@suse.cz
In-Reply-To: <7vbqzrcmgr.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13413>

Thank you all for the comments.  I've tried to address them as follows:

junkip@cox.net wrote:
> I am unsure if we want to further confuse readers by saying
> this, but technically, "Likewise, a tag which is commit-ish can
> be used in place of commit".  Not all tags are necessarily
> commit-ish.  v2.6.11 tag is tree-ish but not commit-ish for
> example.  Typically, however, a tag is commit-ish.

Ah.  It makes me think of Ashford v. Thornton, but you're right, and worse
yet, it's part of the kernel history.  (But Linus could still re-issue the
tag and make it go away.  Are direct tags on trees considered desirable
these days?)

hpa@zytor.com added:
> Saying they can be used interchangably is just plain wrong, however. 
> It's not a bijective relation.

I amended it to:

+ The most common object needed by git primitives is a tree.  Since every
+ commit or tag refers to a unique tree, both of these are acceptable
+ "tree-ish" objects and can be used basically anywhere a tree is required.
+ Likewise, a tag almost always refers to a commit, so is "commit-ish"
+ and can be used where a commit is required.
+ 
+ (I'd say a tag *always* points to a commit, but it's possible to tag
+ a tree directly.  Probably the only time you will ever see this is
+ the v2.6.11 tag in the Linux history, because git was still under
+ heavy development and Linus was still making up the rules as he went
+ along.)

I wanted to keep the term "tree-ish", because it's actually widely
used in the git documentation.


alan@chandlerfamily.org.uk wrote:
>> * Background material.
>>
>> To start with, read "man git".  Or Documentation/git.txt in the git
>> source tree, which is the same thing.  Particularly note the description
>> of the index, which is where all the action in git happens.
>>
>> One thing that's confusing is why git allows you to have one version of
>> a file in the current HEAD, a second version in the index, and possibly a
>> third in the working directory.  Why doesn't the index just contain a copy
>> of the current HEAD until you commit a new one?  The answer is merging,
>> which does all its work in the index.  Neither the object database nor
>> the working directory let you have multiple files with the same name.
>
> If I was a complete newbie, I would be lost right here.  You start
> refering to the term HEAD without any introduction to what it means and
> (as far as I could see on a quick glance - which is what a newbie would
> do - man git doesn't start out here either).
> 
> If your audience really is a complete new commer, then as a minimum I
> think you need  to describe to concept of a "branch of development" with
> a series of snapshots of the state, the current of which is called HEAD.
> You might even at this stage hint about there being several such branches.
> The next bit, which goes on about the index is great - just put it into
> context with a simple explanation first.

First of all, this is a summary of what I found unclear *after* having
read all the documentation, tutorials, etc. I could find.  The business
of HEAD isn't that bad.

I actually wrote a bunch of text explaining the usual basics, but
then realized that the existing docs did the job as well or better,
and deleted it all.

If people think I should try to supplant the existing tutorials and
kernel hacker's guides instead of supplementing them, I could try,
but I found them very good once I had the background to understand them.

However, the comment is still valid: I don't introduce the term, and should.
(Getting exposition out of order is a big hazard of cut-and-paste.)

I've replaced that with:
+ To start with, read "man git".  Or Documentation/git.txt in the git
+ source tree, which is the same thing.  Particularly note the description
+ of the index, which is where all the action in git happens.
+ This document is to supplement that, not replace it.
+ 
+ Like other version control systems, git has a current version (referred
+ to as HEAD) in its object database, you make changes in the working
+ directory, and then commit them, which appends a new version and makes
+ that the new HEAD.
+ 
+ However, there's also this "index" thing interposed.  As "man git"
+ explains, you can have one version of the file in the HEAD, a second
+ in the index, and a third in the working directory.  That's weird
+ and confusing - why does git allow that?  Why isn't the index just an
+ implementation detail that caches the HEAD until you commit a new one?
+ 
+ The answer is merging, which does all its work in the index.  Being a
+ toolkit, git has to pass partial merges around between its various
+ tools, which means keeping track of multiple files all competing for
+ the same name.  Neither the object database nor the working directory
+ let you have multiple files with the same name.

Is that any better?


Josef.Weidendorfer@gmx.de wrote, about git-mv:
> The nice thing about it is that you can move huge directories around,
> or multiple files/dirs at once, and it will do the right thing. E.g.
> 	git-mv -k foo* bar/
> will only move files which are version controlled.

Er... this seems to require a mix of files where the version-controlled
status is not defined by a naming convention.  Isn't that pretty unusual?

> It is actually a 3-step process: rename, delete old, add new.
> Perhaps it should be noted that this has nothing to do with any
> explicit renaming feature like in other SCMs.

The "delete old" (from the index) part is taken care of by git-commit.
I refer to the need to commit the old and new names, but a common
"git-commit -a" will take care of that, and any other edits that
have been made in the meantime.

As I just added to the git-update-index description:
+ 	A lot of early git documentation emphasizes this command,
+ 	since you need to have modified files in the index before you
+ 	can generate tree and commit objects.  But this is done by
+ 	git-commit, and you rarely want to invoke git-update-index
+ 	directly any more.


Finally, pasky@suse.de wrote:
> That said, the "git for the confused" contains a lot of nice points, but
> I don't think it's a good approach to just have extra document for
> clarifying this stuff. It would be much better if the stock
> documentation itself would not be confusing in the first place. Same
> goes for the "commands overview" (BOUND to get out-of-date over time
> since it's detached from the normal per-command documentation; we have
> troubles huge enough to keep usage strings in sync, let alone the
> manpages).

I don't think it's the ideal solution either, but the idea of trying to
supplant Linus' tutorial is a bit alarming given my current still-novice
state.  I've been dabbling with git for a few weeks; many of the people
on this list have been using git in earnest for most of its life.

Unfortunately, given the number of commands, you can't just document
them well individually.  Some overview of how they fit together into
a system is required.

As for keeping things in sync...
The problem with the usage strings and man pages is that they aim to
describe everything, so omitting the latest minor feature is a bug.
I'm not trying to document every detail of every command, just tell people
enough that they can figure out which man page they should be reading.
Surely the basic purpose of the existing commands isn't going to undergo
too much more upheaval?

I do confess some of the docs are rather dated.  One issue, that I just
added a paragraph about, is that they emphasize git-update-index a lot,
while I think these days that's normally invoked via git-commit.
