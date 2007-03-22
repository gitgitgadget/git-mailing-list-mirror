From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Rename handling
Date: Wed, 21 Mar 2007 20:53:51 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0703212047310.6730@woody.linux-foundation.org>
References: <slrnevtdfh.v0v.jgoerzen@katherina.lan.complete.org>
 <200703220301.41180.jnareb@gmail.com> <46a038f90703211939j15dbda4cpfa2f49229b8c16cb@mail.gmail.com>
 <200703220432.27071.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Martin Langhoff <martin.langhoff@gmail.com>,
	Steven Grimm <koreth@midwinter.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 22 04:54:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HUENN-0005YV-4B
	for gcvg-git@gmane.org; Thu, 22 Mar 2007 04:54:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965650AbXCVDyF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Mar 2007 23:54:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965645AbXCVDyF
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Mar 2007 23:54:05 -0400
Received: from smtp.osdl.org ([65.172.181.24]:37723 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965650AbXCVDyD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Mar 2007 23:54:03 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l2M3rqG9017666
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 21 Mar 2007 20:53:53 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l2M3rp5j011425;
	Wed, 21 Mar 2007 20:53:52 -0700
In-Reply-To: <200703220432.27071.jnareb@gmail.com>
X-Spam-Status: No, hits=-0.473 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.176 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42836>



On Thu, 22 Mar 2007, Jakub Narebski wrote:
> 
> Second, I have thought that rename detection is done on final states: upstream,
> branch and ancestor, not on intermediate commits. I guess I thought wrong.

No, you didn't think wrong, with a few caveats:

 - we *do* do intermediate commits occasionally (ie for the criss-cross 
   merge case and the "recursive" part of the merge strategy). But that's 
   strictly a "we had multiple potential merge bases" issue, not a "track 
   renames through every commit" kind of thing.

 - you should also see the 3-way merge as the *first* strategy. If it 
   fails, you could do more involved stuff (ie the "blame" merge 
   strategy).

Personally, I think the three-way merge (aka "stupid") is absolutely the 
right thing to do. SCM projects that always try to take intervening 
commits into account (*cough*darcs*cough*) are just doing masturbation. 
It's pointless. The history only matters as a "what was the common state" 
thing, the intermediate mistakes you did in between are meaningless.

But my point is that if you *wanted* to, you could do something fancy. I 
think it would likely be stupid and wrong, and just cause subtle mismerges 
rather than actually *help*, but that's just my opinion. Git itself 
doesn't *force* you to just take the end-points into account, although my 
opinion that they are the only things that matter certainly may have 
colored how we do things right now ;)

			Linus
