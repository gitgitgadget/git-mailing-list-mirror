From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: How do I...
Date: Fri, 6 May 2005 11:58:41 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0505061145450.2233@ppc970.osdl.org>
References: <427B3DB3.4000507@tuxrocks.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 06 20:51:51 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DU7uV-0001vS-0P
	for gcvg-git@gmane.org; Fri, 06 May 2005 20:50:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261266AbVEFS5Z (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 May 2005 14:57:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261265AbVEFS5Z
	(ORCPT <rfc822;git-outgoing>); Fri, 6 May 2005 14:57:25 -0400
Received: from fire.osdl.org ([65.172.181.4]:13277 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261266AbVEFS4o (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 May 2005 14:56:44 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j46IucU3016998
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 6 May 2005 11:56:39 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j46Iubx4024317;
	Fri, 6 May 2005 11:56:38 -0700
To: Frank Sorenson <frank@tuxrocks.com>
In-Reply-To: <427B3DB3.4000507@tuxrocks.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Fri, 6 May 2005, Frank Sorenson wrote:
> 
> Okay, I've got some "How can I?" questions.  I hope I'm not the only one
> still working to "git it".
> 
> How can I git a list of commits that have modified a particular file?
> For example, I'd like to do something like this:
> # git-file-revs Makefile
> f7eb55878f11575281add2a5726e483aed5e45bb
> aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
> bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb

Ok, I now have the perfect interface for _most_ uses of this thing.

For example, let's say that you are interested in "what changed in the 
USB input layer lately". You can now do

	git-rev-list | git-diff-tree -p -v --stdin drivers/usb/input | less -S

and you'll get some very readable output that tells you _exactly_ what has 
changed to any file in that subdirectory.

Or, let's say that you're the author of the gt96100 ethernet driver (just 
to pick one that has both a .c and a .h file and that has had changes in 
the current git tree, you'd do:

	git-rev-list HEAD | git-diff-tree -p -v --stdin drivers/net/gt96100eth.* | less -S

and it gives you _exactly_ what you want (ie thanks to how diff-tree
works, you can give it any number of files or directories you're
interested in).

Normally, this thing will ignore merge commits, but if you want to see the
merges that the changes came through (a merge _can_ have real changes of
its own too), add the "-m" flag to the git-diff-tree thing.

Try out the above examples on the current kernel tree (and with my most
current git version as of five minutes ago - it shows up at least on
gitweb, but I don't know if it's mirrored out with rsync yet). Very
pretty. Very useful.

		Linus
