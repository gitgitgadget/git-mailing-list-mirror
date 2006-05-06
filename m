From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC] Managing projects - advanced Git tutorial/walkthrough
Date: Sat, 06 May 2006 13:09:03 -0700
Message-ID: <7v64kisyow.fsf@assigned-by-dhcp.cox.net>
References: <e3hnjg$k9f$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 06 22:09:19 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FcT5V-00013v-NW
	for gcvg-git@gmane.org; Sat, 06 May 2006 22:09:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750819AbWEFUJG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 6 May 2006 16:09:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751104AbWEFUJG
	(ORCPT <rfc822;git-outgoing>); Sat, 6 May 2006 16:09:06 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:27885 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S1750819AbWEFUJF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 May 2006 16:09:05 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060506200904.XCOJ19317.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 6 May 2006 16:09:04 -0400
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <e3hnjg$k9f$1@sea.gmane.org> (Jakub Narebski's message of "Sat,
	06 May 2006 10:43:37 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19667>

Jakub Narebski <jnareb@gmail.com> writes:

> I have browsed through Git documentation: "A tutorial introduction to
> git" (tutorial.txt), "A short git tutorial" (core-tutorial.txt) which
> contrary to the title is the tutorial in low-level git commands and is
> longer that the first one, "Everyday GIT With 20 Commands Or
> So" (everyday.txt) and "git for CVS users" (cvs-migration.txt) which does
> not mention git-blame and git-annotate.

I was initially somewhat dissapointed that a posting marked as
RFC did not contain a draft that is commentable, but we would
probably want to know how the updated document set will be
organized in general first.  There was a discussion both here
and on #irc, while Pasky and gang were working on the wiki,
about sprucing up the introductory documentation set.

The core-tutorial grow out of a short tutorial to start from
Plumbing basics (what's in object store) to cover Porcelainish;
when it was written there was not another user-level document,
so it had to cover both, but it is probably a good idea to move
the parts that talk about Porcelainish to other documents and
make it "A short tutorial on git Plumbing" document.  Maybe we
can have a tiered document set like this:

 - Your first experience with git with walkthru.  This shows the
   minimum basic operations to get started a stand-alone "hello
   world" project, without talking about index nor object store.
   The current tutorial.txt is probably good enough with
   updates.

 - Understanding git as an end user.  Currently, this is
   included in the global map git(7) documentation.  It might
   make sense to separate it out.  This should talk about
   concepts like blobs/trees/commits/trust/index without going
   into lowlevel details of the implementation.  The stress
   should be on what they are for, not operationally but
   philosophically.  What's currently in README would be
   suitable for this part, with some additional topics:

   - branches.  "Tying it all together" section talks about the
     single branch and "the HEAD state"; we should talk about
     why you would want to use multiple branches (either
     keeping track of your own development, or keeping track of
     somebody else's) and stress branches are to keep separate
     things separate (explained that way it becomes clear why
     you should not commit on a remote tracking branch).

   - ancestry traversal.  what "A..B" or "^A ^B C" means and why
     you would want to say them.

 - Everyday.

 - Special interests: cvs migration, howto/ documents.

 - The global map git(7) with pointers to individual commands,
   and the glossary.

 - Tutorial on Plumbing.

For a new end-user, the order to read would be from the top to
bottom.  "Everyday" should cover most of what are needed for
different classes of users, and other things can be looked up
from the global map.


I think tutorial.txt is the right "your first experience with
git with walkthru" document, and the materials it gives, and the
order in which it introduces them, are very well thought out;
kudos to JBF.  We might also want to show "git grep", but other
than that I do not think of anything that a new user might want
to use on the first day.

It is deliberately sketchy at times to keep the flow of walkthru
clean and simple, and I'd like to keep it that way.  I would
however like to see the examples to show the expected output
from the commands, like the initial part of the current
core-tutorial.txt does.  Also, I'd like to see a "see also" link
to each step that refers the user to "what if this step does not
work as expected for you", either separate document or a section
in the appendix part of the same document, without cluttering
the main text too much.

Some commands and syntax it mentions may need to be rethought in
the light what happened recently, especially the internal
version of diff and log/show/whatchanged unification that
happened before the 1.3.0 came out.

 * "git diff A B" should probably be spelled as "git diff A..B"
   throughout for consistency.

 * Today's "git log" is more powerful than the one we had when
   the tutorial was first written, and we probably want to
   recommend "git log [-p|--stat]" in place of whatchanged;
   whatchanged is kept primarily for historical reasons and to
   give a different default output format than log.  A new user
   does not have to even know about it.

Then reorganize the initial part core-tutorial.txt to match the
examples tutorial.txt gives, and demonstrate what is happening
under the hood.  The tutorial says "git init-db" then "git
add".  The core-tutorial would match that and explain what
happens when "git init-db" is run (creates .git/objects etc.)
and "git add" is run (populates the index).
