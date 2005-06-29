From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: CAREFUL! No more delta object support!
Date: Wed, 29 Jun 2005 14:38:44 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0506291435310.14331@ppc970.osdl.org>
References: <Pine.LNX.4.21.0506291644120.30848-100000@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jun 29 23:31:51 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dnk9g-0001EF-CJ
	for gcvg-git@gmane.org; Wed, 29 Jun 2005 23:31:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262665AbVF2ViA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 29 Jun 2005 17:38:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262549AbVF2Vh7
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Jun 2005 17:37:59 -0400
Received: from smtp.osdl.org ([65.172.181.4]:40900 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262665AbVF2Vgw (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 29 Jun 2005 17:36:52 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j5TLadjA023984
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 29 Jun 2005 14:36:39 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j5TLackM001661;
	Wed, 29 Jun 2005 14:36:38 -0700
To: Daniel Barkalow <barkalow@iabervon.org>
In-Reply-To: <Pine.LNX.4.21.0506291644120.30848-100000@iabervon.org>
X-Spam-Status: No, hits=0.667 required=5 tests=MANY_EXCLAMATIONS
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.111 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Wed, 29 Jun 2005, Daniel Barkalow wrote:
> 
> > Of course, you can do this one branch at a time, too, if you want to, but
> > the above was meant as an example of how you can actually do all the
> > branches in one single pack-file, which is a lot more efficient (if you do
> > it one branch at a time, you'll quite possible end up transferring objects
> > that are reachable in other branches multiple times, while the "all in one
> > go" thing will pack each object just once).
> 
> It should transfer each only once if you recalculate "refs_in_b" after
> each push, right?

Yes, you can do it that way too. It will possibly not pack as well due to
giving you fewer opportunities for deltas, but that's likely not a huge 
issue.

> The one thing I can think of is whether things will blow up if the target
> repository has heads that aren't in the source

Right. I think that's a "feature" of pushing: you cannot push to an 
archive that has state that you don't know about. Ie you can only push to 
something that is a proper subset of what you are (on a per-branch basis, 
of course - not necessarily on a "global" stage - so you could push just 
_one_ branch, even if another branch was ahead of where you are).

			Linus
