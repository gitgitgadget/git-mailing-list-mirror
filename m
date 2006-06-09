From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Figured out how to get Mozilla into git
Date: Fri, 9 Jun 2006 09:30:35 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0606090926550.5498@g5.osdl.org>
References: <9e4733910606081917l11354e49q25f0c4aea40618ea@mail.gmail.com>
 <46a038f90606082006t5c6a5623q4b9cf7b036dad1e5@mail.gmail.com>
 <9e4733910606082028k37f6d915m26009e0d5011808b@mail.gmail.com>
 <e6b798$td3$1@sea.gmane.org> <Pine.LNX.4.64.0606090745390.5498@g5.osdl.org>
 <Pine.LNX.4.64.0606091127540.19403@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 09 18:31:07 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fojsr-0005k2-Pw
	for gcvg-git@gmane.org; Fri, 09 Jun 2006 18:30:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751443AbWFIQau (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 9 Jun 2006 12:30:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751455AbWFIQau
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Jun 2006 12:30:50 -0400
Received: from smtp.osdl.org ([65.172.181.4]:6360 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751453AbWFIQat (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 9 Jun 2006 12:30:49 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k59GUagt016580
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 9 Jun 2006 09:30:37 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k59GUZd8020369;
	Fri, 9 Jun 2006 09:30:36 -0700
To: Nicolas Pitre <nico@cam.org>
In-Reply-To: <Pine.LNX.4.64.0606091127540.19403@localhost.localdomain>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.75__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21532>



On Fri, 9 Jun 2006, Nicolas Pitre wrote:
> 
> > So a single 2GB pack is already very much pushing it. It's really really 
> > hard to map in a 2GB file on a 32-bit platform: your VM is usually 
> > fragmented enough that it simply isn't practical. In fact, I think the 
> > limit for _practical_ usage of single packs is probably somewhere in the 
> > half-gig region, unless you just have 64-bit machines.
> 
> Sure, but have we already reached that size?

Not for the Linux repos.

But apparently the mozilla repo ends up being 2GB in git. From Martin:

  >> oh, I went back to a cvsimport that I started a couple days ago.
  >> Completed with no problems...
  >> 
  >> Last commit:
  >> commit 5ecb56b9c4566618fad602a8da656477e4c6447a
  >> Author: wtchang%redhat.com <wtchang%redhat.com>
  >> Date:   Fri Jun 2 17:20:37 2006 +0000
  >> 
  >>    Import NSPR 4.6.2 and NSS 3.11.1
  >> 
  >> mozilla.git$ du -sh .git/
  >> 2.0G    .git/

now that was done with _incremental_ repacking (ie his .git directory
won't be just one large pack), but I bet that if you were to clone it
(without using the "-l" flag or rsync/http), you'd end up with serious
trouble because of the single-pack limit.

So we're starting to see archives where single packs are problematic for
a 32-bit architecture. 

			Linus
