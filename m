From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Don't use $author_name undefined when $from contains no
 /\s</.
Date: Fri, 20 Oct 2006 09:21:51 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0610200911360.3962@g5.osdl.org>
References: <87vemgn1s2.fsf@rho.meyering.net> <7vbqo8uvkn.fsf@assigned-by-dhcp.cox.net>
 <878xjckw7x.fsf@rho.meyering.net> <7vk62wruum.fsf@assigned-by-dhcp.cox.net>
 <87fydkj8q1.fsf@penguin.cs.ucla.edu> <7vr6x4q9b6.fsf@assigned-by-dhcp.cox.net>
 <87pscnj29t.fsf@penguin.cs.ucla.edu> <7vhcxzpgot.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Paul Eggert <eggert@CS.UCLA.EDU>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 20 18:22:30 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Gax8K-0003qj-Am
	for gcvg-git@gmane.org; Fri, 20 Oct 2006 18:22:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992591AbWJTQWE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Oct 2006 12:22:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992624AbWJTQWE
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Oct 2006 12:22:04 -0400
Received: from smtp.osdl.org ([65.172.181.4]:18575 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S2992591AbWJTQWB (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 Oct 2006 12:22:01 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k9KGLraX022394
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 20 Oct 2006 09:21:54 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k9KGLpsx024342;
	Fri, 20 Oct 2006 09:21:52 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vhcxzpgot.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=-2.471 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.95__
X-MIMEDefang-Filter: osdl$Revision: 1.155 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29502>



On Fri, 20 Oct 2006, Junio C Hamano wrote:
> 
> Coding a workaround is not a big deal; the change is simple and
> trivial.

Yeah, I sent Junio a patch that _should_ make git accept the patches 
already, so technically it was easy.

What irritates me personally about the new format for "-u" is that

 - Maybe "-u" is new as far as _POSIX_ is concerned, but daamn, it's been 
   a standard format for a hell of a long time in real life, and this was 
   a totally gratuitous change.

 - The new format is very much a new "special case". Now a totally empty 
   line means exactly the same as a line that is " \n", so we have a new 
   special case that simply didn't use to exist - we used to be able to 
   just always skip the first character on a line, and consider the rest 
   of the line to be "the data". Now you can't do that any more.

   The fact that GNU patch has always accepted total crap patches, has 
   always been a thorn in my side: GNU patch is simply too accepting by 
   default if you care about the integrity of the end result (I always ran 
   it with "-p1 --fuzz=0" just to at least fix the most egregious cases of 
   "we'll accept anything that loks even _remotely_ likely to apply")

 - git-apply was being very strict with patches on purpose. The "empty 
   line in a patch" error has triggered several time for me, and at least 
   so far it has _not_ ever been due to a new GNU patch, but every time 
   due to a broken mailer or somebody not being careful when editing the 
   patch by hand.  So triggering an error has been the _right_ thing to 
   do so far - it's been a big red sign saying "somebody did something bad 
   to this patch".

so I think the new format is strictly speaking a regression. It takes away 
a good sanity-check, and we're stuck with having to handle old-style 
patches _anyway_ for the forseeable future, so we can't replace it with a 
new sanity check.

But it does seem like we have no choice, simply because people apparently 
already use the broken version.

			Linus
