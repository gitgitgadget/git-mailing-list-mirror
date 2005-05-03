From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: More problems...
Date: Mon, 2 May 2005 22:56:37 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0505022240040.30848-100000@iabervon.org>
References: <20050503014816.GQ20818@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@osdl.org>,
	Anton Altaparmakov <aia21@cam.ac.uk>,
	Russell King <rmk@arm.linux.org.uk>,
	Junio C Hamano <junkio@cox.net>,
	Ryan Anderson <ryan@michonline.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 03 04:51:22 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DSnV3-0000cP-2s
	for gcvg-git@gmane.org; Tue, 03 May 2005 04:51:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261329AbVECC5S (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 2 May 2005 22:57:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261330AbVECC5R
	(ORCPT <rfc822;git-outgoing>); Mon, 2 May 2005 22:57:17 -0400
Received: from iabervon.org ([66.92.72.58]:10246 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S261329AbVECC5P (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 2 May 2005 22:57:15 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1DSnaP-0008FV-00; Mon, 2 May 2005 22:56:37 -0400
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050503014816.GQ20818@pasky.ji.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Tue, 3 May 2005, Petr Baudis wrote:

> BTW, I've just committed support for pulling from remote repositories
> over the HTTP and SSH protocols (http://your.git/repo,
> git+ssh://root@git.nasa.gov/srv/git/mars) (note that I was unable to
> test the SSH stuff properly now; success reports or patches welcome).
> Also, the local hardlinking access is now done over git-local-pull,
> therefore the cp errors should go away now.

Before you get too far with the SSH version, I have some protocol changes
which (1) allow transmission of things other than objects; (2) allow the
pushing side to report that it doesn't have something without killing the
connection; (3) send refs. (1) and (2) are needed to make the protocol
extensible; (3) takes advantage of (1) to make it possible to maintain a
remote repository without doing anything other than rpush to it.

This goes with my patches from the weekend to enable git-*-pull to
transfer refs/ files in the same process.

> I'm not yet decided whether locations like
> 
> 	kernel.org:/pub/scm/cogito/cogito.git
> 
> should invoke rsync, rpull, throw an error or print a fortune cookie.

Probably not rpull, which requires a login, at least not unless the others
fail. I think that http-pull is going to be nicer in the long run than
rsync, since the remote repository could have a bunch of mingled heads
and http-pull will get exclusively the interesting stuff. If you're trying
to push, then rpush, since that's the only push.

Personally, I've been using http://... for http-pull, rsync://... for
rsync, and //... for rpull/rpush (which is somewhat justified wrt the URI
standard for using the program's default method).

	-Daniel
*This .sig left intentionally blank*

