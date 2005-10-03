From: Junio C Hamano <junkio@cox.net>
Subject: Re: What to expect after 0.99.8
Date: Mon, 03 Oct 2005 15:06:20 -0700
Message-ID: <7v1x32l0gz.fsf@assigned-by-dhcp.cox.net>
References: <7v7jcvxxrl.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0510031522590.23242@iabervon.org>
	<7vmzlqnwmw.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0510031709360.23242@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 04 00:08:43 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EMYSo-0005FB-29
	for gcvg-git@gmane.org; Tue, 04 Oct 2005 00:07:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932708AbVJCWGZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 3 Oct 2005 18:06:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932716AbVJCWGY
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Oct 2005 18:06:24 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:3043 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S932708AbVJCWGW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Oct 2005 18:06:22 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051003220616.SQBM4169.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 3 Oct 2005 18:06:16 -0400
To: Daniel Barkalow <barkalow@iabervon.org>
cc: Dan Aloni <da-x@monatomic.org>
In-Reply-To: <Pine.LNX.4.63.0510031709360.23242@iabervon.org> (Daniel
	Barkalow's message of "Mon, 3 Oct 2005 17:33:29 -0400 (EDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9656>

Daniel Barkalow <barkalow@iabervon.org> writes:

> The code in ssh-fetch already does parallel fetching, actually (only over 
> one connection, but requests are sent before responses are read), so 
> multiple requests are in progress at the same time.

This reminds me of one patch:

    From: Dan Aloni <da-x@monatomic.org>
    Subject: [PATCH] Fix git+ssh's indefinite halts during long fetches
    Date: Sat, 1 Oct 2005 21:39:42 +0300
    Message-ID: <20051001183942.GA2099@localdomain>

I'd appreciate it if you had a chance to take a look at it and
comment on it.

The change is isolated to ssh-fetch [*1*], so even if it were to
break something it would only break ssh-fetch and in that sense
it is a safer change.

But it still is a lot of code, and I felt there might be a
simpler way to do this.  That is why I am deliberately holding
it off.

[Footnote]

*1* The patch touches sha1_file.c and cache.h but that is to
update write_sha1_from_fd(), which is used only by ssh-fetch
AFAICT.  We may want to move it from sha1_file.c to sha1-fetch.c
and make it static, removing it from cache.h.
