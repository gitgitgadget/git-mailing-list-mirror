From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: pack-e3117bbaf6a59cb53c3f6f0d9b17b9433f0e4135.pack
Date: Fri, 8 Jul 2005 12:50:03 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0507081242540.17536@g5.osdl.org>
References: <200507081149.45344.adobriyan@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 08 21:54:57 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dqyvy-0005Sl-6Q
	for gcvg-git@gmane.org; Fri, 08 Jul 2005 21:54:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262837AbVGHTyR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 8 Jul 2005 15:54:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262838AbVGHTwM
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Jul 2005 15:52:12 -0400
Received: from smtp.osdl.org ([65.172.181.4]:46989 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262837AbVGHTuI (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 8 Jul 2005 15:50:08 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j68Jo4jA014267
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 8 Jul 2005 12:50:04 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j68Jo3T5021665;
	Fri, 8 Jul 2005 12:50:04 -0700
To: Alexey Dobriyan <adobriyan@gmail.com>
In-Reply-To: <200507081149.45344.adobriyan@gmail.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.111 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Fri, 8 Jul 2005, Alexey Dobriyan wrote:
> 
> I'm confused now. This pack file is ~60M in size. Will rsync download
> another 60M next time? What command should I use now to a) get latest and
> greatest and b) be nice with my traffic?

Your existing command should work fine.

You may (or may not) want to use the "--delete" argument to the rsync, 
which will remove any old objects as they get packed. That won't change 
your network traffic, but will just keep your disk usage down (and may 
make rsync a bit more efficient).

And no, the way I'm setting up the kernel repo is that I won't re-pack the 
_whole_ archive next time around, I'll only create a new incremental pack. 
So next time a "git repack" happens, you'll see a new pack, probably in 
the couple-of-megabytes size range (depending on how much work has done 
on, of course), and the old pack you already downloaded will continue to 
contain the older history.

Depending on how well - or badly - the incremental packing ends up
working, I _may_ end up doing a full, non-incremental pack at some point,
but that would be something that happens just a couple of times a year, so
then you'd get to do one big update every once in a while.

But I'm hoping that the incrementals work well enough that I literally
need to do that maybe once a year or something (replacing 50 incrementals
with one new big complete re-pack). Or maybe the incrementals work so well
that we don't need to do that at all.

So this "ugh, a new 60MB pack" thing should be something that happens
quite infrequently.

		Linus
