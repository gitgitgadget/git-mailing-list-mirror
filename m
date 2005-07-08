From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] rev-list: add "--full-objects" flag.
Date: Thu, 7 Jul 2005 18:46:31 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0507071841010.25104@g5.osdl.org>
References: <20050703234629.GF13848@pasky.ji.cz> <42CBC822.30701@didntduck.org>
 <20050707144501.GG19781@pasky.ji.cz> <7vk6k2sfa4.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.58.0507071158220.3293@g5.osdl.org> <20050707221443.GB7151@pasky.ji.cz>
 <Pine.LNX.4.58.0507071549330.25104@g5.osdl.org> <7vll4ifbq8.fsf_-_@assigned-by-dhcp.cox.net>
 <7vfyuqfa6r.fsf_-_@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0507071657140.25104@g5.osdl.org>
 <7vvf3mds9c.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 08 03:48:46 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dqhyb-0000hI-H5
	for gcvg-git@gmane.org; Fri, 08 Jul 2005 03:48:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261387AbVGHBrQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 7 Jul 2005 21:47:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261400AbVGHBrQ
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Jul 2005 21:47:16 -0400
Received: from smtp.osdl.org ([65.172.181.4]:49796 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261427AbVGHBqq (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 7 Jul 2005 21:46:46 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j681kWjA000316
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 7 Jul 2005 18:46:32 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j681kVlk007095;
	Thu, 7 Jul 2005 18:46:32 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vvf3mds9c.fsf_-_@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.111 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Thu, 7 Jul 2005, Junio C Hamano wrote:
>
> When --full-objects is specified instead of usual "--objects",
> rev-list shows all objects reachable from trees associated with
> the commits in its output.  This can be used to ensure that a
> single pack can be used to recreate the tree associated with
> every commit in it.

Hmm.. The more I think about it, the less I think this is about "full 
objects".

After all, we won't have all objects: the pack will still cut off any 
commits that may be reachable but not interesting.

So this is more specifically about full _trees_, not objects per se. So 
while the name of the option doesn't really matter all that much, I do 
think it would make more sense as "--whole-trees" or something like that.

However, I really don't think it's a very useful option in the first
place. Any dumb web-based thing that depends on "--whole-trees" would suck
horribly. For the kernel, it means that you'd be guaranteed 17,000+ files,
and there would be very few deltas in there, so you'd have this 40MB+
pack-file. Which is _not_ an acceptable way of getting updates.

		Linus
