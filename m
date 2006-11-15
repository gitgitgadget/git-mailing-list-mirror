X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: Cleaning up git user-interface warts
Date: Tue, 14 Nov 2006 16:31:50 -0800
Message-ID: <7v3b8lv9c9.fsf@assigned-by-dhcp.cox.net>
References: <87k61yt1x2.wl%cworth@cworth.org> <455A1137.8030301@shadowen.org>
	<87hcx1u934.wl%cworth@cworth.org> <20061114194707.GH7201@pasky.or.cz>
	<87d57pu4qa.wl%cworth@cworth.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 15 Nov 2006 00:32:20 +0000 (UTC)
Cc: git@vger.kernel.org, Andy Whitcroft <apw@shadowen.org>,
	Petr Baudis <pasky@suse.cz>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <87d57pu4qa.wl%cworth@cworth.org> (Carl Worth's message of "Tue,
	14 Nov 2006 12:56:45 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31395>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gk8hL-0007k8-2D for gcvg-git@gmane.org; Wed, 15 Nov
 2006 01:32:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S966521AbWKOAbw (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 14 Nov 2006
 19:31:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966535AbWKOAbw
 (ORCPT <rfc822;git-outgoing>); Tue, 14 Nov 2006 19:31:52 -0500
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:10181 "EHLO
 fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP id S966521AbWKOAbv
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 14 Nov 2006 19:31:51 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao06.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061115003150.YOYH7157.fed1rmmtao06.cox.net@fed1rmimpo02.cox.net>; Tue, 14
 Nov 2006 19:31:50 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id moXw1V00h1kojtg0000000; Tue, 14 Nov 2006
 19:31:57 -0500
To: Carl Worth <cworth@cworth.org>
Sender: git-owner@vger.kernel.org

Carl Worth <cworth@cworth.org> writes:

> On Tue, 14 Nov 2006 20:47:07 +0100, Petr Baudis wrote:
>> Hmm, did they (not) consider Cogito? They wouldn't have those issues.
>
> I didn't ask.
>
> Frankly, I don't see a lot of value in the git/cogito split right now.
> ...
> It's great that git is written in a script-friendly way so that new
> interfaces can be built on top of it. And I think the benefits of new
> user interfaces are clear when they work in fundamentally different
> ways, (say, being operated through a GUI). But where git and cogito
> are both command-line utilities and have the same basic functionality,
> ...
> There are some things that cogito does that git does not that I would
> like to have in git.
> ...
> I don't see any defining difference that justifies cogito's
> existence ("hide the index" maybe? let's just hide it a tiny bit more
> in git). And I would like to help work to get the remaining good
> stuff that has been proven in cogito---to get it pushed down into git
> itself.

I am of two minds here.

I do not think the Porcelain-ish UI that is shipped with git
should be taken with the same degree of "authority" as git
Plumbing.  The plumbing needed to have something that worked for
one particular workflow (namely, workflow of the people in the
integrator role of kernel-style project) and that is where the
current set of Porcelain-ish originates.  Linus works primarily
as an integrator so the toolsets he did tend to be more pleasant
to use for integrators and less so for contributors.  I started
as a contributor and added some commands like format-patch and
rebase that Linus never would have felt the need for.  I think
single isolated developers, contributors and CVS style shared
repository usage could be a lot improved because neither of us
were concentrating in their workflows.  This needs somebody
motivated enough to improve things in that area.  For example,
StGIT with its 'float' command is a great improvement over what
rebase does for people in the contributor role.

By now, perhaps git may be good enough for the kernel folks,
even for those not in the integrator role, but I have no doubt
that they have many dislikes to the way some commands work.
They and X.org folks are using git primarily because Linus and
Keith forced them to ;-), and being interoperable is more
important than having to tolerate sucky UI here and there.
Everybody knows that git Porcelain-ish sucks, and making it more
usable is a worthy goal.

But making it more usable for whom is a big question.  

Quite frankly, I do not think there can be _the_ single UI that
would satisfy different types of workflows for some of the
commands.  The commands related to software archaeology, in
which my main interest and strength lie, would easily be usable
across workflows, but commands to build commits locally and
propagate them to and from other repositories would be affected
by the workflow.

For example, fetching and merging from many places without
necessarily having corresponding tracking branches is a great
thing for people in the integrator role.  On the other hand, for
people doing CVS-style centralized repository interaction, it is
often more useful to have tracking branches.  You could support
both but it has been painful.

For another example, having a commit command to commit
everything by default is disastrous for people who allow their
workflows to often be interrupted.  When I respond to a message
from the list with an example patch, my repository is often in
the middle of doing something completely unrelated, and I edit
and make diff to send the message out and I do not necessarily
revert that change afterwards immediately.  For more organized
people it may not be a problem so you either support both types
of workflows or do a specialized toolset.

It is not just command line syntax and the defaults, but
concepts as well.  People in the integrator role often need to
deal with merges and you would need to be aware of the role of
the index and need to be able to manipulate the index, a lot
more often than people in the contributor role.  To satisify
both kinds of workflows, you would either have switches, or do a
specialized toolset, like Cogito, that tries to hide the index.

A Porcelain that does a very similar thing in slightly different
way is obviously a waste, but otherwise I do not think it is a
problem to have different Porcelains.  StGIT does not compete
with the "sucky" Porcelain-ish shipped with git but makes the
user's life a lot more pleasant by complementing what the sucky
one does not do well.  It is not very useful while I am playing
the integrator role, but when I am doing my own thing it is a
great addition to my toolchest.

I am from the camp that does _not_ want to hide the index, so
obviously I do not see any value in its effort to hide the
index.  But other aspects of it, most notably being friendly to
simpler workflows, is a very good thing.

