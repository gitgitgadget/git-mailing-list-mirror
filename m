From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Added hook in git-receive-pack
Date: Sun, 31 Jul 2005 17:25:47 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0507311720220.14342@g5.osdl.org>
References: <200507312117.43957.Josef.Weidendorfer@gmx.de>
 <Pine.LNX.4.58.0507311305170.29650@g5.osdl.org> <7vr7ded8ax.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.58.0507311549300.14342@g5.osdl.org> <7viryqd0eo.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.58.0507311627280.14342@g5.osdl.org> <7vhdeabjo7.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Aug 01 02:27:27 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DzO9I-0008TN-Qu
	for gcvg-git@gmane.org; Mon, 01 Aug 2005 02:27:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262187AbVHAA0i (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 31 Jul 2005 20:26:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262204AbVHAA0g
	(ORCPT <rfc822;git-outgoing>); Sun, 31 Jul 2005 20:26:36 -0400
Received: from smtp.osdl.org ([65.172.181.4]:53225 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262187AbVHAAZ6 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 31 Jul 2005 20:25:58 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j710PmjA021335
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 31 Jul 2005 17:25:48 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j710PlQY011090;
	Sun, 31 Jul 2005 17:25:47 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vhdeabjo7.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.113 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Sun, 31 Jul 2005, Junio C Hamano wrote:
> 
> You are absolutely right.  It should grab some sort of lock
> while it does its thing (would fcntl(F_GETLK) be acceptable to
> networked filesystem folks?).

There is no lock that works reliably except for the "create a directory 
and rename it onto another directory"

Please do it in the hook layer.

> I have one question regarding the hooks.  We seem to prefer
> avoiding system and roll our own.  Is there a particular reason,
> other than bypassing the need to quote parameters for shell?

Hmm.. I suspect it's partly just because there is existing code that does
the fork()/exec() thing because it needs to do IO, and system() doesn't
close the right pipes after fork etc.

"system()" really is very inflexible. It basically never works if you have 
any shared file descriptors.

		Linus
