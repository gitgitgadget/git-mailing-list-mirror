From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFH] Merge driver
Date: Fri, 09 Sep 2005 09:43:39 -0700
Message-ID: <7vy866jio4.fsf@assigned-by-dhcp.cox.net>
References: <20050907164734.GA20198@c165.ib.student.liu.se>
	<7v1x407min.fsf@assigned-by-dhcp.cox.net>
	<431F34FF.5050301@citi.umich.edu>
	<7vvf1cz64l.fsf@assigned-by-dhcp.cox.net>
	<4320536D.2010706@citi.umich.edu>
	<7v7jdrwlih.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0509081012540.3208@g5.osdl.org>
	<43207FE6.2030108@citi.umich.edu>
	<Pine.LNX.4.58.0509081131070.5940@g5.osdl.org>
	<432089D8.4060507@citi.umich.edu>
	<7v3boen0rb.fsf_-_@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0509091151520.23242@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Fredrik Kuivinen <freku045@student.liu.se>,
	Linus Torvalds <torvalds@osdl.org>, cel@citi.umich.edu,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 09 18:47:28 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EDlyi-0004kV-1q
	for gcvg-git@gmane.org; Fri, 09 Sep 2005 18:43:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750831AbVIIQnm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 9 Sep 2005 12:43:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751429AbVIIQnm
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Sep 2005 12:43:42 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:59051 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S1750831AbVIIQnm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Sep 2005 12:43:42 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050909164341.GLLZ3588.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 9 Sep 2005 12:43:41 -0400
To: Daniel Barkalow <barkalow@iabervon.org>
In-Reply-To: <Pine.LNX.4.63.0509091151520.23242@iabervon.org> (Daniel
	Barkalow's message of "Fri, 9 Sep 2005 12:05:33 -0400 (EDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8243>

Daniel Barkalow <barkalow@iabervon.org> writes:

> I'd actually been thinking it would just go into the the "resolve" driver, 
> with that going back to before it chose among merge-base outputs and just 
> sending the whole list to read-tree.
>
> This is no good: the current 'resolve' can generate wrong results and 
> report that it worked cleanly, while 'multibase' would report a conflict 
> because it isn't ignoring a real problem. My primary goal in doing the 
> multibase version wasn't to produce more clean merges; it was to produce 
> fewer clean-but-wrong merges.

True.  Before 'git-merge' hits the "master" branch I should
remove 'git-merge-resolve' from the strategies list (or rename
'git-merge-multibase' to it).  I have them separately only
because I wanted to be able to see how differently they perform
by saying:

    git merge -s resolve blah...
    git merge -s multibase blah...

>> *1* Fredrik, I have been wondering if we can just say that lack
>> of '-u' flag implies '-i'.  Is there a good reason that
>> 'git-read-tree -m O A B' without '-u' should care if working
>> tree is up to date for the paths involved?
>
> It tries to make sure that there is room to put stuff for resolving a 
> conflict without messing with modified files in the directory.

I agree it can be used that way, but nobody seems to use it for
that purpose as far as I can tell hence my earlier comment.  But
let's leave the door open by having them as independent
options.
