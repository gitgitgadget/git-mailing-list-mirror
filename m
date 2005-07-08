From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [ANNOUNCE] Cogito-0.12
Date: Thu, 7 Jul 2005 17:23:26 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0507071720330.25104@g5.osdl.org>
References: <20050703234629.GF13848@pasky.ji.cz> <42CBC822.30701@didntduck.org>
  <20050707144501.GG19781@pasky.ji.cz>  <7vk6k2sfa4.fsf@assigned-by-dhcp.cox.net>
  <Pine.LNX.4.58.0507071158220.3293@g5.osdl.org>  <20050707221443.GB7151@pasky.ji.cz>
  <Pine.LNX.4.58.0507071549330.25104@g5.osdl.org>  <12c511ca05070716526954edd@mail.gmail.com>
  <Pine.LNX.4.58.0507071658460.25104@g5.osdl.org> <12c511ca050707170964a2cc92@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Petr Baudis <pasky@suse.cz>, Junio C Hamano <junkio@cox.net>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 08 02:24:18 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dqgep-0000uQ-3w
	for gcvg-git@gmane.org; Fri, 08 Jul 2005 02:23:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261400AbVGHAXl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 7 Jul 2005 20:23:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262239AbVGHAXl
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Jul 2005 20:23:41 -0400
Received: from smtp.osdl.org ([65.172.181.4]:6629 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261400AbVGHAXk (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 7 Jul 2005 20:23:40 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j680NTjA026922
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 7 Jul 2005 17:23:30 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j680NQqJ002851;
	Thu, 7 Jul 2005 17:23:27 -0700
To: Tony Luck <tony.luck@gmail.com>
In-Reply-To: <12c511ca050707170964a2cc92@mail.gmail.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.111 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Thu, 7 Jul 2005, Tony Luck wrote:
> 
> This is what happens ("linus" is a local branch just pulled from kernel.org,
> so it just contains one pack file and its index).
> 
> $ cg-update linus
> `/home/aegl/GIT/linus/.git/refs/heads/master' -> `.git/refs/heads/linus'
> does not exist /home/aegl/GIT/linus/.git/objects/04/3d051615aa5da09a7e44f1edbb69
> 798458e067
> Cannot obtain needed object 043d051615aa5da09a7e44f1edbb69798458e067
> while processing commit 0000000000000000000000000000000000000000.
> cg-pull: objects pull failed

Ok. The immediate fix is to just unpack the pack:

	mv .git/objects/pack/* .git/
	for i in .git/*.pack; do git-unpack-objects < $i; done

(or similar - the above is untested, but I think it should be obvious 
enough what I'm trying to do).

> If I try it again, it thinks things are up to date (since it mistakenly
> updated the .git/refs/heads/linus), but then fails to apply (since it
> doesn't have the objects it needs).

Ok, that's a worse bug, it really shouldn't update the head until _after_ 
the pull has succeeded.

		Linus
