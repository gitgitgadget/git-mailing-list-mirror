From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: kernel.org now has gitweb installed
Date: Thu, 28 Apr 2005 11:55:16 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504281149330.18901@ppc970.osdl.org>
References: <42703E79.8050808@zytor.com>  <1114673723.12012.324.camel@baythorne.infradead.org>
  <20050428081005.GG8612@pasky.ji.cz>  <1114676955.12012.346.camel@baythorne.infradead.org>
 <1114680199.12012.363.camel@baythorne.infradead.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Petr Baudis <pasky@ucw.cz>, "H. Peter Anvin" <hpa@zytor.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Apr 28 20:49:09 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DRE3Q-0000UA-HC
	for gcvg-git@gmane.org; Thu, 28 Apr 2005 20:48:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262222AbVD1Sxf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Apr 2005 14:53:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262228AbVD1Sxf
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Apr 2005 14:53:35 -0400
Received: from fire.osdl.org ([65.172.181.4]:31180 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262222AbVD1Sx0 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Apr 2005 14:53:26 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3SIrHs4029605
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 28 Apr 2005 11:53:18 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3SIrG9x001646;
	Thu, 28 Apr 2005 11:53:16 -0700
To: David Woodhouse <dwmw2@infradead.org>
In-Reply-To: <1114680199.12012.363.camel@baythorne.infradead.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Thu, 28 Apr 2005, David Woodhouse wrote:
> 
> Walk the tree once. For each commit, count the number of _children_.
> That's not hard -- each new commit you find below HEAD has one child to
> start with, then you increment that figure by one each time you find
> another path to the same commit.
> 
> When printing, you walk the tree depth-first, remote-parent-first.

No, that really sucks. 

Realize that "remote" and "local" parents don't really exist. They have no 
meaning. I've considered sorting the parents by the sha1 name, but I've 
left that for now.

Anyway, the reason remote and local don't matter is that if somebody else
merges with me, and I just pull the result without having any changes in 
my tree, we just "fast-forward" to that other side, because otherwise you 
can never "converge" on anything (people merging each others trees would 
always create a new commit, for no good reason).

What does that mean? It means that my local tree now became the _remote_ 
parent, even though it was always local to my tree.

So if you look at remote vs local, you're _guaranteed_ to mess up. It has 
no meaning.

So what you can do is:
 - if there is one parent, just always walk straight down
 - if it's a merge, add the parents _in_date_order_ to the list of things 
   to do, and then pop the most recent one.

Really. You say that dates don't matter, but they _do_ actually matter a
lot more than "remote/local" does. At least they have meaning.

		Linus
