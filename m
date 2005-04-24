From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [RFC] updates for git-pull-script
Date: Sun, 24 Apr 2005 10:49:15 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504241045260.15879@ppc970.osdl.org>
References: <1114352069.4997.24.camel@mulgrave>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 24 19:43:43 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DPl8T-0003ag-S8
	for gcvg-git@gmane.org; Sun, 24 Apr 2005 19:43:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262356AbVDXRre (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Apr 2005 13:47:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262355AbVDXRre
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Apr 2005 13:47:34 -0400
Received: from fire.osdl.org ([65.172.181.4]:64902 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262356AbVDXRrV (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 24 Apr 2005 13:47:21 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3OHlGs4004239
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 24 Apr 2005 10:47:16 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3OHlF3C013690;
	Sun, 24 Apr 2005 10:47:16 -0700
To: James Bottomley <James.Bottomley@SteelEye.com>
In-Reply-To: <1114352069.4997.24.camel@mulgrave>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Sun, 24 Apr 2005, James Bottomley wrote:
> 
> The attached addresses all these points.  It's what I use, but since
> others may prefer the original behaviour, I'm sending it as a straw
> horse.

I don't think anybody preferes the original behaviour - the reason 
git-pull-script punted with any non-trivial merge was that when I wrote 
the damn thing, I was still just testing out the merges, and I definitely 
didn't trust the automated script.

However, when you remove the "checkout-cache -f -a" thing, it means that 
you are leaving all teh checked-out files in a state where it's _very_ 
easy to mess up later, and doign so silently really is very bad.

So at the _very_ least you should do an "update-cache --refresh", and 
_tell_ the user about the files that are checked-out but not up-to-date.

And it really sounds like the whole and only reason you don't like 
checkout-cache is that you normally work with an empty tree, so I actually 
think that the _right_ answer for you is to add a new flag to 
"checkout-cache" that only updates files that already exist. Something 
like "-n" for "don't create new files". 

		Linus
