From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Add --strict switch to diff-cache to force SHA1 checking
Date: Sat, 23 Apr 2005 20:57:56 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504232056160.2344@ppc970.osdl.org>
References: <20050424033554.GA23293@diku.dk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: pasky@ucw.cz, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 24 05:51:37 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DPY9X-0004LI-R7
	for gcvg-git@gmane.org; Sun, 24 Apr 2005 05:51:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262246AbVDXD4K (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Apr 2005 23:56:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262244AbVDXD4K
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Apr 2005 23:56:10 -0400
Received: from fire.osdl.org ([65.172.181.4]:30621 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262246AbVDXD4D (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 23 Apr 2005 23:56:03 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3O3tvs4032075
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 23 Apr 2005 20:55:58 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3O3tuP7028043;
	Sat, 23 Apr 2005 20:55:57 -0700
To: Jonas Fonseca <fonseca@diku.dk>
In-Reply-To: <20050424033554.GA23293@diku.dk>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Sun, 24 Apr 2005, Jonas Fonseca wrote:
>
> It seems by far the easiest to let diff-cache take care of skipping
> files which have not been modified. The alternative is to keep
> diff-cache's lazy checking and make cogito's diff jump through hoops.
> Note, although the new SHA1 signature is derived, diff-cache still
> prints the special no-SHA1 for the modified file.

The reason I don't want this is that if the commands keep on silently
fixing things like this up, then performance will go down the toilet.

What _should_ happen is that you do an "update-cache --refresh" before    
doing the diff-cache. That way you do _not_ end up having to check the    
sha1 match over and over again if you just did a "touch" on the file.

In other words, you're adding bandage for a problem that shouldn't exist,
and you're doing it in a way which means that _if_ the problem exists,    
you'll never fix it, but you'll just rely on your bandage all the time.

So cogito definitely does not have to jump through any hoops at all. It
should just make sure to keep the cache up-to-date if it ever cares (ie
do "update-cache --refresh"). 

Some commands obviously won't care.

		Linus
