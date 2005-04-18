From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] fix bug in read-cache.c which loses files when merging
 a tree
Date: Mon, 18 Apr 2005 12:25:47 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504181219480.15725@ppc970.osdl.org>
References: <1113848239.4998.45.camel@mulgrave>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 18 21:21:52 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNbmw-00016U-BZ
	for gcvg-git@gmane.org; Mon, 18 Apr 2005 21:20:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262170AbVDRTYE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 18 Apr 2005 15:24:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262171AbVDRTYE
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Apr 2005 15:24:04 -0400
Received: from fire.osdl.org ([65.172.181.4]:26322 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262170AbVDRTYA (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 18 Apr 2005 15:24:00 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3IJNos4020508
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 18 Apr 2005 12:23:51 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3IJNnBJ031055;
	Mon, 18 Apr 2005 12:23:50 -0700
To: James Bottomley <James.Bottomley@SteelEye.com>
In-Reply-To: <1113848239.4998.45.camel@mulgrave>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Mon, 18 Apr 2005, James Bottomley wrote:
>
> I noticed this when I tried a non-trivial scsi merge and checked the
> results against BK.  The problem is that remove_entry_at() actually
> decrements active_nr, so decrementing it in add_cache_entry() before
> calling remove_entry_at() is a double decrement (hence we lose cache
> entries at the end).

Thanks. Just before I was going to hit the same issue, too.

I've pushed out my first real content merge: since Daniel Barkalow's
object model stuff didn't apply to my tree any more (I had added the
commit type tracking to mine after Daniel did his conversion), I
instead applied his series to the place they were done against,
and used git to merge the result with my current top-of-tree.

I based it on the two example scripts I had sent out, but obviously never 
tested until this point (since both of them had some serious syntax 
errors, and thus clearly wouldn't work).

I also checked in the stupid scripts, in the expectation that somebody
else can improve on them and make them useful. For example, firing up an 
editor when the merge fails is probably a damn good idea.

Anyway, it seems to prove the concept of a real three-way merge, and it 
all actually worked exactly the way I envisioned. Whether the end result 
works or not, that's a different issue ;)

			Linus
