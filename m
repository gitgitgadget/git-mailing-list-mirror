From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC] Stgit - patch history / add extra parents
Date: Tue, 23 Aug 2005 17:23:29 -0700
Message-ID: <7virxwmbcu.fsf@assigned-by-dhcp.cox.net>
References: <20050818195753.GA9066@fanta> <tnx64u2p81k.fsf@arm.com>
	<20050819194832.GA8562@fanta>
	<1124572356.7512.21.camel@localhost.localdomain>
	<20050821094059.GA5453@fanta>
	<Pine.LNX.4.63.0508221707520.23242@iabervon.org>
	<tnxvf1wd24m.fsf@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 24 02:24:03 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E7j3H-0008EY-Sf
	for gcvg-git@gmane.org; Wed, 24 Aug 2005 02:23:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932507AbVHXAXc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 23 Aug 2005 20:23:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932475AbVHXAXc
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Aug 2005 20:23:32 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:28596 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S932507AbVHXAXb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Aug 2005 20:23:31 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050824002331.ZLXN17043.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 23 Aug 2005 20:23:31 -0400
To: Catalin Marinas <catalin.marinas@gmail.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7690>

Catalin Marinas <catalin.marinas@gmail.com> writes:

> What's the definition of a parent in GIT terms? What are the
> restriction for a commit object to be a parent? Can a parent be an
> arbitrarily chosen commit?

Yes it can.  GIT does not care if the commit ancestry does not
make sense in contents terms (i.e. you can record one tree
object in a commit object, and record another, completely
unrelated tree object in a commit object that has the first
commit object as its parent).  The "git-diff-tree" output from
comparing those two commits may not make _any_ sense at all to
the human, though, but that is not a problem for GIT to do its
work.

> That's what I've been thinking. StGIT currently only implements the
> external view.
>
> An StGIT patch is a represented by a top and bottom commit
> objects. The bottom one is the same as the parent of the top
> commit. The patch is the diff between the top's tree id and the
> bottom's tree id.
>
> Jan's proposal is to allow a freeze command to save the current top
> hash and later be used as a second parent for the newly generated
> top. The problem I see with this approach is that (even for the
> internal view you described) the newly generated top will have two
> parents, new-bottom and old-top, but only the diff between new-top and
> new-bottom is meaningful. The diff between new-top and old-top (as a
> parent-child relation) wouldn't contain anything relevant to the patch
> but all the new changes to the base of the stack.
>
> Is the above an acceptable usage of the GIT DAG structure?

Surely, as long as it stays internal as StGIT patch stacks.
Even when it is exported (i.e. you manage to have other non
StGIT managed tree to pull and merge with such a commit), the
development history _might_ look funny and complicated, but it
should not be a problem for GIT to handle.  After all, you are
doing complicated thing in the StGIT patch stacks when you pop,
push and freeze number of times, so your history is complicated.
If you want to record that history at least for StGIT internal
bookkeeping purposes, GIT should not prevent you from doing it.

Having said that, I would 100% agree with you that having a
cleansed external view would be a good idea.  It makes merging
with StGIT managed repositories much more acceptable to ordinary
GIT managed history.
