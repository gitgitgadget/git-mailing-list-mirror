From: Junio C Hamano <junkio@cox.net>
Subject: Re: Trying to Update All Heads of a Repository
Date: Fri, 04 Nov 2005 18:07:55 -0800
Message-ID: <7v64r7sv7o.fsf@assigned-by-dhcp.cox.net>
References: <E1EXpN9-00034x-7g@jdl.com>
	<7vy8453zhu.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0511041745480.25300@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jon Loeliger <jdl@freescale.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 05 03:09:13 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EYDU0-0005fp-SQ
	for gcvg-git@gmane.org; Sat, 05 Nov 2005 03:08:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751440AbVKECH6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 4 Nov 2005 21:07:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751206AbVKECH6
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Nov 2005 21:07:58 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:27287 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S1751442AbVKECH5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Nov 2005 21:07:57 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051105020737.ITRZ1668.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 4 Nov 2005 21:07:37 -0500
To: Daniel Barkalow <barkalow@iabervon.org>
In-Reply-To: <Pine.LNX.4.64.0511041745480.25300@iabervon.org> (Daniel
	Barkalow's message of "Fri, 4 Nov 2005 18:47:21 -0500 (EST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11173>

Daniel Barkalow <barkalow@iabervon.org> writes:

> Shouldn't approximately this be what git-clone sets up for you? If it's 
> getting those heads initially, it should keep the information for future 
> use. The only thing it wouldn't know would be the "+" on pu.

Yes, and I am actually thinking along the lines of:

         URL: git://git.kernel.org/pub/scm/git/git.git
         Pull: master:origin/master
         Pull: +pu:origin/pu
         Pull: maint:origin/maint

to further prevent the puller's namespace being cluttered.  This
has an added benefit that it gives a convention that
"remotes/origin" file describes the "refs/heads/origin"
hierarchy.  In the past, somebody complained that branches/*
files are configuration per local branch, but remotes/* files
are not.

> On the "pu" issue, maybe "pu" shouldn't be a branch, but should be 
> something different, like a tag. I think, actually, that a tag would 
> describe "pu" pretty well: no development happens on its line; rather, 
> development happens elsewhere (topic branches), and a merge of some of 
> them is then released as being interesting.

Hmph.  That is a thought.

Another thing that bothers me somewhat about git.git/ repository
is the todo branch.  The "todo" branch does not have any common
commit from the mainline and it is deliberately so --- I'd want
to maintain a unified TODO list even after we go 1.0, at that
time I plan to have master that continues post 1.0 development,
maint which corresponds the current maint (i.e. maintenance for
post 1.0 releases) and maint1.0 which is for backporting
important fixes to frozen 1.0.  I could maintain separate
TODO-for-post-1.0 and TODO-for-1.0-maint, but that is rather a
waste --- items on the two list both end up requirign attention
and time from the same brain.  Also merging "todo" into master
and maint1.0 the way "gitk" project was merged into git.git
would not make much sense, because that merge is pretty much
one-way street.

The first thing I clone from git.git/ repository is almost
always "rm -f .git/refs/heads/todo", because it clutters
git-show-branch output otherwise ;-).  In fact, it comes from
totally separate repository on my private end, and just happens
to be pushed into the same git.git/ repository (partly because I
do not have any other repository there at kernel.org; i.e.
/pub/scm/git/ is not writable by me).
