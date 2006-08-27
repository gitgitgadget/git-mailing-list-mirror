From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] dir: do all size checks before seeking back and fix file
 closing
Date: Sat, 26 Aug 2006 19:37:57 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0608261931460.11811@g5.osdl.org>
References: <20060826141709.GC11601@diku.dk> <Pine.LNX.4.64.0608261509290.11811@g5.osdl.org>
 <7v4pvz11o6.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 27 04:38:15 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GHAXI-000511-6K
	for gcvg-git@gmane.org; Sun, 27 Aug 2006 04:38:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751093AbWH0CiE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 26 Aug 2006 22:38:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751103AbWH0CiE
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Aug 2006 22:38:04 -0400
Received: from smtp.osdl.org ([65.172.181.4]:3726 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751093AbWH0CiC (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 26 Aug 2006 22:38:02 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k7R2bwnW025488
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 26 Aug 2006 19:37:58 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k7R2bv9K012301;
	Sat, 26 Aug 2006 19:37:57 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v4pvz11o6.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=-2.426 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.94__
X-MIMEDefang-Filter: osdl$Revision: 1.143 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26080>



On Sat, 26 Aug 2006, Junio C Hamano wrote:
> 
> > Now, admittedly it's wrong because another bad habit Junio picked up 
> > (doing comparisons with constants in the wrong order)
> 
> I think you misunderstand the rationale used to encourage the
> comparison used there.  It does not have anything to do with
> having comparison on the left.
> 
> The comparison order is done in textual order.  You list smaller
> things on the left and then larger things on the right (iow, you
> almost never use >= or >).

Ahh. A number of people do the "0 == x" thing, because they want to be 
caught if they use "=" instead of "==" by mistake. I thought it was the 
same thing.

> This does not come from any authoritative source, but I picked
> it up because I felt it made a lot of sense.

To anybody who has _ever_ done any math at all, it makes no sense at all. 

You _always_ put constants on the right-hand side (or, possibly last on 
the left-hand side, in order to make the right-hand side be "0").

Similarly, if you say it out loud, you'd always say "if 'x' is larger than 
or equal to zero", not "if zero is smaller or less than 'x'". That's 
because "zero" obviously never varies, so you'd never talk about "zero" 
being compared to anything else.

The only exception would be the mathematical "0 < x < 10" kind of thing, 
which some languages (not C, of course) allows in that form. I can imagine 
that people would just do that as "0 < x && x < 10" just to keep the C 
form as close to the mathematical form, although I would at least 
personally do it as

	if (x > 0 &&
	    x < 10)

especially if I ever needed to write it that way on multiple lines due to 
some of the expressions being more complicated.

		Linus
