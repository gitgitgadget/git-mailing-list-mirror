From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: .gitlink for Summer of Code
Date: Tue, 27 Mar 2007 14:27:17 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0703271420270.6730@woody.linux-foundation.org>
References: <1174825838.12540.5.camel@localhost> <20070326220302.GH22773@admingilde.org>
 <7vfy7rvct2.fsf@assigned-by-dhcp.cox.net> <200703270117.59205.Josef.Weidendorfer@gmx.de>
 <Pine.LNX.4.64.0703270952020.6730@woody.linux-foundation.org>
 <Pine.LNX.4.64.0703271338210.6485@iabervon.org> <4609643C.9050803@midwinter.com>
 <Pine.LNX.4.64.0703271547040.6485@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Steven Grimm <koreth@midwinter.com>,
	Josef Weidendorfer <Josef.Weidendorfer@gmx.de>,
	Junio C Hamano <junkio@cox.net>,
	Martin Waitz <tali@admingilde.org>,
	Eric Lesh <eclesh@ucla.edu>,
	Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Tue Mar 27 23:27:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HWJCl-00015I-Tq
	for gcvg-git@gmane.org; Tue, 27 Mar 2007 23:27:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965475AbXC0V1o (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Mar 2007 17:27:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965483AbXC0V1o
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Mar 2007 17:27:44 -0400
Received: from smtp.osdl.org ([65.172.181.24]:43771 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965475AbXC0V1m (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Mar 2007 17:27:42 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l2RLRIU2014134
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 27 Mar 2007 14:27:19 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l2RLRHr0028144;
	Tue, 27 Mar 2007 14:27:17 -0700
In-Reply-To: <Pine.LNX.4.64.0703271547040.6485@iabervon.org>
X-Spam-Status: No, hits=-0.467 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.177 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43308>



On Tue, 27 Mar 2007, Daniel Barkalow wrote:
> 
> This is actually the case I'm personally interested in. But in that case, 
> you want to reverse the superproject/subproject organization, because that 
> way each project part can use the desired version of the common stuff, and 
> people can modify the common stuff without then testing the whole 
> universe.

The build infrastructure is only a small part of the superproject thing.

A much more interesting thing in many ways is the "how do the pieces fit 
together" question, ie the "which library version X do I need for program 
version Y?"

And that needs to be at the superproject level, obviously. The person who 
works on the application will want to fetch the library too, but he likely 
isn't interested in all the *other* libraries that don't affect his app, 
and he likely isn't interested in things like standard libraries (which 
may be in the superproject too, but since their versioning doesn't affect 
any normal subproject, you'd not expect application developers to have all 
of libc checked out and built, would you?).

So yes, you could have several levels: the top level for "versioning", the 
middle level for "applications and libraries" and some third level for 
"build infrastructure that can be shared". However, I've never actually 
seen any project work that way. People *always* seem to put the build 
infrastructure at either the top level, or as one of the subprojects that 
is required for all the other subprojects.

Of course, it's possible that the reason people do that is that things 
like CVS are really really bad at the versioning stuff, and since they 
aren't distributed, you cannot put the shared build infrastructure in 
multiple projects at the same time anyway.

So with a distributed environment like git, doing the shared build 
infrastructure as a separate sub-sub-project would work in ways it does 
*not* work in a centralized model, but I think we also want to just 
support the way people are used to working, and that definitely involves 
having the build infrastructure at or under the top level..

		Linus
