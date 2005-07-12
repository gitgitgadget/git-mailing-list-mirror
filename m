From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Bootstrapping into git, commit gripes at me
Date: Mon, 11 Jul 2005 17:57:54 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0507111646000.17536@g5.osdl.org>
References: <20050708230750.GA23847@buici.com> <Pine.LNX.4.58.0507081842550.17536@g5.osdl.org>
 <20050711222046.GA21376@buici.com> <7vll4dndwu.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Marc Singer <elf@buici.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 12 03:05:21 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ds9D0-0007HM-L7
	for gcvg-git@gmane.org; Tue, 12 Jul 2005 03:05:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261849AbVGLBEe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 11 Jul 2005 21:04:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261839AbVGLBDk
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Jul 2005 21:03:40 -0400
Received: from smtp.osdl.org ([65.172.181.4]:45790 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261899AbVGLA6J (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 11 Jul 2005 20:58:09 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j6C0vsjA007628
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 11 Jul 2005 17:57:55 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j6C0vsd3012730;
	Mon, 11 Jul 2005 17:57:54 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vll4dndwu.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.113 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Mon, 11 Jul 2005, Junio C Hamano wrote:
> 
>  - we allow git-checkout-script with a tag; I think we store the tag
>    object without dereferencing in .git/HEAD;

No, git-checkout-script _shouldn't_ have done that. It will do the 
read-tree on the tag (which will do the right thing), but it won't change 
the HEAD itself.

But I think Marc has/had an older git-checkout-script. The original one
didn't do branches at all, and indeed just blindly wrote its result into
.git/HEAD.

> My current preference is to keep .git/refs/heads tag free.  At
> least, I do not think we should ever write non commits to
> .git/*_HEAD.

And we don't. Not any more. 

However, right now we don't update .git/HEAD at _all_ unless we checked 
out a specific branch. Part of that is that we don't really know what we 
should change. Should we reset the current branch to that tag? Should we 
switch to the "master" branch, and switch _that_ to that tag? Should we 
create a totally new branch for just this thing?

Creating a new branch ends up being the only _safe_ option, but what 
should we choose as the branch name? 

		Linus
