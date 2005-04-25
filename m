From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH] New option (-H) for rpush/rpull to update HEAD
Date: Mon, 25 Apr 2005 01:18:34 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0504250057510.30848-100000@iabervon.org>
References: <Pine.LNX.4.58.0504242149330.5553@sam.ics.uci.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Apr 25 07:13:40 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DPvuX-0004qB-FS
	for gcvg-git@gmane.org; Mon, 25 Apr 2005 07:13:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262541AbVDYFSc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 25 Apr 2005 01:18:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262542AbVDYFSc
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Apr 2005 01:18:32 -0400
Received: from iabervon.org ([66.92.72.58]:7685 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S262541AbVDYFS3 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Apr 2005 01:18:29 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1DPvzO-000441-00; Mon, 25 Apr 2005 01:18:34 -0400
To: Andreas Gal <gal@uci.edu>
In-Reply-To: <Pine.LNX.4.58.0504242149330.5553@sam.ics.uci.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sun, 24 Apr 2005, Andreas Gal wrote:

> Why? Updating HEAD right after writing the commit id and all its children 
> to the object directory seems reasonable and prevents race conditions when 
> the remote repository is shared via HTTP etc.

Come to think of it, the option I was thinking of is orthogonal to your
option; I was thinking of an option to read the head from the sending
side's file, rather than from the command line.

In any case, if you're sharing the repository by HTTP, there's no hurry to
update the HEAD right after, since the old head doesn't stop being valid
(although it's obviously not going to be current in a moment).

> rpull, in contrast, should  never touch HEAD, because conflicts might
> force a merge that will set HEAD to something else. For the pull case we
> should let the script(tm) do that.

For the rpull case, what you want is to just say "HEAD" (or something),
and the remote server will send you the HEAD and you pull down that
commit. You're probably right that you don't want to automatically write
it to the local HEAD, though, although the future format should give us
somewhere good to put the result.

> Its local anyway. rpush is different because the script(tm) has to do
> some SSH magic to update HEAD. I will gladly supply a patch to fix what
> to read/write once you have figured out the final layout, but I really
> need a working rpush _NOW_ ;). 

That was actually my motice in getting rpush/rpull/http-pull in, too.

If you're going to do much serious with this, you should probably remove
the if (has_sha1_file()) continue;" bit in process_commit(), so that it
will make sure that the repository gets pulled completely with -a, even if
some commits have already been pulled. (This will make things less
efficient, but less error-prone, and we'll fix the inefficiency later.)

	-Daniel
*This .sig left intentionally blank*

