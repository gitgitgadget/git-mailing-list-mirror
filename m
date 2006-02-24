From: "Randy.Dunlap" <rdunlap@xenotime.net>
Subject: Re: Removal of "--merge-order"?
Date: Fri, 24 Feb 2006 10:10:32 -0800 (PST)
Message-ID: <Pine.LNX.4.58.0602241008590.7894@shark.he.net>
References: <Pine.LNX.4.64.0602240824110.3771@g5.osdl.org>
 <Pine.LNX.4.58.0602240840520.7894@shark.he.net> <Pine.LNX.4.64.0602240918030.3771@g5.osdl.org>
 <Pine.LNX.4.58.0602240942520.7894@shark.he.net> <Pine.LNX.4.64.0602240957430.22647@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Randy.Dunlap" <rdunlap@xenotime.net>,
	Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Feb 24 19:11:04 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FChOp-00053Z-Ez
	for gcvg-git@gmane.org; Fri, 24 Feb 2006 19:10:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932414AbWBXSKg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 24 Feb 2006 13:10:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932412AbWBXSKg
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Feb 2006 13:10:36 -0500
Received: from xenotime.net ([66.160.160.81]:60615 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932414AbWBXSKg (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 24 Feb 2006 13:10:36 -0500
Received: from shark.he.net ([66.160.160.2]) by xenotime.net for <git@vger.kernel.org>; Fri, 24 Feb 2006 10:10:32 -0800
X-X-Sender: rddunlap@shark.he.net
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0602240957430.22647@g5.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16723>

On Fri, 24 Feb 2006, Linus Torvalds wrote:

>
>
> On Fri, 24 Feb 2006, Randy.Dunlap wrote:
> >
> > Other than Ryan's reply, I found 2 users in a quick search,
> > but they have already stated that they are willing to change, so I
> > don't see objections unless someone else comes forward.
>
> One thing we could do - and might be simpler - is to make the merge-order
> thing be a post-processing phase of git-rev-list.
>
> IOW, instead of
>
> 	git-rev-list --merge-order
>
> we could perhaps do
>
> 	git-rev-list --parents [--topo-order?] | git-merge-order
>
> so that the merge-order code wouldn't impact git-rev-list itself.

Makes sense to me... thanks.
But even that may not be needed if noone else really needs it.

> As it is, the merge-order code ends up hooking into the "process_commit"
> thing (and thus to "filter_commit" which does the parent rewriting, and
> then show_commit), which makes it harder to work with.
>
> Now, rev-list.c is not the biggest file (apply.c is about twice the size),
> but in many ways it's the most complex one by far. It's also the most
> performance-critical one, and the one that it would be really nice if we
> were to be able to libify it.
>
> For example, instead of the horrid scriping language, I _think_ I could
> almost libify it by just hooking into "show_commit", and using a callback
> function for that (and then the stand-alone program would just make the
> callback function be one that prints out the commit).
>
> With some care, we might be able to make things like "git diff" be small C
> programs (or, more likely, to save space and not replicate the binaries
> many times - make the "git" binary able to do all the simple things on its
> own: "git-diff" would be just a link to "git").
>
> That would possibly be a simpler way to get away from using nonportable
> scripts. Plain C really does remain one of the most portable things out
> there.

-- 
~Randy
