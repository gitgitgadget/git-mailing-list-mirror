From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Comments on recursive merge..
Date: Tue, 8 Nov 2005 16:51:11 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0511081646160.3247@g5.osdl.org>
References: <Pine.LNX.4.64.0511070837530.3193@g5.osdl.org>
 <20051107225807.GA10937@c165.ib.student.liu.se> <7vll00ov2l.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0511071629270.3247@g5.osdl.org>
 <Pine.LNX.4.63.0511081254520.2649@wbgn013.biozentrum.uni-wuerzburg.de>
 <20051108210211.GA23265@c165.ib.student.liu.se> <Pine.LNX.4.64.0511081351020.3247@g5.osdl.org>
 <20051108223609.GA4805@c165.ib.student.liu.se> <Pine.LNX.4.64.0511081450080.3247@g5.osdl.org>
 <20051109003236.GA30496@pasky.or.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Fredrik Kuivinen <freku045@student.liu.se>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 09 01:53:04 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EZeBZ-0007AL-Gl
	for gcvg-git@gmane.org; Wed, 09 Nov 2005 01:51:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030477AbVKIAvb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 8 Nov 2005 19:51:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932403AbVKIAvb
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Nov 2005 19:51:31 -0500
Received: from smtp.osdl.org ([65.172.181.4]:31925 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932391AbVKIAva (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 Nov 2005 19:51:30 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id jA90pCnO003726
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 8 Nov 2005 16:51:12 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id jA90pAR1031049;
	Tue, 8 Nov 2005 16:51:11 -0800
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20051109003236.GA30496@pasky.or.cz>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.55__
X-MIMEDefang-Filter: osdl$Revision: 1.127 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11374>



On Wed, 9 Nov 2005, Petr Baudis wrote:
> 
> BTW, git-show-branch is also by orders of magnitude faster (not that
> this would be any major timesaver). Median 0.006s vs. median 0.124s.

Ouch. That makes me suspicious. One reason git-merge-base is slow is 
because it's being pretty careful about some pathological examples of 
dates being just the wrong way around, and it might just be that the 
reason git-show-branch is faster is because it isn't doing that part 
right.

So yes, git-merge-base does extra work, but it does so because I think it 
needs to.

Junio? You even wrote the comment about the case in git-merge-base, I'm 
wondering whether it's a bug that we use the fast-and-cheap algorithm in 
git-show-branch..

Of course, arguably you can first try the fast-and-cheap thing, and if 
that gives a merge parent that is acceptable, why not? So maybe it's the 
right thing for the "let's see if this is trivial" case, but I think it 
might _think_ some cases are trivial that really shouldn't, because they 
actually have two merge parents.

		Linus
