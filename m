From: Junio C Hamano <junkio@cox.net>
Subject: Re: full kernel history, in patchset format
Date: Sat, 16 Apr 2005 12:27:32 -0700
Message-ID: <7v3btq7c9n.fsf@assigned-by-dhcp.cox.net>
References: <20050416131528.GB19908@elte.hu>
	<Pine.LNX.4.58.0504160953310.7211@ppc970.osdl.org>
	<1113679421.28612.16.camel@tglx.tec.linutronix.de>
	<Pine.LNX.4.58.0504161135480.7211@ppc970.osdl.org>
	<1113681021.28612.29.camel@tglx.tec.linutronix.de>
	<20050416185751.GJ19099@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Linus Torvalds <torvalds@osdl.org>,
	Ingo Molnar <mingo@elte.hu>, junkio@cox.net,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 16 21:24:28 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMsu0-0007pf-Oc
	for gcvg-git@gmane.org; Sat, 16 Apr 2005 21:24:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261884AbVDPT2D (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 16 Apr 2005 15:28:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262734AbVDPT2D
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Apr 2005 15:28:03 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:11436 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S261884AbVDPT17 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Apr 2005 15:27:59 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050416192734.ZAGB18934.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 16 Apr 2005 15:27:34 -0400
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050416185751.GJ19099@pasky.ji.cz> (Petr Baudis's message of
 "Sat, 16 Apr 2005 20:57:51 +0200")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "PB" == Petr Baudis <pasky@ucw.cz> writes:

PB> P.S.: It seems that Linus applied a patch to ls-tree which will make it
PB> read_sha1_file() on each item when ls-tree is recursive. Junio, why did
PB> you do it?

Sorry it was my misunderstanding, before I found out exactly how
S_ISDIR is used.  Thank you for pointing it out.

I was confused by this comment around the area I changed:

    /* XXX: We do some ugly mode heuristics here.
     * It seems not worth it to read each file just to get this
     * and the file size. -- pasky@ucw.cz

I mistakenly inferred from that comment that S_ISDIR(mode) is
not a guarantee.  So I mistakenly optimized it for non-recursive
case by keeping that "heuristics".  The logic was: If recursive
we will need to run read_sha1_file() to find out if it is really
a tree anyway.

I'll fix it up, now I know S_ISDIR(mode) is a guarantee that it
is a tree, I'll do the "heuristics" first, and do read_sha1_file
only when it is a tree and I am recursive.

