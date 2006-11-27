X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] (experimental) per-topic shortlog.
Date: Sun, 26 Nov 2006 22:48:32 -0800
Message-ID: <7vbqmtmlkv.fsf@assigned-by-dhcp.cox.net>
References: <7v8xhxsopp.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0611261652520.30076@woody.osdl.org>
	<7vac2dr6ua.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0611261836250.30076@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Mon, 27 Nov 2006 06:48:41 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <Pine.LNX.4.64.0611261836250.30076@woody.osdl.org> (Linus
	Torvalds's message of "Sun, 26 Nov 2006 18:52:57 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32385>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GoaIA-0005FE-RZ for gcvg-git@gmane.org; Mon, 27 Nov
 2006 07:48:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1757098AbWK0Gsf (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 27 Nov 2006
 01:48:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757106AbWK0Gsf
 (ORCPT <rfc822;git-outgoing>); Mon, 27 Nov 2006 01:48:35 -0500
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:56451 "EHLO
 fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP id S1757098AbWK0Gse
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 27 Nov 2006 01:48:34 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao06.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061127064833.QKSB5465.fed1rmmtao06.cox.net@fed1rmimpo02.cox.net>; Mon, 27
 Nov 2006 01:48:33 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id rioh1V00T1kojtg0000000; Mon, 27 Nov 2006
 01:48:42 -0500
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> writes:

> I think that's actually likely the exception rather than the rule. It's 
> much more likely that people have almost _all_ active development done on 
> side branches, and that - together with rebasing of the side branches - 
> inevitably means that the "main branch" ends up not having such a clean 
> set of "topic branch" merges.

You are absolutely right about "Andrew patchbomb" which is
linear and does not have the series boundary.  Import from
mostly linear foreign SCM would have the same issue.  Merge
topology would not help us at all in these cases.

> In addition, on a more mature tree, a lot (probably _most_) of the commits 
> aren't really "topics" at all, but "maintenance", which exacerbates the 
> problem: you don't have a "line of development of this feature",
> ...
> Put another way: bugs get fixed one by one, not in a nice linear fashion 
> by "topic".

Again, you are right, but that only means topic based grouping
is not for everybody, and certainly is not suitable for a long
stretch of commits on the trunk of a mature project because they
tend to touch everywhere and not all that clustered.  If those
bugs were fixed by committing on separate topic branches and
then later merged, the topology based clustering would get the
grouping right, but I would imagine we would end up seeing
hundreds of such short groups which would not be useful at all.
In such cases, it would be much more useful to have one huge
group that says "these are small fixes, each of which may touch
different areas -- they are not related but grouped together
because they are all small, obviously correct and harmless
fixes".  So I suspect that is a slightly different issue -- it
just illustrates the need for an "ungrouped" bin.

> So I'm coming at it from a totally different project - where "topic 
> branches" simply aren't delineated as much, and even when they are, they 
> tend to be merged in multiple steps (and they pull both ways when they 
> aren't re-based).

I agree multiple steps merge and merging both ways would happen
in real life, but I had an impression that fpc handles that
topology reasonably well, unless that "merge from upstream" are
of "too frequent, automated and useless" kind of merges.

> ... but in the kernel, I pretty much guarantee 
> that you probably get better "topic clustering" by going simply by author, 
> like the old standard "git shortlog" does. Because that will tend to get 
> the clustering at a finer granularity (ie not just "networking", but 
> things like "packet filtering" etc).
>
> So the "sort by people" actually works fairly well, but it's kind of an 
> "incidental" thing, and it _would_ be potentially useful to have other 
> ways of grouping things.

I think "networking" vs "packet filtering" largely depends on
how the networking subsystem you pull from is managed.  If
netfilter comes as e-mailed patches to DaveM and are applied
onto the trunk of networking subsystem, we will face exactly the
same problem as we have with Andrew's patchbomb to your trunk.

If it were managed on a separate topic branch in the networking
subsystem repository (either DaveM manages them in his
repository as a topic, or DaveM pulls from netfilter git
repository -- I do not know how that part of the patchflow
works), I would imagine you would get the same "per topic"
grouping.

Another factor is that the author population of a wide and
mature project like the kernel tends to be more diverse, and a
single person tends to be focused on one thing at a time while
others work on different things.  There is enough work in one
specific area for one person to do, and the project is too wide
for one person to be everywhere.
