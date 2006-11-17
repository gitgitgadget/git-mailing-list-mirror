X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: [DRAFT] Branching and merging with git
Date: Fri, 17 Nov 2006 13:21:57 -0500
Message-ID: <20061117182157.GC11882@fieldses.org>
References: <20061116221701.4499.qmail@science.horizon.com> <20061117153246.GA20065@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Fri, 17 Nov 2006 18:22:16 +0000 (UTC)
Cc: linux@horizon.com, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <20061117153246.GA20065@thunk.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31722>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gl8Ll-0008Bd-VX for gcvg-git@gmane.org; Fri, 17 Nov
 2006 19:22:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1750732AbWKQSWB (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 17 Nov 2006
 13:22:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751893AbWKQSWB
 (ORCPT <rfc822;git-outgoing>); Fri, 17 Nov 2006 13:22:01 -0500
Received: from mail.fieldses.org ([66.93.2.214]:5102 "EHLO
 pickle.fieldses.org") by vger.kernel.org with ESMTP id S1750732AbWKQSWA
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 17 Nov 2006 13:22:00 -0500
Received: from bfields by pickle.fieldses.org with local (Exim 4.63)
 (envelope-from <bfields@fieldses.org>) id 1Gl8Ld-0005I8-NR; Fri, 17 Nov 2006
 13:21:57 -0500
To: Theodore Tso <tytso@mit.edu>
Sender: git-owner@vger.kernel.org

On Fri, Nov 17, 2006 at 10:32:46AM -0500, Theodore Tso wrote:
> Personally, I think this information is actually more important to an
> end-user than the current "part two" of the tutorial, which discusses
> the object database and the index file.  Perhaps this should be "part
> 2", and the object database and index file should become "part 3"?  

Yeah, the really difficult problem here is figuring out how to organize
the documentation.  There are a few needs:

	1. Quick-start/task-based documentation
		- We want to "sell" git to the beginning user by getting
		  them up and running as quickly as possible.
		- We need to help people with some limited needs--
		  testers who just need to download the latest linux git
		  tree, or bisect, or whatever.
		- It's also a fun way to demonstrate the richness of
		  some git features (e.g. history explanation).
	2. Conceptual background
		- People need to understand the commit graph, branches,
		  merging, the index file (gack), pack files, etc.--some of
		  that can be put off a little while, some of it can't.
	3. Reference documentation

The man pages do most of #3, but maybe they could be better organized--I
think people aren't finding stuff there that they should be.

Numbers 1 and 2 are scattered around git(7), the two-part tutorial, the
git-core tutorial, etc.

> It might also be a good to consider moving some of the "discussion"
> portion the top-level git(7) man page into the object database and
> index file discussion.  Right now, the best way to introduce git's
> concepts (IMHO), is to start with the part 1 of the tutorial, then go
> into the your draft branch/merging with git, then the current part 2
> of the tutorial, and then direct folks to read the "discussion"
> section of git(7).  Only then do they really have enough background
> understanding of the fundamental concepts of git that they won't get
> confused when they start talking to other git users, on the git
> mailing list, for example.
> 
> It would be nice if there was an easy way to direct users through the
> documentation in a way which makes good pedagogical sense.  Right now,
> one of the reasons why life gets hard for new users is that the
> current tutorials aren't enough for them to really undersatnd what's
> going on at a conceptual level.  And if users start using "everyday
> git" as a crutch, without the right background concepts, the human
> brain naturally tries to intuit what's happening in the background,
> but without reading the background docs, git is different enough that
> they will probably get it wrong, which means more stuff that they have
> to unlearn later.  

I agree.  Unfortunately, people who need to use git but aren't
study-the-manual-first types *are* going to just dive in whether we want
them to or not, so we have to make it easy for them to pick up what they
need as they go.

How about this as a strawman "git user's manual" outline:

	I. Quick-start: drawn from the tutorial part I and everyday.txt?

	II. Basic git concepts, drawn from "discussion" in git(7) (the
	README), tutorial part II, this branching-and-merging tutorial, etc.:

		1. The commit graph and the object database
		2. References
		3. Fetching and pulling, remotes
		4. The index file

	III. Using git: 

		1. History exploration
		2. merge resolution
		3. pack files, fsck, repository maintenance
		4. pushing, setting up a public repo

	IV. Advanced examples: drawn from the howto directories,
	    cvs-migration.txt,...

		1. More complicated commandline magic, scripting
		   (history exploration with git-rev-list, etc.)
		2. History re-writing: cherry-picking, rebasing,...
		3. Setting up a shared public repo?
		4. Migration to/from other SCM's.

	IV. Technical details: core-tutorial.txt, plumbing, code tours, etc.

Chapter II is the prerequisite for everything else, so a lot of thought
has to be given to treating exactly what's necessary there and no more.
Maybe more of it could be mixed into chapter I.

It has to be readable in order by the 10% of people who actually like to
read manuals, and easy to pick up in the middle for the 90% who will
just dive into the section they were told they need to read to
understand some particular problem.

In particular, ideally only I and II would really be sequential, and
the rest would be readable in any order.

