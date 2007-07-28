From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 3/8] Clean up work-tree handling
Date: Sat, 28 Jul 2007 10:01:08 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707280956510.14781@racer.site>
References: <Pine.LNX.4.64.0707271851370.14781@racer.site>
 <Pine.LNX.4.64.0707271956420.14781@racer.site> <7vk5sly3h9.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0707280115370.14781@racer.site> <7vejitwe8m.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0707280152120.14781@racer.site> <7vlkd1umwf.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, matled@gmx.net
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jul 28 11:01:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IEiAx-0005Co-Fu
	for gcvg-git@gmane.org; Sat, 28 Jul 2007 11:01:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752660AbXG1JBY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 28 Jul 2007 05:01:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754639AbXG1JBY
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Jul 2007 05:01:24 -0400
Received: from mail.gmx.net ([213.165.64.20]:50702 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752227AbXG1JBX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Jul 2007 05:01:23 -0400
Received: (qmail invoked by alias); 28 Jul 2007 09:01:21 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp010) with SMTP; 28 Jul 2007 11:01:21 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18dsS969IsdlaGj5Dk++jH3ESmNQbhSHVf8e9Xh2s
	nUmwG9Zd9YQo1s
X-X-Sender: gene099@racer.site
In-Reply-To: <7vlkd1umwf.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54015>

Hi,

On Fri, 27 Jul 2007, Junio C Hamano wrote:

> Now, I think it is fair to say that if your worktree is somewhere 
> totally unrelated to your cwd, no amount of going up will take you to 
> the top.  IOW, you have to come down after going up some levels.  In 
> such a case, it is easier to code the implementation of --show-cdup to 
> give an absolute path.
> 
> But in that case you are not even in the working tree to begin
> with, aren't you?  Does git need to support that?

I'd say yes.

It is utterly _inconvenient_ to have to cd to the working tree when you 
just want to check the status, for example.  And git already knows about 
the work-tree!

But you got me convinced about the relative path: it is true that nobody 
who has not set core.worktree should be affected.

So I will do something like

	if (!inside_work_tree()) {
		puts(get_git_work_tree());
		continue;
	}
	[do the old thing of outputting ../../[...]]

In fact, I had this in an unpublished version of the patch, and decided 
that I could remove more lines without breaking the test suite.

Heck, I'll even add a test case to make sure that behavior is maintained.  
Okay?

Ciao,
Dscho

P.S.: I'll be offline for a few hours, but then come back to finish it up.
