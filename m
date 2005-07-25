From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC] extending git-ls-files --exclude.
Date: Mon, 25 Jul 2005 12:58:01 -0700
Message-ID: <7vk6jelkty.fsf@assigned-by-dhcp.cox.net>
References: <20050721202309.8216.19338.stgit@h164.c77.b0.tor.eicat.ca>
	<7v3bq71rmb.fsf@assigned-by-dhcp.cox.net> <tnx1x5ryvn2.fsf@arm.com>
	<20050722192424.GB8556@mars.ravnborg.org>
	<7vy87yr2xh.fsf@assigned-by-dhcp.cox.net>
	<20050722205948.GE11916@pasky.ji.cz>
	<7vd5p73jlu.fsf@assigned-by-dhcp.cox.net> <tnxmzobutsf.fsf@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@suse.cz>, Linus Torvalds <torvalds@osdl.org>,
	git@vger.kernel.org, Marco Costalba <mcostalba@yahoo.it>
X-From: git-owner@vger.kernel.org Mon Jul 25 22:06:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dx9Bb-0001Uy-4N
	for gcvg-git@gmane.org; Mon, 25 Jul 2005 22:04:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261531AbVGYT7Y (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 25 Jul 2005 15:59:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261520AbVGYT7W
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Jul 2005 15:59:22 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:17327 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S261521AbVGYT6c (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Jul 2005 15:58:32 -0400
Received: from fed1rmmtao11.cox.net (fed1rmmtao11.cox.net [68.230.241.28])
	by zeus1.kernel.org (8.13.1/8.13.1) with ESMTP id j6PJwV0A010889
	for <git@vger.kernel.org>; Mon, 25 Jul 2005 12:58:31 -0700
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050725195758.QDGO12158.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 25 Jul 2005 15:57:58 -0400
To: Catalin Marinas <catalin.marinas@gmail.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
X-Virus-Scanned: ClamAV version 0.85, clamav-milter version 0.85 on zeus1
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Catalin Marinas <catalin.marinas@gmail.com> writes:

> I think it would make more sense for the exclude-per-directory
> patterns to be local to that directory only, without recursively
> preserving them for subdirectories.

I personally do not have preference either way, but am slightly
biased towards the "cumulative" behaviour the patch attempts to
implement, which was what Pasky said he wanted to have.

    Date: Fri, 22 Jul 2005 22:59:48 +0200
    From: Petr Baudis <pasky@suse.cz>
    Subject: Re: [PATCH 1/1] Tell vim the textwidth is 75.
    Message-ID: <20050722205948.GE11916@pasky.ji.cz>

    > *3* .gitignore in the cwd is used in Cogito, if I am not
    > mistaken.

    Yes. There were several discussions about this in the past, with no
    clear outcome, IIRC. I would prefer:

      ~/.git/ignore per-user
      /.git/ignore per-repository
      .gitignore per-directory (cummulative with parent directories)

>> An exclude pattern is of the following format:
> [...]
>
> That's fine. Actually, the Porcelain would care much about it since it
> gets the information already filtered by git.

Your saying "fine" is a relief.  This change aims at helping
Porcelain people by making it less likely for Porcelain to need
its own filtering.  As you say, if ls-files filters more than
the Porcelain wants, that's a bigger problem.

>>     $ cat Documentation/.gitignore
>>     # ignore generated html files,
>>     # except foo.html which is maintained by hand
>>     !foo.html
>>     *.html
>
> Wouldn't it be clearer to have the general rules first (*.html),
> overridden by the more specific ones (!foo.html)? Just my opinion, I
> don't know what others think.

I do not know, either, but I do know it is consistent with the
"first match determines fate" rule and cleaner to implement.
