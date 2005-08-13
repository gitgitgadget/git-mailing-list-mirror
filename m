From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Fwd: Re: git checkout -f branch doesn't remove extra files
Date: Fri, 12 Aug 2005 22:39:48 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0508122235120.19049@g5.osdl.org>
References: <20050813041737.GB25236@redhat.com> <Pine.LNX.4.58.0508122151120.19049@g5.osdl.org>
 <20050813052731.GC11456@redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 13 07:41:04 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E3okj-0002nQ-Mu
	for gcvg-git@gmane.org; Sat, 13 Aug 2005 07:40:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750730AbVHMFkE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 13 Aug 2005 01:40:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751305AbVHMFkE
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Aug 2005 01:40:04 -0400
Received: from smtp.osdl.org ([65.172.181.4]:56484 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750730AbVHMFkC (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 13 Aug 2005 01:40:02 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j7D5dnjA008882
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 12 Aug 2005 22:39:50 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j7D5dmnV031046;
	Fri, 12 Aug 2005 22:39:49 -0700
To: Dave Jones <davej@redhat.com>
In-Reply-To: <20050813052731.GC11456@redhat.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.44__
X-MIMEDefang-Filter: osdl$Revision: 1.114 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Sat, 13 Aug 2005, Dave Jones wrote:
> 
>  > Git actually has a _lot_ of nifty tools. I didn't realize that people 
>  > didn't know about such basic stuff as "git-tar-tree" and "git-ls-files". 
> 
> Maybe its because things are moving so fast :)  Or maybe I just wasn't
> paying attention on that day. (I even read the git changes via RSS,
> so I should have no excuse).

Well, git-tar-tree has been there since late April - it's actually one of 
those really early commands. I'm pretty sure the RSS feed came later ;)

I use it all the time in doing releases, it's a lot faster than creating a 
tar tree by reading the filesystem (even if you don't have to check things 
out). A hidden pearl.

This is my crappy "release-script":

	[torvalds@g5 ~]$ cat bin/release-script
	#!/bin/sh
	stable="$1"
	last="$2"
	new="$3"
	echo "# git-tag-script v$new"
	echo "git-tar-tree v$new linux-$new | gzip -9 > ../linux-$new.tar.gz"
	echo "git-diff-tree -p v$stable v$new | gzip -9 > ../patch-$new.gz"
	echo "git-rev-list --pretty v$new ^v$last > ../ChangeLog-$new"
	echo "git-rev-list --pretty=short v$new ^v$last | git-shortlog > ../ShortLog"
	echo "git-diff-tree -p v$last v$new | git-apply --stat > ../diffstat-$new"

and when I want to do a new kernel release I literally first tag it, and 
then do

	release-script 2.6.12 2.6.13-rc6 2.6.13-rc7

and check that things look sane, and then just cut-and-paste the commands.

Yeah, it's stupid.

		Linus
