From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] make git-prune-script actually work
Date: Sun, 24 Apr 2005 10:35:40 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504241032490.15879@ppc970.osdl.org>
References: <1114351135.4997.18.camel@mulgrave>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 24 19:29:02 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DPkuh-0001uS-SB
	for gcvg-git@gmane.org; Sun, 24 Apr 2005 19:29:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262314AbVDXRdr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Apr 2005 13:33:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262317AbVDXRdr
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Apr 2005 13:33:47 -0400
Received: from fire.osdl.org ([65.172.181.4]:28546 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262314AbVDXRdp (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 24 Apr 2005 13:33:45 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3OHXgs4003201
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 24 Apr 2005 10:33:42 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3OHXeEb013455;
	Sun, 24 Apr 2005 10:33:41 -0700
To: James Bottomley <James.Bottomley@SteelEye.com>
In-Reply-To: <1114351135.4997.18.camel@mulgrave>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Sun, 24 Apr 2005, James Bottomley wrote:
>
> I find this script very useful to get back to where I started from after
> test merges, and also for cloning trees from a non-current base.  The
> functionality is altered so it now takes an optional commit argument
> (and a -q flag to make it be quiet).

Hmm.. You should probably rename it to "git-reset-script" or something, 
and any time you reset the head, you should also amke sure to reset the 
index, because otherwise your index file may actually be referencing 
objects that no longer even exist, and that's going to be very very 
painful.

So

> +echo $head > .git/HEAD

should probably be followed by

	read-tree -m $head
	update-cache --refresh

which will also tell the user what files he has that are now "dirty" (and 
he can decide whether he wants to commit his changes, or whether he wants 
to do a "checkout-cache -f -a" to just get rid of it all).

		Linus
