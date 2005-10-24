From: Junio C Hamano <junkio@cox.net>
Subject: Re: LCA2006 Git/Cogito tutorial
Date: Sun, 23 Oct 2005 17:58:07 -0700
Message-ID: <7vu0f7u3xc.fsf@assigned-by-dhcp.cox.net>
References: <4352F4C9.1040703@catalyst.net.nz>
	<20051021005145.GB30889@pasky.or.cz>
	<200510202137.22311.dtor_core@ameritech.net>
	<4358597A.6000306@catalyst.net.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 24 02:59:28 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ETqfF-0004nV-AC
	for gcvg-git@gmane.org; Mon, 24 Oct 2005 02:58:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750883AbVJXA6K (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 23 Oct 2005 20:58:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750887AbVJXA6K
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Oct 2005 20:58:10 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:22920 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S1750883AbVJXA6J (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Oct 2005 20:58:09 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051024005740.CVTZ29333.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 23 Oct 2005 20:57:40 -0400
To: "Martin Langhoff (CatalystIT)" <martin@catalyst.net.nz>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10517>

"Martin Langhoff (CatalystIT)" <martin@catalyst.net.nz> writes:

>>>(ii) You say:
>>>
>>>        - Very fast stupid merge
>>>            ... and very smart, slow merges when stupid won't do
>
> Almost. No, truly, I'm very impressed with git-merge.sh, which first 
> does the simple git-read-tree -m, and it can then try several merger 
> scripts to resolve the index. The "smartest" merge resolver we have 
> follows renames, but we could have language-specific and 
> project-specific resolvers, for instance.

I should not be saying this because I am the primary guilty
party, but you should not be so impressed.

Being able to specify which merge strategy to use is a useful
thing, but I do not think being able to try more than one merge
strategies automatically, while it has some coolness value, is
very useful in practice.

The language-specific or project-specific part should be made
orthogonal to merge strategy modules, which currently is not.
The primary thing Daniel's git-merge-resolve and Fredrik's
git-merge-recursive do is to figure out which paths can be
resolved without merging the file contents, and which paths need
to be resolved with file contents merge, and they use different
strategies to find which 3 variants of the contents to use for
that final merge.

But at the end of the day, merging the contents is done by
running 'merge' in either case.  This should be made either
customizable, or we ship our standard one that can be extended
to first run 'file' to see the file content type of what is
being merged and run content specific merge program if there is
one.

Even if we did that, we are still doing 3-way merge; git-merge
framework may not mesh very well when we want to use something
like codeville merge which is not based on 3-way.
