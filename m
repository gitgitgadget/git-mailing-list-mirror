From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC] Second parent for reverts
Date: Thu, 10 May 2007 09:35:45 -0700 (PDT)
Message-ID: <alpine.LFD.0.98.0705100927340.3986@woody.linux-foundation.org>
References: <Pine.LNX.4.64.0705091406350.18541@iabervon.org>
 <7v7irhslx1.fsf@assigned-by-dhcp.cox.net>
 <alpine.LFD.0.98.0705091513050.4062@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu May 10 18:35:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HmBcU-0007U4-MS
	for gcvg-git@gmane.org; Thu, 10 May 2007 18:35:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753201AbXEJQfx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 10 May 2007 12:35:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754775AbXEJQfx
	(ORCPT <rfc822;git-outgoing>); Thu, 10 May 2007 12:35:53 -0400
Received: from smtp1.linux-foundation.org ([65.172.181.25]:52279 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753201AbXEJQfw (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 10 May 2007 12:35:52 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l4AGZk3r023480
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 10 May 2007 09:35:47 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l4AGZjmb025179;
	Thu, 10 May 2007 09:35:45 -0700
In-Reply-To: <alpine.LFD.0.98.0705091513050.4062@woody.linux-foundation.org>
X-Spam-Status: No, hits=-3.48 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.177 $
X-Scanned-By: MIMEDefang 2.53 on 65.172.181.25
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46875>



On Wed, 9 May 2007, Linus Torvalds wrote:
> 
> If you want a "related to that commit" field, it should be a separate 
> field in the commit object. But since it doesn't really have any real 
> *semantic* meaning to git itself, it shouldn't be in the header. We 
> could, for example, make it be in the free-form section, and teach our 
> graphical visualization tools to automatically turn it into a hyperlink.
> 
> .. which we already do.

Btw, sorry for harping on this issue, but one of the really *great* things 
about putting things in the free-form section is a somewhat unanticipated 
huge advantage:

 - we've had much better integration with non-git users than any other SCM 
   I've ever seen!

Now, a lot of that was by design (ie one of the primary design goals for 
git was to work well with patches), and it's one of the reasons that I 
totally dismiss the whole "track file ID's" idiocy: anything but "content" 
will pretty much by definition not be tracked by any other source control 
system.

But it turns out that the whole "you can point to commits in the free-form 
commit message" thing has worked out really well. It means, for example, 
that people can do "git revert" operations in their own local repository, 
AND THEY TRANSLATE BEAUTIFULLY EVEN AS EMAILED PATCHES!

I'm shouting, because it's easy to overlook these kinds of issues, but 
they are really really important. Designing your SCM around the notion 
that everybody will use a totally integrated system is a mistake! It's a 
*huge* mistake. Even a lot of git users end up sending patches back and 
forth, just because for many things it's actually more appropriate.

So I'm literally getting patches that refer to commits that I've 
integrated ("Commit xyz introduced a nasty bug", or "Revert commit abc") 
and they work very well even when I'm not merging with those people 
natively through git. 

And yes, maybe the kernel is a bit unusual in this, but I really don't 
think it should be. In many ways, emailing patches around is a much better 
workflow for actual *development* than doing git merges. The git merges 
are wonderful, but they are kind of a "the development is done, let's 
merge it" operation - they are not good for sending stuff out for comments 
or discussion!

So in general, putting things into the headers and having git semantic 
meaning should be discouraged. The "parents" thing is special, because 
the whole "history" thing is very deeply integrated in git, and obviously 
has to be (any SCM that does _not_ have parenthood information is totally 
broken *cough*CVS/SVN*cough*), but other than that we should actually 
strive to _avoid_ anything with deep git semantics.

		Linus
