From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [ANNOUNCE] Cogito-0.12
Date: Sat, 9 Jul 2005 22:15:41 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0507092211470.17536@g5.osdl.org>
References: <20050707144501.GG19781@pasky.ji.cz> <7vk6k2sfa4.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.58.0507071158220.3293@g5.osdl.org> <20050707221443.GB7151@pasky.ji.cz>
 <Pine.LNX.4.58.0507071549330.25104@g5.osdl.org> <12c511ca05070716526954edd@mail.gmail.com>
 <Pine.LNX.4.58.0507071658460.25104@g5.osdl.org> <12c511ca050707170964a2cc92@mail.gmail.com>
 <Pine.LNX.4.58.0507071720330.25104@g5.osdl.org> <20050709225818.A31045@flint.arm.linux.org.uk>
 <20050709232955.B31045@flint.arm.linux.org.uk> <7vpstrv8z6.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.58.0507092158290.17536@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Russell King <rmk@arm.linux.org.uk>,
	Tony Luck <tony.luck@gmail.com>, Petr Baudis <pasky@suse.cz>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 10 07:16:07 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DrUAg-00055Q-7M
	for gcvg-git@gmane.org; Sun, 10 Jul 2005 07:16:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261853AbVGJFP6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 10 Jul 2005 01:15:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261855AbVGJFP6
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Jul 2005 01:15:58 -0400
Received: from smtp.osdl.org ([65.172.181.4]:26081 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261853AbVGJFPz (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 10 Jul 2005 01:15:55 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j6A5FgjA010475
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 9 Jul 2005 22:15:43 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j6A5FfTO000493;
	Sat, 9 Jul 2005 22:15:42 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <Pine.LNX.4.58.0507092158290.17536@g5.osdl.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.111 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Sat, 9 Jul 2005, Linus Torvalds wrote:
> 
> No, I htink you're using cogito-0.12, and I fixed this one-liner that 
> didn't make it into cogito:

Btw, this will only affect unpacking. The packed objects should be fine,
and you'll never see this if you keep the index file around and have the
pack in .git/objects/pack, because then git won't ever do the "streaming"  
thing, it will look up exactly where the object is using the index, and it
doesn't matter that it doesn't look at the compressed data of a zero-sized
object.

So cogito isn't terminally broken, it just can't do the streaming unpack.

And as Russell points out, unpacking the packs after downloading them is
actually the wrong thing to do, because you break the rsync'ness of your
archive, so you'll keep on downloading the pack-files over and over again.

So you can fix this by getting the current git release, but you probably 
shouldn't even care.  Just use the pack-files as pack-files instead, and 
enjoy the higher performance and lower disk use ;).

		Linus
