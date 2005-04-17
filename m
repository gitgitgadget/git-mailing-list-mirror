From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [1/5] Parsing code in revision.h
Date: Sun, 17 Apr 2005 13:06:18 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504171254500.7211@ppc970.osdl.org>
References: <Pine.LNX.4.21.0504171531180.30848-100000@iabervon.org>
 <Pine.LNX.4.58.0504171253030.7211@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Petr Baudis <pasky@ucw.cz>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 17 22:51:24 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNGjM-00021E-Be
	for gcvg-git@gmane.org; Sun, 17 Apr 2005 22:51:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261461AbVDQUyl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Apr 2005 16:54:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261457AbVDQUyl
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Apr 2005 16:54:41 -0400
Received: from fire.osdl.org ([65.172.181.4]:45963 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261461AbVDQUE2 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 17 Apr 2005 16:04:28 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3HK4Ks4014415
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 17 Apr 2005 13:04:21 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3HK4JwO001305;
	Sun, 17 Apr 2005 13:04:20 -0700
To: Daniel Barkalow <barkalow@iabervon.org>
In-Reply-To: <Pine.LNX.4.58.0504171253030.7211@ppc970.osdl.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Sun, 17 Apr 2005, Linus Torvalds wrote:
> 
> Yes. I'm not opposed to yours, I was just opposed to some of the things 
> around it you did, so I wrote mine as a kind of place-holder. I'll happily 
> take patches to turn it from a rally simple and stupid one into a more 
> polished version.

Btw, before I forget - I did have another reason. I actually think that
the date is potentially a lot more important than "how many parents deep".

In particular, it's entirely possible that the top of my head might be a
veru recent merge that merges with a small fix relative to a very old
parent (making that old parent be just two hops away from the head), while
the thing I want to merge might also have that old parent (for similar
reasons) as a relatively "close" parent from a pure link-counting
standpoint.

The reason I bring this up is that quite often people end up basing their
work on a specific release version, so a merge (especially in specialized
areas) may thus bring such an old parent pretty close to the head, and it
can actually be quite possible (indeed probable) that such a parent ends
up being a common parent.

However, it can easily be a very _bad_ parent.

In ascii barfic:

	        ----------------------- patch ---------
	       /                                        \
	      /                                          \
	- old release -- ... lots of development .. -----HEAD
	     \  \
	      \  \
	       \  ---------------------patch-- MERGE-HEAD      
	        \                             /
		  .. lots of development ..  /

it looks like "old release" is pretty close to both HEAD and MERGE-HEAD, 
right?

But that's just an artifact of the fact that they both had a trivial merge
against some older code, and if the two "lots of development" things have
ever done an earlier merge, there's quite possibly a _much_ better common
parent there somewhere.

I dunno.

		Linus
