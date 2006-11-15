X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Cleaning up git user-interface warts
Date: Wed, 15 Nov 2006 12:40:43 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0611151226590.3349@woody.osdl.org>
References: <87k61yt1x2.wl%cworth@cworth.org> <Pine.LNX.4.64.0611142306090.2591@xanadu.home>
 <Pine.LNX.4.64.0611150950170.3349@woody.osdl.org> <200611151858.51833.andyparkins@gmail.com>
 <Pine.LNX.4.64.0611151111250.3349@woody.osdl.org>
 <f2b55d220611151139v66fba16ax97ce6b9966b33ce7@mail.gmail.com>
 <Pine.LNX.4.64.0611151203450.3349@woody.osdl.org> <Pine.LNX.4.64.0611151516360.2591@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Wed, 15 Nov 2006 20:41:29 +0000 (UTC)
Cc: "Michael K. Edwards" <medwards.linux@gmail.com>,
	git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <Pine.LNX.4.64.0611151516360.2591@xanadu.home>
X-MIMEDefang-Filter: osdl$Revision: 1.156 $
X-Scanned-By: MIMEDefang 2.36
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31490>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GkRZH-0002kp-Mb for gcvg-git@gmane.org; Wed, 15 Nov
 2006 21:41:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1030680AbWKOUkx (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 15 Nov 2006
 15:40:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030763AbWKOUkx
 (ORCPT <rfc822;git-outgoing>); Wed, 15 Nov 2006 15:40:53 -0500
Received: from smtp.osdl.org ([65.172.181.4]:16354 "EHLO smtp.osdl.org") by
 vger.kernel.org with ESMTP id S1030680AbWKOUkw (ORCPT
 <rfc822;git@vger.kernel.org>); Wed, 15 Nov 2006 15:40:52 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6]) by
 smtp.osdl.org (8.12.8/8.12.8) with ESMTP id kAFKeioZ027330
 (version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO); Wed, 15
 Nov 2006 12:40:45 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31]) by
 shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id kAFKeh9p028893; Wed, 15 Nov
 2006 12:40:44 -0800
To: Nicolas Pitre <nico@cam.org>
Sender: git-owner@vger.kernel.org



On Wed, 15 Nov 2006, Nicolas Pitre wrote:
> 
> Actually I believe it would make things even clearer if "merge" was 
> taught at that point.  Only when the user is comfortable with the 
> separate notions of fetching and merging might the pull shorthand 
> possibly be mentioned.

I agree. I just expect that "merge" is such a simple concept that it 
doesn't really need a whole lot of explaining. 

People kind of expect merging to be hard, but I think it's because CVS et 
al have tought people that merging is _painful_. I don't think it's a very 
complicated concept per se, especially if you have explained branches with 
gitk already.

But yes, the order should be:

 (a) explain what "branches" mean in git (and in that situation, "fetch" 
     is very natural - I think fetching itself is probably easier to 
     explain than "branches" are).
 (b) once you've explained branches, the notion of "merge" comes next, and 
     I _think_ that is very obvious. This is where UI issues come in, 
     because "git merge" is really a totally internal program with a 
     pretty horrid UI, but I think we could fix the syntax, and even with 
     the current syntax you can really just gloss it over, because nobody 
     is really going to care.
 (c) once "fetching branches" and "merging" have been explained, "pull" is 
     really pretty damn trivial, and in fact, if you then explain that 
     it's just easier to do "git pull . branchname" than to use "git 
     merge", I think people may just even agree with you.

I think I saw that particular discussion on #git: somebody didn't expect 
"git pull . branch" to be the way to merge. And again, I think it's 
not _really_ because "pull" is hard to understand, it's because people 
haven't been walked through the thing in this way.

Once you understand local branches, fetching and merging, it's actually 
_easier_ to explain why we merge even local branches with "git pull .": 
you just tell them that this way you can use the same command regardless 
of whether you're merging something local or something remote. Again, if 
it's explained that way, I bet a lot of people react with "ahh, that's 
clever", and _like_ the fact that they only really need to learn _one_ 
command, instead of learning two.

See? Explain it that way: "pull" really is simple. By using "pull", you 
don't have to learn about "merge" syntax. You -can- use "merge" as a 
separate program if you want to, but the syntax isn't very nice, exactly 
because you're not really expected to.

But the real issue here is to explain local branches. I will happily admit 
that local branches are very VERY different from just about any other SCM, 
but I also claim that git is just much BETTER than other SCM's in this 
respect.

And yes, this is why you should NOT try to use the same naming as "hg", 
for example. Last I saw, hg still didn't even have local branches, To 
mercurial, repository == branch, and that's it. It was what I came from 
too, and I used to argue for using git that way too. I've since seen the 
error of my ways, and git is simply BETTER. 

And the concept of local branches is exactly _why_ you have to have 
separate "fetch" and "pull", but why you do _not_ need a separate "merge" 
(because "pull ." does it for you).

If you don't understand local branches, you'll never understand git usage. 
And once you _do_ understand local branches, "fetch" vs "pull" actually is 
rather simple.

