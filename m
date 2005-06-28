From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Skip writing out sha1 files for objects in packed git.
Date: Mon, 27 Jun 2005 19:43:57 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0506271935260.19755@ppc970.osdl.org>
References: <Pine.LNX.4.58.0506271755140.19755@ppc970.osdl.org>
 <7vwtofi6jk.fsf@assigned-by-dhcp.cox.net> <7vr7eni6fy.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 28 04:35:48 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dn5wc-0001wR-Rk
	for gcvg-git@gmane.org; Tue, 28 Jun 2005 04:35:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262280AbVF1CmN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 27 Jun 2005 22:42:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262392AbVF1CmN
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Jun 2005 22:42:13 -0400
Received: from smtp.osdl.org ([65.172.181.4]:8421 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262280AbVF1CmC (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 27 Jun 2005 22:42:02 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j5S2fsjA006573
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 27 Jun 2005 19:41:54 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j5S2fpuJ008680;
	Mon, 27 Jun 2005 19:41:53 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vr7eni6fy.fsf_-_@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.111 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Mon, 27 Jun 2005, Junio C Hamano wrote:
>
> Now, there's still a misfeature there, which is that when you
> create a new object, it doesn't check whether that object
> already exists in the pack-file, so you'll end up with a few
> recent objects that you really don't need (notably tree
> objects), and this patch fixes it.
> 
> Signed-off-by: Junio C Hamano <junkio@cox.net>

Actually, I don't think that "do_expand" flag should exist.

If we want to expand a packed file and really write the objects to the 
.git/objects directories, we should just not have that packed file in the 
.git/objects/pack directory.

And if we have a pack-file in .git/objects/ that already has the object, 
that may not be the _same_ pack-file that we're expanding at all, so if 
that pack file already has the object, then not writing it out is actually 
the right thing to do.

That will also simplify your patch a bit. I'll fix it up.

		Linus
