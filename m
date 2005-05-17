From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH] Make object contents optionally available
Date: Tue, 17 May 2005 15:59:53 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0505171535510.30848-100000@iabervon.org>
References: <7vbr79fy22.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org,
	Petr Baudis <pasky@ucw.cz>
X-From: git-owner@vger.kernel.org Tue May 17 22:02:41 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DY8Ef-0005HC-0w
	for gcvg-git@gmane.org; Tue, 17 May 2005 22:00:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261891AbVEQUAj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 May 2005 16:00:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261861AbVEQUAi
	(ORCPT <rfc822;git-outgoing>); Tue, 17 May 2005 16:00:38 -0400
Received: from iabervon.org ([66.92.72.58]:42500 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S261815AbVEQUAa (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 May 2005 16:00:30 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1DY8EL-0005S1-00; Tue, 17 May 2005 15:59:53 -0400
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vbr79fy22.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Tue, 17 May 2005, Junio C Hamano wrote:

> That's what I meant to say by "types are special" but I phrased it so
> badly.

Ah, okay. I'm not convinced that discriminating at all at the point where
parse is deciding whether to free the contents is that useful; doing it
based on type is just sufficiently easy that it could be worthwhile.

> And the callback would solve that naturally.  Or you can
> additionally give the callback the result of the parse_xxx(),
> which would be even more useful.  The callback can then throw
> commit raw-data away based on the date, for example.

I don't think a callback has any advantage over turning on a flag to
provide all unpacked objects, and having the program free them when it
wants to, either right after whatever caused them to be parsed returns
or later. I suspect that the main relevant thing is going to be the stack,
not the data.

I have another idea, which is almost certainly too magical, but which
would work: have library functions that parse objects return them unpacked
if the objects they are given are unpacked. So, for example,
pop_most_recent_commit() would unpack parents of a commit if the commit
was unpacked. This would make everything work the way you'd expect if you
didn't think about it, although it would probably be really surprising if
you were thinking about it. I'm just mentioning this because it might make
someone think of something similar but sane.

	-Daniel
*This .sig left intentionally blank*

