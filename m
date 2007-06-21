From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: What's cooking in git.git (topics)
Date: Thu, 21 Jun 2007 10:44:05 -0700 (PDT)
Message-ID: <alpine.LFD.0.98.0706211034500.3593@woody.linux-foundation.org>
References: <7v646wqrvm.fsf@assigned-by-dhcp.cox.net> <7vfy5wcnbg.fsf@assigned-by-dhcp.cox.net>
 <7vd50xz7lq.fsf@assigned-by-dhcp.cox.net> <7vodkb1adr.fsf@assigned-by-dhcp.cox.net>
 <7virac547s.fsf@assigned-by-dhcp.cox.net> <7v6466oygl.fsf@assigned-by-dhcp.cox.net>
 <7vfy54tt3l.fsf@assigned-by-dhcp.cox.net> <7vtztbbnsq.fsf@assigned-by-dhcp.pobox.com>
 <7v4pl1zsd7.fsf@assigned-by-dhcp.pobox.com>
 <alpine.LFD.0.98.0706211005520.3593@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 21 19:44:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I1Qho-0006xA-Na
	for gcvg-git@gmane.org; Thu, 21 Jun 2007 19:44:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758329AbXFURo1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Jun 2007 13:44:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758361AbXFURo0
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Jun 2007 13:44:26 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:36481 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758280AbXFURo0 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 Jun 2007 13:44:26 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l5LHiBEn015850
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 21 Jun 2007 10:44:12 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l5LHi5UE001352;
	Thu, 21 Jun 2007 10:44:06 -0700
In-Reply-To: <alpine.LFD.0.98.0706211005520.3593@woody.linux-foundation.org>
X-Spam-Status: No, hits=-2.536 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.181 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50648>



On Thu, 21 Jun 2007, Linus Torvalds wrote:
> 
> But "git log" itself really fundamentally has no clue, and you really 
> should see "git log" as a *linearization* thing. It linearizes the history 
> by creating a one-dimensional streaming log. And within that linearized 
> history, there can not be anything like "concurrent renames".

Btw, just to clarify:

	This is absolutely not somethign unique to "--follow" and rename 
	detection!

when you do a simple "git log -p", you will very commonly see the issue of 
the same patch being applied twice, and if you think of the linearized 
"git log" output is somehow "the Truth" with a capital "T", then you'd 
obviously believe that the thing shows up twice in the end result.

It doesn't even have to be the same patch: you can have a patch that shows 
up in one branch, and that *never* makes it into the end result, even 
though the other branch didn't "undo" it. A merge may have chosen just the 
one side (not necessarily due to "-s ours" or anythign like that: a merge 
conflict may have been resoled that way). 

So the individual logs of changes are not "meaningful" in that sense. Not 
with --follow, and not without. They are a locally linearized version of 
history, and as such you cannot put the world together just based on them. 
You need to have the bigger picture to get the end result.

Does that mean that linearization is meaningless? No, obviously not. Does 
it mean that you *can* get confused by it? Yes, absolutely. Does rename 
detection add new _ways_ of getting confused? Oh, YES! The example from 
the kernel is a great one.

I still think "git log --follow" is actually a really good thing. People 
will find places like this where they are confused, and maybe we'll have 
to teach them about the effects of linearizing their history, but 
especially if you come from the CVS/SVN world, your history has _always_ 
been linear, so git will always get that case right. 

And once you get used to merges, you'll start understanding why git does 
what git does more, and then the "git log --follow" behaviour will still 
perhaps not be what you might always want at any particular point in time, 
but it's something you can understand and deal with.

And it's still hugely preferable to "file identities", which have their 
own (and much more fundamental) problems over merges.

		Linus
