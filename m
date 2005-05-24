From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 3/3] Diff overhaul, adding the other half...
Date: Mon, 23 May 2005 23:19:49 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0505232314510.2307@ppc970.osdl.org>
References: <7vu0kz1p6k.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.58.0505190901340.2322@ppc970.osdl.org> <7vzmuokjhg.fsf@assigned-by-dhcp.cox.net>
 <7vfywgkj90.fsf_-_@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0505211016140.2206@ppc970.osdl.org>
 <7vzmuoh2ma.fsf_-_@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0505211124440.2206@ppc970.osdl.org>
 <Pine.LNX.4.58.0505211128570.2206@ppc970.osdl.org>
 <Pine.LNX.4.58.0505211137250.2206@ppc970.osdl.org> <7vbr71xjyt.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 24 08:16:28 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DaSiB-0001zj-7H
	for gcvg-git@gmane.org; Tue, 24 May 2005 08:16:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261158AbVEXGRw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 May 2005 02:17:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261166AbVEXGRw
	(ORCPT <rfc822;git-outgoing>); Tue, 24 May 2005 02:17:52 -0400
Received: from fire.osdl.org ([65.172.181.4]:32233 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261158AbVEXGRt (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 May 2005 02:17:49 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j4O6HjjA024020
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 23 May 2005 23:17:45 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j4O6HiBp011525;
	Mon, 23 May 2005 23:17:44 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vbr71xjyt.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Mon, 23 May 2005, Junio C Hamano wrote:
> 
> I have not measured things yet, but I think the big CPU waste is
> coming from either expanding all the blobs and/or running the
> diff-delta on many file pairs.  If that is indeed the cause,
> then helping the upfront check in the similarity estimator that
> refuses to consider a file pair whose file size change is too
> big may be a good way to resolve this problem.

Since pretty much all the blobs will be expanded in the working directory
anyway, it sounds like that would be the way to go. 

> One approach, which I think is an unacceptable change at this
> stage (but I would seriously consider if this _were_ a week and
> half old project), is to record the blob size as part of the
> object ID.  We say object size is "unsigned long" everywhere, so
> I am talking about making the object ID from 20-byte SHA1 to
> 24-byte SHA1 plus 4-byte integer in the network byte order.

You can actually get the blob size fairly easily for non-delta objects, by 
just unpacking the beginning of it. But since we have the files..

That said, I don't think -C is that important. I personally don't see it
as a thing I'd run normally - it's more of a thing I might do between
releases rather than for something like git-whatchanged that looks at
every commit. It's an interesting thing to have _available_, but I don't
think it's a huge problem if it is a lot more expensive than the more
normal "-M".

		Linus
