From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] git log [diff-tree options]...
Date: Sun, 9 Apr 2006 12:26:18 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0604091221540.9504@g5.osdl.org>
References: <7v7j5zce7x.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0604090950590.9504@g5.osdl.org> <7vbqvabn8f.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0604091158310.9504@g5.osdl.org> <7v3bgmbm8b.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 09 21:26:28 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FSfYI-0002vp-Lr
	for gcvg-git@gmane.org; Sun, 09 Apr 2006 21:26:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750920AbWDIT0Y (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 9 Apr 2006 15:26:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750921AbWDIT0Y
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Apr 2006 15:26:24 -0400
Received: from smtp.osdl.org ([65.172.181.4]:33675 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750919AbWDIT0X (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 9 Apr 2006 15:26:23 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k39JQJtH015368
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 9 Apr 2006 12:26:19 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k39JQIY2011517;
	Sun, 9 Apr 2006 12:26:18 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v3bgmbm8b.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=-3 required=5 tests=PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.72__
X-MIMEDefang-Filter: osdl$Revision: 1.133 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Sun, 9 Apr 2006, Junio C Hamano wrote:
> Linus Torvalds <torvalds@osdl.org> writes:
> 
> > Well, on the other hand, the new "git log --diff" should get the revision 
> > counting right even if it's _not_ done by the caller.
> 
> Not if the user uses --diff-filter and/or --pickaxe, and after
> we start omitting the log message part when no diff is output.

Fair enough. At that point the counting does have to be done in the 
caller, I guess.

> A merge commit touching a path but not actually changing the contents of 
> the path from parents might be a significant event.

Yes. The fact that git-whatchanged happens to ignore such things right now 
is just a implementation detail, not a "good thing". The new git log seems 
to be better in pretty much all respects.

The bigger conceptual difference is actually that once you do revision 
pruning based on the pathname limiter, we prune away parents of merges 
that seem "uninteresting". So before, when you had the same change come 
through two different branches, "git-whatchanged" would actually show it 
twice, while the new "git log" approach would tend to show it just once 
(because it would pick one of the histories and ignore the other).

I think that's fine (and probably even preferable), but it's another 
example of something where we might want to have an option to not 
simplify the merge history. It's likely that nobody will ever care, but 
who knows..

			Linus
