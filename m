From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-name-rev off-by-one bug
Date: Tue, 29 Nov 2005 18:33:10 -0800
Message-ID: <7v4q5u50gp.fsf@assigned-by-dhcp.cox.net>
References: <20051130001503.28498.qmail@science.horizon.com>
	<Pine.LNX.4.64.0511291742000.3135@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux@horizon.com, junkio@cox.net, git@vger.kernel.org,
	pasky@suse.cz
X-From: git-owner@vger.kernel.org Wed Nov 30 03:34:28 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EhHmn-0000MM-PU
	for gcvg-git@gmane.org; Wed, 30 Nov 2005 03:33:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750807AbVK3CdP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 29 Nov 2005 21:33:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750815AbVK3CdO
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Nov 2005 21:33:14 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:46246 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1750807AbVK3CdN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Nov 2005 21:33:13 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051130023231.IUIG6244.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 29 Nov 2005 21:32:31 -0500
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0511291742000.3135@g5.osdl.org> (Linus Torvalds's
	message of "Tue, 29 Nov 2005 17:51:38 -0800 (PST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12980>

Linus Torvalds <torvalds@osdl.org> writes:

> Junio?
>
> The problem (I think) was that "git-diff-file" did bad things with 
> unmerged entries. That's what the comment in git-merge-one-file implies. 
> But otherwise this should just make it so..
>
> Do you want to test this out?

I have actually resolved one conflicting merge with this and it
was OK, except that it was a bit unpleasant when I first did
"git-diff-index HEAD" without giving any path ;-), but the users
will get used to it.  Pushed out as a part of the proposed
updates collection.

Here is what I wrote as the commit log message for the
hand-resolved merge using this updated merge-one-file.

commit 6b48f6ff7ffff6ca0f9da53d9423a0474dd008fd
Merge: b4f40b90ed1d9e1f3c0557e1ba064d169ba03a1c 99e01692063cc48adee19e1f738472a579c14ca2
Author: Junio C Hamano <junkio@cox.net>
Date:   Tue Nov 29 18:25:29 2005 -0800

    Merge branch 'jc/subdir'
    
    This one is done with the updated merge-one-file, which leaves
    unmerged entries in the index file to prevent unresolved merge
    from getting committed by mistake.
    
    After "git pull ..." fails, earlier the user said:
    
    	$ git-diff
    
    to see half-merged state.  Now git-diff just says:
    
    	$ git-diff
    	* Unmerged path ls-tree.c
    
    In order to get the earlier "show me the failed merge relative
    to my HEAD", you can say:
    
    	$ git-diff HEAD ls-tree.c
    
    Signed-off-by: Junio C Hamano <junkio@cox.net>
