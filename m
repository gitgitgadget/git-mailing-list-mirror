From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Update the documentation for git-merge-base
Date: Tue, 16 May 2006 08:32:42 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0605160821570.3866@g5.osdl.org>
References: <20060516055815.GA4572@c165.ib.student.liu.se>
 <7vhd3qebuv.fsf@assigned-by-dhcp.cox.net> <20060516065452.GA5540@c165.ib.student.liu.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 16 17:43:40 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fg1Xg-0005Yo-6o
	for gcvg-git@gmane.org; Tue, 16 May 2006 17:33:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751232AbWEPPc4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 16 May 2006 11:32:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751228AbWEPPc4
	(ORCPT <rfc822;git-outgoing>); Tue, 16 May 2006 11:32:56 -0400
Received: from smtp.osdl.org ([65.172.181.4]:36523 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751232AbWEPPcz (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 May 2006 11:32:55 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k4GFWhtH002426
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 16 May 2006 08:32:44 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k4GFWgTj010820;
	Tue, 16 May 2006 08:32:43 -0700
To: Fredrik Kuivinen <freku045@student.liu.se>
In-Reply-To: <20060516065452.GA5540@c165.ib.student.liu.se>
X-Spam-Status: No, hits=-3 required=5 tests=PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.74__
X-MIMEDefang-Filter: osdl$Revision: 1.134 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20124>



On Tue, 16 May 2006, Fredrik Kuivinen wrote:
> 
> By "least" I mean the following:
> 
> C is a least common ancestor of A and B if:
> 
> * C is a common ancestor of A and B, and
> * for every other common ancestor D (different from C) of A and B, C
>   is not reacheable from D.

Yes, git-merge-base should always return a least common ancestor, never 
anything less. The only question is what happens when there are multiple 
LCA commits.

In fact, even in that case git-merge-base will have a pretty strong 
specification:

  "git-merge-base with the '--all' flag will return the complete set of
   least common ancestors, sorted by most recent (as defined purely by
   the commit date order, not any graph ordering) first.

   Without the '--all' flag, it will return just one LCA commit (the most 
   recent one, by the same date-based definition).

   In the case two or more LCA commits have exactly the same committer 
   date, the ordering between them is arbitrary"

I don't think you can be more specific, or do a better job. The definition 
of "most recent" is arbitrary, of course - and going by commit date is 
just _one_ way to order them, but it happens to be an easy one, and one 
that is as good as any other choice.

Of course, the defined ordering probably really matters only for the case 
where we return just one LCA out of many, but it's nice to be able to tell 
what the order will be even for the multi-commit case.

> There are two examples at the top of the source. In the first one a
> least common ancestor is returned. As I interpret the second one, it
> is an example of how the old algorithm without the postprocessing step
> produced a common ancestor which is not least.

Correct. We used to occasionally get it wrong, and return a common 
ancestor that wasn't least.

> Am I wrong? Do we have any cases where the current merge-base
> algorithm gives us common ancestors which are not least?

Modulo bugs, no. And I don't think there are any bugs in that respect.

		Linus
