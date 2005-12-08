From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH] Clean up file descriptors when calling hooks.
Date: Thu, 8 Dec 2005 00:33:57 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0512080006460.25300@iabervon.org>
References: <Pine.LNX.4.64.0512072052560.25300@iabervon.org>
 <7vvey0mik7.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 08 06:34:47 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EkEPE-0004YA-1F
	for gcvg-git@gmane.org; Thu, 08 Dec 2005 06:33:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030463AbVLHFdP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Dec 2005 00:33:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030467AbVLHFdP
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Dec 2005 00:33:15 -0500
Received: from iabervon.org ([66.92.72.58]:52241 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S1030463AbVLHFdN (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 8 Dec 2005 00:33:13 -0500
Received: (qmail 27290 invoked by uid 1000); 8 Dec 2005 00:33:57 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 8 Dec 2005 00:33:57 -0500
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vvey0mik7.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13357>

On Wed, 7 Dec 2005, Junio C Hamano wrote:

> Daniel Barkalow <barkalow@iabervon.org> writes:
> 
> > When calling post-update hook, don't leave stdin and stdout connected to 
> > the pushing connection.
> 
> A quick question.  I understand "not connected to the pushing
> connection" is desirable, but is there a reason you chose to
> leave them open to /dev/null, not close()d?

Wouldn't that make programs that assume that stdout (or stdin) is still 
valid get errors? I particularly want git-merge (which has a habit of 
saying "Already up-to-date. Yeeah!") to work. Also, something that assumes 
that fd 1 is somewhere to report stuff will get into trouble if it opens a 
couple of files for writing and fd 0/1 weren't open before. I seem to 
recall the standard thing for running with no I/O to be to use /dev/null 
(e.g., daemon(), if you don't keep your fds, replaces them with /dev/null).

	-Daniel
*This .sig left intentionally blank*
