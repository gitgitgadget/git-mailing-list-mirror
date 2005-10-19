From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Pushing a single tag (ref + object)?
Date: Wed, 19 Oct 2005 07:13:49 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0510190702360.3369@g5.osdl.org>
References: <46a038f90510131929m3dac4cc5y6071550e9e9c71ad@mail.gmail.com>
 <46a038f90510182305j1fa2c4bh6d2b36c2fdd058ce@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Oct 19 16:17:24 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ESEhi-0005vW-TK
	for gcvg-git@gmane.org; Wed, 19 Oct 2005 16:14:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750990AbVJSON7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 19 Oct 2005 10:13:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750994AbVJSON7
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Oct 2005 10:13:59 -0400
Received: from smtp.osdl.org ([65.172.181.4]:36502 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750950AbVJSON6 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 19 Oct 2005 10:13:58 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j9JEDoFC017007
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 19 Oct 2005 07:13:51 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j9JEDnIm002153;
	Wed, 19 Oct 2005 07:13:50 -0700
To: Martin Langhoff <martin.langhoff@gmail.com>,
	Junio C Hamano <junkio@cox.net>
In-Reply-To: <46a038f90510182305j1fa2c4bh6d2b36c2fdd058ce@mail.gmail.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.55__
X-MIMEDefang-Filter: osdl$Revision: 1.125 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10290>



On Wed, 19 Oct 2005, Martin Langhoff wrote:
> 
> Now, I am at a loss on how to push a _tag_ object+ref to the repo,
> without doing a git-push --all, which I naturally don't want to do. I
> managed to push the object itself, doing
> 
>     git-push repository tagrefname

This really should work. 

Can you try with

	git-send-pack repository tagname

first? 

If that works for you (it really really should, since that's what I do all 
the time), then the problem is in "get_remote_refs_for_push"..

Oh. Looking at "git-push.sh", I think it is just really really buggy.

It does all this magic to set "x", but then it never uses it, and uses 
"$@" instead after all. Which it has shifted all away. 

How does that thing work at all? Me, I've always used the raw 
git-send-pack program, so I've never tested it, but obviously others are 
using it.

		Linus
