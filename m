From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: bogus merges
Date: Mon, 5 Sep 2005 09:01:32 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0509050853080.3568@evo.osdl.org>
References: <59a6e58305090507387d412b3d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 05 18:02:03 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ECJPN-0002NN-Ps
	for gcvg-git@gmane.org; Mon, 05 Sep 2005 18:01:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932226AbVIEQBT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Sep 2005 12:01:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932300AbVIEQBT
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Sep 2005 12:01:19 -0400
Received: from smtp.osdl.org ([65.172.181.4]:33449 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932226AbVIEQBS (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 5 Sep 2005 12:01:18 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j85G1FBo016552
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 5 Sep 2005 09:01:15 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j85G1DA5016127;
	Mon, 5 Sep 2005 09:01:14 -0700
To: Wayne Scott <wsc9tt@gmail.com>
In-Reply-To: <59a6e58305090507387d412b3d@mail.gmail.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.115 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8099>



On Mon, 5 Sep 2005, Wayne Scott wrote:
>
> A recent commit in linux-2.6 looks like this:

It hopefully shouldn't happen any more with the improved and fixed
git-merge-base.

> Author: Russell King <rmk@dyn-67.arm.linux.org.uk>
> Date:   Wed Aug 31 10:12:14 2005 +0100

I suspect rmk is using cogito-0.13, and that it still has the older 
git-merge-base that can get confused by the date-ordering problem. And 
when git-merge-base gives the wrong result (not either of the commit 
objects it was given as an argument), then "git resolve" will do the wrong 
thing.

I just checked, and the _current_ git-merge-base definitely gives the 
right result:

	linux$ git-merge-base -a \
		6b39374a27eb4be7e9d82145ae270ba02ea90dc8 \
		194d0710e1a7fe92dcf860ddd31fded8c3103b7a

results in

	194d0710e1a7fe92dcf860ddd31fded8c3103b7a

ie it correctly notices that the second commit is the parent of the first
one.

> Really 'git commit' should detect problems like this automatically and
> prevent them from getting in the tree.

Well, that would depend on having the fixed git-merge-base in the first 
place, which in turn would mean that such a commit wouldn't happen at all, 
so it's kind of circular. It's not worth fixing anywhere else, since once 
you fix it in git-merge-base, it just becomes a non-issue.

Hopefully we'll have a new cogito release soon, and this particular bug
will be a thing of the past.

		Linus
