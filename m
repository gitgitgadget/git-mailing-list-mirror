From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Bootstrapping into git, commit gripes at me
Date: Mon, 11 Jul 2005 16:45:22 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0507111636030.17536@g5.osdl.org>
References: <20050708230750.GA23847@buici.com> <Pine.LNX.4.58.0507081842550.17536@g5.osdl.org>
 <20050711222046.GA21376@buici.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 12 01:49:34 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ds81c-0007bp-54
	for gcvg-git@gmane.org; Tue, 12 Jul 2005 01:49:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262266AbVGKXsv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 11 Jul 2005 19:48:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262257AbVGKXrB
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Jul 2005 19:47:01 -0400
Received: from smtp.osdl.org ([65.172.181.4]:56017 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262260AbVGKXp0 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 11 Jul 2005 19:45:26 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j6BNjNjA002463
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 11 Jul 2005 16:45:24 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j6BNjMVf008899;
	Mon, 11 Jul 2005 16:45:23 -0700
To: Marc Singer <elf@buici.com>
In-Reply-To: <20050711222046.GA21376@buici.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.113 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Mon, 11 Jul 2005, Marc Singer wrote:
> 
> I picked 2.6.12
> 
>   # git checkout -f v2.6.12
> 
> applied the patch and was greeted with an error about being unable to
> commit telling me that I LONG_HEX_NUMBER is not a valid commit object.
> Isn't 2.6.12 later than 2.6.12-rcX?

Yes.

However, that's not how "git checkout" ends up working, which is probably 
(almost certainly) a misfeature of git checkout. In particular, when you 
use a tag to checkout something, it will checkout the _state_ at that 
point (ie v2.6.12), but it won't have reset your HEAD to point to it.

And your earlier adventures made your HEAD be something that isn't a
commit (although I quite frankly don't know quite how you succeeded at
that: "git checkout" should refuse to write a HEAD unless you check out a
specific branch, and all branch pointers are proper commit points).

Anyway, here's how you fix it right now, and I'll have to figure out how 
to make a nice interface:

	#
	# Reset the "master" branch to v2.6.12
	#
	git-rev-list --max-count=1 v2.6.12 > .git/refs/heads/master

	#
	# Switch to the master branch
	#
	git checkout -f master

which should get you to be at a known point (which is v2.6.12).

		Linus
