From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: RFC: Subprojects
Date: Tue, 17 Jan 2006 11:45:36 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0601171122270.25300@iabervon.org>
References: <43C52B1F.8020706@hogyros.de> <Pine.LNX.4.64.0601141055210.13339@g5.osdl.org>
 <7vek3ah8f9.fsf@assigned-by-dhcp.cox.net> <200601161144.48245.Josef.Weidendorfer@gmx.de>
 <7vek37rj83.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0601170001130.25300@iabervon.org>
 <7vfynnfkc8.fsf@assigned-by-dhcp.cox.net> <20060117140937.GI28365@pasky.or.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>,
	Josef Weidendorfer <Josef.Weidendorfer@gmx.de>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 17 17:43:52 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Eytvt-00008r-Pq
	for gcvg-git@gmane.org; Tue, 17 Jan 2006 17:43:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932142AbWAQQno (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Jan 2006 11:43:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932147AbWAQQno
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Jan 2006 11:43:44 -0500
Received: from iabervon.org ([66.92.72.58]:4108 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S932142AbWAQQnn (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Jan 2006 11:43:43 -0500
Received: (qmail 19205 invoked by uid 1000); 17 Jan 2006 11:45:36 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 17 Jan 2006 11:45:36 -0500
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20060117140937.GI28365@pasky.or.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14796>

On Tue, 17 Jan 2006, Petr Baudis wrote:

> I perhaps missed this in the thread, but is it really so useful to bind
> the subprojects to specific commits? If you care about reproducing
> specific configuration, all you have to do is tag and seek recursively -
> and even having a separate tiny git branch tracking just a single file
> listing the commit ids of subprojects seems more elegant to me than just
> forcing the specific commit ids. In the general case, I think it most
> usually goes "this project#branch, the latest commit you can get", so
> I'm not really convinced that you are optimizing for the right case at
> all.

Think from a debugging standpoint. You know that the main project worked 
with a particular commit of the superproject. The bug you've found is 
related to the behavior of one of the subprojects in the the context of 
your superproject, but you don't know this. In order to reproduce the 
working version and search for the change that broken things, you need to 
be able to identify which commits of subprojects were used in each commit 
of the superproject; these are almost certainly not the latest commits on 
any branch of the subproject. And if you're going to want to debug things 
later, no commit of the superproject can just say to use the latest in the 
subproject. You don't know what you make a commit whether it will turn out 
to be a configuration that you'll want to recreate later.

Now it may be useful to have a tool to update all of the subprojects to 
the latest versions, similar in end-user usage to pulling repositories, 
but you still need to generate new commits when you do this, rather than 
reinterpreting the old commits with new content, so that you keep the 
history immutable. You also want to know when you've done this, so that 
you don't clone a tree that's working fine and build it only to find that 
the clone has fetched a new kernel version with different behavior without 
letting you know that anything has changed.

	-Daniel
*This .sig left intentionally blank*
