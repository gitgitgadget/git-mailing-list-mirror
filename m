From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 2/2] Add keyword unexpansion support to convert.c
Date: Tue, 17 Apr 2007 08:53:46 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0704170847380.5473@woody.linux-foundation.org>
References: <200704171041.46176.andyparkins@gmail.com>
 <7v7isbpb0p.fsf@assigned-by-dhcp.cox.net> <200704171235.34793.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 17 17:54:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hdq0Q-0006KB-Fv
	for gcvg-git@gmane.org; Tue, 17 Apr 2007 17:54:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031097AbXDQPxy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Apr 2007 11:53:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031099AbXDQPxx
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Apr 2007 11:53:53 -0400
Received: from smtp.osdl.org ([65.172.181.24]:52647 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1031097AbXDQPxw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Apr 2007 11:53:52 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l3HFrlTW007004
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 17 Apr 2007 08:53:47 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l3HFrkrQ000500;
	Tue, 17 Apr 2007 08:53:47 -0700
In-Reply-To: <200704171235.34793.andyparkins@gmail.com>
X-Spam-Status: No, hits=-0.965 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.177 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44786>



On Tue, 17 Apr 2007, Andy Parkins wrote:

> On Tuesday 2007 April 17 11:09, Junio C Hamano wrote:
> 
> > In http://article.gmane.org/gmane.comp.version-control.git/44654,
> > Linus said:
> >     And *I* claim that if you don't get an immediate and empty diff, your
> >     system is TOTALLY BROKEN.
> 
> Well that one is easy - the file is normalised to contain collapsed keywords 
> upon checkin, so diff works the same as it ever did.  The output would be 
> immediate and empty so is not TOTALLY BROKEN.

No, it *is* TOTALLY BROKEN, because your keywords guaranteed that it 
doesn't even *apply*.

That's such a fundamental part of a patch that I didn't even _mention_ it, 
but I obviously should have.

If you cannot apply the diff you generate, what the hell is the *point* of 
a diff?

Try this:

 - File-A in revision 1:

	$ID: some random crap about rev1 $
	Line 2

 - same file in revision 2:
	$ID: some other random crap about rev2 $
	Line 2 got modified

and think about it. Your diff will be something like

	@@ -1,2 +1,2 @@
	 $ID:$
	-Line 2
	+Line 2 got modified

and the diff WON'T EVEN APPLY!

What kind of diff is that? Would you call it perhaps "totally broken"?

In other words, there's no way in hell you can make this work. You'll end 
up always having to edit the keywords parts of diffs to make them apply if 
they are part of the context.

(This, btw, is something that a CVS person says "so what?" about. They're 
_used_ to having to do it. It's how you do merges in CVS. Really. How many 
people have actually *worked* with branches in CVS on any complex project 
with any nontrivial work happening on the branch? I have. I hated CVS for 
many reasons. Keywords was just a small small detail in that hate 
relationship, but it was one of them!)

		Linus
