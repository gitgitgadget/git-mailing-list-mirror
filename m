From: Petr Baudis <pasky@suse.cz>
Subject: Re: Three-way merge with the index as one way
Date: Thu, 3 Nov 2005 21:21:25 +0100
Message-ID: <20051103202125.GK1431@pasky.or.cz>
References: <20051015174103.GA2609@tumblerings.org> <7vu0fimzhn.fsf@assigned-by-dhcp.cox.net> <20051015192720.GA11364@tumblerings.org> <7v8xwummtm.fsf@assigned-by-dhcp.cox.net> <20051103003423.GH1431@pasky.or.cz> <7vy846ma65.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Zack Brown <zbrown@tumblerings.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 03 21:23:46 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EXlac-0007sf-EZ
	for gcvg-git@gmane.org; Thu, 03 Nov 2005 21:21:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750852AbVKCUV2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 3 Nov 2005 15:21:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030438AbVKCUV1
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Nov 2005 15:21:27 -0500
Received: from w241.dkm.cz ([62.24.88.241]:28865 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1750852AbVKCUV1 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 3 Nov 2005 15:21:27 -0500
Received: (qmail 10741 invoked by uid 2001); 3 Nov 2005 21:21:25 +0100
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vy846ma65.fsf@assigned-by-dhcp.cox.net>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11092>

Dear diary, on Thu, Nov 03, 2005 at 09:02:10AM CET, I got a letter
where Junio C Hamano <junkio@cox.net> told me that...
> git-am 3-way fallback logic constructs a sparse
> temporary tree and uses it for running regular 3-way, and you
> may be able to do something similar.

I'm confused now - if the tree is sparse, how does git-read-tree -m know
that the missing files from the other tree are not deletes?

> Right now git-am takes an
> e-mail patch and when it runs all the way it creates a commit,
> but the core logic that applies patch and falls back to 3-way
> could be separated out for your application.  Then you could:
> (1) 'git diff HEAD' before tree-warp to preserve the user
> changes, (2) clean up the working tree to match HEAD,

At this point I get nervous since there is a potential for data loss
when something goes wrong at this point (e.g. system crash). I'm not
saying there are no places like that in Cogito now, but I generally
try to avoid them whenever possible.

> (3) warp to the other tree, and (4) fed the user change perserved
> to git-am core logic.  That might give you something near optimum.
> 
> About "nonsensical" objects, I am not so sure how nonsensical
> those objects you would record from the working tree
> (intermediate state) are.  If you find two trees match on a path
> that has changed in the working tree, there won't be any
> conflict on that paths so it is like the user did an extra
> git-update-index on that path when no merge or warp is involved,
> from object database pollution POV; I do not personally think
> that is such a bad thing.

But if they don't match, you'll get superfluous blobs for the original
index versions which are almost certain to go away.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
