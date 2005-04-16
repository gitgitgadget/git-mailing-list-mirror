From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Re: Re: write-tree is pasky-0.4
Date: Fri, 15 Apr 2005 17:22:45 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504151709180.7211@ppc970.osdl.org>
References: <20050414233159.GX22699@pasky.ji.cz> <7v7jj4q2j2.fsf@assigned-by-dhcp.cox.net>
 <20050414223039.GB28082@64m.dyndns.org> <7vfyxsmqmk.fsf@assigned-by-dhcp.cox.net>
 <20050415062807.GA29841@64m.dyndns.org> <7vfyxsi9bq.fsf@assigned-by-dhcp.cox.net>
 <7vaco0i3t9.fsf_-_@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0504151138490.7211@ppc970.osdl.org>
 <20050415185624.GB7417@pasky.ji.cz> <Pine.LNX.4.58.0504151212160.7211@ppc970.osdl.org>
 <20050415223648.GP7417@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 16 02:17:45 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMb0B-0003hL-It
	for gcvg-git@gmane.org; Sat, 16 Apr 2005 02:17:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262487AbVDPAVF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 15 Apr 2005 20:21:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262489AbVDPAVE
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Apr 2005 20:21:04 -0400
Received: from fire.osdl.org ([65.172.181.4]:21124 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262487AbVDPAUy (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 15 Apr 2005 20:20:54 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3G0Kls4015675
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 15 Apr 2005 17:20:48 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3G0KkDe024731;
	Fri, 15 Apr 2005 17:20:47 -0700
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050415223648.GP7417@pasky.ji.cz>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Sat, 16 Apr 2005, Petr Baudis wrote:
> 
> But otherwise it is great news to me. Actually, in that case, is it
> worth renaming it to Cogito and using cg to invoke it? Wouldn't be that
> actually more confusing after it gets merged? IOW, should I stick to
> "git" or feel free to rename it to "cg"?

I'm perfectly happy for it to stay as "git", and in general I don't have
any huge preferences either way. You guys can discuss names as much as you
like, it's the "tracking renames" and "how to merge" things that worry me.

I think I've explained my name tracking worries.  When it comes to "how to 
merge", there's three issues:

 - we do commonly have merge clashes where both trees have applied the 
   exact same patch. That should merge perfectly well using the 3-way
   merge from a common parent that Junio has, but not your current "bring
   patches forward" kind of strategy.
 - I _do_ actually sometimes merge with dirty state in my working 
   directory, which is why I want the merge to take place in a separate 
   (and temporary) directory, which allows for a failed merge without 
   having any major cleanup. If the merge fails, it's not a big deal, and 
   I can just blow the merge directory away without losing the work I had 
   in my "real" working directory.
 - reliability. I care much less for "clever" than I care for "guaranteed 
   to never do the wrong thing". If I have to fix up some stuff by hand, 
   I'll happily do so. But if I can't trust the merge and have to _check_ 
   things by hand afterwards, that will make me leery of the merges, and
   _that_ is bad.

The third point is why I'm going to the ultra-conservative "three-way 
merge from the common parent". It's not fancy, but it's something I feel 
comfortable with as a merge strategy. For example, arch (and in particular 
darcs) seems to want to try to be "clever" about the merges, and I'd 
always live in fear. 

And, finally, there's obviously performance. I _think_ a normal merge with
nary a conflict and just a few tens of files changed should be possible in
a second. I realize that sounds crazy to some people, but I think it's
entirely doable. Half of that is writing the new tree out (that is a
relative costly op due to the compression). The other half is the "work".

		Linus
