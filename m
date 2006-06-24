From: Junio C Hamano <junkio@cox.net>
Subject: Re: A series file for git?
Date: Sat, 24 Jun 2006 02:01:13 -0700
Message-ID: <7vac83ylk6.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0605291145360.5623@g5.osdl.org>
	<7virno79a7.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0605291739430.5623@g5.osdl.org>
	<7vmzd05i25.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0605292112530.5623@g5.osdl.org>
	<7vpshtyffk.fsf@assigned-by-dhcp.cox.net>
	<m1odwkyuf5.fsf_-_@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jun 24 11:01:33 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fu417-0001Xe-Bl
	for gcvg-git@gmane.org; Sat, 24 Jun 2006 11:01:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932987AbWFXJBQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 24 Jun 2006 05:01:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933359AbWFXJBQ
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Jun 2006 05:01:16 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:12438 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S932987AbWFXJBP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Jun 2006 05:01:15 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060624090115.DCZV19057.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 24 Jun 2006 05:01:15 -0400
To: ebiederm@xmission.com (Eric W. Biederman)
In-Reply-To: <m1odwkyuf5.fsf_-_@ebiederm.dsl.xmission.com> (Eric
	W. Biederman's message of "Fri, 23 Jun 2006 05:37:34 -0600")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22494>

ebiederm@xmission.com (Eric W. Biederman) writes:

> I was using:
> 	git-rev-list $revargs | tac > list
> 	for sha1 in $(cat list); do git-cherry-pick -r $sha1 ; done
>...
> - Keeping patches in git and just remembering their sha1 is nice
>   but it has the downside that it can be really easy to loose
>   the sha1, and thus the patch.  So some sort of history mechanism
>   so you can get back to where you were would be nice.

Actually, the $revargs above is composed of your branch names
(e.g. "^master this-topic that-topic"), so as long as you do not
lose these branches they are protected.
>
> - This is a similar technique to topic branches.  However in some
>   of the more interesting cases a topic branch can't be used because
>   you have a whole series of little changes, that allow depend on
>   each other.  So topic branches need not apply.

Sorry I fail to see why.  A series of little changes that depend
on each other would be a string of pearls on a topic branch in
the simplest case, or a handful of topic branches that
occasionally merge with each other if you want to get fancier.
Cherry-picking from a DAG of the latter kind with your rev-list
piped to tac is no different than cherry-picking from a simple
straight line of the former kind, isn't it?

> - One of the places where we currently uses series files
>   (patch-scripts && quilt), and heavy cherry picking is for patch
>   aging.  That is letting patches sit in a testing branch for 
>   a while so people have a chance to test and look at them.

I agree that patch aging and updating does not mesh well with
how git inherently works, as git regards commits immutable
objects.  Even then, I use my "pu" branch (and topics that
hasn't merged to "next" but in "pu") pretty much as patch aging
area and I regularly do "git commit --amend" to update them.
This however is cumbersome with core git tools alone, and I
suspect is better done with StGIT.

> If we create a meta data branch with just the series file
> we can remove the risk of loosing things, as we always
> have a path back to the old history if we want it.

I am not sure about that.  What does the series file contain,
and what other things the meta data branch contain?  If you are
listing commit SHA1 in the series file, you _do_ have the risk
of losing things -- git-fsck-objects needs to look at such blob
object and consider that as the root of reachability chain; to
me that seems too specialized hack.

I have a feeling that I really should study how well StGIT does
things before talking about this further.  It may suit your
needs perfectly.  What do you feel is lacking in StGIT that you
need?
