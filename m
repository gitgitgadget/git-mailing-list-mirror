From: Junio C Hamano <junkio@cox.net>
Subject: Re: Bootstrapping into git, commit gripes at me
Date: Tue, 12 Jul 2005 02:07:43 -0700
Message-ID: <7vy88c5r4w.fsf@assigned-by-dhcp.cox.net>
References: <20050708230750.GA23847@buici.com>
	<Pine.LNX.4.58.0507081842550.17536@g5.osdl.org>
	<20050711222046.GA21376@buici.com>
	<7vll4dndwu.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0507111646000.17536@g5.osdl.org>
	<Pine.LNX.4.58.0507111833380.17536@g5.osdl.org>
	<20050712021004.GA27576@buici.com>
	<Pine.LNX.4.58.0507112005540.17536@g5.osdl.org>
	<Pine.LNX.4.58.0507112045420.17536@g5.osdl.org>
	<Pine.LNX.4.58.0507112132170.17536@g5.osdl.org>
	<20050712074801.GD6363@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, Marc Singer <elf@buici.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jul 12 11:13:23 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DsGos-0002nQ-UM
	for gcvg-git@gmane.org; Tue, 12 Jul 2005 11:12:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261293AbVGLJKH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 12 Jul 2005 05:10:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261271AbVGLJJy
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Jul 2005 05:09:54 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:56478 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S261267AbVGLJHr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jul 2005 05:07:47 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050712090742.OHLW1860.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 12 Jul 2005 05:07:42 -0400
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20050712074801.GD6363@pasky.ji.cz> (Petr Baudis's message of "Tue, 12 Jul 2005 09:48:01 +0200")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

I do want to see various Porcelains to agree on how to store
state information in $GIT_DIR for doing common operations, when
they are conceptually compatible.  The way they handle branches
may fall into that category.  With the barebone GIT Porcelain,
"seek" like operation may simply be done by creating another
branch or tag and jumping to it, so there may not be the concept
of "seek", in which case they may not be compatible after all.

Having said that, I do like the concept of keeping track of
"which development line are we on, and what's most recent in
it".  The way I read your description of cg-seek, you currently
have that information is either in .git/head-name and
.git/refs/heads/<head-name> pair (when .git/head-name exists),
or .git/HEAD.

If you block certain operations while you have seeked to non-top
anyway, wouldn't it be cleaner to have .git/seeked-to that
records the commit ID you are at, which at the same time
indicates that you are in a special situation, and not touching
HEAD at all?  Then .git/HEAD will always have that line of
development information.

Well, that was half tongue-in-cheek suggestion; I have a feeling
that you may feel it is a bit too late to change this kind of
thing easily.

But if we are going to agree on using .git/head-name, I'd rather
see it exist all times, so that cat "$GIT_DIR/head-name" would
always tell us which branch we are working in.
